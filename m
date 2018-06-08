Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nT37MapPGlsbDwAAmS7hNA
	; Fri, 08 Jun 2018 09:43:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 103D06089E; Fri,  8 Jun 2018 09:43:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="WVvgPre5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DFFD360275;
	Fri,  8 Jun 2018 09:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFFD360275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeFHJny (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:43:54 -0400
Received: from services.gouders.net ([141.101.32.176]:34924 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeFHJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:43:01 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w589a3UV027525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 8 Jun 2018 11:36:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528450582; bh=bmQWPsg0SMhF8U6Zu5dmADNOXdladedc4xHNi5djF/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WVvgPre58/9Qt5vRZKIdUD4pnClBKalERSpAhgLqxEdh9FKGAIvOCWu9BD6xntbts
         jIA+NUvcEZBMrWYZruH61FLlMGxcCgdHTEGWXPFYaGszOqYx7jx0nu63BfQjbSF/3N
         v797+7cSvempEhrWsTsyS/7gTTcUMd3X580N6ke4=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v3 1/1] Emacs-like isearch for mconf.
Date: Fri,  8 Jun 2018 11:35:46 +0200
Message-Id: <20180608093546.7687-2-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180608093546.7687-1-dirk@gouders.net>
References: <20180608093546.7687-1-dirk@gouders.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements isearch functionality for mconf as follows:

* isearch is started by pressing \ or CTRL-s; those keys can also be
  used to find further matches of an already entered string.

* isearch is implemented as a ring search.

* Once isearch is started, all alphanumerical characters and <space>
  are appended to a search string that is then be used to find matches
  in the menu.

* Any other character pressed terminates isearch and -- except ESC ESC
  -- that character is further processed, e.g. ENTER to enter a submenu
  without further input.

* To be able to use CTRL-s to start isearch, the terminal has to be
  put into raw mode and this can be done by setting the environment
  variable MENUCONFIG_RAW_MODE to a numeric value != 0.

An input example to navigate into the USB support menu under device
drivers:

	1) \		# start isearch
	2) de		# navigate to Device Drivers
	3) ENTER	# terminate isearch and enter submenu
	4) \		# start isearch
	5) USB		# navigate to USB support
	6) ENTER	# terminate isearch and enter submenu

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/kbuild/kconfig.txt   |  18 +++-
 scripts/kconfig/lxdialog/dialog.h  |   6 ++
 scripts/kconfig/lxdialog/menubox.c | 171 +++++++++++++++++++++++++++++++++++++
 scripts/kconfig/lxdialog/util.c    |  14 +++
 scripts/kconfig/mconf.c            |  47 ++++++++++
 5 files changed, 254 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/kconfig.txt b/Documentation/kbuild/kconfig.txt
index 7233118f3a05..71270dcfa112 100644
--- a/Documentation/kbuild/kconfig.txt
+++ b/Documentation/kbuild/kconfig.txt
@@ -147,9 +147,11 @@ Its default value is "include/generated/autoconf.h".
 menuconfig
 --------------------------------------------------
 
-SEARCHING for CONFIG symbols
+Menuconfig offers two search capabilities:
+	1) SEARCHING for CONFIG symbols
+	2) Incremental search in menus
 
-Searching in menuconfig:
+Searching for CONFIG symbols:
 
 	The Search function searches for kernel configuration symbol
 	names, so you have to know something close to what you are
@@ -178,6 +180,18 @@ Searching in menuconfig:
 	first (and in alphabetical order), then come all other symbols,
 	sorted in alphabetical order.
 
+Incremental search in menus:
+
+	Isearch is started by pressing <\>.  After that, any alphanumerical
+	character typed in is used to form a growing string that is searched
+	for in the menu items.
+
+	Isearch is realized as a ring search, restarting at the top if it
+	reaches the last menu item.
+
+	Further matches of an already entered string can be found by
+	pressing <\> instead of more alphanumerical characters.
+
 ______________________________________________________________________
 User interface options for 'menuconfig'
 
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 0b00be5abaa6..271bd5a4bc13 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -50,6 +50,8 @@
 #define TR(params) _tracef params
 
 #define KEY_ESC 27
+#define KEY_CTRL_S 19
+#define KEY_ENTR 10
 #define TAB 9
 #define MAX_LEN 2048
 #define BUF_SIZE (10*1024)
