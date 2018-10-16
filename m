Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B95CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C855D2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx0m/PD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C855D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeJPMBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbeJPMBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4342145D;
        Tue, 16 Oct 2018 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663167;
        bh=QVoFIwyHcjvVWOSMrzErhKNN8Z6L0WQbnkU/3FNVh2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nx0m/PD6iuU6VMQfxWqRlIQFSnKgHvMlmi+jPXRyYlY9eQunGgCp088ZMvvvBng5R
         Pzb1+IWJwKsWm2239R1AW5CNm5seONOdATA6ERuRIeOcb4r3NjWAkd6S3mXMe12hme
         VKqCWzwHZnntC9xorecgXQSmNKL9ABW3ijhrJD0Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 025/100] mac80211_hwsim: fix locking when iterating radios during ns exit
Date:   Tue, 16 Oct 2018 00:11:06 -0400
Message-Id: <20181016041221.135528-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Willi <martin@strongswan.org>

[ Upstream commit 628980e5c8f038f730582c6ee50b7410741cd96e ]

The cleanup of radios during namespace exit has recently been reworked
to directly delete a radio while temporarily releasing the spinlock,
fixing a race condition between the work-queue execution and namespace
exits. However, the temporary unlock allows unsafe modifications on the
iterated list, resulting in a potential crash when continuing the
iteration of additional radios.

Move radios about to destroy to a temporary list, and clean that up
after releasing the spinlock once iteration is complete.

Fixes: 8cfd36a0b53a ("mac80211_hwsim: fix use-after-free bug in hwsim_exit_net")
Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 80e2c8595c7c..6b90bef58293 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3523,6 +3523,7 @@ static __net_init int hwsim_init_net(struct net *net)
 static void __net_exit hwsim_exit_net(struct net *net)
 {
 	struct mac80211_hwsim_data *data, *tmp;
+	LIST_HEAD(list);
 
 	spin_lock_bh(&hwsim_radio_lock);
 	list_for_each_entry_safe(data, tmp, &hwsim_radios, list) {
@@ -3533,17 +3534,19 @@ static void __net_exit hwsim_exit_net(struct net *net)
 		if (data->netgroup == hwsim_net_get_netgroup(&init_net))
 			continue;
 
-		list_del(&data->list);
+		list_move(&data->list, &list);
 		rhashtable_remove_fast(&hwsim_radios_rht, &data->rht,
 				       hwsim_rht_params);
 		hwsim_radios_generation++;
-		spin_unlock_bh(&hwsim_radio_lock);
+	}
+	spin_unlock_bh(&hwsim_radio_lock);
+
+	list_for_each_entry_safe(data, tmp, &list, list) {
+		list_del(&data->list);
 		mac80211_hwsim_del_radio(data,
 					 wiphy_name(data->hw->wiphy),
 					 NULL);
-		spin_lock_bh(&hwsim_radio_lock);
 	}
-	spin_unlock_bh(&hwsim_radio_lock);
 
 	ida_simple_remove(&hwsim_netgroup_ida, hwsim_net_get_netgroup(net));
 }
-- 
2.17.1

