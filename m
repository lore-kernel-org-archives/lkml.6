Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9A2229F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z2b6UWxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfBOAcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:32:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43660 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbfBOAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:32:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3915499pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izgJFnCdI5xRDk7KUsF4CwPakY/Nt0DRCaeE0YNyGFI=;
        b=Z2b6UWxxxHUZuBGlg7GgQ5hJ30jQrp+/JBhP12aTdy2au6XMnddBlrcE84jPdCwK6v
         E1NJfPoOtk3XnnJnd39Y1E9W0uM3POw3lCe5+NmH749CqVmMEEbF3NZywwBxkRk+5IJu
         JdE32H9lI7DgCdGM03bpmoCNbOfLmP/SGniyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izgJFnCdI5xRDk7KUsF4CwPakY/Nt0DRCaeE0YNyGFI=;
        b=NxpFVGyB5+A0Tuq4OEEtLBywDgrd6dtoo19G8DrDfqL4j+hvhZzNR2ptRgJvcufa2j
         TdPyiWi6g4h87XOJgbgShnUHxefjCi0G1K+w/tx5LQJdgSNRks39nqjEpnC0FC4ln5NR
         AZo2tN9cgxsNdEV+RDaC5P2fJSl2fwiAOqKbQ/EV0cQQwbidSg+rGPkr0UOdPKEpdDpk
         gYace5h7T58/AbARFZDAW8XWkojZsuLcckSWOOMnrF8Wds/YZhto42lyJVQUdh1Awo2L
         nR0YIyR8BrkymucSfmDy6BM4jy7kdzlXMTX5t0Z5z9JFeCfVRxH5oHCkx/tip2T237Gy
         7d4Q==
X-Gm-Message-State: AHQUAuaIkmE4TJrTGTwK6yJhlyecDTAbkXk/FJRavjNncTLslWbzrpLp
        3K4EsY+zIurSH4kSzpe3qu66TQ==
X-Google-Smtp-Source: AHgI3IacKgMRUXsl4lsmn0isavoz26TuQ2AK7aGp2Y1YroJvzOBelzwbquLEW0o6lHQz1FYV81rUpw==
X-Received: by 2002:a63:160d:: with SMTP id w13mr2440368pgl.85.1550190719717;
        Thu, 14 Feb 2019 16:31:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id y66sm11625387pfy.66.2019.02.14.16.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 16:31:58 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Karthik D A <karthida@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: don't advertise IBSS features without FW support
Date:   Thu, 14 Feb 2019 16:31:29 -0800
Message-Id: <20190215003129.98298-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is, doing something like

  # iw phy phy0 interface add foobar type ibss

on a firmware that doesn't have ad-hoc support just yields failures of
HostCmd_CMD_SET_BSS_MODE, which happened to return a '-1' error code
(-EPERM? not really right...) and sometimes may even crash the firmware
along the way.

Let's parse the firmware capability flag while registering the wiphy, so
we don't allow attempting IBSS at all, and we get a proper -EOPNOTSUPP
from nl80211 instead.

Fixes: e267e71e68ae ("mwifiex: Disable adhoc feature based on firmware capability")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 1467af22e394..883752f640b4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4310,11 +4310,13 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				 BIT(NL80211_IFTYPE_ADHOC) |
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_AP);
 
+	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
+
 	wiphy->bands[NL80211_BAND_2GHZ] = &mwifiex_band_2ghz;
 	if (adapter->config_bands & BAND_A)
 		wiphy->bands[NL80211_BAND_5GHZ] = &mwifiex_band_5ghz;
@@ -4374,11 +4376,13 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	wiphy->available_antennas_tx = BIT(adapter->number_of_antenna) - 1;
 	wiphy->available_antennas_rx = BIT(adapter->number_of_antenna) - 1;
 
-	wiphy->features |= NL80211_FEATURE_HT_IBSS |
-			   NL80211_FEATURE_INACTIVITY_TIMER |
+	wiphy->features |= NL80211_FEATURE_INACTIVITY_TIMER |
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
 
+	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
+		wiphy->features |= NL80211_FEATURE_HT_IBSS;
+
 	if (ISSUPP_RANDOM_MAC(adapter->fw_cap_info))
 		wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
 				   NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
-- 
2.21.0.rc0.258.g878e2cd30e-goog

