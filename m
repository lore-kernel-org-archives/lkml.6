Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012B62084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543435;
	bh=ebWEQouu5I0Pd3vS6a7agpA9KQDjoBEu2FmxnkW6XUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KE8y+B/+vCFr0t9EwYXwJ9w8g9q4XZSctBA3eufYci2hFyH9ANW94plDMHpOXJm/w
	 6Atg86EXW13TclgBcnQZ7nw9pf/hZwwLq1cx1UTN3Md3TO12P/2Aj/LhnE2TuF+zPv
	 dbRPgcnGs0oh2eUW/1WA4zWIxK+sN6D0OcS0AR7U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012B62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeLKPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbeLKPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDEC72084E;
        Tue, 11 Dec 2018 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543425;
        bh=ebWEQouu5I0Pd3vS6a7agpA9KQDjoBEu2FmxnkW6XUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4PxNqmXaowrSXMVwXoSvwdHUrxRjDMQfTcLLpKjY7it968uBiV4JF2Rw5W8rkYvP
         EYtZgcrpD2fMd7tSQfGWsLkWmnSRvhrCThnORe2hQS1GwLOBkEwrxb3UQyj+ji5bBn
         2erj21Tan5gKMbl6rrukFxxTSuXhIJrcjxrZDc7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasyl Vavrychuk <vasyl.vavrychuk@globallogic.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 45/51] mac80211_hwsim: Timer should be initialized before device registered
Date:   Tue, 11 Dec 2018 16:41:53 +0100
Message-Id: <20181211151617.882571196@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2633,6 +2633,10 @@ static int mac80211_hwsim_new_radio(stru
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
+	tasklet_hrtimer_init(&data->beacon_timer,
+			     mac80211_hwsim_beacon,
+			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+
 	err = ieee80211_register_hw(hw);
 	if (err < 0) {
 		printk(KERN_DEBUG "mac80211_hwsim: ieee80211_register_hw failed (%d)\n",
@@ -2657,10 +2661,6 @@ static int mac80211_hwsim_new_radio(stru
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
 
-	tasklet_hrtimer_init(&data->beacon_timer,
-			     mac80211_hwsim_beacon,
-			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-
 	spin_lock_bh(&hwsim_radio_lock);
 	list_add_tail(&data->list, &hwsim_radios);
 	spin_unlock_bh(&hwsim_radio_lock);


