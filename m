Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9241A27179
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bS3AYyZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241A27179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935134AbeF1Jdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:33:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52159 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934745AbeF1Jdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:33:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so8858441wmw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WUecvUx9QESOf5NBce9X6sWFXdFF5TRW/BixNf4XDSQ=;
        b=bS3AYyZyOZvw8elJLjYJy6Q1kf2ey2YBznllQp5FOuN4xDl2YyKyrdxV6drsinl6i7
         eohNY6z1rTYcLLlewqMxnp6g4bOEqOYcuDjIRbXtxIHYvWp3WBfXR4xE/P2RtDjF4ZFu
         +j2kkaDGyWGLIjkWl8Kp9IK2zj9NHo/k/eNmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WUecvUx9QESOf5NBce9X6sWFXdFF5TRW/BixNf4XDSQ=;
        b=AKvqWmhU5Gop3tshYkZ1VFxOsmlNNTHXS5zaqrSeAeVFKp/c6DL8WxIIVpPGOvcmGo
         tf/RmMRym9EZKMHC1MDFKeYjHZrYiRNthrXpn8bLS4RolRMjCfShdNLurajueUAUw+Bq
         Te+/GQIBISUg4EWusxTVdWQfkCJuf8TGcivQm46CVJxVYxRfdVzhHOHbRwKK+d92U/Lm
         hd8mryvsyRRmuCOYF0AJ+sqkbB+rz1eTPPSUU72xzYWoWlP0UeZoIb6jFh7mDkw3daYX
         al+8UZ+9LjNRu8oGHwNzW2JDAXneDuZF/oh8U5YmhjGDviH4jd6Oeo7xm1VYTkq6c1PT
         Atbg==
X-Gm-Message-State: APt69E1CSyDxoAao+LbKrmY1miwjT8yiTqADvX4KIIJafBKblc6Rzapv
        m/flK5cxVsKhF/jMTYJbT2a6kg==
X-Google-Smtp-Source: AAOMgpedNWcbtOJ1jkDDNFmwZfr3+nD/A8L8SkiUxHG2BwCjJQjtTZ33rVBI/6t2CnSmf6pbG1Hmng==
X-Received: by 2002:a1c:c3c6:: with SMTP id t189-v6mr719652wmf.59.1530178410088;
        Thu, 28 Jun 2018 02:33:30 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id e17-v6sm5672769wrr.85.2018.06.28.02.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:33:29 -0700 (PDT)
Subject: Re: [PATCH v2 01/15] nvmem: add support for cell lookups
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180626102245.30711-1-brgl@bgdev.pl>
 <20180626102245.30711-2-brgl@bgdev.pl>
 <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
 <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1b3736c0-246e-4725-b64f-da916b9a0383@linaro.org>
Date:   Thu, 28 Jun 2018 10:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/18 08:56, Bartosz Golaszewski wrote:
>> We should also have something like nvmem_remove_lookup_table() for
>> consistency, and it should ensure that it clears the cells entry too.
>>
> What do you mean by clearing the cells entry exactly?
I meant, Removing entry from the nvmem_cells list.

Initially I though we should remove the entry form nvmem_cells list, 
but It would complicate this path if some consumer has reference to it.

So, just removing the lookup list should be good! Lets not worry about 
removing from nvmem_cells list.


--srini

> 
> Bart
> 
