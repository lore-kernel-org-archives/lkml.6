Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC6FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519802187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4s7lNmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519802187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeHQO0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:26:36 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39212 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeHQO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:26:36 -0400
Received: by mail-wm0-f53.google.com with SMTP id q8-v6so7099532wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wt+9dAnOVTDvEUaG8cEIt38uWkNZ2qVlLjM9d6XPZms=;
        b=Z4s7lNmqj/SDEhKEq6cJkZ2+Omndm4NduB91EQjfCW7vqtM7HGmGC1w54iAXGckRYZ
         ZU8+rnumhjIhF34eHMvEg3K+uSODZdpsjR/zoxtMJdgmEQIdD3j+GKhmWO5Qx5hArypr
         8FrljYvJ60JoKL25N87ExXfZ1srwN0yv456lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wt+9dAnOVTDvEUaG8cEIt38uWkNZ2qVlLjM9d6XPZms=;
        b=hGWJVxVgmmeG3yeETVLiqiQ1k6l0ckNUEAjELGJk0ZWKVQe/qu+e0BnQkn2KNj6UhH
         wDSv0af/rQgHigQAQm7Uyzvp69rXJIRYaer7XodFpcLuFsvL1XbKWwdNPDg7Sbyz60ho
         hPHlwTTMDa5vj3IzhUIS0hkwRBuVA49dre7ERDwmJPdVSYKkz39aYbf+mruS9ANEYm6f
         4QjIE7E6y+DOcNJCwXzhs/5ixoQIvwZNq4cpRLRMxaMymGFU6A1HgyK9zQOVuf/DSE0H
         qXtQfc1o08Uxzwsq8JjH4DS9Tu6EvSJVhmsuTQw4ceL2Jpy+1wokDDQltiYd9M25+aUH
         cRcg==
X-Gm-Message-State: AOUpUlHrvrjMqvYDSp8HgPww0PDbWfu1o7jvJ13Aqp5vEMTDRnMRhN6M
        glnfB3+/348+7fDeYfRr6kZzLg==
X-Google-Smtp-Source: AA+uWPxEqFoIyekvJ5pminDFTPXj055cxDoWMSXP1Bwfz25SCud6bMJQIlMBuU1fEz889U2bULTtDw==
X-Received: by 2002:a1c:cecf:: with SMTP id e198-v6mr17934736wmg.83.1534505008973;
        Fri, 17 Aug 2018 04:23:28 -0700 (PDT)
Received: from holly.lan (82-132-216-154.dab.02.net. [82.132.216.154])
        by smtp.gmail.com with ESMTPSA id m8-v6sm3858768wrf.93.2018.08.17.04.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 04:23:28 -0700 (PDT)
Date:   Fri, 17 Aug 2018 12:23:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     zhe.he@windriver.com
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kgdboc: Change printk to the right fashion
Message-ID: <20180817112319.ouwd3ehm4opeqbee@holly.lan>
References: <1534258660-80070-1-git-send-email-zhe.he@windriver.com>
 <1534258660-80070-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534258660-80070-2-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:57:40PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> pr_* is preferred according to scripts/checkpatch.pl.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

I thought I'd already done this but it looks like maybe I didn't get
round to it...

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> v2:
> - Split printk cleanups into a single patch
> - Add cc to stable@vger.kernel.org
> v3:
> - Add pr_fmt for mod name
> 
>  drivers/tty/serial/kgdboc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index f4d0ef6..371357d 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -8,6 +8,9 @@
>   *
>   * 2007-2008 (c) Jason Wessel - Wind River Systems, Inc.
>   */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/ctype.h>
>  #include <linux/kgdb.h>
> @@ -131,12 +134,12 @@ static void kgdboc_unregister_kbd(void)
>  static int kgdboc_option_setup(char *opt)
>  {
>  	if (!opt) {
> -		pr_err("kgdboc: config string not provided\n");
> +		pr_err("config string not provided\n");
>  		return -EINVAL;
>  	}
>  
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("config string too long\n");
>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> @@ -253,7 +256,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	int len = strlen(kmessage);
>  
>  	if (len >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> @@ -264,8 +267,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	}
>  
>  	if (kgdb_connected) {
> -		printk(KERN_ERR
> -		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
> +		pr_err("Cannot reconfigure while KGDB is connected.\n");
>  
>  		return -EBUSY;
>  	}
> -- 
> 2.7.4
> 
