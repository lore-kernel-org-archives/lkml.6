Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B2D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq0jJGP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B2D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeJKXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8AF62098A;
        Thu, 11 Oct 2018 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272348;
        bh=z6fS0rptsQQYbYjCFfYAvKYeNbfJgtMvlY6ey8zNeVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qq0jJGP8w7ClYNOksxkPgEDX3swR3gLVR+ez2IZQALb/X+pXEawKxtI3UTv33wvLo
         3N9SUefLLXUZZidcMeNXP5Mq3s6dfwkdGTyGJu1jUrs3GS8W3yo9I5Yx3IqTSLs+rd
         SuXeUAcpJlyl4rFrf6iIS93kM/ZCrXzOBoRHyzZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 078/120] mac80211: fix a race between restart and CSA flows
Date:   Thu, 11 Oct 2018 17:34:19 +0200
Message-Id: <20181011152553.033574803@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit f3ffb6c3a28963657eb8b02a795d75f2ebbd5ef4 ]

We hit a problem with iwlwifi that was caused by a bug in
mac80211. A bug in iwlwifi caused the firwmare to crash in
certain cases in channel switch. Because of that bug,
drv_pre_channel_switch would fail and trigger the restart
flow.
Now we had the hw restart worker which runs on the system's
workqueue and the csa_connection_drop_work worker that runs
on mac80211's workqueue that can run together. This is
obviously problematic since the restart work wants to
reconfigure the connection, while the csa_connection_drop_work
worker does the exact opposite: it tries to disconnect.

Fix this by cancelling the csa_connection_drop_work worker
in the restart worker.

Note that this can sound racy: we could have:

driver   iface_work   CSA_work   restart_work
+++++++++++++++++++++++++++++++++++++++++++++
              |
 <--drv_cs ---|
<FW CRASH!>
-CS FAILED-->
              |                       |
              |                 cancel_work(CSA)
           schedule                   |
           CSA work                   |
                         |            |
                        Race between those 2

But this is not possible because we flush the workqueue
in the restart worker before we cancel the CSA worker.
That would be bullet proof if we could guarantee that
we schedule the CSA worker only from the iface_work
which runs on the workqueue (and not on the system's
workqueue), but unfortunately we do have an instance
in which we schedule the CSA work outside the context
of the workqueue (ieee80211_chswitch_done).

Note also that we should probably cancel other workers
like beacon_connection_loss_work and possibly others
for different types of interfaces, at the very least,
IBSS should suffer from the exact same problem, but for
now, do the minimum to fix the actual bug that was actually
experienced and reproduced.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/main.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -258,8 +258,27 @@ static void ieee80211_restart_work(struc
 	     "%s called with hardware scan in progress\n", __func__);
 
 	rtnl_lock();
-	list_for_each_entry(sdata, &local->interfaces, list)
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		/*
+		 * XXX: there may be more work for other vif types and even
+		 * for station mode: a good thing would be to run most of
+		 * the iface type's dependent _stop (ieee80211_mg_stop,
+		 * ieee80211_ibss_stop) etc...
+		 * For now, fix only the specific bug that was seen: race
+		 * between csa_connection_drop_work and us.
+		 */
+		if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+			/*
+			 * This worker is scheduled from the iface worker that
+			 * runs on mac80211's workqueue, so we can't be
+			 * scheduling this worker after the cancel right here.
+			 * The exception is ieee80211_chswitch_done.
+			 * Then we can have a race...
+			 */
+			cancel_work_sync(&sdata->u.mgd.csa_connection_drop_work);
+		}
 		flush_delayed_work(&sdata->dec_tailroom_needed_wk);
+	}
 	ieee80211_scan_cancel(local);
 	ieee80211_reconfig(local);
 	rtnl_unlock();


