Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B742C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7CD20896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7CD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeH1UDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:03:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55108 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1UDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:03:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fugZr-0002Sf-1g; Tue, 28 Aug 2018 16:10:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/xen: remove redundant variable save_pud
Date:   Tue, 28 Aug 2018 17:10:46 +0100
Message-Id: <20180828161046.17165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable save_pud is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'save_pud' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/xen/mmu_pv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 06a814d44b9b..2fe5c9b1816b 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2060,7 +2060,6 @@ void __init xen_relocate_p2m(void)
 	pud_t *pud;
 	pgd_t *pgd;
 	unsigned long *new_p2m;
-	int save_pud;
 
 	size = PAGE_ALIGN(xen_start_info->nr_pages * sizeof(unsigned long));
 	n_pte = roundup(size, PAGE_SIZE) >> PAGE_SHIFT;
@@ -2090,7 +2089,6 @@ void __init xen_relocate_p2m(void)
 
 	pgd = __va(read_cr3_pa());
 	new_p2m = (unsigned long *)(2 * PGDIR_SIZE);
-	save_pud = n_pud;
 	for (idx_pud = 0; idx_pud < n_pud; idx_pud++) {
 		pud = early_memremap(pud_phys, PAGE_SIZE);
 		clear_page(pud);
-- 
2.17.1

