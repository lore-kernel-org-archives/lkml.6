Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63965ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o94h+rHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7D020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeJYWvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeJYWvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:15 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154D420848;
        Thu, 25 Oct 2018 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477098;
        bh=IEexwwnoaRZYytJY/FsV741LpT+N2oaiJeH0dewf+qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o94h+rHQt+TYaL8knHUushp+qXvPBHyr8w6Bt054FWAnJPV2x9mAiu2yY4RkaM4Fq
         vSxYHu248hYFPGQF4JoKToo8VdrTPiRttC4d6ETnVtGS1RhEN5zDIewqwEcUXU2IM9
         jGzrROnGi29ejsidtJ+ue03OH/eUQjkcbxYYGUMs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guillaume Nault <g.nault@alphalink.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 45/65] l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()
Date:   Thu, 25 Oct 2018 10:16:45 -0400
Message-Id: <20181025141705.213937-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Nault <g.nault@alphalink.fr>

[ Upstream commit a3c18422a4b4e108bcf6a2328f48867e1003fd95 ]

Socket must be held while under the protection of the l2tp lock; there
is no guarantee that sk remains valid after the read_unlock_bh() call.

Same issue for l2tp_ip and l2tp_ip6.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ip.c  | 11 ++++++-----
 net/l2tp/l2tp_ip6.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 48ab93842322..c7e6098c924e 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -184,14 +184,15 @@ static int l2tp_ip_recv(struct sk_buff *skb)
 
 		read_lock_bh(&l2tp_ip_lock);
 		sk = __l2tp_ip_bind_lookup(net, iph->daddr, 0, tunnel_id);
+		if (!sk) {
+			read_unlock_bh(&l2tp_ip_lock);
+			goto discard;
+		}
+
+		sock_hold(sk);
 		read_unlock_bh(&l2tp_ip_lock);
 	}
 
-	if (sk == NULL)
-		goto discard;
-
-	sock_hold(sk);
-
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_put;
 
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index bcdab1cba773..5fe0a6f6af3d 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -196,14 +196,15 @@ static int l2tp_ip6_recv(struct sk_buff *skb)
 		read_lock_bh(&l2tp_ip6_lock);
 		sk = __l2tp_ip6_bind_lookup(&init_net, &iph->daddr,
 					    0, tunnel_id);
+		if (!sk) {
+			read_unlock_bh(&l2tp_ip6_lock);
+			goto discard;
+		}
+
+		sock_hold(sk);
 		read_unlock_bh(&l2tp_ip6_lock);
 	}
 
-	if (sk == NULL)
-		goto discard;
-
-	sock_hold(sk);
-
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 		goto discard_put;
 
-- 
2.17.1

