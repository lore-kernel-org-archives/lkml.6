Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77285C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A42084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbeLTNku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:40:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbeLTNku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:40:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62410A0E66;
        Thu, 20 Dec 2018 13:40:50 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01FCE2A19D;
        Thu, 20 Dec 2018 13:40:47 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        David Duncan <davdunc@amazon.com>
Subject: [PATCH] x86/intel_rdt: use rdmsr_safe() to workaround AWS host issue
Date:   Thu, 20 Dec 2018 14:40:46 +0100
Message-Id: <20181220134046.7916-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 20 Dec 2018 13:40:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that AWS x1 instances (Xen-based) lack xen.git commit
1f1d183d4900 (x86/HVM: don't give the wrong impression of WRMSR succeeding)
and because of that the wrmsr_safe() check in cache_alloc_hsw_probe()
doesn't help: the consequent rdmsr() blows up with

 unchecked MSR access error: RDMSR from 0xc90 at rIP:
   0xffffffff88c5bba3 (native_read_msr+0x3/0x30)

The issue should definitely get fixed on AWS side. We can, however, simply
workaround this in Linux and live happily after.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/cpu/intel_rdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 44272b7107ad..0acee6cd07a8 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -213,7 +213,8 @@ static inline void cache_alloc_hsw_probe(void)
 
 	if (wrmsr_safe(IA32_L3_CBM_BASE, max_cbm, 0))
 		return;
-	rdmsr(IA32_L3_CBM_BASE, l, h);
+	if (rdmsr_safe(IA32_L3_CBM_BASE, &l, &h))
+		return;
 
 	/* If all the bits were set in MSR, return success */
 	if (l != max_cbm)
-- 
2.19.2

