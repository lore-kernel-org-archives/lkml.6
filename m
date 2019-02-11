Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4090C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C96222A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWagUc34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBKNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:46:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfBKNqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eH1I4g7KP/93fwQ8RdTzO6SZ9HgEBTMbTrGqkWVVuF0=; b=IWagUc34Fg0DExNPPfnqCdZ8T
        DFUpM7p6MShFnIgDrXQmdecjyATgiTqI6af+P7ZFQN5IJpQUsBrAk9qxbhRo6kp/AsJ1nwIRnembn
        pSwgSGNXaFQmFDEsVTgXEg4f/oxPbc5A9A8oWeQmJRWhb3k0gE9uPaJOsjlV7mzuJ/51xw8+ePetk
        Z+G50JW7j/mCGXpsmqnGSW2FpjgtzNaYcjp8F+v2OvjcytEw0I3wwLm1qLFNPxBSILNUwV5Zi4eRT
        hHHDDmt9Qdj5ENBAgEYh3Jo8fo++UJBxMxu2hf9x54iPYcRny4CAFlzpJ7yf/H8xFEpw1GytINiXj
        5y2aT0Y4A==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBv4-0007S8-E7; Mon, 11 Feb 2019 13:46:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     pjones@redhat.com, konrad@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iscsi_ibft: use virt_to_phys instead of isa_virt_to_bus
Date:   Mon, 11 Feb 2019 14:46:42 +0100
Message-Id: <20190211134642.31149-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell IBFT is a firmware table and has nothing to do with
the good old ISA bus.  And even if it the two would be the same on x86
anyway.  So remove the isa_virt_to_bus call in preparation of eventually
removing that API entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firmware/iscsi_ibft_find.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
index 72d9ea18270b..85c656d04bb0 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -104,7 +104,7 @@ unsigned long __init find_ibft_region(unsigned long *sizep)
 
 	if (ibft_addr) {
 		*sizep = PAGE_ALIGN(ibft_addr->header.length);
-		return (u64)isa_virt_to_bus(ibft_addr);
+		return (u64)virt_to_phys(ibft_addr);
 	}
 
 	*sizep = 0;
-- 
2.20.1

