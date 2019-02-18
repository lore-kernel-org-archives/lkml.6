Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D68E218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdNepYOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfBRHX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:23:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:23:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so5741075pgl.5;
        Sun, 17 Feb 2019 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTZkn+V6r3SZF8iWxRRdmUw/z6+ykv2abHF6AhksFOY=;
        b=qdNepYOKfpVxbGSY6dh4uNwpIrtgL/4VqplafL6VO6VDqXbBAVUY0pHyIcExQaMa0Q
         CDEZmRHbeCOvnUDk6/NkFZwwiUlJUfkmufLxci9zMtlA/FmfF3VCjg7OnyZfaqhjjTUR
         WvMvQbkrfGldzsuOA04mI1nLOmQjatyy3duhPPya+XusN9WkFcqI9Ncx+s9LchOHSBLo
         Cy9uZWxSdr9LE1L56rZHazJ0cg99iwOfI3cJ/WhS8qcbv9KvYxUlb42AwOAQDqR8iuq5
         76eX7ilx07TK/X99c16x8pBPfWiK/Uby0/01yX3JMidEfanhG9RkymF3VZ3fcLBDx1hz
         x5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTZkn+V6r3SZF8iWxRRdmUw/z6+ykv2abHF6AhksFOY=;
        b=S0DSZbwRW0kF7WyX1wAvg9iknbLvWwTJLffxFja8M8LX6WQILcGaq3pX7zZl33w+X5
         jOucRDsbg3bmbUrg9FJAD4rxdEHos+mavxrCZ22y2RmBmoZpwCo6hXe1ntumurXuqFmZ
         HsWu3kDmN6nb41AtqAbMShDhcIjEgqD20F8mNOIN7x+QVRa0GlEPMZDtFSmCyRgP7TJY
         SEw51gjERDqWVj680Nz0MmQzcyH166xlmWfNyrDsVbl/KQZTNnlJxhtoQpTfEgN6sbHd
         ivQGyKkdOWn19ZsfKNB1kyhqbBl2hBbkNmVz0Lx+FMybMuxeJWbdeMUWcUTM/L4y+EJU
         xxUA==
X-Gm-Message-State: AHQUAuZe0+QBJeUO1bIVbifePIZ9Dpo2tYQeEzJ2UANZqMaYfvi+sHiz
        IlhtPzsRqOq2fVHg4HQs8tA=
X-Google-Smtp-Source: AHgI3Iab6GMU1unyw+qDbbZ5QUGF/NJ5odW3HLjjPnLR16Ax1R7M6vmKluU0fWoyB3jhD9DtsSgQcw==
X-Received: by 2002:a62:3047:: with SMTP id w68mr9493339pfw.17.1550474607433;
        Sun, 17 Feb 2019 23:23:27 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i71sm37223030pfi.170.2019.02.17.23.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 23:23:26 -0800 (PST)
Date:   Sun, 17 Feb 2019 23:23:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - Rework DT node name comparisons
Message-ID: <20190218072325.GF242714@dtor-ws>
References: <20190213161631.17028-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213161631.17028-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:16:31AM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. For the root node on SUN DT, we need to retrieve the 'name'
> property as it is the rare case where the 'name' property and node name
> differ. With both changes, it removes direct access to the node name
> pointer.
> 
> While at it, comvert the open coded loop to use
> for_each_child_of_node().
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-sparcio.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> index 796289846204..fce76812843b 100644
> --- a/drivers/input/serio/i8042-sparcio.h
> +++ b/drivers/input/serio/i8042-sparcio.h
> @@ -53,12 +53,11 @@ static struct resource *kbd_res;
>  
>  static int sparc_i8042_probe(struct platform_device *op)
>  {
> -	struct device_node *dp = op->dev.of_node;
> +	struct device_node *dp;
>  
> -	dp = dp->child;
> -	while (dp) {
> -		if (!strcmp(dp->name, OBP_PS2KBD_NAME1) ||
> -		    !strcmp(dp->name, OBP_PS2KBD_NAME2)) {
> +	for_each_child_of_node(op->dev.of_node, dp) {
> +		if (of_node_name_eq(dp, OBP_PS2KBD_NAME1) ||
> +		    of_node_name_eq(dp, OBP_PS2KBD_NAME2)) {
>  			struct platform_device *kbd = of_find_device_by_node(dp);
>  			unsigned int irq = kbd->archdata.irqs[0];
>  			if (irq == 0xffffffff)
> @@ -67,16 +66,14 @@ static int sparc_i8042_probe(struct platform_device *op)
>  			kbd_iobase = of_ioremap(&kbd->resource[0],
>  						0, 8, "kbd");
>  			kbd_res = &kbd->resource[0];
> -		} else if (!strcmp(dp->name, OBP_PS2MS_NAME1) ||
> -			   !strcmp(dp->name, OBP_PS2MS_NAME2)) {
> +		} else if (of_node_name_eq(dp, OBP_PS2MS_NAME1) ||
> +			   of_node_name_eq(dp, OBP_PS2MS_NAME2)) {
>  			struct platform_device *ms = of_find_device_by_node(dp);
>  			unsigned int irq = ms->archdata.irqs[0];
>  			if (irq == 0xffffffff)
>  				irq = op->archdata.irqs[0];
>  			i8042_aux_irq = irq;
>  		}
> -
> -		dp = dp->sibling;
>  	}
>  
>  	return 0;
> @@ -109,8 +106,9 @@ static struct platform_driver sparc_i8042_driver = {
>  static int __init i8042_platform_init(void)
>  {
>  	struct device_node *root = of_find_node_by_path("/");
> +	const char *name = of_get_property(root, "name", NULL);
>  
> -	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> +	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
>  		/* Hardcoded values for MrCoffee.  */
>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
>  		kbd_iobase = ioremap(0x71300060, 8);
> @@ -139,8 +137,9 @@ static int __init i8042_platform_init(void)
>  static inline void i8042_platform_exit(void)
>  {
>  	struct device_node *root = of_find_node_by_path("/");
> +	const char *name = of_get_property(root, "name", NULL);
>  
> -	if (strcmp(root->name, "SUNW,JavaStation-1"))
> +	if (!name || strcmp(name, "SUNW,JavaStation-1"))
>  		platform_driver_unregister(&sparc_i8042_driver);
>  }
>  
> -- 
> 2.19.1
> 

-- 
Dmitry
