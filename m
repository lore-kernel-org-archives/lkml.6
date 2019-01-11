Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28377C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE87D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217434;
	bh=ZxPpYPmBgBnMHkavDdqQGfUM2fjnYVVzmdCcfzIBsS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nmi4b77WxVX7OTS4Vum0hl+n8yiGIeKsm5LovuH9IYtfZ8h+ILApMEFDkToIlIc7+
	 gzqC3cgTA8V99T/2vjx/uul1MXsCKSGjCT5sUmhlpS/tLIZAjOb+WJ5IkFWWq4WwOv
	 2vHNZh6e5KNLNEeS/o5MEzbaEK2qTywV6ajP5140=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbfAKOhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390121AbfAKOhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7867E2063F;
        Fri, 11 Jan 2019 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217430;
        bh=ZxPpYPmBgBnMHkavDdqQGfUM2fjnYVVzmdCcfzIBsS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1b9CsMrm+rI93N6Tqbgzs8EFIqqYxvvKSCw9/fYTeElSIcs9CL3/G4JV5SmvqTAV
         qeWhKYjrW06TicxpVI1rBQw+i6DVFvlCbMwRknarUpBITK0DIvvKAc5KY9K21SLD6J
         NYZFCS4hSS0jzny9X0AXlyz2Xk1OCA/IT/VNV7sY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/148] mac80211: fix a kernel panic when TXing after TXQ teardown
Date:   Fri, 11 Jan 2019 15:13:54 +0100
Message-Id: <20190111131116.507701424@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a50e5fb8db83c5b57392204c21ea6c5c4ccefde6 ]

Recently TXQ teardown was moved earlier in ieee80211_unregister_hw(),
to avoid a use-after-free of the netdev data. However, interfaces
aren't fully removed at the point, and cfg80211_shutdown_all_interfaces
can for example, TX a deauth frame. Move the TXQ teardown to the
point between cfg80211_shutdown_all_interfaces and the free of
netdev queues, so we can be sure they are torn down before netdev
is freed, but after there is no ongoing TX.

Fixes: 77cfaf52eca5 ("mac80211: Run TXQ teardown code before de-registering interfaces")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/iface.c | 3 +++
 net/mac80211/main.c  | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 5f3c81e705c7..3a0171a65db3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -7,6 +7,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
+ * Copyright (C) 2018 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -1951,6 +1952,8 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	WARN(local->open_count, "%s: open count remains %d\n",
 	     wiphy_name(local->hw.wiphy), local->open_count);
 
+	ieee80211_txq_teardown_flows(local);
+
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
 		list_del(&sdata->list);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 513627896204..68db2a356443 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1198,7 +1198,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	rtnl_unlock();
 	ieee80211_led_exit(local);
 	ieee80211_wep_free(local);
-	ieee80211_txq_teardown_flows(local);
  fail_flows:
 	destroy_workqueue(local->workqueue);
  fail_workqueue:
@@ -1224,7 +1223,6 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 #if IS_ENABLED(CONFIG_IPV6)
 	unregister_inet6addr_notifier(&local->ifa6_notifier);
 #endif
-	ieee80211_txq_teardown_flows(local);
 
 	rtnl_lock();
 
-- 
2.19.1



