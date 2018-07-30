Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD641625709
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC02204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC02204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbeG3TOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:14:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeG3TOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:14:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UHbMN92388543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 10:37:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UHbM2I2388540;
        Mon, 30 Jul 2018 10:37:22 -0700
Date:   Mon, 30 Jul 2018 10:37:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-bd9f943e5d2a42d864f9692477a25034c9d47dcc@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, linux@roeck-us.net,
        tglx@linutronix.de, pasha.tatashin@oracle.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          linux@roeck-us.net, mingo@kernel.org
In-Reply-To: <20180730135252.24599-1-pasha.tatashin@oracle.com>
References: <20180730135252.24599-1-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] sched/clock: Disable interrupts when calling
 generic_sched_clock_init()
Git-Commit-ID: bd9f943e5d2a42d864f9692477a25034c9d47dcc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd9f943e5d2a42d864f9692477a25034c9d47dcc
Gitweb:     https://git.kernel.org/tip/bd9f943e5d2a42d864f9692477a25034c9d47dcc
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Mon, 30 Jul 2018 09:52:52 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:33:35 +0200

sched/clock: Disable interrupts when calling generic_sched_clock_init()

sched_clock_init() used be called early during boot when interrupts were
still disabled. After the recent changes to utilize sched clock early the
sched_clock_init() call happens when interrupts are already enabled, which
triggers the following warning:

WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:180 sched_clock_register+0x44/0x278
[<c001a13c>] (warn_slowpath_null) from [<c052367c>] (sched_clock_register+0x44/0x278)
[<c052367c>] (sched_clock_register) from [<c05238d8>] (generic_sched_clock_init+0x28/0x88)
[<c05238d8>] (generic_sched_clock_init) from [<c0521a00>] (sched_clock_init+0x54/0x74)
[<c0521a00>] (sched_clock_init) from [<c0519c18>] (start_kernel+0x310/0x3e4)
[<c0519c18>] (start_kernel) from [<00000000>] (  (null))

Disable IRQs for the duration of generic_sched_clock_init().

Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Link: https://lkml.kernel.org/r/20180730135252.24599-1-pasha.tatashin@oracle.com
---
 kernel/sched/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 811a39aca1ce..e3e3b979f9bd 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -452,7 +452,9 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 void __init sched_clock_init(void)
 {
 	static_branch_inc(&sched_clock_running);
+	local_irq_disable();
 	generic_sched_clock_init();
+	local_irq_enable();
 }
 
 u64 sched_clock_cpu(int cpu)
