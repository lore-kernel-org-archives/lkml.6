Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E4AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQUUiUBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfA2XMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:12:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44478 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfA2XML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:12:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so10401086pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5QI9SCQIVH2sd+cRwUOWax4a5NWTgXxRP/Hc68OVrQ=;
        b=YQUUiUBSHwmDWfSh6N7OjxAVwrzbdWTyxu4juK6HCDi9FZecOTFP7xBtOkWg+Eu35O
         XNyJlPQDbqeqDOXAIJBHC7Dncvf8H+ral7ymA/xDRd/9F8kQvv8rTeB/asLgmQzsxtbw
         V8pIIGDF2Vls4cRH/U1QWu+uBwGUeMMuWWehQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n5QI9SCQIVH2sd+cRwUOWax4a5NWTgXxRP/Hc68OVrQ=;
        b=O5aEvdtwnawf3vvH3tGTBLuPAdcy5U0bGcWCRRXxwAQ0Fs1uCs5EzeSx+iboQW15t2
         hBXmEArHXIrJcWY8qnmkBrbkWYUlCokiQngcYGVB/zfvRv11jzZgxChS4Kav81eoqIKc
         InHh8Hws4LJpmEDKLN61m1fBDksTummiciDg5jdG/ixnoE5JkGEm0HoFR5BK4lyrRlM9
         iMpxcodRB0raBfxHSsHUR/rtKpnUlxo02GQOWAvmpDMWXA7yhOIvmiboryqPA0uiA1y4
         E9YRBxLSUH3vMNSenglPsF64ifkpkgJTAgcji8Bytr/nEg0jHN73lFPIv0682ucPdb2M
         +zSQ==
X-Gm-Message-State: AJcUukdELeyhAZLKg4T3e/SMMwsINx4r7UVuun5pKqijvHmcAwob4PKM
        UvUiVvmlEdYaPenyq+puRlDbnQ==
X-Google-Smtp-Source: ALg8bN5hcrgKnk1iWV5DfqWkGd+kA9rqOlnjRdi2FYjS7j2cC25d1TdNfqqU7RcYCEIu7zzwe3W2CA==
X-Received: by 2002:a63:2315:: with SMTP id j21mr25714008pgj.297.1548803531180;
        Tue, 29 Jan 2019 15:12:11 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id m67sm64681055pfb.25.2019.01.29.15.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:12:09 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Wen Gong <wgong@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH for-5.0] ath10k: correct bus type for WCN3990
Date:   Tue, 29 Jan 2019 15:12:01 -0800
Message-Id: <20190129231201.42230-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCN3990 is SNOC, not PCI. This prevents probing WCN3990.

Fixes: 367c899f622c ("ath10k: add bus type check in ath10k_init_hw_params")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This was a regression in 4.20.

 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 399b501f3c3c..e8891f5fc83a 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -548,7 +548,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
 		.dev_id = 0,
-		.bus = ATH10K_BUS_PCI,
+		.bus = ATH10K_BUS_SNOC,
 		.name = "wcn3990 hw1.0",
 		.continuous_frag_desc = true,
 		.tx_chain_mask = 0x7,
-- 
2.20.1.495.gaa96b0ce6b-goog

