Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57261ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C87420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C87420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbeGWOaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:30:08 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:52032 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388260AbeGWO3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_5sl1lVbkm7cEA--.63S6;
        Mon, 23 Jul 2018 21:21:17 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 04/17] x86/smpboot: smp init nodelay and no flush caches before sleep
Date:   Mon, 23 Jul 2018 21:20:24 +0800
Message-Id: <1532352037-7151-5-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
X-CM-TRANSID: qwCowAD3_5sl1lVbkm7cEA--.63S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtry5GrWkuw4DKry7Kr4fuFg_yoWkArc_Wr
        yUCr4UZ3yFya4ava17Ww4rXr13JwsYkF4jgFyqyrWUCrWayF15Ga9FyrWqqrn3Cr4Ivrsr
        KwsIkrZ0kw4SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbq8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0
        c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2dWr
        DUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dhyana use no delay in smp_quirk_init_udelay(), and return in
mwait_play_dead() as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/smpboot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index db9656e..26cb2c9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -658,6 +658,7 @@ static void __init smp_quirk_init_udelay(void)
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
 		return;
@@ -1574,7 +1575,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
-- 
2.7.4

