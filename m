Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ADCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4462420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWVfKpy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4462420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeKSWtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:49:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeKSWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:49:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so5138462wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xesRda5rimx9wq9yHaz1ffHav24Xt7nvxc3sWfUisE8=;
        b=TWVfKpy6pgfIlB74YTGVavAeGXe4pHa9FohBZE3fVexN12ckCZMGagl7f1mH8OKO1a
         w1yGPOuSBCMv0DigOVom8fcbhvbDYcYZ6eC4ceCbq2faUvvDa0BAA2ikY7dP8/BioW7E
         U4GmFgay+UuvoM2ys8maUm8NlCZRwHwuO1Q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xesRda5rimx9wq9yHaz1ffHav24Xt7nvxc3sWfUisE8=;
        b=JWl19NGVcHJRNuCt3J4vvfh94HgvFC22E8kU6hOJT930WXyuyN0wuFI/Pvd1dknof+
         poSq9Q3ZDKlwKiF80knsZF5nOk5JhqxPG8OXCXu0t4gwn9rKgJ20CJIzTNsmIgEVV5Tt
         9cCcOwuQhAFEHUTxaP3Kvd2W9lVVLfYKhw22z5a5z1IZktsSeb3oLvDd/uPUIfpKjjuX
         emRMHwe/uu39wR3CGgKFCgIz4AyxIQt6tWI1gNXaVkvppCxljl+H2ZBp9x0j0RlcsqLj
         mjJzeInDgS3Qa2fXQY9uh2ABmyOxeRfe1+P7+626GPZ4obnQ0ajKsCR8n2ieIhs2pc25
         beHQ==
X-Gm-Message-State: AGRZ1gJ6lysgM1BJYsQa47yhywc+P0q6X7jeidIusINtW+Illl4bHYZH
        YpVwVIxlMQ36Reny++txuNYAj0dA3O8=
X-Google-Smtp-Source: AFSGD/U8jZEHN4bMggPht2evYtu6dwJ3xRa8jzCxbBbIx9/v3NsArQ1fFDtUPv5FOLw2YG4H7IHysQ==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr7196654wma.85.1542630335727;
        Mon, 19 Nov 2018 04:25:35 -0800 (PST)
Received: from localhost ([49.248.195.80])
        by smtp.gmail.com with ESMTPSA id d5sm4075397wrx.22.2018.11.19.04.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:25:34 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v2 0/4] thermal: tsens: Add support for QCS404 platform
Date:   Mon, 19 Nov 2018 17:55:18 +0530
Message-Id: <cover.1542629810.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches have been tested on top of 4.20-rc3 + various qcs404-related
DT patches now in Andy's ci-next branch[1].

Changes since v1:
- Change p1 and p2 to be fixed-size arrays
- Refactor DT entries to be sorted by address, Thanks Vinod
- Added Acks

[1] https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=ci-next

Amit Kucheria (4):
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor

 .../bindings/thermal/qcom-tsens.txt           |   3 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 226 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   2 +-
 drivers/thermal/qcom/tsens-v1.c               | 196 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 6 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1