@@ -145,6 +147,7 @@ struct dialog_info {
 extern struct dialog_info dlg;
 extern char dialog_input_result[];
 extern int saved_x, saved_y;		/* Needed in signal handler in mconf.c */
+extern int raw_mode;			/* Toggle raw mode */
 
 /*
  * Function prototypes
@@ -238,6 +241,9 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height);
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
+int do_isearch(char *str, int choice, int scroll);
+int dialog_isearch(WINDOW *menu, WINDOW *dialog, int *choice, int max_choice,
+		   int box_x, int box_y, int menu_height, int *scroll);
 
 /*
  * This is the base for fictitious keys, which activate
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d70cab36137e..20a14fa1c96f 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -56,8 +56,13 @@
  * fscanf would read in 'scroll', and eventually that value would get used.
  */
 
+#include <string.h>
 #include "dialog.h"
 
+#define ISEARCH_LEN 32
+#define ISEARCH_INDICATOR_LEN (ISEARCH_LEN + 8)
+static char isearch_str[ISEARCH_LEN] = "";
+
 static int menu_width, item_x;
 
 /*
@@ -105,6 +110,32 @@ do {									\
 	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
 } while (0)
 
+
+/*
+* Print the isearch indicator.
+*/
+static void print_isearch(WINDOW * win, int y, int x, int height, bool isearch)
+{
+	unsigned char i = 0;
+
+	wmove(win, y, x);
+
+	y = y + height + 1;
+	wmove(win, y, x);
+
+	if (isearch) {
+		wattrset(win, dlg.button_key_inactive.atr);
+		waddstr(win, "isearch: ");
+		waddstr(win, isearch_str);
+		i = ISEARCH_INDICATOR_LEN - strlen(isearch_str);
+	}
+
+	wattrset(win, dlg.menubox_border.atr);
+
+	for ( ; i < ISEARCH_INDICATOR_LEN; i++ )
+		waddch(win, ACS_HLINE);
+}
+
 /*
  * Print the scroll indicators.
  */
@@ -178,6 +209,130 @@ static void do_scroll(WINDOW *win, int *scroll, int n)
 	wrefresh(win);
 }
 
+/*
+ * Incremental search for text in dialog menu entries.
+ * The search operates as a ring search, continuing at the top after
+ * the last entry has been visited.
+ *
+ * Returned is -1 if no match was found, else the absolute index of
+ * the matching item.
+ */
+int do_isearch(char *str, int choice, int scroll)
+{
+	int found = 0;
+	int i;
+
+	for (i = 0; i < item_count(); i++) {
+		item_set((choice + scroll + i)%item_count());
+		if (strcasestr(item_str(), str)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (found)
+		return (choice + scroll + i)%item_count();
+	return -1;
+}
+
+/*
+ * Incremental search in dialog menu
+ *
+ * This function is executed after CTRL-S or \ has been pressed and it
+ * navigates to and highlights menu entries that match the string
+ * formed by subsequently entered characters.  To find further matches
+ * of an entered string, CTRL-S or \ has to be entered instead of
+ * further characters.
+ *
+ * Subsequently pressing just CTRL-S or \ keys results in searches for
+ * empty strings (any line matches) and thus results in navigating through
+ * the menu, line by line.
+ *
+ * Incremental search is terminated by pressing any other key than
+ * alnum characters or blank.
+ *
+ * Isearch returns -1 when it is terminatet with ESC ESC, otherwise
+ * the pressed key is returned.
+ */
+int dialog_isearch(WINDOW *menu, WINDOW *dialog, int *choice, int max_choice,
+		   int box_x, int box_y, int menu_height, int *scroll)
+{
+	int i;
+	int key = KEY_CTRL_S;
+
+	print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, true);
+	wnoutrefresh(dialog);
+	wrefresh(menu);
+
+	while ( 1 ) {
+		key = wgetch(menu);
+
+		if (key == KEY_CTRL_S || key == '\\') {
+			/* Remove highligt of current item */
+			print_item(*scroll + *choice, *choice, FALSE);
+			i = do_isearch(isearch_str, *choice + 1, *scroll);
+		} else {
+			if ( key == KEY_BACKSPACE && isearch_str[0] ) {
+				isearch_str[i = (strlen(isearch_str) - 1)] = '\0';
+			} else {
+				if ( key < 256 && (isalnum(key) || key == ' ')) {
+					if (strlen(isearch_str) < ISEARCH_LEN - 1) {
+						isearch_str[i = strlen(isearch_str)] = key;
+						isearch_str[i+1] = '\0';
+					} else
+						continue;
+				} else
+					goto exit_isearch;
+			}
+			/* Remove highligt of current item */
+			print_item(*scroll + *choice, *choice, FALSE);
+			i = do_isearch(isearch_str, *choice, *scroll);
+		}
+
+		/*
+		 * Handle matches
+		 */
+		if (i >= 0) {
+			i -= *scroll;
+
+			if (i >= max_choice)
+				/*
+				 * Handle matches below the currently visible menu entries.
+				 */
+				while (i >= max_choice) {
+					do_scroll(menu, scroll, 1);
+					i--;
+					print_item(max_choice + *scroll - 1, max_choice - 1, false);
+				}
+			else if (i < 0)
+				/*
+				 * Handle matches higher in the menu (ring search).
+				 */
+				while (i < 0) {
+					do_scroll(menu, scroll, -1);
+					i++;
+					print_item(*scroll, 0, false);
+				}
+			*choice = i;
+		}
+
+		print_item(*scroll + *choice, *choice, TRUE);
+		print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, true);
+		print_arrows(dialog, item_count(), *scroll,
+			     box_y, box_x + item_x + 1, menu_height);
+
+		wnoutrefresh(dialog);
+		wrefresh(menu);
+	}
+exit_isearch:
+	isearch_str[0] = '\0';
+	print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, false);
+	print_arrows(dialog, item_count(), *scroll,
+		     box_y, box_x + item_x + 1, menu_height);
+	print_item(*scroll + *choice, *choice, true);
+	return key == KEY_ESC ? -1 : key;
+}
+
 /*
  * Display a menu for choosing among a number of options
  */
