Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48192C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5D620891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L0zQsAnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5D620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757141AbeFQCDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:03:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934596AbeFQCBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LeMKahj/PRRicsA35gt3pl12oVGucoAeWFm4Rznk8kI=; b=L0zQsAnKQFSFlP3s4Uy7N75+1
        nPC4veNqYhTZLIm1yjdBG+P6y3GcDSB2X9TGr+5MrJDgw/DNWH3i0UBTn/GipemFOLO/glEMXyBqd
        ILhchaMO4//6rB+Grco2oSAKKl/oyajy7B7vWxpILaRurOWbPMhitMD54hpel9HFj7b6fFyPWkAAa
        XA6NPtza3i2uZcZbm1gi3gtHWo0oRwbBU9j/whTZWYiE+vBIRlsXjvBI7zGFDtmkO6Febfx4viKX1
        FRnEEeAZe0dsRtQNsgXVyePntwpIa84EzsioDduDmJjoDn2T4Y0p35yN3dAfYvngIMAi1VaZYSVvw
        50CcmW4LA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0c-0001gq-22; Sun, 17 Jun 2018 02:01:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 70/74] page cache: Finish XArray conversion
Date:   Sat, 16 Jun 2018 19:00:48 -0700
Message-Id: <20180617020052.4759-71-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With no more radix tree API users left, we can drop the GFP flags
and use xa_init() instead of INIT_RADIX_TREE().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/inode.c      | 2 +-
 mm/swap_state.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 077a6174dfd5..8ab03bf193a4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(inc_nlink);
 
 static void __address_space_init_once(struct address_space *mapping)
 {
-	INIT_RADIX_TREE(&mapping->i_pages, GFP_ATOMIC | __GFP_ACCOUNT);
+	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 5cd42d05177e..3d813d2b5dff 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -596,7 +596,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		INIT_RADIX_TREE(&space->i_pages, GFP_ATOMIC|__GFP_NOWARN);
+		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */
-- 
2.17.1

