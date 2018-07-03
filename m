Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3236FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12E4224FD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5SpDTjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12E4224FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeGCHU6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:20:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40999 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeGCHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:20:53 -0400
Received: by mail-lf0-f65.google.com with SMTP id y127-v6so736094lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLLGwu+g4ALeO8P3prQgQDSV2DBmz+K7UKHODB0ua9o=;
        b=G5SpDTjNrS/Kq297PxbAWVDegit0Yr8Y8qesm9onbcer+r9xVbMea2Cs968OuzH4e2
         3EgE/Hzn2MtbW8r+Xlann6BNPCBHZHICaxu+qViEmb/ZjCWFgKAKVZeVcs0zEV57mvEW
         3KGU25zSNW89Yat8p4Dgk9pZMDP5Z9lao/rZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLLGwu+g4ALeO8P3prQgQDSV2DBmz+K7UKHODB0ua9o=;
        b=hsYVzEUjRoGQDHTIZnHhJevRudEAp4fOG6nTSnQ7G2d9feuMAPgvz484TaMQKIDkBi
         XovoN+zBfV1S7HnX5VwPdc8dexi3mD0ci5McZ7R5RDwMxo1Cu0ZR/fXDq0qzZsVkXe72
         bR2LNVOfsQr1ky0dLAxVJOQcsqa/LJDByXcOQNKk90si0dv4L7rsif4lGiTdTT6bvyhR
         WWielTdHLXwgKptnef+3TkoOLI+ceSZineCSEW3NHBcqVxDMv2q8iMo9cDU5pliw259V
         ksuBEoFTNI42TVKcPR4npOOmH9bmb8c12/uFzCgAXw8j1CjoyoL23rozpZvj1TPURyXC
         U9jw==
X-Gm-Message-State: APt69E2/9/22FQv+7YhtImFu6RCuSOhnVqmmzYNeB8aPgS6Pu8KZOYhO
        lenpBxqPo324+yDm9NCpXFSRvQ==
X-Google-Smtp-Source: AAOMgpeapMivp1k+aTdTQ+/NG+zbK7n82b2DijzJN5S+BbZCn8P2fT6227yw77Krc8Z/mnsE5DCcaw==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr19786329lfj.47.1530602451648;
        Tue, 03 Jul 2018 00:20:51 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 10-v6sm65125ljh.91.2018.07.03.00.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:20:51 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] soc: qcom: llcc-slice: Add missing include of sizes.h
Date:   Tue,  3 Jul 2018 09:20:29 +0200
Message-Id: <20180703072034.20213-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703072034.20213-1-niklas.cassel@linaro.org>
References: <20180703072034.20213-1-niklas.cassel@linaro.org>
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

