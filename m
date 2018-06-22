Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E21E2466C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21E2466C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeFVRGi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:06:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754633AbeFVRGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62992406E8C4;
        Fri, 22 Jun 2018 17:06:34 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A68561C59F;
        Fri, 22 Jun 2018 17:06:32 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH 3/4] x86/hyper-v: use cheaper HVCALL_SEND_IPI hypercall when possible
Date:   Fri, 22 Jun 2018 19:06:24 +0200
Message-Id: <20180622170625.30688-4-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-1-vkuznets@redhat.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:34 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no need to send an IPI to a CPU with VP number > 64
we can do the job with fast HVCALL_SEND_IPI hypercall.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 90055f89223b..ee962784d25b 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -99,6 +99,9 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 	int nr_bank = 0;
 	int ret = 1;
 
+	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return false;
+
 	local_irq_save(flags);
 	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
@@ -140,8 +143,18 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
 
-	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		return __send_ipi_mask_ex(mask, vector);
+	/*
+	 * From the supplied CPU set we need to figure out if we can get away
+	 * with cheaper HVCALL_SEND_IPI hypercall. This is possible when the
+	 * highest VP number in the set is < 64. As VP numbers are usually in
+	 * ascending order and match Linux CPU ids, here is an optimization:
+	 * we check the VP number for the highest bit in the supplied set first
+	 * so we can quickly find out if using HVCALL_SEND_IPI_EX hypercall is
+	 * a must. We will also check all VP numbers when walking the supplied
+	 * CPU set to remain correct in all cases.
+	 */
+	if (hv_cpu_number_to_vp_number(cpumask_last(mask)) >= 64)
+		goto do_ex_hypercall;
 
 	ipi_arg.vector = vector;
 	ipi_arg.cpu_mask = 0;
@@ -153,16 +166,17 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		 * only target upto 64 CPUs.
 		 */
 		if (vcpu >= 64)
-			goto ipi_mask_done;
+			goto do_ex_hypercall;
 
 		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
 	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
 				     ipi_arg.cpu_mask);
-
-ipi_mask_done:
 	return ((ret == 0) ? true : false);
+
+do_ex_hypercall:
+	return __send_ipi_mask_ex(mask, vector);
 }
 
 static bool __send_ipi_one(int cpu, int vector)
@@ -218,10 +232,7 @@ static void hv_send_ipi_self(int vector)
 void __init hv_apic_init(void)
 {
 	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
-		if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-			pr_info("Hyper-V: Using ext hypercalls for IPI\n");
-		else
-			pr_info("Hyper-V: Using IPI hypercalls\n");
+		pr_info("Hyper-V: Using IPI hypercalls\n");
 		/*
 		 * Set the IPI entry points.
 		 */
-- 
2.14.4

