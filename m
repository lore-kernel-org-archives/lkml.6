Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A82098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="agty5svU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeJKXKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0A92098A;
        Thu, 11 Oct 2018 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272557;
        bh=y88qNM9u5KeWe0ZgE4KO/CqB8i3kQ3YXf9PfC61FC4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agty5svUc+GHWakW3D86RDJTkfTnLs4oDRcLt6N7POW9lzixju8eMapxzNJi+yyqt
         lSLcyreDlzWdMekopvuZhO2UqUBKiW88z00rK1Zo9ZmXLe27Gth0r8/J46Yp+tlR2b
         B4tmYtM++Tk6AebeBT/fL9/tZGS89wPchVV9iy5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 06/27] mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
Date:   Thu, 11 Oct 2018 17:34:53 +0200
Message-Id: <20181011152534.315780314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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
@@ -219,7 +219,7 @@ static int ieee80211_add_key(struct wiph
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 		/* Keys without a station are used for TX only */
-		if (key->sta && test_sta_flag(key->sta, WLAN_STA_MFP))
+		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
 		break;
 	case NL80211_IFTYPE_ADHOC:


