Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE54C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98AC2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMqhhboM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfACAVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:21:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfACAVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OQOpxZv95FP2XBOu61CyGnmRm4Xc+rHoB1dn4/6ZEI8=; b=OMqhhboM/P06ByKNvuIKuLIVND
        d1+GPBi17b3OquyFB7EWJYUpBjNu6APWsEl4/C3wqr+i41knmwuPdrkOr1/RDMqx983GYn19L6VBi
        sQPD3D1bWwInHA3todiDvqjDtBcRmcmTwRoAx5a9UA5aKHTA6Fcb/ckvz+xcOcyNJcRYRS2IamrTu
        3uFJUZujpgHoKfBscNHtlSTegac1Qq6E4Sf1vvsMeZMe45221KqKEOeWPbLNlSNxgxNqmNwEbHcEw
        eHPCsXP60PidkM9UFBBSaqCesex7Gzn9nVcS1x0mUxviGLxTGEUn4mEwDCwWko8uZoAoE1WPnI/MW
        T5jcQCDQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1geqlL-0000n5-3N; Thu, 03 Jan 2019 00:21:27 +0000
Date:   Wed, 2 Jan 2019 16:21:26 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103002126.GM6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


One of the paths in follow_pte_pmd() initialised the mmu_notifier_range
incorrectly.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
Tested-by: Dave Chinner <dchinner@redhat.com>

diff --git a/mm/memory.c b/mm/memory.c
index 2dd2f9ab57f4..21a650368be0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4078,8 +4078,8 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		goto out;
 
 	if (range) {
-		range->start = address & PAGE_MASK;
-		range->end = range->start + PAGE_SIZE;
+		mmu_notifier_range_init(range, mm, address & PAGE_MASK,
+				     (address & PAGE_MASK) + PAGE_SIZE);
 		mmu_notifier_invalidate_range_start(range);
 	}
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
