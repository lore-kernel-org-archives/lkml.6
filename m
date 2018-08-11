Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C6C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CA72173C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CA72173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeHKQEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:04:02 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:42043 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbeHKQEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:04:02 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAB3fZG35G5b56JfAA--.772S2;
        Sat, 11 Aug 2018 21:29:31 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        JBeulich@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
Date:   Sat, 11 Aug 2018 21:29:24 +0800
Message-Id: <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
X-CM-TRANSID: swCowAB3fZG35G5b56JfAA--.772S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1fKF43tFWDZryfJr1UWrg_yoW8Zw45p3
        y3AF40qrsYq3Z7Xas5XrW8XrWrZr1vqan5GrZxJ3WftF4rZ3Z8XrWjyw1Fqw10934kur40
        qa48Gw4Dua9avFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUD-B_UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make Xen work correctly on Hygon platforms, reuse AMD's Xen support
code path and add vendor check for Hygon along with AMD.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/xen/pmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..1053dda 100644
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
 
@@ -285,7 +291,8 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -308,7 +315,8 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -379,7 +387,8 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
-- 
2.7.4

