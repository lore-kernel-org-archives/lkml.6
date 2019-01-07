Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229C6206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiBJ2NI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfAGOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:04:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:04:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so217652pfb.4;
        Mon, 07 Jan 2019 06:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=80bC7EvBXvwUzeNM76uilRT3B917MijdAdYsd0gcdAM=;
        b=DiBJ2NI3a4b/ydkhc1CPMQCRpf8QzHOO6WHZmXIq2SdBLWOTH3/GxfsPNsPEVKSZFf
         DqUJlvrlsvQ5lTmg9ze0DdM8RpTREbfxU3iXiXFnkaPr8uRkgX8kCLOQbEN7mpDjKsmV
         GNI7hKaWti3KSdrZszgPK3LqBuogMapFr+X3h1bpTWr4ho7bbx+yTmB6jtcu8IkFLuMk
         od50vYEGWwrAeUY8yrorTvyNkLt9zZ91rkXwXgpGaepK+qLekfFI4tTJUdS06mFlPe0K
         qQ4C9jrm1M7q6oqu+ApvlFX83IdTOI/YVuRUcUR42/DaxS4T7qXrcFAyXJfscoacxgVP
         8eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80bC7EvBXvwUzeNM76uilRT3B917MijdAdYsd0gcdAM=;
        b=kLzx6MVj/39ykVKQPqJDrPte3TfzP5S0UadMhb40xkrEFAsCJNBOrAsjfJSyhu1AFI
         bJPQc67zveOx6wtsVBwqmN/1b4ePcHAIS7PRG8jPAZM+va00lWwGs8DYviXDu+gIVe+S
         xaxAMFCRHo9ZK2Hh+tSHDUA9Lx1LqJiOptDcSRsW9yVh0U99/DcqR08U8qBVz7IuQAyC
         m9rDh9g3v2RML34eKUyU9fkLtYBHHVz1x0N5g5LmZP6ZrIIOkqs5S18ecb9fon0lJ9ne
         lzebOHHF0HrJ6Wyw/XZ9OwpRDk6Q0/e+7v3j4WaywbsvdP4tIPbDrLgWkwSQlOCTZqCv
         8j8A==
X-Gm-Message-State: AJcUukfHDo35a4PbrYcpuanNkSD8kYOvJSK/F1LGUHThkhuabLWdjkhg
        P868BzeqjyTVlIdvGbrJaPawZEds
X-Google-Smtp-Source: ALg8bN7HtwoXE3vIX7aHAViJkI1WHNvGPl3YDw5p1KHjEUsmskVkJwWJan4gteEUVNy8e1VTqZq7Ng==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr10858334pgf.402.1546869885076;
        Mon, 07 Jan 2019 06:04:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u29sm92340056pgn.23.2019.01.07.06.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:04:44 -0800 (PST)
Subject: Re: [PATCH v2 4/4] hwmon: (pmbus) add support for DPS-650AB
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>, jdelvare@suse.com
Cc:     openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <2e94eb44c0acf6b90c1d9bbffd1c5c5cc2af59be.1546851856.git.xiaoting.liu@hxt-semitech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af54e702-d384-4af8-0cbc-008a1e927b67@roeck-us.net>
Date:   Mon, 7 Jan 2019 06:04:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2e94eb44c0acf6b90c1d9bbffd1c5c5cc2af59be.1546851856.git.xiaoting.liu@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 3:06 AM, Xiaoting Liu wrote:
> Provide support for PSU DPS-650AB from Delta Electronics, INC.
> 

Where is patch 3/4 ?

> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v2:
>    Change the patch subject and commit message.
>    Drop dps650ab.c file.
>    Replace struct name dps650ab_pmbus_info with pmbus_info_one_skip.
> ---
>   drivers/hwmon/pmbus/pmbus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index e38dd97cc49a..f6b35f858db8 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -213,6 +213,7 @@ static int pmbus_probe(struct i2c_client *client,
>          {"bmr453", (kernel_ulong_t)&pmbus_info_one},
>          {"bmr454", (kernel_ulong_t)&pmbus_info_one},
>          {"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
> +       {"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
>          {"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
>          {"mdt040", (kernel_ulong_t)&pmbus_info_one},
>          {"ncp4200", (kernel_ulong_t)&pmbus_info_one},
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> 
> 

