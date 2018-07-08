Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12600C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9359E20882
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9359E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754281AbeGHMil convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 08:38:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34209 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753745AbeGHMik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 08:38:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4DBFC206A6; Sun,  8 Jul 2018 14:38:37 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 740FE203B4;
        Sun,  8 Jul 2018 14:38:36 +0200 (CEST)
Date:   Sun, 8 Jul 2018 14:38:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Message-ID: <20180708143836.3eb4af31@xps13>
In-Reply-To: <MWHPR02MB262302F2D504A4783CF60832AF420@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180627172249.72f878a2@xps13>
        <MWHPR02MB26236BEABAAF0213B49EC21EAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180628091450.25bd54e5@xps13>
        <MWHPR02MB262302F2D504A4783CF60832AF420@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

[...]

> > > > > +
> > > > > +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> > > > > +		return -EINVAL;  
> > > >
> > > > Why?  
> > > It is similar to
> > > if (chipnr < 0)
> > > 	return 0;  
> > 
> > Mmmmmh, no?
> > 
> > (return 0) != (return -EINVAL)
> > 
> > The core is asking you to check if the controller driver support particular timings (usually
> > ONFI modes 1-5). Returning an error means "I only support the slowest timings" which, I
> > suppose, is wrong. Please fix this and compare the speeds.  
> I tried updating the driver as per your comments.
> But I am facing an issue here.
> The part I am using is http://www.cypress.com/file/207521/download.
> This part doesn't support get/set features. But the controller supports it.
> In this case, the frame work is doing like this
> If chip supports set_features, then it issues the ONFI_FEATURE_ADDR_TIMING_MODE other wise not.

Yes because some NAND parts are broken and do not support set feature
while working naturally at an higher rate than the slowest default one.

> In our case it won't and then next it simply changes the controller mode. Hence both are in different timing mode and not

If you look at the table 3.4 of your NAND part specification, you can
see that it supports mode 0-4. Hence the core will suppose it can
switch the controller timings to mode 4. Now, is your controller able
to support these speeds? Maybe it only supports non-EDO modes (0-3)
and mode 4 cannot be achieved?

> Able to communicate with the nand flash device.
> https://elixir.bootlin.com/linux/v4.18-rc3/source/drivers/mtd/nand/raw/nand_base.c#L1285
> Am I missing something?
> Could you please help on this.
> 
> The code snippet is like this
> tatic int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
> 				       const struct nand_data_interface *conf)
> {
> 	sdr = nand_get_sdr_timings(conf);
> 	if (IS_ERR(sdr)) {
> 
> 		return PTR_ERR(sdr);
> 	}
> 	if (csline == NAND_DATA_IFACE_CHECK_ONLY) {
> 		return 0;
> 	}
> }
> 
> Thanks,
> Naga Sureshkumar Relli.

Thanks,
Miquèl
