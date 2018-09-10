Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC649C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5270720865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxdF0cMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5270720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIJM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:26:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34122 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeIJM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:26:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so20766674wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LUUUoirvmHIU5XdGXsy7cHFNXt6qB4Azz4LVtzSeqKE=;
        b=BxdF0cMN/Q4CZ3qMQvGbpkm7fdgFs75rY/tCWV6fkqHxYYmm9Z+RMSS4uD1zBOkLYt
         VHsX5MuykQjkrv3uHyvXyvMgAL/21mD+M+LPvlDFsY/+E1tciuYB22Rajtw2lq2bhKEC
         ke5wOhd17H2fKxMLbKXwR0dAzK9whCNRPln84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUUUoirvmHIU5XdGXsy7cHFNXt6qB4Azz4LVtzSeqKE=;
        b=BP9QLqXBCzca40ZhDpejKKC2bCBSJm3p9wIFg0VMizJTxsCMu0lLrdjl4PNjOKDX14
         SxBOZeo3igRNzdTBTXKhdu7BOh3pmuDRMnvUEvZ6CejYhgokFaeWi/icgct3eoEBqiX9
         ywHDWTq4LMG7Ed3B6kGFSK1Eh1qxcPyhVLs0VYOgj99Tk1TXvh1elntKl6m/89XN//7O
         Kogf7YuQ5ynstc7aWWznIM693/MX0kHqjFYeHZHSL/DePDHADlXXSGEaDW/PMExCvzFZ
         CcdiUGCw8EdyizEf+3AeOteFvJGPbGjKW5ozf3869B6FQfA1gv3tNb8IUFLUX5AMuNGV
         jj1Q==
X-Gm-Message-State: APzg51BlLQJB+KXv+TX2mTk5YhmJEzKnJjK0vZbjLtTjOECtrG6dtJHP
        f4P2ZEqRsXkPAyw+W1SVUjSloQ==
X-Google-Smtp-Source: ANB0VdaY2jEFiIXKaYAdkzwQcUk5dOIgrw/iO95d/T9H1/DSLE93iw5gx8zghLXycZ+XLibP+itgyw==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr14748248wrq.225.1536564808107;
        Mon, 10 Sep 2018 00:33:28 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s13-v6sm19132068wrq.39.2018.09.10.00.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:33:27 -0700 (PDT)
Subject: Re: [PATCH v2 07/16] nvmem: change the signature of
 nvmem_unregister()
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
 <20180907100750.14564-8-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <545e0e3a-7728-7179-2bc3-fbb813e3c39d@linaro.org>
Date:   Mon, 10 Sep 2018 08:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907100750.14564-8-brgl@bgdev.pl>
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
> This function can no longer fail and there are no more users that check
> it return value. Change it to return void.

This should be either part of Kref patch or it should state that 
refcount handling is impoved in Kref patch so there is no need of 
returning error code from unregister.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 8 ++------
>   include/linux/nvmem-provider.h | 9 +++------
>   2 files changed, 5 insertions(+), 12 deletions(-)
