Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A4920843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ySfVvpLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A4920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeKCDsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCDsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:36 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8599C20840;
        Fri,  2 Nov 2018 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184024;
        bh=nqQSOFykV9COU0FT7aoPYzwAl9+ef9XKLbRcvDW1CLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySfVvpLOS/X92VvuBOZTcW8FQNDM0YHOCGM3XjMF8i7ehRFB/wf8o2CbiDrKRPX5v
         GSi4+m0upL7E7uJsjwjamPQgQoF/kC5jHaO0tUD/J5FmKtxz/LSKSyNWR8ourUmbU6
         To5HK+8f4jWOFeTMI+o/JFw8Lq/sMEBygr19uqS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 025/150] mac80211_hwsim: fix race in radio destruction from netlink notifier
Date:   Fri,  2 Nov 2018 19:33:07 +0100
Message-Id: <20181102182904.918284312@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



