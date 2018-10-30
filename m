Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DCD2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dTvWtyGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DCD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJ3TPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:15:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51297 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJ3TPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:15:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so113753wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=oHwIOK7vIbf8oBgNpA5M3ssBE6xZbJhaQZte0SX7dJY=;
        b=dTvWtyGfcRGsjg45ofZvMDsGjExJcwVldyixbJZz7ylClXxhf2FOTJGt7Ht2Ma2GGQ
         uhFlNmr8iUN5cy46WwYryFsqjOieNRSgmijG6uuPmZxhd6MiS2udF9Pjze1t8kRkN9G1
         Z47Ha9KVCMcU1ZxTQttY6bY/PUQ9+R6nTzl3/LSnctDQu+VxrZwo6FtwRWdy6cB33QM0
         nA3hQWnt4V0mUYAqaMohkGO1d83c1fiP1jUQFKG41FaipW24suon6dk3FpfduiPeiTMq
         8SVdZzUDA8PynxG8yvUVouXSjOmFCA61ylpAY0uSyvsfUyDlY/FGMyxqr5/2zKsCCedc
         ECqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oHwIOK7vIbf8oBgNpA5M3ssBE6xZbJhaQZte0SX7dJY=;
        b=iywsf1l0/vOqg+tPi5rvwmS6JX9C2r3sc++7pxEUR4dRgOI9+avMUsmGfrP264YoOL
         65o5MRuDSSV9bE/C71wLplAXRDRVITMHDFH+q4zmk3J023gSOttWNaIZiYxBT9O/G8P7
         Tbuut2x6tnfKmTSIT15elcPP5/aOdMWjbeY54MrT90J5sA2PRfb6THTZSU6W81Tou7HV
         JfWeC5567qyLtPoluYMSP9rQbyRIDANHuvvyPc6tmoEneylcW29AWvd3wsC90ZcZrN44
         3jWjyO6SXXTWTrTIS2WIrAgFIcq02qBy39pjsUl/FkT0j4WhNWIQMvHezKrJowqylwhg
         EYtg==
X-Gm-Message-State: AGRZ1gIC3uqaXe3U97ce+FJrLUiQfnXoprmeFVK2kOtbLTV+vs5nv5Vc
        czRa+iZkWTANWKbaS7sMQTLh1uJQvF4=
X-Google-Smtp-Source: AJdET5d8/qvWP7/zsVK7xQ/K/LnNtYOYBVbWE6VN2J4V+9SNwOQlUqchRsqCPzQrnuO+WldS05yUrQ==
X-Received: by 2002:a1c:c4f:: with SMTP id 76-v6mr1237463wmm.6.1540894958712;
        Tue, 30 Oct 2018 03:22:38 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i204-v6sm26638614wmd.28.2018.10.30.03.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:22:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] nvmem: meson: efuse updates
Date:   Tue, 30 Oct 2018 11:22:27 +0100
Message-Id: <20181030102231.4851-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first change of this patchset just adds add error message in case
of failure. If there is problem with the secure monitor, the
SM_EFUSE_USER_MAX call will be first one to fail so it is better if it
give us a clue to help debugging, instead af silently failing.

Next this series adds the peripheral clock missing in this driver.
Like many other device in amlogic's SoC, the efuse requires a
peripheral clock to operate. ATM, the clock controller has
CLK_IGNORE_UNUSED on this clock and we have been lucky enough that the
bootloader left the clock enabled

At some point, we would like to remove those CLK_IGNORE_UNUSED, so if a
driver needs a clock, it needs to properly claim it.

Srinivas, Kevin,
The dts change needs to land before the actual driver change, to avoid
breaking the efuse on our users. If there an agreement on this series,
Kevin could you provide a tag to Srinivas ?

Cheers
Jerome

Jerome Brunet (4):
  nvmem: meson-efuse: add error message on user_max failure.
  nvmem: meson-efuse: bindings: add peripheral clock
  arm64: dts: meson-gx: add efuse pclk
  nvmem: meson-efuse: add peripheral clock

 .../bindings/nvmem/amlogic-efuse.txt          |  3 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  4 +++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  4 +++
 drivers/nvmem/meson-efuse.c                   | 29 ++++++++++++++++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.17.2

