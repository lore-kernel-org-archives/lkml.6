Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /IGYM3vQGlvzEwAAmS7hNA
	; Fri, 08 Jun 2018 18:53:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4CD81607A4; Fri,  8 Jun 2018 18:53:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Cg+SqWVr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 239DC601D2;
	Fri,  8 Jun 2018 18:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 239DC601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeFHSx2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:53:28 -0400
Received: from services.gouders.net ([141.101.32.176]:45398 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeFHSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:53:25 -0400
Received: from lena.gouders.net (ltea-047-066-004-082.pools.arcor-ip.net [47.66.4.82])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w58IkL2T032281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 8 Jun 2018 20:46:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528483602; bh=fZlzcI5YaJJPPVEkBNFCZi36WwfLqF/fNCn+bCd0B8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Cg+SqWVrgOnp8LqQ0Pcx6BFZOKiJQSKkcArB+mYrbbzoYN/SSpK9VJYs2QwSIMKBm
         lPK4z0M7gHdBNm8sJi/qRFjcoAoVyFL6Vp6aLGyrgt+n8BcjBGJSzXW2Iw+lJHd/ga
         ZJQX5R7YP9pehRSjQJbEigCilZraYItyLuoyxZzs=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v4 1/1] i-search functionality for mconf
Date: Fri,  8 Jun 2018 20:46:06 +0200
Message-Id: <20180608184606.5029-2-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180608184606.5029-1-dirk@gouders.net>
References: <20180608184606.5029-1-dirk@gouders.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prototypes isearch functionality for mconf based on an idea of
Sam Ravnborg:

* mconf now distinguishes if the focus is on the menu items or the
  buttons below it.

* At startup focus is on the menu items and alphanumeric
  characters or space entered are used to form a string that is
  searched for.

* BACKSPACE is used to remove the last character of the search string.

* ENTER can be used to enter a submenu.

* Horizontal arrow keys put focus on the buttons with the known
  behavior.

* The TAB key is now exclusively used to toggle the focus.

* Vertical arrow keys work anywhere.

* When the focus is on the buttons, all keys (e.g. hotkeys) work the
  same as before this change.

* '\' can be used to search for other occurences of an already entered
  string.

* To use y|n|m on an item, focus has to be on the buttons.

An example to navigate into the USB support menu under Device Drivers:

   1) de		# Navigates to the item "Device Drivers"
   2) ENTER		# Enter the submenu
   3) USB		# Navigate to the item "USB support"
   4) ENTER		# Enter the submenu

---
 scripts/kconfig/lxdialog/dialog.h  |   3 +
 scripts/kconfig/lxdialog/menubox.c | 207 +++++++++++++++++++++++++++++++++----
 2 files changed, 189 insertions(+), 21 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 0b00be5abaa6..02b036435919 100644
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
@@ -238,6 +240,7 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height);
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
+int do_isearch(char *str, int choice, int scroll);
 
 /*
  * This is the base for fictitious keys, which activate
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d70cab36137e..e49280115b52 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -56,10 +56,17 @@
  * fscanf would read in 'scroll', and eventually that value would get used.
  */
 
+#include <string.h>
 #include "dialog.h"
 
+#define ISEARCH_LEN 32
+#define ISEARCH_INDICATOR_LEN (ISEARCH_LEN + 8)
+static char isearch_str[ISEARCH_LEN] = "";
+
 static int menu_width, item_x;
 
+static int focus_on_buttons;
+
 /*
  * Print menu item
  */
