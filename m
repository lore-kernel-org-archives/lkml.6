Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83305C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3131D214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3131D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbeHPMPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:15:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390378AbeHPMPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:15:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 816527A9;
        Thu, 16 Aug 2018 02:17:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F09B3F5BD;
        Thu, 16 Aug 2018 02:17:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7A8181AE11BC; Thu, 16 Aug 2018 10:18:05 +0100 (BST)
Date:   Thu, 16 Aug 2018 10:18:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Message-ID: <20180816091805.GB31093@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
 <5B7533FD.20903@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B7533FD.20903@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 04:21:17PM +0800, Leizhen (ThunderTown) wrote:
> On 2018/8/15 20:26, Robin Murphy wrote:
> > On 15/08/18 11:23, Zhen Lei wrote:
> >> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >> index 1d64710..3f5c236 100644
> >> --- a/drivers/iommu/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm-smmu-v3.c
> >> @@ -566,7 +566,7 @@ struct arm_smmu_device {
> >>
> >>       int                gerr_irq;
> >>       int                combined_irq;
> >> -    atomic_t            sync_nr;
> >> +    u32                sync_nr;
> >>
> >>       unsigned long            ias; /* IPA */
> >>       unsigned long            oas; /* PA */
> >> @@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
> >>       return 0;
> >>   }
> >>
> >> +static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
> > 
> > If we *are* going to go down this route then I think it would make sense
> > to move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
> > arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
> > command, then calling this guy would convert it to an MSI-based one.
> > As-is, having bits of mutually-dependent data handled across two
> > separate places just seems too messy and error-prone.
> 
> Yes, How about create a new function "arm_smmu_cmdq_build_sync_msi_cmd"?
> 
> static inline
> void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> {
> 	cmd[0]  = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
> 	cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> 	cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
> }

None of this seems justified given the numbers from John, so please just do
the simple thing and build the command with the lock held.

Will
