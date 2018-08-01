Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979F92083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979F92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbeHATxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:53:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405791AbeHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EEB7F10AA;
        Wed,  1 Aug 2018 17:03:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 187/336] rsi: Add null check for virtual interfaces in wowlan config
Date:   Wed,  1 Aug 2018 18:48:42 +0200
Message-Id: <20180801165036.256309518@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>

[ Upstream commit 54b5172087aeae61150835c91e68f084a9644f1c ]

When the "poweroff" command is executed after wowlan enabled, we have
observed a system crash. In the system "poweroff" sequence, network-manager
is sent to inactive state by cleaning up the network interfaces, using
rsi_mac80211_remove_interface() and when driver tries to access those
network interfaces in rsi_wowlan_config() which was invoked by SDIO
shutdown, results in a crash. Added a NULL check before accessing the
network interfaces in rsi_wowlan_config().

Signed-off-by: Sanjay Kumar Konduri <sanjay.konduri@redpinesignals.com>
Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Signed-off-by: Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -1788,10 +1788,15 @@ int rsi_config_wowlan(struct rsi_hw *ada
 	struct rsi_common *common = adapter->priv;
 	u16 triggers = 0;
 	u16 rx_filter_word = 0;
-	struct ieee80211_bss_conf *bss = &adapter->vifs[0]->bss_conf;
+	struct ieee80211_bss_conf *bss = NULL;
 
 	rsi_dbg(INFO_ZONE, "Config WoWLAN to device\n");
 
+	if (!adapter->vifs[0])
+		return -EINVAL;
+
+	bss = &adapter->vifs[0]->bss_conf;
+
 	if (WARN_ON(!wowlan)) {
 		rsi_dbg(ERR_ZONE, "WoW triggers not enabled\n");
 		return -EINVAL;


