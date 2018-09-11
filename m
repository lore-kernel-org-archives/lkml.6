Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A73C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1204120645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITjpBwSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1204120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeIKNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:23:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeIKNXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:23:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so24589312wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vT5pDjIUR3mQ5r7guysdggl7MWXNRs2tuiZRjWllRUk=;
        b=ITjpBwSGrnU8GffmmAnbFdf5Au/A/QWg8EW+TrWepWp3vKHRuNiIODIYUJX7nnqKQL
         HFubSJAzh9rOaG/O7rUdoudVVH7rsEbSB86crLhWab2SPrH/qiNBnhGMVuE29UQHMgNH
         X1OmLo6Sn8KSJa7eojvsfVpD450VTsxnug/Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vT5pDjIUR3mQ5r7guysdggl7MWXNRs2tuiZRjWllRUk=;
        b=lTRdsgqQub4imLjEsWJCumLdccGyG8iBp9G302rEQ98GQ+kix9mPxc1e5CuKm65fgL
         YOkKuIPO1FMQsw1juQjAcFC2oxbcc3Sk5GCLBtXZq3TH7CNwOYvY0Z83x7LphaUW8R9m
         10Oh8ay6DE9YLNP9lgl2okQRk+6Ly9gHfQiMecCKOEDKufCSwB23zxf0k2d/yMXsH5Aq
         DQzXCB/NRcKYO6F8Jx1eBqv+q3ixlR/XT+H8Hlk3RPtYe94Ugyb2MF8d/OMQ3dy/NliW
         1VWlkmlPT3XB7FvGKWzaaZjekP1vvqtbTW7FNhguX3i1aV88jYnHlFIYd07N6VTHVkXq
         4YLg==
X-Gm-Message-State: APzg51AlYuSR/RTGyUiEvLYmzXsxPb2dHq94dBA4id3vrWj3eahuvBhC
        2OH0NEEoLO/9ETva2yVEIAWt0A==
X-Google-Smtp-Source: ANB0VdbFZ51yBTfgWzClquYRtHIe0yE5jxsuVvwdpuF9Kd36AQ+QDQkT4T5i0fTT1FvrdJ1Fdo4Lsw==
X-Received: by 2002:a5d:4990:: with SMTP id r16-v6mr18654136wrq.116.1536654336004;
        Tue, 11 Sep 2018 01:25:36 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id 72-v6sm24004701wrb.48.2018.09.11.01.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:25:35 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:25:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20180911082534.GA4185@dell>
References: <20180911125857.5e5c34f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911125857.5e5c34f4@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Stephen Rothwell wrote:

> Hi Greg,
> 
> After merging the tty tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element type 'struct of_device_id'
>  static const struct of_device_id at91_usart_mode_of_match[] = {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mfd/at91-usart.c:52:4: error: field name not in record or union initializer
>   { .compatible = "atmel,at91rm9200-usart" },
>     ^
> drivers/mfd/at91-usart.c:52:4: note: (near initialization for 'at91_usart_mode_of_match')
> drivers/mfd/at91-usart.c:53:4: error: field name not in record or union initializer
>   { .compatible = "atmel,at91sam9260-usart" },
>     ^
> drivers/mfd/at91-usart.c:53:4: note: (near initialization for 'at91_usart_mode_of_match')
> drivers/mfd/at91-usart.c:51:34: warning: 'at91_usart_mode_of_match' defined but not used [-Wunused-variable]
>  static const struct of_device_id at91_usart_mode_of_match[] = {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
> 
> Forgot to include <linux/mod_devicetable.h>?

Looks like a missing Device Tree header <linux/of.h>.

Will chase this today and follow up with another PR.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
