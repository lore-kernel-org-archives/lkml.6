Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A62223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFQntWXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A62223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbeKNDLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:11:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35090 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeKNDLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:11:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so5987946pgu.2;
        Tue, 13 Nov 2018 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e8znlquAmWcLR9yuXxgB2cuoXzqaIywIQ1jb6pjBdY0=;
        b=QFQntWXTTSNQp1cn42G4gbYXg+BhzG+seXHSjgpyi5fPSNN8JM/AzOUnnanV6X5/Mr
         iuc5mNGX62uHCYogmQI7mK0buARpyt8yMNQxJ4WrmZXArlwNsTsdo4+PUr9RpuH0XHrB
         GWCl1bQT0besK255s/D8XzEg81fbVL8+KdsW3Kt5x1MoXRTgPGak2mBUnoYKxzM0ZnPk
         QE7Qyu6LxM1FL67DBb2bgRyO7R1uLQMucUCkC2RSzFS/QGXL4c4e5/gWRq8Ff9XiSp9T
         /qg/oHFie/YQbPtMbZ9ZQpSHSJwZLKPgtomjgrgwGrrNe/ekrv7a9Zc1TvSYsajnsmYY
         XzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=e8znlquAmWcLR9yuXxgB2cuoXzqaIywIQ1jb6pjBdY0=;
        b=bGNkmO9KldKq+S24c7TzCb2f3ABCUSJ5G095tJ7PaD0Q8Ew7oeYAbiUgZ0jGytvwkH
         6i4kcMBdbzSm/KZEw7puiJbYceUn+jU/0L6wwpwjgN0X5q0KwcdOivlnZNOX3U2Fo/Cw
         efqB7f2nvpV+K7u2BhoL7ifGjIBKpaZcS+kgycxQUu3ccWr4deyDuxvboUwKySOAy9PB
         csoM5qeAVbVj1GDmblgTag0ZKs7AEzik5LE9wn1lSxSEWECKU0jLUwbyPfSH2an0fVIZ
         aohM/u6tA83PqEujx0WqQIU0EqYy8p/v9Kf1AQt/nBgWeaJYLTFc3xxCXjSuXE4AtXyq
         LUsw==
X-Gm-Message-State: AGRZ1gKgWe93Mys2Rm+ws0j92PbHbvF54ueZOZQ2z72s4agVpb/QLNlG
        UbgRybV/vVYvVVnbNAX6QRw=
X-Google-Smtp-Source: AJdET5fJyC2DPnY86selD0QqQEklQ3sIoHZVvNt3jGMbt9S+kWheZJ2vmVyReY59zXRUCuUblp7hfQ==
X-Received: by 2002:a63:5153:: with SMTP id r19mr5441587pgl.281.1542129172013;
        Tue, 13 Nov 2018 09:12:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15sm13747755pfj.131.2018.11.13.09.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 09:12:50 -0800 (PST)
Date:   Tue, 13 Nov 2018 09:12:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon (lm63) Do not overwrite data->kind
Message-ID: <20181113171249.GA21521@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:36:56PM -0800, Nicolin Chen wrote:
> According to the code right before the removed line, data->kind
> should be either from DT or from id pointer. So there shouldn't
> be an additional overwriting after the if-else statement.
> 
> So this patch just removes the overwriting line.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Guenter,
>     I have not really tested this change but still sent it out
>     since it looks obvious. Please feel free to drop it if you
>     have concern at an untested change. Thanks.

Good find. You are right, the patch introducing the DT code didn't
really do anything. Given that no one (including me) noticed that
commit b25f663b91f1a was effectively a no-op, I'll queue this up
for the next kernel release.

Thanks,
Guenter

> 
>  drivers/hwmon/lm63.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 4c1770920d29..eac54b9cdeec 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -1120,7 +1120,6 @@ static int lm63_probe(struct i2c_client *client,
>  		data->kind = (enum chips)of_device_get_match_data(&client->dev);
>  	else
>  		data->kind = id->driver_data;
> -	data->kind = id->driver_data;
>  	if (data->kind == lm64)
>  		data->temp2_offset = 16000;
>  
> -- 
> 2.17.1
> 
