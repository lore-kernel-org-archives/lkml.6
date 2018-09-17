Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C89ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD32086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXi2PlJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FD32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIRCJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:09:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43746 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeIRCJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:09:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id 38-v6so2251257plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONHY698AS4/lgMtGINXgaFx6XR7w8BK1UatJF0epUrM=;
        b=nXi2PlJB7qyPxeONGWKy9hJqhkLksTwPNZkqfoBGJFtm9olmGMc5DEazk7ACjh+v5G
         BwY5G1EE1LusukOgyWGnV1jS07DSr4zDoikQLs0DihK9h0EYvjz4hrLYti6SuNL+vqrL
         UK9T8K3hFmyfbaFU9/FV6fUWpjRr9kXYSk6hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONHY698AS4/lgMtGINXgaFx6XR7w8BK1UatJF0epUrM=;
        b=DBtHf7Ins7E0iLNKRvjv5EA+J6gerwAO7yAnbixExs0qXKtqHtfj9BF7XQ8WV56dw2
         ort5dFNXrhkMllOuJKmPVnrqa13N93FELFo8bG8LjO9btkmt5XzukX7lmlF8hWJ+h43t
         49JNzrMwV5siEgJDuo7yZ1lp+L3JJ2RZ0jzxvlZu+bd60gZ+eIiwO7CfW0biE7YE40D8
         KGeSkEq0ao8zHz5TJ7cQKwRKcu47ZbUm+qqaIXvMyoItar6whmoo8Yj40rDw9BMtHFNj
         JKnV4OQFn6JpriWWmDwqkMQ/TQv9hvfqd/WPf16T3mf3faKrwInxELpknvTdDFyiIlpd
         5FLg==
X-Gm-Message-State: APzg51D0tSjVHCD4yo+p+S4w8rLu2dPeOlazysVMENNLOApOEdp6pRp7
        ueNDcxkQgBl45XgUrhXYoowiQS+Kqw4=
X-Google-Smtp-Source: ANB0VdZNWoMQ2Aqm2+h5gADQxKMwqmhpOLj0teYdZ5lm4WXd2HCj6FXAXzGpwFHEbBoOb/4EaEvE3A==
X-Received: by 2002:a17:902:ba86:: with SMTP id k6-v6mr5410290pls.84.1537216809697;
        Mon, 17 Sep 2018 13:40:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g25-v6sm26858002pfd.23.2018.09.17.13.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 13:40:08 -0700 (PDT)
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
Subject: [PATCH v2 0/2] qcom: remove memcpy()ing from cmd-db driver
Date:   Mon, 17 Sep 2018 13:40:05 -0700
Message-Id: <20180917204007.250862-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some changes to the cmd-db code to not do any more copying
of memory. Instead, we'll just hand out pointers to things
inside cmd-db. 

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

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 34 +++++-----
 drivers/soc/qcom/cmd-db.c             | 93 +++++++++------------------
 include/soc/qcom/cmd-db.h             | 12 +---
 3 files changed, 49 insertions(+), 90 deletions(-)

-- 
Sent by a computer through tubes

