Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B7A21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B7A21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeIXSeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbeIXSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01D221018;
        Mon, 24 Sep 2018 12:32:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiang Biao <jiang.biao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        albcamus@gmail.com, zhong.weidong@zte.com.cn,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 095/235] x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
Date:   Mon, 24 Sep 2018 13:51:21 +0200
Message-Id: <20180924113114.774100032@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit 8c934e01a7ce685d98e970880f5941d79272c654 ]

pti_user_pagetable_walk_pmd() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the PMD allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-2-git-send-email-jiang.biao2@zte.com.cn
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pti.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -206,7 +206,7 @@ static pmd_t *pti_user_pagetable_walk_pm
 	BUILD_BUG_ON(p4d_large(*p4d) != 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page = __get_free_page(gfp);
-		if (!new_pud_page)
+		if (WARN_ON_ONCE(!new_pud_page))
 			return NULL;
 
 		set_p4d(p4d, __p4d(_KERNPG_TABLE | __pa(new_pud_page)));
@@ -220,7 +220,7 @@ static pmd_t *pti_user_pagetable_walk_pm
 	}
 	if (pud_none(*pud)) {
 		unsigned long new_pmd_page = __get_free_page(gfp);
-		if (!new_pmd_page)
+		if (WARN_ON_ONCE(!new_pmd_page))
 			return NULL;
 
 		set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
@@ -242,9 +242,13 @@ static pmd_t *pti_user_pagetable_walk_pm
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd = pti_user_pagetable_walk_pmd(address);
+	pmd_t *pmd;
 	pte_t *pte;
 
+	pmd = pti_user_pagetable_walk_pmd(address);
+	if (!pmd)
+		return NULL;
+
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
 		WARN_ON(1);


