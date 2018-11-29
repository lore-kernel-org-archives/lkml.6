Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13A42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDtbBlY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbeK3Bbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbeK3Bbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A54602133F;
        Thu, 29 Nov 2018 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501570;
        bh=KMaxANTAClP+4/b8adJMH5v7zwixGljE+0vDj7DU29k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDtbBlY2BO9Y9+zlC6c1HW9S5/hsNaP8CM7AvWxWoxH4buMv18AtQWp1cq0oqA3GT
         ZzFlyiUvMrFCk78SlbiE8jB6yILnHnHoxE/FshpgNeikxVYd+vbdco+/WALFrEaC1D
         sj14AxlYcTJleeBSQZHGO/PhiMPtezoVV3EsGTFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.14 016/100] iwlwifi: mvm: support sta_statistics() even on older firmware
Date:   Thu, 29 Nov 2018 15:11:46 +0100
Message-Id: <20181129140100.290856000@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit ec484d03ef0df8d34086b95710e355a259cbe1f2 upstream.

The oldest firmware supported by iwlmvm do support getting
the average beacon RSSI. Enable the sta_statistics() call
from mac80211 even on older firmware versions.

Fixes: 33cef9256342 ("iwlwifi: mvm: support beacon statistics for BSS client")
Cc: stable@vger.kernel.org # 4.2+
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4189,10 +4189,6 @@ static void iwl_mvm_mac_sta_statistics(s
 		sinfo->filled |= BIT(NL80211_STA_INFO_SIGNAL_AVG);
 	}
 
-	if (!fw_has_capa(&mvm->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_RADIO_BEACON_STATS))
-		return;
-
 	/* if beacon filtering isn't on mac80211 does it anyway */
 	if (!(vif->driver_flags & IEEE80211_VIF_BEACON_FILTER))
 		return;


