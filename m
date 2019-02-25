Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60877C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72B213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130131;
	bh=oQaqOZEqdGFEPpSW9xl9ITzQqmGGjO++B9u5j0v7GTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIaxHP4vObUdhMMsqMEXzgvxHHDZgEBPrcegakvpnPJ4lLwVK2GoN+2W7p3va796T
	 2f4tUlOfmudjeQwCGoX5NEJj8pZfeLEarlJXmOGDYWaLP4QK2YpHkPtyA84EJJM6LX
	 XgbmcU9ZZUkNVMrb0j1rRNjTyX4o/QzoQxHtnLRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfBYV2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfBYV2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6C432084D;
        Mon, 25 Feb 2019 21:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130126;
        bh=oQaqOZEqdGFEPpSW9xl9ITzQqmGGjO++B9u5j0v7GTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgjlElkF+bJriS3CVkQ/ZMio+/mZT2Q4+MXAWUW/SAvsR5FjBKeHMh+2Ju44n5jva
         GrvGgWSb+LTYcuKHVRD3FznJ9z9jKw6QwThhvUeHp1pyNJKUzJfNyorg7mjYahlxL5
         E70lAh19p6VYDaWRGI4rm5O37vh6saGj11JOJNcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 008/183] mac80211: Restore vif beacon interval if start ap fails
Date:   Mon, 25 Feb 2019 22:09:41 +0100
Message-Id: <20190225195056.058684625@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Rakesh Pillai <pillair@codeaurora.org>

commit 83e37e0bdd1470bbe6612250b745ad39b1a7b130 upstream.

The starting of AP interface can fail due to invalid
beacon interval, which does not match the minimum gcd
requirement set by the wifi driver. In such case, the
beacon interval of that interface gets updated with
that invalid beacon interval.

The next time that interface is brought up in AP mode,
an interface combination check is performed and the
beacon interval is taken from the previously set value.

In a case where an invalid beacon interval, i.e. a beacon
interval value which does not satisfy the minimum gcd criteria
set by the driver, is set, all the subsequent trials to
bring that interface in AP mode will fail, even if the
subsequent trials have a valid beacon interval.

To avoid this, in case of a failure in bringing up an
interface in AP mode due to interface combination error,
the interface beacon interval which is stored in bss
conf, needs to be restored with the last working value
of beacon interval.

Tested on ath10k using WCN3990.

Cc: stable@vger.kernel.org
Fixes: 0c317a02ca98 ("cfg80211: support virtual interfaces with different beacon intervals")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/cfg.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -941,6 +941,7 @@ static int ieee80211_start_ap(struct wip
 		      BSS_CHANGED_P2P_PS |
 		      BSS_CHANGED_TXPOWER;
 	int err;
+	int prev_beacon_int;
 
 	old = sdata_dereference(sdata->u.ap.beacon, sdata);
 	if (old)
@@ -963,6 +964,7 @@ static int ieee80211_start_ap(struct wip
 
 	sdata->needed_rx_chains = sdata->local->rx_chains;
 
+	prev_beacon_int = sdata->vif.bss_conf.beacon_int;
 	sdata->vif.bss_conf.beacon_int = params->beacon_interval;
 
 	if (params->he_cap)
@@ -974,8 +976,10 @@ static int ieee80211_start_ap(struct wip
 	if (!err)
 		ieee80211_vif_copy_chanctx_to_vlans(sdata, false);
 	mutex_unlock(&local->mtx);
-	if (err)
+	if (err) {
+		sdata->vif.bss_conf.beacon_int = prev_beacon_int;
 		return err;
+	}
 
 	/*
 	 * Apply control port protocol, this allows us to


