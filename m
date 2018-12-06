Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F2FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A88120989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A88120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeLFH2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:28:40 -0500
Received: from [110.188.70.11] ([110.188.70.11]:4831 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbeLFH2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:28:40 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id wB67QXuM043280;
        Thu, 6 Dec 2018 15:26:33 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id wB67QMKj095378;
        Thu, 6 Dec 2018 15:26:23 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 6 Dec 2018
 15:26:28 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH RESEND] x86/cpu: Avoid endless loop to get the number of cache leaves
Date:   Thu, 6 Dec 2018 15:26:13 +0800
Message-ID: <1544081173-25059-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn wB67QXuM043280
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the number of cache leaves on AMD or Hygon platform, it should
get the value of cpuid leaf 0x8000001d. But on certain broken platform
such as a not fullly implemented virtual platform(for example Xen),
the value of the cpuid leaf will nerver be CTYPE_NULL, so the kernel
will run into an endless loop.

To fix this problem, add a new enum type CTYPE_MAX to limit the maximum
cpuid accessing.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/cacheinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index dc1b934..7bd167f 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -121,7 +121,8 @@ enum _cache_type {
 	CTYPE_NULL = 0,
 	CTYPE_DATA = 1,
 	CTYPE_INST = 2,
-	CTYPE_UNIFIED = 3
+	CTYPE_UNIFIED = 3,
+	CTYPE_MAX = 4
 };
 
 union _cpuid4_leaf_eax {
@@ -640,7 +641,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 		/* Do cpuid(op) loop to find out num_cache_leaves */
 		cpuid_count(op, i, &eax, &ebx, &ecx, &edx);
 		cache_eax.full = eax;
-	} while (cache_eax.split.type != CTYPE_NULL);
+	} while (cache_eax.split.type != CTYPE_NULL && i != CTYPE_MAX);
 	return i;
 }
 
-- 
2.7.4

