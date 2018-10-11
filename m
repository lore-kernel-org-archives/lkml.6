Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BA2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA83721476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez9NEQv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA83721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeJKXLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbeJKXLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9783321476;
        Thu, 11 Oct 2018 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272643;
        bh=uVGJ32s+FPiqJYe8VVJZs/dIIR3SdSuyeEVEalR+1yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ez9NEQv1P0XIe5qkDQ2FoMfNTsZn7TSigl2OYt0z2sLUA/jPazIpC9A3Rk9Cbz2vE
         XqPNcqe7t45P/I4VhY5YoGN5fFvIY+5J4Wruynz7mIhMgko1Z1d9IEEjZCkrnFPQgX
         rzhCfSyD/jmm5GLF75ZGNqEM5YEQQGZG2BFXCq3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 07/35] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
Date:   Thu, 11 Oct 2018 17:35:09 +0200
Message-Id: <20181011152520.475100983@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 211710ca74adf790b46ab3867fcce8047b573cd1 upstream.

key->sta is only valid after ieee80211_key_link, which is called later
in this function. Because of that, the IEEE80211_KEY_FLAG_RX_MGMT is
never set when management frame protection is enabled.

Fixes: e548c49e6dc6b ("mac80211: add key flag for management keys")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/cfg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -386,7 +386,7 @@ static int ieee80211_add_key(struct wiph
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 		/* Keys without a station are used for TX only */
-		if (key->sta && test_sta_flag(key->sta, WLAN_STA_MFP))
+		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
 		break;
 	case NL80211_IFTYPE_ADHOC:


