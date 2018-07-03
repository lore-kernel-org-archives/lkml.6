Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7FF2175A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7FF2175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeGCWhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:37:48 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:52108
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753302AbeGCWhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:37:46 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id aTuefI7Fa8JHPaTuefnWwp; Tue, 03 Jul 2018 15:36:45 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1faTue-00015z-5d; Tue, 03 Jul 2018 15:36:44 -0700
From:   kys@linuxonhyperv.com
To:     x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] X86: Fix the circular dependency in IPI enlightenment.
Date:   Tue,  3 Jul 2018 15:36:41 -0700
Message-Id: <20180703223641.4171-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfLx+Jk9rU/Gyw2WXQ9kJe1OTtzSeS7nF/9LjmFtNTC60yyzB7EvxnwUO7biL05paZ8YtbXyzUH/RwU9byaZe3QflQB8XacA/rHBbe23Gp6FHBkwd0QhG
 tceScMvkSAS58JCDN1XOmUIjlEBBEdd58jpism/pBJ0LOLfHCGOx+xEDXm8JkcKJ+JwXzY1D2m3Yr8VpC3nJffEMOYd6wTptlM/u9v6dDpfRDNmCXma1vb97
 FBMPzGnjbDTEdCCpUfYz4xZT4DtDHJFbLNXeJ019nuX8BCABcFi8Fw4ZQsMVa0fOv1N6Wv0Mr9vKWUfYGCCHzjdY/VzVPp22EqtYiXD9jX/xg0ZF8ZE/7HLQ
 hmS3qRUv2MOlxwl8WN7lBjj0Iho+QUB9lUk5tr7z+TtzUAUqJiJItcgCXi82ddSRXajVyn/MxKb+dhS/oQvTN+/9ipJ7W1fiOPRjt60T2hdQ1LUoaOq3FMVB
 RDKLdU+QkfWSTBVlgR8iAxsfF9Dzqdprtuj60Z+6VT0o7cXlMIDgEF+RQI1hJcP3iSe5YmSN2lBdZx6UnDDfWFfIrbdvag+ir382jxFgfJay56jMcDzvtRL8
 MQujl9QYB8EY78egpyRF0sSc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

The IPI hypercalls depend on being able to map the Linux notion of CPU ID
to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provides
this mapping. Code for populating this array depends on the IPI functionality.
Break this circular dependency.

Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c       | 5 +++++
 arch/x86/hyperv/hv_init.c       | 3 +++
 arch/x86/include/asm/mshyperv.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f68855499391..63d7c196739f 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -114,6 +114,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
 	}
+	if (nr_bank == -1)
+		goto ipi_mask_ex_done;
 	if (!nr_bank)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 
@@ -158,6 +160,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		if (vcpu == -1)
+			goto ipi_mask_done;
+
 		/*
 		 * This particular version of the IPI hypercall can
 		 * only target upto 64 CPUs.
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 595e44e8abaa..762ce164d733 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -293,6 +293,9 @@ void __init hyperv_init(void)
 	if (!hv_vp_index)
 		return;
 
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = -1;
+
 	hv_vp_assist_page = kcalloc(num_possible_cpus(),
 				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
 	if (!hv_vp_assist_page) {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 81e768b8d9eb..299de3dcc319 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -285,6 +285,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	 */
 	for_each_cpu(cpu, cpus) {
 		vcpu = hv_cpu_number_to_vp_number(cpu);
+		if (vcpu == -1)
+			return -1;
 		vcpu_bank = vcpu / 64;
 		vcpu_offset = vcpu % 64;
 		__set_bit(vcpu_offset, (unsigned long *)
-- 
2.17.1

