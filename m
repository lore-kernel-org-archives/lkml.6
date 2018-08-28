Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E456C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E97020842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFsQ/p7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E97020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeH1OLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:11:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41206 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeH1OLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:11:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so1040837wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MbXFfW2nTQu/4MMUaxCUfzzNPsgOyF2P1ycpQDWIJA4=;
        b=VFsQ/p7w4L9pVsK7j+GupT2+xXzzMx2E4pzCr01t5dNRwxQOiqG3tHr+Mia7yJSB8M
         nKsrIB0XwMzvmVOaTn9MQwjoNwtR4jDVX329VnpaM2oHoian3k8yajxdlUwH5SYKxlqL
         CJ3E0jTnDcat5Fj6XzAIg1RRT+/VfCq7KTevs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MbXFfW2nTQu/4MMUaxCUfzzNPsgOyF2P1ycpQDWIJA4=;
        b=RLOmOb9zyr/oBnDth0e50Agh+JYhvjcAD4gwuMZaiCOmP5rG75dq6saeQfaQog7mM3
         YNgEubhhp7h+gJY81GQSJw2ySD8M/XyTVz+6li3t3o7o58rpphFG6moOh4rfHFtdeVty
         zowzwfJh8Ft1CpGfT0w+8Z/JOXJREhIHVpK7d1VsrGpEqQGyFaGC904DyiiI4vWwdHhr
         DyFhGjC4b6hu89eyGXvoITpiAc0Gx/F216/1uK2IUhuQMhk/msbegcPn1UjB+2rGsP39
         S/INH6Jx7VsuyZSJA18zq8/iW0pc2bpLp+lE3yR1IlV+7FofT1n8xZRU4nGyfrf4/2KQ
         0Udw==
X-Gm-Message-State: APzg51Be9e5HZybP0ShmcoDPW6a2Yss1LlQ2NEPtQ8kUTKhdo1inDF5d
        H5ruY4OkyT0cet1kVVxgbX4nfw==
X-Google-Smtp-Source: ANB0VdZrpHX+c1dkObFCIQ2t/xtDeWwS107DoV6YxT7u+iqR1SMGLhxGjgU4Ut5TcfKHmRi5CPk0Iw==
X-Received: by 2002:a5d:4b90:: with SMTP id b16-v6mr727578wrt.168.1535451633341;
        Tue, 28 Aug 2018 03:20:33 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id p89-v6sm1345987wrc.97.2018.08.28.03.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 03:20:32 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Alban <albeu@free.fr>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821133916.3a1c51b1@eos>
 <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
 <20180821150121.4408672f@bbrezillon> <20180823122921.6857d917@tock>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <58fd7ab3-c115-1f26-6d6e-677af6351239@linaro.org>
Date:   Tue, 28 Aug 2018 11:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180823122921.6857d917@tock>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/18 11:29, Alban wrote:
> Let say I have a device that use the following binding:
> 
> device {
>      compatible = "example-device";
>      #address-cells = <2>;
>      #size-cells = <1>;
> 
>      child@0,0 {
>          reg = <0x0 0x0>;
>          ...
>      };
> 
>      child@1,2 {
>          reg = <0x1 0x2>;
>          ...
>      };
> 
> };
> 
> Now this binding already use the node address space for something,
> so putting a nvmem node as direct child would not work.

AFAIK, It should work but the we would get a DT warning this, as nvmem 
does not use of_address based apis to parse this. Which should be 
totally fixed!!

As discussed before once we add support to #address-cells and 
#size-cells in nvmem core this should not be a problem.


--srini
  Here it is
> quiet clear as we have 2 address cells, however even if the number of
> cells and the cells size would match it would still be conceptually
> wrong as both bindings then use the same address space for something
> different.
