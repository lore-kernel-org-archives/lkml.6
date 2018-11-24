Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D375C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043A22082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQnkdG+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043A22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeKYHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:36:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43129 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKYHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:36:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so10844947lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7Xyf6jPNPlCKW7o1JJYDMnX2t/q5N0SRjNYl9BRhgk=;
        b=BQnkdG+tOgUg4o4O2XIKE21cFdeahwnECO2fU4UgAXjGpJDeTl5Uo+n5tXoBQ2S+s+
         IEDkZU4GVUjELhpdaw2SylBLKsfGR9CGg9DOE0IteCBrQkaoR9iGhn3f9iWFF1+fb1dy
         SGVEfaAgNGGqoWqxJGEezdUs7zGeMSBiFzn74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7Xyf6jPNPlCKW7o1JJYDMnX2t/q5N0SRjNYl9BRhgk=;
        b=aWKaXh5DuayfHJzBBwO0xVTCeI9QPJsegzY/k9SyOY7fh5+TU62k8nz7B6PTnSWeBe
         39jxnyDjvtIMmfypR2oA0+jzjytnLrS2IxyrcKSxFuYW5cONUYOFfaNJ/taE4z2nblL9
         Gz8E7rQB0qXk33Q153iV629jbz+TCv/5DrOi/5CqRtDBRwLy1aAjXXGAzGf6EwyLMiVB
         XFMKUyu7DfLeQxdlShQJQ6wYA2X6cai+HeKQDSPCXq9T7+CB6k/6Ve8MqVg7BTKeAPgt
         NKZjLa1yvmemTHDb3s32OFSZmgwk2wtvFS9/8PpZnc7QxL6bvvtE621HWiwV8UxH2lsf
         cfjQ==
X-Gm-Message-State: AGRZ1gKIO6dmyvLNnHHPZWF4ffWQH7tuoxI6So6/dQ6Nwsp1suLrsGU3
        dUwZ093AtDa5WzglM8r6ohl2/dXscLy6vfRTFpCjdw==
X-Google-Smtp-Source: AJdET5ePiTDsn0dkzMlSv4QNCrfx/lx05ubDKflpLy8SyYC5zhCEcIBigU/vfO5c8kx531y6qhanEz0XahVRmymPh2Y=
X-Received: by 2002:a19:5154:: with SMTP id f81mr13108290lfb.96.1543092457002;
 Sat, 24 Nov 2018 12:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-6-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-6-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:47:25 +0100
Message-ID: <CACRpkdbUK-Xx4XfLPAzJdH_R_JADFDxKkvQLiYeZyd6sJ02Pzw@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm: replace "drm_connector_unreference" with "drm_connector_put"
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

Patch applied.

Yours,
Linus Walleij
