Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14E0208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeBlBDzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14E0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeK1WEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:04:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1WEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:04:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so25831959wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ir7Ygr/iHYwaZE8Vy4ZH8UuhoVdfsK6DrAglwP1uG8E=;
        b=eeBlBDznvIX0atq+gGLDiikcsZqfoyYrTVoQe8CU7u9Rll8SOAth5KLeeEO0gZGt7B
         rxXmp1JYHml2wVgh2TPD51ntizUDgIKgrowYQ7qluEQ2FV4pIHFHu0Yu9If3qdFcIZy/
         EnOBEuYNUD/gX7S48pHG+9OpJibTtVP8JPCOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ir7Ygr/iHYwaZE8Vy4ZH8UuhoVdfsK6DrAglwP1uG8E=;
        b=H67QZKLX04Cl9dPrrgYcWi5fcf6nswglxSGMNF0lEY1NC56XdJkpPDFU8gJbgnkgkc
         SOAvw7V+tgogJXAvBKHRgxwVwIUrq3qzOcPogIiC5FGcPYVSKoxiQu+YNxBRlcl883NZ
         QCWeUtp2A0ed8trEbSFH6FZJnc3/NIBUTeXNd+W/MkViqeaMRVKw5cfOF37Mqzet1Zie
         vtzTD/JubPEEHj6V3P+lfMVsMnZHCoCEPGNztQ2y3Zvys8pDdkJ+hvym8aSJTxueQps+
         kELR2uEtBDiLogP87G/Fx7ncqWPKWnVXJwkvUVFB1vFmuVGraI8PeIfgHH/U5x5Ajcus
         kQmA==
X-Gm-Message-State: AA+aEWaBg25SYDx1Y8577VdtBROu6B7LmgFzFOQ2o47brdx6buLzuQiZ
        NrXRQMlmEVwxOe5M7fibvM8oWQ==
X-Google-Smtp-Source: AFSGD/UhphWj6ZJ6I41HaHtfyXEgg6UjEp00s2dKZdpjMAcFQqE3Y7uGqjKd6/GwiHlSzH1oQGRCDQ==
X-Received: by 2002:adf:d24e:: with SMTP id o14mr31507642wri.66.1543403003524;
        Wed, 28 Nov 2018 03:03:23 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id 60sm9421389wrb.81.2018.11.28.03.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 03:03:22 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:03:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: ti_am335x_tscadc: Provide unique name for child
 mfd cells
Message-ID: <20181128110321.GG4272@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-2-vigneshr@ti.com>
 <20181128090726.GS4272@dell>
 <16f2b753-1fde-3d20-6ddf-5dc5e4f13a15@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f2b753-1fde-3d20-6ddf-5dc5e4f13a15@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018, Vignesh R wrote:

> Hi,
> 
> On 28/11/18 2:37 PM, Lee Jones wrote:
> > On Mon, 19 Nov 2018, Vignesh R wrote:
> > 
> >> Provide unique names for child mfd cells, this is required in order to
> >> support registering of multiple instances of same ti_am335x_tscadc IP.
> > 
> > I don't think it is.  What is the error you are receiving?
> 
> W/o this patch I get:
> 
> [    2.296839] sysfs: cannot create duplicate filename '/bus/platform/devices/TI-am335x-adc'
> [    2.305085] CPU: 0 PID: 31 Comm: kworker/0:1 Not tainted 4.20.0-rc3-next-20181123-00018-g
> 7791ce8f123f-dirty #182
> [    2.315254] Hardware name: Texas Instruments AM654 Base Board (DT)
> [    2.321447] Workqueue: events deferred_probe_work_func
> [    2.326585] Call trace:
> [    2.329036]  dump_backtrace+0x0/0x1c0
> [    2.332699]  show_stack+0x14/0x20
> [    2.336017]  dump_stack+0x9c/0xbc
> [    2.339333]  sysfs_warn_dup+0x60/0x78
> [    2.342995]  sysfs_do_create_link_sd.isra.0+0xdc/0xe8
> [    2.348042]  sysfs_create_link+0x20/0x40
> [    2.351963]  bus_add_device+0x68/0x130
> [    2.355711]  device_add+0x398/0x618
> [    2.359199]  platform_device_add+0x120/0x290
> [    2.363469]  mfd_add_device+0x23c/0x2e8
> [    2.367302]  mfd_add_devices+0xb4/0x158
> [    2.371136]  ti_tscadc_probe+0x35c/0x4c8
> [    2.375056]  platform_drv_probe+0x50/0xa0
> [    2.379062]  really_probe+0x204/0x2a8
> [    2.382722]  driver_probe_device+0x58/0x100
> [    2.386903]  __device_attach_driver+0x98/0xf0
> [    2.391258]  bus_for_each_drv+0x64/0xc8
> [    2.395091]  __device_attach+0xd8/0x138
> [    2.398923]  device_initial_probe+0x10/0x18
> [    2.403103]  bus_probe_device+0x90/0x98
> [    2.406938]  deferred_probe_work_func+0x74/0xb0
> [    2.411470]  process_one_work+0x1e0/0x330
> [    2.415478]  worker_thread+0x238/0x460
> [    2.419225]  kthread+0x128/0x130
> [    2.422452]  ret_from_fork+0x10/0x1c
> [    2.426195] ti_am3359-tscadc: probe of 40210000.tscadc failed with error -1

That's because of the way the cells are being registered:

        err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
                tscadc->used_cells, NULL, 0, NULL);

The cells are not numbered (tscadc->cells->id is always 0) and you are
forcing the use of the platform ID from the parent platform device
(with pdev->id here).  Instead you should s/pdev->id/PLATFORM_DEVID_AUTO/
or number the cells manually. I suggest the former.

> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>  drivers/mfd/ti_am335x_tscadc.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> >> index c2d47d78705b..ee08af34f81d 100644
> >> --- a/drivers/mfd/ti_am335x_tscadc.c
> >> +++ b/drivers/mfd/ti_am335x_tscadc.c
> >> @@ -248,7 +248,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >>  	if (tsc_wires > 0) {
> >>  		tscadc->tsc_cell = tscadc->used_cells;
> >>  		cell = &tscadc->cells[tscadc->used_cells++];
> >> -		cell->name = "TI-am335x-tsc";
> >> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> >> +					    dev_name(&pdev->dev), "tsc");
> >>  		cell->of_compatible = "ti,am3359-tsc";
> >>  		cell->platform_data = &tscadc;
> >>  		cell->pdata_size = sizeof(tscadc);
> >> @@ -258,7 +259,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >>  	if (adc_channels > 0) {
> >>  		tscadc->adc_cell = tscadc->used_cells;
> >>  		cell = &tscadc->cells[tscadc->used_cells++];
> >> -		cell->name = "TI-am335x-adc";
> >> +		cell->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s",
> >> +					    dev_name(&pdev->dev), "adc");
> >>  		cell->of_compatible = "ti,am3359-adc";
> >>  		cell->platform_data = &tscadc;
> >>  		cell->pdata_size = sizeof(tscadc);
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
