Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8FD2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865296;
	bh=ZYES8ImQVaWi/uX6XKLdG4qtbKCYnhbDjdcjqULrxVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6EIwhvUrXGwvzGVn5xrMgSTGo2OPBUz4jp3tKNOluHRqdrEef3XXvrKHvugioLRq
	 ZKyc2BfpxM4TG08fDORhXdF0kI/G/z6VxCWvHw4RG3WXJJWRqYxOJIFgKRd4V8I+Jq
	 NGIxlDjalWTTAlrfc4cbkSkvX4iNBfGFEhAa0cZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbeLZXBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeLZWg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 899B021741;
        Wed, 26 Dec 2018 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863786;
        bh=ZYES8ImQVaWi/uX6XKLdG4qtbKCYnhbDjdcjqULrxVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcpbNd/laFvclloIql0CYBaN00bb5J+NgROTV+hdziFzsIbSP1rNAXYZTxLVkiNWP
         1wjog9Hfg9nczuga+Klf7lOURTp4F9WMDiWpnmG0fQahceu5Ttc6Fji17+tYuBrpAg
         BAbM3fix8gtRZLEqweuTao3uwKbRf/XNSzvHkpY8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Poirier <bpoirier@suse.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/97] xfrm: Fix bucket count reported to userspace
Date:   Wed, 26 Dec 2018 17:34:37 -0500
Message-Id: <20181226223557.149329-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Poirier <bpoirier@suse.com>

[ Upstream commit ca92e173ab34a4f7fc4128bd372bd96f1af6f507 ]

sadhcnt is reported by `ip -s xfrm state count` as "buckets count", not the
hash mask.

Fixes: 28d8909bc790 ("[XFRM]: Export SAD info.")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index b669262682c9..12cdb350c456 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -788,7 +788,7 @@ void xfrm_sad_getinfo(struct net *net, struct xfrmk_sadinfo *si)
 {
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	si->sadcnt = net->xfrm.state_num;
-	si->sadhcnt = net->xfrm.state_hmask;
+	si->sadhcnt = net->xfrm.state_hmask + 1;
 	si->sadhmcnt = xfrm_state_hashmax;
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 }
-- 
2.19.1

