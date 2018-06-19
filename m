Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/dFVLEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6997A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967187AbeFSQNP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:13:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37661 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966739AbeFSQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:13:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so1503369wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NI9pUEdzdqLxZ4OT/Rck3Rw0VtUJokueNnd9m0UfHEY=;
        b=f/dFVLEsbhdm8knanGbavPe9NXrHPuPfn84Gxvvly/JdjWIggqqhR7iyipcwUZ+DHJ
         SPMzjJTGop8j5BhEmwB3p5vbKQvNOI9k5h3du9FkR8k2oG0Oz791CASLTP9xRHrM2aW1
         c8NX31kZDUzjfgDmUokSJmCOQeeHgEZ93Qh8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NI9pUEdzdqLxZ4OT/Rck3Rw0VtUJokueNnd9m0UfHEY=;
        b=GxMIUW9edVO+3WfQg6s5E2loHYrNUu+IaUR4ef7wBao2c9KJgsn+Z7eQCTvfGNCc0o
         3ZbFLVZn1278dCSZXRcAnRXuFGe2X1aezDtVE60AadcL2BpCEXH5JouUeOIO3Hl5Xbj6
         +/B3984iF3g5uQH0r9bWQTsbzgTcP3U8pt1DpVtIPokOhHLnGMUoiUhh1zxGoGUrSzbY
         xHQqjJ2/j0vMGa1IphYMVHCAy5zGgwlgYnrqm1AFegBFHg7pKd4utbN/MlY7f3mdBM8R
         47Jl2YjbHVfbz0dxIzqYERsqpw8BTr64xqXdhXk1GHev1jf5AWjL2S1LdWvHpjyxJ/J/
         qf5Q==
X-Gm-Message-State: APt69E3g+m5eeOL3nOLvQDDJtEqCOx5pRdLHM1gmZ3AClj23O9M1NRgp
        7CRaigY5HnK3zttCYzBsUvUyuA==
X-Google-Smtp-Source: ADUXVKKfOuUryrNIfftKnaFeKvZd0n16AgAFiY3TyEzyfJxO13+3bKjbDpPtoeIIFv1CHjnrdoeQ7w==
X-Received: by 2002:a1c:ea4a:: with SMTP id i71-v6mr11396567wmh.158.1529424786403;
        Tue, 19 Jun 2018 09:13:06 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r5-v6sm47248wrp.59.2018.06.19.09.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 09:13:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/5] slimbus: Add QCOM SLIMBus NGD driver
Date:   Tue, 19 Jun 2018 17:12:56 +0100
Message-Id: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Some parts fot the work is derived from Qualcomm downstream kernels
and intial work from
Karthikeyan Ramasubramanian <kramasub@codeaurora.org> and
Sagar Dharia <sdharia@codeaurora.org>

Tested this patchset with v4.18-rc1 on DB820c with WCD9335 codec for playback
and Craig tested on msm8974 with wcd9320 codec for register read/writes.

I have pushed my working branch to [1] incase someone want to try.

[1]:https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Changes since v4:
- Moved all dependency patches to this patchset.
- replaced slim_prepare_txn with slim_alloc/free_txn_tid()
- fixed runtime pm issue for ngd device.

Srinivas Kandagatla (5):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: messaging: add slim_alloc/free_txn_tid()
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
 drivers/slimbus/Kconfig                            |   11 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/core.c                             |   39 +
 drivers/slimbus/messaging.c                        |   74 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1381 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |   10 +
 include/linux/slimbus.h                            |   14 +-
 8 files changed, 1588 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2

