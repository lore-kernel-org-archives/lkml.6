Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D143C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521B52086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMndRC3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521B52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeFKVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:10:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34852 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeFKVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:10:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so10353518pge.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2VwEAe1pf0rMRMJgdY74rfx9E+D+i3REtmu39k2M5A=;
        b=gMndRC3EeS+K7FW7WSh2RuIHBTnzbs5LsCrmLp5UA4cB+KxlsPBQqVO45DHTpcqI/1
         vGnUVf5TNsWcZHqUVud01sRPEQqIfO/WVtUYn2KY22RbVz9EmKUXjD6y8a27S9njJ3Qn
         Q5mcnxfPrkxGer2VgzWjksxM8rRx39bRktcPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2VwEAe1pf0rMRMJgdY74rfx9E+D+i3REtmu39k2M5A=;
        b=ZwYwpaxrmGueRm+T4HvSjAkfsgoKBU/oEzquwkBozOqLcHNoK5kGIaKpBkXRGb+kMn
         Ff3iPfHq/YAiIrm6wseKokGzeVwWBfkS5FLusmCYYPN/ED5QAuFGTvcccZq5JF6x5RQA
         O70yHSTDrwvkU5zAsAMPjrFVqmBSL35OLWVEBE4kxzFzjT8kb93f6CJo5hdAMm/UQF9V
         WvcQvI+rzFWl1f4OoeD6cLYl0LypwyIDu+hTKlpg6qhJGY9XT4ZY0h0WWHV9SrWSVBZl
         Bh0GYN8pMD8WvomEy9szdSjaoO2HekjWAOIwirypLLR2pHTbWzQEI770ZDnYZS97W1p5
         wm8A==
X-Gm-Message-State: APt69E0DlBCI81HIPiUKKj/L1tDlCXFweYIeLLcmOZebJBAXBkIAT9m3
        HHAtNI7qmjwfGcVIdJPStXxKGg==
X-Google-Smtp-Source: ADUXVKLhwNE4NMb8YOyuyr5TpmUaw1vhiC69lI6rvqCuldfibfhaFDPma757kbKbMog4jOvKwwYx+g==
X-Received: by 2002:a62:9f16:: with SMTP id g22-v6mr731937pfe.207.1528751403176;
        Mon, 11 Jun 2018 14:10:03 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id c4-v6sm49116184pfe.53.2018.06.11.14.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:10:02 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/4] ath10k: snoc: drop unused WCN3990_CE_ATTR_FLAGS
Date:   Mon, 11 Jun 2018 14:09:45 -0700
Message-Id: <20180611210946.241341-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180611210946.241341-1-briannorris@chromium.org>
References: <20180611210946.241341-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We started using a common CE_ATTR_FLAGS definition, so drop this one.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index c7cfc9c9b3d7..61967c2966e6 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
-#define  WCN3990_CE_ATTR_FLAGS 0
+
 #define ATH10K_SNOC_RX_POST_RETRY_MS 50
 #define CE_POLL_PIPE 4
 
-- 
2.18.0.rc1.242.g61856ae69a-goog

