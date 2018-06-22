Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C092C24665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C092C24665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933945AbeFVRHs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:07:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754677AbeFVRGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F0E1406E81E;
        Fri, 22 Jun 2018 17:06:32 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3AD71C59F;
        Fri, 22 Jun 2018 17:06:30 +0000 (UTC)
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
Subject: [PATCH 2/4] x86/hyper-v: use 'fast' hypercall for HVCALL_SEND_IPI
Date:   Fri, 22 Jun 2018 19:06:23 +0200
Message-Id: <20180622170625.30688-3-vkuznets@redhat.com>
In-Reply-To: <20180622170625.30688-1-vkuznets@redhat.com>
References: <20180622170625.30688-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 22 Jun 2018 17:06:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current Hyper-V TLFS (v5.0b) claims that HvCallSendSyntheticClusterIpi
hypercall can't be 'fast' (passing parameters through registers) but
apparently this is not true, Windows always uses 'fast' version. We can
do the same in Linux too.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f68855499391..90055f89223b 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -128,10 +128,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	int cur_cpu, vcpu;
-	struct ipi_arg_non_ex **arg;
-	struct ipi_arg_non_ex *ipi_arg;
+	struct ipi_arg_non_ex ipi_arg;
 	int ret = 1;
-	unsigned long flags;
 
 	if (cpumask_empty(mask))
 		return true;
@@ -145,16 +143,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return __send_ipi_mask_ex(mask, vector);
 
-	local_irq_save(flags);
-	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	ipi_arg = *arg;
-	if (unlikely(!ipi_arg))
-		goto ipi_mask_done;
-
-	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->cpu_mask = 0;
+	ipi_arg.vector = vector;
+	ipi_arg.cpu_mask = 0;
 
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
@@ -165,13 +155,13 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 		if (vcpu >= 64)
 			goto ipi_mask_done;
 
-		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
+		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
 	}
 
-	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
+	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
+				     ipi_arg.cpu_mask);
 
 ipi_mask_done:
-	local_irq_restore(flags);
 	return ((ret == 0) ? true : false);
 }
 
-- 
2.14.4

