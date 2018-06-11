Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hX8UEupxHluxfwAAmS7hNA
	; Mon, 11 Jun 2018 12:59:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9972607A4; Mon, 11 Jun 2018 12:59:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="UOwE0Bd8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0FD74601C3;
	Mon, 11 Jun 2018 12:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FD74601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeFKM7b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:59:31 -0400
Received: from services.gouders.net ([141.101.32.176]:42047 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:59:24 -0400
Received: from lena.gouders.net ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5BCq6mk028784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 11 Jun 2018 14:52:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1528721543; bh=l8UpWD9YxbxOivchLtWsT9nydNRNSJQG0T7vX3a/1J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UOwE0Bd8uyooEufbkwaeu9U7EVOYYgZFhaOkhtlIHhBG7jGwHvcxGSDIBl8jX3C3N
         RbEAoDNbZ2z1oyfPVUoWwXGOXKz5n8SnjVyoKtXbHIf/qNycO9VgmGtHmS23SyyinO
         ixqm9zdlXXlyNUyc629JRxMsViJmhO5ayWud8ttI=
From: Dirk Gouders <dirk@gouders.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [RFC v5 1/1] i-search navigation for mconf
Date: Mon, 11 Jun 2018 14:51:55 +0200
Message-Id: <20180611125155.21470-2-dirk@gouders.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180611125155.21470-1-dirk@gouders.net>
References: <20180611125155.21470-1-dirk@gouders.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements an i-search navigation concept for mconf based
on an idea of Sam Ravnborg:

* mconf now distinguishes if the focus is on the menu items or the
  buttons below it.

* At startup focus is on the menu items and printable characters
  (except the keys below) entered are used to form a string that is
  searched for.

* Hotkeys were sacrificed for the i-search navigation concept.
  However, focus on the buttons offers most of mconf's known behavior,
  except the TAB key and a change in the highlighting of menu items.

Keys with special meaning:

* BACKSPACE is used to remove the last character of the search string

* DEL clears the search string

* ENTER can be used to enter a submenu; it also clears the search string

* Horizontal arrow keys still cycle between the buttons but also
  switch focus to the buttons.

* The TAB key is now exclusively used to toggle the focus.

* Vertical arrow keys work everywhere.

* When the focus is on the buttons, all keys work the
  same as before this change -- except TAB and hotkeys.

* <\> (backslash) can be used to search for other occurences of an
  already entered string.

* To use y|n|m|<space> on an item, focus has to be on the buttons.

An example to navigate into the USB support menu under Device Drivers:

   1) de		# Navigates to the item "Device Drivers"
   2) ENTER		# Enter the submenu
   3) USB		# Navigate to the item "USB support"
   4) ENTER		# Enter the submenu

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 scripts/kconfig/lxdialog/dialog.h  |   3 +
 scripts/kconfig/lxdialog/menubox.c | 489 +++++++++++++++++++++++++++----------
 scripts/kconfig/lxdialog/util.c    | 106 +++++++-
 scripts/kconfig/mconf.c            |  68 ++++--
 4 files changed, 506 insertions(+), 160 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 0b00be5abaa6..28a3b42fdf71 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -215,6 +215,8 @@ void end_dialog(int x, int y);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
+void print_autowrap_fill(WINDOW * win, const char *prompt, int width,
+			int height, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
@@ -238,6 +240,7 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height);
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
+int do_isearch(char *str, int choice, int scroll);
 
 /*
  * This is the base for fictitious keys, which activate
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index d70cab36137e..7b22ec813d3c 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -56,22 +56,38 @@
  * fscanf would read in 'scroll', and eventually that value would get used.
  */
 
+#include <string.h>
 #include "dialog.h"
 
+#define ISEARCH_LEN 32
+static char isearch_str[ISEARCH_LEN] = "";
+
 static int menu_width, item_x;
 
+static int focus_on_buttons;
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
-			  int selected, int hotkey)
+			  int selected)
 {
-	int j;
+	int i;
+	int isearch_match_pos;
+	char *isearch_match;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width - item_x);
 	menu_item[menu_width - item_x] = '\0';
-	j = first_alpha(menu_item, "YyNnMmHh");
+
+	isearch_match = strcasestr(menu_item, isearch_str);
+	isearch_match_pos = isearch_match - menu_item;
 
 	/* Clear 'residue' of last item */
 	wattrset(win, dlg.menubox.atr);
