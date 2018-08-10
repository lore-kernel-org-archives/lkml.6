Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F181C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DA0223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdItCVha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA0223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeHJLCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:02:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33168 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeHJLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:02:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so837678wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cdi2TvlBH96SFmWkfoG5hkjVI/vJ8e6JJdfWlbLSQF4=;
        b=RdItCVhaxuiPJHsJmwwT5Q47pYWjY/Ae1c5n2Oyg9/SKHOvc5gL9iENRuSRpbwZCj1
         Vb9H9xcSkdsfiWj5k7FXgeYnKSCSxUqeyYKEUQv4SV6JsdUuMeycoLnbWNbzMD5EDlWD
         m1ufXMOMylVEr+kUzuO55hEnaZ9ybt8jVqdTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdi2TvlBH96SFmWkfoG5hkjVI/vJ8e6JJdfWlbLSQF4=;
        b=jfEObkdfD91w2ScqhpwH8VblQKrXeMhw/BZ5BDphCdDnE9LDS7SB0FT7svaBCPlfkV
         B7qOpSw0epYS8lFPBT0GPhmnXCNNm22vMEUnxYUng7a3VgkWtLSrRoHi+iDgw4Jb1JgF
         YIXcu7M3PeUBuuYnrlinwEReEgMc2P3XLlamfOYXJ6pLQJtGIO39qt4cMTSYagPCyeQk
         UsiyTH2xkIrGkk7quLkZ1n4wLpHsFfvkkUZ2z3p/u5rwNtfjU6UDj1CkkkrVcG0ZqFr1
         eDG3oPljjoaaAT5WXGtqUBCZPpD3t7BCyJ7Sot9xzGcxgOxMoRrJzp+ih6r1WQ//H24C
         qAdg==
X-Gm-Message-State: AOUpUlHHieVNpu8PrDwVOqCSKucddnfCD9jfFQXeQqQAnh9ayPKeBrir
        EPi/eabx00xd0GAJN26EPKws3A==
X-Google-Smtp-Source: AA+uWPxhxFcmckse03BprpqLp3lkHRkQvU4HY6mnZIHv32zAT5Zv+dy0icEQbkr4HQPI9hcdHEpLtQ==
X-Received: by 2002:a1c:9f86:: with SMTP id i128-v6mr776105wme.156.1533889999159;
        Fri, 10 Aug 2018 01:33:19 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id k6-v6sm9282460wrv.92.2018.08.10.01.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:33:18 -0700 (PDT)
Subject: Re: [PATCH v2 03/29] nvmem: add a notifier chain
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-4-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <343dde5f-7e92-426f-89e4-1bfcf6714337@linaro.org>
Date:   Fri, 10 Aug 2018 09:33:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180810080526.27207-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
> +int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_register_notifier);
> +
> +int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
> +
Kerneldoc is missing for these both exported symbols too!

--srini
