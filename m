Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144BFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5AA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gvi6J8Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5AA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGQUvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:51:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43288 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeGQUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:51:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id z74-v6so1224304qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H9VwNQ7XZIfP82BCmlFPU2TtUCFDNitoXqnUYg53efs=;
        b=Gvi6J8Dn45vZAI+mC4nQycb/lcDzZYHQYYJttckyeRIjyvbn/zKSxRr6Hu7RrK3NYM
         cdq03XW37pjhDrkmMSYa5M73Coc5OOLc+F/euUkH+ly74cmSBMpZF77QC2dx5u6nv+6l
         0T0rQUC+ble3tW/+c04bLDOOM9Mu0UWNAGUcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H9VwNQ7XZIfP82BCmlFPU2TtUCFDNitoXqnUYg53efs=;
        b=D8KENCwd8NV8wkNEpbXtYsBgFSH5p4Ss8AqCbsyQQvTPQs8ZhuJkXUr2bJtu+BxxLZ
         H0OW+XeZfGdZUS2/GxRGH3Jyc+lSNQO9sRbyLUoZD3X+gLQTVL/uY+UJDyifIiO4wqOG
         N/DCxlu+yG0OF7ayCwBGYor6UyS+6IIRrF9gfvumMnRdArGori5LT9Ohn5T3hdmY3fbv
         PWa7MIku6V66DCqubrgFjyptgEuyO2MYYjxyoW0nT0KLymPMBALcmqF7FEakCUTTYldk
         ukPL8M4YurYxVzcN63DtkqDtTvnaO6UT9jdSK6ixcKvvAlwOOAieEgGoema1BOWTggBP
         B2UQ==
X-Gm-Message-State: AOUpUlHvZ1ZE9RMgpUxuXPTjUdupphT5TUZ10Z4DRImGhlKfvekDGgUG
        RgRep2Pn8RmsAPxkffrFikb5bZvhfKk=
X-Google-Smtp-Source: AAOMgpfQnt8Ca3cAWYQ4QIYNXfXQ5nIiEc7jwnGTiaBUQkalD1YOHIL47BLM7ZA0bdbEcUld1m5kIg==
X-Received: by 2002:a37:7d87:: with SMTP id y129-v6mr2824427qkc.232.1531858606988;
        Tue, 17 Jul 2018 13:16:46 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1827842qtk.12.2018.07.17.13.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:16:45 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:16:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: early_printk: respect keep parameter
In-Reply-To: <20180711183239.21023-1-alexandre.belloni@bootlin.com>
Message-ID: <nycvar.YSQ.7.76.1807171603240.20892@knanqh.ubzr>
References: <20180711183239.21023-1-alexandre.belloni@bootlin.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Alexandre Belloni wrote:

> Parse and use the keep parameter of earlyprintk to avoid having the kernel
> output stop with:
> 
> Console: colour dummy device 80x30
> console [tty0] enabled
> bootconsole [earlycon0] disabled
> 
> This happens because once tty0, the virtual terminal console is registered,
> it is selected as the default console, disregarding an existing stdout-path
> DT property and the early console is shutdown before the console driver is
> probed.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Why can't you have a real console driver that takes over at that point 
which respects whatever DT property you give it?

The early_printk code is very raw and inefficient, and it shouldn't be 
used for anything but the debugging of early boot hangs.

> ---
>  arch/arm/kernel/early_printk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> index 9257736ec9fa..bbb10150b11a 100644
> --- a/arch/arm/kernel/early_printk.c
> +++ b/arch/arm/kernel/early_printk.c
> @@ -42,6 +42,9 @@ static struct console early_console_dev = {
>  
>  static int __init setup_early_printk(char *buf)
>  {
> +	if (buf && strstr(buf, "keep"))
> +		early_console_dev.flags &= ~CON_BOOT;
> +
>  	early_console = &early_console_dev;
>  	register_console(&early_console_dev);
>  	return 0;
> -- 
> 2.18.0
> 
> 

