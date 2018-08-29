Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5916D2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5916D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeH2QmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:42:24 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:50214 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbeH2QmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:42:24 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowACHjJBblYZbTqD_BA--.100S2;
        Wed, 29 Aug 2018 20:45:19 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        JBeulich@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 12/16] x86/xen: enable Hygon support to Xen
Date:   Wed, 29 Aug 2018 20:45:14 +0800
Message-Id: <e281da9e1b9c55747ad05a182d0517d1a9501f92.1535459013.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
X-CM-TRANSID: swCowACHjJBblYZbTqD_BA--.100S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr48XFW7ur4DAry7Ww43trb_yoW8tFy3pr
        W3AF4IqFWvqwn7X3s5X3y8XryrZw1qqa1rKrW3Ka1fXFs5Z3Z8XrWUCw1rJr1I9348ur10
        va4093WUCFZYvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUCVW8JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make Xen works functionly on Hygon platforms, reuse AMD's Xen support
code path for Hygon.

There are six core performance events counters per thread, so there are
six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
they are alias of the counters(0-3).

In this version of kernel Hygon use the lagacy and safe versions of MSR
access. It works fine when VPMU enabled in Xen on Hygon platforms by
testing with perf.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/xen/pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..9403854 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -90,6 +90,12 @@ static void xen_pmu_arch_init(void)
 			k7_counters_mirrored = 0;
 			break;
 		}
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		amd_num_counters = F10H_NUM_COUNTERS;
+		amd_counters_base = MSR_K7_PERFCTR0;
+		amd_ctrls_base = MSR_K7_EVNTSEL0;
+		amd_msr_step = 1;
+		k7_counters_mirrored = 0;
 	} else {
 		uint32_t eax, ebx, ecx, edx;
 
@@ -285,7 +291,7 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -308,7 +314,7 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -379,7 +385,7 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
-- 
2.7.4

