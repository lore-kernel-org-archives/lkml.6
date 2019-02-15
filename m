Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2841AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB76420449
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198039;
	bh=LwTr1nXOEVL3MpJuQXnZTtCapQoKNlaweD0rUUygPwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tg+mz4K8Y7kvnJpa7ecQA8DmNPnlHp/BSplczxPT0kpNRUUrRRtYuNhxAjlkbTWy2
	 DdaEnFdO+CoZ/6LGuDvWlni4YinXVe7Fy6M/T/IZNza53ANvVFJtzoirb0vTGks4iM
	 pvkFu3xLAi32sCWa+zH3BUcRJtRr0J1x/Q21XllM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbfBOCLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403901AbfBOCLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1303821B1C;
        Fri, 15 Feb 2019 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196706;
        bh=LwTr1nXOEVL3MpJuQXnZTtCapQoKNlaweD0rUUygPwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0Q8NZ7vW/hqF61FQtKUWPIYiuybfCijGaY+ZqWZq874CQQXm1SKhGp5BnfVb4YKU
         FXdARPypl6tdrqX4AgEgC0b3Kx2z5gUlhW0MNGwK7empYUH9xEmhUVuKELbZG+r2f9
         6Ir3q+S70S4jxjpxwj3eacseLEOBZZwk8ZSVhcSM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/65] x86/mm/mem_encrypt: Fix erroneous sizeof()
Date:   Thu, 14 Feb 2019 21:10:31 -0500
Message-Id: <20190215021121.177674-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

[ Upstream commit bf7d28c53453ea904584960de55e33e03b9d93b1 ]

Using sizeof(pointer) for determining the size of a memset() only works
when the size of the pointer and the size of type to which it points are
the same. For pte_t this is only true for 64bit and 32bit-NONPAE. On 32bit
PAE systems this is wrong as the pointer size is 4 byte but the PTE entry
is 8 bytes. It's actually not a real world issue as this code depends on
64bit, but it's wrong nevertheless.

Use sizeof(*p) for correctness sake.

Fixes: aad983913d77 ("x86/mm/encrypt: Simplify sme_populate_pgd() and sme_populate_pgd_large()")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae36868aed2..c9faf34cbb62 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -157,8 +157,8 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	pmd = pmd_offset(pud, ppd->vaddr);
 	if (pmd_none(*pmd)) {
 		pte = ppd->pgtable_area;
-		memset(pte, 0, sizeof(pte) * PTRS_PER_PTE);
-		ppd->pgtable_area += sizeof(pte) * PTRS_PER_PTE;
+		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
+		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
 		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
 	}
 
-- 
2.19.1

