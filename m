Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2753420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrOjZdtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2753420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeIKNmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:42:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeIKNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:42:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so24739348wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tjuDZfWEahVddVKqWWQaVEO+bLwzCSuXCpsNiNthUao=;
        b=YrOjZdtJFMVqcmoSVEDcBYgxT03D0gxXDEPIv8euapFychXmUYF9XFtsjA4Gxjc7jj
         JqugKCDqxZl6lbA3f0cJENQfPDsKFPRSP7vNLGH1oHcmoMnvazbtsgLt+5g5eQcHaugP
         elbROTHJbQsTT7IAceft2R7SXsA3PygjvoQSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tjuDZfWEahVddVKqWWQaVEO+bLwzCSuXCpsNiNthUao=;
        b=UPwexVTLnZt1RwV4oMxGJ+QccfaqDb/YZbsG91D4rDcHCl6j8o7AjBXhJKg4SP5jAs
         0NTcRJ4WPHlJ/YUqS5uJJ1eGv9Z28jh15XbS0EJvul2zdjCsLIlECdlyaC/Iuo+6IPVu
         9gC+1ztq0loDoaMBmNNAaa+73RXEQERan3wDyLo9EP8DVHvW/AfkGZ2O6JRy5uj4Bhz1
         dbAUE+9Bq+YAZT6HAbnjGvcIi2Xrjh1YS4Rzw6FEfrAPP1BfIKtm22xxFdun7dtkg/El
         mi2mCk0e5jWqLGD8qCe5vGmicuLHQS0e/C59B/BnI07dISaiL78oaw5vIta+nBj58KhR
         5ryg==
X-Gm-Message-State: APzg51AnU1tGZR4CoozcLjNIgREPWz79eiWoYQhGWgSFp/REiZA/8vY+
        9I2DQxbNnCp4xrJsl7NtDAZdGw==
X-Google-Smtp-Source: ANB0VdZ+LpbaGeDqfhRD3K3+4r5BN/QnbrRMciewVbQqVDdiCgTdD9l//2f77jN8TVxMXam3nrRESg==
X-Received: by 2002:a5d:4d52:: with SMTP id a18-v6mr18249796wru.40.1536655428889;
        Tue, 11 Sep 2018 01:43:48 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id x24-v6sm33287328wrd.13.2018.09.11.01.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:43:48 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:43:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20180911084346.GB4185@dell>
References: <20180911125857.5e5c34f4@canb.auug.org.au>
 <20180911082534.GA4185@dell>
 <84bafe76-741e-7dc1-d985-62027f4f634a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84bafe76-741e-7dc1-d985-62027f4f634a@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Nicolas Ferre wrote:

> On 11/09/2018 at 10:25, Lee Jones wrote:
> > On Tue, 11 Sep 2018, Stephen Rothwell wrote:
> > 
> > > Hi Greg,
> > > 
> > > After merging the tty tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > > 
> > > drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element type 'struct of_device_id'
> > >   static const struct of_device_id at91_usart_mode_of_match[] = {
> > >                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/mfd/at91-usart.c:52:4: error: field name not in record or union initializer
> > >    { .compatible = "atmel,at91rm9200-usart" },
> > >      ^
> > > drivers/mfd/at91-usart.c:52:4: note: (near initialization for 'at91_usart_mode_of_match')
> > > drivers/mfd/at91-usart.c:53:4: error: field name not in record or union initializer
> > >    { .compatible = "atmel,at91sam9260-usart" },
> > >      ^
> > > drivers/mfd/at91-usart.c:53:4: note: (near initialization for 'at91_usart_mode_of_match')
> > > drivers/mfd/at91-usart.c:51:34: warning: 'at91_usart_mode_of_match' defined but not used [-Wunused-variable]
> > >   static const struct of_device_id at91_usart_mode_of_match[] = {
> > >                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >    7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
> > > 
> > > Forgot to include <linux/mod_devicetable.h>?
> > 
> > Looks like a missing Device Tree header <linux/of.h>.
> > 
> > Will chase this today and follow up with another PR.
> 
> Hi all,
> 
> Actually it is due to the missing of  <linux/mod_devicetable.h> as Stephen
> suggested. It is due to the patch ac3167257b9f ("headers: separate
> linux/mod_devicetable.h from linux/platform_device.h") merged in v4.19-rc1.

Since this set uses Device Tree, it really should include the of.h.

This solves the issue reported above.

I will fix-up and re-send the pull-request.

> because linux/platform_device.h was included by linux/mfd/core.h that is
> present in this driver. This is why the issue was not identified beforehand.
> 
> I'm building a tiny patch to address this right now.
> 
> Thanks for your help. Best regards,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
