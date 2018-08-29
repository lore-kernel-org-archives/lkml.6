Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9E1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A922086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mq0Ewk/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A922086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeH2LxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43685 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2LxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id h64-v6so3495057lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=me8/a8IQyU0522obqv5m6glMpeNSmc8yqidyogcAdvg=;
        b=Mq0Ewk/k9dvIWJCv70o4LxMdJBhP8q3S9j7CnrrXiROMkWok71hmVXr1JNITV/ba4Q
         ooKUcuDLW/1lQ/nSYybGtGvNC+yC8Sqf0B14Xj3KYg0KHxhhpEzDrOhEEpz1FIaeG6uK
         nerGN1WPXhS9RCVtJh5i9PKQpEFLY1z/JaYtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=me8/a8IQyU0522obqv5m6glMpeNSmc8yqidyogcAdvg=;
        b=khH1a9K/mjdotMBphf3ztTLUTiK7uM8oitMSamWAfVLgyiWtibgeoDEOAySzDzeatH
         5yZRPEXQ1i+4Nra7XWYw6HUdEz26dxdiDjeF7J1x7EI0kSgLVZweIAw/wkbAVXPvY+x9
         4WCRsfJTnKrRbpJWn3pE2IzeW98HjpGQ31+4xenk/RlEuGSZvJd+5GVeC/jgw+ixQ4St
         dQb9tcy8HwiZ0M1xL/0Vg1UcctwZxVymmBFgmJubZxfPISZ26igxTqAEsNJkUJymklw4
         Jcd3NYR+Bfq74SDlD9JJ14HRXblIZ1fUe/xxOwA/zyajB4EmLAiC/vYhTMg4iylMPf4d
         rZHw==
X-Gm-Message-State: APzg51ADWrbNvAcSrkqSPbCkaQrwKORQLEGHoj+20Wk86GA2qlu8p5b6
        Posv37y+/irtCpwL4BdnNCO4dg==
X-Google-Smtp-Source: ANB0VdZ8QTcFr7BFaUR/ArD8yzwAOuNp4d77mFxx4KunAFpRR+NgkOW2ZJyQBVwzeH/deIZZ45ArlA==
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr3598774lfa.80.1535529450033;
        Wed, 29 Aug 2018 00:57:30 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u19-v6sm596232lje.51.2018.08.29.00.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:29 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/9] soc: qcom: llcc-slice: Add missing include of sizes.h
Date:   Wed, 29 Aug 2018 09:57:16 +0200
Message-Id: <20180829075724.9095-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/soc/qcom/llcc-slice.c: In function ‘llcc_update_act_ctrl’:
drivers/soc/qcom/llcc-slice.c:41:44: error: ‘SZ_4K’ undeclared
 #define LLCC_TRP_ACT_CTRLn(n)         (n * SZ_4K)
                                            ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/llcc-slice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index 54063a31132f..344dc2daf431 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/llcc-qcom.h>
 
-- 
2.17.1

