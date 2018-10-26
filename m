Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3858ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D612086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dyqVoGBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D612086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJ0CEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:04:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35296 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJ0CEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:04:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so1505175lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FEh8sTdFKlSTkUlAMcTG6ttwnSALhfb5mXuBJsrGAU=;
        b=dyqVoGBxnCczXIbYExYyBTO/73zs+TJ+QbKIivq8S1/16frbeZU/A7F7XirjKsnYah
         O+HXpiQTKfjjxmZPuknaGtoHhAjNHgbCBcd2XbgBe+mW53GTqEG9ZfdrzqlzGhb0C1gn
         TOvotZJZ4X2ZA7TiVFTKq8f5N5tLfo9pSpskA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FEh8sTdFKlSTkUlAMcTG6ttwnSALhfb5mXuBJsrGAU=;
        b=pfV9AHvdA8/S2c/E7OK1griKv2bdLUpaqV4XX4gzW6eEnFfqRterSN6QKNguAimH1l
         tGf8pHEbVluofXGFBA/cHDUp2cTpbYNGyrxwJxoGaO2VhHsUH3qiazpTK42AFRKvzWbn
         dA35w4E99wNyANKT+XuWJv9uWd0U/cCPMNrAtTD5k+9M7hAzMu1+SzW22RZnH7FRhLVy
         FRMwxkwD4dCBFQgYTdUkzzbeMenVnAtmlRnplKmQwBpdetLSf2+kOOWWSnMdtRhw+s0s
         xdhHa2R3xw3wsujOkDP0FlXqrcsX8BZrgvoBIn1DewPYOEjX5WtKw/n/NrmzJoxZr5dj
         9Z1w==
X-Gm-Message-State: AGRZ1gKAlcEWHn8xRnZc816g9Mg6VmktO8e0ZZkGkeBUoBcu7370Wi5k
        XDkgzR3Vi3JnEre/iffdaJg5cnvx7Fk=
X-Google-Smtp-Source: AJdET5eTaa9w6JTcd6mtePACCIDi4Qy41ZmsjI3LUGxZT25eHvW5NeBLV14g+8rpxPpHeEY2NxDTvQ==
X-Received: by 2002:ac2:4299:: with SMTP id m25-v6mr2680436lfh.115.1540574792491;
        Fri, 26 Oct 2018 10:26:32 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i2-v6sm354365ljc.94.2018.10.26.10.26.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 10:26:31 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a82-v6so1494464lfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:26:29 -0700 (PDT)
X-Received: by 2002:a19:4287:: with SMTP id p129mr1775322lfa.135.1540574789407;
 Fri, 26 Oct 2018 10:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181025172318.31353-1-mgautam@codeaurora.org> <CAD=FV=Xk0VDp2mQ9B25XXovabiHAHr=Dm1v3Pavf_iaNGOexnw@mail.gmail.com>
In-Reply-To: <CAD=FV=Xk0VDp2mQ9B25XXovabiHAHr=Dm1v3Pavf_iaNGOexnw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 26 Oct 2018 10:25:52 -0700
X-Gmail-Original-Message-ID: <CAE=gft5vEfqxXhC+cADYreRGtj68PnwFnXoFknh8mP5UWYHsHQ@mail.gmail.com>
Message-ID: <CAE=gft5vEfqxXhC+cADYreRGtj68PnwFnXoFknh8mP5UWYHsHQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sdm845: Fix pcs_misc region address
 for UNI PHY
To:     Doug Anderson <dianders@chromium.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        vivek.gautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 1:38 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
> On Thu, Oct 25, 2018 at 10:23 AM Manu Gautam <mgautam@codeaurora.org> wrote:
> >
> > Correct address for pcs_misc register region of USB3 QMP UNI PHY.
> > These registers are used during runtime-suspend/resume routines
> > of phy.
> >
> > Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> > Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index b72bdb0a31a5..84bee81562a5 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1156,7 +1156,7 @@
> >                                 reg = <0x88eb200 0x128>,
> >                                       <0x88eb400 0x1fc>,
> >                                       <0x88eb800 0x218>,
> > -                                     <0x88e9600 0x70>;
> > +                                     <0x88eb600 0x70>;
>
> Whoops, sorry for not noticing this earlier.  Thanks for the fix!
>
> Evan's most recent patch to the bindings [1] should also be fixed
> eventually too.  It feels like those patches have gone through enough
> spins though, so maybe we can just post this fix atop those?
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> [1] https://lkml.kernel.org/r/20181024172735.154304-2-evgreen@chromium.org

I'll spin mine. Incoming!
