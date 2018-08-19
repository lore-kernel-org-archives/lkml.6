Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA145C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E6120836
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeHSTXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:23:40 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:49609 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbeHSTXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:23:40 -0400
Received: from localhost.localdomain (unknown [110.184.154.248])
        by APP-10 (Coremail) with SMTP id tACowACncu2wlnlbSKKwAg--.30S2;
        Mon, 20 Aug 2018 00:11:33 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 08/16] x86/apic: add modern APIC support for Hygon
Date:   Mon, 20 Aug 2018 00:11:20 +0800
Message-Id: <f101bee8ecd654963be0f76baeabc669c40752df.1534599097.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
X-CM-TRANSID: tACowACncu2wlnlbSKKwAg--.30S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr45JF1UuFyrXr4rKFy7trb_yoW8tFyxpr
        WUJF4rJFnYqas3Xas7trWxXryUZwn2ga13Gw43Jw1fJFWYvr17Xrs2vw1Sk34j9rZ5Cr18
        tw4UXa1YvayUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAF
        wI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf
        9x0JUD-B_UUUUU=
X-Originating-IP: [110.184.154.248]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon processors use modern APIC, so just return in modern_apic() and
sync_Arb_IDs(). And should break in switch case in detect_init_API().

When running on 32 bit mode, should set bigsmp if there are more than
8 cores.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/apic/apic.c     | 19 ++++++++++++++-----
 arch/x86/kernel/apic/probe_32.c |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 3b3a2d0..9480ffa 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -220,10 +220,15 @@ static inline int lapic_is_integrated(void)
  */
 static int modern_apic(void)
 {
-	/* AMD systems use old APIC versions, so check the CPU */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-	    boot_cpu_data.x86 >= 0xf)
+	/*
+	 * Old AMD systems use old APIC versions, newer AMD systems
+	 * and Hygon systems use modern APIC, so check the CPU
+	 */
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	     boot_cpu_data.x86 >= 0xf) ||
+	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return 1;
+
 	return lapic_get_version() >= 0x14;
 }
 
@@ -1211,9 +1216,11 @@ void __init sync_Arb_IDs(void)
 {
 	/*
 	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
-	 * needed on AMD.
+	 * needed on AMD or Hygon.
 	 */
-	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (modern_apic() ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 
 	/*
@@ -1912,6 +1919,8 @@ static int __init detect_init_APIC(void)
 		    (boot_cpu_data.x86 >= 15))
 			break;
 		goto no_apic;
+	case X86_VENDOR_HYGON:
+		break;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 02e8acb..47ff297 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -185,6 +185,7 @@ void __init default_setup_apic_routing(void)
 				break;
 			}
 			/* If P4 and above fall through */
+		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
 		}
-- 
2.7.4

