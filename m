Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1284ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC082084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZMaawKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC082084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeGRUs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:48:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbeGRUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:48:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so2481561pgr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=MZMaawKRFu+jcuqGYSzB65k9bLSbz2qG17JXlgci38r1YrpqgR4cvBZkFSpQO2qVPJ
         rcZT4yxeNRfN2LDqfcl85XHbaP+AL8S/6Av6PbAbMQszy5i8Xn90jSbjQ03tsPWBVtuq
         1TD0We3A/0Fu9DOD8+B1wjX2R1CGvHyiFEmEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=qPOTVQxShTF3tU9/cgJm/NDD75ezCOTOYlK4MAYZIn4NQ6yd4vqkSHdBlN4mEHlkxE
         hhkzSoCBAXWkYL+qwx01yr4zPPOsDhS5JxUX33gJmq95yBJJPB+ozRp5H569qCbumloj
         44dT+EPpByP67Iptrh7iPHl+zWtoi0nzLBVnQBDW6nwXz0P0l3cRl3hitPURfCa53yQI
         2dpvoI188b0tSF2iV9FumrvHfYLMRoVjCbMTzF52+V24h3NwrEDCnRC1/WyZ/LiGIh7V
         uEjtvNyXvVTyHc7nZxUxthbatcglhS0HEXChEEdsw+qceBuje1Xd5Bu9OxC8iPRVZ+29
         y7Zg==
X-Gm-Message-State: AOUpUlGk12jKRrel3PUpStCIm8a1eIar5EchS4yHTu8ajrMj3fYHm5Wh
        4IiqFOYvRFRJ/rd/rqwoWpM2
X-Google-Smtp-Source: AAOMgpcG9ELMy6fz5H9jISR2+ukTRcIzPabZ22guskxxCEgl3l8hOnBO2bQTsKHOx6kEP+9+XGKSlw==
X-Received: by 2002:a63:c50c:: with SMTP id f12-v6mr6954441pgd.88.1531944567049;
        Wed, 18 Jul 2018 13:09:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628d:5c0b:b467:58cc:4c91:39b3])
        by smtp.gmail.com with ESMTPSA id c7-v6sm6924697pfh.25.2018.07.18.13.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 13:09:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver
Date:   Thu, 19 Jul 2018 01:37:09 +0530
Message-Id: <20180718200709.27102-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
References: <20180718200709.27102-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semi Owl SoCs DMA driver under ARM/ACTIONS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b54e9ebc6f..56d9c7715c2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1145,12 +1145,14 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/dma/owl-dma.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

