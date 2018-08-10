Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD0C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6494A223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QyQ+jWbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6494A223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHKCLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 22:11:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40929 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKCLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 22:11:55 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so4628487plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHkDb6qaKxPT3RKCwWTlK162HxGfwzC3DwW8Inu+HKk=;
        b=QyQ+jWboymP+kH1M8h+mDOk+EuHT0IQANJmMmzwTKJaJ3fxH9ag4EqOiXcQTc7aSbR
         pi46WirGbtb8a+6eOORZ5bcUys6xC0xqbUMxfGT6grh8RhSrAvUR6QdfLUEB+ysUrOk/
         QPU9J+NCJ3jnXpAOuEqa2FbRfolJCNTcIsZmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHkDb6qaKxPT3RKCwWTlK162HxGfwzC3DwW8Inu+HKk=;
        b=ORqAMzDhJS5p3+78vTOipn4tJg9e1DrTvIgbsCGEucWZjA9qg9tSwzZu1vNSLhqAh7
         xykrOoZ1E8LFV0M65c880SYAdqxaWK/JMamx7HG5YcLfnUvJULY3DRhcULPWy3CPeUrp
         GzX3hqbsEnbdbW2juFqq2FmC3w3bD5BD8crfl8uUOlXeXBCfYD74bURFQzBDfYnMw/eZ
         Q+Qiz7oMA9IpIv14cHduJwyl6iOpbpgiudrUMo+UlrYY3rgbg+Yscktnh/f+K6lRWG+7
         uWFNK+vznofoD50jHgS/ZGrZ1qZ+vLkGWxLf5SiDvylOdKAvMtCa+fism3BzTHjNAKel
         6JNQ==
X-Gm-Message-State: AOUpUlEKsGA0+jM/9p7dNOrwCnymx43EMjCDFgedeGB6cUJCdOeW6GPE
        /pDogCx6tY8YKVO/1xJnxnCq1g==
X-Google-Smtp-Source: AA+uWPwIebREHfzipAAji/gNIqAwhcDRpKSeN9BR7Bf1oFbAPKC7VCriFDmtKbBqJiG23KAhpKnAMg==
X-Received: by 2002:a17:902:e85:: with SMTP id 5-v6mr7798101plx.73.1533944393185;
        Fri, 10 Aug 2018 16:39:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 75-v6sm20985577pfr.115.2018.08.10.16.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 16:39:51 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ath10k: retrieve MAC address from firmware if provided
Date:   Fri, 10 Aug 2018 16:39:48 -0700
Message-Id: <20180810233948.144792-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices may provide their own MAC address via system firmware (e.g.,
device tree), especially in the case where the device doesn't have a
useful EEPROM on which to store its MAC address (e.g., for integrated
Wifi).

Use the generic device helper to retrieve the MAC address, and (if
present) honor it above the MAC address advertised by the card.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 3 +++
 drivers/net/wireless/ath/ath10k/wmi.c  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index c40cd129afe7..840c1f039098 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
 #include <asm/byteorder.h>
@@ -2602,6 +2603,8 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ath10k_debug_print_board_info(ar);
 	}
 
+	device_get_mac_address(ar->dev, ar->mac_addr, sizeof(ar->mac_addr));
+
 	ret = ath10k_core_init_firmware_features(ar);
 	if (ret) {
 		ath10k_err(ar, "fatal problem with firmware features: %d\n",
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index fd612d2905b0..3cfd98de8ad2 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5449,7 +5449,8 @@ int ath10k_wmi_event_ready(struct ath10k *ar, struct sk_buff *skb)
 		   arg.mac_addr,
 		   __le32_to_cpu(arg.status));
 
-	ether_addr_copy(ar->mac_addr, arg.mac_addr);
+	if (is_zero_ether_addr(ar->mac_addr))
+		ether_addr_copy(ar->mac_addr, arg.mac_addr);
 	complete(&ar->wmi.unified_ready);
 	return 0;
 }
-- 
2.18.0.597.ga71716f1ad-goog

