Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB9AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FA42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kg/F2SZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FA42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeH2Lx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:27 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43709 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbeH2LxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id h64-v6so3495680lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IW7gPFbp3Cs/xxYQ78q60NQhn2rxDLB3vVZCg9hJpfg=;
        b=kg/F2SZML7WBuqEBtFfwjdEToBm5pPLV9BztrAqylqmdk3608H21CbMLwoQecSARRo
         3g9Ru/ZUloD71YYuEuRhftTZN+/h8RBxWmYpgHqhZEfFkMkwUPrA2BbmfkkTTY8nKvtS
         9vFEHLKzSKFtI8XRgSWvs94KKe4zgxGHZe4Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IW7gPFbp3Cs/xxYQ78q60NQhn2rxDLB3vVZCg9hJpfg=;
        b=OHTfJHQUI+VMkzCIwMcfEkZL/gWqjoi2oeRMhdRmP4EHetAy2o38HxyT5RGHsrrTtZ
         jo56sQTQ8M7dEdV8LzzpLA9tE0cx3mD/RoKlr5A3S2fK7JMSMr5TnJzkFdY+g7DESuts
         XGDI1EBowWxGctAY9TIObcXiPFXS4SOWZkaghSXTIvdNlxtqLEridqEHg/Ec1DeMfUWT
         EGj8jt7SwMrFlEzt8RnzgZFK2bLGqiYJMU0RmoMWy9iy8QrKMOD/0LIQre5ME0IsAHgI
         oZ8q+adsHIF5qC5KbwuMSMx/BSlxCkHlS24DHUNIFW15KY4bMHP5qSZ5BL8zvmdNLIbd
         TY6g==
X-Gm-Message-State: APzg51BB232PEKa1cNZmn05BvgEmjCjyNZmr987/ZiG+U+t+38e6uLx9
        uVNwRxR0dB/dYcOYUGJTWFeU+Q==
X-Google-Smtp-Source: ANB0VdZ/cC6W4Xp+66vbp5HVH71U0+p4B3AeO9k3CxVSckczb+XCafn9/5rGGxQHKSgwKdILIYg4TQ==
X-Received: by 2002:a19:6d12:: with SMTP id i18-v6mr3370552lfc.72.1535529467079;
        Wed, 29 Aug 2018 00:57:47 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f7-v6sm613386lfc.4.2018.08.29.00.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:57:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/9] soc: qcom: smsm: Add select IRQ_DOMAIN
Date:   Wed, 29 Aug 2018 09:57:18 +0200
Message-Id: <20180829075724.9095-5-niklas.cassel@linaro.org>
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

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smsm.c: In function ‘smsm_inbound_entry’:
drivers/soc/qcom/smsm.c:411:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 6e063202ad0b..7da6e67c7ea1 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -143,6 +143,7 @@ config QCOM_SMSM
 	tristate "Qualcomm Shared Memory State Machine"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
-- 
2.17.1

