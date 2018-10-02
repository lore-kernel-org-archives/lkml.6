Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3702FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BD2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GjFElW5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68BD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeJBIDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:03:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BhmQ1RU7SkoorF4O1yVXhhNZkjc8jQEjYybwQYhCQkI=; b=GjFElW5VTgIy5bUZJyINa57vv
        TCK3LEH1qCLF5sC7YooWGD1j8PlPfCBut00H2mgB6nNyqRLgGFVD0jMN/Orra5fpmqPqw+HBYsL6/
        7Jhdy2rt+IlZH0SQ6nwpX4ElLkrlolg/6pLAGpcNp1gaQkvdn7OzChkuW4wMWDtUAHOYtuZGP6aTl
        qBBYZG28SCCGfzARBba33BtDHgDKpIEYiQLcLh+jQj4YronLxi3K2Qwrudh+JBnKaXd6N6JOo1BIy
        /bCjemPE20yboFpuB/R9vc+lAWXWaoU11YERIul6O/thw5jjOUYT7iIXZZ13itMgMx439WGbtLo7R
        rWuywuQBQ==;
Received: from [191.33.184.123] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g79Ow-0007Hc-Mm; Tue, 02 Oct 2018 01:23:02 +0000
Date:   Mon, 1 Oct 2018 22:22:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Russ Anderson <rja@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Message-ID: <20181001222257.45e4fd59@coco.lan>
In-Reply-To: <20181001224313.GA9487@agluck-desk>
References: <20180926130340.6b22918b@coco.lan>
        <20180926161749.GI5584@zn.tnic>
        <20180926181035.GA1132@agluck-desk>
        <20180926182317.patqjso7nzw2oxiz@hpe.com>
        <20180926230257.GA5666@agluck-desk>
        <20180927045244.GA30912@zn.tnic>
        <20180927214400.GA2249@agluck-desk>
        <20180927220355.GF19687@zn.tnic>
        <20180927221054.580220e5@coco.lan>
        <20181001124754.GD7269@zn.tnic>
        <20181001224313.GA9487@agluck-desk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 1 Oct 2018 15:43:13 -0700
"Luck, Tony" <tony.luck@intel.com> escreveu:

> Nobody(*) uses them.  Dropping this will allow us to make the total
> number of memory controllers configurable (as we won't have to
> worry about duplicated device names under this directory).
> 
> (*) https://marc.info/?l=linux-edac&m=153809709903987&w=2
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Boris: Apply this, then your earlier patch to get rid of the
> hard coded limit on the number of memory controllers:
>   https://marc.info/?l=linux-edac&m=153797567628947&w=2
> the combination works on my 4 socket machine. Perhaps HPE
> can test on their superdome.
> 

For both this and the referred patch:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  drivers/edac/edac_mc_sysfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 20374b8248f0..4c1bee59c2e6 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -405,7 +405,6 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
>  				    struct csrow_info *csrow, int index)
>  {
>  	csrow->dev.type = &csrow_attr_type;
> -	csrow->dev.bus = mci->bus;
>  	csrow->dev.groups = csrow_dev_groups;
>  	device_initialize(&csrow->dev);
>  	csrow->dev.parent = &mci->dev;
> @@ -636,7 +635,6 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
>  	dimm->mci = mci;
>  
>  	dimm->dev.type = &dimm_attr_type;
> -	dimm->dev.bus = mci->bus;
>  	device_initialize(&dimm->dev);
>  
>  	dimm->dev.parent = &mci->dev;
> @@ -940,7 +938,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	device_initialize(&mci->dev);
>  
>  	mci->dev.parent = mci_pdev;
> -	mci->dev.bus = mci->bus;
>  	mci->dev.groups = groups;
>  	dev_set_name(&mci->dev, "mc%d", mci->mc_idx);
>  	dev_set_drvdata(&mci->dev, mci);



Thanks,
Mauro
