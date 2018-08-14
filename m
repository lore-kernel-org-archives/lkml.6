Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AC0218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AC0218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeHNLVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:21:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbeHNLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:21:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AF180D;
        Tue, 14 Aug 2018 01:34:54 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C563A3F5D0;
        Tue, 14 Aug 2018 01:34:54 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 57C9F1AE3096; Tue, 14 Aug 2018 09:35:01 +0100 (BST)
Date:   Tue, 14 Aug 2018 09:35:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
Message-ID: <20180814083500.GA28101@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
 <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B7293E5.7040702@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown) wrote:
> On 2018/8/6 9:32, Yang, Shunyong wrote:
> > On 2018/7/26 22:37, Robin Murphy wrote:
> >> Because DMA code is not the only caller of iommu_map/unmap. It's 
> >> perfectly legal in the IOMMU API to partially unmap a previous mapping 
> >> such that a block entry needs to be split. The DMA API, however, is a 
> >> lot more constrined, and thus by construction the iommu-dma layer will 
> >> never generate a block-splitting iommu_unmap() except as a result of 
> >> illegal DMA API usage, and we obviously do not need to optimise for that 
> >> (you will get a warning about mismatched unmaps under dma-debug, but 
> >> it's a bit too expensive to police in the general case).
> >>
> > 
> > When I was reading the code around arm_lpae_split_blk_unmap(), I was
> > curious in which scenario a block will be split. Now with your comments
> > "Because DMA code is not the only caller of iommu_map/unmap", it seems
> > depending on the user.
> > 
> > Would you please explain this further? I mean besides DMA, which user
> > will use iommu_map/umap and how it split a block.
> 
> I also think that arm_lpae_split_blk_unmap() scenario is not exist, maybe
> we should remove it, and give a warning for this wrong usage.

Can't it happen with VFIO?

Will
