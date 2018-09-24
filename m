Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AEC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA0920874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zq1hRxnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA0920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIYF5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:57:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeIYF5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:57:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so2068791pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htkOv8a+jJwLkJJsbzLqP9XECHHdn1Vyryn+ssv2BFA=;
        b=Zq1hRxnljPXKgJ+PZk58Adufj5x61ThBJcAKbTZcVHEOTRieH0ysnp3COnPehO3ANb
         NZPCnVBBMEuyZ2kSEyLXtPSLYjkEJV03fr/QH6VPY2bNH9OgnVHHLuQ5SJyxISufT5Jk
         p3FGvY+55Z7bxzl00gaBHKUFtB8CK+U4hc6Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htkOv8a+jJwLkJJsbzLqP9XECHHdn1Vyryn+ssv2BFA=;
        b=rdbNrKmwPcD/FBsULVmEJumQIHH3tk31ND6YrKIvZglwUce0sZG/XKBltodNBvxxaT
         cVSDRvVz8J7vXU/EYuEpByvisBnmoP1wAHpBNtgUZrmu1SZSLXGEj6SFYF1ePQ1c8O2b
         x3rkHlVOKAySgrqBLVDNgz7I++zNu41iKLAnRVGdJcM5XPXEz+OsoX25QSP2Nj7AC1Sh
         F9mGNL5dYRTX+vx/ezKKspU4Xv41TD8tF7GZJJzXlKZaRagQWX+dZAswIHatCQu22CRT
         P39RzJDed9KwyOpv/bbpKDx3+9+7wgF7Q9B7pMkhNXnNBQSu10g0x36nHXkYuHY7urok
         Vs4w==
X-Gm-Message-State: ABuFfoiEWXlXubb82cOotJs9Qaj+Ty487RgRuwnbhInNjZicapYbBidQ
        Z/Dl5H7q81pG/uJBfAs4+/qhocIK/ZQ=
X-Google-Smtp-Source: ACcGV61ilLHLRC3uXbWAAuLItRD10Vuzf88LsiStlferA5oxVvbbuCwPoi9fW+eZVhGlozzq2uKCKA==
X-Received: by 2002:a62:18a:: with SMTP id 132-v6mr902226pfb.207.1537833157355;
        Mon, 24 Sep 2018 16:52:37 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d81-v6sm518993pfj.122.2018.09.24.16.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 16:52:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/3] Fix qcom geni i2c DMA handling
Date:   Mon, 24 Sep 2018 16:52:33 -0700
Message-Id: <20180924235235.182649-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Numbering is weird because I dropped patch 1 but left numbering
the same)

The qcom GENI I2C driver fails DMA sometimes when things
from request firmware are passed in as the message buffer.
This patch series fixes that problem in the first patch
and the second patch cleans up the code a little to reduce
lines and simplify lines.

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>

Changes from v2:
 * Dropped first patch because it's applied
 * New patch 3 to simplify irq handler
 * Updated patch 2 to hoist out common code and remove 'mode'
   local variable

Changes from v1:
 * Use i2c helpers to map buffers
 * New patch 2 to clean up seriously indented code

Stephen Boyd (2):
  i2c: i2c-qcom-geni: Simplify tx/rx functions
  i2c: i2c-qcom-geni: Simplify irq handler

 drivers/i2c/busses/i2c-qcom-geni.c | 149 +++++++++++++----------------
 1 file changed, 65 insertions(+), 84 deletions(-)

-- 
Sent by a computer through tubes

