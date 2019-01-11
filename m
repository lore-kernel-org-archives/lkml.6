Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80666C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA220660
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqS72cWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAKDPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:15:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42897 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAKDPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:15:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so6093919plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yx4yQXIKxW7YTtA3rr7iZqxnRr2RSZ9wqmpwBW/NF0c=;
        b=WqS72cWNdSSw0SuRaNYPvYE7oY8teoBR9JkRDtBQfP4RTxCmg9ac0mtTKHFNH9jwqt
         A+NTxmRILWdiYdArDZImbu0Z73AsNEYZ3Ew10usxBG1ttpGj0hx18eXJiCGCuGh6MYEv
         67xgZcfvKZygA0R+73so1ktLciXmQos6C33lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yx4yQXIKxW7YTtA3rr7iZqxnRr2RSZ9wqmpwBW/NF0c=;
        b=ftTf9d/YJVHJvmA5QlIm8pgO7h3Zm14riZblv3w7iZCI+cV2mOICri+/hsPS81+JgB
         5kdlu+YmCt3/81RKw6whQnmaCMRejliPgmaneY54qgfnXfhO9zomPLWtOIVfZf6gD2UL
         MTF3xg5QWVdXunmGGqHyeroGVI/5Fuiv4dFzextWlyc+9UDyj7WPuzV/aWJNZd6sRQnE
         OisfvAkboRyTPqtoBmUxL/pWp9sqRKtSBKL15gCGM1rWZlqQuLExhMIigJ1ZUcP3lABC
         COO2DrLD1Fj4LF7XKNNnZsxKUfuJ1K0bhycS/VjvGymUToO2cg3JQoP3gq+akFsrwuju
         CTfg==
X-Gm-Message-State: AJcUukfe1QhCu9///Cer6va0mnRXcUbvr/m3bYoGIwFKNZr/9s0XgFFt
        ixk+ALFPdcCiyh40sJbj/yMABg==
X-Google-Smtp-Source: ALg8bN5cVfwTPgDJMss7X4em4Y1YENV2B3aKzPPnHSsqPofYI3C8uSGpfRHJV72LBAy9In+EgsngwQ==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr13129022plb.52.1547176507869;
        Thu, 10 Jan 2019 19:15:07 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i1sm110118747pgb.46.2019.01.10.19.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 19:15:07 -0800 (PST)
Date:   Thu, 10 Jan 2019 19:15:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org
Subject: Re: [PATCH v4 2/2] dts: arm64/sdm845: Add node for arm,mmu-500
Message-ID: <20190111031504.GC17247@minitux>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-3-vivek.gautam@codeaurora.org>
 <20190108065935.GA11536@builder>
 <9675f7d8-a726-07d3-34b7-99b7464a6303@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9675f7d8-a726-07d3-34b7-99b7464a6303@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Jan 03:18 PST 2019, Vivek Gautam wrote:

> 
> On 1/8/2019 12:29 PM, Bjorn Andersson wrote:
> > On Thu 11 Oct 02:49 PDT 2018, Vivek Gautam wrote:
> > 
> > > Add device node for arm,mmu-500 available on sdm845.
> > > This MMU-500 with single TCU and multiple TBU architecture
> > > is shared among all the peripherals except gpu.
> > > 
> > Hi Vivek,
> > 
> > Applying this patch together with UFS ([1] and [2]) ontop of v5.0-rc1
> > causes my MTP reboot once the UFSHCD module is inserted and probed.
> > Independently the patches seems to work fine.
> > 
> > Do you have any suggestion to why this would be?
> 
> 
> Hi Bjorn,
> 
> Enabling SMMU on sdm845 when you have UFS also enabled, would need addition
> of
> 'iommus' property to ufs dt node.
> You will need to add the following with ufs:
> 
> iommus = <&apps_smmu 0x100 0xf>;
> 

Thanks, this do address the sudden restart of my MTP, but provides a
fault.

[    7.391117] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffdf3e0, fsynr=0x290000, cb=0
[    7.747406] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11

The only thing done ontop of v5.0-rc1, is to take your patch adding
apps_smmu, add the ufs nodes as Evan proposed and specify iommus in the
ufshcd node.


With Coreboot UFS seems to work without specifying iommus, but with it
UFS fails to come up.

Regards,
Bjorn

> Thanks
> Vivek
> 
> > 
> > [1] https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen@chromium.org/
> > [2] https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen@chromium.org/
> > 
> > Regards,
> > Bjorn
> > 
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > ---
> > > 
> > > Changes since v3:
> > >   - none.
> > > 
> > >   arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 72 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index b72bdb0a31a5..0aace729643d 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1297,6 +1297,78 @@
> > >   			cell-index = <0>;
> > >   		};
> > > +		apps_smmu: iommu@15000000 {
> > > +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> > > +			reg = <0x15000000 0x80000>;
> > > +			#iommu-cells = <2>;
> > > +			#global-interrupts = <1>;
> > > +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> > > +		};
> > > +
> > >   		apss_shared: mailbox@17990000 {
> > >   			compatible = "qcom,sdm845-apss-shared";
> > >   			reg = <0x17990000 0x1000>;
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 