@@ -85,14 +101,24 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
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
-		wattrset(win, selected ? dlg.tag_key_selected.atr
-			 : dlg.tag_key.atr);
-		mvwaddch(win, line_y, item_x + j, menu_item[j]);
-	}
+
 	if (selected) {
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
 		wmove(win, line_y, item_x + 1);
 	}
 	free(menu_item);
@@ -102,9 +128,37 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #define print_item(index, choice, selected)				\
 do {									\
 	item_set(index);						\
-	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
+	do_print_item(menu, item_str(), choice, selected); \
 } while (0)
 
+
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
@@ -156,12 +210,22 @@ static void print_buttons(WINDOW * win, int height, int width, int selected)
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
@@ -178,13 +242,40 @@ static void do_scroll(WINDOW *win, int *scroll, int n)
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
 int dialog_menu(const char *title, const char *prompt,
 		const void *selected, int *s_scroll)
 {
-	int i, j, x, y, box_x, box_y;
+	int i, x, y, box_x, box_y;
+	int key_match;		/* remember match in switch statement */
 	int height, width, menu_height;
 	int key = 0, button = 0, scroll = 0, choice = 0;
 	int first_item =  0, max_choice;
@@ -224,7 +315,9 @@ int dialog_menu(const char *title, const char *prompt,
 	print_title(dialog, title, width);
 
 	wattrset(dialog, dlg.dialog.atr);
-	print_autowrap(dialog, prompt, width - 2, 1, 3);
+	print_autowrap_fill(dialog,
+			   focus_on_buttons ? prompt : isearch_instructions,
+			   width - 2, 4, 1, 3);
 
 	menu_width = width - 6;
 	box_y = height - menu_height - 5;
@@ -275,6 +368,7 @@ int dialog_menu(const char *title, const char *prompt,
 	print_arrows(dialog, item_count(), scroll,
 		     box_y, box_x + item_x + 1, menu_height);
 
+	print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
 	print_buttons(dialog, height, width, 0);
 	wmove(menu, choice, item_x + 1);
 	wrefresh(menu);
@@ -284,44 +378,129 @@ int dialog_menu(const char *title, const char *prompt,
 
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
-
-		if (strchr("ynmh", key))
-			i = max_choice;
-		else {
-			for (i = choice + 1; i < max_choice; i++) {
-				item_set(scroll + i);
-				j = first_alpha(item_str(), "YyNnMmHh");
-				if (key == tolower(item_str()[j]))
-					break;
+		/*
+		 * These keys are handled for the focus on both,
+		 * menu and buttons.
+		 */
+		key_match = 0;
+		switch (key) {
+		case KEY_DC:	/* delete key clears i-search string */
+			key_match = 1;
+			isearch_str[0] = '\0';
+			break;
+		case TAB:
+			key_match = 1;
+			focus_on_buttons = 1 - focus_on_buttons;
+			wattrset(dialog, dlg.dialog.atr);
+			print_autowrap_fill(dialog,
+					   focus_on_buttons ? prompt : isearch_instructions,
+					   width - 2, 4, 1, 3);
+			break;
+		case KEY_LEFT:
+		case KEY_RIGHT:
+			key_match = 1;
+			if (!focus_on_buttons) {
+				focus_on_buttons = 1;
+				wattrset(dialog, dlg.dialog.atr);
+				print_autowrap_fill(dialog, prompt, width - 2, 4, 1, 3);
+				wnoutrefresh(dialog);
 			}
-			if (i == max_choice)
-				for (i = 0; i < max_choice; i++) {
-					item_set(scroll + i);
-					j = first_alpha(item_str(), "YyNnMmHh");
-					if (key == tolower(item_str()[j]))
-						break;
-				}
+			button = ((key == KEY_LEFT ? --button : ++button) < 0)
+			    ? 4 : (button > 4 ? 0 : button);
+			break;
+		case KEY_ESC:
+			key = on_key_esc(menu);
+			continue;
+		case KEY_RESIZE:
+			on_key_resize();
+			delwin(menu);
+			delwin(dialog);
+			goto do_resize;
+		}
+		if (key_match) {
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, !focus_on_buttons);
+			print_item(scroll + choice, choice, TRUE);
+			print_buttons(dialog, height, width, button);
+			wrefresh(menu);
+			continue;	/* wait for another key press */
 		}
 
-		if (item_count() != 0 &&
-		    (i < max_choice ||
-		     key == KEY_UP || key == KEY_DOWN ||
-		     key == '-' || key == '+' ||
-		     key == KEY_PPAGE || key == KEY_NPAGE)) {
-			/* Remove highligt of current item */
+		key_match = 0;
+		switch (key) {
+		case KEY_UP:
+			key_match = 1;
+			/* Remove highlight of current item */
+			print_item(scroll + choice, choice, FALSE);
+			if (choice < 2 && scroll) {
+				/* Scroll menu down */
+				do_scroll(menu, &scroll, -1);
+				print_item(scroll, 0, FALSE);
+			} else
+				choice = MAX(choice - 1, 0);
+			break;
+		case KEY_DOWN:
+			key_match = 1;
+			/* Remove highlight of current item */
 			print_item(scroll + choice, choice, FALSE);
 
-			if (key == KEY_UP || key == '-') {
-				if (choice < 2 && scroll) {
-					/* Scroll menu down */
-					do_scroll(menu, &scroll, -1);
+			if ((choice > max_choice - 3) &&
+			    (scroll + max_choice < item_count())) {
+				/* Scroll menu up */
+				do_scroll(menu, &scroll, 1);
+				print_item(scroll+max_choice - 1,
+					   max_choice - 1, FALSE);
+			} else
+				choice = MIN(choice + 1, max_choice - 1);
+			break;
+		case KEY_PPAGE:
+			key_match = 1;
+			/* Remove highlight of current item */
+			print_item(scroll + choice, choice, FALSE);
 
+			scrollok(menu, TRUE);
+			for (i = 0; (i < max_choice); i++) {
+				if (scroll > 0) {
+					do_scroll(menu, &scroll, -1);
 					print_item(scroll, 0, FALSE);
-				} else
-					choice = MAX(choice - 1, 0);
+				} else {
+					if (choice > 0)
+						choice--;
+				}
+			}
+			break;
+		case KEY_NPAGE:
+			key_match = 1;
+			/* Remove highlight of current item */
+			print_item(scroll + choice, choice, FALSE);
+			for (i = 0; (i < max_choice); i++) {
+				if (scroll + max_choice < item_count()) {
+					do_scroll(menu, &scroll, 1);
+					print_item(scroll+max_choice-1,
+						   max_choice - 1, FALSE);
+				} else {
+					if (choice + 1 < max_choice)
+						choice++;
+				}
+			}
+		}
+
+		if (key_match) {
+			print_item(scroll + choice, choice, TRUE);
+			print_arrows(dialog, item_count(), scroll,
+				     box_y, box_x + item_x + 1, menu_height);
+			wnoutrefresh(dialog);
+			wrefresh(menu);
+			continue;	/* wait for another key press */
+		}
 
-			} else if (key == KEY_DOWN || key == '+') {
-				print_item(scroll+choice, choice, FALSE);
+		if (focus_on_buttons) {
+			/*
+			 * Focus is on buttons, handle appropriate keys.
+			 */
+			switch (key) {
+			case '+':
+				/* Remove highlight of current item */
+				print_item(scroll + choice, choice, FALSE);
 
 				if ((choice > max_choice - 3) &&
 				    (scroll + max_choice < item_count())) {
@@ -332,106 +511,150 @@ int dialog_menu(const char *title, const char *prompt,
 						   max_choice - 1, FALSE);
 				} else
 					choice = MIN(choice + 1, max_choice - 1);
-
-			} else if (key == KEY_PPAGE) {
-				scrollok(menu, TRUE);
-				for (i = 0; (i < max_choice); i++) {
-					if (scroll > 0) {
-						do_scroll(menu, &scroll, -1);
-						print_item(scroll, 0, FALSE);
-					} else {
-						if (choice > 0)
-							choice--;
-					}
+				print_item(scroll + choice, choice, TRUE);
+				print_arrows(dialog, item_count(), scroll,
+					     box_y, box_x + item_x + 1, menu_height);
+				wnoutrefresh(dialog);
+				wrefresh(menu);
+				continue;	/* wait for another key press */
+			case '-':
+				/* Remove highlight of current item */
+				print_item(scroll + choice, choice, FALSE);
+				if (choice < 2 && scroll) {
+					/* Scroll menu down */
+					do_scroll(menu, &scroll, -1);
+					print_item(scroll, 0, FALSE);
+				} else
+					choice = MAX(choice - 1, 0);
+				print_item(scroll + choice, choice, TRUE);
+				print_arrows(dialog, item_count(), scroll,
+					     box_y, box_x + item_x + 1, menu_height);
+				wnoutrefresh(dialog);
+				wrefresh(menu);
+				continue;	/* wait for another key press */
+			case '\n':
+				isearch_str[0] = '\0';
+				/* fallthrough */
+			case ' ':
+			case 's':
+			case 'y':
+			case 'n':
+			case 'm':
+			case '/':
+			case 'h':
+			case '?':
+			case 'z':
+				/* save scroll info */
+				*s_scroll = scroll;
+				delwin(menu);
+				delwin(dialog);
+				item_set(scroll + choice);
+				item_set_selected(1);
+				switch (key) {
+				case 'h':
+				case '?':
+					return 2;
+				case 's':
+				case 'y':
+					return 5;
+				case 'n':
+					return 6;
+				case 'm':
+					return 7;
+				case ' ':
+					return 8;
+				case '/':
+					return 9;
+				case 'z':
+					return 10;
+				case '\n':
+					return button;
 				}
-
-			} else if (key == KEY_NPAGE) {
-				for (i = 0; (i < max_choice); i++) {
-					if (scroll + max_choice < item_count()) {
+				return 0;
+			case 'e':
+			case 'x':
+				key = KEY_ESC;
+				break;
+			}
+			continue;
+		} else {	/* !focus_on_buttons */
+			if (key == '\n') {
+				/* save scroll info */
+				*s_scroll = scroll;
+				delwin(menu);
+				delwin(dialog);
+				item_set(scroll + choice);
+				item_set_selected(1);
+				isearch_str[0] = '\0';
+				return 0; /* 0 means first button "Select" */
+			} else if ( key == KEY_BACKSPACE ) {
+				if ( isearch_str[0] )
+					isearch_str[i = (strlen(isearch_str) - 1)] = '\0';
+				/* Remove highlight of current item */
+				print_item(scroll + choice, choice, FALSE);
+				i = do_isearch(isearch_str, choice + 1, scroll);
+			} else if (key == '\\') {
+				/*
+				 * Check \ before printable chars,
+				 * because it is reserved to search
+				 * further matches.
+				 */
+				/* Remove highlight of current item */
+				print_item(scroll + choice, choice, FALSE);
+				i = do_isearch(isearch_str, choice + 1, scroll);
+			} else if (key < 256 && (isprint(key) || key == ' ')) {
+				if (strlen(isearch_str) < ISEARCH_LEN - 1) {
+					isearch_str[i = strlen(isearch_str)] = key;
+					isearch_str[i+1] = '\0';
+					/* Remove highlight of current item */
+					print_item(scroll + choice, choice, FALSE);
+					i = do_isearch(isearch_str, choice, scroll);
+				} else
+					continue;
+			} else
+				continue;
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
 						do_scroll(menu, &scroll, 1);
-						print_item(scroll+max_choice-1,
-							   max_choice - 1, FALSE);
-					} else {
-						if (choice + 1 < max_choice)
-							choice++;
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
 					}
-				}
-			} else
 				choice = i;
+			} else {
+				i = choice;
+			}
 
 			print_item(scroll + choice, choice, TRUE);
-
+			print_isearch(dialog, box_y, box_x + item_x + 5, menu_height, true);
 			print_arrows(dialog, item_count(), scroll,
 				     box_y, box_x + item_x + 1, menu_height);
 
 			wnoutrefresh(dialog);
 			wrefresh(menu);
-
-			continue;	/* wait for another key press */
-		}
-
-		switch (key) {
-		case KEY_LEFT:
-		case TAB:
-		case KEY_RIGHT:
-			button = ((key == KEY_LEFT ? --button : ++button) < 0)
-			    ? 4 : (button > 4 ? 0 : button);
-
-			print_buttons(dialog, height, width, button);
-			wrefresh(menu);
-			break;
-		case ' ':
-		case 's':
-		case 'y':
-		case 'n':
-		case 'm':
-		case '/':
-		case 'h':
-		case '?':
-		case 'z':
-		case '\n':
-			/* save scroll info */
-			*s_scroll = scroll;
-			delwin(menu);
-			delwin(dialog);
-			item_set(scroll + choice);
-			item_set_selected(1);
-			switch (key) {
-			case 'h':
-			case '?':
-				return 2;
-			case 's':
-			case 'y':
-				return 5;
-			case 'n':
-				return 6;
-			case 'm':
-				return 7;
-			case ' ':
-				return 8;
-			case '/':
-				return 9;
-			case 'z':
-				return 10;
-			case '\n':
-				return button;
-			}
-			return 0;
-		case 'e':
-		case 'x':
-			key = KEY_ESC;
-			break;
-		case KEY_ESC:
-			key = on_key_esc(menu);
-			break;
-		case KEY_RESIZE:
-			on_key_resize();
-			delwin(menu);
-			delwin(dialog);
-			goto do_resize;
+			continue;
 		}
 	}
 	delwin(menu);
 	delwin(dialog);
+	isearch_str[0] = '\0';
 	return key;		/* ESC pressed */
 }
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f7abdeb92af0..fde4865ff83a 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -373,13 +373,79 @@ void print_title(WINDOW *dialog, const char *title, int width)
 	}
 }
 
+void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
+{
+	int newl, cur_x, cur_y;
+	int prompt_len, room, wlen;
+	char tempstr[MAX_LEN + 1], *word, *sp, *sp2, *newline_separator = 0;
+
+	strcpy(tempstr, prompt);
+
+	prompt_len = strlen(tempstr);
+
+	if (prompt_len <= width - x * 2) {	/* If prompt is short */
+		wmove(win, y, (width - prompt_len) / 2);
+		waddstr(win, tempstr);
+	} else {
+		cur_x = x;
+		cur_y = y;
+		newl = 1;
+		word = tempstr;
+		while (word && *word) {
+			sp = strpbrk(word, "\n ");
+			if (sp && *sp == '\n')
+				newline_separator = sp;
+
+			if (sp)
+				*sp++ = 0;
+
+			/* Wrap to next line if either the word does not fit,
+			   or it is the first word of a new sentence, and it is
+			   short, and the next word does not fit. */
+			room = width - cur_x;
+			wlen = strlen(word);
+			if (wlen > room ||
+			    (newl && wlen < 4 && sp
+			     && wlen + 1 + strlen(sp) > room
+			     && (!(sp2 = strpbrk(sp, "\n "))
+				 || wlen + 1 + (sp2 - sp) > room))) {
+				cur_y++;
+				cur_x = x;
+			}
+			wmove(win, cur_y, cur_x);
+			waddstr(win, word);
+			getyx(win, cur_y, cur_x);
+
+			/* Move to the next line if the word separator was a newline */
+			if (newline_separator) {
+				cur_y++;
+				cur_x = x;
+				newline_separator = 0;
+			} else
+				cur_x++;
+
+			if (sp && *sp == ' ') {
+				cur_x++;	/* double space */
+				while (*++sp == ' ') ;
+				newl = 1;
+			} else
+				newl = 0;
+			word = sp;
+		}
+	}
+}
+
 /*
  * Print a string of text in a window, automatically wrap around to the
  * next line if the string is too long to fit on one line. Newline
  * characters '\n' are propperly processed.  We start on a new line
  * if there is no room for at least 4 nonblanks following a double-space.
+ *
+ * This function fills all of and at most the area width x height so
+ * that it can be used to overwrite previosly displayed text.
  */
-void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
+void print_autowrap_fill(WINDOW * win, const char *prompt, int width,
+			int height, int y, int x)
 {
 	int newl, cur_x, cur_y;
 	int prompt_len, room, wlen;
@@ -415,7 +481,13 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			     && wlen + 1 + strlen(sp) > room
 			     && (!(sp2 = strpbrk(sp, "\n "))
 				 || wlen + 1 + (sp2 - sp) > room))) {
+				while (cur_x < width) {
+					waddch(win, ' ');
+					cur_x++;
+				}
 				cur_y++;
+				if (cur_y - y >= height)
+					break;
 				cur_x = x;
 			}
 			wmove(win, cur_y, cur_x);
@@ -424,13 +496,24 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 
 			/* Move to the next line if the word separator was a newline */
 			if (newline_separator) {
+				while (cur_x < width) {
+					waddch(win, ' ');
+					cur_x++;
+				}
 				cur_y++;
+				if (cur_y - y >= height)
+					break;
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
@@ -439,6 +522,25 @@ void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x)
 			word = sp;
 		}
 	}
