Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A109F222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083754;
	bh=xOiWPNECfftlfeJBDXKEzWo0Fc+66luvb0Im6BNO9iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vgIvQPU+MYp15ojzySTo8vAFBlXTH/E8CW5cfysFrBO8t1DdNF2G7dOevDNsMq+9k
	 nUMs+Vx9k6ZOVIXzkrCk9jMIv2lvGeDjExoR/n9zCJxHCWzZQb8xeURxmXu6j1VGz3
	 CCooAO78evaUiOoALrmY9vJuww9OFwNmTJs8wXCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406342AbfBMSpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406331AbfBMSp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6565D20811;
        Wed, 13 Feb 2019 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083527;
        bh=xOiWPNECfftlfeJBDXKEzWo0Fc+66luvb0Im6BNO9iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igGHrkb0q7zaTqjdFNd3ssaoj3mRfjO57qQDlx8+HD58yYOQ2hNFo1ijBzTpQti76
         Tdz4HR98l5xLKYqeb/0zxdcld+J8SAlYwEpa0b95J3Tvv3qr4Z570e4mtoPQxJn+rC
         C6WkCdFEN2VCuul2ncBHZnKfoypsArJWuX5WGRKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 14/50] cfg80211: call disconnect_wk when AP stops
Date:   Wed, 13 Feb 2019 19:38:19 +0100
Message-Id: <20190213183656.954676443@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit e005bd7ddea06784c1eb91ac5bb6b171a94f3b05 upstream.

Since we now prevent regulatory restore during STA disconnect
if concurrent AP interfaces are active, we need to reschedule
this check when the AP state changes. This fixes never doing
a restore when an AP is the last interface to stop. Or to put
it another way: we need to re-check after anything we check
here changes.

Cc: stable@vger.kernel.org
Fixes: 113f3aaa81bd ("cfg80211: Prevent regulatory restore during STA disconnect in concurrent interfaces")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/ap.c   |    2 ++
 net/wireless/core.h |    2 ++
 net/wireless/sme.c  |    2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -41,6 +41,8 @@ int __cfg80211_stop_ap(struct cfg80211_r
 		cfg80211_sched_dfs_chan_update(rdev);
 	}
 
+	schedule_work(&cfg80211_disconnect_work);
+
 	return err;
 }
 
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -444,6 +444,8 @@ void cfg80211_process_wdev_events(struct
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
 				u32 center_freq_khz, u32 bw_khz);
 
+extern struct work_struct cfg80211_disconnect_work;
+
 /**
  * cfg80211_chandef_dfs_usable - checks if chandef is DFS usable
  * @wiphy: the wiphy to validate against
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -667,7 +667,7 @@ static void disconnect_work(struct work_
 	rtnl_unlock();
 }
 
-static DECLARE_WORK(cfg80211_disconnect_work, disconnect_work);
+DECLARE_WORK(cfg80211_disconnect_work, disconnect_work);
 
 
 /*


