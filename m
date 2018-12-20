Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FBEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA6620811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299100;
	bh=w5IsztGGC1kFmGxqZkxZZvrhm5JVwnT4/6HYYsVr3vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXnifNi4u22azBMrs8GXpbuU4OWFbQT7cIsrhIaRigLTJyu9adyyg3gPM99RY/1cJ
	 IuxYnn+56e2E7s8QE5B94AbD0sd/dTdTGlraYlrsMmoV9+e6uOAkppQoZpTd8qTtuV
	 GaoJe9O0hMHhSZ0zABfwU6RapCMqnS/0MnVDPpYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbeLTJVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbeLTJVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6957F21720;
        Thu, 20 Dec 2018 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297677;
        bh=w5IsztGGC1kFmGxqZkxZZvrhm5JVwnT4/6HYYsVr3vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q06siYNCpNh4pMlwChR9HXmZuSkR324+YQVjRm66OkyuVjC3GAaE7Uw34mr51V26Y
         VsDbzFzAEN8PWR1jrEzNhp5bBhsY/06qGN/eJhgaogX6f2dnhNpMe1YJhm/Z+cfSga
         wsWrTYvhd5gaeTdVVJ94W0T0xQe5iFCnLHvzEqDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 17/40] mac80211: Fix condition validating WMM IE
Date:   Thu, 20 Dec 2018 10:18:29 +0100
Message-Id: <20181220085827.161507587@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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
index 51f31e77c19b..ed4fef32b394 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1886,7 +1886,7 @@ static bool ieee80211_sta_wmm_params(struct ieee80211_local *local,
 		params[ac].acm = acm;
 		params[ac].uapsd = uapsd;
 
-		if (params->cw_min == 0 ||
+		if (params[ac].cw_min == 0 ||
 		    params[ac].cw_min > params[ac].cw_max) {
 			sdata_info(sdata,
 				   "AP has invalid WMM params (CWmin/max=%d/%d for ACI %d), using defaults\n",
-- 
2.19.1



