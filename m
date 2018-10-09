Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD09C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5518B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU7DKNL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5518B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJINUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:20:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51769 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJINUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:20:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so522663wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/9x/4vj7eZ23L89xUG7TNcQWpb2iVKY1xsgc6Wno+ZE=;
        b=DU7DKNL2G5flrz3ZvsAZcP4ZRMmUqBxLXmLV8qEV377xV4u76q74eABrrBCDbojUJ/
         8krB8WjsZfNm3eW6q5R3Y5YgAsmLISowNzU8jInwUEfHmk7uC93t8oeOAjMSNDtFFLOv
         Sod9Yu+7qgDTPj2SA3MKCCCJe1jqLyPOjCnjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/9x/4vj7eZ23L89xUG7TNcQWpb2iVKY1xsgc6Wno+ZE=;
        b=Ddp2iofV45OOg+EbqihI3NRESOAe2+hpkk/42rRdSxp+SzUNmLwv3MHxAdvcXJPcpl
         PSK8HJMOYGKmWMeXIwVbiYoNnKWRrlPnKsN2cNQOv0AtAGavbmfrmBMrwF1zwcZvBOzr
         f9foxhwd48Avv1Aj4QT/Gx50Dl+RenozxQc0liyu27m9Nfp6DEJASfb+FAxrbhgbNkQn
         /RNK8EWdVNlFNEuPea0mAE28zW8GU2gHQmWgiiS0U/BLdjweGiuLiexXoMhpNnAzmmwq
         AVpMGKZKMTxwtEU9GKI0bkDsxC/GftnLFMlOCev78wVzd2mYA7/O/8Lspfrz9ItH7YC8
         zTJg==
X-Gm-Message-State: ABuFfoiYCdErJVIiB4qrPQK5nHfakVwbHd6/frFYvouuTMSgrkE5oRyX
        5/chsVqNlq2vQC63Vg+4/RFY7Q==
X-Google-Smtp-Source: ACcGV60jCFSNc0nu4ZopSPUaZbhXfxih1WuOMfwN7vhlufLhoI0vy1bU5pVu/dwki/d2PYnWRE56hg==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203-v6mr685003wmc.62.1539065083396;
        Mon, 08 Oct 2018 23:04:43 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id c2-v6sm13855227wrt.77.2018.10.08.23.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:04:42 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:04:40 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@collabora.com, cl@rock-chips.com
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Message-ID: <20181009060440.GB4324@dell>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
 <20180910144924.GU28860@dell>
 <2092357.WrANtTvkTV@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2092357.WrANtTvkTV@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Heiko Stuebner wrote:

> Hi Lee,
> 
> Am Montag, 10. September 2018, 16:49:24 CEST schrieb Lee Jones:
> > On Tue, 14 Aug 2018, Enric Balletbo i Serra wrote:
> > 
> > > The "atomic" API allows us to configure PWM period and duty_cycle and
> > > enable it in one call.
> > > 
> > > The patch also moves the pwm_init_state just before any use of the
> > > pwm_state struct, this fixes a potential bug where pwm_get_state
> > > can be called before pwm_init_state.
> > > 
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > 
> > > Changes in v3:
> > > - Get rid of duty_cycle variable from pwm_backlight_update_status.
> > > - Get rid of pb->enabled and use only the status.enabled variable.
> > > - Make power_on match power_off.
> > > - Do not share status between ...update_status and ...power_on
> > > 
> > > Changes in v2:
> > > - Do not force the PWM be off in the first call to pwm_apply_state.
> > > - Delayed applying the state until we know what the period is.
> > > - Removed pb->period as after the conversion is not needed.
> > > 
> > >  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
> > >  1 file changed, 42 insertions(+), 39 deletions(-)
> > 
> > Applied, thanks.
> 
> did this miss some push or so, because looking at [0], I don't see
> any new patches for a while now?

Yes.  It has been applied locally for a while though, so don't worry.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
