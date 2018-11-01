Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1650E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1650E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeKBA5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:57:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbeKBA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:57:00 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CqXfvSCyWd3y; Thu,  1 Nov 2018 16:53:27 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBDC00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:dc00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED66D1EC037D;
        Thu,  1 Nov 2018 16:53:26 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/gart: Rewrite early_gart_iommu_check() comment
Date:   Thu,  1 Nov 2018 16:53:14 +0100
Message-Id: <20181101155314.30690-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to actually explain what the function is trying to do.

Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/aperture_64.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 2c4d5ece7456..4fb4b7f53568 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -264,18 +264,23 @@ static int __init parse_gart_mem(char *p)
 }
 early_param("gart_fix_e820", parse_gart_mem);
 
+/*
+ * With kexec/kdump, if the first kernel doesn't shutdown the GART and the
+ * second kernel allocates a different GART region, there might be two
+ * overlapping GART regions present:
+ *
+ * - the first still used by the GART initialized in the first kernel.
+ * - (sub-)set of it used as normal RAM by the second kernel.
+ *
+ * which leads to memory corruptions and a kernel panic eventually.
+ *
+ * This can also happen if the BIOS has forgotten to mark the GART region
+ * as reserved.
+ *
+ * Try to update the e820 map to mark that new region as reserved.
+ */
 void __init early_gart_iommu_check(void)
 {
-	/*
-	 * in case it is enabled before, esp for kexec/kdump,
-	 * previous kernel already enable that. memset called
-	 * by allocate_aperture/__alloc_bootmem_nopanic cause restart.
-	 * or second kernel have different position for GART hole. and new
-	 * kernel could use hole as RAM that is still used by GART set by
-	 * first kernel
-	 * or BIOS forget to put that in reserved.
-	 * try to update e820 to make that region as reserved.
-	 */
 	u32 agp_aper_order = 0;
 	int i, fix, slot, valid_agp = 0;
 	u32 ctl;
-- 
2.19.1

