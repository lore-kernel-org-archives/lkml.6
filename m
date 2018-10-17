Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C22ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386882150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RW+kydhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386882150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJRAIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:08:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34163 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJRAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:08:23 -0400
Received: by mail-vs1-f67.google.com with SMTP id q15so6840755vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzRLyX6uES2dOIWmXA/MqMQUxJNWjgiy74t6SwzRozs=;
        b=RW+kydhuyojLwIvtOUKIx98A8okPoqeqGuFEUtxZjMzc7cRrfuRDFHYqL0E+w0y5Pf
         1B5YSVAHwoumlx4zeytEunLFGLou+uKEXoTTLRzkDElZaFJA2uVVPuucmfOGr4lrbA+L
         3TfNTHTK1Hu0IfWq6vNKPJnHZsOAON5x7ULZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzRLyX6uES2dOIWmXA/MqMQUxJNWjgiy74t6SwzRozs=;
        b=Am5/8GQUh5x8jmINMJ2HNCNPusk4hy81sd8axsjhhMfhhUhds03sz2iNg5hlpjMGOt
         lEEpAPNAOitAGFiUDwpXHK2O23cU6E1kUPfey1rJ45N+yzF/mtBUYBqL4WNVgkWT1uy8
         T9GP70gORqtLNZSo5jduaay2kGt3SwbAO9glqbCI0qIWUx3lr/Lbqwm2ZKLx3fAtP0dX
         jjs0c0sAI3/nx251RsjTCbvqs39EwQoGEBKFwzUQ5xKfd2o9edhFZAuriYJwkn2kVxzA
         Oa1Fw4GFOg6EYbCVfv+Y4umFnDCJm/FZWLPw71XYAF0EhMxWzHV1qDU6S1KzWNO23Sxj
         SCUA==
X-Gm-Message-State: ABuFfogwYwEdGq4Zlbx9JZie/znLa8lPmiSm1VcM6hLacIr22pGbpeZt
        khHOaSmbgvItuAiiLe0E+jlus5hTrOs=
X-Google-Smtp-Source: ACcGV62msCNAnSlTQA+xC7a5lpNzDLmveOUv5WRWuK4nBz5BcY3iLN9iwK62MSQ/iyYqrJxL5sOgnA==
X-Received: by 2002:a67:ea05:: with SMTP id g5mr2991150vso.61.1539792718353;
        Wed, 17 Oct 2018 09:11:58 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id c6sm3056303vsg.20.2018.10.17.09.11.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:11:57 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id w85so21130706vsa.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:11:56 -0700 (PDT)
X-Received: by 2002:a67:1144:: with SMTP id 65mr2895516vsr.213.1539792715912;
 Wed, 17 Oct 2018 09:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org>
 <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
 <CAD=FV=WYM5OOigy+81cVzPtAJXhvrhB1znr9zHzMf3q5iFOtFw@mail.gmail.com>
 <CAFp+6iGxvDoptnjM18ggnHqX6MV0+HFqsnCMi61b8gquBxaYmw@mail.gmail.com>
 <CAD=FV=XWC8q4Cx4GF0yXCgj2APwd5ZfccVBC_ORwnJg0vRsS7A@mail.gmail.com> <1ce7b24c-b154-4ce6-2b4c-9eb0fd0d71cb@codeaurora.org>
In-Reply-To: <1ce7b24c-b154-4ce6-2b4c-9eb0fd0d71cb@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Oct 2018 09:11:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XSjfRSHP6B6GtiTqrQuUZaoA=hZNW_L1=71MU9fEXpDQ@mail.gmail.com>
Message-ID: <CAD=FV=XSjfRSHP6B6GtiTqrQuUZaoA=hZNW_L1=71MU9fEXpDQ@mail.gmail.com>
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

Hi,

