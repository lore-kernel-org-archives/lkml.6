Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A857C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A857C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbeHATJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:09:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbeHATJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:09:15 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71700D2F;
        Wed,  1 Aug 2018 17:22:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 214/246] drm/dp/mst: Fix off-by-one typo when dump payload table
Date:   Wed,  1 Aug 2018 18:52:04 +0200
Message-Id: <20180801165021.950806129@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 7056a2bccc3b5afc51f9b35b30a46f0d9219968d ]

It seems there is a classical off-by-one typo from the beginning
when commit

  ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")

introduced a new helper.

Fix a typo by introducing a macro constant.

Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180319141932.37290-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2862,12 +2862,14 @@ static void drm_dp_mst_dump_mstb(struct
 	}
 }
 
+#define DP_PAYLOAD_TABLE_SIZE		64
+
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 				  char *buf)
 {
 	int i;
 
-	for (i = 0; i < 64; i += 16) {
+	for (i = 0; i < DP_PAYLOAD_TABLE_SIZE; i += 16) {
 		if (drm_dp_dpcd_read(mgr->aux,
 				     DP_PAYLOAD_TABLE_UPDATE_STATUS + i,
 				     &buf[i], 16) != 16)
@@ -2936,7 +2938,7 @@ void drm_dp_mst_dump_topology(struct seq
 
 	mutex_lock(&mgr->lock);
 	if (mgr->mst_primary) {
-		u8 buf[64];
+		u8 buf[DP_PAYLOAD_TABLE_SIZE];
 		int ret;
 
 		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
@@ -2954,8 +2956,7 @@ void drm_dp_mst_dump_topology(struct seq
 		seq_printf(m, " revision: hw: %x.%x sw: %x.%x\n",
 			   buf[0x9] >> 4, buf[0x9] & 0xf, buf[0xa], buf[0xb]);
 		if (dump_dp_payload_table(mgr, buf))
-			seq_printf(m, "payload table: %*ph\n", 63, buf);
-
+			seq_printf(m, "payload table: %*ph\n", DP_PAYLOAD_TABLE_SIZE, buf);
 	}
 
 	mutex_unlock(&mgr->lock);


