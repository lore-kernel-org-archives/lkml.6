Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60421C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6820867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KEJ0LRKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA6820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeH1Stk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1Stk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IvyoQtmq78o1GLbrdsrBmxk4/oo+yXg7kMb6YQ3nLKs=; b=KEJ0LRKpf9rV9T1Cg2ydJTohw
        DMtCEXvJxrNDegeBQtDEvwa0R003EkmlNUnembT6NBudhfQRwoSCGGx96mZsC2UNWIWxk+SLBVI5W
        0I8afgC7iyonpf+O7HnlUzmeTpPKjv0Dg+Ccps3xb6pBR+zW5MDw+Z1Bx0hUuDZsiI7vQz7OWu84T
        zA5RZwMVvUNBTosrnjE9Ue/ah0/bu2Eyxd7O8EGFBK4ZaLyQCar5fV7s2ZbN+cIjJayDQkwczKqb7
        zgRltv7bHO2PLry/QkYZkixbX6yTPB27b2BMwPqoH6Ui0etMpssSTaJ+9WFRewfivC9rHEDknTPUO
        QqRHwQOeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR1-0003A6-N1; Tue, 28 Aug 2018 14:57:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Push the vm_fault_t conversion further
Date:   Tue, 28 Aug 2018 07:57:18 -0700
Message-Id: <20180828145728.11873-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series reaps some of the benefits of the vm_fault_t work that
Souptick has been diligently plugging away at by converting insert_pfn()
to return a vm_fault_t.

Eventually, we'll be able to do the same thing to insert_page(),
but there's more work to be done converting all current callers of
vm_insert_page() to vmf_insert_page(), and this patch series provides
a nice clean-up.

Nicolas, I'd like your reviewed-by on patch 1 please.

Matthew Wilcox (10):
  cramfs: Convert to use vmf_insert_mixed
  mm: Remove vm_insert_mixed
  mm: Introduce vmf_insert_pfn_prot
  x86: Convert vdso to use vm_fault_t
  mm: Make vm_insert_pfn_prot static
  mm: Remove references to vm_insert_pfn
  mm: Remove vm_insert_pfn
  mm: Inline vm_insert_pfn_prot into caller
  mm: Convert __vm_insert_mixed to vm_fault_t
  mm: Convert insert_pfn to vm_fault_t

 Documentation/x86/pat.txt     |   4 +-
 arch/x86/entry/vdso/vma.c     |  24 +++----
 fs/cramfs/inode.c             |   9 ++-
 include/asm-generic/pgtable.h |   4 +-
 include/linux/hmm.h           |   2 +-
 include/linux/mm.h            |  32 +--------
 mm/memory.c                   | 122 +++++++++++++++++-----------------
 7 files changed, 84 insertions(+), 113 deletions(-)

-- 
2.18.0

