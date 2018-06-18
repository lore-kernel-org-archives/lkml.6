Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87920874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030282AbeFRIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:38:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967158AbeFRIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0DA2C5C;
        Mon, 18 Jun 2018 08:38:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 185/189] ARM: kexec: fix kdump register saving on panic()
Date:   Mon, 18 Jun 2018 10:14:41 +0200
Message-Id: <20180618081216.651706376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 2d7b3c64431245c95b05a441669c074da10db943 ]

When a panic() occurs, the kexec code uses smp_send_stop() to stop
the other CPUs, but this results in the CPU register state not being
saved, and gdb is unable to inspect the state of other CPUs.

Commit 0ee59413c967 ("x86/panic: replace smp_send_stop() with kdump
friendly version in panic path") addressed the issue on x86, but
ignored other architectures.  Address the issue on ARM by splitting
out the crash stop implementation to crash_smp_send_stop() and
adding the necessary protection.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kernel/machine_kexec.c |   34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -95,6 +95,27 @@ void machine_crash_nonpanic_core(void *u
 		cpu_relax();
 }
 
+void crash_smp_send_stop(void)
+{
+	static int cpus_stopped;
+	unsigned long msecs;
+
+	if (cpus_stopped)
+		return;
+
+	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	msecs = 1000; /* Wait at most a second for the other cpus to stop */
+	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
+		mdelay(1);
+		msecs--;
+	}
+	if (atomic_read(&waiting_for_crash_ipi) > 0)
+		pr_warn("Non-crashing CPUs did not react to IPI\n");
+
+	cpus_stopped = 1;
+}
+
 static void machine_kexec_mask_interrupts(void)
 {
 	unsigned int i;
@@ -120,19 +141,8 @@ static void machine_kexec_mask_interrupt
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
-	unsigned long msecs;
-
 	local_irq_disable();
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
-	msecs = 1000; /* Wait at most a second for the other cpus to stop */
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
-		mdelay(1);
-		msecs--;
-	}
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("Non-crashing CPUs did not react to IPI\n");
+	crash_smp_send_stop();
 
 	crash_save_cpu(regs, smp_processor_id());
 	machine_kexec_mask_interrupts();


