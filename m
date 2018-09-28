Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5750DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDD3206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPoCKFLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDD3206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeI2FGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:06:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2FGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:06:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id d8-v6so5198478pfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sYDwMJtleRIaB4Y7RQNuPRSHElQNbA5x2Y3GRQNL0sc=;
        b=aPoCKFLR95QpIAHeZ4lMykf1JhaFYmZWYubo6g15vLnhPxjCan9x1vca+uHRFpYS/e
         FJzZBLIPF6pLXbItldGTLwew6OaioZ7EykTx25ZR1rRndaI2Mmgodw5zvXHlmpwI9CVe
         ltvUdu0X1ZiUVb/el4LWzkzGN8Du2uKwlw49m7FbOkEW4IvmFlbMAuixZJJEzNgCoQqU
         x1FH/BEsvg5NfWaaBbzuBnRjbhld9bYNO6CEgPXpbjWz2wAGpCxtHubpy3+eR9hROfNY
         /oRDc5w+LUFUo8s5mWwaOAUFe73WgyEm86K2BN2aNdsFPlUqQudX6rhZKBDK5WzLd3A+
         pljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=sYDwMJtleRIaB4Y7RQNuPRSHElQNbA5x2Y3GRQNL0sc=;
        b=KO6qMJ/KWF+nLoZC7tjqnUaBknyKIfTQR2ZaLYaVIhy4ofje6broHZ0MAp6EY0DdwG
         +pFtE4S4Uhj6OvamEJs6wxGMiOBWxlibeIzAP8ugbceZHdDUcMo9nTONHdM/q+5tsLWF
         OYvl1X2RCvheoG5HutwWjSbucpYNX4vbmCfZytE1GIsDsPuu7SW2DH3L4oU6HR5hKmme
         ExvmET869OX2Lsxnzo8utpyXcCOhcSBkwMnXofGFwX++k1YC9TF8f2c6VpWQVbqaGtHx
         au0fLlBloKI0jw3w3rhZqPL7muroE0c+7DeZQUwwbhkk5Oc9ipWLIwSZ/ObSuc1FhLSJ
         iMJQ==
X-Gm-Message-State: ABuFfogDgbYUlaVx6witN4BWRpGDo11f3jfy/DlUwyJ8Sr4czR8A/RSm
        U1NdWFgeFRylSpnWdYErd7c=
X-Google-Smtp-Source: ACcGV60ADOVbyubrelo15FHpANifewZUt5fYxzZyl2enzO5SNIEMTS3JDlDDy+KVSzVeQz901cQuYQ==
X-Received: by 2002:a63:3285:: with SMTP id y127-v6mr615355pgy.104.1538174458978;
        Fri, 28 Sep 2018 15:40:58 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z6-v6sm8424016pgr.41.2018.09.28.15.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:40:57 -0700 (PDT)
Date:   Fri, 28 Sep 2018 15:40:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix runtime PM handling
Message-ID: <20180928224056.GA10486@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 03:13:56PM +0100, Phil Edworthy wrote:
> When using kgdb, you get an abort when accessing the UART registers.
> This is because the driver has already entered runtime PM and so turned
> off the bus clock needed to access the registers.
> 
> To fix this, set the capability indicating Runtime PM is active while idle.
> 

With this patch applied, I get the already reported traceback [1].
Obviously neither the promised revert [2] nor the presumed fix [3] made it
into the mainline Kernel.

Greg, can you please revert this patch ? If people don't care enough
to fix the problem, we should at least not have to suffer the consequences.

Thanks,
Guenter

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 0529b5cc094b..aff04f1de3a5 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -576,6 +576,10 @@ static int dw8250_probe(struct platform_device *pdev)
>  	if (!data->skip_autocfg)
>  		dw8250_setup_port(p);
>  
> +#ifdef CONFIG_PM
> +	uart.capabilities |= UART_CAP_RPM;
> +#endif
> +
>  	/* If we have a valid fifosize, try hooking up DMA */
>  	if (p->fifosize) {
>  		data->dma.rxconf.src_maxburst = p->fifosize / 4;
> -- 
> 2.7.4

---
[1] https://www.spinics.net/lists/linux-serial/msg30379.html
[2] https://www.spinics.net/lists/linux-serial/msg30380.html
[3] https://www.spinics.net/lists/linux-serial/msg30757.html
