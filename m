Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C774208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO2mmKka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C774208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLFR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:57:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43806 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so466091pgk.10;
        Thu, 06 Dec 2018 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adEkfOzYwQg07e/v/ulIq1JdUKfE3bPooXvV2FE6Lio=;
        b=VO2mmKkasNMEuF3LzFndMMRaISJdFOxQzZWdFFfQv1lv58k3xMiLMCWuHN/7XiWpzF
         sHf1UMhcPMgVIxO4syTIaX6ZB7ardJjo1hB+bWwQh1ipkyknQYrwRUwwStuiVF+dPZeN
         3+NIxEbAIJhqPDVd0Fv7viM8AFcefUBjDpfnsyaqn59k7iT3ARNMku/Q/1gpbkOO85i3
         zMfJOA9PLpitakP+Y+U3nIg9TEWNBoYr4TfGiLDxjTV9vvQB17T+xR0sKf3yFv57BBRY
         r8xotuY70Gwz5B1XOwXRJ4SQb3r6gpYWoxDi33Sv6+wyte3vvDRL2lS6X8rylYkNCe36
         HfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=adEkfOzYwQg07e/v/ulIq1JdUKfE3bPooXvV2FE6Lio=;
        b=lig1XPvoSqJyfNuu3FNN8sSVygp9iz5oy5g9RAp4c7XWSAxZOXFD8/q3xzuohncrle
         ps5x1xFJEkNqmfJiKcCY+nO3BOdTixsnu2eLJoy7Tx51E/uwsEE/ZhVoLQO1SpMHpLFA
         wtVbv7vUrUonRGwzZP0pJf7QGH9XPgFANw8auTe0QUxKqQC0gBGYpijlYhxYU4tNwfrB
         CJnaQtNYfi2B0GUvx9eYKMmMlz62icbho0htM8mAaxDMqH0IkOZ85LEHxkI3rdD+4yEi
         06z0IVcLnLHYaehlP24OeqsVmbgDoayYOAv95jBNbuZyGoTXzUv0+otlMPLYjfxayek6
         ce7g==
X-Gm-Message-State: AA+aEWZeyW4DmD/+s63wvRCUMI7rPEye9OcTYBEKc75xOVpPeBz8sHFo
        2MTJWczMxazOG53uGIe52PY=
X-Google-Smtp-Source: AFSGD/XO/eCFjYvkv4GKTll6zwvoMLLFzV1IWmcQcm5XCY71qjdVKirR5l6NMDaJgkBozrysgROq8g==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr24431125pga.157.1544119030053;
        Thu, 06 Dec 2018 09:57:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y71sm1916989pfi.123.2018.12.06.09.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:57:09 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:57:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog/hpwdt: Exclude via blacklist
Message-ID: <20181206175708.GB11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:21PM -0700, Jerry Hoemann wrote:
> Instead of having explicit if statments excluding devices,
> use a pci_device_id table of devices to blacklist.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9356230..eecd014 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -50,6 +50,10 @@
>  };
>  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
>  
> +static const struct pci_device_id hpwdt_blacklist[] = {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
> +	{0},			/* terminate list */
> +};
>  
>  /*
>   *	Watchdog operations
> @@ -274,12 +278,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  		return -ENODEV;
>  	}
>  
> -	/*
> -	 * Ignore all auxilary iLO devices with the following PCI ID
> -	 */
> -	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP &&
> -	    dev->subsystem_device == 0x1979)
> +	if (pci_match_id(hpwdt_blacklist, dev)) {
> +		dev_dbg(&dev->dev, "Not supported on this device\n");
>  		return -ENODEV;
> +	}
>  
>  	if (pci_enable_device(dev)) {
>  		dev_warn(&dev->dev,
> -- 
> 1.8.3.1
> 
