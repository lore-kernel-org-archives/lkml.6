Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE29C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9AC217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAYT1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:27:55 -0500
Received: from foss.arm.com ([217.140.101.70]:53158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYT1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:27:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1733EEBD;
        Fri, 25 Jan 2019 11:27:54 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BCA13F5C1;
        Fri, 25 Jan 2019 11:27:51 -0800 (PST)
Subject: Re: [RFC v3 09/21] iommu/smmuv3: Get prepared for nested stage
 support
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, jean-philippe.brucker@arm.com,
        will.deacon@arm.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, peter.maydell@linaro.org
References: <20190108102633.17482-1-eric.auger@redhat.com>
 <20190108102633.17482-10-eric.auger@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1d03f9bc-68e9-215b-8ac5-c7b07a7d55fc@arm.com>
Date:   Fri, 25 Jan 2019 19:27:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108102633.17482-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2019 10:26, Eric Auger wrote:
> To allow nested stage support, we need to store both
> stage 1 and stage 2 configurations (and remove the former
> union).
> 
> arm_smmu_write_strtab_ent() is modified to write both stage
> fields in the STE.
> 
> We add a nested_bypass field to the S1 configuration as the first
> stage can be bypassed. Also the guest may force the STE to abort:
> this information gets stored into the nested_abort field.
> 
> Only S2 stage is "finalized" as the host does not configure
> S1 CD, guest does.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - invalidate the STE before moving from a live STE config to another
> - add the nested_abort and nested_bypass fields
> ---
>   drivers/iommu/arm-smmu-v3.c | 43 ++++++++++++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 9af68266bbb1..9716a301d9ae 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -212,6 +212,7 @@
>   #define STRTAB_STE_0_CFG_BYPASS		4
>   #define STRTAB_STE_0_CFG_S1_TRANS	5
>   #define STRTAB_STE_0_CFG_S2_TRANS	6
> +#define STRTAB_STE_0_CFG_NESTED		7
>   
>   #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
>   #define STRTAB_STE_0_S1FMT_LINEAR	0
> @@ -491,6 +492,10 @@ struct arm_smmu_strtab_l1_desc {
>   struct arm_smmu_s1_cfg {
>   	__le64				*cdptr;
>   	dma_addr_t			cdptr_dma;
> +	/* in nested mode, tells s1 must be bypassed */
> +	bool				nested_bypass;

Couldn't that be inferred from "s1_cfg == NULL"?

> +	/* in nested mode, abort is forced by guest */
> +	bool				nested_abort;

Couldn't that be inferred from "s1_cfg == NULL && s2_cfg == NULL && 
smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED"?

>   	struct arm_smmu_ctx_desc {
>   		u16	asid;
> @@ -515,6 +520,7 @@ struct arm_smmu_strtab_ent {
>   	 * configured according to the domain type.
>   	 */
>   	bool				assigned;
> +	bool				nested;

AFAICS, "nested" really only serves a differentiator between the 
assigned-as-bypass and assigned-as-fault cases. The latter isn't 
actually unique to nested though, I'd say it's more just that nobody's 
found reason to do anything with IOMMU_DOMAIN_BLOCKED yet. There's some 
argument for upgrading "assigned" into a tristate enum, but I think it 
might have a few drawbacks elsewhere, so an extra flag here seems 
reasonable, but I think it should just be named "abort". If we have both 
s1_cfg and s2_cfg set, we can see it's nested; if we only have s2_cfg, I 
don't think we really care whether the host or guest asked for stage 1 
bypass; and if in future we care about the difference between host- vs. 
guest-requested abort, leaving s2_cfg set for the latter would probably 
suffice.

>   	struct arm_smmu_s1_cfg		*s1_cfg;
>   	struct arm_smmu_s2_cfg		*s2_cfg;
>   };
> @@ -629,10 +635,8 @@ struct arm_smmu_domain {
>   	bool				non_strict;
>   
>   	enum arm_smmu_domain_stage	stage;
> -	union {
> -		struct arm_smmu_s1_cfg	s1_cfg;
> -		struct arm_smmu_s2_cfg	s2_cfg;
> -	};
> +	struct arm_smmu_s1_cfg	s1_cfg;
> +	struct arm_smmu_s2_cfg	s2_cfg;
>   
>   	struct iommu_domain		domain;
>   
> @@ -1139,10 +1143,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>   			break;
>   		case STRTAB_STE_0_CFG_S1_TRANS:
>   		case STRTAB_STE_0_CFG_S2_TRANS:
> +		case STRTAB_STE_0_CFG_NESTED:
>   			ste_live = true;
>   			break;
>   		case STRTAB_STE_0_CFG_ABORT:
> -			if (disable_bypass)
> +			if (disable_bypass || ste->nested)
>   				break;
>   		default:
>   			BUG(); /* STE corruption */
> @@ -1154,7 +1159,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>   
>   	/* Bypass/fault */
>   	if (!ste->assigned || !(ste->s1_cfg || ste->s2_cfg)) {
> -		if (!ste->assigned && disable_bypass)
> +		if ((!ste->assigned && disable_bypass) ||
> +				(ste->s1_cfg && ste->s1_cfg->nested_abort))

Yikes, these conditions were hard enough to follow before...


I think what I've proposed above might allow the logic here to be a bit 
less convoluted, but even then it may be time to hoist all these checks 
out and have a temporary decision variable for the bypass/abort/valid 
config outcome.

Robin.

>   			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
>   		else
>   			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
> @@ -1172,8 +1178,17 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>   		return;
>   	}
>   
> +	if (ste->nested && ste_live) {
> +		/*
> +		 * When enabling nested, the STE may be transitionning from
> +		 * s2 to nested and back. Invalidate the STE before changing it.
> +		 */
> +		dst[0] = cpu_to_le64(0);
> +		arm_smmu_sync_ste_for_sid(smmu, sid);
> +		val = STRTAB_STE_0_V;
> +	}
> +
>   	if (ste->s1_cfg) {
> -		BUG_ON(ste_live);
>   		dst[1] = cpu_to_le64(
>   			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>   			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
> @@ -1187,12 +1202,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>   		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
>   			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>   
> -		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
> +		if (!ste->s1_cfg->nested_bypass)
> +			val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +				FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
>   	}
>   
>   	if (ste->s2_cfg) {
> -		BUG_ON(ste_live);
>   		dst[2] = cpu_to_le64(
>   			 FIELD_PREP(STRTAB_STE_2_S2VMID, ste->s2_cfg->vmid) |
>   			 FIELD_PREP(STRTAB_STE_2_VTCR, ste->s2_cfg->vtcr) |
> @@ -1454,6 +1469,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
>   		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
>   		cmd.tlbi.vmid	= 0;
> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
> +		cmd.opcode      = CMDQ_OP_TLBI_NH_ASID;
> +		cmd.tlbi.asid   = smmu_domain->s1_cfg.cd.asid;
> +		cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>   	} else {
>   		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
>   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> @@ -1484,6 +1503,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>   	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>   		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
>   		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
> +	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
> +		cmd.opcode      = CMDQ_OP_TLBI_NH_VA;
> +		cmd.tlbi.asid   = smmu_domain->s1_cfg.cd.asid;
> +		cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
>   	} else {
>   		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
>   		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> 
