Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543969;
	bh=IS/kF7hY9pHqT51+4aL3u3Vr7Y1qvb4C2iWsq5reQ4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSQ1D68kkum3Ol/EbH+6umbhXdAZJHSOUqD6OCQObD+uxNnBkoOJK7UKgyQ2m/KUx
	 7rtWWUOTV5I6eM5WhC+S689YPagCZu1VWjmYuLgDnGrNoMURM8/veA0cfMT+hn8yPX
	 rUzw4CZD3BmBm5BK9p1UOTTSBWhzUPGaj98zCVc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeLKP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731119AbeLKP66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABFE208E7;
        Tue, 11 Dec 2018 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543938;
        bh=IS/kF7hY9pHqT51+4aL3u3Vr7Y1qvb4C2iWsq5reQ4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNPXcE7aLgxlvR8/uemdnE3sMHY1mrBvuUSQR08EDgFQLXonlMYsNbNA6aHZDlIs+
         /gfSeXJ5eUKWJVlgktv4JBbxQQ72+GdHpX8R09hWVxd1V/J2ArvKEWRKUaFQOOtK9j
         VT5H8CflVAj2Ey34DNkzWqSrfP8cQ12z4nuzTKKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 115/118] mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
Date:   Tue, 11 Dec 2018 16:42:14 +0100
Message-Id: <20181211151648.902892295@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -964,6 +964,8 @@ void ieee80211_tx_status_ext(struct ieee
 			/* Track when last TDLS packet was ACKed */
 			if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
 				sta->status_stats.last_tdls_pkt_time = jiffies;
+		} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
+			return;
 		} else {
 			ieee80211_lost_packet(sta, info);
 		}


