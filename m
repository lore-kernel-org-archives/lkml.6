Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B0CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902DD20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBj49i9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfA3Sfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:35:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45979 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733011AbfA3Sfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:35:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so406057ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz1pJJHxFDjHYDa5FNImunQFYutxZ8wy7/pKlBaS2E0=;
        b=MBj49i9BZps1u5Jgm124BfF4vUDqnjlxGywDrDT3pg6LUlgS8dDFSTIC8iXO0P9zw5
         a0lLJ8AO1ydAxu6UeYNp/6Tcck53RVHTMoYfi+tjPB39bRM9vLxUnolRzFcqTitNEoog
         Ms2oVXkF/2VFPWIKH/U0gUp1iyWlW4NlYxUDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz1pJJHxFDjHYDa5FNImunQFYutxZ8wy7/pKlBaS2E0=;
        b=qrBONHYsgojJ2WIPA4TBzybsPaCi7ppU7OlxeHkYxzy4X5eBsfJdIqPwucdnQryajy
         6MDLFSugktxlUK9CUQ5MSf5ixe1vW7+lPipZqlGNItf85HdPoO0ScUd0K7V2S8Vi/R0b
         KjUt4efNi5GxCNtQzXabrKKR7QVdmndgpZwcEG9WVSFHDLZz8R6Hp0YNT2FoU0m0vU0N
         +G/97hr02TbGoQQwdDMqcRNwSfMI9+G2VvEBM+Ob2h20C/vq6fJdPsO/OLtwAupN7a5g
         GdKWznIy+OGnLcBJNEAfpo67cMFQ5Ol8vn3Jfli8wqtxMflU6dO5ptCvI/RbWclBZjkn
         3wVg==
X-Gm-Message-State: AJcUukeN7wAQW3y0ttVAVawxeAUkxSEaTpEWbhjIRbyP3pd6IT6IVEYi
        ott232RxGdmwvhOfqt3AZW1TQQaWE4w=
X-Google-Smtp-Source: ALg8bN7wS4fTMKzvPCrrR1rwJFYttsKUe2MJs35IWgUMXvja4f379fUrDux0xZnF9EzlKoV2BtYveg==
X-Received: by 2002:a2e:145a:: with SMTP id 26-v6mr24847666lju.116.1548873348530;
        Wed, 30 Jan 2019 10:35:48 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id k68-v6sm404400ljb.35.2019.01.30.10.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 10:35:48 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id e26so421303lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:35:48 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr24301931lfg.101.1548872883637;
 Wed, 30 Jan 2019 10:28:03 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-2-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-2-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 10:27:27 -0800
X-Gmail-Original-Message-ID: <CAE=gft4dQjUw3j52dZJYjvQ4GTf8_KcZOdW5Wn9cFtY9wu_atg@mail.gmail.com>
Message-ID: <CAE=gft4dQjUw3j52dZJYjvQ4GTf8_KcZOdW5Wn9cFtY9wu_atg@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:56 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch adds decriptions for mt8183 IOMMU and SMI.
>
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
>
> The mt8183 M4U-SMI HW diagram is as below:
>
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam

It might be cool to put the gals in the picture in the bindings. Not a
big deal though.

>
> All the connections are HW fixed, SW can NOT adjust it.
>
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
>
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
>
> From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 ++-
>  .../memory-controllers/mediatek,smi-common.txt     |  11 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   3 +
>  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
>  4 files changed, 153 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
>
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index 6922db5..6e758996 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -36,6 +36,10 @@ each local arbiter.
>  like display, video decode, and camera. And there are different ports
>  in each larb. Take a example, There are many ports like MC, PP, VLD in the
>  video decode local arbiter, all these ports are according to the video HW.
> +  In some SoCs, there may be a GALS(Global Async Local Sync) module between
> +smi-common and m4u, and additional GALS module between smi-larb and
> +smi-common. GALS can been seen as a "asynchronous fifo" which could help
> +synchronize for the modules in different clock frequency.
>
>  Required properties:
>  - compatible : must be one of the following string:
> @@ -44,18 +48,23 @@ Required properties:
>         "mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
>                                                      generation one m4u HW.
>         "mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
> +       "mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
>  - reg : m4u register base and size.
>  - interrupts : the interrupt of m4u.
>  - clocks : must contain one entry for each clock-names.
> -- clock-names : must be "bclk", It is the block clock of m4u.
> +- clock-names : Only 1 optional clock:
> +  - "bclk": the block clock of m4u.
> +  Note that m4u use the EMI clock which always has been enabled before kernel
> +  if there is no this "bclk".

Ideally bclk could be specified a little more crisply, as this is
actually required for some SoCs and not used at all on others (as in
patch 7).

>  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
>         Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>         Specifies the mtk_m4u_id as defined in
>         dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> -       dt-binding/memory/mt2712-larb-port.h for mt2712, and
> -       dt-binding/memory/mt8173-larb-port.h for mt8173.
> +       dt-binding/memory/mt2712-larb-port.h for mt2712,
> +       dt-binding/memory/mt8173-larb-port.h for mt8173, and
> +       dt-binding/memory/mt8183-larb-port.h for mt8183.
>
>  Example:
>         iommu: iommu@10205000 {
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> index e937ddd..8d3240a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> @@ -2,9 +2,10 @@ SMI (Smart Multimedia Interface) Common
>
>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>
> -Mediatek SMI have two generations of HW architecture, mt2712 and mt8173 use
> -the second generation of SMI HW while mt2701 uses the first generation HW of
> -SMI.
> +Mediatek SMI have two generations of HW architecture, here is the list
> +which generation the Socs use:
> +generation 1: mt2701 and mt7623.
> +generation 2: mt2712, mt8173 and mt8183.
>
>  There's slight differences between the two SMI, for generation 2, the
>  register which control the iommu port is at each larb's register base. But
> @@ -19,6 +20,7 @@ Required properties:
>         "mediatek,mt2712-smi-common"
>         "mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
>         "mediatek,mt8173-smi-common"
> +       "mediatek,mt8183-smi-common"
>  - reg : the register and size of the SMI block.
>  - power-domains : a phandle to the power domain of this local arbiter.
>  - clocks : Must contain an entry for each entry in clock-names.
> @@ -30,6 +32,9 @@ Required properties:
>             They may be the same if both source clocks are the same.
>    - "async" : asynchronous clock, it help transform the smi clock into the emi
>               clock domain, this clock is only needed by generation 1 smi HW.
> +  and these 2 option clocks for generation 2 smi HW:
> +  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> +  - "gals1": the path1 clock of GALS(Global Async Local Sync).

It would also be nice to specify these more clearly too, since these
are also required for some SoCs and not used on others (as in patch
12).