On Tue, Oct 16, 2018 at 11:28 PM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Doug,
>
>
> On 10/16/2018 10:29 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 15, 2018 at 10:51 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >>>> P.S.: While you are at it, can you please move 'ufs-qcom.txt'
> >>>> to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
> >>>> The current name and file location is misleading.
> >>> I'd rather someone at Qualcomm do this.  Do you have a suggested
> >>> person?  The reason I feel that Qualcomm needs to get involved is that
> >>> I see that when I look at the file you refer to says it's for:
> >>>
> >>>    "qcom,ufs-phy-qmp-20nm" for 20nm ufs phy,
> >>>    "qcom,ufs-phy-qmp-14nm" for legacy 14nm ufs phy,
> >>>    "qcom,msm8996-ufs-phy-qmp-14nm" for 14nm ufs phy
> >>>    present on MSM8996 chipset.
> >>>
> >>> ...but there's another Qualcomm file, 'qcom-qmp-phy.txt'.  That
> >>> handles the compatible string:
> >>>
> >>>         "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> >>>
> >>> So I'm a little confused.  Should the SDM845 UFS PHY been handled by
> >>> the older UFS PHY driver?  ...or should all the older UFS PHYs be
> >>> moved to be handled by the newer QMP PHY driver?  ...or are they
> >>> really different hardware blocks, in which case how would you describe
> >>> the difference (both are described as UFS QMP PHYs I think).
> >> As you rightly said "ufs/ufs-qcom.txt" describes the bindings for
> >> 14nm, and 20nm ufs phy. These phys are however handled by the older
> >> ufs phy driver present at:
> >> drivers/phy/qualcomm/phy-qcom-ufs-qmp-{14nm,20nm}.c
> >> The sdm845 UFS phy driver is handled by the new consolidated qmp phy
> >> driver: drivers/phy/qualcomm/phy-qcom-qmp.c whose bindings are
> >> described by 'qcom-qmp-phy.txt'.
> >> We didn't attempt to move the 14nm phy to new driver as we already had
> >> 8996 using the bindings.
> >>
> >> So, really these are two separate drivers with different bindings. I
> >> believe it should be okay to move the file. If you are fine, I can
> >> attempt to post a small patch to do that.
> > I guess what I should have said was that the new name you're proposing
> > "qcom,ufs-phy.txt" is confusing and opening the file doesn't help
> > clarify things.  The name and the binding make it sound like this is
> > _the_ file to look at for Qualcomm UFS PHYs.  ...and then you look in
> > the examples in the file and it seems that this even includes Qualcomm
> > QMP PHYs for UFS.
> >
> > ...so while I agree that the file "ufs-qcom.txt" needs to be moved to
> > the "PHY" directory, I think at the same time we need to change the
> > name of the file and maybe the contents to disambiguate which things
> > belong in this file vs. the "qcom-qmp-phy.txt".  ...and I feel like
> > someone at Qualcomm will have the most information to properly do
> > that.
> >
> > For instance, you could call the older bindings
> > "qcom-qmp-phy-14nm-20nm.txt" or something like that.
>
> Sure, I get your point. I will propose something that removes the confusion.
>
> >
> > One point of clarification I'd like to know is if there's really a
> > good reason to have two drivers here.  Certainly if the hardware is
> > really different then a new driver can make sense, but if there are
> > two drivers for arbitrary reasons then maybe they should be combined
> > into one eventually?
>
> Right, the 14nm phy driver can be happily merged into the new qmp-phy
> driver.
> But we should take care of older bindings. Removing the driver will break
> things on targets with older bindings, precisely 8996.
>
> 20nm is bit tricky as it exported few APIs directly to ufs host
> controller, and
> that's the reason we have declared that as BROKEN after the ufs cleanup.
> So, until we are really in a kill mode, the old ufs-phy driver will have
> to live.

OK, sounds like a plan.  I'll assume you're posting the patch to move
the old PHY bindings and add some of the above information to them so
people aren't confused.

...all this is sort off the original subject, though.  ;-)  Just a
quick summary here is that nothing suggests ${SUBJECT} patch shouldn't
land and all the additional discussion has been about making further
improvements to the bindings situation for UFS on Qualcomm.

-Doug
