Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCB0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A972154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A972154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390017AbeHNU3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:29:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbeHNU3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:29:53 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD1F2D20;
        Tue, 14 Aug 2018 17:41:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 048/107] x86/cpu/AMD: Evaluate smp_num_siblings early
Date:   Tue, 14 Aug 2018 19:17:11 +0200
Message-Id: <20180814171524.179842469@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 1e1d7e25fd759eddf96d8ab39d0a90a1979b2d8c upstream

To support force disabling of SMT it's required to know the number of
thread siblings early. amd_get_topology() cannot be called before the APIC
driver is selected, so split out the part which initializes
smp_num_siblings and invoke it from amd_early_init().

[dwmw2: Backport to 4.9]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -296,13 +296,24 @@ static int nearby_node(int apicid)
 }
 #endif
 
+#ifdef CONFIG_SMP
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
  *     Assumption: Number of cores in each internal node is the same.
  * (2) AMD processors supporting compute units
  */
-#ifdef CONFIG_SMP
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
 	u8 node_id;
@@ -633,6 +644,8 @@ static void early_init_amd(struct cpuinf
 	 */
 	if (cpu_has_amd_erratum(c, amd_erratum_400))
 		set_cpu_bug(c, X86_BUG_AMD_E400);
+
+	amd_get_topology_early(c);
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)


