Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4C6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F135217FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUDf24kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F135217FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeHJKjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:39:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51631 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeHJKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:39:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so949286wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZtOSkkpLyY5oymSlHooxe8Vnv7GsO+riwpQ/wHD/2F8=;
        b=LUDf24knO+1vWyA2ur2S5lYNdL9KlsK7wn4v3RDHEbBps4SCcAk+A0mnrux5pobdIV
         p6vcyNS8de125CmAX3sCJ5JGymjEpmpja6DonFIAUVUikHc/7dsn6JDcg3L7hF6abcbU
         I0QxegJJENMeBAb/xyDxuvK7icoLZz7b14qw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZtOSkkpLyY5oymSlHooxe8Vnv7GsO+riwpQ/wHD/2F8=;
        b=ZFJze9C/MVOxWEabr9D1ceklfFoafDfrGsLNAQAysLpZPBIgsLAYWXVdmbjVw+u9/q
         d2uX9vkEmeuhM0d5/utLDiJ8v2MwtStAA/I/rY2ct4tDRWwaa7DUYhPXUfUSDVsee3G1
         XdFH2KCRXSrfOJ3qprP31+UtnH92hmKXIvYB5rhdw/uRWRNpAO0mMWvIpylB2OOX/gRT
         RwAzUCRGbRnnBCSN/j9nlpwYuYVawE/YbZzIzxoblJsAf5PRKlmAJGdbTIsrzlK6D9yI
         H0IF2o+bcFGyVlpVvOqjlSw4iAG3yJxk9BBQ2dWeLuY0sqy1ug0TEiSF1pTMRIriV2t9
         2tDg==
X-Gm-Message-State: AOUpUlEwUkBN5UWma0UERHzgUhyyVhZlU+m4SwvK4JjRq3/V0j2NgavQ
        XmIi18/RwUcwSd5F2+j252w2Ig==
X-Google-Smtp-Source: AA+uWPxL7VoYF4X68ToGzIJt1yZszvND6TKyIKv8Cp6cUC67Aq7IF5c73OuUzXXFjffjK6/Yr5EDfQ==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr765489wmd.137.1533888628593;
        Fri, 10 Aug 2018 01:10:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm7940515wrn.83.2018.08.10.01.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:10:28 -0700 (PDT)
Subject: Re: [PATCH v2 04/29] nvmem: provide nvmem_dev_name()
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
 <20180810080526.27207-5-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <45fda8c0-aa09-3c4b-69ee-9a61265f1120@linaro.org>
Date:   Fri, 10 Aug 2018 09:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180810080526.27207-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
>   
> +const char *nvmem_dev_name(struct nvmem_device *nvmem)
> +{
> +	return dev_name(&nvmem->dev);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_dev_name);
> +
Kernel doc for this is missing!
Other than that it looks good to me!

--srini
