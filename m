Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E76C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7A20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vtPjjdwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C7A20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKCD4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbeKCD43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:56:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557F32082D;
        Fri,  2 Nov 2018 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184495;
        bh=REXAdL1Tr0L/6uDZVVGOIyKzuGtHm+tZATWBCchcMrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtPjjdwPlptKBE0DUh34RLZN7AXJz1fLqzd9wkmSwKk+QMDTngkzY76epGvL4pHhh
         LimqjU+tnWBaSKotfW00IdWUizhoPaDF4TDE3x840FTjVqv76o2zmArdtqqhSNYmIy
         C0Q6y2wZHwbMH+qMzOgwd9KUgrKNy560TQ7yDiTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/143] mac80211_hwsim: do not omit multicast announce of first added radio
Date:   Fri,  2 Nov 2018 19:33:26 +0100
Message-Id: <20181102182858.772977455@linuxfoundation.org>
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

[ Upstream commit 28ef8b49a338dc1844e86b7954cfffc7dfa2660a ]

The allocation of hwsim radio identifiers uses a post-increment from 0,
so the first radio has idx 0. This idx is explicitly excluded from
multicast announcements ever since, but it is unclear why.

Drop that idx check and announce the first radio as well. This makes
userspace happy if it relies on these events.

Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index aafa7aa18fbd..477f9f2f6626 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2730,8 +2730,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	list_add_tail(&data->list, &hwsim_radios);
 	spin_unlock_bh(&hwsim_radio_lock);
 
-	if (idx > 0)
-		hwsim_mcast_new_radio(idx, info, param);
+	hwsim_mcast_new_radio(idx, info, param);
 
 	return idx;
 
-- 
2.17.1



