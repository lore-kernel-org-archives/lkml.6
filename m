Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7466820C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7466820C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeHOTOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:14:04 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:57950 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeHOTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:14:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fpyXq-0007NN-Fb; Wed, 15 Aug 2018 18:21:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211_hwsim: require at least one channel
Date:   Wed, 15 Aug 2018 18:19:59 +0200
Message-Id: <20180815161959.8775-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <0000000000006ebad505737b6bf4@google.com>
References: <0000000000006ebad505737b6bf4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Syzbot continues to try to create mac80211_hwsim radios, and
manages to pass parameters that are later checked with WARN_ON
in cfg80211 - catch another one in hwsim directly.

Reported-by: syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 18e819d964f1..fe1b0108f06d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3194,6 +3194,11 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		param.channels = nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
 
+	if (param.channels < 1) {
+		GENL_SET_ERR_MSG(info, "must have at least one channel");
+		return -EINVAL;
+	}
+
 	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
 		GENL_SET_ERR_MSG(info, "too many channels specified");
 		return -EINVAL;
-- 
2.14.4

