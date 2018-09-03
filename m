Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E30AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A3B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A3B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeICVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeICVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AFDF3D09;
        Mon,  3 Sep 2018 17:16:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 006/165] mac80211: add stations tied to AP_VLANs during hw reconfig
Date:   Mon,  3 Sep 2018 18:54:52 +0200
Message-Id: <20180903165655.323783610@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: "mpubbise@codeaurora.org" <mpubbise@codeaurora.org>

[ Upstream commit 19103a4bfb42f320395daa5616ece3e89e759d63 ]

As part of hw reconfig, only stations linked to AP interfaces are added
back to the driver ignoring those which are tied to AP_VLAN interfaces.

It is true that there could be stations tied to the AP_VLAN interface while
serving 4addr clients or when using AP_VLAN for VLAN operations; we should
be adding these stations back to the driver as part of hw reconfig, failing
to do so can cause functional issues.

In the case of ath10k driver, the following errors were observed.

ath10k_pci : failed to install key for non-existent peer XX:XX:XX:XX:XX:XX
Workqueue: events_freezable ieee80211_restart_work [mac80211]
(unwind_backtrace) from (show_stack+0x10/0x14)
(show_stack) (dump_stack+0x80/0xa0)
(dump_stack) (warn_slowpath_common+0x68/0x8c)
(warn_slowpath_common) (warn_slowpath_null+0x18/0x20)
(warn_slowpath_null) (ieee80211_enable_keys+0x88/0x154 [mac80211])
(ieee80211_enable_keys) (ieee80211_reconfig+0xc90/0x19c8 [mac80211])
(ieee80211_reconfig]) (ieee80211_restart_work+0x8c/0xa0 [mac80211])
(ieee80211_restart_work) (process_one_work+0x284/0x488)
(process_one_work) (worker_thread+0x228/0x360)
(worker_thread) (kthread+0xd8/0xec)
(kthread) (ret_from_fork+0x14/0x24)

Also while bringing down the AP VAP, WARN_ONs and errors related to peer
removal were observed.

ath10k_pci : failed to clear all peer wep keys for vdev 0: -2
ath10k_pci : failed to disassociate station: 8c:fd:f0:0a:8c:f5 vdev 0: -2
(unwind_backtrace) (show_stack+0x10/0x14)
(show_stack) (dump_stack+0x80/0xa0)
(dump_stack) (warn_slowpath_common+0x68/0x8c)
(warn_slowpath_common) (warn_slowpath_null+0x18/0x20)
(warn_slowpath_null) (sta_set_sinfo+0xb98/0xc9c [mac80211])
(sta_set_sinfo [mac80211]) (__sta_info_flush+0xf0/0x134 [mac80211])
(__sta_info_flush [mac80211]) (ieee80211_stop_ap+0xe8/0x390 [mac80211])
(ieee80211_stop_ap [mac80211]) (__cfg80211_stop_ap+0xe0/0x3dc [cfg80211])
(__cfg80211_stop_ap [cfg80211]) (cfg80211_stop_ap+0x30/0x44 [cfg80211])
(cfg80211_stop_ap [cfg80211]) (genl_rcv_msg+0x274/0x30c)
(genl_rcv_msg) (netlink_rcv_skb+0x58/0xac)
(netlink_rcv_skb) (genl_rcv+0x20/0x34)
(genl_rcv) (netlink_unicast+0x11c/0x204)
(netlink_unicast) (netlink_sendmsg+0x30c/0x370)
(netlink_sendmsg) (sock_sendmsg+0x70/0x84)
(sock_sendmsg) (___sys_sendmsg.part.3+0x188/0x228)
(___sys_sendmsg.part.3) (__sys_sendmsg+0x4c/0x70)
(__sys_sendmsg) (ret_fast_syscall+0x0/0x44)

These issues got fixed by adding the stations which are
tied to AP_VLANs back to the driver.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/util.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2068,7 +2068,8 @@ int ieee80211_reconfig(struct ieee80211_
 		if (!sta->uploaded)
 			continue;
 
-		if (sta->sdata->vif.type != NL80211_IFTYPE_AP)
+		if (sta->sdata->vif.type != NL80211_IFTYPE_AP &&
+		    sta->sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
 			continue;
 
 		for (state = IEEE80211_STA_NOTEXIST;


