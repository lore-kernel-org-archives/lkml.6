Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B199C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036EE26999
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMO+eSzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036EE26999
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeFZLGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:06:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42056 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932888AbeFZLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:06:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so1205828wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+mJeQGFTRJHE/3BL5qTKTwaKOqkKEVbq51/K2yU6YPY=;
        b=RMO+eSzZ/eU+E+dEQCspknDnYcS9aKCX3+TJ+cvYvE0/KzAt3vkBJEd3KMPDS+ls1R
         YxO14JXsfkVfDC/DCARXRXHJyZIZ89T4muiRaOVcEzY1epNFiRUSECf8bWv7M5Ib5lGt
         AVyj+V4MbRMbGmL36F/kqfjCAWBaR2GgJLlz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mJeQGFTRJHE/3BL5qTKTwaKOqkKEVbq51/K2yU6YPY=;
        b=FyeTnQ7D/eTJWnUthZbCNtJx4AnVN9w+of3jlWB0qgIOA22EFjP/iib9++DniFVR4e
         ETBORaeXjXa8BRnuYLM1Qq606OLXmHH0nDI7INYLpNRzO8o1MCYFkODFnXLhPNukfst3
         qBNHIxVfjP5qxNkVn+hNdu/sy0s9cGD0BRJzoSvf6Ph+kdVZglGeCqh01bAszY/mcowq
         KLFQhwx4B9MwHYM7CFKEwKJFz6F5l0cz1mQuzlgA24asUjiZYC1/F8tRhK+iv4a3jYvG
         buPJ3C1tSKNG6Y4xNluADpTTz9x7U8YVmvDti+Ep5rJetZmFLFbK7lfx2Jw186fVx9SW
         izoQ==
X-Gm-Message-State: APt69E2/1wb1ESFkXghrXTvLGA5kXzztD+ZGwF9+9msOarRPQNSXdAyH
        Z2Bg3VS6v4nxontDTcb5YiCm2Q==
X-Google-Smtp-Source: AAOMgpe8fS83aqn/Fgt6ZPLmdpT6yV1+FeJQZ4uopfkpg+JCq3jbt8UVfYeOVa4Lx9u2jQoVtNKJ1A==
X-Received: by 2002:adf:af27:: with SMTP id z36-v6mr1037888wrc.59.1530011181164;
        Tue, 26 Jun 2018 04:06:21 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id e188-v6sm6231724wmf.21.2018.06.26.04.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 04:06:20 -0700 (PDT)
Subject: Re: [PATCH v2 01/15] nvmem: add support for cell lookups
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180626102245.30711-1-brgl@bgdev.pl>
 <20180626102245.30711-2-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
Date:   Tue, 26 Jun 2018 12:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180626102245.30711-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,

On 26/06/18 11:22, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We can currently only register nvmem cells from device tree or by
> manually calling nvmem_add_cells(). The latter options however forces
> users to make sure that the nvmem provider with which the cells are
> associated is registered before the call.
> 
> This patch proposes a new solution inspired by other frameworks that
> offer resource lookups (GPIO, PWM etc.). It adds a function that allows
> machine code to register nvmem lookup which are later lazily used to
> add corresponding nvmem cells.
> 
Overall the idea look fine to me.

This needs to be documented in ./Documentation/nvmem/nvmem.txt

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 57 +++++++++++++++++++++++++++++++++-
>   include/linux/nvmem-consumer.h |  6 ++++
>   include/linux/nvmem-provider.h |  6 ++++
>   3 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b5b0cdc21d01..a2e87b464319 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
>   static LIST_HEAD(nvmem_cells);
>   static DEFINE_MUTEX(nvmem_cells_mutex);
>   
> +static LIST_HEAD(nvmem_cell_lookups);
> +static DEFINE_MUTEX(nvmem_lookup_mutex);
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   static struct lock_class_key eeprom_lock_key;
>   #endif
> @@ -247,6 +250,23 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
>   	NULL,
>   };
>   
> +/**
> + * nvmem_register_lookup() - register a number of nvmem cell lookup entries
> + *

Can we rename this to nvmem_add_lookup_table()?
register sound bit heavy here.

We should also have something like nvmem_remove_lookup_table() for 
consistency, and it should ensure that it clears the cells entry too.

> + * @lookup: array of nvmem cell lookup entries
> + * @nentries: number of lookup entries in the array
> + */
> +void nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t nentries)
> +{
> +	int i;
> + > +	mutex_lock(&nvmem_lookup_mutex);
> +	for (i = 0; i < nentries; i++)
> +		list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
> +	mutex_unlock(&nvmem_lookup_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_register_lookup);
> +
>   static void nvmem_release(struct device *dev)
>   {
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
> @@ -916,6 +936,37 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>   EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
>   #endif
>   
