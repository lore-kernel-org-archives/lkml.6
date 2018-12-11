Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F03C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C5520645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544927;
	bh=f60XhGnVUxrXVMGRhmpElIbbF7i6TQwHKpgMBXSR8Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDUbQUQdUtPaKhgdBUPaQgPBEs/b9dSr5WKOICfvHS/MEHqYfCNl9ZfUzdWrh3f7+
	 eny/+hs56hrHa7BT5mF7CRz6Dwv+ON3YCDP8FdwQiQOKYxI2EmTessXBZSDKpPNmoE
	 zM/S7Ro0b4yegFqXAoWnHUPQxKGZbtBNV0jIadHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C5520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeLKPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbeLKPsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E65D20989;
        Tue, 11 Dec 2018 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543319;
        bh=f60XhGnVUxrXVMGRhmpElIbbF7i6TQwHKpgMBXSR8Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwM3I72/R8gg7BsMB8e9A+RvKSHxt+fY/8LVYMImhwmPawFidoepHh33U1vjhpHrP
         Q51h9OCWf4M+oklBaIsei1vYP/joqHw+44Ad48lJGgBCFPeaWoPwf5E2abj/vGMhU7
         lDkSMFyj/r50tAMUvpWUNAS26ZJDOc1g7ROnHdgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 89/91] mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
Date:   Tue, 11 Dec 2018 16:41:48 +0100
Message-Id: <20181211151614.178747372@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit a317e65face482371de30246b6494feb093ff7f9 upstream.

Make it behave like regular ieee80211_tx_status calls, except for the lack of
filtered frame processing.
This fixes spurious low-ack triggered disconnections with powersave clients
connected to an AP.

Fixes: f027c2aca0cf4 ("mac80211: add ieee80211_tx_status_noskb")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/status.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -648,6 +648,8 @@ void ieee80211_tx_status_noskb(struct ie
 			/* Track when last TDLS packet was ACKed */
 			if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
 				sta->status_stats.last_tdls_pkt_time = jiffies;
+		} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
+			return;
 		} else {
 			ieee80211_lost_packet(sta, info);
 		}


