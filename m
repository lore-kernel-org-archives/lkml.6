Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676098;
	bh=VXKa1Xfu3bHDv/YOFsZQ7/rIi4ygf+QGdPVvadxtX88=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VSRvBbp1TshVDAcCtpgQp7/uqcqrFYuLvoL9OJTvd1ieHVUSlO/04WoawdVZIpvo0
	 4nDegI8aQPDtT29q+xHqqku7rqau2DdD0988mbiRPNkyiH9sqH0Tg0kOcHcOqO+t4I
	 h/I5TGiiQoCThMkVH6rCE+kArG12bKSDNnhGg9RI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E42520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeLMElh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbeLMEcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C10420879;
        Thu, 13 Dec 2018 04:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675522;
        bh=VXKa1Xfu3bHDv/YOFsZQ7/rIi4ygf+QGdPVvadxtX88=;
        h=From:To:Cc:Subject:Date:From;
        b=uOlh1nklbz4laW/128G6xWaYiYhxBsv90GnSfqcOWuxNn8PiO3zUt8ce7QcCsumpP
         xPHw10Jllz2XeRNahPRJMi3WT8q/VctuDTe/ZprY8gXMZR2mEOEKmF3BldgQtdZZ/z
         C4utiSXnXntXHu+Gozshkb3ccdSIXhbkwcuV4KyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/34] mac80211_hwsim: fix module init error paths for netlink
Date:   Wed, 12 Dec 2018 23:31:27 -0500
Message-Id: <20181213043200.76295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

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
index cbb3e902e347..c591c7c1d33a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3403,16 +3403,16 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		goto out_unregister_pernet;
 
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
 
@@ -3518,6 +3518,8 @@ static int __init init_mac80211_hwsim(void)
 	free_netdev(hwsim_mon);
 out_free_radios:
 	mac80211_hwsim_free();
+out_exit_netlink:
+	hwsim_exit_netlink();
 out_unregister_driver:
 	platform_driver_unregister(&mac80211_hwsim_driver);
 out_unregister_pernet:
-- 
2.19.1

