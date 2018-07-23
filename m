Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFD5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1E320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1E320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGWO3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:52042 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388097AbeGWO3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:34 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_5sl1lVbkm7cEA--.63S7;
        Mon, 23 Jul 2018 21:21:18 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 05/17] x86/perfctr: return perf counter and event selection bit offset
Date:   Mon, 23 Jul 2018 21:20:25 +0800
Message-Id: <1532352037-7151-6-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
X-CM-TRANSID: qwCowAD3_5sl1lVbkm7cEA--.63S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DWrW7CF48Jr1xCrWktFb_yoW8XF48pr
        W2y3yfXwnFga1UCa45trZYk3y3uFyxK3yrAr45KFZ7Z3Z0qFySgr10kw4jqrW0qryF9r1U
        t3yxAr48Gw4kAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWx
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tr
        W5UUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon Dhyana shares similar perfctr arch with AMD family 17h.
It returns the bit offset of the performance counter register and the
event selection register for Hygon CPU in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083..df46708 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -50,6 +50,10 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
 		return msr - MSR_K7_PERFCTR0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTR)
+			return (msr - MSR_F15H_PERF_CTR) >> 1;
+		return msr - MSR_K7_PERFCTR0;
 	case X86_VENDOR_INTEL:
 		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
 			return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -78,6 +82,10 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
 		return msr - MSR_K7_EVNTSEL0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTL)
+			return (msr - MSR_F15H_PERF_CTL) >> 1;
+		return msr - MSR_K7_EVNTSEL0;
 	case X86_VENDOR_INTEL:
 		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
 			return msr - MSR_ARCH_PERFMON_EVENTSEL0;
-- 
2.7.4

