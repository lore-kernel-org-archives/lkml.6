Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72775C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC932064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqwQL3ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC932064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeJ3D1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:27:54 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39269 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbeJ3D1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:27:54 -0400
Received: by mail-ua1-f66.google.com with SMTP id j38so3432749uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6q+mNR4wPMMnGdcKzLeW+W3mMTI2m08qGqio7AhisY=;
        b=OqwQL3kyVIVQpkwrNOH7ZB0dZighlsej+FjGZJpKf8BGWsorL0ULgVo4ibBB2FMx8f
         poJKMf3WOuC4sKIcbF90w7fhn8Ts+feiO2B2K9aJVDYrHH0dVMtGb9WnbNGOWlcKKZrX
         kwyNNpUPyEHxjo8PEl2kd6ntcRbhbLDflMNto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6q+mNR4wPMMnGdcKzLeW+W3mMTI2m08qGqio7AhisY=;
        b=nISuLVmtDNCy90aDX+Fpj6JGj3NgXwj0lxKnsM3n/VrRPDsFYDQ7Jlg2lSLedb85Ku
         olDwlHz9BMI62mty/1THSGQlBNkwQWQzwIy8HmVlydvwYuX0DzRnzgx+sxj3QPvKRTpH
         oPvRi64EFtPg+lDusi/aj0shVPDf9e7PGa2cGqSQ7ISjs8VXQTEOgZHpL5J8isUsAJqr
         guDHLo8gRCvb77xbGbc3plgCIgDdRERT4/ogM2La79gM+srzmtjoyH1TqwdER525xjZ1
         FvWvEhsIuCltfGEmp6dDeratun+gH32PtgtsXVSjY3uDfXrOHKBlvvgg4YsH3UxDv3ev
         tgKg==
X-Gm-Message-State: AGRZ1gL+fWgZda9GYkH9ngUnjR+0QKymNK2vrIrSrBkOjX6kaJnYC6D+
        99ChppBP4O24DHGoS8vblE6D6tqWWuk=
X-Google-Smtp-Source: AJdET5c0825W+IAdlMjH0Lcm8ptvW2UdwKvASaDIpdNI8FcnWMGxkI85p9U0yQJ9OguysESJ0sFPzQ==
X-Received: by 2002:ab0:30d8:: with SMTP id c24mr141278uam.44.1540838280527;
        Mon, 29 Oct 2018 11:38:00 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j7sm5728365vsd.17.2018.10.29.11.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:37:59 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id j124so2708939vsd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:37:58 -0700 (PDT)
X-Received: by 2002:a67:b20e:: with SMTP id b14mr6472811vsf.121.1540838278336;
 Mon, 29 Oct 2018 11:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181026122745.5094-1-sibis@codeaurora.org>
In-Reply-To: <20181026122745.5094-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Oct 2018 11:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xf7NXTV_OtBePn9QUQbzdkMxdYg-yRua_6SbV-av3P+g@mail.gmail.com>
Message-ID: <CAD=FV=Xf7NXTV_OtBePn9QUQbzdkMxdYg-yRua_6SbV-av3P+g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add reserve-memory nodes
To:     sibis@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, benchan@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 26, 2018 at 5:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add reserve-memory nodes for mpss and mba required for
> remoteproc mss pil.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d3fe012ad84e..f74892e447f9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -88,6 +88,16 @@
>                         reg = <0 0x86200000 0 0x2d00000>;
>                         no-map;
>                 };
> +
> +               mpss_region: reserved-memory@8e000000 {
> +                       no-map;
> +                       reg = <0 0x8e000000 0 0x7800000>;
> +               };
> +
> +               mba_region: reserved-memory@96500000 {

nit: All of the other reserved memory in this same section just has
the node name "memory".  Can you please follow suit?  Also above.
This is the kind of thing that Rob H. usually cares about doing right.

> +                       no-map;
> +                       reg = <0 0x96500000 0 0x200000>;

nit: All of the other reserved memory in this same section has "reg"
above "no-map".  It doesn't matter a whole lot, but why not make it
match everyone else?  Also above.


-Doug
