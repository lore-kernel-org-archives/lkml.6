Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931FAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E16217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeL2Lsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:48:51 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56855 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeL2Lsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:48:51 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBTBmnVf002411;
        Sat, 29 Dec 2018 20:48:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Sat, 29 Dec 2018 20:48:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBTBmgQU002368
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 29 Dec 2018 20:48:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
To:     Paul Fulghum <paulkf@microgate.com>, Arnd Bergmann <arnd@arndb.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <000000000000449587057e1e6f8b@google.com>
Cc:     syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
Date:   Sat, 29 Dec 2018 20:48:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <000000000000449587057e1e6f8b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting __might_sleep() warning [1], for commit 1035b63d3c6fc34a
("n_hdlc: fix read and write locking") changed to set TASK_INTERRUPTIBLE
state before calling copy_to_user(). Let's set TASK_INTERRUPTIBLE state
immediately before calling schedule().

[1] https://syzkaller.appspot.com/bug?id=17d5de7f1fcab794cb8c40032f893f52de899324

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/tty/n_hdlc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index dabb391..7835489 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -589,8 +589,6 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 		if (tty_hung_up_p(file))
 			break;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
 		if (rbuf) {
 			if (rbuf->count > nr) {
@@ -617,6 +615,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			break;
 		}
 
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 
 		if (signal_pending(current)) {
@@ -673,8 +672,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	add_wait_queue(&tty->write_wait, &wait);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-	
 		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
 		if (tbuf)
 			break;
@@ -683,6 +680,8 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			error = -EAGAIN;
 			break;
 		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
 			
 		n_hdlc = tty2n_hdlc (tty);
-- 
1.8.3.1


