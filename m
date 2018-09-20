Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965B521534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bz+W0Kbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965B521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbeIUBED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45868 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbeIUBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so4778260pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZmIfhLlS7No2zlitXufekMnQETwoKFvLJIWVS3LdmXc=;
        b=bz+W0KbrReWypHhIqQ3ztUzSPz/Uo+ksBhPwRSyA3LU8ELb0UeBjTMIIYCERFWgp4d
         WdWjfRTwe+RKB32HQ2nppIFK69vmgEDndKq9ozst/cj3pNWtn8xq57/49xeqNnsonLPh
         PxtUgWHBFqqXIXGjWo0RsuNMzRNfAsof3AR58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZmIfhLlS7No2zlitXufekMnQETwoKFvLJIWVS3LdmXc=;
        b=EP6H40kSAwcWipikGdKcywjNgA2zprJAT68GcOANN8/o8pvJkWuPbe0Kee1mF/lo/6
         GVDeFydwVJc6vRjzBYQxPDiVXQjHdXhZSiG7i1KsY2RSo73MOYtOOg/YRbbkWPnGlwu8
         wjKh17iYbOB7nu3Mavol+Aqklry949o2v0vOb3FvYiDcgHa+va3YkkIeOAXP7V5Aq8/i
         JU+lyogLidJRTgHqvGA5ShGMwkNg1I6I349+fG4lk6J09+UsoBWYBkTaqogU+k0APmzX
         K+WTh/zkea0SKfuCJ5kHHTfIMPD8+R7gAtzQTFKsRY+Z0i4PAiFAurTf+WuQ8TYmug/v
         Ax6A==
X-Gm-Message-State: APzg51CQQV4Ywwepb4l7zh4kt/gkeizyt9MiUB9fZl90e6rUe7KAC2Jp
        GBFAai//SS4chWekttjLHuGCTA==
X-Google-Smtp-Source: ANB0Vda/ehKHeK4pjRTtWHFOKq7n31ukLNO2pcQB4O6tWUA7jhN5/uCARYAo2ukCBGpeN0SdbL3QDw==
X-Received: by 2002:a17:902:7291:: with SMTP id d17-v6mr5753867pll.260.1537471143540;
        Thu, 20 Sep 2018 12:19:03 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 27/44] coresight: tmc: Fix byte-address alignment for RRP
Date:   Thu, 20 Sep 2018 13:18:02 -0600
Message-Id: <1537471099-19781-28-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

From the comment in the code, it claims the requirement for byte-address
alignment for RRP register: 'for 32-bit, 64-bit and 128-bit wide trace
memory, the four LSBs must be 0s. For 256-bit wide trace memory, the
five LSBs must be 0s'.  This isn't consistent with the program, the
program sets five LSBs as zeros for 32/64/128-bit wide trace memory and
set six LSBs zeros for 256-bit wide trace memory.

After checking with the CoreSight Trace Memory Controller technical
reference manual (ARM DDI 0461B, section 3.3.4 RAM Read Pointer
Register), it proves the comment is right and the program does wrong
setting.

This patch fixes byte-address alignment for RRP by following correct
definition in the technical reference manual.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4bf3bfd7c078..b54a3db13fee 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -417,10 +417,10 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		case TMC_MEM_INTF_WIDTH_32BITS:
 		case TMC_MEM_INTF_WIDTH_64BITS:
 		case TMC_MEM_INTF_WIDTH_128BITS:
-			mask = GENMASK(31, 5);
+			mask = GENMASK(31, 4);
 			break;
 		case TMC_MEM_INTF_WIDTH_256BITS:
-			mask = GENMASK(31, 6);
+			mask = GENMASK(31, 5);
 			break;
 		}
 
-- 
2.7.4

