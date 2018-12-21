Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41F7218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl599PYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbeLUI1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:27:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33240 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLUI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:27:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so2196737pgu.0;
        Fri, 21 Dec 2018 00:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e+mpaMmJU3qd+NUv7lAudbCV8zcT9yIu7TTtWgRtRZE=;
        b=Cl599PYwNWHiG68EUJcNV8HqaDgL+Bdi6TSCEW8T1AwZmjJfAenDQp9QFfWifwPjuH
         9Q+yN7iWgMa+cRFH8Y81K38q1WbnOihIY16bkbuUIv7sQY4TlriBL43nlJ4rkcwto8zC
         3tcdkk4nOAEvtXmOnyugk1aXZUT0+bhKqjduFfrKrdu7qA3vA3Sx1w2wlsNjkfqqKgEi
         HHKpNXCYXE4koZ6h/Ra8RtJj/j3ye4eJPhGATSfh5gvE0xTsGbzRTj8RH+4od2kt/F80
         KdFYDWcdWNvDbRKwjhEORS9RkWcbtOvbokN+20kb2GiSdb8l74YdvEg9T6bolHzbAmsE
         2sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+mpaMmJU3qd+NUv7lAudbCV8zcT9yIu7TTtWgRtRZE=;
        b=DjbIIrNzxq4gYbGgbbl4D4YdlSAzySHzvtMiPESdP37QtmEqdp9NfUggpTEdIxC9z/
         figerwh1TCHeJ1SeanWt+RtBd1VQSSK1+XI1XQYY1lsFXEf62eByhp9k4yIdQfbve5gE
         9KfxOH4s3+6/nArS0bxcB1NQTJYw/ZYdqZmD3cAQW15aWPFHA5km2++REJwILVDux2ak
         UaTQJ6K/waQuwu1DBkuhoqfcHRTAn6LkPSw76qQ3Ie1B2fCCyxlDNf7cKH8FRWTPrPN3
         X7WGlWn0XJrxxFK0kjtlYPJliFH4z/S75jrvv01kQvSn97Y1oZhI3nU0DSh++q3goeQN
         MJYw==
X-Gm-Message-State: AJcUukdI9YZI2bTeT1kYRwfjlW+AaNohvI3uE62ich+2ekzgyESIvRV5
        Ka/Wkp1Q4k5FNvpV936ORlU=
X-Google-Smtp-Source: ALg8bN7wPqGiqTlx9HA99OSA2TmZaYphO3fFxt54PU45PLJ8nzdDy0ObFmLVChaeHb4B1TCuBBwlOw==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr1486270pgv.393.1545380848117;
        Fri, 21 Dec 2018 00:27:28 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 78sm41588597pft.184.2018.12.21.00.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:27:27 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:27:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] touchscreen: elants: fix a missing check of return values
Message-ID: <20181221082725.GB211587@dtor-ws>
References: <20181221065919.60129-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221065919.60129-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Fri, Dec 21, 2018 at 12:59:16AM -0600, Kangjie Lu wrote:
> elants_i2c_send() may fail, let's check its return values. The fix does
> the check and reports an error message upon the failure.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index f2cb23121833..cb3c1470bb68 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -245,8 +245,14 @@ static int elants_i2c_calibrate(struct elants_data *ts)
>  	ts->state = ELAN_WAIT_RECALIBRATION;
>  	reinit_completion(&ts->cmd_done);
>  
> -	elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> -	elants_i2c_send(client, rek, sizeof(rek));
> +	error = elants_i2c_send(client, w_flashkey, sizeof(w_flashkey));
> +	error |= elants_i2c_send(client, rek, sizeof(rek));

I dislike this kind of error handling as this may result in invalid
error code being reported, in case 2 commands produce different results.

> +	if (error) {
> +		dev_err(&client->dev,
> +				"error in sending I2C messages for calibration: %d\n",
> +				error);
> +		return error;

If we just return like you do it here, interrupts will stay disabled and
touchscreen will be completely dead. With the old code we'd report
timeout on calibration, and touchscreen would have chance of working. We
would also be able to retry calibration.

> +	}
>  
>  	enable_irq(client->irq);
>  
> -- 
> 2.17.2 (Apple Git-113)
> 

Thanks.

-- 
Dmitry