+
+	/*
+	 * Fill remaining space to overwrite possibly existing text.
+	 */
+	wmove(win, cur_y, cur_x);
+	while (cur_x < width) {
+		waddch(win, ' ');
+		cur_x++;
+	}
+	wmove(win, cur_y + 1, x);
+	getyx(win, cur_y, cur_x);
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
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 5294ed159b98..b25d4738136b 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -36,43 +36,62 @@ static const char mconf_readme[] =
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
-"Some additional keyboard hints:\n"
-"\n"
-"Menus\n"
+"Navigation\n"
 "----------\n"
-"o  Use the Up/Down arrow keys (cursor keys) to highlight the item you\n"
-"   wish to change or the submenu you wish to select and press <Enter>.\n"
-"   Submenus are designated by \"--->\", empty ones by \"----\".\n"
+"The following keys work independent of the current focus:\n"
 "\n"
-"   Shortcut: Press the option's highlighted letter (hotkey).\n"
-"             Pressing a hotkey more than once will sequence\n"
-"             through all visible items which use that hotkey.\n"
+"o vertical arrow keys are used to navigate to menu items\n"
 "\n"
-"   You may also use the <PAGE UP> and <PAGE DOWN> keys to scroll\n"
-"   unseen options into view.\n"
+"o horizontal arrow keys cycle between the buttons\n"
+"  If used with focus on the menu, the focus also changes to the buttons\n"
 "\n"
