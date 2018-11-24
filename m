Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C73C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E94A20645
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVb6PfSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E94A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeKYH1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:27:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41884 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKYH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:27:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so13269221ljb.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 12:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YNX1aPE/SVwRFw3fNROIhW8+05SCoozZhXoa+cbw3k=;
        b=ZVb6PfSyCydnx4jxB+11VrJONbURfp+USpAimVG05XsuW95a8r6yIHF7RrGrlw71q9
         mZoXJi9ZSuQMVP6SDqS9LAtHt2ZQWkp/nTKu0Xfx1Jbz3ZXrg3fnk4WEOysp1LGHArKK
         1XL/bt+LfS57ytxcNN4U2NoxD3YAWDVDjNHYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YNX1aPE/SVwRFw3fNROIhW8+05SCoozZhXoa+cbw3k=;
        b=H9ObzYR5i7h89GgMlHb2yXu4OFYf2mqaUisxjn/TvJiomqrNmsiUWqVqcb4QMEBV+X
         OyCLfQSuAnFYcZglsviSToh92RVmOoLbifOGCnTeZfpZ1yheVhP8NcjBFJaBxGJDigJw
         Ebryj61BEZ3hq6AA+kRCBNSi+eKt58jcpKbeA7D1uoaHi20gazIvx0YfwMHNm7wV+6S7
         30U0SVtZDeexSxI7ocSo/z3JZ3v243HIRrrHrZMJDtXPJnkLrie2PTV+Z+tk7rriQOJz
         jGD7knhKttWLNfZlCb5BuDazcTBSU5Llvk19vl7CknG+9iWbhGuLOo4PGC3Tw581J8NE
         0xwg==
X-Gm-Message-State: AA+aEWaKxjiJRufpE/k3rWgsJJEilS3NPbLL8D7rUkgJiTJFDkarGkNv
        og42PowHiBxuTrZc8EuQduojJxvZBnpH/yCDz/7TJQ==
X-Google-Smtp-Source: AFSGD/WxaBqpxmjeaIE/9a6dQ4gHFvwQRb4EPq5Y+mprubdQCWeAsbMER2Twzz3vSQ4B7LolaFIf0cvzR4tysMQFyvw=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr13041027ljk.4.1543091901638;
 Sat, 24 Nov 2018 12:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20181115221634.22715-1-greenfoo@gluegarage.com> <20181115221634.22715-2-greenfoo@gluegarage.com>
In-Reply-To: <20181115221634.22715-2-greenfoo@gluegarage.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 24 Nov 2018 21:38:09 +0100
Message-ID: <CACRpkda9HhODvWgsUb_ErFVpJ_o3frp-xz_Syvzh0yJRw8US8g@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm: replace "drm_gem_object_unreference_unlocked"
 function with "*put_unlocked"
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

This is already fixed in drm-misc-next as it happens:

commit a0d4d42cb5854400baa47bf63d9aae65fa9f484e
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Sep 26 13:36:23 2018 +0200

    drm/bochs: Replace drm_commit a0d4d42cb5854400baa47bf63d9aae65fa9f484e
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Sep 26 13:36:23 2018 +0200

    drm/bochs: Replace drm_gem_object_unreference_unlocked with put function

    This patch unifies the naming of DRM functions for reference counting
    of struct drm_gem_object. The resulting code is more aligned with the
    rest of the Linux kernel interfaces.

    v2:
            * rebase onto fbdev rework

    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Link: http://patchwork.freedesktop.org/patch/msgid/20180926113623.22679-1-tzimmermann@suse.de
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
gem_object_unreference_unlocked with put function

    This patch unifies the naming of DRM functions for reference counting
    of struct drm_gem_object. The resulting code is more aligned with the
    rest of the Linux kernel interfaces.

    v2:
            * rebase onto fbdev rework

    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Link: http://patchwork.freedesktop.org/patch/msgid/20180926113623.22679-1-tzimmermann@suse.de
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Going on to try and apply the rest.

Yours,
Linus Walleij
