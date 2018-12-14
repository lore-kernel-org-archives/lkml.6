Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E35208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RP5kYVEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E35208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeLNM0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55879 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbeLNM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:26:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so5468092wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8oiBcyrlQ7JAXHe6dv46StEKhNjUj3ou2vDb0X7ketk=;
        b=RP5kYVEMR87Hnewx+d/hmg0Jxqoyao1GQ7oV5t3Jobn8dCnWecVh6V0ipQrfYOkJdK
         VGb2h4mubsF6N+FjrPQLovNhb1MdJSk3uU2nzPOHvBzVCLS5ln0V+aIUXcC2CUGNwLlQ
         E0Ctaq7YmZRuKuJDqunp9jbrluGI9YK8IzyoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8oiBcyrlQ7JAXHe6dv46StEKhNjUj3ou2vDb0X7ketk=;
        b=RikuSnxEM3e/EcCJRD/sfejTH3NMyGe+GS7+bdIvdq3dqZRaMBh3XsS0O/gPL6YX4o
         DM7NCrZMslZL/0KtFFOkmmQIpbsuwc9O0m3tiYaD9RVPZprcAcdICjkz8pxwLVAyHlvy
         +SkzlK1+AiO3tVzBgoaaGUSlc9axd4lUXayJDVLWw4YjEWpKelpWcT5a94M2FJ+ssPFe
         3O2GSMBTJ5Ivs8qia+l5U0Z4qaThU/t+wBNi8OpxNAn56WeKooOVCTyRzq/BPa1HHWM9
         myVC8FeQdJ2ZHdqO92j/P4n+anK3CkbFFYHm5BAisszDbRA19OvxNTOdaqmk4b3iJqKK
         Hdmg==
X-Gm-Message-State: AA+aEWaPkLrGIdz6xlkkouwDgAgTWMZ3XGucHlmOFmGgZOL189XRBs9K
        CFdeHUPeMNupbQx+o4ZoYNdtGg==
X-Google-Smtp-Source: AFSGD/VLbtlqdVj419Qe54SVc3zvwYgx0CfiE6/rtkp9i0erhfmcSh6dYurpYMB5rF1Ufq8xup7IQA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr2964335wmj.127.1544790361784;
        Fri, 14 Dec 2018 04:26:01 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id h10sm5584648wmf.44.2018.12.14.04.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:26:01 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:25:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     "J, KEERTHY" <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Message-ID: <20181214122559.GV4497@dell>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:

> Free allocated IRQ if reading the device ID fails.

The patch is fine.  However, in future please submit patches using the
format set (by precedent) by the subsystem.  I will fix the subject
for you this time.

To check the format, you can do:

  `git log --oneline -- <subsystem>`


> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  drivers/mfd/tps65218.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 910f569..19270bc 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -244,7 +244,7 @@ static int tps65218_probe(struct i2c_client *client,
>  	ret = regmap_read(tps->regmap, TPS65218_REG_CHIPID, &chipid);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
> -		return ret;
> +		goto err_irq;
>  	}
>  
>  	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
