Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D998C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0372C216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY2rTmFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0372C216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHUQy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:54:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeHUQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:54:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so2987100wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C42zPFqmvCGsNDPIk7JUlF/7n5UyUyS88HsCgICvxvg=;
        b=bY2rTmFF9G1ammigFMLmiOyaNxHV8691tBH7pYyD+4zvo4hQBxh/FDv226KyLXpXU8
         qeYwjeozwJIUmx4wLxrD/9Qg9l1/E3Id1lqQVWcojlcBXzIUWsAsPWA0+UBJmVVlTBCg
         0M1se0y84kClr+BkDfJ852LCGU+KGNU+CdqKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C42zPFqmvCGsNDPIk7JUlF/7n5UyUyS88HsCgICvxvg=;
        b=EL2XnOZdZiJRrz8J0gOPrf+YBLWmbVT9KyOP8hx0MCNiBTb95gH3Lx0liIs1XHMljk
         uXJfHpN4iSgid5Mp6bEV08/rzd7ZiPeNckkWN9KrvVNB3gZ21I7cCoRvOMQzwEBB1VvY
         2/ETYCexxRnal5h7IJLtZ450P8riGLGV5yH19w/gHmqfPJj7Sj46Sm0JU9MIamMAa4CO
         1Q05v5AqVviFb67vSZM+7czY7rLYfNEOc1UUuzil4+Y/v4JFpzLrYRW+J+BDKk3sRWLZ
         gPmL0UB75uRIDhPapj1RpgIhV3i/i2zNTPEzYY5AaA++PHeOC9/e1NF+Nn217pKJ9SPJ
         L4ZA==
X-Gm-Message-State: AOUpUlGIgY7gFfZf1Cz7h4JVbo4hBCtSUS9pGyz3jm6qlm5vl7h7ZjsU
        4ges5G7EkLX/QDne3PhpV4FrVA==
X-Google-Smtp-Source: AA+uWPySzM3XFkhE6yc2CuSosUeS+vax2L+m8s9RExPCaEmWOdw99DBffCE/uiwwJcwyADqemu5/EA==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr29016440wmg.58.1534858486848;
        Tue, 21 Aug 2018 06:34:46 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id z141-v6sm3305479wmc.3.2018.08.21.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:34:46 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
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
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <20180821005327.0d312a85@tock> <20180821074404.23aaeb6b@bbrezillon>
 <81407b4d-a02f-4085-f333-a96102bd96ce@linaro.org>
 <20180821133136.1fada1b6@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6fb36da4-c985-6d6e-f9e1-572f5cd7609b@linaro.org>
Date:   Tue, 21 Aug 2018 14:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180821133136.1fada1b6@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/18 12:31, Boris Brezillon wrote:
>>     * struct nvmem_config - NVMEM device configuration
>> @@ -58,6 +62,7 @@ struct nvmem_config {
>>           bool                    root_only;
>>           nvmem_reg_read_t        reg_read;
>>           nvmem_reg_write_t       reg_write;
>> +       nvmem_match_t           match;
>>           int     size;
>>           int     word_size;
>>           int     stride;
>>
> That might work if nvmem cells are defined directly under the mtdnode.
Layout should not matter! which is the purpose of this callback.

The only purpose of this callback is to tell nvmem core that the 
node(nvmem cell) belongs to that provider or not, if it is then we 
successfully found the provider. Its up to the provider on which layout 
it describes nvmem cells. Additionally the provider can add additional 
sanity checks in this match function to ensure that cell is correctly 
represented.


> If we go for this approach, I'd recommend replacing this ->match() hook
> by ->is_nvmem_cell() and pass it the cell node instead of the nvmem
> node, because what we're really after here is knowing which subnode is
> an nvmem cell and which subnode is not.

I agree on passing cell node instead of its parent. Regarding basic 
validating if its nvmem cell or not, we can check compatible string in 
nvmem core if we decide to use "nvmem-cell" compatible.

Also just in case if you missed this, nvmem would not iterate the

--srini
