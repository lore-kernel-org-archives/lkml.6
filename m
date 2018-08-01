Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7211C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679FE208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679FE208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbeHALsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:48:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55990 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbeHALsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:48:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkny6-00010M-Io; Wed, 01 Aug 2018 06:02:58 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, mingo@kernel.org, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 10/11] x86,tlb: really leave mm on shootdown
Date:   Wed,  1 Aug 2018 06:02:54 -0400
Message-Id: <20180801100255.4278-11-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801100255.4278-1-riel@surriel.com>
References: <20180801100255.4278-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting an mm shot down from under us in lazy TLB mode, don't
just switch the TLB over to the init_mm page tables, but really drop
our references to the lazy TLB mm.

This allows for faster (instant) freeing of a lazy TLB mm, which is
a precondition to getting rid of the refcounting of mms in lazy TLB mode.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7b1add904396..425cb9fa2640 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -140,6 +140,8 @@ void leave_mm(void *dummy)
 	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
 
 	switch_mm(NULL, &init_mm, NULL);
+	current->active_mm = &init_mm;
+	mmdrop(loaded_mm);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
@@ -483,6 +485,8 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
+		current->active_mm = &init_mm;
+		mmdrop(loaded_mm);
 		return;
 	}
 
-- 
2.14.4

