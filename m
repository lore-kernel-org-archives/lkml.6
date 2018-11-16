Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6FF2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPdfSEIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6FF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeKPL1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:27:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37287 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeKPL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:27:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so9817864pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JnfNJMIvpGLiig1dSnDTnb2+8FOSrJ7l97WHiQsgds=;
        b=SPdfSEIpKjBHBQ0titZhqbguO5Ld7Vj+0cXGnsV2OgZQLyexLn0t9sxyrCn6gdKwXu
         jm4CkpBu9mzW0iyFrhwFrccM+tzAdm2r+w9IAmriczYjCTnhWX65EEtvDLs1S9Y6g50p
         gXLypgZAX3ItAjKNF3WiMtyWgkbEvNYA/9jP5dpggo5Ha/O5NAsQtxHK76xWPBF3Qw8S
         Qi6/4p1SHAlM4L7SziIdCgxZlucht0SBw7m3dry5ciNsgF2f+p9MCEWF8KYjpxYPpOrZ
         qpYoM9e/kikdJpacxOJ68J8TcHD5UL75Q/guVxuX7EypLQX8OywoiY8A8TdNYiU1SI8y
         VrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JnfNJMIvpGLiig1dSnDTnb2+8FOSrJ7l97WHiQsgds=;
        b=TLoBE1X1MCcNygdOeXLAE/q3wjYaltEgSJhymn+E4nWDL2iE6OYmTshP1Hkh8t3ExO
         ck5El14ke3nClLS93rpdt/Xre0pzAj6nbBTBE22fsDp2yYz/ouXRa8Lyac+MCTSHu/rc
         3zSF+8ElzpTBz9nXHDdXZBFwm71C9Vw2UrYqr1eu+nujuF8YD0tcBVve46hwhq9YbYLS
         hfAlMP51Tqs+/3Ulqsn+x6ykFrgB8BYn8oi++ddEZ3slDb5MeYSH6nbZeWIxMvD9rK0Q
         uwJ9W6CY+EGmuxrYeeb6qRDrynySy4o+c14hdRkoG6XpeKSx2ZhrHk0mX+8Gyuey5+1X
         y52A==
X-Gm-Message-State: AGRZ1gKS5VDg9WcjEV/J4N1aYPytLpR5XR4v87zLHJ3wLYqBlwo0Adkp
        eJNvdkWtHq3qXzTiA4nHwuk=
X-Google-Smtp-Source: AJdET5eClilNDDT/gdqO9UFXgqUuvtg6MAW1YkXPYXuGZnR6NXwYo0Dix4oBT9aTDk//lsE2flNHSw==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr8134183pgc.3.1542331018930;
        Thu, 15 Nov 2018 17:16:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-v6sm49348639pfj.72.2018.11.15.17.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 17:16:57 -0800 (PST)
Date:   Thu, 15 Nov 2018 17:16:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181116011656.GA21813@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
 <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
> 
> OK, would you mind testing this below? It seems to me that 8250_of.c is
> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
> is causing the issue here.
> 
> diff --git a/drivers/tty/serial/8250/Kconfig
> b/drivers/tty/serial/8250/Kconfig
> index d7737dca0e48..21cb14cbd34a 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
> 
>  config SERIAL_OF_PLATFORM
>         tristate "Devicetree based probing for 8250 ports"
> -       depends on SERIAL_8250 && OF
> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
>         default SERIAL_8250
>         help
>           This option is used for all 8250 compatible serial ports that

44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
and fails to boot (or display anything on the console) with this patch applied.

Guenter
