Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F8C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3330A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpQq0SwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfA2AZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:25:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40256 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2AZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:25:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so7951412pgp.7;
        Mon, 28 Jan 2019 16:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uKESH3dP8KlH2H1aC9ySmBdA/fbboEB/JQypTItUj7I=;
        b=gpQq0SwPdDkNS9ZYm6KJF0bJ55NyrCChKzrCu46vKxqh0tIeyvh1unq0/4JCI+o1x3
         1hrLVRRSqhUi1OmCgRWfsNAjr48UvmNB1JwinR1RiVZfeSFAE3YvtWRaG+zTuV1lE3U6
         wrfNszfiWmQG1r1GCdHAwNrbs/TOla4gmbNRV5Ihgunj7cxKm+ZVmBw3Y8vtm/WwXGCL
         Cqr2LB6mIq005qo1RE4qm2KGOfA3kkX0OcaQNGljwDGMkUD7QBBjBkpU4Kkyyr966tX1
         gTPbE6lsc1KTP1oHHNzNOOP3p/kAlbrsPUpav/9XByNj9+pZx+IjddCbdlb85PoSoo3n
         XmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uKESH3dP8KlH2H1aC9ySmBdA/fbboEB/JQypTItUj7I=;
        b=W822ADF5n29Hc5/yo6GUrtLiu+sv0/WPvrBLXBCUTiuhkmK5WcuRD9sZERon85lCa+
         XaxribBVYA86n7C4EFxwnjDpI1oU5BgVmR4ZX87VXH/9SdWnN2ijrvzqcWxjakLGJnVx
         suC/2G8ITSWnM6/eM62hCzRvm6Lom+YZlg5f7OHBz74vUEVsPylwKJ39EFCUPX76KfA/
         reGgyTHXqdO38HtZE4lyYfIvBkl0vxuNInlwoEEX1sDrfs30SZf6bPjN69SHJfmgcjPl
         UZUHuFuyAqOYjrmW8kNblaDxEtppFBuzb9IC6Y/XuggtXk7CF2R4NH30m4lV7OOWgX7n
         DZFA==
X-Gm-Message-State: AJcUukclMfchK/u9E+sa72RLd840zX/TWZzKQ3tHs39TKzY1w1XBFYfG
        PjFCUq86d20yGBXIrOx74jo=
X-Google-Smtp-Source: ALg8bN6AoR5EUkhDerMKX1YXbzqmE34VQORbHd9A8F71uuc9YoJnqTqgbIrtTaQni6qDO/ywQ8s1uw==
X-Received: by 2002:a62:1484:: with SMTP id 126mr23660899pfu.257.1548721528966;
        Mon, 28 Jan 2019 16:25:28 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m9sm75473244pgd.32.2019.01.28.16.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:25:28 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:25:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 7/8] Input: sx8654 - use common of_touchscreen
 functions
Message-ID: <20190129002526.GI34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083946.13823-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218083946.13823-1-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:39:46AM +0100, Richard Leitner wrote:
> of_touchscreen.c provides a common interface for a axis invertion and
> swapping of touchscreens. Therefore use it in the sx8654 driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sx8654.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 4939863efbef..b7b263ed52af 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -35,6 +35,7 @@
>  #include <linux/irq.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
> +#include <linux/input/touchscreen.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -101,6 +102,7 @@ struct sx8654 {
>  
>  	spinlock_t		lock; /* for input reporting from irq/timer */
>  	struct timer_list	timer;
> +	struct touchscreen_properties props;
>  
>  	const struct sx865x_data *data;
>  };
> @@ -178,8 +180,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
>  				 chdata);
>  	}
>  
> -	input_report_abs(ts->input, ABS_X, x);
> -	input_report_abs(ts->input, ABS_Y, y);
> +	touchscreen_report_pos(ts->input, &ts->props, x, y, false);
>  	input_report_key(ts->input, BTN_TOUCH, 1);
>  	input_sync(ts->input);
>  	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
> @@ -226,8 +227,8 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  		x = ((data[0] & 0xf) << 8) | (data[1]);
>  		y = ((data[2] & 0xf) << 8) | (data[3]);
>  
> -		input_report_abs(sx8654->input, ABS_X, x);
> -		input_report_abs(sx8654->input, ABS_Y, y);
> +		touchscreen_report_pos(sx8654->input, &sx8654->props, x, y,
> +				       false);
>  		input_report_key(sx8654->input, BTN_TOUCH, 1);
>  		input_sync(sx8654->input);
>  
> @@ -377,6 +378,8 @@ static int sx8654_probe(struct i2c_client *client,
>  	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
>  	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
>  
> +	touchscreen_parse_properties(input, false, &sx8654->props);
> +
>  	sx8654->client = client;
>  	sx8654->input = input;
>  
> -- 
> 2.11.0
> 

-- 
Dmitry
