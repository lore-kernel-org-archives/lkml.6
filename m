Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A33C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C61821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zkMkozdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJPMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJPMBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85E22098A;
        Tue, 16 Oct 2018 04:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663168;
        bh=2WcFDsHUU9fJ0TVGEDXfYAvN1m28FcC6P9uI8fW4NEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkMkozduqJkqCLFePsuhvKdwYRf81IFGA+syO9oNdd5TtBUYR+f9uTgAakHY0iwF+
         sPMjVWqoaNWRaIpZhZH9sZsLw6WTCxEo/gwVtD/kVJ7Tqc263PMVIbijtUcCqeCR4D
         0I9aYzl5UFgitlyuJPdAC9grnl1IC0Tw/i4HOMeI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 026/100] mac80211_hwsim: fix race in radio destruction from netlink notifier
Date:   Tue, 16 Oct 2018 00:11:07 -0400
Message-Id: <20181016041221.135528-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Willi <martin@strongswan.org>

[ Upstream commit f1c47eb61d52379de5747d02bb36be20d7a2d0d3 ]

The asynchronous destruction from a work-queue of radios tagged with
destroy-on-close may race with the owning namespace about to exit,
resulting in potential use-after-free of that namespace.

Instead of using a work-queue, move radios about to destroy to a
temporary list, which can be worked on synchronously after releasing
the lock. This should be safe to do from the netlink socket notifier,
as the namespace is guaranteed to not get released.

Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 6b90bef58293..cfd0c58aa02a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -519,7 +519,6 @@ struct mac80211_hwsim_data {
 	int channels, idx;
 	bool use_chanctx;
 	bool destroy_on_close;
-	struct work_struct destroy_work;
 	u32 portid;
 	char alpha2[2];
 	const struct ieee80211_regdomain *regd;
@@ -3442,30 +3441,27 @@ static struct genl_family hwsim_genl_family __ro_after_init = {
 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
 };
 
-static void destroy_radio(struct work_struct *work)
-{
-	struct mac80211_hwsim_data *data =
-		container_of(work, struct mac80211_hwsim_data, destroy_work);
-
-	hwsim_radios_generation++;
-	mac80211_hwsim_del_radio(data, wiphy_name(data->hw->wiphy), NULL);
-}
-
 static void remove_user_radios(u32 portid)
 {
 	struct mac80211_hwsim_data *entry, *tmp;
+	LIST_HEAD(list);
 
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry_safe(entry, tmp, &hwsim_radios, list) {
 		if (entry->destroy_on_close && entry->portid == portid) {
-			list_del(&entry->list);
+			list_move(&entry->list, &list);
 			rhashtable_remove_fast(&hwsim_radios_rht, &entry->rht,
 					       hwsim_rht_params);
-			INIT_WORK(&entry->destroy_work, destroy_radio);
-			queue_work(hwsim_wq, &entry->destroy_work);
+			hwsim_radios_generation++;
 		}
 	}
 	spin_unlock_bh(&hwsim_radio_lock);
+
+	list_for_each_entry_safe(entry, tmp, &list, list) {
+		list_del(&entry->list);
+		mac80211_hwsim_del_radio(entry, wiphy_name(entry->hw->wiphy),
+					 NULL);
+	}
 }
 
 static int mac80211_hwsim_netlink_notify(struct notifier_block *nb,
-- 
2.17.1

