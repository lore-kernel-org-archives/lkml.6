Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03AAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797742186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfBFN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:59:44 -0500
Received: from ns.iliad.fr ([212.27.33.1]:52438 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfBFN7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:59:44 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 377F221A34;
        Wed,  6 Feb 2019 14:59:42 +0100 (CET)
Received: from [192.168.108.68] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1622121A1F;
        Wed,  6 Feb 2019 14:59:42 +0100 (CET)
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
References: <20181012213926.253765-1-dianders@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1ca83453-89e1-82c1-2720-987407bd9fa8@free.fr>
Date:   Wed, 6 Feb 2019 14:59:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181012213926.253765-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Feb  6 14:59:42 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 23:39, Douglas Anderson wrote:

> If you look at the bindings for the UFS Host Controller it says:
> 
> - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
>               also list one or more of the following:
>                  "qcom,msm8994-ufshc"
>                  "qcom,msm8996-ufshc"
>                  "qcom,ufshc"
> 
> My reading of that is that it's fine to just have either of these:
> 1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
> 2. "qcom,ufshc", "jedec,ufs-2.0"
> 
> As far as I can tell neither of the above is actually a good idea.
> 
> For #1 it turns out that the driver currently only keys off the
> compatible string "qcom,ufshc" so it won't actually probe.
> 
> For #2 the driver won't probe but it's not a good idea to keep the SoC
> name out of the compatible string.
> 
> Let's update the compatible string to make it really explicit.  We'll
> include a nod to the existing driver and the old binding and say that
> we should always include the "qcom,ufshc" string in addition to the
> SoC compatible string.
> 
> While we're at it we'll also include another example SoC known to have
> UFS: sdm845.
> 
> Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index 2df00524bd21..69a06a1b732e 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -4,11 +4,14 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
>  Each UFS controller instance should have its own node.
>  
>  Required properties:
> -- compatible		: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> -			  also list one or more of the following:
> -					  "qcom,msm8994-ufshc"
> -					  "qcom,msm8996-ufshc"
> -					  "qcom,ufshc"
> +- compatible		: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0"
> +
> +			  For Qualcomm SoCs must contain, as below, an
> +			  SoC-specific compatible along with "qcom,ufshc" and
> +			  the appropriate jedec string:
> +			    "qcom,msm8994-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +			    "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +			    "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  - interrupts        : <interrupt mapping for UFS host controller IRQ>
>  - reg               : <registers mapping>
>  

Tweaking CC list.

Martin, this one's for you, according to Rob ;-)

https://lore.kernel.org/patchwork/patch/999046/

FWIW, it has already been:

Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>

Regards.
