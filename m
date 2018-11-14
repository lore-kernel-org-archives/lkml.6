Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815CB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815CB20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeKOBoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:44:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38219 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeKOBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:44:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so7963318plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMOqUwqEcY+BbL/wGADWN2ro23WXGClZxKZcWgBhzjY=;
        b=C3CZDVUBHfeAwKHoY3XLtI+8rb8hw7rk5Ee1g0X6uoV3fsPy7fLAulasNZliqtdyqc
         vvf7OF3Y0yD4xyNe4emWLuh42bJ3Jhn3vhR09SsKMXoHsOaQwizqVjwe/IIZEclJ5cBr
         NX1BNg12Aep5HU8/OOPA1q1X/AtHvNbpyO2lq8Ax1+DqaAch8LeAsloI/wIswnomMbYN
         GuN2dpMzxR5fCulBoOJSnkkrKD6y7zx53ovHe7lfUJn5Ae+BYBLuHe+X3Z8e7xseOIn5
         GmY/AShCqb9zUPEoxHsySsn0l/2ur7NoA38G/li2bmGXD7a9qk7uY7kHqtnIM7D5Mnm4
         DLxQ==
X-Gm-Message-State: AGRZ1gI9Asu6F8a/fTlbnsUVLvvUJ332q/M86PUSmiixtCEq+p2cbqPU
        vLK9TXb8GOEp69iI/musjA+PH4+4tBg=
X-Google-Smtp-Source: AJdET5efyBiyGf5U9EhWGwJGkkcywA3rp2IOJOFC6BvHiW+VykwBBnhD+lI1FM6o1EREU0yXfV1H3g==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17-v6mr2323462plp.274.1542210045527;
        Wed, 14 Nov 2018 07:40:45 -0800 (PST)
Received: from [192.168.46.186] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id b27sm13952395pfh.113.2018.11.14.07.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:40:44 -0800 (PST)
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
To:     David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, Kees Cook <keescook@chromium.org>
References: <20181114131642.21425-1-dh.herrmann@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
Date:   Wed, 14 Nov 2018 07:40:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114131642.21425-1-dh.herrmann@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/18 5:16 AM, David Herrmann wrote:
> This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.
> 
> Please note that `strlcpy()` does *NOT* do what you think it does.
> strlcpy() *ALWAYS* reads the full input string, regardless of the
> 'length' parameter. That is, if the input is not zero-terminated,
> strlcpy() will *READ* beyond input boundaries. It does this, because it
> always returns the size it *would* copy if the target was big enough,
> not the truncated size it actually copied.
> 
> The original code was perfectly fine. The hid device is
> zero-initialized and the strncpy() functions copied up to n-1
> characters. The result is always zero-terminated this way.
> 
> This is the third time someone tried to replace strncpy with strlcpy in
> this function, and gets it wrong. I now added a comment that should at
> least make people reconsider.
> 

Can we switch to strscpy instead? This will quiet gcc and avoid the
issues with strlcpy.

> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>   drivers/hid/uhid.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index fefedc0b4dc6..0dfdd0ac7120 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -496,12 +496,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>   		goto err_free;
>   	}
>   
> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
> -	strlcpy(hid->name, ev->u.create2.name, len);
> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
> -	strlcpy(hid->phys, ev->u.create2.phys, len);
> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
> -	strlcpy(hid->uniq, ev->u.create2.uniq, len);
> +	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
> +	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
> +	strncpy(hid->name, ev->u.create2.name, len);
> +	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
> +	strncpy(hid->phys, ev->u.create2.phys, len);
> +	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
> +	strncpy(hid->uniq, ev->u.create2.uniq, len);
>   
>   	hid->ll_driver = &uhid_hid_driver;
>   	hid->bus = ev->u.create2.bus;
> 

