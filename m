Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E315DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407420879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVimNEqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A407420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeLEVo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:44:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41133 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeLEVo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:44:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so2284312ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEeJHAAiSGsLcB7FfbD7q9ilLJGsNKJ++qp+PPJmZZs=;
        b=cVimNEqGh3m4R1bKKyCfw0n6eCWEBhBGMdMAEXhYGV2YgU2hzCbEqqyZvepsN06IB7
         v8ekRsvc6bs0iWLt656e4RQt2tY4t1qTYOMmvZ+3kc6G1PCKTcLPJy4vd3I8f1SRhfOB
         f2hyOkXfxLhgAkknhO1SikvTUojk1NxErh/xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEeJHAAiSGsLcB7FfbD7q9ilLJGsNKJ++qp+PPJmZZs=;
        b=BdvixCfL9jDJWcJ3VOoOrjN8A6k5C0V3Vev2dseXOFBiU3VGDKZbBK7aZkLGtBijed
         YUf9A0WjAc1bITZZOqd88o0Z5ZYlqOIz0ftd9TaOJToS21JrIBc7zvYb+eNqSnnQvgRc
         YLBPd+QEiOJejjHDqnBM4eAHfNBm68pj+07Nf+i+OLwvuJSPUKfd3NKz+SEJCCLbkI2g
         mnMg13uMQLOSscObYQi1Wm2ZtT/Dv+qmi+VogXofZ8SvAvVmgIVV9qSfZ7jwBraqD2rG
         h7m66KaT/Iw9Ik5YeRNGb9c/SH9Wjrklfe9wvO3ocLC5m+/++oIaAMBQfjovcOt9f+pG
         m1uw==
X-Gm-Message-State: AA+aEWb7rGHO52y17GI28SGWRdqIe8sotmXaf3uxyognOedN7tK11jfU
        k0PT1Nxz4EEX65rdVqyoh1S4aq8wnr0=
X-Google-Smtp-Source: AFSGD/XRH6E6/TzmEnpXf3vMZSeb0A69C+AaY8zy4y0R2q5umYZHBP//Ow7/yleEAq8aK/6SK0Fu8g==
X-Received: by 2002:a2e:5d12:: with SMTP id r18-v6mr18401441ljb.89.1544046264968;
        Wed, 05 Dec 2018 13:44:24 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id r4sm3813928lfe.60.2018.12.05.13.44.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:44:24 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v15-v6so19728555ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:44:23 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr18174084ljh.174.1544046263003;
 Wed, 05 Dec 2018 13:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20181128223428.177313-1-evgreen@chromium.org> <20181128223428.177313-4-evgreen@chromium.org>
 <CAD=FV=VtKpbL3-Wt8ctcmTG0_-YzgEv3xXZGd8xV=RsgAhof1A@mail.gmail.com>
In-Reply-To: <CAD=FV=VtKpbL3-Wt8ctcmTG0_-YzgEv3xXZGd8xV=RsgAhof1A@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 Dec 2018 13:43:46 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ffHt8GzyZXzG0uJdYUSmzWk7mGu7Y-E=Oh+PSBQoepg@mail.gmail.com>
Message-ID: <CAE=gft7ffHt8GzyZXzG0uJdYUSmzWk7mGu7Y-E=Oh+PSBQoepg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        mark.rutland@arm.com, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 1:19 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Nov 28, 2018 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
> > +&sdhc_2 {
> > +       status = "okay";
> > +
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_cd_odl>;
> > +
> > +       vmmc-supply = <&vreg_l21a_2p95>;
> > +       vqmmc-supply = <&vddpx_2>;
> > +
> > +       cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
> > +};
> > +
> >  &qupv3_id_1 {
>
> Please sort alphabetically.  "s" comes after "q".

I've got A through F down cold, but those later letters are spotty :) Will fix.

>
>
> > +       /* It seems that mmc_test reports errors if drive strength is not 16. */
>
> Possibly put this comment right next to one of the the "drive-strength" lines?

Ok.

>
>
> > +       sd_cd_odl: sd-cd-odl {
>
> "sd_cd_odl" is the name on a different board.  On sdm845 this is
> 'sd_card_det_n", so it'd be better to use that name.
>
>
> > +               pinmux {
> > +                       pins = "gpio126";
> > +                       function = "gpio";
> > +               };
> > +
> > +               pinconf {
> > +                       pins = "gpio126";
> > +                       bias-pull-up;
> > +                       drive-strength = <2>;
>
> Maybe leave this off?  According to Bjorn's research "drive-strength"
> has no affect on inputs and this is most certainly an input.

Sure. Spin coming up.

>
> -Doug
