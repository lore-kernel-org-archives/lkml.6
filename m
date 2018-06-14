Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 017D8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE71208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZi1xLld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE71208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935738AbeFNLMo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:12:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39617 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755054AbeFNLM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:29 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so2385118lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3hIKntiQ7FDruQIk4s8cWntlo1jMsbA4iHu4PLiEgM=;
        b=BZi1xLldOjen7x71n42Mu01gBpg08m/LLjyFiWU7BurlSdYSSD3jq76N7Dw6lSKGHv
         tM490ojGW+ynTbcX4eKQvv9LbVJREqX5crCTQ4VIz3voryanuuQ8BKiF8ED+Bi2NbRhF
         t57U08GGAZot/7YRzygK+Xg9tPnZ+xdkV5o6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3hIKntiQ7FDruQIk4s8cWntlo1jMsbA4iHu4PLiEgM=;
        b=Lpd0S/IWPVa7KAb9KTXUrtA8JFRmdHY4fXstQWPW6AEFdx71v+5Jcq5HlVp2pXm69h
         aWFi3FJaGDgy/9J9aM8mWO3dmR/6CNiSoG2dwvBxd5UmEJwvvGUvnqyAz4IqlOQu1LuW
         y7weR/JGLJVMvWofh2GRKnLF6OlMD3oXKk8NgDmFWk4XDSL0Iuha+c50+NV6PbbHG5xx
         GSeQP0S5zCx18cJjejpsuiL7IdXONcJbnLomx3f+kBc+VRirz2AnSOoHNWcLMXbrQF7L
         Domc7Lul2TsK+oTC6mftUYTwRJH8mOq70091NSxnEAhdcS+4DzXmQ2pbLi/DLsGqkWBs
         1pMg==
X-Gm-Message-State: APt69E3SHvD6V/gTrjve8oKfRL/DtdkyczgppJh7qUhUWvseOrLjluba
        MbpNJi5b0o8hnyTz0/LIZhj8niq/fkY=
X-Google-Smtp-Source: ADUXVKLRzCNGdebLl9lu8wiXToUBCm0YD0g9z0itQKmAA9PApcgefvwXb1JkqXY21tjXtoWh2OVbxA==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24-v6mr1508867ljj.141.1528974747989;
        Thu, 14 Jun 2018 04:12:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j103-v6sm1029550lfi.58.2018.06.14.04.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:27 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] soc: qcom: smem: Add missing include of sizes.h
Date:   Thu, 14 Jun 2018 13:11:33 +0200
Message-Id: <20180614111138.8923-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h

drivers/soc/qcom/smem.c: In function ‘qcom_smem_get_ptable’:
drivers/soc/qcom/smem.c:666:64: error: ‘SZ_4K’ undeclared (first use in this function)
  ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
                                                                ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/smem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 70b2ee80d6bd..0fcf60e8269c 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
-- 
2.17.1

