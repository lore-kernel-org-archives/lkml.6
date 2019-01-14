Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35394205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQU+bXrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfANWIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:08:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39023 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfANWIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:08:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so260658pld.6;
        Mon, 14 Jan 2019 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=shHou+66+RjSgcQd8m33V51MEprMke5m68diHVIUSQs=;
        b=SQU+bXrOHhu6I3frFOYkIAxI1I04OlkuQHps4JykshNlzR87qkKlsLZlHYbVkcBQFW
         6YBCkalfT47n9xxLJ2l9qzf+6uq4XuvIzNCi6OzKgwn3dkKJ9vUdGEhVV0Lsasq0p76W
         R3C/ZAGVlqhdJGMKGu6kHPIQ1CB8II/oPz30Jw4ZEB3tSGmW4ps6yTGw2bCGWX5CdJZG
         DDwKkQxSifhAKMplWSGBdaAkHa7qe9CHA+75JeVGGI1HBEUKTJEeeH/uKPI8xmLRpbZe
         smRQ4zN/hOAvPoz0CRSis5dFs53IsbEvTIMOe4hrKsVEy4c7NY7hBlSCt+y0BdJ67FL8
         I9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shHou+66+RjSgcQd8m33V51MEprMke5m68diHVIUSQs=;
        b=X6Gs77k5coNAgZxgHihdc0EWf4lFtQLY5bD/R5dbPQ27doDjmlWJudJA+f9rnOjxN9
         pXewYLeXGij+Co2t4w5B87A6QBbWKNEqLy7kF+419SP/UUBk9C+z4uw21s1nYSEFmwKm
         LMu6Ff5vNDRuOO2HwGSU6zZvo2mbFuEm5lOsDDqRflTk/8Xs2q3ZugfBjo/9Y88h8OuF
         Ejqh1/BsIcQKB4QNPW9AZzrrY5nT6BnodkZdBy/TXOFhf63+Fwlg/RONMtZH2Eb9l0DT
         xkS8OM6lWk+e5VV/sQd8Ck6Wc4nJnsiJxTvWFqIpr4pOxksyGiAlHtHcXgcNRUuDWVHx
         lQgw==
X-Gm-Message-State: AJcUukdxhlwtotWYphPppGaf3B9iZ9PeLnotnpTLqGxs+SkZrkcAHfnx
        6qYarJK50w/PNjvJ1adDS6q6w4TW
X-Google-Smtp-Source: ALg8bN72AF/IAKGPiBxnJGSMHbnsOOZKdVbatqVO4aPt9J49mKrzCVobuVCC7furIFpnj2y3sMz14w==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr725269plp.180.1547503679459;
        Mon, 14 Jan 2019 14:07:59 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v89sm2593155pfj.164.2019.01.14.14.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:07:58 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:07:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Byoungyoung Lee <lifeasageek@gmail.com>, rydberg@bitmath.org,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix undefined behavior in
 uinput_validate_absinfo()
Message-ID: <20190114220756.GF117329@dtor-ws>
References: <20190114220448.GA241112@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114220448.GA241112@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:04:48PM -0800, Dmitry Torokhov wrote:
> An integer overflow may arise in uinput_validate_absinfo() if "max - min"
> can't be represented by an "int". We should check for overflow before
> trying to use the result.
> 
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/uinput.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 8ec483e8688b..26ec603fe220 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -39,6 +39,7 @@
>  #include <linux/init.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> +#include <linux/overflow.h>
>  #include <linux/input/mt.h>
>  #include "../input-compat.h"
>  
> @@ -405,7 +406,7 @@ static int uinput_open(struct inode *inode, struct file *file)
>  static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
>  				   const struct input_absinfo *abs)
>  {
> -	int min, max;
> +	int min, max, range;
>  
>  	min = abs->minimum;
>  	max = abs->maximum;
> @@ -417,7 +418,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
>  		return -EINVAL;
>  	}
>  
> -	if (abs->flat > max - min) {
> +	if (check_sub_overflow(max, min, &range) && abs->flat > range) {

This should be !check_sub_overflow(...) of course.

>  		printk(KERN_DEBUG
>  		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
>  		       UINPUT_NAME, code, abs->flat, min, max);
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
