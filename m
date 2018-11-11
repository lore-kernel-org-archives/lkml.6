Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE46C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4822080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4822080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbeKLF77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:59:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbeKLF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:59:59 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsv-0000l7-BH; Sun, 11 Nov 2018 19:59:05 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001eR-TA; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Peter Hurley" <peter@hurleysoftware.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "syzbot" <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.992181520@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 209/366] n_tty: Fix stall at n_tty_receive_char_special().
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 3d63b7e4ae0dc5e02d28ddd2fa1f945defc68d81 upstream.

syzbot is reporting stalls at n_tty_receive_char_special() [1]. This is
because comparison is not working as expected since ldata->read_head can
change at any moment. Mitigate this by explicitly masking with buffer size
when checking condition for "while" loops.

[1] https://syzkaller.appspot.com/bug?id=3d7481a346958d9469bebbeb0537d5f056bdd6e8

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
Fixes: bc5a5e3f45d04784 ("n_tty: Don't wrap input buffer indices at buffer size")
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/n_tty.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -127,6 +127,8 @@ struct n_tty_data {
 	struct mutex output_lock;
 };
 
+#define MASK(x) ((x) & (N_TTY_BUF_SIZE - 1))
+
 static inline size_t read_cnt(struct n_tty_data *ldata)
 {
 	return ldata->read_head - ldata->read_tail;
@@ -1032,14 +1034,15 @@ static void eraser(unsigned char c, stru
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
@@ -1081,7 +1084,7 @@ static void eraser(unsigned char c, stru
 				 * This info is used to go back the correct
 				 * number of columns.
 				 */
-				while (tail != ldata->canon_head) {
+				while (MASK(tail) != MASK(ldata->canon_head)) {
 					tail--;
 					c = read_buf(ldata, tail);
 					if (c == '\t') {
@@ -1341,7 +1344,7 @@ n_tty_receive_char_special(struct tty_st
 			finish_erasing(ldata);
 			echo_char(c, tty);
 			echo_char_raw('\n', ldata);
-			while (tail != ldata->read_head) {
+			while (MASK(tail) != MASK(ldata->read_head)) {
 				echo_char(read_buf(ldata, tail), tty);
 				tail++;
 			}
@@ -2506,7 +2509,7 @@ static unsigned long inq_canon(struct n_
 	tail = ldata->read_tail;
 	nr = head - tail;
 	/* Skip EOF-chars.. */
-	while (head != tail) {
+	while (MASK(head) != MASK(tail)) {
 		if (test_bit(tail & (N_TTY_BUF_SIZE - 1), ldata->read_flags) &&
 		    read_buf(ldata, tail) == __DISABLED_CHAR)
 			nr--;

