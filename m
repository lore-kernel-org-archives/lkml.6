Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC6C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3CF206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRSBdK+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfAJSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:42:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42193 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:42:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so5551066plp.9;
        Thu, 10 Jan 2019 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GmBKVju7YpXYxZxfMod0Ao5g3yfsoyp7zP+gkrAEqrk=;
        b=VRSBdK+qlxZFezxWlJF0twycu102H5+rmtO01buiToMpWnbKVsumyVzg+oYFwlwhNT
         k734y0PlEmqk4Ldr1NzYJmOOhkGKVWIV3CSlQDF0uZmXYVJk5QzS2E62P3awtbrfQPig
         lxFJyF6GVQkRHwBImj6te2NAJ0V0ry8PqZYM+vOa4Bgao6mdJSgdd1lv+4dV7IJi3Sjh
         SCcFRkhqd5wPKEajt/gaNW3UwUxCNXV559NYyXctlrMyHejqhCKK6n7c4d8X0OdrlcSl
         XEf6LzjVlAr11jhNLr5JiQOs/mXWusRnNDgM/Zwvu5WiLuWamwc1/ABiivxtccGNgdR4
         PUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GmBKVju7YpXYxZxfMod0Ao5g3yfsoyp7zP+gkrAEqrk=;
        b=f2PsnyGF0G76zIb2fPreX4ypm057rn/Zwb6NbnAKkjItg0QFCQfgTyQUlCbhbq/9se
         JTos5Rt0WNPxyG1Fap0k8RazW0TIyNqS8btrI3ExEKbL3Ji+IWOEE9HKoCDzypvqwoTP
         Uio4V0ePOoTUka92HIXRV0kzV+rTMcjjRGGHZBnDkblPyry2Zdk8UvKsBsIrkxRLxJG3
         9p+yTn8YTRbqEJSFx63M8cyKVIArd3FQfEsXIOFJCeZO5wEFr15UKJ0x+r2u0TbiA0sn
         X4keImsuCwxMeuZtnC4s+/hdvK0BZl68jCK8UJdJdNR7hfZYHkAab3+2K9DI0ljqP/RU
         O/uQ==
X-Gm-Message-State: AJcUuke7shkJW99NccWJ81w4TrHxRLeZaIuEdzugDioO/YrA6np4TGtJ
        lyP6EgfEBRweUjsjDinAwVQ=
X-Google-Smtp-Source: ALg8bN58bphF34IBddXD21DM+2+BSjyaYpSwmsYXMavtJtI2y9DMA/O/E86C3rAu9yW4B/Y1QgnJhA==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr10941431plp.19.1547145748937;
        Thu, 10 Jan 2019 10:42:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d69sm104501339pfg.168.2019.01.10.10.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 10:42:28 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:42:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Cc:     jdelvare@suse.com, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        shunyong.yang@hxt-semitech.com, dongsheng.wang@hxt-semitech.com
Subject: Re: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
Message-ID: <20190110184227.GB9010@roeck-us.net>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <625d047f0f42d30bb5ceb75ada529b5fa0c9a21a.1546918172.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625d047f0f42d30bb5ceb75ada529b5fa0c9a21a.1546918172.git.xiaoting.liu@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:31:44AM +0800, Xiaoting Liu wrote:
> Provide support for PSU DPS-650AB from Delta Electronics, INC.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v3:
>   No change.
> ---
> v2:
>   Change the patch subject and commit message.
>   Drop dps650ab.c file.
>   Replace struct name dps650ab_pmbus_info with pmbus_info_one_skip.
> ---
>  drivers/hwmon/pmbus/pmbus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index ef845a1310fa..e648ed8d926a 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -212,6 +212,7 @@ static int pmbus_probe(struct i2c_client *client,
>  	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
>  	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
>  	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
> +	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
>  	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
>  	{"mdt040", (kernel_ulong_t)&pmbus_info_one},
>  	{"ncp4200", (kernel_ulong_t)&pmbus_info_one},
> -- 
> 1.8.3.1
> 
