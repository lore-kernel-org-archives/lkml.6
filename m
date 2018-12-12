Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC88C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC2F2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC2F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbeLLQLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:11:48 -0500
Received: from verein.lst.de ([213.95.11.211]:34860 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLQLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:11:48 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E61FC68D8D; Wed, 12 Dec 2018 17:11:46 +0100 (CET)
Date:   Wed, 12 Dec 2018 17:11:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: linux-next: manual merge of the sparc-next tree with the
 dma-mapping tree
Message-ID: <20181212161146.GA7176@lst.de>
References: <20181212093042.00fbf6be@canb.auug.org.au> <20181212074420.GB29137@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212074420.GB29137@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 08:44:20AM +0100, Christoph Hellwig wrote:
> Dave, Sam:
> 
> should I just apply a version of Rob's tree that takes the refactoring
> into account to the dma-mapping tree?  That way we should get the right
> result independent of the merge order.

E.g. something like the patch below:

--
From 6ee3d6c39a0c8bc4b58fa601bb4370bdec785be7 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Dec 2018 17:09:58 +0100
Subject: sparc: use DT node full_name in sparc_dma_alloc_resource

The sparc tree already has this change for the pre-refactored code,
but pulling it into the dma-mapping tree like this should ease
the merge conflicts a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/ioport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 51c128d80193..baa235652c27 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -252,7 +252,7 @@ unsigned long sparc_dma_alloc_resource(struct device *dev, size_t len)
 	res = kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return 0;
-	res->name = dev->of_node->name;
+	res->name = dev->of_node->full_name;
 
 	if (allocate_resource(&_sparc_dvma, res, len, _sparc_dvma.start,
 			      _sparc_dvma.end, PAGE_SIZE, NULL, NULL) != 0) {
-- 
2.19.2

