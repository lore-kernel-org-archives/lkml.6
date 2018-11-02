Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5092082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/aJWle6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5092082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeKCDs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeKCDs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8953B2082E;
        Fri,  2 Nov 2018 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184015;
        bh=jOfjNx2iXGVDGBMWF7cIysDLVEi9Luh2wWnX9tS/7Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/aJWle6O35DMMv7TiFAL6XuYfipAlS5Jm77907fq2LZBca7SWi2FsHsLqz76cH8X
         opwRBn74TWg6xAopQWxx6pzof5SPdwfmwt1nfZ36EEf/0ESolTT8a8e50ew1snVdaP
         s8/yKpOYqp0ieSOrq2d00KjwGDPsdDVJ/6/8OkDk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 024/150] mac80211_hwsim: fix locking when iterating radios during ns exit
Date:   Fri,  2 Nov 2018 19:33:06 +0100
Message-Id: <20181102182904.825989145@linuxfoundation.org>
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



