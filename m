Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A649206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeZe7vRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A649206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeIJMZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:25:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34035 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeIJMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:25:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so20763496wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nxg0K5Q3XUnA4xH4u9oFwd8IgN2CPwsl1i3H30Ri1CY=;
        b=ZeZe7vRAOYa/ooqmA3fosbO2oRwlD1+j10xkimmMblacvd7OP4OZRSVKKOh6kbyqF0
         qtQEIUu1cvhcHuHU59PZ0Pcb7jzP/vkSGov/436cjQYYwn6XxGxbSGt1tjoVODqUm9Dt
         HBXNhuoglo8X2vtsqHcCcCCybHMrwbIbq9V9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nxg0K5Q3XUnA4xH4u9oFwd8IgN2CPwsl1i3H30Ri1CY=;
        b=BWPUeS8RX2AYW+Yv38Gsl8L8jzBPKVm65CcNvOe9VBQNPmDO+CXf4PhaDxBbFWlrbX
         oAUgzJqPC+lA86zLO8LL9VeqbRw4UISypZkDgv9v/lgkFw+Thqdl+VhDun0fWKsBYn/D
         BFuPUpelhelYFJ+XXSFwo6VSa/wcegqeackA4frmO0fRynktDPLXoYQV/NGiGMSZto98
         QVhKh6owFuZGwAgm+zIbqp5abgjKAzc379i90Ym+d9FQjM5gYgGCJMIPuFzkSr8HRpRQ
         4ahoV6S65/JuYF8d0ALVcpA09HusPaIOwgnZ5ZTuxWsVbZh4M3y6Tozujjn0fFc+RIzg
         HIWw==
X-Gm-Message-State: APzg51B026cmtAyNY+HYw7r2WJFW7+1ehPPfC7kFMkvh53XmceiGEWft
        KZfRiY/LLE/O/3Oi5FXxWAIqCg==
X-Google-Smtp-Source: ANB0VdZdtB2fCPjKF1c2unVflAkgCzXgSYNVPHrZ1TJRS2Q35x0hQqp5I3DobAooxZXTuHGkSRxGRQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16-v6mr13326601wrn.112.1536564747664;
        Mon, 10 Sep 2018 00:32:27 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 200-v6sm27067640wmv.6.2018.09.10.00.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:32:27 -0700 (PDT)
Subject: Re: [PATCH v2 11/16] nvmem: add support for cell info
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-12-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
Date:   Mon, 10 Sep 2018 08:32:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907100750.14564-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add new structs and routines allowing users to define nvmem cells from
> machine code. This global list of entries is parsed when a provider
> is registered and cells are associated with the relevant nvmem_device
> struct.
> 
> A possible improvement for the future is to allow users to register
> cell tables after the nvmem provider has been registered by updating
> the cell list at each call to nvmem_(add|del)_cell_table().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   MAINTAINERS                   |  1 +
>   drivers/nvmem/core.c          | 97 ++++++++++++++++++++++++++++++++++-

I see some of this code is removed in first patch and added back here, I 
dont really see a value in doing this in a single series of patchset.

I would recommend "[PATCH v2 01/16] nvmem: remove unused APIs" and this 
patch to be merged.

>   include/linux/nvmem-machine.h | 41 +++++++++++++++
>   3 files changed, 138 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/nvmem-machine.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39..a520924bf0a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10391,6 +10391,7 @@ F:	drivers/nvmem/
>   F:	Documentation/devicetree/bindings/nvmem/
>   F:	Documentation/ABI/stable/sysfs-bus-nvmem
>   F:	include/linux/nvmem-consumer.h
> +F:	include/linux/nvmem-machine.h
>   F:	include/linux/nvmem-provider.h
>   
>   NXP SGTL5000 DRIVER
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 17307015905a..854baa0559a1 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
...
>    *
> diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
> new file mode 100644
> index 000000000000..1e199dfaacab
> --- /dev/null
> +++ b/include/linux/nvmem-machine.h

This should go in nvmem-consumer.h, I don't think we should add header 
files for each usecase. These are nvmem consumers so lets put them in 
correct header file.


--srini
