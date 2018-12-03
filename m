Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A0DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB202082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MK/hOlfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB202082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLCKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:36:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51103 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLCKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:36:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so2732297wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tZ39PrTF0znqqIsslBBgwwXSS7/eKyw+IFfL3nde1N0=;
        b=MK/hOlfS5hp5q8y6O9f1lAfndbtfdnj75d8/A97AL39kRZ/sosV0F+ncfMDpJDoFOa
         M4XXNXJ+DyL6CKc+NCQJv/oyx5IAlUAqjkD4NcdMsfFKVGBKqmX/xoBSi8zC6+XZ/Xtb
         S8hEKNiG5Xi2k5RL9dkII8aKc+bnHh8+tijJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tZ39PrTF0znqqIsslBBgwwXSS7/eKyw+IFfL3nde1N0=;
        b=MSCEAz9If9sNRcjMnYsv//XvxF/OOuERo8AAM7MGuILfxSo9GdxCKnhyJYCMRNW7in
         d6W6BgZjKEm94CwPuEEFqwBdO2O7P49EO2tbGGR1iONleMJd1YPKTtK9HgPRLVkiEj2c
         JbFaXjo1Xs2Oy0BICwQgCe3H/doJDkChETaHj1ehRbVsawrhzS06R5pXYSiZM6N1VC8Q
         AAMQQpljDcuHDPNfsJZlNEN6vkUh3CeEXUrekoQVJ6SvVFoAtydnOsKKZURWrdGQ8Khp
         U9miqAcVwdxbzqZpcN25KcW1YD9YsT3VqZI0nOBvHtL6YjxkmrffDFaJSegCmMs4mMZo
         Y9OA==
X-Gm-Message-State: AA+aEWbc2zQt1obeA0twk66/31vND4NyQ+8RWeOhDrsr24tmCNAhI1i1
        2fhWsohA4AlABC9L7Mj9lj056g==
X-Google-Smtp-Source: AFSGD/VWlIkJmzFC9WU5v3nC8x3mEAIcOIFQeWiklEm8rbr9tI3jVUGPV6zd2TgyHvMlS35qPMS+0g==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr8328297wmc.7.1543833381434;
        Mon, 03 Dec 2018 02:36:21 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id w16sm21775138wrp.1.2018.12.03.02.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:36:20 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:36:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
Message-ID: <20181203103619.GD26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_lightbar should be its own driver and its attributes should be
> associated with a lightbar driver not the mfd driver. In order to retain
> the path, the lightbar attributes are attached to the cros_class.

I'm not exactly clear on what a lightbar is, but shouldn't it live in
the appropriate subsystem.  Like LED for example?

> The patch also adds the sysfs documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Removed unneded check for ec_dev.
> 
> Changes in v2:
> - Removed the two exported functions to attach/detach to the cros_class.
> - Use dev_warn instead of dev_err when adding the lightbar.
> 
>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
>  drivers/mfd/cros_ec_dev.h                     |  6 --
>  drivers/platform/chrome/Kconfig               | 10 ++
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
>  include/linux/mfd/cros_ec.h                   |  1 -
>  7 files changed, 172 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
