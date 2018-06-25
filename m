Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46840C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EBC25482
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8/pVnqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EBC25482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeFYF3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:29:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeFYF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:29:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id t12-v6so5074337ljc.11;
        Sun, 24 Jun 2018 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCxKwBtgcsr8G9X3AfWMiKeiOAXUh/PExF3rg7eDaL0=;
        b=U8/pVnqE7GuyTE2WvsJWlovf86JizzxwbN5/C2MgzVDvZjFVat3sUpX33/TwZaVlR+
         sGY1hRzSgthtJ9G50AWAXYMQFaht75lH/9e4kkxY+H5TeYjm3in1DdNlZs9apuIKBgm4
         DJ7zeXilVVeIbgumLNGDvuoyUHzSJy3AEKEKaMeneYailjsp4ObyQ5wuMcf9IRAsUYnp
         F7YWN4hJFSfj8euL8+fZUk2NlphDXtsO7tGBQYFYgBM6TOZG5/AVoAWkX9dbLJu4YC+7
         +K77YMbHToAEykAGAvidq9WB2wdC71hKZtPe63rfIGnCyLdLPnPlWyc7vesUpypwWcCF
         PZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCxKwBtgcsr8G9X3AfWMiKeiOAXUh/PExF3rg7eDaL0=;
        b=LT4exCoo90n+aLLFvveDyyPTxgb+gxEj8IvGgFol1Tr1Gb7s0MO/iyq4RgHx8X24Os
         3LssBi/b9ZOWM8nOtqvCf6U9W8vOP/hmFru8xQJrq/CSlxqJ2tlU6P4hb/LxpgpW6lii
         xKfxIcSxSIeHgC1qjuJMJJMzNghuMYtbRR1/tKvbF5WOxGaqw9YCE/tUUDHl2MMc8eIJ
         OCabcjC8AP5QaDz5tB3XW4Z7n32EJqMeWIrua5w5dakTetvvLqlt2je7oR/hpJS6LaLf
         L5twtZquDLlWIgN2hCGepGjEUBzsRxOdJ4QjwmFlJ39slIYp5ynxZU4bM9Lh7B45tSAf
         T3ZA==
X-Gm-Message-State: APt69E2b5hiii1Ax/9dXN3xvs7cymx99BWW+FSfZtPlosNnZd0HI5i8o
        Y8g5GLNVzBNcxmieqEn4cBE=
X-Google-Smtp-Source: ADUXVKIqAwUyGmmfOU1r6/VX8Kdc68t44MvUrvV4PEQfO2dbOJNYYsYYn5YGGWDRkvmAqx2YLa5S4g==
X-Received: by 2002:a2e:9156:: with SMTP id q22-v6mr2588338ljg.27.1529904580195;
        Sun, 24 Jun 2018 22:29:40 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j18-v6sm2245882ljc.11.2018.06.24.22.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 22:29:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fXK4A-0002QF-LQ; Mon, 25 Jun 2018 07:29:31 +0200
Date:   Mon, 25 Jun 2018 07:29:30 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     chunfeng.yun@mediatek.com, johan@kernel.org,
        gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        matthias.bgg@gmail.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
Message-ID: <20180625052930.GA26803@localhost>
References: <4c338a129ab14ab41949da5e3c21aed0d77dff8d.1529647619.git.chunfeng.yun@mediatek.com>
 <644d00edd2932c1a0d0a1bf368dd25427d1d9f64.1529647619.git.chunfeng.yun@mediatek.com>
 <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBS+fpfx6jaaqD=kqFuMF6ko8GikbV1ZVwgbDh-Sn8T8w@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 08:00:01PM +0200, Martin Blumenstingl wrote:
> Hello Chunfeng,
> 
> thank you for the patch!
> 
> On Fri, Jun 22, 2018 at 8:33 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

> > 2. devm_of_phy_get_by_index() should not fail for a valid index
> I have learned that the PHY framework can return -ENODEV if the PHY is:
> 1. supposed to be handled by the legacy USB PHY framework
> 2. the PHY node is disabled in devicetree
> 
> see [0] for the code in the PHY framework and [1] for the discussion
> with Johan (who informed me of case #1, I added him on this mail)
> 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/core/phy.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> > index 9879767..0f972e1 100644
> > --- a/drivers/usb/core/phy.c
> > +++ b/drivers/usb/core/phy.c
> > @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
> >                                    struct list_head *list)
> >  {
> >         struct usb_phy_roothub *roothub_entry;
> > -       struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +       struct phy *phy;
> >
> > -       if (IS_ERR_OR_NULL(phy)) {
> > -               if (!phy || PTR_ERR(phy) == -ENODEV)
> > -                       return 0;
> > -               else
> > -                       return PTR_ERR(phy);
> > -       }
> > +       phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> > +       if (IS_ERR(phy))
> > +               return PTR_ERR(phy);
> @Johan can you please review this as well? maybe we need to keep the
> -ENODEV check

Indeed, the -ENODEV check is still needed for the reasons you point out
above.

Johan