-"o  To exit a menu use the cursor keys to highlight the <Exit> button\n"
-"   and press <ENTER>.\n"
+"o <PAGE UP> and <PAGE DOWN> scroll invisible items into view\n"
 "\n"
-"   Shortcut: Press <ESC><ESC> or <E> or <X> if there is no hotkey\n"
-"             using those letters.  You may press a single <ESC>, but\n"
-"             there is a delayed response which you may find annoying.\n"
+"o <ENTER> visits a submenu\n"
+"  Submenus are designated by \"--->\", empty ones by \"----\".\n"
 "\n"
-"   Also, the <TAB> and cursor keys will cycle between <Select>,\n"
-"   <Exit>, <Help>, <Save>, and <Load>.\n"
+"o <ESC><ESC> leaves a submenu or (in the main menu) exits menuconfig\n"
 "\n"
-"o  To get help with an item, use the cursor keys to highlight <Help>\n"
-"   and press <ENTER>.\n"
+"o <TAB> is reserved to toggle the focus between menu and buttons\n"
 "\n"
-"   Shortcut: Press <H> or <?>.\n"
+"When menuconfig starts, the focus is on the menu and i-search mode\n"
+"is active.  You can enter subsequent characters to build a string the\n"
+"menu items are searched for.  Keys with a special meaning are:\n"
+"\n"
+"o <BACKSPACE> removes the last character of the current search string\n"
+"\n"
+"o <DEL> clears the complete search string\n"
+"\n"
+"o <ENTER> also clears the whole string, but also visits a submenu\n"
+"  if the selected menu item is one\n"
 "\n"
-"o  To toggle the display of hidden options, press <Z>.\n"
+"o <\\> (backslash) can be used to find further matches of a string\n"
 "\n"
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
+"Some additional keyboard hints:\n"
 "\n"
 "Radiolists  (Choice lists)\n"
 "-----------\n"
@@ -174,7 +193,6 @@ static const char mconf_readme[] =
 menu_instructions[] =
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus ---> (or empty submenus ----).  "
-	"Highlighted letters are hotkeys.  "
 	"Pressing <Y> includes, <N> excludes, <M> modularizes features.  "
 	"Press <Esc><Esc> to exit, <?> for Help, </> for Search.  "
 	"Legend: [*] built-in  [ ] excluded  <M> module  < > module capable",
-- 
2.16.4
