Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D23C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87FA2073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfBCOby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:31:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55228 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728939AbfBCOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:19:58 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcn-000640-7T; Sun, 03 Feb 2019 14:19:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00077n-TQ; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johannes Berg" <johannes.berg@intel.com>,
        "Ben Greear" <greearb@candelatech.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.827998642@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 171/305] mac80211: Clear beacon_int in ieee80211_do_stop
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>

commit 5c21e8100dfd57c806e833ae905e26efbb87840f upstream.

This fixes stale beacon-int values that would keep a netdev
from going up.

To reproduce:

Create two VAP on one radio.
vap1 has beacon-int 100, start it.
vap2 has beacon-int 240, start it (and it will fail
  because beacon-int mismatch).
reconfigure vap2 to have beacon-int 100 and start it.
  It will fail because the stale beacon-int 240 will be used
  in the ifup path and hostapd never gets a chance to set the
  new beacon interval.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/mac80211/iface.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -955,6 +955,8 @@ static void ieee80211_do_stop(struct iee
 	if (local->open_count == 0)
 		ieee80211_clear_tx_pending(local);
 
+	sdata->vif.bss_conf.beacon_int = 0;
+
 	/*
 	 * If the interface goes down while suspended, presumably because
 	 * the device was unplugged and that happens before our resume,

