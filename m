Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF15C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B9B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbtMdunc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B9B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeLEKFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:05:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35268 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeLEKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:05:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so19026910wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ng7uQOIsu1dfvksG0iACt+aByYbnfmfrK7mC5qiDRPA=;
        b=JbtMduncsGbNGCfjNy0cROdW7R+KT1dd+ElYm99IRebO8dZ7lZzz6/AJcveN6f7Wwk
         T70qkOXUfg0LgrIGfDKeHoFfT23etydSv/gO1kbbeOfk5Fjozd2TfIsFUfvsjQuwZv/A
         ZrRxKhGkLbSjmEoTdz+lErrm3x3DhSF+5D8Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ng7uQOIsu1dfvksG0iACt+aByYbnfmfrK7mC5qiDRPA=;
        b=WKD2lXDyBwJQlr8TPOK33QEPL7iqvNTEALQn/yhqFiBq+oXm1nDsArSiqi6S2Hdv08
         fTsXpLJ25i88gmAzJ+jRlubLBkRd/FSKvWq4Cf2QAezE4z5NE/QYCYLTIJL+Uy0uQhry
         3GKZjFgEjYYylJbzrJjD91Q2CuNpJLnPSfNCSNDEDNVAP01imMBOG8RPOMClCdvYnNah
         GpgeXUcyiuzNHvpE32m/ybBcc3JUMyEZ8bfOsnnHA68KICvSEANwAz1SFH5nO8dNzSRb
         iPc7p7RXO5ZrrgVo0GpmQOiwvWIj+oNRFxSkRM80M9b2D+2MBhZxzna6LIqALgLyF1N4
         a58A==
X-Gm-Message-State: AA+aEWaE4JjX5htjoDLgbmytk21YQvGnktZBfrR6Hh4in8CBOENg5WTv
        pqOZNUokmoyb7FM8whi+vS5G9g==
X-Google-Smtp-Source: AFSGD/VUoQoM/DxBPRMyRWJONWaHQUbUH2VcwTjzjisOOuusQuMFw02jcKEO3RdXk09bwf4G41lQAA==
X-Received: by 2002:adf:f189:: with SMTP id h9mr21061838wro.35.1544004347203;
        Wed, 05 Dec 2018 02:05:47 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id e130sm30513607wmf.25.2018.12.05.02.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 02:05:46 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:05:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org, dtor@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: cros_ec: Use devm_kzalloc for private data"
Message-ID: <20181205100544.GB26661@dell>
References: <20181204155843.11411-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204155843.11411-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Enric Balletbo i Serra wrote:

> This reverts commit 3aa2177e47878f7e7616da8a2050c44f22301b6e.
> 
> That commit triggered a new WARN when unloading the module (see at the
> end of the commit message). When a class_dev is embedded in a structure
> then that class_dev is the thing that controls the lifetime of that
> structure, for that reason device managed allocations can't be used here.
> See Documentation/kobject.txt.
> 
> Revert the above patch, so the struct is allocated using kzalloc and we
> have a release function for it that frees the allocated memory, otherwise
> it is broken.
> 
>  ------------[ cut here ]------------
>  Device 'cros_ec' does not have a release() function, it is broken and must be fixed.
>  WARNING: CPU: 3 PID: 3675 at drivers/base/core.c:895 device_release+0x80/0x90
>  Modules linked in: btusb btrtl btintel btbcm bluetooth ...
>  CPU: 3 PID: 3675 Comm: rmmod Not tainted 4.20.0-rc4 #76
>  Hardware name: Google Kevin (DT)
>  pstate: 40000005 (nZcv daif -PAN -UAO)
>  pc : device_release+0x80/0x90
>  lr : device_release+0x80/0x90
>  sp : ffff00000c47bc70
>  x29: ffff00000c47bc70 x28: ffff8000e86b0d40
>  x27: 0000000000000000 x26: 0000000000000000
>  x25: 0000000056000000 x24: 0000000000000015
>  x23: ffff8000f0bbf860 x22: ffff000000d320a0
>  x21: ffff8000ee93e100 x20: ffff8000ed931428
>  x19: ffff8000ed931418 x18: 0000000000000020
>  x17: 0000000000000000 x16: 0000000000000000
>  x15: 0000000000000400 x14: 0000000000000143
>  x13: 0000000000000000 x12: 0000000000000400
>  x11: 0000000000000157 x10: 0000000000000960
>  x9 : ffff00000c47b9b0 x8 : ffff8000e86b1700
>  x7 : 0000000000000000 x6 : ffff8000f7d520b8
>  x5 : ffff8000f7d520b8 x4 : 0000000000000000
>  x3 : ffff8000f7d58e68 x2 : ffff8000e86b0d40
>  x1 : 37d859939c964800 x0 : 0000000000000000
>  Call trace:
>   device_release+0x80/0x90
>   kobject_put+0x74/0xe8
>   device_unregister+0x20/0x30
>   ec_device_remove+0x34/0x48 [cros_ec_dev]
>   platform_drv_remove+0x28/0x48
>   device_release_driver_internal+0x1a8/0x240
>   driver_detach+0x40/0x80
>   bus_remove_driver+0x54/0xa8
>   driver_unregister+0x2c/0x58
>   platform_driver_unregister+0x10/0x18
>   cros_ec_dev_exit+0x1c/0x2d8 [cros_ec_dev]
>   __arm64_sys_delete_module+0x16c/0x1f8
>   el0_svc_common+0x84/0xd8
>   el0_svc_handler+0x2c/0x80
>   el0_svc+0x8/0xc
>  ---[ end trace a57c4625f3c60ae8 ]---
> 
> Cc: stable@vger.kernel.org
> Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/cros_ec_dev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
