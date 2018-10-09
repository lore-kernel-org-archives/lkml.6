Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC03C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E283214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DPUb3RNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E283214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJIXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:33:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34700 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIXdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:33:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so1102926pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=e8U7vS3I4mO5c7L7Cb9CDgtFysq4xkDcXF+v1h2gbXk=;
        b=DPUb3RNeLfCfYuAVz6PmndtTQ5ab/RSKoyGqSfzMc5uxlzt7sm+7RIf2BA89UAHlKS
         Icf3ikPs0cHSTnnxHE3QpTA02vWgI1k2DHTQhx2KiqLYV192GFj1uzM4m8mspFuC6i9E
         QHNm1st542NXudpCR3MbL24xoA1YlB0cKlPd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=e8U7vS3I4mO5c7L7Cb9CDgtFysq4xkDcXF+v1h2gbXk=;
        b=WCIb02BlswG/PWeyRxQE2aBiLE+88x5tR/S2frWJ1XdEqmSRy5R8QXfHOjmHA6tYlH
         ZsBe5gIqIE2Zd9gV1jiUmcWDKtNImZoIudGerdqHW9glhAPWMitLX36WGR8Kd4nIUuty
         J3i1QU+WhMf0YR9qbHiDRWJFSOPrKlIM4B4rqtAiaru7fN+1/441w9j5qhmmEZ1QOr7X
         Y90ctX+qNR8CgTAD4TY6uRwj7ihkmGmx8yOplxBrYk7sUDGyHmyAYlgdTX+O6xHtaR8h
         QbxjmTMRfSGDsgWrT1RemJfB744fGhE/pa9fSV7FY8qW65fSMsXDBDuojwlYRuM5UpQ1
         eO3Q==
X-Gm-Message-State: ABuFfoi2LB+KFUmPmGtuxbrB55QM9XsGPPMkLBCTM9z0kfEb9YeGbyyK
        WOQC3WTF/rjNAmjcwTn/ciroTA==
X-Google-Smtp-Source: ACcGV60gLEDt5GGWYaegU5j3DjKO3FHPY+JcrCyuavnmvtRTOI3asxfRCIWNN53UV59yJEy0uuuocA==
X-Received: by 2002:a63:5a54:: with SMTP id k20-v6mr26385152pgm.297.1539101754892;
        Tue, 09 Oct 2018 09:15:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id y85-v6sm37318521pfa.120.2018.10.09.09.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:15:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lee Jones <lee.jones@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180928011614.GA3681@flashbox>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180927033316.9784-1-natechancellor@gmail.com>
 <20180928011614.GA3681@flashbox>
Message-ID: <153910175330.119890.2963290473787316949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] mfd: cros_ec: Avoid unneeded internal declaration warning
Date:   Tue, 09 Oct 2018 09:15:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2018-09-27 18:16:14)
> On Wed, Sep 26, 2018 at 08:33:17PM -0700, Nathan Chancellor wrote:
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index 999dac752bcc..8f9d6964173e 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -546,6 +546,7 @@ static struct platform_driver cros_ec_dev_driver =
=3D {
> >               .name =3D DRV_NAME,
> >               .pm =3D &cros_ec_dev_pm_ops,
> >       },
> > +     .id_table =3D cros_ec_id,
> >       .probe =3D ec_device_probe,
> >       .remove =3D ec_device_remove,
> >       .shutdown =3D ec_device_shutdown,
> > -- =

> > 2.19.0
> > =

> =

> It just occurred to me I probably should have added some of the Chromium
> guys who have modified this driver to this patch. I've done that now.

Looks OK to me.

Acked-by: Stephen Boyd <swboyd@chromium.org>

