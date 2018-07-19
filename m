Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8875EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D920652
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JA966Qz9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UKMkvVpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2D920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGSXEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:04:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbeGSXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:04:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C03560B1E; Thu, 19 Jul 2018 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532038734;
        bh=PGYF59ny5Qx8fu1sEfS/nVzeA68tRuCHlJyVezeXR2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=JA966Qz96kZ9Tc7HbuDcTNtoRR0AlsCWDt/Y+GbZJy9fhKh+A4oIKykZlHa0N3C6Q
         NfpcjdohByUOxSorAhm0AuChbUQHaCFXszLPDuOmXHYAe+/MWsW55iRBYd4BgJW6QO
         sP50IxqDxdF6p4lbFAh+kmSg02LYJ1x+gRfacQhI=
Received: from vgutta-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnkgutta@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05E1C60274;
        Thu, 19 Jul 2018 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532038733;
        bh=PGYF59ny5Qx8fu1sEfS/nVzeA68tRuCHlJyVezeXR2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=UKMkvVpEEWc2LnY6vZeqO4/0tUOKiJPiVbjlhsdXwhdcnPUWGnBvB9/3nl0+g3+oY
         YbP0NNP15P5SALlOHLrMox+D2J9jMOYlhoY06ZKnFhfOtLStukk2+k5PYqN3SyM9+2
         qUl8rP+LEleiqzDQnJMflOIv8LRwtlhbB+q0p5CE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05E1C60274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vnkgutta@codeaurora.org
From:   Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
To:     linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, hoeun.ryu@gmail.com,
        adobriyan@gmail.com, zhizhouzhang@asrmicro.com,
        suzuki.poulose@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     Abhimanyu Kapur <abhimany@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
Date:   Thu, 19 Jul 2018 15:18:46 -0700
Message-Id: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing stops a process from hotplugging in a CPU concurrently
with a sys_reboot() call. In such a situation we could have
ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
fact that the CPU is not really offline and call the
CPU_UP_PREPARE notifier. When this happens stop_machine code will
complain that the cpu thread already exists and BUG_ON().

CPU0                      CPU1

 sys_reboot()
 kernel_restart()
 machine_restart()
 machine_shutdown()
 smp_send_stop()
 ...                   ipi_cpu_stop()
		       set_cpu_online(1, false)
                       local_irq_disable()
                       while(1)
        <PREEMPT>
 cpu_up()
 _cpu_up()
 if (!cpu_online(1))
 __cpu_notify(CPU_UP_PREPARE...)

 cpu_stop_cpu_callback()
 BUG_ON(stopper->thread)

This is easily reproducible by hotplugging in and out in a tight
loop while also rebooting.

Since the CPU is not really offline and hasn't gone through the
proper steps to be marked as such, let's mark the CPU as inactive.
This is just as easily testable as online and avoids any possibility
of _cpu_up() trying to bring the CPU back online when it never was
offline to begin with. Based on the similar patchset by for arm
targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 arch/arm64/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2faa986..adee4d3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -790,7 +790,7 @@ void arch_irq_work_raise(void)
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	set_cpu_online(cpu, false);
+	set_cpu_active(cpu, false);
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
@@ -925,10 +925,10 @@ void smp_send_stop(void)
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
+	while (num_active_cpus() > 1 && timeout--)
 		udelay(1);
 
-	if (num_online_cpus() > 1)
+	if (num_active_cpus() > 1)
 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(cpu_online_mask));
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

