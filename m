Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE717C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25C4206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25C4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeJBUS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbeJBUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:55 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DAEBF5AA;
        Tue,  2 Oct 2018 13:35:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 137/137] x86/pti: Fix section mismatch warning/error
Date:   Tue,  2 Oct 2018 06:25:38 -0700
Message-Id: <20181002132508.095916361@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit ff924c5a1ec7548825cc2d07980b03be4224ffac ]

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infradead.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pti.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -224,7 +224,7 @@ static __init pmd_t *pti_user_pagetable_
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;


