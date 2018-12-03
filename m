Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD591C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9452082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBUQqzuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9452082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLCKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:43:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45232 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:43:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so11545977wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TRRpU1ugoBCwyMdRSV7p1f06262sTpaTgnrzhW6b2M8=;
        b=dBUQqzucAQl4frXE0OblVrA9Sd3RqVd/F777b7y/qX20ieSA/QdfB5kJVzff6QACoQ
         HgFHrUwfBfCFu1YGHvwq8xt5vGanEIZoxp/Cq8TM6rC5td7PayP2ffvux2PJJ5r2nwWe
         l4rQOMRd8SrcCU3jLKyy7tLX/jc/JGBj/7SGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TRRpU1ugoBCwyMdRSV7p1f06262sTpaTgnrzhW6b2M8=;
        b=ngdoW5v+bToXzN7f0LKT6MvCAM1noaNYFzPT9dF0xASYI4z/dkWao43N/KmuNPj65h
         VmClEw4grr21nvAofrFOUF8IZTTAz8zL+eo/aDnTYxn7FW7XRQh/oZqVpqkWw2Siy8xg
         cQcpxBlU89z+fktdJApWCg46+cJ8Wl1rSgWjxp4BTiVybN3N8/+SHVx0x8FcrszBW+h3
         xDIqAL8xQrYZsqk8woITSHJAd6TjxaizDUO7grcPx6YN34EnLjYRRu+CKxf1gAE0j84R
         Z0tLj6TKzh7Xb5Ly6NWE22m2/16ngHMoBWxWflvWga50Jem1186lCl5Ybg0w3pkQiXlv
         tt4g==
X-Gm-Message-State: AA+aEWZ0s9MPuDHdZuIlcFb7fv3iOx+/KByoC64yiAahadWn7x5L33xX
        oRRKswIL3ekhytlPVN5PWGaVYQ==
X-Google-Smtp-Source: AFSGD/XlqzlkYq0M2ZVQCxJ5sNJwWYPmqsc1nbGwty39zp7DYx8nCnAj6RtW9JJdhuOMQi2HMAdVxA==
X-Received: by 2002:adf:e707:: with SMTP id c7mr12879927wrm.196.1543833776814;
        Mon, 03 Dec 2018 02:42:56 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id h203sm20661986wma.19.2018.12.03.02.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:42:56 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:42:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 3/8] mfd / platform: cros_ec: move vbc attributes to
 its own driver.
Message-ID: <20181203104254.GE26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_vbc should be its own driver and its attributes should be
> associated with a vbc driver not the mfd driver. In order to retain
> the path, the vbc attributes are attached to the cros_class.
> 
> The patch also adds the sysfs documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Fixed build error as reported by the kbuild test robot.
> 
> Changes in v2:
> - Removed unneeded check of ec_dev.
> 
>  .../sysfs-class-chromeos-driver-cros-ec-vbc   |  6 +++
>  drivers/mfd/cros_ec_dev.c                     |  2 +-
>  drivers/platform/chrome/Kconfig               | 10 +++++
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_vbc.c         | 43 ++++++++++++++++++-
>  include/linux/mfd/cros_ec.h                   |  1 -
>  6 files changed, 61 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-vbc

Patch looks fine, so long as drivers/platform is the right place for
this driver to reside.  No better subsystems for it?

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
