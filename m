Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B02CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD12082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QenR8MCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeKYHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:34:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39525 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKYHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:34:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so13272328ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu0Q5lsKovpLa36mEqIQaw/+EGL0gmOyRCZniPWwu6M=;
        b=QenR8MCMVtjsl4odRclGgCfzFk+bgahZWO9gHDejGQ6RSHp5kP9ebUelnqzjOuwrv+
         K4ABrCfL7gsgsSNL215x6f5nCHYw8YWZtKnv38Bo4dBo4GqUVTkdjdo+lHPrQ2v+IgIc
         ta5+0qnTO9lXcx5R6U4IyWePf1pLEPUI2NZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu0Q5lsKovpLa36mEqIQaw/+EGL0gmOyRCZniPWwu6M=;
        b=oxVCf/zuSCI1HnyD1wuxcUacj/vtfcPMVTPeQWkxvJWXHPL03gUo6wARoiDp0w4vIP
         1Tn5ptT9qHXmlj80BNaK8vN1bqgtnFnI/zJT+lvOkMO8K38OPSSiXapMzoA1cYQY3dc+
         hVsK3EY/L556xa4fIsPv5Pd5CY1fOW//uIfd+DLG3pSMgnGOB8LW9xM6WrdtVCcpiXC/
         pMJILFJgaBmBJlSxtQBBChc3QdEtj/VZd6gT8Au44q/EpXqYQnP1PJ/P+u3V6ITHqvCJ
         vpNEMxmuXjnHMWmVtx2ccmN6v1SUJEqRddr3VWa6E3si4tS2rkU/C8yJG3hr4uD2xXem
         Xlrg==
X-Gm-Message-State: AA+aEWa40YTwAGX4dZn6hUtgxVu/re4MqweLWIrtsi1fZ/OzoNPZidWu
        VFAAeRYu1vMTbpWQgEC8iKTjdPIlHTUSM/W4DFBJ5g==
X-Google-Smtp-Source: AFSGD/VEZ6x2QCIsilhaQrORMHhVTCoUS8UhL+kkx0459UvExM0A2qAA/NryzYHLlA1XplXsR00eF/6kPkhjxnR1lx8=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr11681009ljj.9.1543092293964;
 Sat, 24 Nov 2018 12:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-4-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:44:41 +0100
Message-ID: <CACRpkdatws8igmhXrEZSi6+ZES+omtWDone8SjpUrN9pohBNGw@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm: replace "drm_dev_unref" function with "drm_dev_put"
To:     greenfoo@gluegarage.com
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, sean@poorly.run,
        Jonathan Corbet <corbet@lwn.net>, abrodkin@synopsys.com,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        kieran.bingham+renesas@ideasonboard.com,
        Shawn Guo <shawnguo@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, michal.lkml@markovi.net,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org,
        etnaviv@lists.freedesktop.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied after some collecting ACKs and tweaking.

Yours,
Linus Walleij
