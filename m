Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EBDC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F44F218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBZt5mvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfAZPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:08:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35967 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 10:08:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so9857893oix.3;
        Sat, 26 Jan 2019 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQwTq+ofT3hQHAzwwcm4GfG2maRcojtgVOU/coiy8YY=;
        b=OBZt5mvbjvurkgpFlWxlEsHcI1Mc6xCHlgCEya4It7CnuBCb776l6x4mkstwLmwlLT
         mGg1EeOLINR6aHCL7OWbEubPsRxRnAvtEhnvb8x6dnjtmpOHQi5YJp0ZQJrcym2Wd5h4
         gKjaqHY1fGVoUHhzGjGa/D1uG0g2wQMmhERBQgaHg3xmp+Bp8rAtlFJuaMQNXN0erBpJ
         K3v7PKliqiFB+yXLwiw1cHtUBcp7KizLBuIH4aHCQb7pSwnu00ppEK9lImMYFiEHIHx+
         EE4lBbVPJmSGAoMEq8Z9KBdXRFCrWb32KUJh5faNg66ZW+CWJHb+5HUXDl1TIqQLAir0
         xAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=xQwTq+ofT3hQHAzwwcm4GfG2maRcojtgVOU/coiy8YY=;
        b=m8Bi+2t/zQodIIw04Xh095HuJjzdcwPG+F6ly66QNKhfz0/3h4QwG9i/FbnZPTraVB
         52DltumvrXZkzwk1RGbWGURugUSLbbd7ktk99WnKpfzgI6AJ1nApSfh6rCr1RdnUs7sG
         4ubILWkAFK/4dbYoGBRcgADKAf/4BhjJsyFu4exOnH7wuSspT7W4krQawdr+Jmj0ZxSf
         aIrMxU1ZapygwXXrjHItKAnDFEExbmcYUPMiU0WzMXvxWvyMZsHOovnEC5Pt7pUjbr9Q
         AWAPb4+OV1TZ36WxNKpZ/2i3qtkR4wi+Xsacbgkc41288hrto8144cdFtbpebyiujtp+
         Ye0g==
X-Gm-Message-State: AHQUAuYb5d7eWsj7xOA8XJSRCFa6c6VftwMooDzRMtW8bGV9iBPLf7P9
        G9W7AeVrXqyBwJrjFf+qWg==
X-Google-Smtp-Source: ALg8bN5JY0GxJm4zegS9E++fqZEuPXshGDG11kdVqN6rp/dMf/VdRC9Syh752XJGpUlHLlQix75XsA==
X-Received: by 2002:a54:4713:: with SMTP id k19mr1152372oik.241.1548515300059;
        Sat, 26 Jan 2019 07:08:20 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id x127sm2578140oia.20.2019.01.26.07.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 07:08:19 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a64e:31ff:fe14:d744])
        by serve.minyard.net (Postfix) with ESMTPSA id 901B8395;
        Sat, 26 Jan 2019 09:08:18 -0600 (CST)
Date:   Sat, 26 Jan 2019 09:08:09 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     cminyard@mvista.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net, qiaonuohan@huawei.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH v2] ipmi_si: fix use-after-free of
 resource->name
Message-ID: <20190126150809.GA11354@minyard.net>
Reply-To: minyard@acm.org
References: <1548494094-14356-1-git-send-email-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548494094-14356-1-git-send-email-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 05:14:54PM +0800, Yang Yingliang wrote:
> When we excute the following commands, we got oops
> rmmod ipmi_si
> cat /proc/ioports
> 

snip..

> 
> If io_setup is called successful in try_smi_init() but try_smi_init()
> goes out_err before calling ipmi_register_smi(), so ipmi_unregister_smi()
> will not be called while removing module. It leads to the resource that
> allocated in io_setup() can not be freed, but the name(DEVICE_NAME) of
> resource is freed while removing the module. It causes use-after-free
> when cat /proc/ioports.
> 
> Fix this by calling io_cleanup() while try_smi_init() goes to out_err
> and don't call release_region() if request_region() is not called to
> avoid error prints.
> 
> Fixes: 93c303d2045b ("ipmi_si: Clean up shutdown a bit")
> Cc: stable@vger.kernel.org
> Reported-by: NuoHan Qiao <qiaonuohan@huawei.com>
> Suggested-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c    | 5 +++++
>  drivers/char/ipmi/ipmi_si_port_io.c | 3 +++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index dc8603d..f1b9fda 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2085,6 +2085,11 @@ static int try_smi_init(struct smi_info *new_smi)
>  	WARN_ON(new_smi->io.dev->init_name != NULL);
>  
>   out_err:
> +	if (rv && new_smi->io.io_cleanup) {
> +		new_smi->io.io_cleanup(&new_smi->io);
> +		new_smi->io.io_cleanup = NULL;
> +	}
> +
>  	kfree(init_name);
>  	return rv;
>  }
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

Why do you need this part?  I can't see the reason for it.  The addr
part below should handle that, especially with the above change.

-corey

>  	if (addr) {
>  		for (idx = 0; idx < io->io_size; idx++)
>  			release_region(addr + idx * io->regspacing,
> -- 
> 1.8.3
> 
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
