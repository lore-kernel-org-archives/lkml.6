Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7210FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36D2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SSr737h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A36D2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeITXsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:48:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeITXsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:48:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so4731391pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iuMC2k3DstUrHPClZARrvqFXdDrwKM+94ZNyoBTy0E=;
        b=SSr737h8cqMU5tUEPaWEv2uFYFzrgFxKV1G3nkHtmN5zkamsSKSWl7hifXn0Vtm8kv
         93zKzok9w7b1uhju1JgfCOFYc3wzQyOM23TypGzBQ8cMRytj7VTJ+KZWhYFNAScgIETf
         Z1FzCXN6iPv4ykYYllQ+2Opduz9QN6++fTDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iuMC2k3DstUrHPClZARrvqFXdDrwKM+94ZNyoBTy0E=;
        b=AfKJwLrdG5spvwBFjQN7zSTqK1XQxKH6/4SRl9v+IxCsipk0HTBVa1KIr6kGSJzmeN
         EkEBvglbAcOyz4KPZWkmTMCkY7rN8BVoMepiTgFVBQDnM+Dy5o35BBFrm425yXHSri76
         4JUUaUwUXuAw33d5eTzjynP83NeE+DEAOA4xM5LKt4zJ8ou7R3gpMyF/A0Dtnj7g1YX4
         xR30jL7nLC/7KMRpMSnIutxyDd/A9BIo2ii/2Pqq32ijwXglL//jv+kpmI7C422ZTTCO
         4U0V+0qjpgFBPD/Z/eHSpWk9OPjbFjbBtzL6mNhwACVqsiMai1bQRuGhsHLKNeKIJ18O
         42jw==
X-Gm-Message-State: APzg51CoIsfQnbIf8c4ygWd/kNir9zoZgZ0yrxP649UCahfb+NdCoHiJ
        VF50V4LrtQml0lvv/aQ6xH1WNw==
X-Google-Smtp-Source: ANB0VdY1+7lFE7CKDj5sinazbLn1XfKTr39/35/Xi1AcZpN5t7qHvkThsRU9GSnfRDDrjkdjvP34jA==
X-Received: by 2002:a63:e855:: with SMTP id a21-v6mr769654pgk.4.1537466605836;
        Thu, 20 Sep 2018 11:03:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id h124-v6sm2941874pfg.112.2018.09.20.11.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:03:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH v2 0/2] Fix qcom geni i2c DMA handling
Date:   Thu, 20 Sep 2018 11:03:21 -0700
Message-Id: <20180920180323.217377-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom GENI I2C driver fails DMA sometimes when things
from request firmware are passed in as the message buffer.
This patch series fixes that problem in the first patch
and the second patch cleans up the code a little to reduce
lines and simplify lines.

Changes from v1:
 * Use i2c helpers to map buffers
 * New patch 2 to clean up seriously indented code

Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: Sagar Dharia <sdharia@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>

Stephen Boyd (2):
  i2c: i2c-qcom-geni: Properly handle DMA safe buffers
  i2c: i2c-qcom-geni: Simplify tx/rx functions

 drivers/i2c/busses/i2c-qcom-geni.c | 68 +++++++++++++++++-------------
 1 file changed, 39 insertions(+), 29 deletions(-)

-- 
Sent by a computer through tubes

