Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EF120878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgW8KY1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EF120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLDJXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:23:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51752 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:22:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so8773314wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PWlj7O4M1nWNKX7mh7+IPtcOY+7OHOGx5Tq8ZH8HMCU=;
        b=hgW8KY1xuvl3mrevsiZAlDhuEL7z3qsI3std4tA0UgtqcsDrfj1GGiIRXnLLUj/RyZ
         ay+yKS+FqeQ5oZTweA/xbFU9F8I3ne3QKD/R5uW4oV/Jph3Xho5QzCyAlq/lwH/iI3Ow
         4LPruFk66Yoqir/W6EpgcFzUVM8DqqjlBXY+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PWlj7O4M1nWNKX7mh7+IPtcOY+7OHOGx5Tq8ZH8HMCU=;
        b=naN3l+vJgDpQ6oeaXBA6xv52ZWXEUX4tzc1QdSbr9pVTW8M1PsoHrFtTbKjRAHTwij
         dqliG6WdmmvyFe+7yveytXRtTAZJXoqEH48oLAPgqtAD9WHgkEnORhAg9bFqLQC7a0ZO
         gBnElBOfZGuBMmI5A+fCbDZNpuYiXpdA337XMDuKDIwiDd1vngvdiShwaAnT7iJPtNkW
         Yv1Hfp90MBXofOGPXZO0URAPbctLYzNAYMolxQtXBTxaIJnASWeMH9KPmVEA7wLhBp2H
         eYigglMYjD5d0JpZhDvN9YZVbqHxHt2bPTgMfEtl/84vyOdNiuBljUGE3hWUG0vPmtIJ
         +8zg==
X-Gm-Message-State: AA+aEWYTbwa4KOIy5KrQSpXhLXwjPYmcJTPEohA1xZkVRzaUon9lLeiz
        ZJswnhEbbblaU4312snViIRrXg==
X-Google-Smtp-Source: AFSGD/UAh3fFy6lk+u6XStBmaVp0Y3yZVs11rM3L1jxHv9EKIuXLN9DN5NllkG/nNwq7XqRoFRT8yg==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr10976192wmg.100.1543915376511;
        Tue, 04 Dec 2018 01:22:56 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id y8sm8628347wmg.13.2018.12.04.01.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:22:55 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:22:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 1/8] mfd / platform: cros_ec: use devm_mfd_add_devices.
Message-ID: <20181204092254.GS26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-2-enric.balletbo@collabora.com>
 <20181203103228.GC26661@dell>
 <652e1f21-c443-3a25-a57f-71e0f835d47d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <652e1f21-c443-3a25-a57f-71e0f835d47d@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> On 3/12/18 11:32, Lee Jones wrote:
> > On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> > 
> >> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
> >> reduces the need of remove callback from platform/chrome for removing the
> >> MFD child devices.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Removed cros_ec_remove from include file.
> >>
> >> Changes in v2:
> >> - Use devm only for the cros-ec core.
> >>
> >>  drivers/mfd/cros_ec.c                 | 14 +++-----------
> >>  drivers/mfd/cros_ec_dev.c             |  1 +
> >>  drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
> >>  drivers/platform/chrome/cros_ec_lpc.c |  4 ----
> >>  drivers/platform/chrome/cros_ec_spi.c | 11 -----------
> >>  include/linux/mfd/cros_ec.h           | 10 ----------
> >>  6 files changed, 4 insertions(+), 46 deletions(-)
> > 
> > Nice patch.
> > 
> > Just one question:
> > 
> > [...]
> > 
> >> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> >> index 8f9d6964173e..ff788d3e6d5f 100644
> >> --- a/drivers/mfd/cros_ec_dev.c
> >> +++ b/drivers/mfd/cros_ec_dev.c
> >> @@ -493,6 +493,7 @@ static int ec_device_remove(struct platform_device *pdev)
> >>  
> >>  	cros_ec_debugfs_remove(ec);
> >>  
> >> +	mfd_remove_devices(ec->dev);
> > 
> > Why is this still required?
> > 
> 
> Hmm, maybe that line shouldn't be here as is not really related to this patch,
> it's more a fix for the cros_ec_dev to remove those cells that are registered
> with mfd_add_devices.
> 
> Actually what we have is cros_ec that instantiates one or two cros_ec_dev
> (depends on the platform) and cros_ec_dev instantiating different subdrivers.
> The purpose of the patch was use the device managed resource for the cros_ec
> driver, I did not touch the cros_ec_dev driver

Also, if you are using managed devices, you shouldn't need to call
mfd_remove_devices() at all, since it will be called for you when the
device is torn down, right?

> >>  	cdev_del(&ec->cdev);
> >>  	device_unregister(&ec->class_dev);
> >>  	return 0;
> > 
> > [...]
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
