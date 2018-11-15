Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B781C21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1dMjH0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B781C21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeKOSiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:38:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbeKOSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:38:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id f19-v6so15308546wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=51PjUhnX193KfA8tRiO5znGLBPliAfWXoIy3yr6KJVw=;
        b=X1dMjH0q5bkQb3iZN6N4TlVhnuORm2mvD+xh9IzToPjZVEBj7YeqWrrVrYOkCkiMH2
         Z/TljnI6XnvnsnXdSvMXqRymYQnRZuxLd+XRiAAhYBDmZVXcTFdC4UcrGxevzJJ2B3AN
         JZLDCbqxN2ixKMYHDmt/12hpf5pY4u5MyqjDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=51PjUhnX193KfA8tRiO5znGLBPliAfWXoIy3yr6KJVw=;
        b=EPsXEGkVNv0kSjLpShrEhmUP2kvHpzsxVYHOou3E/cko/P6x4feyD/c9ZcWz+TF9Rz
         nU42IuAmv+5WMXXgheTcFhafcIQf4uXuYVfptDst1Bsw0OB63PYXIVmv6QWy8BXCg0oE
         B8es/KmJFxvgrhK2VnWgahFgE5XbeVbzf6HDjWL+z5ItExaknKU7f1Bfzd43oe6buV3+
         Vx6PSiZJYb5sbTHlCIFa7xTWK2VZ8xiyAUqc50JZ0hUNG8vbNG9uRThmKsS/9onQnOyo
         yoHLdatqLlLqf2tY6Z/DcvlOLa+/wRRP1OoG/0YjxvLUUz7oIYjO20N2q5eA+ObhbSs/
         KUBg==
X-Gm-Message-State: AGRZ1gLGG+mzmxzopizNk4bvbT01v2b9yQKXI7uZ2l4LpJVXSvhpMl+1
        lZeZJSYMSA1+PvuxcfslebGzySKME7A=
X-Google-Smtp-Source: AJdET5eGQY+g7x0sYgBkb77DK/ONWBrodYRv4Ovu6GQ6vWnxVRLKGWln4WGfZVzEVFhHa+jva9/7qg==
X-Received: by 2002:a1c:e402:: with SMTP id b2-v6mr4545273wmh.12.1542270683809;
        Thu, 15 Nov 2018 00:31:23 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id x8-v6sm60443234wrd.54.2018.11.15.00.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:31:23 -0800 (PST)
Date:   Thu, 15 Nov 2018 08:31:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     bjorn.andersson@linaro.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: qcom_rpm: write fw_version to CTRL_REG
Message-ID: <20181115083121.GI3513@dell>
References: <20181114224201.16225-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114224201.16225-1-jonathan@marek.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Jonathan Marek wrote:

> downstream driver does this, and it is required on msm8060 (hp touchpad)

You can leave the bit about the downstream driver.

Please expand your commit message.  Why is it required?  What happens
if you don't have it?  What problem does it solve?  Exactly what is
happening to the H/W?

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/mfd/qcom_rpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> index 52fafea06067..8d420c37b2a6 100644
> --- a/drivers/mfd/qcom_rpm.c
> +++ b/drivers/mfd/qcom_rpm.c
> @@ -638,6 +638,10 @@ static int qcom_rpm_probe(struct platform_device *pdev)
>  		return -EFAULT;
>  	}
>  
> +	writel(fw_version[0], RPM_CTRL_REG(rpm, 0));
> +	writel(fw_version[1], RPM_CTRL_REG(rpm, 1));
> +	writel(fw_version[2], RPM_CTRL_REG(rpm, 2));
> +
>  	dev_info(&pdev->dev, "RPM firmware %u.%u.%u\n", fw_version[0],
>  							fw_version[1],
>  							fw_version[2]);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
