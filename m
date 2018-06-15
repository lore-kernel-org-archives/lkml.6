Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47C720896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="GgQXStlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47C720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756728AbeFOWgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:36:40 -0400
Received: from services.gouders.net ([141.101.32.176]:37999 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756592AbeFOWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:36:26 -0400
Received: from lena.gouders.net (ipservice-047-071-023-039.pools.arcor-ip.net [47.71.23.39])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5FMTCfI020007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 16 Jun 2018 00:29:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529101769; bh=BdJqoAUCYeVEu/c+L4tF+XEnbZMPXp19bnhiJ1EGqDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GgQXStlmpheopLwH0A1+P1UYxRylJ1gjrfcIPPCx/wAPefoNaKvNJ+EYWDaJ3+cP7
         8YMd/E9Xx7M2REx8n0GQpWUK7fbkBVHfOt9xg1ptFSw4yXFH9zasJ/eOefralItRMR
         etgNmmfFyOyCVpzHH/uT2NaRuRepSPqTQifm/Vd4=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Dirk Gouders <dirk@gouders.net>
Subject: [RFC v6 1/1] mconf: global i-search in menu structure
Date:   Sat, 16 Jun 2018 00:29:07 +0200
Message-Id: <20180615222907.23449-2-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180615222907.23449-1-dirk@gouders.net>
References: <20180615222907.23449-1-dirk@gouders.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements an i-search navigation concept for mconf based
on an idea of Sam Ravnborg:

* mconf now distinguishes if the focus is on the menu items or the
  buttons below it.

* At startup focus is on the menu items and printable characters
  (details see below) entered are used to form a string that is
  searched for.

This patch implements a global cyclic i-search in the complete menu
tree.  For ease of cyclic searches, the menu tree is serialized into
an array at startup.  For example, the following tree

a1 - b1 - c1 - d1 - e1
     |         |
     b2        d2 - d3
               |
               d4

is serialized to

a1 - b1 - b2 - c1 - d1 - d2 - d4 - d3 - e1

Operation
---------
The TAB key is reserved to toggle the focus between menu and bottons.

When the focus is on the buttons, mconf operates as before with the
exception of the TAB key.

When the focus is on the menu, mconf operates in i-search mode and the
following input has special meaning:

* <\> (backslash) can be used to search for other occurences of an
  already entered string.  On empty search strings, nothing happens.

* Any other printable character than backslash is appended to the
  current search string and a match is searched for.

* BACKSPACE is used to remove the last character of the search string.

* DEL clears the search string.

* ENTER can be used to enter a submenu.

* ESC ESC exits the current isearch.

* Horizontal arrow keys still cycle between the buttons but also
  switch focus to the buttons.

* Vertical arroy keys navigate the menu items.

At any time, only one i-search is active and the navigation path to
the current menu is displayed in the subtitle, the second line in the
menu window.

Navigation example:

To navigate to options concerning NFS file systems, simply type 'n',
'f' and 's'.

Hint: use the 'z' key with focus on buttons to search for invisible
      prompts.

Signed-off-by: Dirk Gouders <dirk@gouders.net>
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/checklist.c |   2 +-
 scripts/kconfig/lxdialog/dialog.h    |   3 +-
 scripts/kconfig/lxdialog/inputbox.c  |   2 +-
 scripts/kconfig/lxdialog/menubox.c   | 177 +++++++++++++++++++++++++++++-----
 scripts/kconfig/lxdialog/util.c      |  37 ++++++-
 scripts/kconfig/lxdialog/yesno.c     |   2 +-
 scripts/kconfig/mconf.c              | 181 +++++++++++++++++++++++++++++++++--
 7 files changed, 364 insertions(+), 40 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index 2e96323ad11b..2a8bd877af72 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -160,7 +160,7 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 	print_title(dialog, title, width);
 
 	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 3);
