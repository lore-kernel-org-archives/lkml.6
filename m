Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D204C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AEB20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HwJAqaUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AEB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeH3T1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:27:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3T1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:27:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id w8-v6so2456089pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yTIwkCYK+pxqBVVBZV9JxsXH4X6wG8/VjUyBuG8Tdg=;
        b=HwJAqaUZojBZu6tlzU8IPEXrzKEbHkBwLZ2bAIsV1nIxqrxHWCXMqWFluhpcQBTs8O
         78skkYDqFWUO8VUNM73Qsy8VOA3M+qzJgyqFteumztMdI+D0S0dogjBKqqYQqg6YXTPv
         EpfNAbeD80SA0SN+jkIeLNU3k4slMyJ1FDa4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yTIwkCYK+pxqBVVBZV9JxsXH4X6wG8/VjUyBuG8Tdg=;
        b=tDyC2SmPdvqmfSLnJfVe2thkBnfbLPKwNiaOUOLXx7ZCiRgfFZS7A/lJNisbnWuGbU
         OkbDzck7vBIWHyoVrpktfPkIru4HIa4hSGj9hMhReg4xjUsDWagb0inlY1El9kBEVl88
         /oVOZ2veNw+bypb/EpC1dtzT+hhVVDejFzxEkkHnxEkji7Mzia4o0zbHG0DLulekbHH6
         /l1WIrfLdZAX2MwNiktz4xaB5uakBfQJXs4tuUEix2nK7mPlXZrEuqUObC/u0+pDimU+
         Wqduy8zVtktbnT3NCww94HG8ZxRR6zYnPKXX+I4IiDo7UgFuVvMyrP6WqJ8Xg7HjJUh9
         b/vg==
X-Gm-Message-State: APzg51CQgzkT8WVWLfK+RghlvO0lFLXg84qeZpPeiOEmUsnKqzsMjINF
        COSLHPMu7NcQkUZUju847vAWAA==
X-Google-Smtp-Source: ANB0VdZPAnUX6Oce2nX15bPwRmYgnQ90k/9jG4pHnwZwRJNt4ZLWlAwXSvZiv+JykR6wxKopSqhHmg==
X-Received: by 2002:a62:2744:: with SMTP id n65-v6mr11090551pfn.125.1535642663082;
        Thu, 30 Aug 2018 08:24:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d9-v6sm24143920pfb.86.2018.08.30.08.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:24:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "Ivan T . Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [RFT PATCH 0/2] pinctrl: Fix two more xxx_config_get() functions to be compliant
Date:   Thu, 30 Aug 2018 08:23:37 -0700
Message-Id: <20180830152340.242249-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have no way to test the patches in this series, but Stephen Boyd
pointed out the problems being fixed here when he reviewed my patch
("pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be
compliant").  It seemed nice to (finally) follow-up and address the
problems that Stephen found.  Hopefully someone can test them out and
make sure they work as advertised.


Douglas Anderson (2):
  pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant
  pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant

 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c  | 19 ++++++++++------
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 28 ++++++++++++++++++------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

