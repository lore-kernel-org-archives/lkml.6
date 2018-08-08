Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8EC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B31521719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SlSpT9Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B31521719
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeHHIS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:18:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeHHIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:18:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14-v6so545116pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=HHKUgbQr+sh7nNguZKCtu9miLX8X8JVfjwsfiUG37ko=;
        b=SlSpT9Orgieat3P/qBlNG+7Xoj1ZedER+EN/BlbijJ4/MeH1NSsy8RiHNU0RUb8IGk
         0DUZQ9zgpI/lW4nKB1qjYC9uJWw8Ov9CYP0T797LOY+YHsRREEwd203pK3IEMJllkGvr
         jp8Pj9t1y8egMDTlmwP/h4ON3txtWhF0zQ7yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=HHKUgbQr+sh7nNguZKCtu9miLX8X8JVfjwsfiUG37ko=;
        b=SEstAXizYRh7pLxPLl55kqHwQDKALvbzoRTpuCd5YLbXZpB/oERewg6xZeGRbC6Tm8
         DnemAbdXLsD1oko0dd5JcvkDfRKooI3FmqeacapnQEHSYlPikg10I6HqE8Jzq39yzBkP
         r5PSi5PGefQvf1NfX+CnL9D6wK22rglNS/tOOremAS3SIZxj9ugccmcYiSV8xfaxqOvG
         FwxEyXy91meRLoLCWMnTT86RzXq4AfW0mYRxGOi7RQXNNPymWf370tUrEwbs7NScdDpp
         jlIKefEC7T22SJFXvfiGpJeEfCOuAWDoxDyvMR/7Axx3muw4Ql5Qv5TUjddagP4aO3Hy
         AUMQ==
X-Gm-Message-State: AOUpUlGDCAVrNuwSScJJiTijovsJ9yUvZ9ifXKggp9GVYuhAvmTTgqsM
        co47IG74+GXGMOR5S2p2zGEFuA==
X-Google-Smtp-Source: AA+uWPx2PwU6sc8FaxAYknF0Pc6Ym2451jUH1iBROMng1Ucz4uEYpLlqnF7Ged1p/osuVQQOySVy/g==
X-Received: by 2002:a63:4d06:: with SMTP id a6-v6mr1175899pgb.408.1533708052485;
        Tue, 07 Aug 2018 23:00:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id p17-v6sm3031059pgv.26.2018.08.07.23.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 23:00:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Norris <briannorris@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180807214102.GA218251@ban.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
References: <20180806171047.227835-1-swboyd@chromium.org>
 <20180807214102.GA218251@ban.mtv.corp.google.com>
Message-ID: <153370805099.220756.5343483987100252246@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
Date:   Tue, 07 Aug 2018 23:00:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2018-08-07 14:41:04)
> On Mon, Aug 06, 2018 at 10:10:47AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/firmware/google/coreboot_table-of.c b/drivers/firm=
ware/google/coreboot_table-of.c
> > index f15bf404c579..270f112bdc54 100644
> > --- a/drivers/firmware/google/coreboot_table-of.c
> > +++ b/drivers/firmware/google/coreboot_table-of.c
> > @@ -18,21 +18,20 @@
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > -#include <linux/of_address.h>
> > -#include <linux/of_platform.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> >  =

> >  #include "coreboot_table.h"
> >  =

> >  static int coreboot_table_of_probe(struct platform_device *pdev)
> >  {
> > -     struct device_node *fw_dn =3D pdev->dev.of_node;
> >       void __iomem *ptr;
> > +     struct resource *res;
> >  =

> > -     ptr =3D of_iomap(fw_dn, 0);
> > -     of_node_put(fw_dn);
> > -     if (!ptr)
> > -             return -ENOMEM;
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     ptr =3D devm_ioremap_resource(&pdev->dev, res);
> =

> You're making this a devm_* ioremap, but coreboot_table_exit() will
> handle unmapping this for you already. So you're introducing a potential
> double-unmap.

Thanks! I'll split this patch into essential and non-essential pieces
then and layer shortening patches on top.

> =

> > +     if (IS_ERR(ptr))
> > +             return PTR_ERR(ptr);
> >  =

> >       return coreboot_table_init(&pdev->dev, ptr);
> >  }
> > @@ -44,8 +43,9 @@ static int coreboot_table_of_remove(struct platform_d=
evice *pdev)
> >  =

> >  static const struct of_device_id coreboot_of_match[] =3D {
> >       { .compatible =3D "coreboot" },
> > -     {},
> > +     {}
> =

> ...and since I had a *real* comment, I'll mention this bit I noticed
> previously...this diff seems a bit superfluous. I understand we don't
> really want to extend this list beyond the NULL terminator, but
> normally, I'd expect we leave it alone.
> =


I was adding MODULE_DEVICE_TABLE nearby. I'll leave the removal here
unless you really hate the style cleanup.

> >  };
> > +MODULE_DEVICE_TABLE(of, coreboot_of_match);
> > =20
