Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F52C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D197206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXKmDPQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfAGOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:04:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45855 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfAGOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:04:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so181921plm.12;
        Mon, 07 Jan 2019 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+U3XuUmg0XccEuCDZlmrK486PGTLmI8Q6wHipDWNVfQ=;
        b=RXKmDPQ3W5hRRkcqEWde7OeULy1TosigWT0tolNGir2XbYrWQFwh2QRMTVcq3HLXDJ
         Qt7BYnxwTaCh7HuAF+Cumf5XqHA8/IIdW/2zYiPwZHpCQzX1Tv+FD6+Zlizq0Uy1jFQo
         pZo8vtNyxIu3Sd7w4vmkaZh4R6veqnwhhRj5DjC2g3YxedesjE7gQFmD7a8xmrynLsVx
         bcN8ZQcra9OPUzjDjC0JNyGixWVvqDA0eqh69Pm4NoC3ZGeZa47PS8hcCipNn/BVzT9+
         d/d1jk3tF7ivXnlBnexItTx/8Usi3UoSvJW6BHlAnocgRpdbqWW67HC87GGktsP0hPJc
         G9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+U3XuUmg0XccEuCDZlmrK486PGTLmI8Q6wHipDWNVfQ=;
        b=aiXOVKgdTIReVEpQAA45wQ4JfNRH8jrpPKVnOjZqHYeFaA37OT9ufIOrlony83T+rK
         mEwQBdFtiATFupItZw5nXz+DGDatjqJ0y4jBsBQmRhGyk6dDErP+chb98DUQyB/N4Kww
         yGs1jVuPAfVYmDhx5FCi67X8ij4XiCpHT1vCyZ8v11auwM7BbYlyJya9BfuETdJsHbME
         psg6vKTpFNBPasHaAXhc/nFvWQpX6ml1uwNtUPdUrOKMYwgaRoXH2p9eQ1Q94XqsGePN
         SLgj9gY6TprYYzof0AAIKYXCTiwQk3tZYNdgOUWTcIUh3rO3ZPyJwf/uFWELty3LgZIs
         nvcQ==
X-Gm-Message-State: AJcUukd3iy2+TI9WTQo6EYQKK+TfaklE2CSDRAWjFQwBiKJM+wXtkWuz
        vyhc3QDdM+bLjfpaTU6tadk=
X-Google-Smtp-Source: ALg8bN7Pq5X5vP0fQjLthXxuetJkK6LFeuh2u5OEN7W9VLeC6JAclHuML4rvVcqulkooOn/A3Tu+QA==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr62308161pla.267.1546869852854;
        Mon, 07 Jan 2019 06:04:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 22sm84612975pgd.85.2019.01.07.06.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:04:11 -0800 (PST)
