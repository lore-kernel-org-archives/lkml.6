Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6635624899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6635624899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeGCHFJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:05:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754671AbeGCHFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:05:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6374rtL189888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:04:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6374raj189885;
        Tue, 3 Jul 2018 00:04:53 -0700
Date:   Tue, 3 Jul 2018 00:04:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Kuznetsov <tipbot@zytor.com>
Message-ID: <tip-4bd06060762bc7e4834ecf9daeb78834f7a29582@git.kernel.org>
Cc:     tglx@linutronix.de, kys@microsoft.com, Tianyu.Lan@microsoft.com,
        hpa@zytor.com, haiyangz@microsoft.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com, sthemmin@microsoft.com, mikelley@microsoft.com
Reply-To: hpa@zytor.com, Tianyu.Lan@microsoft.com, kys@microsoft.com,
          tglx@linutronix.de, haiyangz@microsoft.com,
          Michael.H.Kelley@microsoft.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, vkuznets@redhat.com, sthemmin@microsoft.com,
          mikelley@microsoft.com
In-Reply-To: <20180622170625.30688-4-vkuznets@redhat.com>
References: <20180622170625.30688-4-vkuznets@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall
 when possible
Git-Commit-ID: 4bd06060762bc7e4834ecf9daeb78834f7a29582
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

Commit-ID:  4bd06060762bc7e4834ecf9daeb78834f7a29582
Gitweb:     https://git.kernel.org/tip/4bd06060762bc7e4834ecf9daeb78834f7a29582
Author:     Vitaly Kuznetsov <vkuznets@redhat.com>
AuthorDate: Fri, 22 Jun 2018 19:06:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 09:00:34 +0200

x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall when possible

When there is no need to send an IPI to a CPU with VP number > 64
we can do the job with fast HVCALL_SEND_IPI hypercall.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: devel@linuxdriverproject.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Link: https://lkml.kernel.org/r/20180622170625.30688-4-vkuznets@redhat.com

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