+	print_autowrap(dialog, prompt, width - 2, 3, 1, 3);
 
 	list_width = width - 6;
 	box_y = height - list_height - 5;
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 0b00be5abaa6..9396ed2122f9 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -214,7 +214,8 @@ void set_dialog_subtitles(struct subtitle_list *subtitles);
 void end_dialog(int x, int y);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
-void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
+void print_autowrap(WINDOW * win, const char *prompt,
+		    int width, int height, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index fe82ff6d744e..121ac6b810f3 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -82,7 +82,7 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 	print_title(dialog, title, width);
 
 	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 3);
+	print_autowrap(dialog, prompt, width - 2, 2, 1, 3);
 
 	/* Draw the input field box */
 	box_width = width - 6;
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d70cab36137e..18de050a7dcc 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -58,21 +58,38 @@
 
 #include "dialog.h"
 
+#define ISEARCH_LEN 32
+char isearch_str[ISEARCH_LEN] = "";
+
 static int menu_width, item_x;
 
+int focus_on_buttons;
+
+static const char isearch_instructions[] =
+	"I-search: Arrow keys navigate the menu.  "
+	"<Enter> selects submenus and/or clears i-search string.  "
+	"Type any character to search for menu items, "
+	"press <\\> to find further matches, <Esc><Esc> to exit. "
+	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable";
 /*
  * Print menu item
  */
 static void do_print_item(WINDOW * win, const char *item, int line_y,
 			  int selected, int hotkey)
 {
+	int i;
 	int j;
+	int isearch_match_pos;
+	char *isearch_match;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width - item_x);
 	menu_item[menu_width - item_x] = '\0';
 	j = first_alpha(menu_item, "YyNnMmHh");
 
+	isearch_match = strcasestr(menu_item, isearch_str);
+	isearch_match_pos = isearch_match - menu_item;
+
 	/* Clear 'residue' of last item */
 	wattrset(win, dlg.menubox.atr);
 	wmove(win, line_y, 0);
@@ -85,16 +102,31 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #else
 	wclrtoeol(win);
 #endif
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	if (focus_on_buttons)
+		wattrset(win, selected ? A_UNDERLINE : dlg.item.atr);
+	else
+		wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
 	mvwaddstr(win, line_y, item_x, menu_item);
-	if (hotkey) {
+	if (hotkey && focus_on_buttons) {
 		wattrset(win, selected ? dlg.tag_key_selected.atr
 			 : dlg.tag_key.atr);
 		mvwaddch(win, line_y, item_x + j, menu_item[j]);
 	}
-	if (selected) {
-		wmove(win, line_y, item_x + 1);
+
+	if (selected && !focus_on_buttons) {
+		/*
+		 * Highlight i-search matching part of selected menu item
+		 */
+		if (isearch_match) {
+			for (i = 0; i < strlen(isearch_str); i++) {
+				wattrset(win, dlg.tag_key_selected.atr);
+				mvwaddch(win, line_y, item_x + isearch_match_pos + i,
+					 menu_item[isearch_match_pos + i]);
+			}
+		}
+
 	}
+	wmove(win, line_y, item_x + 1);
 	free(menu_item);
 	wrefresh(win);
 }
@@ -102,9 +134,36 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #define print_item(index, choice, selected)				\
 do {									\
 	item_set(index);						\
-	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
+	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':'));		\
 } while (0)
 
+/*
+* Print the isearch indicator.
+*/
+static void print_isearch(WINDOW * win, int y, int x, int height, bool isearch)
+{
+	unsigned char i = 0;
+	int text_size = ISEARCH_LEN - 1;
+	wmove(win, y, x);
+
+	y = y + height + 1;
+	wmove(win, y, x);
+
+	if (isearch) {
+		wattrset(win, dlg.button_key_inactive.atr);
+		waddstr(win, "isearch: ");
+		waddstr(win, isearch_str);
+		i = strlen(isearch_str);
+	} else {
+		text_size += 9; /* also overwrite "isearch: " */
+	}
+
+	wattrset(win, dlg.menubox_border.atr);
+
+	for ( ; i < text_size; i++ )
+		waddch(win, ACS_HLINE);
+}
+
 /*
  * Print the scroll indicators.
  */
