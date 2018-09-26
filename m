Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E721547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLCwlDf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624E721547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeI0ARL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:17:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeI0ARL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:17:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so11043985pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7x8vU+QPzqkl1b1HK/UQe87tsHfAWdX6bNhK7HjKn8=;
        b=KLCwlDf1ZDopLBuSaLeYuU/36YMrRKzFJqJFEBtl7D3BpTGtBbtiaYGyCiC6yaVDwV
         DhGyj9O0HkpwsN8oD6AhMqRMiI+AmxQ7j0JwqcXXcph7oLz30sSVAucH+BJpEY1etnQN
         Cggw1cHVREJCZKsE1HKByntrCdknJbLY2/la8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7x8vU+QPzqkl1b1HK/UQe87tsHfAWdX6bNhK7HjKn8=;
        b=Uk4QWnht9rZDb4hYQ5Z0n8HBt+x4JiOnBCzAUXjpBaF8GxU4R+PtCE6wsi7M0wSs9v
         vGlrU7jQVtvYkzbPdbxLERFUD3iuFqFqmRXoyHoMTMM9SkBfbG2s4ljUShiU04iID7Md
         x5WtDhzn3b4g2ZXZxVH6ZE7XXPZStzukCghvCaT4fZageW7kyE39M5k1mnR5GGBY3qal
         dUIH3ekKQNWfLlYdGsDjDaMkNW3sezMtEKSvOTb56OWSz2YSbAqIYN3UpiPIRh1Q9s3k
         ocRSnp3V4AQI5Sn5TWKaWaUkV9GtF+z08AXbWml9tuhr31iqDfOFNoMSvR0I8h3TClDQ
         /ltg==
X-Gm-Message-State: ABuFfoh1JHByddCpv8kZX5+CYyZtzjRUB1yXnNDOldwORUzmkUIOTIcI
        9lT04jW0FG+QUoGbAAyAic435g==
X-Google-Smtp-Source: ACcGV63Ou3/2Z/BJ7imdDbfBJNqqwKoSOQT65mr0Gf1ijgwqEqlue5R/gqxicAHnWaGPU5pG9+YL4A==
X-Received: by 2002:a63:78cc:: with SMTP id t195-v6mr6629237pgc.329.1537984984227;
        Wed, 26 Sep 2018 11:03:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id j16-v6sm12246816pfk.125.2018.09.26.11.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:02:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH v3 0/2] qcom: remove memcpy()ing from cmd-db driver
Date:   Wed, 26 Sep 2018 11:02:32 -0700
Message-Id: <20180926180234.55620-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple patches for the cmd-db code to not do any more copying
of memory. Instead, we'll just hand out pointers to things
inside cmd-db. 

Changes from v2:
 * Consolidated GPU code some more per Jordan's suggestion

Changes from v1:
 * Fixed patch#2 for GPU wreckage

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Rob Clark <robdclark@gmail.com>

Stephen Boyd (2):
  soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
  soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 54 ++++++----------
 drivers/soc/qcom/cmd-db.c             | 93 +++++++++------------------
 include/soc/qcom/cmd-db.h             | 12 +---
 3 files changed, 51 insertions(+), 108 deletions(-)

-- 
Sent by a computer through tubes

