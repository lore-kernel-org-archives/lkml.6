Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8E9218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999286;
	bh=Qjfn1vFeDBCqlf/QEnd2BYQyAq36nZsOCznt3wXd5HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OCX4V5OQP4JzfrOBCltUGjSMr/o4JhqWrbzXXjST3einy0/9AFIt+qGILCxpwnimT
	 oBkPS2J4gb1UAmrG0d9Fl1r9RnTK6mbS46KpeuDKWU52ApR9FV0vUaYgZHrjoFFhke
	 tqRCv8lfhNOWuxYRU/noVWMLvEMRUai+gxaF/0mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeL1MOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbeL1MOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B100C20866;
        Fri, 28 Dec 2018 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999279;
        bh=Qjfn1vFeDBCqlf/QEnd2BYQyAq36nZsOCznt3wXd5HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMS8cW28rwJ30qE4ImyP3syXlwHyP20a9NEn3nV7ucN0D4JJ4rhRhyaG53KdALFML
         r2f5GnAroDYH5L9Vs5ZgCS4K8emd/WQvuO/iX0OV8c5bv7RV4V/84JZbIhXVYc0fpT
         Ppxuq77jwna3Ff8aE1oe7w30H4f0+fVBxSChH2M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/46] mm: introduce mm_[p4d|pud|pmd]_folded
Date:   Fri, 28 Dec 2018 12:52:27 +0100
Message-Id: <20181228113126.764275627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1071fc5779d9846fec56a4ff6089ab08cac1ab72 ]

Add three architecture overrideable functions to test if the
p4d, pud, or pmd layer of a page table is folded or not.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/pgtable.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 88ebc6102c7c..15fd0277ffa6 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1127,4 +1127,20 @@ static inline bool arch_has_pfn_modify_check(void)
 #endif
 #endif
 
+/*
+ * On some architectures it depends on the mm if the p4d/pud or pmd
+ * layer of the page table hierarchy is folded or not.
+ */
+#ifndef mm_p4d_folded
+#define mm_p4d_folded(mm)	__is_defined(__PAGETABLE_P4D_FOLDED)
+#endif
+
+#ifndef mm_pud_folded
+#define mm_pud_folded(mm)	__is_defined(__PAGETABLE_PUD_FOLDED)
+#endif
+
+#ifndef mm_pmd_folded
+#define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
-- 
2.19.1



