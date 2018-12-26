Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFCDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08E214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865228;
	bh=gO2s7wweSAC6UEPBGmWBoNc7yRmP6whsoZIHB7b6zlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1DkpSRrxXA4kjGsEejOIAA3K2SHGp3NsDk+9seCUGt4ZowCcdlDx1va4X1LQqtHk7
	 lvCvMtmIz7G08h3EDWm16G6VJW4fPaYsyMo/E3oLbFtaXS3Io+B23krsM2/layfZWw
	 5KLGiJ2A96MByeVeyRU1uesT3+gtyFJQaPkFoUMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbeLZXA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeLZWx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:53:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DF5218A5;
        Wed, 26 Dec 2018 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864837;
        bh=gO2s7wweSAC6UEPBGmWBoNc7yRmP6whsoZIHB7b6zlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1OofBc4KBZ+A4j2k/g9yw0WZ9VZqGuyHZqwpNf5fAD4tN7hk1kdpf46EhRcwVzZ6
         mhmgDS0Asgb0ceC6oxaQf+vdDntwbgsWRwLqkFFLr4+8n9ukPoH20dNLTpDGqumsZd
         Wz1kZdFF6RZ5uc6+EhqqSmMTBTIYI09n6ClU6A3s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Poirier <bpoirier@suse.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/35] xfrm: Fix bucket count reported to userspace
Date:   Wed, 26 Dec 2018 17:41:14 -0500
Message-Id: <20181226224142.150866-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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
index 71a94e549301..884f2136b34b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -641,7 +641,7 @@ void xfrm_sad_getinfo(struct net *net, struct xfrmk_sadinfo *si)
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

