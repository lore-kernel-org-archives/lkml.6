Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F358C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30572086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qgsl6Is+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30572086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeK1SAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:00:22 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43710 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbeK1SAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:00:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so16188023qkr.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9A5w39wUOKS/Zre1YyUran8Plh9y0s6bu15KiaJKdTI=;
        b=Qgsl6Is+XwahKfLaTCulaHl6BeVEXpzaj1ojp16ehmIl6hS4QUvwrl/fBznl5E5UaL
         K+UfJfKp3GUilomgZDAsYF3TquqYW7lul1GHQc7Kh6DT5Q46x1DMV7Wxk7nbQkAfUFrn
         r+wCFz5Y6AN8RmMglfHA7uHc3Z9uHwKPXiX9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9A5w39wUOKS/Zre1YyUran8Plh9y0s6bu15KiaJKdTI=;
        b=JxQkU2NCudCgDg71JAvc8TShxQBC4rYa2m6+QlkGA30pRSIeFSkme0o6vFmkKnQZYt
         uSoLE+UuoyIR2ZpWu038VCWJnstE6AjCPnBR2rLU7j9K5mhpVlBgGe9fXr+l9814JoNy
         nUdiHxv+8oVI9Hly/5xoakiBaowjiELWx+WHT0v8pKDfszsYSngJ+FxwVxUk96YmQnpN
         wnOGcWyiH6l8BKJzt5hZNkpyAceCralMseqEi09EzVV9AHtLit/b78EyBt9V8pM2fusy
         IBXTetrV7Po0yhJlMP76HxvEU776aeC01EgKIavYUWjsslAPLwjf59lVb03uqQ1bmqek
         UfKQ==
X-Gm-Message-State: AA+aEWZ8imL1bWE7ANUCgeDSet8BNUwy0VdWphB+3ZnguzZ0Asejk2Hs
        0iu6kSvUMX/1LYVhGx1a+D2VwbAkcTCV+cvjGfHwRGIPSyywnw==
X-Google-Smtp-Source: AFSGD/Xn6XjJez9IcdvXi5Yie4BQTxSXTyuTN1C4tInCQ08sEb3tUBPwNb4quctMvHoGKAsAs5CcJC8+xhXpQYswWwM=
X-Received: by 2002:a37:11dd:: with SMTP id 90mr32787483qkr.212.1543388384772;
 Tue, 27 Nov 2018 22:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20181128060412.630-1-hsinyi@chromium.org> <1543386149.32173.87.camel@mhfsdcap03>
In-Reply-To: <1543386149.32173.87.camel@mhfsdcap03>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 28 Nov 2018 14:59:33 +0800
Message-ID: <CAJMQK-got7Xo2mfKqhjuL6C5OJUov79JPRf9JA5+zL1b1saUSA@mail.gmail.com>
Subject: Re: [PATCH] usb/mtu3: power down device ip at setup
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,
On mt8183, We found `ip sleep failed!!!` with powerd_dbus_suspend.
Referenced from xhci, it power down device ip at
xhci_mtk_ssusb_config(). Also if dr_mode is PERIPHERAL and OTG, they
both power down device ip at ssusb_gadget_init().

On Wed, Nov 28, 2018 at 2:22 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi Hsin-Yi,
>
> On Wed, 2018-11-28 at 14:04 +0800, Hsin-Yi, Wang wrote:
> > Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> > so host ip sleep will fail at ssusb_host_disable.
> >
> > Power down device ip at ssusb_host_setup.
> >
> > Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> > ---
> >  drivers/usb/mtu3/mtu3_host.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> > index c871b94f3e6f..d17cf43305db 100644
> > --- a/drivers/usb/mtu3/mtu3_host.c
> > +++ b/drivers/usb/mtu3/mtu3_host.c
> > @@ -192,9 +192,17 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
> >  static void ssusb_host_setup(struct ssusb_mtk *ssusb)
> >  {
> >       struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> > +     void __iomem *ibase = ssusb->ippc_base;
> >
> >       host_ports_num_get(ssusb);
> >
> > +     /*
> > +      * device ip is default power-on in fact
> The device ip is power-off by default, no need power down it here.
>
> On which platform did you encounter the issue?
>
> > +      * power down device ip, otherwise ip-sleep will fail
> > +      */
> > +     if (ssusb->dr_mode == USB_DR_MODE_HOST)
> > +             mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
> > +
>
>
> >       /*
> >        * power on host and power on/enable all ports
> >        * if support OTG, gadget driver will switch port0 to device mode
>
>
