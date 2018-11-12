Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED35C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99604223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhVq4DOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99604223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeKMBlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeKMBlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:41:18 -0500
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7638822503;
        Mon, 12 Nov 2018 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542037650;
        bh=BJpZJPvmVVKBqHZHK2yLeVsWLCh3a+jUOhD7eUWG9b8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhVq4DOdjVS95N85MKG2Jp5flfKsz1FQjeTROuwkzd1K7ZF4DuaSho5WkblZAbOoI
         sMkagh5X9OtBO1Py5j0On78FP/3orG16jKUhIVQiY6fHDFYhHfIj+TdTx52cn90cek
         aFVGCuqOKZBRwl8tSt7YT3dUefmoPLp/iPAEyMLA=
Received: by mail-yw1-f42.google.com with SMTP id l66-v6so4518526ywl.7;
        Mon, 12 Nov 2018 07:47:30 -0800 (PST)
X-Gm-Message-State: AGRZ1gJlBnQE3WXczEUGKtkG3vQH6rKbhG3ewHd3Zn59+toc1Syf50gH
        Jkb33dx++pMERkSazZOQbjwahvhJ05JxuW/35ow=
X-Google-Smtp-Source: AJdET5fmE0vdnVbFbr4vbsJu85I5qzDq2iyo250BshtTcpvmdRYti/uAZFKf9UJG4N1NyUjM98j3NhkobfOZgosRUqk=
X-Received: by 2002:a81:1b88:: with SMTP id b130-v6mr1332341ywb.230.1542037649567;
 Mon, 12 Nov 2018 07:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20180912144327.3130-1-atull@kernel.org> <20180912144327.3130-6-atull@kernel.org>
 <20180930154845.GA13200@kroah.com>
In-Reply-To: <20180930154845.GA13200@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 12 Nov 2018 09:46:53 -0600
X-Gmail-Original-Message-ID: <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
Message-ID: <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 10:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

Hi Greg,

>
> On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> > From: Moritz Fischer <mdf@kernel.org>
> >
> > Use platform_get_drvdata() in remove() function of
> > the platform driver rather than dev_get_drvdata()
> > to match the platform_set_drvdata in the probe().
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/dfl-fme-region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> > index 51a5ac2..3fa0de2 100644
> > --- a/drivers/fpga/dfl-fme-region.c
> > +++ b/drivers/fpga/dfl-fme-region.c
> > @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
> >
> >  static int fme_region_remove(struct platform_device *pdev)
> >  {
> > -     struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> > +     struct fpga_region *region = platform_get_drvdata(pdev);
>
> This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.

Could you take patch 4/5 and 5/5?  They didn't make it into a 4.20 rc yet.

Alan

>
> thanks,
>
> greg k-h
