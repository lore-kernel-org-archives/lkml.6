Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254FAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA11A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP7JrpB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA11A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeKBDoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeKBDoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:44:06 -0400
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CF62082E;
        Thu,  1 Nov 2018 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541097597;
        bh=U5J/VYXPqrIQd9/0rEl/Efhwjkr0k8uc0bR8GptPkU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eP7JrpB42+6bqA7jkKp98YBoHj5HhBcnJ+mIpTA7AsLXOlyIBQH/tauJuaOrmUHUr
         8BP7o6WkVVeQ+ra7hGgBCgdmJ9OC8N9f+o62eXWyXQHiYqXD81J2190Xd6yewxCsv9
         h8moOYgqe1uHA1CjShoeuHoSBH+/hjjaVwICf1H0=
Received: by mail-yw1-f52.google.com with SMTP id j202-v6so8288401ywa.13;
        Thu, 01 Nov 2018 11:39:57 -0700 (PDT)
X-Gm-Message-State: AGRZ1gI392D2IGC4fREnvpJwrklyC+xQ4iaLh2rOb6cKA5cxva0cC/d6
        4qCDMrSwfDc8u9YoQHyQWtKjptMhtBx5vcS53aI=
X-Google-Smtp-Source: AJdET5cZtSZNLaUv6AfaXBFABNpqJToQ8y1RnX3o6uqsLvnjwdnVS5mrcZiz4Vrl0ZDtb1L8OcakpHhltLrJz4yJXx8=
X-Received: by 2002:a81:72c1:: with SMTP id n184-v6mr8596251ywc.57.1541097596962;
 Thu, 01 Nov 2018 11:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181029072630.13339-1-agust@denx.de> <20181029165945.GB2453@archbook>
In-Reply-To: <20181029165945.GB2453@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 1 Nov 2018 13:39:20 -0500
X-Gmail-Original-Message-ID: <CANk1AXRc7Erwb-stmZ6+zp9EKAb3f0XjPd3uiWYLPzgapkozbw@mail.gmail.com>
Message-ID: <CANk1AXRc7Erwb-stmZ6+zp9EKAb3f0XjPd3uiWYLPzgapkozbw@mail.gmail.com>
Subject: Re: [PATCH v2] fpga: altera-cvp: Fix registration for CvP incapable devices
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Anatolij Gustschin <agust@denx.de>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, puhm@oregano.at
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:59 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Anatolij, Andreas,
>
> On Mon, Oct 29, 2018 at 08:26:30AM +0100, Anatolij Gustschin wrote:
> > From: Andreas Puhm <puhm@oregano.at>
> >
> > The probe function needs to verify the CvP enable bit in order to
> > properly determine if FPGA Manager functionality can be safely
> > enabled.
> >
> > Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
> > Signed-off-by: Andreas Puhm <puhm@oregano.at>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>

Thanks!

Alan

> > ---
> > Changes in v2:
> >  - improve Fixes tag
> >  - wrap lines in commit description
> >
> >  drivers/fpga/altera-cvp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > index 3998d4f0e5e7..196d52558990 100644
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
> > @@ -419,6 +420,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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
> > 2.17.1
> >
>
> Thanks,
> Moritz
