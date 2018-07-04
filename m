Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E70C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5772184F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2Plu00I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5772184F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGDGsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:48:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35473 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeGDGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:48:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id v3-v6so856705wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WX7rVJIPlnbA2uOubdp40jO1Cymotu/X9vpoeO4P6kk=;
        b=O2Plu00IrwkIDKDh1pGzUgXhY0zOfjZWYJMOYmOt8Ufhe+LLm7PIGkB9TKwZGjiARh
         6g9073ZmfD0jG9fo/y65Hm6dajkEt9KqTV8p7eF5QUj1DjIXJ1z2tdIxu/vdMu3sqIrV
         MQZDee/TGyjmbB0K8Mnhk3AENNptAFj2XMXgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WX7rVJIPlnbA2uOubdp40jO1Cymotu/X9vpoeO4P6kk=;
        b=l2mdkQfTNdOno2Tw0EMW9W70fyzKNloGDI+QXyedATdT8QkLLGw0PxNRNT5Lbx/1y8
         Ig4aL/F9M75zr7thmsONlwoVOfwid20pzvv6qCW+4b5BPELrnHiZJdPfFCshd8KJH7Kg
         n3LJ0hp4IjNNTO8I4V0FSr/uq8ZTVmfX3NULKh8dVkl8Ua9u+MMyBH/ZTkbrVNW+qfnF
         znS8//yL58BfUi8E46/kmKxCyP43OvLMYT8F4pHAXmzKR5JsqDqQBpYu9LV62d6Ht51d
         a92PdCEqthlel219GCkSn8Tc7YaA24X+7OFqz1Jsp0fWT4OYNxkRH7qFIBVZpR+SmMCh
         CWlQ==
X-Gm-Message-State: APt69E0GWeAax6Y/SjQUQguevTybJBfWLjyk60SmfBgNEttKCtEjpAks
        SP8Df1yNTtqFRl2j/QGbdNfZHw==
X-Google-Smtp-Source: AAOMgpcVFyWBTrAsx3DfCSTcZiawTkQmOiNMqL3y6EP+ivf0mPtLMtv4vpy3ySpWmVgisYezMVjIQw==
X-Received: by 2002:a1c:2c03:: with SMTP id s3-v6mr713675wms.109.1530686893521;
        Tue, 03 Jul 2018 23:48:13 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id t53-v6sm1272382wrc.13.2018.07.03.23.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:48:12 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:48:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 1/2] Revert "mfd: cros_ec: Remove unused __remove
 function"
Message-ID: <20180704064811.GD20176@dell>
References: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Dmitry Torokhov wrote:

> This reverts commit 556c242045f0c1613aac2e64dc5b2ff0e4bc89e1.
> 
> The patch that this change is purported to fix is broken and should be
> reverted; thus we reverting this one as well.

You need to provide more information.

How does the original patch break the build/code execution?
What is this patch doing to rectify the issue?
Any other information you think is relevant.

> ---
> 
> Lee,
> 
> I see the broken code is already in Linus' tree, so please merge send
> it on at your earliest convenience.
> 
> Thanks,
> Dmitry
> 
> 
>  drivers/mfd/cros_ec_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 306e1fd109bd..4b1dbe81fcb6 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -262,6 +262,8 @@ static const struct file_operations fops = {
>  #endif
>  };
>  
> +static void __remove(struct device *dev) { }
> +
>  static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  {
>  	/*

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
