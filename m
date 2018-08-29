Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6BDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71A12064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRyZ4zRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71A12064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeH3DMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:12:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38425 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeH3DMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:12:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so2957505plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R4fo+PSsCT9wIggboItk/HU4eKAdedO7SgEFW67hCYU=;
        b=BRyZ4zRWp9pFI8ScogxSHr8IKwbUwqC5F/VWj+xG3Vqg3hWdmoXeEOfAmVB8AYMz0E
         1L1ck6FpMouafvi3on07wErAFQ1N9VmGOTYDo8FSr2gu8seKkTAsiQnJQ+FCNxTIDqU+
         bFNXajGpQ6z1mMuGFOSSFmhWditI5mgc34B64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R4fo+PSsCT9wIggboItk/HU4eKAdedO7SgEFW67hCYU=;
        b=dP/XjT3QiNPPLm4fMH9Lan+d/++NmFX6YxntSmbezvPzOkUritexwpUu0CCgULKsTq
         xL7Jvz65oITSN75J2ICbvUJXxDD9GtXZnfSRkP6Ft8WRlik5q3EZ14lX6d4DsB7byQsW
         YQ0VrBqx0GqhtunkzqdaqWqfMhyO4dZHjc0Y8AQiP+2m1txcy0IeX0MIpc/Rjmay/tYa
         mSqF8KiwEsGTE3nJygXRs4SdXTVPIaJ2IYxOCrw773T33qPrrMzjlIUve6R090wAnIyx
         UusIhItKDuH1u+w4WJx5y6Gm9/dPOPKetJVUgDhZJC+8ANHfoOVcBhYqXDJOB4fQrt48
         BXKw==
X-Gm-Message-State: APzg51DYTKciJ3tDOSfY7biSjeE6UNhSnwOhV0H8ymOhnB4r2nXXbzW9
        IPIJstp8Fk/Gwikj4PpLBhbQNQ==
X-Google-Smtp-Source: ANB0VdZQI12D3Mg/Jcfvz0vOoFmicly08EvV+Dhwybu3sQ9cHkU+kQ49VA311MDq8/EEAMd80g+9dw==
X-Received: by 2002:a17:902:5998:: with SMTP id p24-v6mr7767439pli.36.1535584406269;
        Wed, 29 Aug 2018 16:13:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w69-v6sm14035404pgd.37.2018.08.29.16.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 16:13:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Sricharan R <sricharan@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: [PATCH 0/3] firmware: qcom: scm: Improve clock handling
Date:   Wed, 29 Aug 2018 16:15:02 -0700
Message-Id: <20180829231505.22660-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're currently facing the issue that every new platform requires the addition
of a compatible to the DT binding as well as the driver.

The DT binding patch to allow us to use qcom,scm for all these new platforms
that doesn't require any clocks and the driver is reworked to make the qcom,scm
still pick up specified clocks in this case but won't require them.

This makes it possible to add new platforms by simply add the new compatible to
the list in the DT binding, but no changes needs to be done in the driver.
Which is what is done in patch 3.

Bjorn Andersson (3):
  dt-bindings: firmware: scm: Refactor compatibles and clocks
  firmware: qcom: scm: Refactor clock handling
  dt-bindings: firmware: scm: Add MSM8998 and SDM845

 .../devicetree/bindings/firmware/qcom,scm.txt | 33 ++++++---
 drivers/firmware/qcom_scm.c                   | 74 +++++++++++--------
 2 files changed, 63 insertions(+), 44 deletions(-)

-- 
2.18.0

