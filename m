Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2C221727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C221727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbeHNUXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:23:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbeHNUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:23:47 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A42EDDE;
        Tue, 14 Aug 2018 17:35:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 047/104] x86/cpu/AMD: Evaluate smp_num_siblings early
Date:   Tue, 14 Aug 2018 19:17:01 +0200
Message-Id: <20180814171518.389138668@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1e1d7e25fd759eddf96d8ab39d0a90a1979b2d8c upstream

To support force disabling of SMT it's required to know the number of
thread siblings early. amd_get_topology() cannot be called before the APIC
driver is selected, so split out the part which initializes
smp_num_siblings and invoke it from amd_early_init().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -315,6 +315,17 @@ static void legacy_fixup_core_id(struct
 	c->cpu_core_id %= cus_per_node;
 }
 
+
+static void amd_get_topology_early(struct cpuinfo_x86 *c)
+{
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
+		smp_num_siblings = ((ebx >> 8) & 0xff) + 1;
+	}
+}
+
 /*
  * Fixup core topology information for
  * (1) AMD multi-node processors
@@ -668,6 +679,8 @@ static void early_init_amd(struct cpuinf
 			clear_cpu_cap(c, X86_FEATURE_SME);
 		}
 	}
+
+	amd_get_topology_early(c);
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)


