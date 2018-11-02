Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D6C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91FD20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v36H+WBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91FD20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeKCD40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbeKCD40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:26 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B222082D;
        Fri,  2 Nov 2018 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184492;
        bh=U6G4mvS6MwXk5BPMC3O6hQtzSHwPfOi8nt6BUg+8d3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v36H+WBYTdmaRdQoeIGDEC3rKn7t6eWdjishfbLV3BLZdlDo1Pln/crqG+3j6HmLu
         +fXu4xJqDSMrLnipxDLtTQemzq/MkOUkOiMh6x1QEirp+Oh/+F/U9UPH6kBnaKWpOW
         dm5q0JD3IfnShNLecpHW+LUszjHKEC68z3sztW0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/143] nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
Date:   Fri,  2 Nov 2018 19:33:25 +0100
Message-Id: <20181102182858.704032734@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 30fe6d50eb088783c8729c7d930f65296b2b3fa7 ]

Use array_index_nospec() to sanitize ridx with respect to speculation.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3de415bca391..5e7c9b361e8a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3480,6 +3480,7 @@ static bool ht_rateset_to_mask(struct ieee80211_supported_band *sband,
 			return false;
 
 		/* check availability */
+		ridx = array_index_nospec(ridx, IEEE80211_HT_MCS_MASK_LEN);
 		if (sband->ht_cap.mcs.rx_mask[ridx] & rbit)
 			mcs[ridx] |= rbit;
 		else
-- 
2.17.1



