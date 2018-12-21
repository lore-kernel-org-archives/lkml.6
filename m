Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA82D218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgwXJ1As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeLUIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:46:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37480 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732228AbeLUIqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:46:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2287072pfb.4;
        Fri, 21 Dec 2018 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGxEk3/D6g1MqHex7GlE9IhaxrZrX946np858x37zqI=;
        b=mgwXJ1AsKsltgkW36r5r2eRHHndvtEmFSm3eqkfelo+HKUaIA/40YRb4bi8IyyiD15
         kP81US9EWW3GvWtWNmQQftDRsOwMPwwznDoWcgH/afWMzyA5CrQs0zZi+fmD2IiaeNHR
         jLCPBavNISuCZbZkAdkGOvdPMv5b9kpiadDhsfxbm3jwD8tKs+62QTvrQ/xXZw/rigjc
         Q9CmbaYWqCqIL+V108BU5h6l8BNCO4Vwu7darDdLr/0TO4/ETZUzsYYwAlWnhF3LPv8j
         YiMElMaS18/pZIw6Q+ujaj1cVYt/M2YEJokv0vmF5u8n455NWl2ANtERtWchsc3AnntK
         X52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGxEk3/D6g1MqHex7GlE9IhaxrZrX946np858x37zqI=;
        b=RupsIsKpTTMTTuDHf5AhJ0Qftkj/w665rYTQ+A0i//hjtUIHHYXLmbzYJ2IMy3JXUa
         9sa/+GuxbirWjvT4+obqFWyf+DWynlqQtb7dX1HXWuvrNpIfIrE/5as/kZJsq3e7Q7AW
         MwnlVxQJJN7GZHK1Fx6uPE9K3R0aft/lrA9a+0YbH6uelpU19UwJPZULsAC1pP91zfqh
         kxxr9qbW8bmkepch9LvhCR1gZKY+8aJ/+wDxG5qZKCLI9avd1y49sbznSeXGC/nP1W5H
         441Ig51mWMsiU7V2MO25g9In93M8u+h2V7dEHa6pZR/UMbdIfRkoSdoHb3wqXBQSNaWN
         E8bA==
X-Gm-Message-State: AJcUukfftIp0dQLGO5Pe2YjjRFYtTQE/7F724fRNjthQ83DNx6n94zCO
        Zd+RlBthx82NVGR9abRMaW4hQwB1
X-Google-Smtp-Source: ALg8bN6QI0/l/vBK9caNVFvyWfATU4idnxpc45Vay4Fy1qGehGYZnyXrdFXA3JTJogAm7iFQEHMS3w==
X-Received: by 2002:a63:151f:: with SMTP id v31mr1537852pgl.34.1545382003702;
        Fri, 21 Dec 2018 00:46:43 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x186sm35197522pfb.59.2018.12.21.00.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:46:42 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:46:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     matthias.bgg@gmail.com, lee.jones@linaro.org,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 -next] input: keyboard: remove duplicated include from
 mtk-pmic-keys.c
Message-ID: <20181221084640.GI211587@dtor-ws>
References: <20181211093200.18140-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211093200.18140-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:32:00PM +0800, YueHaibing wrote:
> alphabetise the header files and remove duplicated include
> file linux/kernel.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
> v2: alphabetise the header files
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 02c67a1..8e6ebab 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -14,18 +14,17 @@
>   *
>   */
>  
> -#include <linux/module.h>
> -#include <linux/kernel.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> -#include <linux/platform_device.h>
>  #include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/regmap.h>
>  #include <linux/mfd/mt6323/registers.h>
> -#include <linux/mfd/mt6397/registers.h>
>  #include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/registers.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  
>  #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
>  #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
