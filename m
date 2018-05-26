Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030949AbeEZAyN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:54:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:32781 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030896AbeEZAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:54:12 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Hurley <peter@hurleysoftware.com>,
        syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
Subject: [PATCH 1/2] n_tty: Fix stall at n_tty_receive_char_special().
Date: Sat, 26 May 2018 09:53:13 +0900
Message-Id: <1527295994-3440-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting stalls at n_tty_receive_char_special() [1]. This is
because comparison is not working as expected since ldata->read_head can
change at any moment. Mitigate this by explicitly masking with buffer size
when checking condition for "while" loops.

[1] https://syzkaller.appspot.com/bug?id=3d7481a346958d9469bebbeb0537d5f056bdd6e8

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
Fixes: bc5a5e3f45d04784 ("n_tty: Don't wrap input buffer indices at buffer size")
Cc: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index cbe98bc..b279f873 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -124,6 +124,8 @@ struct n_tty_data {
 	struct mutex output_lock;
 };
 
+#define MASK(x) ((x) & (N_TTY_BUF_SIZE - 1))
+
 static inline size_t read_cnt(struct n_tty_data *ldata)
 {
 	return ldata->read_head - ldata->read_tail;
@@ -978,14 +980,15 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 	}
 
 	seen_alnums = 0;
-	while (ldata->read_head != ldata->canon_head) {
+	while (MASK(ldata->read_head) != MASK(ldata->canon_head)) {
 		head = ldata->read_head;
 
 		/* erase a single possibly multibyte character */
 		do {
 			head--;
 			c = read_buf(ldata, head);
-		} while (is_continuation(c, tty) && head != ldata->canon_head);
+		} while (is_continuation(c, tty) &&
+			 MASK(head) != MASK(ldata->canon_head));
 
 		/* do not partially erase */
 		if (is_continuation(c, tty))
@@ -1027,7 +1030,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 				 * This info is used to go back the correct
 				 * number of columns.
 				 */
-				while (tail != ldata->canon_head) {
+				while (MASK(tail) != MASK(ldata->canon_head)) {
 					tail--;
 					c = read_buf(ldata, tail);
 					if (c == '\t') {
@@ -1302,7 +1305,7 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 			finish_erasing(ldata);
 			echo_char(c, tty);
 			echo_char_raw('\n', ldata);
-			while (tail != ldata->read_head) {
+			while (MASK(tail) != MASK(ldata->read_head)) {
 				echo_char(read_buf(ldata, tail), tty);
 				tail++;
 			}
@@ -2411,7 +2414,7 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 	tail = ldata->read_tail;
 	nr = head - tail;
 	/* Skip EOF-chars.. */
-	while (head != tail) {
+	while (MASK(head) != MASK(tail)) {
 		if (test_bit(tail & (N_TTY_BUF_SIZE - 1), ldata->read_flags) &&
 		    read_buf(ldata, tail) == __DISABLED_CHAR)
 			nr--;
-- 
1.8.3.1
