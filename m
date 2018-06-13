Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9058EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4722D204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zk5r2XLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4722D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935622AbeFMMz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43347 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935477AbeFMMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so3762551lfn.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se/RkAuYKxDvATwaOKEGCpzfV6DWJrCjLhv0y8/exhc=;
        b=Zk5r2XLfZjkVNVcbo3LkqinNbATgB+fhNujuv5YoQFtwvqThdsZ0wP7QmAylktFPT3
         KVpZ5TEhh1SNGqjX7dB+Cuy82eEizdAuqUV2dgnuZEMrniWOQbxXdGKr1rrMna5wELov
         kHuYiakvRPI/ODRObLBWmSkecM9Bsn9VGUNes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se/RkAuYKxDvATwaOKEGCpzfV6DWJrCjLhv0y8/exhc=;
        b=g60c4Hq1FmP2rcos3PpNj8V5Xv22+8/qH2W3oJI9KSR+7vvJmhNk8ljVNwQoQnvBod
         4JvY5Cx2R6l4BqIFTZIzPafmIn5IHkv4Ar8P1/ePtcCwP4fd3j+Vmq2Dycy/pGhD0Gyj
         PUAcc+4bn96QULDgJUa4/ti/pABRqkAQ897uTn2nsm3kFJEWTMdPvG3dfALQXgpdzk16
         JgtKdkQydOW6yAC1KY52nwB4yNBKhzKIlhm5MzzN4ImvQr0bTwtnwAM1WoDHlBSGujwI
         MDLUTIbu1BpHEUODqFs2W/fOr28ilzc233kUAnLzSVgr5/EPMagFJh+Z6zUGmUksMtwK
         ZHDg==
X-Gm-Message-State: APt69E1i8WN5NZzmwuCOS4ihhFGRC7Dfrp6KhBW3lmj42AdLCA8lJyEN
        FpWmAnJvsYGqLdqdbJFrzfl8ww==
X-Google-Smtp-Source: ADUXVKIfl+f2U5G8CWSsT4pzy8lqUcm+b5Pj0AExNQ96Kr7QTT7OjDNqJg6Zrl9pUExVPXvkpa16rw==
X-Received: by 2002:a2e:6a07:: with SMTP id f7-v6mr2986086ljc.109.1528894520611;
        Wed, 13 Jun 2018 05:55:20 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id p5-v6sm526516ljh.3.2018.06.13.05.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:20 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] soc: qcom: smp2p: Add select IRQ_DOMAIN
Date:   Wed, 13 Jun 2018 14:53:58 +0200
Message-Id: <20180613125401.11734-4-niklas.cassel@linaro.org>
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

drivers/soc/qcom/smp2p.c: In function ‘qcom_smp2p_inbound_entry’:
drivers/soc/qcom/smp2p.c:317:18: error: implicit declaration of function
  ‘irq_domain_add_linear’
  entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
                  ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9dc02f390ba3..2f59d0a835fd 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -106,6 +106,7 @@ config QCOM_SMP2P
 	depends on MAILBOX
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
+	select IRQ_DOMAIN
 	help
 	  Say yes here to support the Qualcomm Shared Memory Point to Point
 	  protocol.
-- 
2.17.1