@@ -156,12 +215,22 @@ static void print_buttons(WINDOW * win, int height, int width, int selected)
 {
 	int x = width / 2 - 28;
 	int y = height - 2;
+	int highlight;
+
+	/*
+	 * Don't highlight the selected button if the buttons don't have
+	 * the focus.
+	 */
+	if (!focus_on_buttons)
+		highlight = -1;
+	else
+		highlight = selected;
 
-	print_button(win, "Select", y, x, selected == 0);
-	print_button(win, " Exit ", y, x + 12, selected == 1);
-	print_button(win, " Help ", y, x + 24, selected == 2);
-	print_button(win, " Save ", y, x + 36, selected == 3);
-	print_button(win, " Load ", y, x + 48, selected == 4);
+	print_button(win, "Select", y, x, highlight == 0);
+	print_button(win, " Exit ", y, x + 12, highlight == 1);
+	print_button(win, " Help ", y, x + 24, highlight == 2);
+	print_button(win, " Save ", y, x + 36, highlight == 3);
+	print_button(win, " Load ", y, x + 48, highlight == 4);
 
 	wmove(win, y, x + 1 + 12 * selected);
 	wrefresh(win);
@@ -224,7 +293,9 @@ int dialog_menu(const char *title, const char *prompt,
 	print_title(dialog, title, width);
 
 	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 3);
+	print_autowrap(dialog,
+		       focus_on_buttons ? prompt : isearch_instructions,
+		       width - 2, 4, 1, 3);
 
 	menu_width = width - 6;
 	box_y = height - menu_height - 5;
@@ -275,6 +346,7 @@ int dialog_menu(const char *title, const char *prompt,
 	print_arrows(dialog, item_count(), scroll,
 		     box_y, box_x + item_x + 1, menu_height);
 
+	print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
 	print_buttons(dialog, height, width, 0);
 	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
@@ -285,22 +357,24 @@ int dialog_menu(const char *title, const char *prompt,
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
@@ -370,13 +444,68 @@ int dialog_menu(const char *title, const char *prompt,
 			continue;	/* wait for another key press */
 		}
 
+		if (!focus_on_buttons) {
+			if (key == KEY_BACKSPACE) {
+				i = max_choice;
+				if (isearch_str[0]) {
+					isearch_str[strlen(isearch_str) - 1] = '\0';
+					print_item(scroll + choice, choice, true);
+					print_isearch(dialog, box_y, box_x + item_x + 5,
+						      menu_height, !focus_on_buttons);
+					print_buttons(dialog, height, width, button);
+					wrefresh(menu);
+				}
+				continue;
+			}
+
+			if (key == KEY_DC) {
+				isearch_str[0] = '\0';
+				print_item(scroll + choice, choice, true);
+				print_isearch(dialog, box_y, box_x + item_x + 5,
+					      menu_height, !focus_on_buttons);
+				print_buttons(dialog, height, width, button);
+				wrefresh(menu);
+				continue;
+			}
+
+			if (isprint(key)) {
+				item_set(choice);
+				if (strlen(isearch_str) < ISEARCH_LEN - 1
+				    && key != '\\') {
+					isearch_str[i = strlen(isearch_str)] = key;
+					isearch_str[i+1] = '\0';
+					/* Remove highlight of current item */
+					print_item(scroll + choice, choice, FALSE);
+				}
+				if (key == '\\')
+					item_set(choice + 1 < max_choice ? choice + 1 : 0);
+				return key;
+			}
+		}
+
 		switch (key) {
 		case KEY_LEFT:
-		case TAB:
 		case KEY_RIGHT:
 			button = ((key == KEY_LEFT ? --button : ++button) < 0)
 			    ? 4 : (button > 4 ? 0 : button);
-
+			focus_on_buttons = 0; /* see next
+					       * modification below! */
+			/* fallthrough */
+		case TAB:
+			focus_on_buttons = !focus_on_buttons;
+			/* Print the menu */
+			for (i = 0; i < max_choice; i++) {
+				print_item(scroll + i, i, false);
+			}
+			/*
+			 * Print current item again to have the cursor
+			 * positioned
+			 */
+			print_item(scroll + choice, choice, true);
+			wattrset(dialog, dlg.dialog.atr);
+			print_autowrap(dialog, focus_on_buttons ? prompt : isearch_instructions,
+				       width - 2, 4, 1, 3);
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
 			print_buttons(dialog, height, width, button);
 			wrefresh(menu);
 			break;
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f7abdeb92af0..ce54b0dfc109 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -378,8 +378,12 @@ void print_title(WINDOW *dialog, const char *title, int width)
  * next line if the string is too long to fit on one line. Newline
  * characters '\n' are propperly processed.  We start on a new line
  * if there is no room for at least 4 nonblanks following a double-space.
+ *
+ * This function fills all of and at most the area width x height so
+ * that it can be used to overwrite previosly displayed text.
  */
-void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
+void print_autowrap(WINDOW * win, const char *prompt, int width,
+			int height, int y, int x)
 {
 	int newl, cur_x, cur_y;
 	int prompt_len, room, wlen;
@@ -415,7 +419,13 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			     && wlen + 1 + strlen(sp) > room
 			     && (!(sp2 = strpbrk(sp, "\n "))
 				 || wlen + 1 + (sp2 - sp) > room))) {
+				while (cur_x < width) {
+					waddch(win, ' ');
+					cur_x++;
+				}
 				cur_y++;
+				if (cur_y - y >= height)
+					return;
 				cur_x = x;
 			}
 			wmove(win, cur_y, cur_x);
@@ -424,13 +434,24 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 
 			/* Move to the next line if the word separator was a newline */
 			if (newline_separator) {
+				while (cur_x < width) {
+					waddch(win, ' ');
+					cur_x++;
+				}
 				cur_y++;
+				if (cur_y - y >= height)
+					return;
 				cur_x = x;
 				newline_separator = 0;
-			} else
+			} else {
+				if (cur_x < width)
+					waddch(win, ' ');
 				cur_x++;
+			}
 
 			if (sp && *sp == ' ') {
+				if (cur_x < width)
+					waddch(win, ' ');
 				cur_x++;	/* double space */
 				while (*++sp == ' ') ;
 				newl = 1;
@@ -439,6 +460,18 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			word = sp;
 		}
 	}
+
+	/*
+	 * Fill remaining space to overwrite possibly existing text.
+	 */
+	while (cur_y - y < height) {
+		while (cur_x < width) {
+			waddch(win, ' ');
+			cur_x++;
+		}
+		wmove(win, cur_y + 1, x);
+		getyx(win, cur_y, cur_x);
+	}
 }
 
 /*
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index cd1223c903d1..d2af2a04173d 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -71,7 +71,7 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width)
 	print_title(dialog, title, width);
 
 	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 3);
+	print_autowrap(dialog, prompt, width - 2, 2, 1, 3);
 
 	print_buttons(dialog, height, width, 0);
 
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5294ed159b98..d1d32b5dd995 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -21,6 +21,12 @@
 #include "lkc.h"
 #include "lxdialog/dialog.h"
 
+extern int focus_on_buttons;
+extern char isearch_str[];
+struct menu **flat_menu;
+static int flat_menu_max = 10;
+static int in_isearch;
+
 static const char mconf_readme[] =
 "Overview\n"
 "--------\n"
@@ -36,20 +42,72 @@ static const char mconf_readme[] =
 "while *, M or whitespace inside braces means to build in, build as\n"
 "a module or to exclude the feature respectively.\n"
 "\n"
-"To change any of these features, highlight it with the cursor\n"
-"keys and press <Y> to build it in, <M> to make it a module or\n"
+"Operation modes\n"
+"---------------\n"
+"Menuconfig operates in two modes, depending on the focus that can be\n"
+"either on the menu or the buttons below it.\n"
+"\n"
+"To change any of the above features, it has to be navigated to (see\n"
+"below) so that it is highlited, focus then has to be on the buttons\n"
+"before you press <Y> to build it in, <M> to make it a module or\n"
 "<N> to remove it.  You may also press the <Space Bar> to cycle\n"
 "through the available options (i.e. Y->N->M->Y).\n"
 "\n"
+"Navigation\n"
+"----------\n"
+"The following keys work independent of the current focus:\n"
+"\n"
+"o vertical arrow keys are used to navigate to menu items\n"
+"\n"
+"o horizontal arrow keys cycle between the buttons\n"
+"  If used with focus on the menu, the focus also changes to the buttons\n"
+"\n"
+"o <PAGE UP> and <PAGE DOWN> scroll invisible items into view\n"
+"\n"
+"o <ENTER> visits a submenu\n"
+"  Submenus are designated by \"--->\", empty ones by \"----\".\n"
+"\n"
+"o <ESC><ESC> leaves a submenu or (in the main menu) exits menuconfig\n"
+"\n"
+"o <TAB> is reserved to toggle the focus between menu and buttons\n"
+"\n"
+"When menuconfig starts, the focus is on the menu and i-search mode\n"
+"is active.  I-search performs continuous cyclic searches for an entered\n"
+"string in the prompt texts of a serialized version of the complete menu\n"
+"tree.\n"
+"\n"
+"You can enter subsequent characters to build a string the\n"
+"menu items are searched for and each time a character is added the\n"
+"current string is searched for starting from the current position in the menu\n"
+"tree.\n"
+"\n"
+"Keys with a special meaning are:\n"
+"\n"
+"o <BACKSPACE> removes the last character from the current search string\n"
+"\n"
+"o <DEL> clears the complete search string\n"
+"\n"
+"o <\\> (backslash) can be used to find further matches of a string\n"
+"\n"
+"When the focus is on the buttons the following keys can be used:\n"
+"\n"
+"o <x> can be used for exit identical to <ESC><ESC>\n"
+"\n"
+"o <y>, <n>, <m> or <SPACE> change the selected item\n"
+"\n"
+"o <+> and <-> keys navigate menu items identical to vertical arrow\n"
+"  keys\n"
+"\n"
+"o <h> or <?> display help messages\n"
+"\n"
+"o <z> toggles the display of hidden options\n"
+"\n"
 "Some additional keyboard hints:\n"
 "\n"
 "Menus\n"
 "----------\n"
-"o  Use the Up/Down arrow keys (cursor keys) to highlight the item you\n"
-"   wish to change or the submenu you wish to select and press <Enter>.\n"
-"   Submenus are designated by \"--->\", empty ones by \"----\".\n"
-"\n"
-"   Shortcut: Press the option's highlighted letter (hotkey).\n"
+"o  Hotkeys (available with focus on buttons): Press the target option's\n"
+"             highlighted letter (hotkey).\n"
 "             Pressing a hotkey more than once will sequence\n"
 "             through all visible items which use that hotkey.\n"
 "\n"
@@ -280,7 +338,7 @@ static int show_all_options;
 static int save_and_exit;
 static int silent;
 
-static void conf(struct menu *menu, struct menu *active_menu);
+static int conf(struct menu *menu, struct menu *active_menu);
 static void conf_choice(struct menu *menu);
 static void conf_string(struct menu *menu);
 static void conf_load(void);
@@ -641,7 +699,72 @@ static void build_conf(struct menu *menu)
 	indent -= doint;
 }
 
-static void conf(struct menu *menu, struct menu *active_menu)
+char menu_isearch(void);
+char menu_isearch(void)
+{
+	int i;
+	struct menu *start = item_data();
+	int flat_start = -1;
+	struct menu *submenu;
+	char res = '\\';
+	int isearch_match;		/* Avoid continuous loops for
+					 * nonexistent patterns.*/
+	struct gstr sttext;
+	struct subtitle_part stpart;
+
+	in_isearch = 1;
+	/*
+	 * Position to current menu item to start search from there.
+	 */
+	for (i = 0; i < flat_menu_max; i++)
+		if (flat_menu[i] == start) {
+			flat_start = i;
+			break;
+		}
+
+	sttext = str_new();
+	str_printf(&sttext, "i-search");
+	stpart.text = str_get(&sttext);
+	list_add_tail(&stpart.entries, &trail);
+	set_subtitle();
+
+	while (isearch_str[0] != '\0') {
+		isearch_match = 0;
+		for (i = 0; i < flat_menu_max; i++) {
+			submenu = flat_menu[(flat_start + i) % flat_menu_max];
+
+			if (!submenu->prompt ||
+			    (!show_all_options && !menu_is_visible(submenu)))
+				continue;
+
+			if (!strcasestr(submenu->prompt->text, isearch_str))
+				continue;
+
+			if (!submenu->sym && submenu->prompt->type == P_COMMENT)
+				continue;
+
+			isearch_match = 1;
+
+			res = conf(submenu->parent, submenu);
+
+			if (focus_on_buttons || !isprint(res)) {
+				in_isearch = 0;
+				list_del(trail.prev);
+				return res;
+			}
+
+			if (res != '\\')
+				i--;	/* continue search with the same menu item */
+		}
+		if (!isearch_match)
+			break;
+	}
+	in_isearch = 0;
+	list_del(trail.prev);
+	return res;
+}
+
+static int conf(struct menu *menu, struct menu *active_menu)
 {
 	struct menu *submenu;
 	const char *prompt = menu_get_prompt(menu);
@@ -667,6 +790,16 @@ static void conf(struct menu *menu, struct menu *active_menu)
 		res = dialog_menu(prompt ? prompt : "Main Menu",
 				  menu_instructions,
 				  active_menu, &s_scroll);
+
+		if (!focus_on_buttons && isprint(res)) {
+			if (in_isearch) {
+				list_del(trail.prev);
+				return res;
+			}
+			res = menu_isearch();
+			continue;
+		}
+
 		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
 			break;
 		if (item_count() != 0) {
@@ -748,8 +881,8 @@ static void conf(struct menu *menu, struct menu *active_menu)
 			break;
 		}
 	}
