Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E949C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BF120850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LavkQRsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BF120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLDEAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:00:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41154 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDEAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:00:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so6731548pgh.8;
        Mon, 03 Dec 2018 20:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KBADcBl+EG4Bp0sozOZepTjFTECJZfdXbzHRwi27KVw=;
        b=LavkQRsqURxe6drAkw3J7FzLheoFMdxfRDmvEYZujTv/yEY7uDvgIJ7l0CO35q5Mc2
         Rs/V7d8HYnl8L7AOxc8hYY1OVWIjoQSPqguWaxlJ1xqBHh48Ey1lY6BFR6nOPbCS2fiF
         F4xixdYSkVfXKBW3lnA0hy+DtP94uCPuIgQ5//xv1Vod+tR5jus1RsOld4gwF9gACaX+
         Uf2UpDYgnK22C3ZdqbiTp1e9vNIKiFHWxc/F8EvAlej8dJDB9qQe1snAv4PBqbSY7wv4
         To0UMSzmXR7IiHy4y44yG8X88MsOaKc7+N3JJ/sNZX0dAyLUEE57hQvVs9jgrChQsERN
         ZhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KBADcBl+EG4Bp0sozOZepTjFTECJZfdXbzHRwi27KVw=;
        b=fFgqUl2JvmzyfgdhTCKTnY41MHT6llOspKpkEPuqnbkwtIHfcc/gLv909AxpMamQ1g
         Zi7J9RVr7rlUHkltk8uNAkv9jYNJjyNUSgm7cZuRiIpm+yCMkaQCDuhX/mpMU+xqD4tz
         Ro7ouuHxf4hoidv3u9ZnwM5UGcfUfwTAeVN9JFaslkozGFimKVL7Q4EHcIzF+7D3qn3J
         GCmxiuW+DB0UCa+FsMm/YLhcJMXFsR0ILPwZzHHnjuKX8jS0S6B+sIk6GIt/Csxq8qdQ
         eAt5OAQ5T7ceypP6izeSp4N8KmI2gkUL8a9OUb4W1AO7LfxFTbDYOTFgpu13lsC6umvs
         ZMjQ==
X-Gm-Message-State: AA+aEWaucgMZIhjtRxGIMMoCvnAttlM5FHHdRItWPabudB3X0xUnM+94
        89rcPqeLmn94MUrTEOR4sqA=
X-Google-Smtp-Source: AFSGD/UgPBV3Vkd+w4GeA1B+OA2ZxLCn1BXIGRCmJhPqgsyo1/I7Fd6rfb0Y/PAmDQsGt7QwwoClJw==
X-Received: by 2002:a62:870e:: with SMTP id i14mr19013882pfe.41.1543896005203;
        Mon, 03 Dec 2018 20:00:05 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b2sm27487381pgg.87.2018.12.03.20.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 20:00:04 -0800 (PST)
Date:   Mon, 3 Dec 2018 20:00:01 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] Input: omap-keypad: Fix idle configration to not
 block SoC idle states
Message-ID: <20181204040001.GA239923@dtor-ws>
References: <20181203012933.6647-1-tony@atomide.com>
 <20181203012933.6647-2-tony@atomide.com>
 <20181203192351.GB257010@dtor-ws>
 <20181203231251.GB39861@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203231251.GB39861@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Mon, Dec 03, 2018 at 03:12:51PM -0800, Tony Lindgren wrote:
> 
> With PM enabled, I noticed that pressing a key on the droid4 keyboard will
> block deeper idle states for the SoC. Looks like we can fix this by
> managing the idle register to gether with the interrupt similar to what
> we already do for the GPIO controller.

Can you show me where exactly we are doing this? I can't seem to find
the matching code.

Thanks!

> 
> And there's no need to keep enabling and disabling interrupts and
> wake-up events for normal use if we use IRQF_ONESHOT as suggested by
> Dmitry Torokhov <dmitry.torokhov@gmail.com> so let's do that too.
> 
> Cc: Axel Haslam <axelhaslam@ti.com>
> Cc: Illia Smyrnov <illia.smyrnov@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/input/keyboard/omap4-keypad.c | 30 ++++++++++-----------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -53,11 +53,12 @@
>  /* OMAP4 bit definitions */
>  #define OMAP4_DEF_IRQENABLE_EVENTEN	BIT(0)
>  #define OMAP4_DEF_IRQENABLE_LONGKEY	BIT(1)
> -#define OMAP4_DEF_WUP_EVENT_ENA		BIT(0)
> -#define OMAP4_DEF_WUP_LONG_KEY_ENA	BIT(1)
>  #define OMAP4_DEF_CTRL_NOSOFTMODE	BIT(1)
>  #define OMAP4_DEF_CTRL_PTV_SHIFT	2
>  
> +#define OMAP4_KBD_IRQ_MASK		(OMAP4_DEF_IRQENABLE_LONGKEY | \
> +					 OMAP4_DEF_IRQENABLE_EVENTEN)
> +
>  /* OMAP4 values */
>  #define OMAP4_VAL_IRQDISABLE		0x0
>  
> @@ -126,12 +127,8 @@ static irqreturn_t omap4_keypad_irq_handler(int irq, void *dev_id)
>  {
>  	struct omap4_keypad *keypad_data = dev_id;
>  
> -	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS)) {
> -		/* Disable interrupts */
> -		kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> -				 OMAP4_VAL_IRQDISABLE);
> +	if (kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS))
>  		return IRQ_WAKE_THREAD;
> -	}
>  
>  	return IRQ_NONE;
>  }
> @@ -173,11 +170,6 @@ static irqreturn_t omap4_keypad_irq_thread_fn(int irq, void *dev_id)
>  	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>  			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
>  
> -	/* enable interrupts */
> -	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> -		OMAP4_DEF_IRQENABLE_EVENTEN |
> -				OMAP4_DEF_IRQENABLE_LONGKEY);
> -
>  	return IRQ_HANDLED;
>  }
>  
> @@ -197,11 +189,10 @@ static int omap4_keypad_open(struct input_dev *input)
>  	/* clear pending interrupts */
>  	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
>  			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
> -	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
> -			OMAP4_DEF_IRQENABLE_EVENTEN |
> -				OMAP4_DEF_IRQENABLE_LONGKEY);
> -	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE,
> -			OMAP4_DEF_WUP_EVENT_ENA | OMAP4_DEF_WUP_LONG_KEY_ENA);
> +
> +	/* enable interrupts and wake-up events */
> +	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE, OMAP4_KBD_IRQ_MASK);
> +	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, OMAP4_KBD_IRQ_MASK);
>  
>  	enable_irq(keypad_data->irq);
>  
> @@ -214,9 +205,10 @@ static void omap4_keypad_close(struct input_dev *input)
>  
>  	disable_irq(keypad_data->irq);
>  
> -	/* Disable interrupts */
> +	/* Disable interrupts and wake-up events */
>  	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQENABLE,
>  			 OMAP4_VAL_IRQDISABLE);
> +	kbd_writel(keypad_data, OMAP4_KBD_WAKEUPENABLE, 0);
>  
>  	/* clear pending interrupts */
>  	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
> @@ -365,7 +357,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
>  	}
>  
>  	error = request_threaded_irq(keypad_data->irq, omap4_keypad_irq_handler,
> -				     omap4_keypad_irq_thread_fn, 0,
> +				     omap4_keypad_irq_thread_fn, IRQF_ONESHOT,
>  				     "omap4-keypad", keypad_data);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register interrupt\n");
> -- 
> 2.19.2

-- 
Dmitry
