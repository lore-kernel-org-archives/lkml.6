Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC90C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B872086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pSlT0I0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B872086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeK1H6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:58:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeK1H6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:58:48 -0500
Received: from zn.tnic (p200300EC2BDEFE0021C853CE8979B2E0.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:fe00:21c8:53ce:8979:b2e0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 515E91EC047F;
        Tue, 27 Nov 2018 21:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543352378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=fzk0yA1pwf60jilvfDRYcMiRIbyTaRV3y18Zc0VbLHU=;
        b=pSlT0I0f3BnajTxxfI+VtM0dJUafi8A5o4GBoBSoRno2jzz0h89fmZlQAp6LEx/1RngXgj
        XvOI/leP5lkYf6KfW7ygVPRIjqEP/iC/iiV80VM2WWFEg7yc1n0/lEV6c2aAG1+G7qi0hH
        RkNOUGrDFhASUKw0QQ5TOE/yJKDA55s=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/umip: Print UMIP line only once
Date:   Tue, 27 Nov 2018 21:59:36 +0100
Message-Id: <20181127205936.30331-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... instead of issuing it per CPU and flooding dmesg unnecessarily.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ffb181f959d2..2c56b8066280 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -353,7 +353,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 	cr4_set_bits(X86_CR4_UMIP);
 
-	pr_info("x86/cpu: Activated the Intel User Mode Instruction Prevention (UMIP) CPU feature\n");
+	pr_info_once("x86/cpu: Intel User Mode Instruction Prevention (UMIP) activated\n");
 
 	return;
 
-- 
2.19.1

