Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B76C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DA72087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764693;
	bh=YHyF8g71Qi4NVNMhmCLc3E+MIekNiLMLzpdE4G7qD3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fOp9lpONllYEIti8SpRydRKULNEByw9n3NTZKj4j1um0O8HIfigeYVREvMLYux/TM
	 FakCIWvzkMcfjJ3i5CzucTX0YQeX/rPXdLu8ZO8dxm6ZTw4XInsDJzSeBXXedaPHE2
	 EnniNelr0mU+1DFlyVVYQYAyQQ3NJi4IahBJNM0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfA2MYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:24:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfA2MYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:24:51 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D43820870;
        Tue, 29 Jan 2019 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764690;
        bh=YHyF8g71Qi4NVNMhmCLc3E+MIekNiLMLzpdE4G7qD3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otqx39PE03e3RAUJ43EyUOBM8jcvSXmZH5Ux9FY7tz6GPnEK0zAM5cyahp1D+wNpr
         mEH24iCAdKPS0664O3njSexuaeR99CD3WBooZLIc//7z1pMFbqnb1p1YTPfC4ffCyy
         zlXue6Yfd1MOvwT6Ip2vK0y2cSd0X8i/vR15QxQ8=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 03/10] csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
Date:   Tue, 29 Jan 2019 20:24:22 +0800
Message-Id: <1548764669-16656-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY CPU 8xx's _PAGE_GLOBAL is BIT(0), but 610's _PAGE_GLOBAL is
BIT(6). Use _PAGE_GLOBAL macro instead of bad magic number.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index edfcbb2..af7a7fa 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -45,8 +45,8 @@
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset_t(address))
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
-			(((unsigned int)addr&0x80000000)?__pte(1):__pte(0)))
-#define pte_none(pte)	(!(pte_val(pte)&0xfffffffe))
+	(((unsigned int) addr & PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
+#define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_pfn(x)	((unsigned long)((x).pte_low >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
-- 
2.7.4

