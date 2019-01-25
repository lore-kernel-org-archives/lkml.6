Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9900C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0E218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="gt2e+PgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAYUfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:35:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34064 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:35:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so9759475otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V7Zz6B4ep/S9lo2cEqRIuyWB8Oo9z82Zia2aFv4SK0M=;
        b=gt2e+PgXjIbm7TYJ2AND6hu+hnnpvm9LASQWkcVJ0IyNrBFsg+5dw5OBoQdNTmY1eS
         VVBteq4a4G9MokMZlU2/R4nmxC0tubl4S2Qf5NEiv9eA3aKZMfGrudboTevUnkSjn5xq
         HazaqnFF02cvmoSbBzIi3NxZq4utCN6x+RyEl8SFfZwCrftj5wLrJYZWaBmxC7LAOm0u
         zA0ChV4mpETT2EY4mF1/i05CbydM+bxUo4YiGs2IQbbJ2DatzL/v1BgnMV1NtkMnVeNx
         Stka32Nm2la4dEUfLzWqBBPTKLWA4ilAWgo5xhyhI96j6fdVcSbwm19PVc0wri2fcfHh
         5VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7Zz6B4ep/S9lo2cEqRIuyWB8Oo9z82Zia2aFv4SK0M=;
        b=cf5Vin0GCIvM5qdJ51uhvRNqJy0SfTPrMFciSm3D/fcz8Oz77kxU2LH7hX+wUHI9b2
         6HLlDWmJrJAQzab19bOkO3j1GstWwSGwqcP7a62ZKxPQodNkBUw3d1DU1RV9AGWlFhj7
         GLWkeOSS0cDv7LwlLblWRZI3rYWYt8ForaSCQWH+nDQcov0jVI04SXIPFFCFspmpZqof
         vwV+41MCvN+ulFtI0GcCdtYkWfGzzROV/aoCQICRlTbAhazJkJlK+q4gxHGGSvYbJxKI
         IwaABYRykr15jrYkCd7BeISvcHbfoslG5xzSxUmNHuPew9UQWpD9dG7sWpeSY2U8vd1U
         Uhng==
X-Gm-Message-State: AJcUukfyhTDXdvGx6d9/pn97a10sYdaNGXzjTW9ZHEYlhz1xBELiPtoE
        DGSn1SS2g3x2e/Yx0Njy6/Mm2w==
X-Google-Smtp-Source: ALg8bN69G3lnM7aJqDk/rPyMLx6EsXng3ItsywYGfGYkfI6jFRXZ7jqTKiVK3MPN1wVZNVaGch1xjg==
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr9287581otr.299.1548448527527;
        Fri, 25 Jan 2019 12:35:27 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:a64e:31ff:fe14:d744])
        by smtp.gmail.com with ESMTPSA id r9sm1746527otq.81.2019.01.25.12.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 12:35:26 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:35:24 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        qiaonuohan@huawei.com
Subject: Re: [PATCH] ipmi_si: fix use-after-free of resource->name
Message-ID: <20190125203524.GA20851@minyard.net>
Reply-To: cminyard@mvista.com
References: <1548383459-38420-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548383459-38420-1-git-send-email-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:30:59AM +0800, Yang Yingliang wrote:
> When we excute the following commands, we got oops
> rmmod ipmi_si
> cat /proc/ioports
> 

snip...

> 
> If io_setup is called successful in try_smi_init() but try_smi_init()
> goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
> will not be called while removing module. It leads to the resource that
> allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
> resource is freed while removing the module. It causes use-after-free
> when cat /proc/ioports.
> 
> Fix this by calling shutdown_smi() while removing the module and don't
> call release_region() if request_region() is not called to avoid error
> prints.
> 
> Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
> Cc: stable@vger.kernel.org
> Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c    | 2 ++
>  drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index dc8603d..635e98a 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2235,6 +2235,8 @@ static void cleanup_one_si(struct smi_info *smi_info)
>  
>  	if (smi_info->intf)
>  		ipmi_unregister_smi(smi_info->intf);
> +	else
> +		shutdown_smi(smi_info);

This is completely the wrong way to fix this.  The general principle is
that a function cleans up for itself if it returns an error.  If you
add hacks other places for a function failing you end up with a mess.

I think the right way to fix this is to add something like:

	if (rv && new_smi->io.io_size && smi_info->io.io_cleanup) {
		smi_info->io.io_cleanup(&smi_info->io);
		smi_info->io.io_cleanup = NULL;
	}

at the end of try_smi_init().  

-corey

>  
>  	if (smi_info->pdev) {
>  		if (smi_info->pdev_registered)
> diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
> index ef6dffc..0c46a3f 100644
> --- a/drivers/char/ipmi/ipmi_si_port_io.c
> +++ b/drivers/char/ipmi/ipmi_si_port_io.c
> @@ -53,6 +53,9 @@ static void port_cleanup(struct si_sm_io *io)
>  	unsigned int addr = io->addr_data;
>  	int          idx;
>  
> +	if (io->regsize != 1 && io->regsize != 2 && io->regsize != 4)
> +		return;
> +
>  	if (addr) {
>  		for (idx = 0; idx < io->io_size; idx++)
>  			release_region(addr + idx * io->regspacing,
> -- 
> 1.8.3
> 
> 
