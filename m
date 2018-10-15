Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BDC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D88C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hkeIVIjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D88C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPBJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:09:43 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:46642 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:09:42 -0400
Received: by mail-vs1-f46.google.com with SMTP id i10so16688578vsm.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgMXBdhtP3xM/XDCfAU2l7yKlvKhT6Oo9lrhmaWrqKU=;
        b=hkeIVIjKq5RiU8ImyT+03pl+oi68/nGZVQmF4/HxXZXUXSELPfpYajCpDaryZgKrKm
         +eBJdgWNZsg9OJX0bqC+tHgedPSFb/zQZzdtWX+9sJS4mEFn/LBreuengvFFavi9DZG3
         Wz11OqJJ69DDmxrta3h13OW3huQzeyoO5vLzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgMXBdhtP3xM/XDCfAU2l7yKlvKhT6Oo9lrhmaWrqKU=;
        b=nPa85LNAcfyWlt634Hx3ZMOas+jLzZx4asaB2NoqC1kopaLhdVFXgLCgjekpxVsetn
         /ZEtddLNWw0zaz0rP9cQJ+UJrWiNmIRNcmUnDQxE+xVuLwv4V5cAtlOD6CfjHGwYdoD8
         /zgNamU3c0FwyJM1r8kxzfdZKY+Nl1Il6inGlOD+4creWwcir9oN0LuWIpwqSY7oOSeY
         Pu2Itu7MXep1WaYcMe526qYLZos2kZVgeVTgqeZXQE1C39HHoMcIdkO4wnTDlNXLx7tQ
         +PJd2wc5+QnwCblDFfUD7lwala8Xe8YF6WhAGWgXNjEvVKGj8b5E3UpHgfQ9XOqBubH7
         VZaA==
X-Gm-Message-State: ABuFfohVyx2zf5FYMWaQChzkD88dgw1yVzys2KeWqWZwAYmm67WfjkDL
        oblO0s6S8MxV43d3esR5k8XSLXEBWtY=
X-Google-Smtp-Source: ACcGV62X2u18VV/7zPFgIqysy3nnCBkvzkWHCEBr40WnTSbIKCUUwR0YIU2bi1C6nQx8aiaCOB92/A==
X-Received: by 2002:a67:3f0f:: with SMTP id m15mr6793801vsa.37.1539624212538;
        Mon, 15 Oct 2018 10:23:32 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id s22-v6sm2214403vke.56.2018.10.15.10.23.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 10:23:32 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id x78-v6so2037686vke.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:23:32 -0700 (PDT)
X-Received: by 2002:a1f:4c86:: with SMTP id z128-v6mr7219328vka.73.1539624211655;
 Mon, 15 Oct 2018 10:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org> <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
In-Reply-To: <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Oct 2018 10:23:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
Message-ID: <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        cang@codeaurora.org, Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayalil@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        devicetree@vger.kernel.org, liwei213@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek,

On Mon, Oct 15, 2018 at 8:23 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Doug,
>
> On Sat, Oct 13, 2018 at 3:09 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > If you look at the bindings for the UFS Host Controller it says:
> >
> > - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> >               also list one or more of the following:
> >                  "qcom,msm8994-ufshc"
> >                  "qcom,msm8996-ufshc"
> >                  "qcom,ufshc"
> >
> > My reading of that is that it's fine to just have either of these:
> > 1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
> > 2. "qcom,ufshc", "jedec,ufs-2.0"
> >
> > As far as I can tell neither of the above is actually a good idea.
> >
> > For #1 it turns out that the driver currently only keys off the
> > compatible string "qcom,ufshc" so it won't actually probe.
> >
> > For #2 the driver won't probe but it's not a good idea to keep the SoC
> > name out of the compatible string.
> >
> > Let's update the compatible string to make it really explicit.  We'll
> > include a nod to the existing driver and the old binding and say that
> > we should always include the "qcom,ufshc" string in addition to the
> > SoC compatible string.
> >
> > While we're at it we'll also include another example SoC known to have
> > UFS: sdm845.
> >
> > Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > index 2df00524bd21..69a06a1b732e 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> > @@ -4,11 +4,14 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
> >  Each UFS controller instance should have its own node.
> >
> >  Required properties:
> > -- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> > -                         also list one or more of the following:
> > -                                         "qcom,msm8994-ufshc"
> > -                                         "qcom,msm8996-ufshc"
> > -                                         "qcom,ufshc"
> > +- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0"
> > +
> > +                         For Qualcomm SoCs must contain, as below, an
> > +                         SoC-specific compatible along with "qcom,ufshc" and
> > +                         the appropriate jedec string:
> > +                           "qcom,msm8994-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> > +                           "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> > +                           "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>
> Thanks for the patch. It looks good to me.
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Thanks for the review!


> P.S.: While you are at it, can you please move 'ufs-qcom.txt'
> to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
> The current name and file location is misleading.

I'd rather someone at Qualcomm do this.  Do you have a suggested
person?  The reason I feel that Qualcomm needs to get involved is that
I see that when I look at the file you refer to says it's for:

  "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
  "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
  "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
  present on MSM8996 chipset.

...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
handles the compatible string:

       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.

So I'm a little confused.  Should the SDM845 UFS PHY been handled by
the older UFS PHY driver?  ...or should all the older UFS PHYs be
moved to be handled by the newer QMP PHY driver?  ...or are they
really different hardware blocks, in which case how would you describe
the difference (both are described as UFS QMP PHYs I think).

BTW: I have a patch attempting to fixup the QMP PHY bindings at
<https://lkml.kernel.org/r/20181012213632.252346-1-dianders@chromium.org>.


-Doug
