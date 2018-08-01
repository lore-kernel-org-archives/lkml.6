Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D54820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gDBlmo9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D54820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbeHALp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:45:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44202 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbeHALp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:45:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so19486729wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=R8V9qS7RHBkORrhq3PjUR7AbuVwCLRqpVf31ozhz4/w=;
        b=gDBlmo9FdK8QR2+NbotsYk0D86DH3QAzZQkDCRakum89ed63hKunA3D3gtRr2C8i1d
         ZLBoIDAK8tJon0XcxCMmM/x4usgzH7vrq++OvH9gwrRJX3FGjIUGnA4bDYwh8AS75lFQ
         XyVuN0pIfzE4tqc0nugXzcISlM5TTevCJCgDwLi8OGvKNWY2w9sVrxf7bs1HYRq/xYe3
         Z+0ThvfHXaagE6mYxjWR4AMkg/ZXiCWF2MtH1a15tn/sH5kmZotQy6PtMGabWpRCQ2h8
         yP2zTWF5fQ41ci3GhHBT4SAXcVv6ll69vfuAjMKXNINooNUsUVVxgm55smb3R+/0DUFR
         U/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R8V9qS7RHBkORrhq3PjUR7AbuVwCLRqpVf31ozhz4/w=;
        b=ioQOHPeEZPksYVdmGGkWcTtf0dJeyS4rzj1hObFR/64Buv50BAxmVlmLyATwuSGd4L
         ojrFXzHlfhfRFeWONreo9qWLoTpUHL/Ve8KDcUuy67uL+24braHTf+BbVCuDjuGurGMH
         1Ej9wLqpsvLps59owEeK3dSrkmptGq1n/RO7EGTEgaxGdUTzo4A8gSVOeJ8bi5AFtQU2
         o83zfLXRngLH5svX6J9H0zTazjaIGSGW7+0pc+XYx6kBYZXP1RJnYM143nm7fgbgK7u8
         WXK2ccmCsP10dhIUzLbN1/HFe1qlz4Zx7TUu1ZLctApsmgPxGzkqlRvy8cVInS9pTLC7
         4fxg==
X-Gm-Message-State: AOUpUlEbw4dMAEzZDEl17S/3QrRr2COwAT7Okj7msSvxqXKLShFEnxCF
        K1RcPxKjut27qMPr3udpyyXg3g==
X-Google-Smtp-Source: AAOMgpdPpNSu+fAPxQ/tnpHUTpkjxjBIK6O0nPMkIZJeEJaJk9WAPo0SDai9YUUQHltMB5s4CNqYOQ==
X-Received: by 2002:adf:b309:: with SMTP id j9-v6mr23014680wrd.207.1533117628023;
        Wed, 01 Aug 2018 03:00:28 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u7-v6sm6317067wmd.46.2018.08.01.03.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:00:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pinctrl: meson: Add support for TEST_N gpio
Date:   Wed,  1 Aug 2018 12:00:18 +0200
Message-Id: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
set the TEST_N pin direction.
This patchset :
- adds the Secure Monitor call
- adds support int the pinctrl-meson common code
- adds support for GXBB, GXL and AGX SoCs

Neil Armstrong (5):
  meson_sm: add TEST_N pin direction call
  pinctrl: meson: Add support to set direction with a secure monitor
    call
  meson: pinctrl-gxbb: add support for TEST_N pin
  meson: pinctrl-gxl: add support for TEST_N pin
  meson: pinctrl-axg: add support for TEST_N pin

 drivers/firmware/meson/meson_sm.c          |  1 +
 drivers/pinctrl/meson/Kconfig              |  1 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c  |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  |  4 ++++
 drivers/pinctrl/meson/pinctrl-meson.c      | 31 +++++++++++++++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h      | 10 +++++++++-
 include/linux/firmware/meson/meson_sm.h    |  1 +
 8 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.7.4

