Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41212083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41212083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbeHWMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0955B7F6;
        Thu, 23 Aug 2018 08:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 058/324] powerpc: smp_send_stop do not offline stopped CPUs
Date:   Thu, 23 Aug 2018 09:52:04 +0200
Message-Id: <20180823074958.738028974@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit de6e5d38417e6cdb005843db420a2974993d36ff ]

Marking CPUs stopped by smp_send_stop as offline can cause warnings
due to cross-CPU wakeups. This trace was noticed on a busy system
running a sysrq+c crash test, after the injected crash:

WARNING: CPU: 51 PID: 1546 at kernel/sched/core.c:1179 set_task_cpu+0x22c/0x240
CPU: 51 PID: 1546 Comm: kworker/u352:1 Tainted: G      D
Workqueue: mlx5e mlx5e_update_stats_work [mlx5_core]
[...]
NIP [c00000000017c21c] set_task_cpu+0x22c/0x240
LR [c00000000017d580] try_to_wake_up+0x230/0x720
Call Trace:
[c000000001017700] runqueues+0x0/0xb00 (unreliable)
[c00000000017d580] try_to_wake_up+0x230/0x720
[c00000000015a214] insert_work+0x104/0x140
[c00000000015adb0] __queue_work+0x230/0x690
[c000003fc5007910] [c00000000015b26c] queue_work_on+0x5c/0x90
[c0080000135fc8f8] mlx5_cmd_exec+0x538/0xcb0 [mlx5_core]
[c008000013608fd0] mlx5_core_access_reg+0x140/0x1d0 [mlx5_core]
[c00800001362777c] mlx5e_update_pport_counters.constprop.59+0x6c/0x90 [mlx5_core]
[c008000013628868] mlx5e_update_ndo_stats+0x28/0x90 [mlx5_core]
[c008000013625558] mlx5e_update_stats_work+0x68/0xb0 [mlx5_core]
[c00000000015bcec] process_one_work+0x1bc/0x5f0
[c00000000015ecac] worker_thread+0xac/0x6b0
[c000000000168338] kthread+0x168/0x1b0
[c00000000000b628] ret_from_kernel_thread+0x5c/0xb4

This happens because firstly the CPU is not really offline in the
usual sense, processes and interrupts have not been migrated away.
Secondly smp_send_stop does not happen atomically on all CPUs, so
one CPU can have marked itself offline, while another CPU is still
running processes or interrupts which can affect the first CPU.

Fix this by just not marking the CPU as offline. It's more like
frozen in time, so offline does not really reflect its state properly
anyway. There should be nothing in the crash/panic path that walks
online CPUs and synchronously waits for them, so this change should
not introduce new hangs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/smp.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -579,9 +579,6 @@ static void nmi_stop_this_cpu(struct pt_
 	nmi_ipi_busy_count--;
 	nmi_ipi_unlock();
 
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
 	spin_begin();
 	while (1)
 		spin_cpu_relax();
@@ -596,9 +593,6 @@ void smp_send_stop(void)
 
 static void stop_this_cpu(void *dummy)
 {
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
 	hard_irq_disable();
 	spin_begin();
 	while (1)


