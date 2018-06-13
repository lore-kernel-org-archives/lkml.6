Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32621C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD110208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDrPK6Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD110208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935652AbeFMMza (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40630 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935602AbeFMMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so3775622lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6zw4wLJZVQHCaGthfXT2V4RF0fCTGlqbZ+/633hWcY=;
        b=LDrPK6LvZuOfCk+L00ewYep1TjE7J/hzkLkl+Ev9TTYzdal74wbRiKELMp9IuyMY0M
         D7NB9uJY3LkoulvlorFBzNK/BBm5iDYFQ7wO191AdXH76YCuhuP/harkXiJgQF7Jx8r6
         WoUITcsP4dCEOBIJ4Sssg+XoTLtKDaL4qFbNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6zw4wLJZVQHCaGthfXT2V4RF0fCTGlqbZ+/633hWcY=;
        b=X49pZ1rF38x2Y2WEa7kCYow5lYOR4+G0Kf2pP0F2nAGR8CxLIWLtQuqlvEhD6DYJoY
         xIRVC4COtf/z1QUugqkcfs1vGfdEtjS9qLIJpaf6ZhNyfNYRwTUAHBeaSs/GX99Icmh8
         KO4Hx2rlQlb2GqbRwKLckQhfGr2Y3NVCkkTEdyVIglo1fcyZu/bRMwqbj/HH77A3IoVn
         oTjuORYbs9/H7txk2XvCxEOYoWrDsC4w4fzPdO0u6NrrYdFQEmzCbZRxCyPC1VVBunyv
         gYuyOUM7tQteP5G5pKnjzv/j4neBpv6yZHH4pFdc9yR/UVSCmdcPWc5vEgojrVNaBokK
         6xqw==
X-Gm-Message-State: APt69E1Y/iK5s2nTg8IkEpcKp/XOMpiHIMRQ/uQ8+iB9Dmete0NYsZ4S
        OJF/PxF+JGcmvWRG1ULw9ecWfg==
X-Google-Smtp-Source: ADUXVKKHnOcV4GY9vloDWNzkNADIt128cXL/7Bh6ATOauh8Mbjmsu4x8ikwjPzYPmq3JNGfEuumXXQ==
X-Received: by 2002:a2e:9204:: with SMTP id k4-v6mr3088773ljg.144.1528894521763;
        Wed, 13 Jun 2018 05:55:21 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p5-v6sm526516ljh.3.2018.06.13.05.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:21 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] soc: qcom: smsm: Add select IRQ_DOMAIN
Date:   Wed, 13 Jun 2018 14:53:59 +0200
Message-Id: <20180613125401.11734-5-niklas.cassel@linaro.org>
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

Since we are using irq_domain_add_linear(), add a select on IRQ_DOMAIN.
This is needed in order to be able to remove the depends on ARCH_QCOM.

drivers/soc/qcom/smsm.c: In function ‘smsm_inbound_entry’:
drivers/soc/qcom/smsm.c:411:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2f59d0a835fd..1d4a9f3ada8c 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -115,6 +115,7 @@ config QCOM_SMSM
 	tristate "Qualcomm Shared Memory State Machine"
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
-- 
2.17.1

