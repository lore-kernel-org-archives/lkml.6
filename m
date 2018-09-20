Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA48214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qTZrhxfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA48214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbeIUAht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:37:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AOLlbSuHhx+0PG/hegozsrUdJLTxsHqKyO8h1vJ2Vbs=; b=qTZrhxfNbx+r6rg+PHzKe2nlR
        pA7iJ+md/pbloIlqvp+Rz1qB/AqYGSpSC24IrNkhrVpndjDZV63DMO4iuTTpOieVUOyxPBfO/dX9Z
        e0CquIyc+j71DGfb4iFMzc9H4w7cmKMAQPVH9q4zlKVzML0BVB6To6YAtREN7ifZsqyTLtMHfeF43
        JZlsr5WVgkyNotx/ZY4lyjGRi1EWauHnqpNdPBvPbJAM8vajccjp4grQ9JI1QV2qzyKvsVv1yuwS2
        rchwhWdDC2Udyw9uz//jxt7Kg3t4hwN4F/1tSp6byBAN1V17H7wJ7Ki/gh5pGMyZv33RXMJalAorG
        RITSkazpg==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g344K-0001kP-9Q; Thu, 20 Sep 2018 18:52:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: dma mask related fixups (including full bus_dma_mask support)
Date:   Thu, 20 Sep 2018 20:52:42 +0200
Message-Id: <20180920185247.20037-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the dma_get_required_mask dma API implementation has always been a little
odd, in that we by default don't wire it up struct dma_map_ops, but
instead hard code a default implementation.  powerpc and ia64 override
this default and either call a method or otherwise duplicate the default.

This series always enabled the method and just falls back to the previous
default implementation when it is not available, as well as fixing up
a few bits in the default implementations.  This already allows removing
the ia64 override of the implementation, and will also allow to remove
the powerpc one together with a few additional cleanups in the powerpc
code, but those will be sent separately with other powerpc DMA API
patches.  Last but not least the method will allow us to return a more
sensible value for typical iommu dma_ops eventually, but that is left
to another series as well.

Additionally the dma-direct code has been a bit sloppy in when it was
using phys_to_dma in a few places, so this gets fixed up as well as
actually respecting the bus_dma_mask everywhere instead of just
rejecting dma mask that don't fit into it.

Alltogether this should be all core dma-direct changes required to
move powerpc over to the generic code.
