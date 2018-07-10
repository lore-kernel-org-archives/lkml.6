Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17511C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E2F20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E2F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbeGJSZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:25:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbeGJSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:25:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2ABED71;
        Tue, 10 Jul 2018 18:25:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3.18 01/23] n_tty: Fix stall at n_tty_receive_char_special().
Date:   Tue, 10 Jul 2018 20:24:34 +0200
Message-Id: <20180710182308.933799891@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182308.877332304@linuxfoundation.org>
References: <20180710182308.877332304@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/n_tty.c |   13 ++++++++-----
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
@@ -2505,7 +2508,7 @@ static unsigned long inq_canon(struct n_
 	tail = ldata->read_tail;
 	nr = head - tail;
 	/* Skip EOF-chars.. */
-	while (head != tail) {
+	while (MASK(head) != MASK(tail)) {
 		if (test_bit(tail & (N_TTY_BUF_SIZE - 1), ldata->read_flags) &&
 		    read_buf(ldata, tail) == __DISABLED_CHAR)
 			nr--;


