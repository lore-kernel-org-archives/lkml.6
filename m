Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7975921773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297684;
	bh=DEYp7qMZ5yu+rI+l7vmjv43aWdvlbrTmCyzcBi0wA8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGzq9haw3ibEQD0/Lyj0T8GXNF4n/GKmMsU5j/52ZLO6IsPMBCYgJG/AF6Oru3L0+
	 yuiPnQ11gOE+OmwFacLJYyh9z9xg90GH5/sUn+r0OIX4o/hHj0v3PvVfzEWj0UwC98
	 53b7YjgVXO3Bf9OAdOuOUrQPkYuVJvgmQQZNgTzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbeLTJVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbeLTJVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C30A62177B;
        Thu, 20 Dec 2018 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297680;
        bh=DEYp7qMZ5yu+rI+l7vmjv43aWdvlbrTmCyzcBi0wA8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veHnUvbqnxlD0YqgmuZikQ2bZTkUDKsb+m22DTudpIxLgNlfboddXj7H2VeecyKQP
         7GOFTTG+V+9xMxDyraZKvFehICpgl4T/nUgEx4n6c2R9Vh7blVmiCDNxhE73M43lNo
         O3qf8Ryry4i13tyDpgzDCfajZSgcMg/w8PunGRAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 18/40] mac80211_hwsim: fix module init error paths for netlink
Date:   Thu, 20 Dec 2018 10:18:30 +0100
Message-Id: <20181220085827.197702334@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 05cc09de4c017663a217630682041066f2f9a5cd ]

There is no unregister netlink notifier and family on error paths
in init_mac80211_hwsim(). Also there is an error path where
hwsim_class is not destroyed.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 62759361eb49 ("mac80211-hwsim: Provide multicast event for HWSIM_CMD_NEW_RADIO")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ab480ea6d95a..0d1abcfec003 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3195,16 +3195,16 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		return err;
 
+	err = hwsim_init_netlink();
+	if (err)
+		goto out_unregister_driver;
+
 	hwsim_class = class_create(THIS_MODULE, "mac80211_hwsim");
 	if (IS_ERR(hwsim_class)) {
 		err = PTR_ERR(hwsim_class);
-		goto out_unregister_driver;
+		goto out_exit_netlink;
 	}
 
-	err = hwsim_init_netlink();
-	if (err < 0)
-		goto out_unregister_driver;
-
 	for (i = 0; i < radios; i++) {
 		struct hwsim_new_radio_params param = { 0 };
 
@@ -3310,6 +3310,8 @@ out_free_mon:
 	free_netdev(hwsim_mon);
 out_free_radios:
 	mac80211_hwsim_free();
+out_exit_netlink:
+	hwsim_exit_netlink();
 out_unregister_driver:
 	platform_driver_unregister(&mac80211_hwsim_driver);
 	return err;
-- 
2.19.1



