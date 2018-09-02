Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD12EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435DC2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UGGfl7hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435DC2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeIBIPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 04:15:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeIBIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 04:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I5Vvi8NjvGsKqae49MWMLvwnKeV8+ft/BeHw3J40eTI=; b=UGGfl7hdUJX0oNIJRRMn+8J1X
        cUV7rxMzvrFq6IyNLwSyXOny1giuuyt+LrC7dlCmii3er0hzjFgVhdFBhZ1D99gzB+FG5RAxDv5Xv
        Is2ymZwujkduaVxvs8CJWXKaXwFInBdr+5bArXesrqCyenb7mMtLBM3vMwze0MkZijPhjjeUkstuO
        WEFyDiZCx/k/66Ou/aQojwMZxNvhkJEkjg1Um62bH6cO2t9qtheENnbODGWSTbRNBxUtf/nfaZFHQ
        tV6MRkY2xgVMR+jx6W/lMCa46BHUWWtXGUo7MIqiVzrRVTwQkbdyGXhPxxy65fFRLlUufn5CYYEV+
        K3mZZ0lSQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwJZr-0006Ae-0D; Sun, 02 Sep 2018 04:01:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: fix pti Section Mismatch warning/error
Message-ID: <43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infradead.org>
Date:   Sat, 1 Sep 2018 21:01:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix the section mismatch warning in arch/x86/mm/pti.c:

WARNING: vmlinux.o(.text+0x6972a): Section mismatch in reference from the function pti_clone_pgtable() to the function .init.text:pti_user_pagetable_walk_pte()
The function pti_clone_pgtable() references
the function __init pti_user_pagetable_walk_pte().
This is often because pti_clone_pgtable lacks a __init
annotation or the annotation of pti_user_pagetable_walk_pte is wrong.
FATAL: modpost: Section mismatches detected.

Fixes: 85900ea51577 ("x86/pti: Map the vsyscall page if needed")

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
---
Applies to mainline.

 arch/x86/mm/pti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180830.orig/arch/x86/mm/pti.c
+++ linux-next-20180830/arch/x86/mm/pti.c
@@ -248,7 +248,7 @@ static pmd_t *pti_user_pagetable_walk_pm
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;

