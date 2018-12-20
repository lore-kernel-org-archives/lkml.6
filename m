Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9668C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EC1217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297839;
	bh=pbZlX9dRLHGm5WWGC+4NYR7mFa4ciru9AiQlPpd3gVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Id1VrQAVLzzkNRLFadWrPgsiSexyqAfYnuDudVUpH3+V/Tw6KsTnP35brpP70otG8
	 aaUoV9efWw8EugEsTZAIygc0bdx1OSuiywSiPJVpIdK83jg/D5wslzzGwGcc0PCJxx
	 DSg+a43HFy3TkjGoaTYUX2LLXH+DeOSmzJPnjnt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbeLTJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbeLTJXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73ADD20656;
        Thu, 20 Dec 2018 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297834;
        bh=pbZlX9dRLHGm5WWGC+4NYR7mFa4ciru9AiQlPpd3gVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaruT+J4yE8ba4gfQb9SXIf4KEGrVIse7FQEzJO+hOhZhUS7lyTg2clKwAwEXq3Sc
         XmCX5hsvg9Up0EAjwRzcG5bzSliZr40bWTFILLCTMo6rXMfF0R0rM/gbtg63G9vFeY
         Cuv2rDtP0aakypht21RDBoHZcOXQu/5MnyEnjilo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 17/61] mac80211: dont WARN on bad WMM parameters from buggy APs
Date:   Thu, 20 Dec 2018 10:18:17 +0100
Message-Id: <20181220085844.421283135@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c470bdc1aaf36669e04ba65faf1092b2d1c6cabe ]

Apparently, some APs are buggy enough to send a zeroed
WMM IE. Don't WARN on this since this is not caused by a bug
on the client's system.

This aligns the condition of the WARNING in drv_conf_tx
with the validity check in ieee80211_sta_wmm_params.
We will now pick the default values whenever we get
a zeroed WMM IE.

This has been reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=199161

Fixes: f409079bb678 ("mac80211: sanity check CW_min/CW_max towards driver")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 39451c84c785..7811650e76c4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1867,7 +1867,8 @@ static bool ieee80211_sta_wmm_params(struct ieee80211_local *local,
 		params[ac].acm = acm;
 		params[ac].uapsd = uapsd;
 
-		if (params[ac].cw_min > params[ac].cw_max) {
+		if (params->cw_min == 0 ||
+		    params[ac].cw_min > params[ac].cw_max) {
 			sdata_info(sdata,
 				   "AP has invalid WMM params (CWmin/max=%d/%d for ACI %d), using defaults\n",
 				   params[ac].cw_min, params[ac].cw_max, aci);
-- 
2.19.1



