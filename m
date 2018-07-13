Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693FEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227812147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3/3p8iT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227812147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeGMH7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:59:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbeGMH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:59:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so24143715wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tsF1/rFKTWKQ6pJBTW9GmuhhuqkCoXVS6f+kIIRwmjg=;
        b=g3/3p8iTAMnEvIuCyYpdkPd/f7GSNaAmpu0E0MKe7Ncs8MZj2l+mmqADP8bLBzd8au
         XKjSqtAEGfTATCOf/NzgKdtA8+M3C0fi6TyQJ3+5yIiuvgbDcZv8eY0lJoqvMCP4xI/8
         8uOirJSB/HI+PeZQzRGN1YseQWMZWtllj6nAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tsF1/rFKTWKQ6pJBTW9GmuhhuqkCoXVS6f+kIIRwmjg=;
        b=ESktF1MImJXrHoVlfKxcZMMe995BOzMmfDMiWa2PLi8Qs/4w5QuZ5Yq9+I8sC/r5Gc
         8i3tIXE+AT08Sml2nY8jvdaF/KfZFcfffWS5uJNLsGfwTI9FOuedIs0oKDR+FUK/TsAV
         cawMVDqIifT0/7ntPmTzMvGG7IqLTi0lx2nkgwcGHzs6MQ9ITAx25+c6s3D12qQmg7yf
         P4+bNR5fWlF4NoHiA/mvZj2I2uU5ldRhldigDuanBRQEcPDwj1UcYRObyzLd7GdnefM/
         WniXSB43I+F9WVg8ZuHQ+IrK1RNNWPIlbKtnECGQGhz7r83u14GIhybuCGXLFM5cZBqC
         +HRA==
X-Gm-Message-State: AOUpUlEHEHuB5i0XiMDsdnzZeUVTIUFelqcZqrJgsa+KtPghuzXY/5Yo
        uCFQDGq87DimCIKkjK1JwBtDyg==
X-Google-Smtp-Source: AAOMgpdyT3NtUIMO0mHvDylqvR7/gBAHbknwDIHVXTXr1rRZR9Lxg4PlATlpoBFNttWMwccDbnoyyg==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr3951607wrw.159.1531467982883;
        Fri, 13 Jul 2018 00:46:22 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id b6-v6sm53137553wru.66.2018.07.13.00.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:46:22 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:46:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: [GIT PULL] Immutable branch between MFD and DRM/i915, Media and
 Platform due for the v4.19 merge window
Message-ID: <20180713074620.GW4641@dell>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-i915-media-platform-v4.19

for you to fetch changes up to cd70de2d356ee692477276bd5d6bc88c71a48733:

  media: platform: Add ChromeOS EC CEC driver (2018-07-13 08:44:46 +0100)

----------------------------------------------------------------
Immutable branch between MFD and DRM/i915, Media and Platform due for the v4.19 merge window

----------------------------------------------------------------
Neil Armstrong (6):
      media: cec-notifier: Get notifier by device and connector name
      drm/i915: hdmi: add CEC notifier to intel_hdmi
      mfd: cros-ec: Increase maximum mkbp event size
      mfd: cros-ec: Introduce CEC commands and events definitions.
      mfd: cros_ec_dev: Add CEC sub-device registration
      media: platform: Add ChromeOS EC CEC driver

 drivers/gpu/drm/i915/Kconfig                     |   1 +
 drivers/gpu/drm/i915/intel_display.h             |  24 ++
 drivers/gpu/drm/i915/intel_drv.h                 |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
 drivers/media/cec/cec-notifier.c                 |  11 +-
 drivers/media/platform/Kconfig                   |  11 +
 drivers/media/platform/Makefile                  |   2 +
 drivers/media/platform/cros-ec-cec/Makefile      |   1 +
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                        |  16 ++
 drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
 include/linux/mfd/cros_ec.h                      |   2 +-
 include/linux/mfd/cros_ec_commands.h             |  97 +++++++
 include/media/cec-notifier.h                     |  27 +-
 14 files changed, 578 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
 create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
