Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF33C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF9215E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAF9215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeHOPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:52:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54862 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbeHOPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:52:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91497A9;
        Wed, 15 Aug 2018 06:00:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A96033F5D0;
        Wed, 15 Aug 2018 06:00:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 958A91AE17CB; Wed, 15 Aug 2018 14:00:47 +0100 (BST)
Date:   Wed, 15 Aug 2018 14:00:47 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Message-ID: <20180815130046.GA19402@arm.com>
References: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
 <1534328582-17664-2-git-send-email-thunder.leizhen@huawei.com>
 <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6027cd67-7c76-673c-082f-8dd0b7a575b0@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 01:26:31PM +0100, Robin Murphy wrote:
> On 15/08/18 11:23, Zhen Lei wrote:
> >The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
> >__arm_smmu_sync_poll_msi requires that sync_idx must be increased
> >monotonously according to the sequence of the CMDs in the cmdq.
> >
> >But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
> >by spinlock, so the following scenarios may appear:
> >cpu0			cpu1
> >msidata=0
> >			msidata=1
> >			insert cmd1
> >insert cmd0
> >			smmu execute cmd1
> >smmu execute cmd0
> >			poll timeout, because msidata=1 is overridden by
> >			cmd0, that means VAL=0, sync_idx=1.
> >
> >This is not a functional problem, just make the caller wait for a long
> >time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
> >during the waiting period will break it.
> >
> >Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >---
> >  drivers/iommu/arm-smmu-v3.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >index 1d64710..3f5c236 100644
> >--- a/drivers/iommu/arm-smmu-v3.c
> >+++ b/drivers/iommu/arm-smmu-v3.c
> >@@ -566,7 +566,7 @@ struct arm_smmu_device {
> >
> >  	int				gerr_irq;
> >  	int				combined_irq;
> >-	atomic_t			sync_nr;
> >+	u32				sync_nr;
> >
> >  	unsigned long			ias; /* IPA */
> >  	unsigned long			oas; /* PA */
> >@@ -775,6 +775,11 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
> >  	return 0;
> >  }
> >
> >+static inline void arm_smmu_cmdq_sync_set_msidata(u64 *cmd, u32 msidata)
> 
> If we *are* going to go down this route then I think it would make sense to
> move the msiaddr and CMDQ_SYNC_0_CS_MSI logic here as well; i.e.
> arm_smmu_cmdq_build_cmd() always generates a "normal" SEV-based sync
> command, then calling this guy would convert it to an MSI-based one. As-is,
> having bits of mutually-dependent data handled across two separate places
> just seems too messy and error-prone.

Yeah, but I'd first like to see some number showing that doing all of this
under the lock actually has an impact.

Will
