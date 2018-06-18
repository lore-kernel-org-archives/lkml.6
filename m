Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400DCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035B0208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B0208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934822AbeFRORC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:17:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934145AbeFRORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:17:00 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LrZ6L-1gDclJ05O9-013LNL; Mon, 18 Jun 2018 16:16:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Cox <alan@linux.intel.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Sahara <keun-o.park@darkmatter.ae>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: use 64-bit timstamp
Date:   Mon, 18 Jun 2018 16:16:26 +0200
Message-Id: <20180618141633.3303890-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:KocDYRy2ZdPfG7BCzXoSC6GfmwSZeMpsuurpdIXIYvKytCmuY4m
 Di8sGKdN6jFg2mOxok9z5YFIeHupJgS85jvfbblJV3FqSGuGdcQ0S7/OklGbz47OEzi0GoL
 k559Nt0L0/WQw/FyfQx2ArBW2v2zzNAS7Ym5BP/KJtjngNggPvNonVuEYqEwmJ3jh/CqRPC
 PYJdTgRj/ovsF2IfP3cig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qJTfk6KjIUI=:n9C8WwlOg70+waMp6DFEcq
 2CugvxVNws8OhHMuDRVKEHBUm0cNh7MaeQhTxF72wTxWduowCuWxOin6ASZhvCUTVdXH1I6gg
 BTEGWwGBfLSS9oS+auppk4TrOglx7z3a3Hk9awKaIP6Fh/4nwrI1ebesMrRH7FPktxbJ1S514
 7goqwJCm2MZnL8ZWkZY2A3rAVz0FoheqtYMDahctFRk0XIjxbUlRSpfp535qYpko63rvUCAin
 BxXt/Oiw3Fe15KzDbuxcXODk2tAAZyq0kbNUrfTzn0bwBl9x6MQIh/leM5fYQNWdY51nUOauN
 zzximhWguJJ3H/DLoOs2Sh+jLgJ24OTl03ZulIEHYXd3beooLHbwuv9Zjzibrg5J5lOCWReDT
 gcmr1ozC8niAMP8BSiBRFAAp7cYom5Ys6ygwytDOzvCPYBlMNMbJWl7qR1NQ6XyidHqGuAwXO
 7Iw0vV5bLXQXjizdmOSrZM+PD7LDc24YdaYVqD0V3jx1uLNpj8WvYHDblv8G6rFkkSyg77sJ3
 SvXjSKCxkq8M8ZQO54lPbzDH5B6hFYD4erQ73P+YoXC3CWhMO6B4SS1ZmeHA+B5AItzxX831j
 M6oL3fZA95ViLSQ6o7ysVIEXgOWG0t71xLTJOE5xOfEfXQ3Ke7gMbvWmuuXUkf9MStPDt5FZU
 /0ZA4VPekwZi739NLdpBJSn+knVvT9jHF6QVqw49m17kXW8vhphjY7oyK8hfrkc7v2kY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automated VFS conversion to timespec64 has left one caller of
the deprecated get_seconds() function in the tty driver, this cleans
it up to call ktime_get_real_seconds() instead, fixing the possible
overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/tty_io.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index aba59521ad48..11c2df904ac9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -814,9 +814,9 @@ void start_tty(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(start_tty);
 
-static void tty_update_time(struct timespec *time)
+static void tty_update_time(struct timespec64 *time)
 {
-	unsigned long sec = get_seconds();
+	time64_t sec = ktime_get_real_seconds();
 
 	/*
 	 * We only care if the two values differ in anything other than the
@@ -867,13 +867,8 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 		i = -EIO;
 	tty_ldisc_deref(ld);
 
-	if (i > 0) {
-		struct timespec ts;
-
-		ts = timespec64_to_timespec(inode->i_atime);
-		tty_update_time(&ts);
-		inode->i_atime = timespec_to_timespec64(ts);
-	}
+	if (i > 0)
+		tty_update_time(&inode->i_atime);
 
 	return i;
 }
@@ -974,11 +969,7 @@ static inline ssize_t do_tty_write(
 		cond_resched();
 	}
 	if (written) {
-		struct timespec ts;
-
-		ts = timespec64_to_timespec(file_inode(file)->i_mtime);
-		tty_update_time(&ts);
-		file_inode(file)->i_mtime = timespec_to_timespec64(ts);
+		tty_update_time(&file_inode(file)->i_mtime);
 		ret = written;
 	}
 out:
-- 
2.9.0