-
 	list_del(trail.prev);
+	return res;
 }
 
 static int show_textbox_ext(const char *title, char *text, int r, int c, int
@@ -1003,6 +1136,33 @@ static void sig_handler(int signo)
 	exit(handle_exit());
 }
 
+void flat_menu_add(struct menu *m);
+void flat_menu_add(struct menu *m)
+{
+	static int i = 0;
+	if (i == flat_menu_max) {
+		flat_menu_max += 10;
+		flat_menu = xrealloc(flat_menu, sizeof(struct menu *) * flat_menu_max);
+	}
+	flat_menu[i++] = m;
+}
+
+void serialize_menu(struct menu *m);
+void serialize_menu(struct menu *m)
+{
+	struct menu *menu_ptr;
+	struct menu *start_menu = m;
+
+	if (!flat_menu)
+		flat_menu = xmalloc(sizeof(struct menu *) * flat_menu_max);
+
+	for (menu_ptr = start_menu; menu_ptr; menu_ptr = menu_ptr->next) {
+		flat_menu_add(menu_ptr);
+		if (menu_ptr->list)
+			serialize_menu(menu_ptr->list);
+	}
+}
+
 int main(int ac, char **av)
 {
 	char *mode;
@@ -1033,6 +1193,7 @@ int main(int ac, char **av)
 
 	set_config_filename(conf_get_configname());
 	conf_set_message_callback(conf_message_callback);
+	serialize_menu(&rootmenu);
 	do {
 		conf(&rootmenu, NULL);
 		res = handle_exit();
-- 
2.16.4