Subject: Re: [PATCH v2 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>, jdelvare@suse.com
Cc:     openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <b336867f159242e141f21e2bef7182adbc624fbd.1546851856.git.xiaoting.liu@hxt-semitech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <db6cdd06-c895-566c-0514-fe56a362d215@roeck-us.net>
Date:   Mon, 7 Jan 2019 06:04:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b336867f159242e141f21e2bef7182adbc624fbd.1546851856.git.xiaoting.liu@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 2:57 AM, Xiaoting Liu wrote:
> Current code compares device name with name in i2c_device_id to decide
> whether PMBUS_SKIP_STATUS_CHECK should be set in pmbus_platform_data,
> which makes adding new devices with PMBUS_SKIP_STATUS_CHECK should also
> modify code in pmbus_probe().
> 
> This patch adds pmbus_device_info to save pages and flags. Its pointer
> is put in driver_data of i2c_device_id, which makes adding new device
> more straightforward.
> 
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
> v2:
>    Move struct pmbus_device_info definition location from pmbus.h to pmbus.c.
>    Change struct name from default_pmbus_info to pmbus_info_one.
>    Change struct name from pmbus_info to pmbus_info_zero.
>    Replace struct name dps460_pmbus_info and sgd009_pmbus_info with
>    pmbus_info_one_skip.
> ---
>   drivers/hwmon/pmbus/pmbus.c | 55 +++++++++++++++++++++++++++------------------
>   1 file changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index 7688dab32f6e..e38dd97cc49a 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -28,6 +28,11 @@
>   #include <linux/pmbus.h>
>   #include "pmbus.h"
> 
> +struct pmbus_device_info {
> +       int pages;
> +       u32 flags;
> +};
> +
>   /*
>    * Find sensor groups and status registers on each page.
>    */
> @@ -172,13 +177,15 @@ static int pmbus_probe(struct i2c_client *client,
>          struct pmbus_driver_info *info;
>          struct pmbus_platform_data *pdata = NULL;
>          struct device *dev = &client->dev;
> +       struct pmbus_device_info *device_info;
> 
>          info = devm_kzalloc(dev, sizeof(struct pmbus_driver_info), GFP_KERNEL);
>          if (!info)
>                  return -ENOMEM;
> 
> -       if (!strcmp(id->name, "dps460") || !strcmp(id->name, "dps800") ||
> -           !strcmp(id->name, "sgd009")) {
> +       device_info = (struct pmbus_device_info *)id->driver_data;
> +

Please no empty line between assignments and checking its results.

> +       if (device_info->flags & PMBUS_SKIP_STATUS_CHECK) {
>                  pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
>                                       GFP_KERNEL);
>                  if (!pdata)
> @@ -187,36 +194,40 @@ static int pmbus_probe(struct i2c_client *client,
>                  pdata->flags = PMBUS_SKIP_STATUS_CHECK;
>          }
> 
> -       info->pages = id->driver_data;
> +       info->pages = device_info->pages;
>          info->identify = pmbus_identify;
>          dev->platform_data = pdata;
> 
>          return pmbus_do_probe(client, id, info);
>   }
> 
> +static const struct pmbus_device_info pmbus_info_one = {1, 0};
> +static const struct pmbus_device_info pmbus_info_zero = {0, 0};
> +static const struct pmbus_device_info pmbus_info_one_skip = {
> +                               1, PMBUS_SKIP_STATUS_CHECK};
>   /*
>    * Use driver_data to set the number of pages supported by the chip.
>    */
>   static const struct i2c_device_id pmbus_id[] = {
> -       {"adp4000", 1},
> -       {"bmr453", 1},
> -       {"bmr454", 1},
> -       {"dps460", 1},
> -       {"dps800", 1},
> -       {"mdt040", 1},
> -       {"ncp4200", 1},
> -       {"ncp4208", 1},
> -       {"pdt003", 1},
> -       {"pdt006", 1},
> -       {"pdt012", 1},
> -       {"pmbus", 0},
> -       {"sgd009", 1},
> -       {"tps40400", 1},
> -       {"tps544b20", 1},
> -       {"tps544b25", 1},
> -       {"tps544c20", 1},
> -       {"tps544c25", 1},
> -       {"udt020", 1},
> +       {"adp4000", (kernel_ulong_t)&pmbus_info_one},
> +       {"bmr453", (kernel_ulong_t)&pmbus_info_one},
> +       {"bmr454", (kernel_ulong_t)&pmbus_info_one},
> +       {"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
> +       {"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
> +       {"mdt040", (kernel_ulong_t)&pmbus_info_one},
> +       {"ncp4200", (kernel_ulong_t)&pmbus_info_one},
> +       {"ncp4208", (kernel_ulong_t)&pmbus_info_one},
> +       {"pdt003", (kernel_ulong_t)&pmbus_info_one},
> +       {"pdt006", (kernel_ulong_t)&pmbus_info_one},
> +       {"pdt012", (kernel_ulong_t)&pmbus_info_one},
> +       {"pmbus", (kernel_ulong_t)&pmbus_info_zero},
> +       {"sgd009", (kernel_ulong_t)&pmbus_info_one_skip},
> +       {"tps40400", (kernel_ulong_t)&pmbus_info_one},
> +       {"tps544b20", (kernel_ulong_t)&pmbus_info_one},
> +       {"tps544b25", (kernel_ulong_t)&pmbus_info_one},
> +       {"tps544c20", (kernel_ulong_t)&pmbus_info_one},
> +       {"tps544c25", (kernel_ulong_t)&pmbus_info_one},
> +       {"udt020", (kernel_ulong_t)&pmbus_info_one},
>          {}
>   };
> 
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 

I think I mentioned that before. This legalese makes it all but impossible
for me to apply your patches.

Guenter


