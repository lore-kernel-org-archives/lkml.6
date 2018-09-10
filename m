Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49CB2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EDNPHSBL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LzYpPKKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49CB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeIJPcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:32:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:32:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C82C7607F4; Mon, 10 Sep 2018 10:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536575923;
        bh=hhMwW5/Slpp1/ap5G/h13/IxIjRHAi8b3/3kgz/dsaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EDNPHSBLAWeI79TD/4tJtM81R6bJ409y2zwYaLbClXXfvNpApb2vZIKEs7iaQQvIG
         BcBEnOaLkgzyOuNz2oTWgd2FuoxfD80J5J8M5aWRyEChL3MrNyLAxbsekqz18teQ8g
         lEzhmTECBMpnmT+f8qnDnBNJ0qJgrEcbtEcNkmNU=
Received: from [10.79.40.103] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CD286053B;
        Mon, 10 Sep 2018 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536575922;
        bh=hhMwW5/Slpp1/ap5G/h13/IxIjRHAi8b3/3kgz/dsaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LzYpPKKQYVmBzhYSNLMRwVHAWk4MqZX4BpDkFHrKnvNOp12zUe8s6ZZkAWIZOCs6o
         8DnwoHUzS5JJlIvh6uzeVTj8vEOmFMN9uwQgr0PQlIJvw6lkFPkSF/4dyzSqfnEo9b
         bvpkEFIlOtwkRm+A1V3MJYN5JiLdqn2cT5gPDXHo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CD286053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v2 0/4] Qcom smmu-500 TLB invalidation errata for sdm845
To:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <4f6e48c4-6fec-b764-6083-fea4133e1fa8@codeaurora.org>
Date:   Mon, 10 Sep 2018 16:08:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+linux-arm-msm


On 09/10/2018 11:55 AM, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
> errata [1] because of which the TCU cache look ups are stalled during
> invalidation cycle. This is mitigated by serializing all the invalidation
> requests coming to the smmu.
>
> This patch series addresses this errata by adding new tlb_ops for
> qcom,sdm845-smmu-500 [2]. These ops take context bank locks for all the
> tlb_ops that queue and sync the TLB invalidation requests.
>
> Besides adding locks, there's a way to expadite these TLB invalidations
> for display and camera devices by turning off the 'wait-for-safe' logic
> in hardware that holds the tlb invalidations until a safe level.
> This 'wait-for-safe' logic is controlled by toggling a chicken bit
> through a secure register. This secure register is accessed by making an
> explicit SCM call into the EL3 firmware.
> There are two ways of handling this logic -
>   * Firmware, such as tz present on sdm845-mtp devices has a handler to do
>     all the register access and bit set/clear. So is the handling in
>     downstream arm-smmu driver [3].
>   * Other firmwares can have handlers to just read/write this secure
>     register. In such cases the kernel make io_read/writel scm calls to
>     modify the register.
> This patch series adds APIs in qcom-scm driver to handle both of these
> cases.
>
> Lastly, since these TLB invalidations can happen in atomic contexts
> there's a need to add atomic versions of qcom_scm_io_readl/writel() and
> qcom_scm_call() APIs. The traditional scm calls take mutex and we therefore
> can't use these calls in atomic contexts.
>
> This patch series is adapted version of how the errata is handled in
> downstream [1].
>
> Changes since v1:
>   * Addressed Will and Robin's comments:
>      - Dropped the patch[4] that forked out __arm_smmu_tlb_inv_range_nosync(),
>        and __arm_smmu_tlb_sync().
>      - Cleaned up the errata patch further to use downstream polling mechanism
>        for tlb sync.
>   * No change in SCM call patches - patches 1 to 3.
>
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842
> [2] https://lore.kernel.org/patchwork/patch/974114/
> [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4864
> [4] https://patchwork.kernel.org/patch/10565349/
>
> Vivek Gautam (4):
>    firmware: qcom_scm-64: Add atomic version of qcom_scm_call
>    firmware/qcom_scm: Add atomic version of io read/write APIs
>    firmware/qcom_scm: Add scm call to handle smmu errata
>    iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata
>
>   drivers/firmware/qcom_scm-32.c |  17 ++++
>   drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
>   drivers/firmware/qcom_scm.c    |  18 ++++
>   drivers/firmware/qcom_scm.h    |   9 ++
>   drivers/iommu/arm-smmu-regs.h  |   2 +
>   drivers/iommu/arm-smmu.c       | 133 +++++++++++++++++++++++++++++-
>   include/linux/qcom_scm.h       |   6 ++
>   7 files changed, 320 insertions(+), 46 deletions(-)
>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

