Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B239ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79A214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC79A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeIQTBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:01:09 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:59915 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbeIQTBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:01:08 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowADXsxwmrZ9b79OlCg--.313S2;
        Mon, 17 Sep 2018 21:33:32 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 12/16] x86/xen: Add Hygon Dhyana support to Xen
Date:   Mon, 17 Sep 2018 21:33:23 +0800
Message-Id: <442c514034790d4f6b8b743769114be6d48b3094.1537182523.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
X-CM-TRANSID: swCowADXsxwmrZ9b79OlCg--.313S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryftF1ftw1fKFyfJF1fZwb_yoW8tFW7pr
        W3AF4IqFWvqwn7X3s5X3yxXryrZw1qqa15KrZxKa1fXa1rZ3Z8XrWjk3WrXr1fu348ur10
        va40ga1UCFZYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make Xen works functionally on Hygon platform, reuse AMD's Xen
support code path for Hygon Dhyana CPU.

There are six core performance events counters per thread, so there are
six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
they are alias of the counters(0-3).

In this version of kernel Hygon use the legacy and safe version of MSR
access. It works fine when VPMU enabled in Xen on Hygon platform by
testing with perf.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

