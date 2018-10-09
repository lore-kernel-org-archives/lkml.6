Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5572720835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVIks5Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5572720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJIRZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:25:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50861 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:25:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so1233784wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wf56raxll4Qn0FhDS1ZTCZJ4Ds3hdNwal65QjE4jh9U=;
        b=NVIks5Xo30CaGmCTRl4RX4D+wTsq3t4v/yXMZRHE05DuhPZubwgSvvQ7DyfT5hnVAx
         c/EIX51B65sLf2RWfnvYHmxB3QzGipC5jwkw8A9qd1DQVBR6izMDXUdAQGT/zpGyy6eb
         jrXpykqVfHUph1HEVI2K63oV2DYZLqzQuciTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wf56raxll4Qn0FhDS1ZTCZJ4Ds3hdNwal65QjE4jh9U=;
        b=qcnWZP5jvsf8e2c5i7cVbl1oDzTQn3GDhpHDk8zal2rSCtOkT/4Tz//fjntZen8RDI
         s8dmdMpnFNt3pV4VTnrpwvPsh1RJzVeu3kgVLlVgc52tlw49Pmw/55dpn5blhlme3uic
         Gs0km2G9qGIoKZoOWN31rHAZH72cf2azy2xACA2gvM4Gj8CFPjvogBhSUh3WyTfcN2H8
         XP7/9A/61DPAsUcN0/jEvuadTwmz/hRimwpA6gdz9pYvNzQI6kI6WhXjMIoIqPHl07yW
         xQ0xrJrUmpySDcUzux8N6z+m7Hqj2gkZoLpGgkre8WZs/5TpM/y4c6JaTBuXuowbR7T6
         Xdag==
X-Gm-Message-State: ABuFfogbDhe0kc7PNHZEOPYSr2OqO2kRB5Jgvhg7MQKG77ijnuQrVnDA
        PDLmG6XRytl3SOv3U8qWwyCUdw==
X-Google-Smtp-Source: ACcGV62FUo/BJes3dVFhQGQ/qmc5a/aTrEPeie120vrOhAMtI6p/u1bTYmaW3C574ofp0Y6o2Akn8w==
X-Received: by 2002:a1c:7e57:: with SMTP id z84-v6mr1482183wmc.43.1539079776792;
        Tue, 09 Oct 2018 03:09:36 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id v14-v6sm7564315wrw.28.2018.10.09.03.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:09:35 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:09:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] mfd: cros_ec: Avoid unneeded internal declaration warning
Message-ID: <20181009100934.GK4939@dell>
References: <20180927033316.9784-1-natechancellor@gmail.com>
 <20180928011614.GA3681@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928011614.GA3681@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Nathan Chancellor wrote:

> On Wed, Sep 26, 2018 at 08:33:17PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > drivers/mfd/cros_ec_dev.c:509:40: warning: variable 'cros_ec_id' is not
> > needed and will not be emitted [-Wunneeded-internal-declaration]
> > static const struct platform_device_id cros_ec_id[] = {
> >                                        ^
> > 1 warning generated.
> > 
> > Avoid this warning by adding it to the cros_ec_dev_driver definition
> > under the id_table member like all other platform drivers.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > I looked at several drivers with platform_device_id defintions and I
> > didn't really find any where the definition wasn't then added to the
> > platform_driver so I'm not sure if this was just missed in commit
> > afbf8ec7c4f9 ("platform/chrome: cros_ec_dev - Add a platform
> > device ID table") or if it was an intentional omission. I'm not super
> > familiar with the inner workings of platform devices.
> > 
> > Should this commit be undesirable, the warning can be silenced with the
> > __used attribute but this seemed like a more proper first commit.
> > 
> >  drivers/mfd/cros_ec_dev.c | 1 +
> >  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
