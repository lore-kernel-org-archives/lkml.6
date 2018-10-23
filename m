Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DAC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5C8207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7XXEwj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5C8207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeJWXR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbeJWXR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:17:59 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF7B207DD;
        Tue, 23 Oct 2018 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540306452;
        bh=Mmmr5PQbdAo8xnXgXs6WiHVr8CBjpAsihd1NGEOmgIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l7XXEwj0tUBaOTyfHMGwy03o853ucwSMAYhR7y0tcG9NmqBXnv1uGPyfHYRvfXZIW
         T9rGXf1JbP8GfdGbnFApA9cEUJMwq6fZfQyl6mV7kdRNbP7N4c0guMOJvyQvraBikR
         0NGxwSdtDCqZkhw0eMd2DeQHjLhbbGoZcLKYDmWA=
Received: by mail-ed1-f46.google.com with SMTP id b7-v6so1910645edd.9;
        Tue, 23 Oct 2018 07:54:12 -0700 (PDT)
X-Gm-Message-State: ABuFfohrdEzvmkNPzb6g9Fqgl7kbSkel59aQNrW8IS7Zg9uJYtpSdzzN
        XIkr+gF2UQP42/A/aF6NbbqdSg1hjf/C/W5c2BY=
X-Google-Smtp-Source: ACcGV62J+K/VXdB7NjeoZppuPOWNHrofgfjUudiXjLiW7n1F+y7ahz0NE5Ez+Z+BKdplPAQdW2oiKgCvXTw4B9cxdqQ=
X-Received: by 2002:a50:fc06:: with SMTP id i6-v6mr16685434edr.153.1540306450897;
 Tue, 23 Oct 2018 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <9b53d15391054a598ec3a32cee540798@SRV177.busymouse24.de> <20181023092639.GA4682@archbook>
In-Reply-To: <20181023092639.GA4682@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 23 Oct 2018 09:53:33 -0500
X-Gmail-Original-Message-ID: <CANk1AXRDRsmmm8OLStQ1YQjbtfmMqDf75OLeX+VAbybAkMbTmw@mail.gmail.com>
Message-ID: <CANk1AXRDRsmmm8OLStQ1YQjbtfmMqDf75OLeX+VAbybAkMbTmw@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable devices
To:     Moritz Fischer <mdf@kernel.org>
Cc:     puhm@oregano.at, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:26 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Andreas,
>
> we're getting there :) It seems your mail setup is still a bit
> funky though. Did you use git send-email / git format-patch?
>
> On Tue, Oct 23, 2018 at 09:01:39AM +0000, Andreas Puhm wrote:
> > From bfc602900b016f65bc2f183aa93702101a1fdc17 Mon Sep 17 00:00:00 2001
> > From: Andreas Puhm <puhm@oregano.at>
> > Date: Tue, 23 Oct 2018 10:24:10 +0200
> > Subject: [PATCH] fpga: altera-cvp: Fix registration for CvP incapable devices
> >
> > The probe function needs to verify the CvP enable bit in order to properly determine if FPGA Manager functionality can be safely enabled.

Please wrap at 80 chars per line.

Thanks,
Alan

> >
> > Fixes 34d1dc17ce978ae76e676d401b48fe9d004aa948 ("fpga manager: Add Altera CvP driver")
>
> According to [1] this should be the first 12 characters of the SHA-1.
> >
> > Signed-off-by: Andreas Puhm <puhm@oregano.at>
> > ---
> >  drivers/fpga/altera-cvp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 7fa793672a7a..ece344a56075 100644
> > --- a/drivers/fpga/altera-cvp.c
> > +++ b/drivers/fpga/altera-cvp.c
> > @@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >       struct altera_cvp_conf *conf;
> >       struct fpga_manager *mgr;
> >       u16 cmd, val;
> > +     u32 regval;
> >       int ret;
> >
> >       /*
> > @@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >               return -ENODEV;
> >       }
> >
> > +     pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> > +     if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
> > +             dev_err(&pdev->dev,
> > +                     "CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> > +                     regval);
> > +             return -ENODEV;
> > +     }
> > +
> >       conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
> >       if (!conf)
> >               return -ENOMEM;
> > --
> > 2.18.0.windows.1
> >
>
> It looks like you used Windows / Outlook or something. Please don't send
> patches as attachment.
>
> There's tutorials out there to set up git send-email with GMail for
> example, if your current provider makes using git send-email hard.
>
> [1] https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html
>
> Thanks,
> Moritz
