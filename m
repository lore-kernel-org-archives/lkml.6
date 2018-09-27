Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF53C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4769216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9aJejna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4769216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeI1E4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:56:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1E4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AYZEMS42FWgWX/fZd9uNWJ95ae3u3tpBODoaU0A9Amg=; b=V9aJejnaDNDprBrqfXpd1FI+0
        8CYuQz71rO2ew/P/VWh1j4gq0TTLZpqIU2Sdm735ttG0HNxP7CrHKYJhxqIdrUGwnISP6EAnd/cYE
        ZKB6nPvEMTRBTEfyw74BMiSZi9mi/Xlf9KKQT3UBUb+YIlKhjDtwJQAobZJSZ28JDvgJ9lR56Ptg7
        Gsy9P72I493S5tt3mJZRELn8uJdCxp/UdsSEsoGdyHwYiki1D8j55lGfz9gsKt+JJY18cvil2f+u9
        V6KgicuXt/Xr/jl3uuSDSYb+5ii7VzhYyEHuIO+KAyzBYPXss2VRlyyQGiVXu+331moWx7MWcu2pb
        WtDa/kmKw==;
Received: from [199.255.44.5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5esr-0002jp-Sv; Thu, 27 Sep 2018 22:36:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: dma mask related fixups (including full bus_dma_mask support) v2
Date:   Thu, 27 Sep 2018 15:35:34 -0700
Message-Id: <20180927223539.28449-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since v2:
 - clean up a mask check
 - add various acks
