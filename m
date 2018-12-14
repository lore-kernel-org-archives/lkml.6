Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABFA20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790543;
	bh=q3UXguVpNniudnn2cTofTtFHl8QeKdth9T/kDQEDu+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3dMJKChe6OSoMA1P8hfLUtoFtTuVrNX9EArDnbHtnEEJ+rFn3F5Ng0/acEMVtczt
	 qr3oJxReNiLpobj3RUnGQqXXZ5HHRJ5zXbSnZ6dlOsokTxwYoWAj4G6gijUrIu4YoL
	 O76iDPXc3Yq3n9WVRCN4+Ur1NgqxTWG/pvomqvdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABFA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeLNM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:29:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbeLNMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E063214F1;
        Fri, 14 Dec 2018 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789438;
        bh=q3UXguVpNniudnn2cTofTtFHl8QeKdth9T/kDQEDu+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B7jMzzfCN829ylkvGQkGkbfNDHAhPkC/edqjc0+TEU7mTYZseBbqVuRCrvACUHT/N
         um0mLZxhODLQY3q+fO9/gAxm6U26Lw8PLKt1KJHu6kZZp7Hrh7O2af/VQwBk0FF0JI
         ePwIkMuZBqSP3L0oK/IXVNnh6lo++Ot08F+0EaGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 83/89] printk: Wake klogd when passing console_lock owner
Date:   Fri, 14 Dec 2018 13:00:36 +0100
Message-Id: <20181214115733.788949088@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c14376de3a1befa70d9811ca2872d47367b48767 ]

wake_klogd is a local variable in console_unlock(). The information
is lost when the console_lock owner using the busy wait added by
the commit dbdda842fe96f8932 ("printk: Add console owner and waiter
logic to load balance console writes"). The following race is
possible:

CPU0				CPU1
console_unlock()

  for (;;)
     /* calling console for last message */

				printk()
				  log_store()
				    log_next_seq++;

     /* see new message */
     if (seen_seq != log_next_seq) {
	wake_klogd = true;
	seen_seq = log_next_seq;
     }

     console_lock_spinning_enable();

				  if (console_trylock_spinning())
				     /* spinning */

     if (console_lock_spinning_disable_and_check()) {
	printk_safe_exit_irqrestore(flags);
	return;

				  console_unlock()
				    if (seen_seq != log_next_seq) {
				    /* already seen */
				    /* nothing to do */

Result: Nobody would wakeup klogd.

One solution would be to make a global variable from wake_klogd.
But then we would need to manipulate it under a lock or so.

This patch wakes klogd also when console_lock is passed to the
spinning waiter. It looks like the right way to go. Also userspace
should have a chance to see and store any "flood" of messages.

Note that the very late klogd wake up was a historic solution.
It made sense on single CPU systems or when sys_syslog() operations
were synchronized using the big kernel lock like in v2.1.113.
But it is questionable these days.

Fixes: dbdda842fe96f8932 ("printk: Add console owner and waiter logic to load balance console writes")
Link: http://lkml.kernel.org/r/20180226155734.dzwg3aovqnwtvkoy@pathway.suse.cz
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f654a79f80b..2e2c86dd226f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2393,7 +2393,7 @@ void console_unlock(void)
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
-			return;
+			goto out;
 		}
 
 		printk_safe_exit_irqrestore(flags);
@@ -2426,6 +2426,7 @@ void console_unlock(void)
 	if (retry && console_trylock())
 		goto again;
 
+out:
 	if (wake_klogd)
 		wake_up_klogd();
 }
-- 
2.19.1



