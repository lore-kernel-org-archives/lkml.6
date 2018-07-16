Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7EEECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584D8208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNbbxkej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584D8208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGPK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:29:59 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:37590 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeGPK37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:29:59 -0400
Received: by mail-lj1-f172.google.com with SMTP id v9-v6so19095290ljk.4;
        Mon, 16 Jul 2018 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2zyESEeLed+XQUoEdVKmHoZNTJKreUo+Q8McYzIZmmk=;
        b=rNbbxkeje0gmxZ0fKEtLCcwytvmGS+ucKZd+AQiBFDBcyE1JuFtRO6txPb1xj1hejq
         LDt18dRXHTRznXwstCEADxe1sWkASeutMwup2Mbc7hl8IL+wgotpy/Czey9GxXOC5tXf
         YVjmyjzj4dnBPRnZ5DdM6fijiLf8ahj7RGM7+3aYfL2Pd+1Mmr4y89zBNqzLIEgA8r2F
         tLXcLxUchxT9G11seG1sJtIUa6SLIiXy9C322xLog9QWpdc1jbxdwGA4083lc8CfjCcw
         JKu6fyzTHGr1iUgQp/aVp6wgszdbqLpER0ffiItLVYLizptmFbygLDG1RWKKF7G6o1xM
         1H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zyESEeLed+XQUoEdVKmHoZNTJKreUo+Q8McYzIZmmk=;
        b=T65/MIpiv24S34lD/B0XFVHB7ba+M0I6Vhds8JINY6wmnYJv4kBFooK3A/6X+rVpEw
         SbATfc12guifcOHNv4RsNmi8093FkGmwrvyjOv0TBWQ2IAqt5zF4zoBpXOzvAFUUJCjP
         Yc8odT4xDJ6/4d/sbmhWcruPQy8BG7MUB+RqGv4F1Ndu2GlddBUCx0+Oea22InQts0pT
         CAerNV7Keg+IiYuVVlnZ6Mqv9hPX1swKJx73Iw0KKBSJBbrYQBd3NqPrJuIMxlcATmml
         ywVr5m9N8k5XaZULN+xklN8QdDM5vsiEGu3mzLoDXBkxhiUzPZY9sEMmbfcR3bbHL8Jf
         jpqQ==
X-Gm-Message-State: AOUpUlFX882+c/Q79uzwxIuDXdwUfWjm1nQ3qaME0NSb2NVGE0ypLoaN
        w7X+RihvVRgwQ5mBnBqLBBj66cXq
X-Google-Smtp-Source: AAOMgpemeeaYVEbiNqrPGcUq2GG6fyokq1RbX3jk0W5Ew1pfSPZiEjNVOr9jAOE8y7zgGY6mln1rTg==
X-Received: by 2002:a2e:e3:: with SMTP id e96-v6mr9444422lji.82.1531735398792;
        Mon, 16 Jul 2018 03:03:18 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id r23-v6sm2816083ljc.15.2018.07.16.03.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 03:03:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff0LV-00075r-G5; Mon, 16 Jul 2018 12:03:09 +0200
Date:   Mon, 16 Jul 2018 12:03:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     moviesong <MovieSong@aten-itlab.cn>
Cc:     johan <johan@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        YorkDai <YorkDai@aten-itlab.cn>, BillLi <BillLi@aten-itlab.cn>
Subject: Re: your mail
Message-ID: <20180716100309.GJ10204@localhost>
References: <201807160555.w6G5t9Dc075492@mse.aten.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201807160555.w6G5t9Dc075492@mse.aten.com.tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:46:05AM +0800, MovieSong wrote:
> From cff42ec450bdd1fb44dd80564cb622660a9a8071 Mon Sep 17 00:00:00 2001
> From: Movie Song <MovieSong@aten-itlab.cn>
> Date: Fri, 13 Jul 2018 17:46:19 +0800
> Subject: [PATCH] This add a new device for ATEN
> 
> Signed-off-by: Movie Song <MovieSong@aten-itlab.cn>

First, your mail still has the legal disclaimer footer which prevents us
from using this patch.

Second, the patch is now inline, but it's unfortunately white-space
damaged (tabs replaces with spaces).

Take a look at

	https://marc.info/?l=linux-usb&m=150576193231309

for an example of what the subject and commit message should look like.

Send it to yourself first and make sure it has no legal disclaimer
footers, and that you can apply it using git-am.

> ---
>  drivers/usb/serial/pl2303.c | 2 ++
>  drivers/usb/serial/pl2303.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
> index 5d1a193..99f7e1f 100644
> --- a/drivers/usb/serial/pl2303.c
> +++ b/drivers/usb/serial/pl2303.c
> @@ -52,6 +52,8 @@
>   .driver_info = PL2303_QUIRK_ENDPOINT_HACK },
>   { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC485),
>   .driver_info = PL2303_QUIRK_ENDPOINT_HACK },
> + { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC485),
> + .driver_info = PL2303_QUIRK_ENDPOINT_HACK },

And here you add a duplicate entry instead of the one based on the new
id you add.

>   { USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID2) },
>   { USB_DEVICE(ATEN_VENDOR_ID2, ATEN_PRODUCT_ID) },
>   { USB_DEVICE(ELCOM_VENDOR_ID, ELCOM_PRODUCT_ID) },
> diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
> index fcd7239..26965cc 100644
> --- a/drivers/usb/serial/pl2303.h
> +++ b/drivers/usb/serial/pl2303.h
> @@ -24,6 +24,7 @@
>  #define ATEN_VENDOR_ID2 0x0547
>  #define ATEN_PRODUCT_ID 0x2008
>  #define ATEN_PRODUCT_UC485 0x2021
> +#define ATEN_PRODUCT_UC232B 0x2022
>  #define ATEN_PRODUCT_ID2 0x2118
> 
>  #define IODATA_VENDOR_ID 0x04bb

Thanks,
Johan
