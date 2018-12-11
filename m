Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E207920989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543318;
	bh=DbTkrtTbs6ekCfL3duw1qqiA7tvUY8sL2yn3PS3vnFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Auw4TlwMDSnsuk7CFG4qEuaK7mcpzRjlOdrEMT078vJNUoLNZN/55rf4oU8LOKt66
	 dBlJcxWmA6IOg4FN2TasgHKr/jQkguLLADpGEVbV54UZ+OUOkfMYhJl2lrEO3UAUl7
	 zoPOd52hZpjA1XMOJwKIZ3+KREGY11BdZcoGtxSQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E207920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeLKPsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbeLKPse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDF220870;
        Tue, 11 Dec 2018 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543314;
        bh=DbTkrtTbs6ekCfL3duw1qqiA7tvUY8sL2yn3PS3vnFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpTCW6mKch55ZkvmhGbn+y1DTqRajoHM0zb1hQp1qW3bhI7hR+QSz7G5CMPeD5nRO
         8QvyWidE8mcQbML6xuZAuOVC7OoDDWk5pXTZPAknY5px4L3ivKw03PcXYfPx1AiOap
         O3GlB6I9NuhQqKzkqA+apTWgxi+5VkPDbibvAK7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 87/91] mac80211_hwsim: Timer should be initialized before device registered
Date:   Tue, 11 Dec 2018 16:41:46 +0100
Message-Id: <20181211151613.958492049@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>

commit a1881c9b8a1edef0a5ae1d5c1b61406fe3402114 upstream.

Otherwise if network manager starts configuring Wi-Fi interface
immidiatelly after getting notification of its creation, we will get
NULL pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at           (null)
  IP: [<ffffffff95ae94c8>] hrtimer_active+0x28/0x50
  ...
  Call Trace:
   [<ffffffff95ae9997>] ? hrtimer_try_to_cancel+0x27/0x110
   [<ffffffff95ae9a95>] ? hrtimer_cancel+0x15/0x20
   [<ffffffffc0803bf0>] ? mac80211_hwsim_config+0x140/0x1c0 [mac80211_hwsim]

Cc: stable@vger.kernel.org
Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2515,6 +2515,10 @@ static int mac80211_hwsim_new_radio(stru
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
+	tasklet_hrtimer_init(&data->beacon_timer,
+			     mac80211_hwsim_beacon,
+			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+
 	err = ieee80211_register_hw(hw);
 	if (err < 0) {
 		printk(KERN_DEBUG "mac80211_hwsim: ieee80211_register_hw failed (%d)\n",
@@ -2539,10 +2543,6 @@ static int mac80211_hwsim_new_radio(stru
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
 
-	tasklet_hrtimer_init(&data->beacon_timer,
-			     mac80211_hwsim_beacon,
-			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-
 	spin_lock_bh(&hwsim_radio_lock);
 	list_add_tail(&data->list, &hwsim_radios);
 	spin_unlock_bh(&hwsim_radio_lock);


