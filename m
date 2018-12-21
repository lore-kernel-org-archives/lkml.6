Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3150C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574821906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYFUuUIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeLUImR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:42:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbeLUImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:42:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2204583plo.3;
        Fri, 21 Dec 2018 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQA5CjVTo6GyyaRwAZb65VSbnCQPPLvjjE1b30vHv2w=;
        b=mYFUuUIMHWNVwwTzrociju96qFhn4C3PZGH/KqhIk2P5TcMXnE0ldZbTvZVs/YwSLp
         0EjX17/kKygnofgCtHGsn721LGlF8X0IPv+ehtNpkljNXc3m7DcZHqEAlDFhHa4UM5n9
         Red4PI+SP3ALnH3JRSu4/lDLjgHyGGmGnx/sdUATltm+6Kx12M+6yW0LHMuEC7if7kic
         y4Lp1Ex/4WX83LMCloISzm1kjJO5QWXJZ4MsCBRhUZAE7KynHmIikimLnlyoGxDmnjMk
         CW0NfPfkRjgld2baSWMLFU9Uou40xbbve8ZzvJ5j/PBEbI395+MaNp7Z9ym/2iuuh0Zt
         qFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQA5CjVTo6GyyaRwAZb65VSbnCQPPLvjjE1b30vHv2w=;
        b=gF9ePHYMzfVdY+Se30+vYr/cant7MBOkc2BGnmrF6SJhz0I7r0BVB4Y8FANYpQeNjT
         Kxk9c+VmRTCyw0Hn+KnXNdF9FD6/20MGaMpSeMNnV3MnoZbRamY6/3e6vyRorgbaLD+d
         6qDqMFqnd/T4Kdex2AihbZs7/U3rfOaGVNgFO+IGEvFpJf1Z3VmfxNKhoVkfSVg6ATWf
         lBxPvkNnHLuLiMnnTJwojkjYAF775h4lLz5kyTM6JvAgiBLugK5TiGcnCAk2RhbYcpzo
         WtKZAVCpCwSJdcPKl2nVDtoKcJXsecv92fnSIkuNA9wddlGGpF6CKST/6XfqDR9EmuNj
         xgOQ==
X-Gm-Message-State: AJcUukdP/8pYD5U6FL4BlC/PK5X9W03fnUSYkX3fI8SvsfnsUQG59Rt1
        t+DpyTOc9O7g1uWS9YkxySo=
X-Google-Smtp-Source: ALg8bN78C9u/u+HZq1jOl6aG7GB4FNnb2SJo+kYJF6xGWzktCsqXXWgvTyXJho5ZHJnLV1ImDjsfGQ==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr1608032pld.53.1545381734908;
        Fri, 21 Dec 2018 00:42:14 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b26sm50625041pfe.91.2018.12.21.00.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:42:14 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:42:12 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
Message-ID: <20181221084212.GG211587@dtor-ws>
References: <20181215090846.28009-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215090846.28009-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:08:46AM -0500, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller. Add
> i8042_is_mr_coffee() helper to avoid refconut leak.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> changes in v5:
> -fix typo

Has this at least been actually compiled by you?

> 
> changes in v4:
> -fix typo
> 
> changes in v3:
> -add i8042_is_mr_coffee
> ---
>  drivers/input/serio/i8042-sparcio.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index 796289846204..9e9e512bc432 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -106,11 +106,23 @@ static struct platform_driver sparc_i8042_driver = {
>  	.remove		= sparc_i8042_remove,
>  };
>  
> +static inline bool i8042_is_mr_coffee(void)
> +{
> +	struct device_node *root;
> +	bool is_mr_coffee;
> +
> +	root = of_find_node_by_path("/");
> +	is_mr_coffee = !strcmp(root->name, "SUNW,JavaStation-1");
> +	of_node_put(root);
> +
> +	return is_mr_coffee;
> +}
> +
>  static int __init i8042_platform_init(void)
>  {
> -	struct device_node *root = of_find_node_by_path("/");
> +	bool match = i8042_is_mr_coffee();
>  
> -	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> +	if (match) {
>  		/* Hardcoded values for MrCoffee.  */
>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
>  		kbd_iobase = ioremap(0x71300060, 8);
> @@ -138,9 +150,9 @@ static int __init i8042_platform_init(void)
>  
>  static inline void i8042_platform_exit(void)
>  {
> -	struct device_node *root = of_find_node_by_path("/");
> +	bool match = i8042_is_mr_coffee();
>  
> -	if (strcmp(root->name, "SUNW,JavaStation-1"))
> +	if (!match)
>  		platform_driver_unregister(&sparc_i8042_driver);
>  }
>  
> -- 
> 2.17.0
> 

-- 
Dmitry
