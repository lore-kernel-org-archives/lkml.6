Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1207AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0F520659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gzK59faK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cbQUxP+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0F520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIEVgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:36:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIEVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:36:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58A586055B; Wed,  5 Sep 2018 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536167140;
        bh=ORwigBhk9ORTEIFTAiwrKaT8y+a8beEcrOssARsyHK4=;
        h=From:To:Cc:Subject:Date:From;
        b=gzK59faKJzGo7sK87MZ5J5R5vSqs54hy9Yjf9aP0TsiO9SdQvFDHTVk+jwVOVWWLV
         v4KLiMyM5wcK73ESBqMysf3nkJiTh69Vply8HIBuhEgKwIRIBseuV3OLRpgz8VMvm0
         v3zPf8oKqSLqfsO2JX+492H7DGxmpo5SoyBLWSw0=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92A7E601D9;
        Wed,  5 Sep 2018 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536167139;
        bh=ORwigBhk9ORTEIFTAiwrKaT8y+a8beEcrOssARsyHK4=;
        h=From:To:Cc:Subject:Date:From;
        b=cbQUxP+s+t8mwu7bCYv0AsLsvtUyX2IE3hONrv46p6AD+64E2Ke+ovdSRnPDJz5MF
         kYMSk8xbKr7ecCzh3s85teBmmywxIItyTMWMFLoOidi8YITrRDkHQC3vY8yZSgMGMv
         p4+fjaSbGuhthms0CU1za7WZ2YeAX33BrPG3UNbg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92A7E601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] genirq: Avoid race between cpu hot plug and irq_desc() allocation paths
Date:   Wed,  5 Sep 2018 10:05:31 -0700
Message-Id: <1536167131-20585-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the cores might have just allocated irq_desc() and other core
might be doing irq migration in the hot plug path. In the hot plug path
during the IRQ migration, for_each_active_irq macro is trying to get
irqs whose bits are set in allocated_irqs bit map but there is no return
value check after irq_to_desc for desc validity.

[   24.566381] msm_thermal:do_core_control Set Offline: CPU4 Temp: 73
[   24.568821] Unable to handle kernel NULL pointer dereference at virtual address 000000a4
[   24.568931] pgd = ffffffc002184000
[   24.568995] [000000a4] *pgd=0000000178df5003, *pud=0000000178df5003, *pmd=0000000178df6003, *pte=0060000017a00707
[   24.569153] ------------[ cut here ]------------
[   24.569228] Kernel BUG at ffffffc0000f3060 [verbose debug info unavailable]
[   24.569334] Internal error: Oops - BUG: 96000005 [#1] PREEMPT SMP
[   24.569422] Modules linked in:
[   24.569486] CPU: 4 PID: 28 Comm: migration/4 Tainted: G        W       4.4.8-perf-9407222-eng #1
[   24.569684] task: ffffffc0f28f0e80 ti: ffffffc0f2a84000 task.ti: ffffffc0f2a84000
[   24.569785] PC is at do_raw_spin_lock+0x20/0x160
[   24.569859] LR is at _raw_spin_lock+0x34/0x40
[   24.569931] pc : [<ffffffc0000f3060>] lr : [<ffffffc001023dec>] pstate: 200001c5
[   24.570029] sp : ffffffc0f2a87bc0
[   24.570091] x29: ffffffc0f2a87bc0 x28: ffffffc001033988
[   24.570174] x27: ffffffc001adebb0 x26: 0000000000000000
[   24.570257] x25: 00000000000000a0 x24: 0000000000000020
[   24.570339] x23: ffffffc001033978 x22: ffffffc001adeb80
[   24.570421] x21: 000000000000027e x20: 0000000000000000
[   24.570502] x19: 00000000000000a0 x18: 000000000000000d
[   24.570584] x17: 0000000000005f00 x16: 0000000000000003
[   24.570666] x15: 000000000000bd39 x14: 0ffffffffffffffe
[   24.570748] x13: 0000000000000000 x12: 0000000000000018
[   24.570829] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[   24.570911] x9 : fefefefeff332e6d x8 : 7f7f7f7f7f7f7f7f
[   24.570993] x7 : ffffffc00344f6a0 x6 : 0000000000000000
[   24.571075] x5 : 0000000000000001 x4 : ffffffc00344f488
[   24.571157] x3 : 0000000000000000 x2 : 0000000000000000
[   24.571238] x1 : ffffffc0f2a84000 x0 : 0000000000004ead
...
...
...
[   24.581324] Call trace:
[   24.581379] [<ffffffc0000f3060>] do_raw_spin_lock+0x20/0x160
[   24.581463] [<ffffffc001023dec>] _raw_spin_lock+0x34/0x40
[   24.581546] [<ffffffc000103f10>] irq_migrate_all_off_this_cpu+0x84/0x1c4
[   24.581641] [<ffffffc00008ec84>] __cpu_disable+0x54/0x74
[   24.581722] [<ffffffc0000a3368>] take_cpu_down+0x1c/0x58
[   24.581803] [<ffffffc00013ac08>] multi_cpu_stop+0xb0/0x10c
[   24.581885] [<ffffffc00013ad60>] cpu_stopper_thread+0xb8/0x184
[   24.581972] [<ffffffc0000c4920>] smpboot_thread_fn+0x26c/0x290
[   24.582057] [<ffffffc0000c0f84>] kthread+0x100/0x108
[   24.582135] Code: aa0003f3 aa1e03e0 d503201f 5289d5a0 (b9400661)
[   24.582224] ---[ end trace 609f38584306f5d9 ]---

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 kernel/irq/cpuhotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 5b1072e..17c5e71 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -160,6 +160,9 @@ void irq_migrate_all_off_this_cpu(void)
 		bool affinity_broken;
 
 		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
 		raw_spin_lock(&desc->lock);
 		affinity_broken = migrate_one_irq(desc);
 		raw_spin_unlock(&desc->lock);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

