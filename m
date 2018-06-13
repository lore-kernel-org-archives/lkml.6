Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D6A3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9tLhdBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0496B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935637AbeFMMz2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34060 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935406AbeFMMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id o9-v6so3799785lfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3hIKntiQ7FDruQIk4s8cWntlo1jMsbA4iHu4PLiEgM=;
        b=g9tLhdBd1l+7JBG7DkLppCbmZJKyku7LaY2n5CVFt5xC7ojDuDOrDHoYAfgYCN24HP
         N/4YWouaUlXTqsToy/8fEYQtySRHJ1ULj6oK2mKVCteXE7DwweSE0ATA812TGi3tU4BQ
         q/BrJAuEeyee+ATKGVuXUKf2g3mkdYkEdGa4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3hIKntiQ7FDruQIk4s8cWntlo1jMsbA4iHu4PLiEgM=;
        b=CTLkrNGBbO/m/IwDkdf5xrnW40XuL2E7rB8RJ0sUc6Rw6ZjYE5Wd51VuYlV0qlg+3K
         gI8Ppg7tkU5vQfYT4dk7c1OogGtxkdJxMIMlYM2oMUlxw53vdVOXtlFEsAW/gRhvjCJU
         wbpg6FWEGsGvCpdnuvF+aumnh1oh15HYuoK+vS6kyYRpDrlxAqAMqzpbCgKELn7ZO9N7
         dbTUcSdAqOWcotxvCQI6xxIZ4HWaI/ZVkVdrZxAUVr43YvsqndzENuSMqwS8VN7pQipQ
         oECqOh+p/9zP51FVoqnJvR2wJzn+43KXqQ/EX1poXhJPazewUZwazSeMvJL042sPaV2K
         bvWQ==
X-Gm-Message-State: APt69E1MRjXc88fQK5DxMuf9lP7iN1AzT/gDuKYN2zEIrBqogn+xwZQd
        7ZRifm/1yxTMKZ6ndnVRTIoY0Q==
X-Google-Smtp-Source: ADUXVKKftfZL/7OCbyLVRLzBKSZ60yqN2yVwWtsCDx8eN5siEoOGFtPF01Cw/bMsgdh1OB9j88sj0Q==
X-Received: by 2002:a2e:994f:: with SMTP id r15-v6mr3030329ljj.53.1528894504982;
        Wed, 13 Jun 2018 05:55:04 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o9-v6sm580840lfk.2.2018.06.13.05.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:04 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] soc: qcom: smem: Add missing include of sizes.h
Date:   Wed, 13 Jun 2018 14:53:57 +0200
Message-Id: <20180613125401.11734-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180613125401.11734-1-niklas.cassel@linaro.org>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
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

