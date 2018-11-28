Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D552086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/qPoNk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D552086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeK2D0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2D0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:26:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBB222081C;
        Wed, 28 Nov 2018 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543422260;
        bh=8mhaGNZrYFcm/IRz3hf9V1WI1AHFqUJV/VNTvIYNrlc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=t/qPoNk6e2k5KBld6GKbiEdy/z/NKcw4eT7iC0JXUvmeptnx9g9/O6dsfPRrQvUqv
         JngTuhV6vyR1zFmpbGCNIWU8xcxZI1KVRXhdeIhjxPYtd62Tpo4xS07aUezaQuQGfw
         zBBMpiA2131AYNOmjfEaK5f688yQXvqx09Pdokec=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        will.deacon@arm.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181127101145.7682-2-vivek.gautam@codeaurora.org>
Cc:     alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thor.thayer@linux.intel.com,
        Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
Message-ID: <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date:   Wed, 28 Nov 2018 08:24:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2018-11-27 02:11:41)
> @@ -1966,6 +1970,23 @@ static const struct of_device_id arm_smmu_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>  =

> +static void arm_smmu_fill_clk_data(struct arm_smmu_device *smmu,
> +                                  const char * const *clks)
> +{
> +       int i;
> +
> +       if (smmu->num_clks < 1)
> +               return;
> +
> +       smmu->clks =3D devm_kcalloc(smmu->dev, smmu->num_clks,
> +                                 sizeof(*smmu->clks), GFP_KERNEL);
> +       if (!smmu->clks)
> +               return;
> +
> +       for (i =3D 0; i < smmu->num_clks; i++)
> +               smmu->clks[i].id =3D clks[i];

Is this clk_bulk_get_all()?

