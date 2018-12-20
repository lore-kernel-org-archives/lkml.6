Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7848C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A393120656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298100;
	bh=+Qqfbg4II23FUuZqQJ+GCFdY6r+P+zyOOIsRYWuZg64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFTJo3gDAquM0pT4O+7FBDE1nk4PN8HACV+9BArn8fTfl1A3Ro19EkgNG51zq0vrp
	 8DMy5flda8HrVPGHpsMtlTmwfAc3cRbHiDh2T1kV+0QpBby6jF/gFnnEVy2vdNDXnd
	 YjQnKwvOFQP9rOwFxSzPaRa51nh74Fsdz3iAgB1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeLTJ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbeLTJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362B220989;
        Thu, 20 Dec 2018 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298096;
        bh=+Qqfbg4II23FUuZqQJ+GCFdY6r+P+zyOOIsRYWuZg64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkNbs0B3/PjOpkjjQbX0QBkxfVZyLHEvBEga3DOLwGTwlwRvijtUxqOkYu4spicq1
         ya8wG/7bGPSMTKM43GmHBsEFOYb8Htxa2PnMK64htM0xYmSvFzROBct48+umnQRcEw
         3NdQGXfFUzYpUKaInz6fF+fPnaw1r4qLM8f7jXi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/72] mac80211: Fix condition validating WMM IE
Date:   Thu, 20 Dec 2018 10:18:32 +0100
Message-Id: <20181220085923.646831980@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 911a26484c33e10de6237228ca1d7293548e9f49 ]

Commit c470bdc1aaf3 ("mac80211: don't WARN on bad WMM parameters from
buggy APs") handled cases where an AP reports a zeroed WMM
IE. However, the condition that checks the validity accessed the wrong
index in the ieee80211_tx_queue_params array, thus wrongly deducing
that the parameters are invalid. Fix it.

Fixes: c470bdc1aaf3 ("mac80211: don't WARN on bad WMM parameters from buggy APs")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 75909a744121..4c59b5507e7a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1861,7 +1861,7 @@ static bool ieee80211_sta_wmm_params(struct ieee80211_local *local,
 		params[ac].acm = acm;
 		params[ac].uapsd = uapsd;
 
-		if (params->cw_min == 0 ||
+		if (params[ac].cw_min == 0 ||
 		    params[ac].cw_min > params[ac].cw_max) {
 			sdata_info(sdata,
 				   "AP has invalid WMM params (CWmin/max=%d/%d for ACI %d), using defaults\n",
-- 
2.19.1



