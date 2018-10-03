Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491032098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuWqAz0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491032098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJDAnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:43:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51202 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDAnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:43:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so6550470wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iNOLio4kSRLlE6Dc0TrcT0mx7y+MdMk4FvEcL5Mj3E=;
        b=HuWqAz0NbPP52rLjzFKcr//yiFCJ4R/2xbH4mCBx4oVxaPj+3F76KVe1kat0C/olLY
         dm7WJacfdySFdP6kqktspBovdDWfgZ9Ja7adSCxF4i2YkRGGaRxy+taz5vkv6Udc1ySp
         TzR35povqS3Rjqa4Kxmm1vFywsYgpjZ9l6LQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9iNOLio4kSRLlE6Dc0TrcT0mx7y+MdMk4FvEcL5Mj3E=;
        b=qtoewJJafoZxC6P6Zrn4UWJc3cTH+0VlURCdIqRul0zVdTbHMajAgKhZNuKRDJAjbr
         glVcK41nj42pHsRIR2v6C8urMq3dv1DvoWnrVzHneEH+fo7/KVrHrYo+Wn35urWuorx6
         Oo1sm0QywRmdx3QpCFYceRdG5okxij5SF9h+Jgmud3fHLqzW+RHoNiJY0sdbKcwm5RYu
         u4nNAGwqDrPKAPLzI7YMdvNhdLhArxQsEZbMdRQFY25scMaaxiTg2i9xRvR30FOBcaAc
         koRwC10tE7Y6tSOeDfaI3ZQQa8bG5kun2lOCACgbJqwFsbT2C4OshMMbbcGWH2BxPkWq
         ueLw==
X-Gm-Message-State: ABuFfohoeoZEbeaK46OSwT4iuSvgdjfs0NVJ5WPxT1bx4Rqsk+iZ3szk
        f+UEzoZ/yvBWGRQFlVvH7p/uQgGoHB4=
X-Google-Smtp-Source: ACcGV62MW3f4h/dOcKhUiqz1r3vBqiKcfpYRo7Ntn+zrXFc1tXBkuMCAlimH4V/2QBxs86GKa/zGfw==
X-Received: by 2002:a7b:c151:: with SMTP id z17-v6mr2382254wmi.39.1538589228390;
        Wed, 03 Oct 2018 10:53:48 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id q17-v6sm507971wrw.19.2018.10.03.10.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 10:53:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: ngd: QCOM_QMI_HELPERS has to be selected
Date:   Wed,  3 Oct 2018 18:52:36 +0100
Message-Id: <20181003175236.20039-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

QCOM_QMI_HELPERS is a hidden kconfig, so the proper usage is
to select it, not depend upon it.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 9d73ad806698..9cca2c3559f2 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,8 +22,8 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on QCOM_QMI_HELPERS
 	depends on HAS_IOMEM && DMA_ENGINE
+	select QCOM_QMI_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
-- 
2.19.0

