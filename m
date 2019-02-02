Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E0C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33882086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBBFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:22:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:23419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfBBFVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:21:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 21:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="271934479"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2019 21:21:17 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Michael Chan" <michael.chan@broadcom.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ricardo Neri" <ricardo.neri@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 03/10] wlcore: Align reg_ch_conf_pending and tmp_ch_bitmap to unsigned long for better performance
Date:   Fri,  1 Feb 2019 21:14:44 -0800
Message-Id: <1549084491-57808-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bit in reg_ch_conf_pending in wl271 and tmp_ch_bitmap is set atomically
by set_bit(). set_bit() sets the bit in a single unsigned long location. If
the variables are not aligned to unsigned long, set_bit() accesses two
cache lines and thus causes slower performance. On x86, this scenario is
called split lock and can cause overall performance degradation due to
locked BTSL instruction in set_bit() locks bus.

To avoid performance degradation, the two variables are aligned to
unsigned long.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/net/wireless/ti/wlcore/cmd.c    | 3 ++-
 drivers/net/wireless/ti/wlcore/wlcore.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 903968735a74..8d15a6307d44 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -1707,7 +1707,8 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
 {
 	struct wl12xx_cmd_regdomain_dfs_config *cmd = NULL;
 	int ret = 0, i, b, ch_bit_idx;
-	u32 tmp_ch_bitmap[2];
+	/* Align to unsigned long for better performance in set_bit() */
+	u32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));
 	struct wiphy *wiphy = wl->hw->wiphy;
 	struct ieee80211_supported_band *band;
 	bool timeout = false;
diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
index dd14850b0603..92d878f01fa5 100644
--- a/drivers/net/wireless/ti/wlcore/wlcore.h
+++ b/drivers/net/wireless/ti/wlcore/wlcore.h
@@ -321,8 +321,10 @@ struct wl1271 {
 
 	/* Reg domain last configuration */
 	u32 reg_ch_conf_last[2]  __aligned(8);
-	/* Reg domain pending configuration */
-	u32 reg_ch_conf_pending[2];
+	/* Reg domain pending configuration. Aligned to unsigned long for
+	 * better performane in set_bit().
+	 */
+	u32 reg_ch_conf_pending[2] __aligned(sizeof(unsigned long));
 
 	/* Pointer that holds DMA-friendly block for the mailbox */
 	void *mbox;
-- 
2.7.4

