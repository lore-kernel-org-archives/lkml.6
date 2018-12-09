Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0CF2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck491BL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0CF2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeLIFkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:40:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33678 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeLIFkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 00:40:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so3495161pgu.0;
        Sat, 08 Dec 2018 21:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gA9Ie+JZJng603NTmDIlGfbEqGo8/+N+WSNM7QiY2Cw=;
        b=ck491BL0mdVcVmvfPgxMP/snKY9P2Aktyjzq4Nyv79lzB/m6OtrwGmyDCwdgeX/1rr
         mApke5zFcJJA6Rr5YK4G1aKK6Af/TajESnUAJBzUfw6MAuOmiK8AZHeMzhcy4n2MMC06
         IiKjbZJDk9tLkapnpX+4mgYoQ8ct3/5AguHExnV9Fo8XEor7zBKU5yhdi5J0GveOo7VA
         VGmso+Yg4B6MrOJzRZ/hkEB0kvxYJ4PLOVkByNHMiHcih7StF4tY7kQam4UNlIqO3tya
         n0+ocoH8Vez2n7b5PegPBx8jWDZkK6LZH2XH8afnMXo8PKa44DZsI94G0Q1nyFquXGoa
         L/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gA9Ie+JZJng603NTmDIlGfbEqGo8/+N+WSNM7QiY2Cw=;
        b=VhyHQ/JBD1NdhmEmchWLW/b8KZyhf+v9QjXjIkSBNi8tQWhTBiSjrFK/oggq7GLfmu
         43LKXD686kB4kjxvv08hwuKsMf6nHuiYRlX3t+SujFeIiZngvLY9yXzUZClXq5Dc7Ai5
         m+WA31vf3Iz50TOWjy/BEy4ci9LHvFqh7mOcJciT4PRYrpiq41zUWWhvH7AGoxz4OCrD
         nnOW172e9uNdHKNYXjGTJo2fUroaHwCf3wSMKLVI2ftMn0tvUkl5rJPezkz4PHU4N6zP
         kOuBeNE9mxUqfrywemKr/R5CpwotkR6mFVrkd7ejwlqvZzCci3JyqGvt8LA/X4C7A6Aw
         MCRw==
X-Gm-Message-State: AA+aEWalO7XRLnNkbv0Qh2FMOGSl2ixeRSk7GpR+M2WviLVreYeGUffS
        tpdE9egENpcdsVT1HNG7VHk=
X-Google-Smtp-Source: AFSGD/XgTj+HWCt06tsrcl08YM2nCzfzSitRlAyM/PXmwS5IPEIUZ1Z/rh+K9S8t0H3t2jgNagwo5A==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr7905876pfe.185.1544334017084;
        Sat, 08 Dec 2018 21:40:17 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y89sm11221242pfa.136.2018.12.08.21.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 21:40:16 -0800 (PST)
Date:   Sat, 8 Dec 2018 21:40:14 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: i8042 fix refcount leak
Message-ID: <20181209054014.GA237502@dtor-ws>
References: <20181209051900.19035-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209051900.19035-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 12:19:00AM -0500, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/input/serio/i8042-sparcio.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index 796289846204..cc6777b4c4ea 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -111,13 +111,17 @@ static int __init i8042_platform_init(void)
>  	struct device_node *root = of_find_node_by_path("/");
>  
>  	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> +		of_node_put(root);
>  		/* Hardcoded values for MrCoffee.  */
>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
>  		kbd_iobase = ioremap(0x71300060, 8);
>  		if (!kbd_iobase)
>  			return -ENODEV;
>  	} else {
> -		int err = platform_driver_register(&sparc_i8042_driver);
> +		int err;
> +
> +		of_node_put(root);
> +		err = platform_driver_register(&sparc_i8042_driver);
>  		if (err)
>  			return err;

This is not really what I asked for, as in this version you left out
leaky reference in i8042_platform_exit(). Please make the "detect Mr
Coffee" function and use it in both i8042_platform_init() and
i8042_platform_exit().

Thanks.

-- 
Dmitry