@@ -85,7 +92,10 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #else
 	wclrtoeol(win);
 #endif
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	if (focus_on_buttons)
+		wattrset(win, selected ? A_UNDERLINE : dlg.item.atr);
+	else
+		wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
 	mvwaddstr(win, line_y, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? dlg.tag_key_selected.atr
@@ -105,6 +115,32 @@ do {									\
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
@@ -157,6 +193,9 @@ static void print_buttons(WINDOW * win, int height, int width, int selected)
 	int x = width / 2 - 28;
 	int y = height - 2;
 
+	if (!focus_on_buttons)
+		selected = -1;
+
 	print_button(win, "Select", y, x, selected == 0);
 	print_button(win, " Exit ", y, x + 12, selected == 1);
 	print_button(win, " Help ", y, x + 24, selected == 2);
@@ -178,6 +217,32 @@ static void do_scroll(WINDOW *win, int *scroll, int n)
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
 /*
  * Display a menu for choosing among a number of options
  */
@@ -275,6 +340,7 @@ int dialog_menu(const char *title, const char *prompt,
 	print_arrows(dialog, item_count(), scroll,
 		     box_y, box_x + item_x + 1, menu_height);
 
+	print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
 	print_buttons(dialog, height, width, 0);
 	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
@@ -285,22 +351,27 @@ int dialog_menu(const char *title, const char *prompt,
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
 
-		if (strchr("ynmh", key))
-			i = max_choice;
-		else {
-			for (i = choice + 1; i < max_choice; i++) {
-				item_set(scroll + i);
-				j = first_alpha(item_str(), "YyNnMmHh");
-				if (key == tolower(item_str()[j]))
-					break;
-			}
-			if (i == max_choice)
-				for (i = 0; i < max_choice; i++) {
+		if (focus_on_buttons) {
+			/*
+			 * Find item matching hot key.
+			 */
+			if (strchr("ynmh", key))
+				i = max_choice;
+			else {
+				for (i = choice + 1; i < max_choice; i++) {
 					item_set(scroll + i);
 					j = first_alpha(item_str(), "YyNnMmHh");
 					if (key == tolower(item_str()[j]))
 						break;
 				}
+				if (i == max_choice)
+					for (i = 0; i < max_choice; i++) {
+						item_set(scroll + i);
+						j = first_alpha(item_str(), "YyNnMmHh");
+						if (key == tolower(item_str()[j]))
+							break;
+					}
+			}
 		}
 
 		if (item_count() != 0 &&
@@ -370,16 +441,117 @@ int dialog_menu(const char *title, const char *prompt,
 			continue;	/* wait for another key press */
 		}
 
+		if (!focus_on_buttons) {
+			i = -1;
+
+			if (key == '\n') {
+				/* save scroll info */
+				*s_scroll = scroll;
+				delwin(menu);
+				delwin(dialog);
+				item_set(scroll + choice);
+				item_set_selected(1);
+				isearch_str[0] = '\0';
+				return 0; /* 0 means first button "Select" */
+			}
+
+			if ( key == KEY_BACKSPACE && isearch_str[0] ) {
+				isearch_str[i = (strlen(isearch_str) - 1)] = '\0';
+				i = -1;
+			}
+
+			if (key < 256 && (isalnum(key) || key == ' ')) {
+				if (strlen(isearch_str) < ISEARCH_LEN - 1) {
+					isearch_str[i = strlen(isearch_str)] = key;
+					isearch_str[i+1] = '\0';
+				}
+
+				/* Remove highligt of current item */
+				print_item(scroll + choice, choice, FALSE);
+				i = do_isearch(isearch_str, choice, scroll);
+			}
+
+			if (key == '\\') {
+				/* Remove highligt of current item */
+				print_item(scroll + choice, choice, FALSE);
+				i = do_isearch(isearch_str, choice + 1, scroll);
+			}
+
+			/*
+			 * Handle matches
+			 */
+			if (i >= 0) {
+				i -= scroll;
+
+				if (i >= max_choice)
+					/*
+					 * Handle matches below the currently visible menu entries.
+					 */
+					while (i >= max_choice) {
+						do_scroll(menu, &scroll, 1);
+						i--;
+						print_item(max_choice + scroll - 1, max_choice - 1, false);
+					}
+				else if (i < 0)
+					/*
+					 * Handle matches higher in the menu (ring search).
+					 */
+					while (i < 0) {
+						do_scroll(menu, &scroll, -1);
+						i++;
+						print_item(scroll, 0, false);
+					}
+				choice = i;
+			} else {
+				i = choice;
+				goto a;
+			}
+
+			print_item(scroll + choice, choice, TRUE);
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, true);
+			print_arrows(dialog, item_count(), scroll,
+				     box_y, box_x + item_x + 1, menu_height);
+
+			wnoutrefresh(dialog);
+			wrefresh(menu);
+			i = max_choice;
+			continue;
+		}
+	a:
 		switch (key) {
-		case KEY_LEFT:
 		case TAB:
+			focus_on_buttons = 1 - focus_on_buttons;
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
+
+			print_item(scroll + choice, choice, TRUE);
+			print_buttons(dialog, height, width, button);
+			wrefresh(menu);
+			break;
+		case KEY_LEFT:
 		case KEY_RIGHT:
+			focus_on_buttons = 1;
 			button = ((key == KEY_LEFT ? --button : ++button) < 0)
 			    ? 4 : (button > 4 ? 0 : button);
 
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
+			print_item(scroll + choice, choice, TRUE);
 			print_buttons(dialog, height, width, button);
 			wrefresh(menu);
 			break;
+		case KEY_ESC:
+			key = on_key_esc(menu);
+			break;
+		case KEY_RESIZE:
+			on_key_resize();
+			delwin(menu);
+			delwin(dialog);
+			goto do_resize;
+		}
+
+		/*
+		 * Focus is on buttons, handle keys appropriately
+		 */
+		switch (key) {
 		case ' ':
 		case 's':
 		case 'y':
@@ -390,6 +562,7 @@ int dialog_menu(const char *title, const char *prompt,
 		case '?':
 		case 'z':
 		case '\n':
+			isearch_str[0] = '\0';
 			/* save scroll info */
 			*s_scroll = scroll;
 			delwin(menu);
@@ -421,14 +594,6 @@ int dialog_menu(const char *title, const char *prompt,
 		case 'x':
 			key = KEY_ESC;
 			break;
-		case KEY_ESC:
-			key = on_key_esc(menu);
-			break;
-		case KEY_RESIZE:
-			on_key_resize();
-			delwin(menu);
-			delwin(dialog);
-			goto do_resize;
 		}
 	}
 	delwin(menu);
-- 
2.16.4
