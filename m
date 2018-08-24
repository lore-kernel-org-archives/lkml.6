Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBE5208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MAmThqjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBE5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeHYBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:51:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42896 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeHYBvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:51:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so5130859pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7Ogc/oXRP8VDylGTGuLopZkokuBEbXpPp6EF+M2P4Q=;
        b=MAmThqjI4oa7WY0Mm4niSA+KVkSmz6qGiSJfoxcvFnPohj191ejtwwj/PfNqpRqrbz
         LWCiI9oOQZZntPML9hSFoMpY9RwtRoddUxa1d0haHg7yjH14y9POnm2+5zHVwjklZZmY
         f5Y9dhs0+AtDAfNRCHl3D7V9xRoSPSVH6Pkgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7Ogc/oXRP8VDylGTGuLopZkokuBEbXpPp6EF+M2P4Q=;
        b=qEzR1Xyf4/sMDlujuVn6GerNDaG3Mjy2CUwVUT+t5/R+BzdUsqOV1yIJEtMalPF8Ef
         zBElqmpPEMHcwgAWPQmfVwZBdCV6vVhwepdrxqG5VBfysNwmc8pu3b2uDYEKQ/LB4WPI
         amvsogH6Y2tsYqnIaw4S4VAJMvCjcbXFKG1dC+I1WoYtBPCdsGLzZPzvwWPiSpvgXI39
         uY1mpUe7j6NYwjoXjMG9c17W/3q7LVkDP8h3gWBFN0wR+IT+SZDLxEwhRDQkTP+65NBF
         O3QR7D/oKsCRv3qR+Sp3+V9CR7yL775eE414vXTP5lhgKCeB2W96Wjq2s4EN+Bzpc7dq
         qoQA==
X-Gm-Message-State: APzg51CTVcfFdNXUiHw45A+j8qrZ9angWJyCbCxeL6xRaqGj4HCnNqH8
        NXF9/wWD5vlvD76NoINSqBlf2g==
X-Google-Smtp-Source: ANB0Vdbrtd0Mvej2D3wj3CnJuHklb5wjrNiHbCgKorMFcgfW6CGSohBRqBMyMFnpPifQG7Edaz4DkA==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr3760634pfi.109.1535148880953;
        Fri, 24 Aug 2018 15:14:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v19-v6sm28162439pgn.94.2018.08.24.15.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 15:14:40 -0700 (PDT)
Date:   Fri, 24 Aug 2018 15:14:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU
 to rev2 channel list
Message-ID: <20180824221439.GT160295@google.com>
References: <20180810194702.144641-1-mka@chromium.org>
 <20180819175452.31e0906b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180819175452.31e0906b@archlinux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 05:54:52PM +0100, Jonathan Cameron wrote:
> On Fri, 10 Aug 2018 12:47:02 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
> > rev2 ADC channels.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> This is fine and applied to the togreg branch of iio.git.
> Pushed out as testing to let the autobuilders play with it.

Thanks!

> However, I took a quick look and can't immediately see what prevents us
> specifying channels in DT that don't have these definitions in the driver.

Indeed, the DT could just specify an arbitrary value.

> Should we have a check for that as at least superficially it seems like
> a bad idea!

It seems there isn't a single contiguous range, but a very superficial
check could at least verify that the value isn't larger than CHAN_MAX
or check a few sub-ranges.

> > ---
> >  drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index a4299417f3de..1f9298a5c83d 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
> >  					SCALE_HW_CALIB_PMIC_THERM)
> >  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > +	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
> > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
> 
