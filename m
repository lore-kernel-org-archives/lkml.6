Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B3CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DC320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DC320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405746AbeHATIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405273AbeHATId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0ACD1369;
        Wed,  1 Aug 2018 17:13:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 041/246] printk: drop in_nmi check from printk_safe_flush_on_panic()
Date:   Wed,  1 Aug 2018 18:49:11 +0200
Message-Id: <20180801165013.685247499@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

[ Upstream commit 554755be08fba31c74f66b82a485e5513205af84 ]

Drop the in_nmi() check from printk_safe_flush_on_panic()
and attempt to re-init (IOW unlock) locked logbuf spinlock
from panic CPU regardless of its context.

Otherwise, theoretically, we can deadlock on logbuf trying to flush
per-CPU buffers:

  a) Panic CPU is running in non-NMI context
  b) Panic CPU sends out shutdown IPI via reboot vector
  c) Panic CPU fails to stop all remote CPUs
  d) Panic CPU sends out shutdown IPI via NMI vector
     One of the CPUs that we bring down via NMI vector can hold
     logbuf spin lock (theoretically).

Link: http://lkml.kernel.org/r/20180530070350.10131-1-sergey.senozhatsky@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/printk_safe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -284,7 +284,7 @@ void printk_safe_flush_on_panic(void)
 	 * Make sure that we could access the main ring buffer.
 	 * Do not risk a double release when more CPUs are up.
 	 */
-	if (in_nmi() && raw_spin_is_locked(&logbuf_lock)) {
+	if (raw_spin_is_locked(&logbuf_lock)) {
 		if (num_online_cpus() > 1)
 			return;
 


