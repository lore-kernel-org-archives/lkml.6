Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D0F20858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8rNU01u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D0F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeH0PWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:22:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37208 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH0PWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:22:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so12052182ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h90+3ReY06e+iLNerRK9K1XsVHAVsoADC481ssK4+Co=;
        b=j8rNU01ujl9hYtNsMEWK2gbZLyGFHvptyc6PL4QfD3czbdEMF47Cvdo7LPrQqvSKCN
         BKSIB07fazZGV1Br2UryhZ7aTanKARHIy4lWDT/p4ex8GBa/0zixsa2LQE2Ea2KUQQuW
         X6qGs+uiTaMVo7+i+c6S+4fnSD0v94fWF3oo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h90+3ReY06e+iLNerRK9K1XsVHAVsoADC481ssK4+Co=;
        b=lzEuL4M+pYIJ4+PpaBkDjuP+vSrly28yIk0cximjffdpPpa6N6hqALUYueX1ZUTV4r
         GcBDIczPDrWmD4j4w+WEE7N7XV365IaWXMkPMvp5p2oY9rsqbVtelTRpP8knQ9L2qNUw
         qPksVEdBNOuH4wpfSzN+P/JAPFAXSEnHMWcCbBxs/Rs4XpjDXUPPBuKJEspHOPRpT0QT
         Hu60QFh/U8tDlUXKxckQSLODKw3yaIrNyx6k/wi92OxDbvMGdadQ2Wnao+QxvAHdD3Yz
         VRUFCGv5YJTevdpduELmATBSF3UkVSA5RqIgkRGC+CFdJkUqz6eQdmGPROCo/6ytduXk
         z80w==
X-Gm-Message-State: APzg51AhN8TQKALi6FWYWsYwQwtzEeOMye2mvHDuWl5xzRlswKhmS3JV
        yaWJIJ2IjS5f1u9DkZV4RpNdpg==
X-Google-Smtp-Source: ANB0VdZo4wKJcipB23hvnpu9zjqRshfW+LUEaQCUpjtUL80B+uDc2z69nsKbRNDNc41ZV++xbYr9Rg==
X-Received: by 2002:a2e:650e:: with SMTP id z14-v6mr7958371ljb.62.1535369788605;
        Mon, 27 Aug 2018 04:36:28 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z15-v6sm2737503lji.58.2018.08.27.04.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 04:36:28 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] soc: qcom: smem: Add missing include of sizes.h
Date:   Mon, 27 Aug 2018 13:35:59 +0200
Message-Id: <20180827113605.9594-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827113605.9594-1-niklas.cassel@linaro.org>
References: <20180827113605.9594-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/soc/qcom/smem.c: In function ‘qcom_smem_get_ptable’:
drivers/soc/qcom/smem.c:666:64: error: ‘SZ_4K’ undeclared
  ptable = smem->regions[0].virt_base + smem->regions[0].size - SZ_4K;
                                                                ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/smem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index bf4bd71ab53f..b77573eed596 100644
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

