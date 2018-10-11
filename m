Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D65C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1C321476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy9YPq3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1C321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbeJKXIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6F52098A;
        Thu, 11 Oct 2018 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272446;
        bh=NRyY4MwnsQIUbUSeqTyAxMibe9ve0sXAVkVQSMFp8Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fy9YPq3L1PQwmgAjFmtmGgA4PksbVAVBdiNDn9GhJEvpIjNLPdmCMw95MzxpMxHP4
         /8VhfHZkhYXf1nMhQs0RCVNlyDUmORB9WH1ugLqYY804cMlpx2dsvTHPR35c7Fo6HH
         PMxBUu1r1msLLzsfBtNyAFS21ts0wsFl2R2Lhzbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 105/120] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
Date:   Thu, 11 Oct 2018 17:34:46 +0200
Message-Id: <20181011152554.123032832@linuxfoundation.org>
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
@@ -210,7 +210,7 @@ static int ieee80211_add_key(struct wiph
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 		/* Keys without a station are used for TX only */
-		if (key->sta && test_sta_flag(key->sta, WLAN_STA_MFP))
+		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
 		break;
 	case NL80211_IFTYPE_ADHOC:


