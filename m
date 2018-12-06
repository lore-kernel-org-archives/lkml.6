Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCD6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E7B20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFRZ9mb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E7B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeLFOCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:02:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeLFOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:02:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so606654wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kB34XZmDHLwF0IkhTK5ZXKAQOuz+S8TT+1tfCKZPkSc=;
        b=IFRZ9mb0Wxl8Z6ggml7mwYPy6K4sQoFDoJ0/OdE7UykjbdD8OTArJrvIhQKl+JrBdm
         LatQcEdeJAZW/9O11w054sLYlBoWuiQxCYFpCl4OoeMMGDCyA1at1WJ5Dr0fGXZDaJG1
         rtFOCM/Y1B09un9jQE6oImJ0S16hEwroz9RtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kB34XZmDHLwF0IkhTK5ZXKAQOuz+S8TT+1tfCKZPkSc=;
        b=sUKAC+8t1vU+Cuz4Lb1M2zvxA15laBDmNm4EiHg9LcKxtCuZPlSHH4VW8zTBENy4zy
         E8rAVef76tfT5Wcoa7CNsZjry5XwXo6ZZBUkryhbG0l462EDvDW0+/PL/3YUFxqJLGWk
         UUVqLoQtZCQoARmX5ed98MpxYOBVmE4xcDgaKarPyRMHp6Bgaj0ZPy73tlqve3ArNpu0
         +jpcn8fZCkqFI3kqncvFUVupuMFRBqXEZApxxw36dVBUHyn6A9RmidAf/AkV+oztRo7g
         CwsZRbFmwTlkslw7ICuNCOs9dcoitP6wiSQvFM86ChTEn2dLDl6utJYtyeL31pV8APAN
         PObg==
X-Gm-Message-State: AA+aEWZDjtBK7m+b3VNRUnkDbAEkvs9MOqA44loHRa7ccX1NsrWZ/ye5
        5bMUlU+9/X/JU83W/vdEaL5mag==
X-Google-Smtp-Source: AFSGD/UuECKYw45OZoeGvaPb9lG3cYE2ulfKpHQu0XiLlkxsMq0XmrviFGKa6fMWdY+6CFmnnjFBTQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr24687403wrq.69.1544104946035;
        Thu, 06 Dec 2018 06:02:26 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k19sm805331wre.5.2018.12.06.06.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 06:02:23 -0800 (PST)
Date:   Thu, 6 Dec 2018 14:02:21 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video/backlight: Use of_node_name_eq for node name
 comparisons
Message-ID: <20181206140221.rq4zp74olghzipxu@holly.lan>
References: <20181205195050.4759-28-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-28-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 01:50:44PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which this is.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

[this is FAO Lee J. rather than recommending you take it via you tree]

> ---
>  drivers/video/backlight/88pm860x_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
> index 6d8dc2c77520..51e0c4be08df 100644
> --- a/drivers/video/backlight/88pm860x_bl.c
> +++ b/drivers/video/backlight/88pm860x_bl.c
> @@ -174,7 +174,7 @@ static int pm860x_backlight_dt_init(struct platform_device *pdev,
>  		return -ENODEV;
>  	}
>  	for_each_child_of_node(nproot, np) {
> -		if (!of_node_cmp(np->name, name)) {
> +		if (of_node_name_eq(np, name)) {
>  			of_property_read_u32(np, "marvell,88pm860x-iset",
>  					     &iset);
>  			data->iset = PM8606_WLED_CURRENT(iset);
> -- 
> 2.19.1
> 
