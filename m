Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3715214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKei5ZO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3715214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeHNMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:02:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeHNMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:02:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so11446019wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7V5uCt35QisFwnN5/setQHaBhEh3UzqeRj0Y1d7B3M=;
        b=CKei5ZO7s4IyagMlOt2+JwGuzRa+aXBulHEJUlZxBcKj3rdzjOi3rp1SoRQuwymojJ
         MR+526HC7a4r7ClJiWdQbggjjR2SYxC0kYlUSswn/4oSuxPRzh5herDDFtbDC+GzkIp3
         NzZ5HkQ6p+3nt+A/gR02GHwDBzC73JUPRToCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7V5uCt35QisFwnN5/setQHaBhEh3UzqeRj0Y1d7B3M=;
        b=qlljEiS1zppetoVcR6UBC9qxVubDzP29I98NapZOc7Yp/+PNhKvdtW5nMJGKApUMhe
         J7wJZ58Bve9nyyUhxTCWE/hva9S4KEA/CvDXG64lTFsyCImy+eQxyeU3HQEafuvY6F3g
         96vRVOPnF0sFkLezAowvRxtYKw0Gmg0fGpJNd1ORoMvizk+rp4rUbwC+XP79blgHrSoq
         9+sr8WR3a3bU/jn0ngeaewM5ijEORtfYD01k/xWdHgq7tC9NM6ang2HAW15io79v6GeR
         x2P126NWEbpbFlS7WtzriGdfYYw4hDTf5uTHNjcgm873xNDDeLxfK7kH+8izIFXFo9hp
         lJaw==
X-Gm-Message-State: AOUpUlFY/jtwzdmr0VYbX1fp5qAI5vBYcIOt8jpnmTe+m4nvC3C6p+jK
        RmncPCxQviXRYgjbfb66ILpa+Q==
X-Google-Smtp-Source: AA+uWPy34HpSM/HWVqWDu6l3uFnebRasdcXj7itk0A5ibQgxyKBng/okhGCwwTjp66INxCBvQJKirA==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr10072555wmh.150.1534238163597;
        Tue, 14 Aug 2018 02:16:03 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 185-v6sm21121332wmy.38.2018.08.14.02.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 02:16:02 -0700 (PDT)
Date:   Tue, 14 Aug 2018 10:16:00 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     zhe.he@windriver.com
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdboc: Passing ekgdboc to command line causes panic
Message-ID: <20180814091600.md6v2dj53wco7lgn@holly.lan>
References: <1533743984-426660-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533743984-426660-1-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:59:44PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> kgdboc_option_setup does not check input argument before passing it
> to strlen. The argument would be a NULL pointer if "ekgdboc", without
> its value, is set in command line and thus cause the following panic.
> 
> PANIC: early exception 0xe3 IP 10:ffffffff8fbbb620 error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #1
> [    0.000000] RIP: 0010:strlen+0x0/0x20
> ...
> [    0.000000] Call Trace
> [    0.000000]  ? kgdboc_option_setup+0x9/0xa0
> [    0.000000]  ? kgdboc_early_init+0x6/0x1b
> [    0.000000]  ? do_early_param+0x4d/0x82
> [    0.000000]  ? parse_args+0x212/0x330
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_options+0x20/0x23
> [    0.000000]  ? rdinit_setup+0x26/0x26
> [    0.000000]  ? parse_early_param+0x2d/0x39
> [    0.000000]  ? setup_arch+0x2f7/0xbf4
> [    0.000000]  ? start_kernel+0x5e/0x4c2
> [    0.000000]  ? load_ucode_bsp+0x113/0x12f
> [    0.000000]  ? secondary_startup_64+0xa5/0xb0
> 
> This patch adds a check to prevent the panic and changes some printk
> to right fashion.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

For the bug fix portions of this patch you should add the stable kernel
ML to the Cc: of the sign off area: See:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

> ---
>  drivers/tty/serial/kgdboc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index b4ba2b1..0003d6c 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -130,8 +130,13 @@ static void kgdboc_unregister_kbd(void)
>  
>  static int kgdboc_option_setup(char *opt)
>  {
> +	if (!opt) {
> +		pr_err("kgdboc: null option\n");
> +		return -EINVAL;
> +	}
> +
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");

These changes are not bug fixes and are not normally candidates for
backporting. It would therefore be better to put the s/printk KERN_ERR /pr_err(/
changes into a separate patch.


>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> @@ -248,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	int len = strlen(kmessage);
>  
>  	if (len >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> @@ -259,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	}
>  
>  	if (kgdb_connected) {
> -		printk(KERN_ERR
> -		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
> +		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
>  
>  		return -EBUSY;
>  	}
> -- 
> 2.7.4
> 
