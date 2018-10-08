Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14CC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEEE214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yAMmACTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEEE214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeJIBxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJIBxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:53:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC972064A;
        Mon,  8 Oct 2018 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023999;
        bh=4oQXYJylRqyL2DxPAVCeYgyLplmaxUEv4banntLU4wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAMmACTfgT34gIWZrUuSTPw88+x6I+veE4SuplPSJAvH5lW+1/m+akS5tknNRbYq0
         +K/gMY3BsxRwDfHcgliwUloGzm1M2+YMTfaRzPcmDlzJnNLD9RvYlRF4CeCBo9WrsZ
         0hhDqq1h+IiwlfbdBjrk4d0QDRGLPr3voJOwqEic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 21/59] mac80211: dont Tx a deauth frame if the AP forbade Tx
Date:   Mon,  8 Oct 2018 20:31:28 +0200
Message-Id: <20181008175548.646977786@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 6c18b27d6e5c6a7206364eae2b47bc8d8b2fa68f ]

If the driver fails to properly prepare for the channel
switch, mac80211 will disconnect. If the CSA IE had mode
set to 1, it means that the clients are not allowed to send
any Tx on the current channel, and that includes the
deauthentication frame.

Make sure that we don't send the deauthentication frame in
this case.

In iwlwifi, this caused a failure to flush queues since the
firmware already closed the queues after having parsed the
CSA IE. Then mac80211 would wait until the deauthentication
frame would go out (drv_flush(drop=false)) and that would
never happen.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mlme.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1282,6 +1282,16 @@ ieee80211_sta_process_chanswitch(struct
 					 cbss->beacon_interval));
 	return;
  drop_connection:
+	/*
+	 * This is just so that the disconnect flow will know that
+	 * we were trying to switch channel and failed. In case the
+	 * mode is 1 (we are not allowed to Tx), we will know not to
+	 * send a deauthentication frame. Those two fields will be
+	 * reset when the disconnection worker runs.
+	 */
+	sdata->vif.csa_active = true;
+	sdata->csa_block_tx = csa_ie.mode;
+
 	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
@@ -2454,6 +2464,7 @@ static void __ieee80211_disconnect(struc
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	bool tx;
 
 	sdata_lock(sdata);
 	if (!ifmgd->associated) {
@@ -2461,6 +2472,8 @@ static void __ieee80211_disconnect(struc
 		return;
 	}
 
+	tx = !sdata->csa_block_tx;
+
 	/* AP is probably out of range (or not reachable for another reason) so
 	 * remove the bss struct for that AP.
 	 */
@@ -2468,7 +2481,7 @@ static void __ieee80211_disconnect(struc
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
-			       true, frame_buf);
+			       tx, frame_buf);
 	mutex_lock(&local->mtx);
 	sdata->vif.csa_active = false;
 	ifmgd->csa_waiting_bcn = false;
@@ -2479,7 +2492,7 @@ static void __ieee80211_disconnect(struc
 	}
 	mutex_unlock(&local->mtx);
 
-	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), true,
+	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
 				    WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY);
 
 	sdata_unlock(sdata);