@@ -281,6 +436,22 @@ int dialog_menu(const char *title, const char *prompt,
 
 	while (key != KEY_ESC) {
 		key = wgetch(menu);
+		/*
+		 * CTRL-s works only if MENUCONFIG_RAW_MODE is set and
+		 * != 0.  Otherwise, only \ can be used to start isearch.
+		 */
+		if (key == KEY_CTRL_S || key == '\\') {
+			key = dialog_isearch(menu, dialog, &choice, max_choice,
+					     box_x, box_y, menu_height, &scroll);
+			/*
+			 * dialog_isearch returns -1 if it was
+			 * terminated with ESC ESC, otherwise the
+			 * pressed key (e.g. ENTER) so that it can be
+			 * further processed, here.
+			 */
+			if (key == -1)
+				continue;
+		}
 
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f7abdeb92af0..d61cffd8c011 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -28,6 +28,8 @@ int saved_x, saved_y;
 
 struct dialog_info dlg;
 
+int raw_mode;			/* Toggle raw mode */
+
 static void set_mono_theme(void)
 {
 	dlg.screen.atr = A_NORMAL;
@@ -236,6 +238,17 @@ static void color_setup(const char *theme)
 		set_mono_theme();
 }
 
+/*
+ * Setup raw mode if MENUCONFIG_RAW_MODE
+ */
+static void raw_setup(const char *val)
+{
+	if (val && atoi(val)) {
+		raw_mode = 1;
+		raw();			/* Enable CTRL-sequences*/
+	}
+}
+
 /*
  * Set window to attribute 'attr'
  */
@@ -332,6 +345,7 @@ int init_dialog(const char *backtitle)
 
 	keypad(stdscr, TRUE);
 	cbreak();
+	raw_setup(getenv("MENUCONFIG_RAW_MODE"));
 	noecho();
 	dialog_clear();
 
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5294ed159b98..b46bb24b01fe 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -73,6 +73,52 @@ static const char mconf_readme[] =
 "\n"
 "o  To toggle the display of hidden options, press <Z>.\n"
 "\n"
+"o  Searching\n"
+"   There are two search capabilities in mconf:\n"
+"   1) Search for config symbols\n"
+"   2) Incremental search in menus\n"
+"\n"
+"   Searching for config symbols\n"
+"   ----------------------------\n"
+"   The Search function searches for kernel configuration symbol names,\n"
+"   so you have to know something close to what you are	looking for.\n"
+"\n"
+"   Example:\n"
+"               /hotplug\n"
+"               This lists all config symbols that contain \"hotplug\",\n"
+"               e.g., HOTPLUG_CPU, MEMORY_HOTPLUG.\n"
+"\n"
+"   For search help, enter / followed TAB-TAB-TAB (to highlight	<Help>)\n"
+"   and Enter.  This will tell you that you can also use regular\n"
+"   expressions (regexes) in the search string, so if you are not\n"
+"   interested in MEMORY_HOTPLUG, you could try\n"
+"\n"
+"               /^hotplug\n"
+"\n"
+"   When searching, symbols are sorted thus:\n"
+"     - first, exact matches, sorted alphabetically (an exact match is\n"
+"       when the search matches the complete symbol name);\n"
+"     - then, other matches, sorted alphabetically.\n"
+"       For example: ^ATH.K matches:\n"
+"         ATH5K ATH9K ATH5K_AHB ATH5K_DEBUG [...] ATH6KL ATH6KL_DEBUG\n"
+"         [...] ATH9K_AHB ATH9K_BTCOEX_SUPPORT ATH9K_COMMON [...]\n"
+"       of which only ATH5K and ATH9K match exactly and so are sorted\n"
+"       first (and in alphabetical order), then come all other symbols,\n"
+"       sorted in alphabetical order.\n"
+"\n"
+"   Incremental search in menus\n"
+"   ---------------------------\n"
+"   Isearch is started by pressing <\\>.  After that, any alphanumerical\n"
+"   character typed in is used to form a growing string that is searched\n"
+"   for in the menu items.\n"
+"\n"
+"   Isearch is realized as a ring search, restarting at the top if it\n"
+"   reaches the last menu item.\n"
+"\n"
+"   Further matches of an already entered string can be found by\n"
+"   pressing <\\> instead of more alphanumerical characters.\n"
+""
+"\n"
 "\n"
 "Radiolists  (Choice lists)\n"
 "-----------\n"
@@ -177,6 +223,7 @@ menu_instructions[] =
 	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
 	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
+	"Press <Esc><Esc> to exit, <?> for Help, </> for Search, <\\> for isearch.  "
 	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
 radiolist_instructions[] =
 	"Use the arrow keys to navigate this window or "
-- 
2.16.4
