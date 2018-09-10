Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD29A206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD29A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIJSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:11:46 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:52135 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIJSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:11:46 -0400
Received: from pw-vbox.higon.com (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowACXnMTobpZbxQWaCQ--.1741S2;
        Mon, 10 Sep 2018 21:17:32 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH v6 08/16] x86/apic: Add Hygon Dhyana support to APIC
Date:   Mon, 10 Sep 2018 21:17:27 +0800
Message-Id: <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536550549.git.puwen@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
X-CM-TRANSID: tACowACXnMTobpZbxQWaCQ--.1741S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW8AFyxXrWUJw1UXFy8Grg_yoW8Cw13pr
        W5JF4kJFn0qas3Xas7trZ7XrWUZ3Z2ga1fGw43Cw1fJFWYvr17Xrs2vw1Sk34jgrZ3Cr1r
        ta1DXa1YvayUAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbKLvtUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Hygon Dhyana support to the APIC subsystem as it use modern APIC.
When running on 32 bit mode, bigsmp should be enabled if there are
more than 8 cores online.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/apic/apic.c     | 13 +++++++++++--
 arch/x86/kernel/apic/probe_32.c |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84132ed..709daf2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -224,6 +224,11 @@ static int modern_apic(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 >= 0xf)
 		return 1;
+
+	/* Hygon systems use modern APIC */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return 1;
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

