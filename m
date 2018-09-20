Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF91821531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIBq0hO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF91821531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbeIUBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35642 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbeIUBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so4828867pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Yn6k8iXxmXjg2p667vERDiX53KSRwgK7zCH4SYjx4c=;
        b=ZIBq0hO3k6jJ9iQxF/V/q132iDTpYOB7S85BlqYaN1fKVd3tGJVlgG8opi3g4V0HWs
         UkMk2bxHU20TN5JRpnfK0MKi1CN8kv87fqciquRcDXLErSfmYLaoo95O1QXk/5/Otcnt
         dNa26dR9Stm9XblK1KX0CLwdsbtryvrB7BRBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Yn6k8iXxmXjg2p667vERDiX53KSRwgK7zCH4SYjx4c=;
        b=qDNruTo8oBXGi5SeCz/xqq3PQzGzjzvEGTAXFju8suKML4ZaU52Lv3MdNJCHSiActd
         q505SmxR9q3KMxwoCDHdQ8CORY845Yk/BLo+jATSSxvUJg+nuD0XMbVlxvgbbEUOjggB
         EPD3+lnIryQ+0nF+s8zlUCdOOhQ7CMufNRAoT77uAXs2dZf/HxrIHftUfJilQA9o5vYC
         nDpNF14naaPy2DJfdpqdDrpxOh0MWNe7PWubAdMEVevVIln3Y2NJkng4+puPrbRh2/G2
         hV/Xopv500eWTYICbNKAzFvgfIsGn+XQVDcHRu31HaLsiSZFMV4sgyS2ijPO/DlJQ1Lt
         7Axg==
X-Gm-Message-State: APzg51CW7QWUuMJrl5lZcOCl8yod5Wa/DvDZkjwnKO6iCJX4HDL5+fhG
        5Ihi3MoiW6HlFOT/zHATGAX31g==
X-Google-Smtp-Source: ANB0VdbUiYgCRrNYJe0TlqPSPx4xDiJTmEowofmriD2ojjJ6A0pnWAqYcyNKnHptAKvq7B9V5iwhWw==
X-Received: by 2002:a63:3741:: with SMTP id g1-v6mr6568297pgn.59.1537471140124;
        Thu, 20 Sep 2018 12:19:00 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:58 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 25/44] coresight: etm4x: Configure EL2 exception level when kernel is running in HYP
Date:   Thu, 20 Sep 2018 13:18:00 -0600
Message-Id: <1537471099-19781-26-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Nowicki <tnowicki@caviumnetworks.com>

For non-VHE systems host kernel runs at EL1 and jumps to EL2 whenever
hypervisor code should be executed. In this case ETM4x driver must
restrict configuration to EL1 when it setups kernel tracing.
However, there is no separate hypervisor privilege level when VHE
is enabled, the host kernel runs at EL2.

This patch fixes configuration of TRCACATRn register for VHE systems
so that ETM_EXLEVEL_NS_HYP bit is used instead of ETM_EXLEVEL_NS_OS
to on/off kernel tracing. At the same time, it moves common code
to new helper.

Signed-off-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 40 +++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index c1dcc7c289a5..b7379e9cfb30 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <asm/sections.h>
 #include <asm/local.h>
+#include <asm/virt.h>
 
 #include "coresight-etm4x.h"
 #include "coresight-etm-perf.h"
@@ -605,7 +606,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->vinst_ctrl |= BIT(0);
 }
 
-static u64 etm4_get_access_type(struct etmv4_config *config)
+static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 {
 	u64 access_type = 0;
 
@@ -616,17 +617,26 @@ static u64 etm4_get_access_type(struct etmv4_config *config)
 	 *   Bit[13] Exception level 1 - OS
 	 *   Bit[14] Exception level 2 - Hypervisor
 	 *   Bit[15] Never implemented
-	 *
-	 * Always stay away from hypervisor mode.
 	 */
-	access_type = ETM_EXLEVEL_NS_HYP;
-
-	if (config->mode & ETM_MODE_EXCL_KERN)
-		access_type |= ETM_EXLEVEL_NS_OS;
+	if (!is_kernel_in_hyp_mode()) {
+		/* Stay away from hypervisor mode for non-VHE */
+		access_type =  ETM_EXLEVEL_NS_HYP;
+		if (config->mode & ETM_MODE_EXCL_KERN)
+			access_type |= ETM_EXLEVEL_NS_OS;
+	} else if (config->mode & ETM_MODE_EXCL_KERN) {
+		access_type = ETM_EXLEVEL_NS_HYP;
+	}
 
 	if (config->mode & ETM_MODE_EXCL_USER)
 		access_type |= ETM_EXLEVEL_NS_APP;
 
+	return access_type;
+}
+
+static u64 etm4_get_access_type(struct etmv4_config *config)
+{
+	u64 access_type = etm4_get_ns_access_type(config);
+
 	/*
 	 * EXLEVEL_S, bits[11:8], don't trace anything happening
 	 * in secure state.
@@ -880,20 +890,10 @@ void etm4_config_trace_mode(struct etmv4_config *config)
 
 	addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
 	/* clear default config */
-	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
+	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
+		      ETM_EXLEVEL_NS_HYP);
 
-	/*
-	 * EXLEVEL_NS, bits[15:12]
-	 * The Exception levels are:
-	 *   Bit[12] Exception level 0 - Application
-	 *   Bit[13] Exception level 1 - OS
-	 *   Bit[14] Exception level 2 - Hypervisor
-	 *   Bit[15] Never implemented
-	 */
-	if (mode & ETM_MODE_EXCL_KERN)
-		addr_acc |= ETM_EXLEVEL_NS_OS;
-	else
-		addr_acc |= ETM_EXLEVEL_NS_APP;
+	addr_acc |= etm4_get_ns_access_type(config);
 
 	config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
 	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
-- 
2.7.4

