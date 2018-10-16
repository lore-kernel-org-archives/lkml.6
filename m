Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80A72086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80A72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeJPR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:57:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33596 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:57:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3B4341;
        Tue, 16 Oct 2018 03:07:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9274B3F71C;
        Tue, 16 Oct 2018 03:07:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 76CA31AE33DD; Tue, 16 Oct 2018 11:08:00 +0100 (BST)
Date:   Tue, 16 Oct 2018 11:08:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Message-ID: <20181016100800.GA28150@arm.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
 <20181015172146.GD31305@brain-police>
 <5fa2a259-b070-f8de-77d3-73eb8ac14d59@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa2a259-b070-f8de-77d3-73eb8ac14d59@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:36:52PM +0100, Robin Murphy wrote:
> On 15/10/18 18:21, Will Deacon wrote:
> >On Mon, Oct 15, 2018 at 04:36:16PM +0800, Zhen Lei wrote:
> >>ITS translation register map:
> >>0x0000-0x003C	Reserved
> >>0x0040		GITS_TRANSLATER
> >>0x0044-0xFFFC	Reserved
> >>
> >>The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> >>expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> >>data will be written to MSIAddress each time.
> >>
> >>MSIAddr: |----4bytes----|----4bytes----|
> >>	 |    MSIData   |    IMPDEF    |
> >>
> >>There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> >>But it will overwrite the 4 bytes memory following "sync_count". It's very
> >>luckly that the previous and the next neighbour of "sync_count" are both aligned
> >>by 8 bytes, so no problem is met now.
> >>
> >>It's good to explicitly add a workaround:
> >>1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
> >>    aligned by 8 bytes.
> >>2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
> >>
> >>There is no functional change.
> >>
> >>Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>---
> >>  drivers/iommu/arm-smmu-v3.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >>diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >>index 5059d09..a07bc0d 100644
> >>--- a/drivers/iommu/arm-smmu-v3.c
> >>+++ b/drivers/iommu/arm-smmu-v3.c
> >>@@ -586,7 +586,10 @@ struct arm_smmu_device {
> >>  	struct arm_smmu_strtab_cfg	strtab_cfg;
> >>+	union {
> >>+	u64				padding; /* workaround for Hisilicon */
> >>  	u32				sync_count;
> >>+	} __attribute__((aligned(8)));
> >
> >Won't this already be aligned by the ABI?
> >
> >Anyway, you'll need to swizzle things for big-endian, I suspect. Maybe you
> >can do something clever like making sync_count an array of two elements
> >and determining the offset based on the endianness. Or just keep it simple
> >like we do for things like struct qrwlock and struct qspinlock and use
> >#ifdefs.
> 
> I don't think so - the CPUs should only ever be making word accesses to the
> u32 member, while the SMMU expects to be writing little-endian data to an
> ITS, so AFAICS the data word will always be at the lower address either way.

Yes, thanks. I'd actually got the union layout wrong in my head and not
realised that both member will start at the same address. Ok, so that works.

> Although now that it's come up, the pre-existing issue of whether the byte
> order *within* that u32 comes out correct after its round-trip through the
> SMMU is something I need to run away and hurriedly think about...

Ha, oops! Everything going into the command queue is swabbed, so I guess we
need to swab the data again in smp_cond_load_acquire(). I'll leave it with
you...

Will
