Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7782146D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys1zEcHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7782146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeKIHhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbeKIHhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:35 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CCA20818;
        Thu,  8 Nov 2018 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714406;
        bh=1ZQIUfafpALwGjhV7vIQ/baY1BJv3QoWn+FjsXf3WQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ys1zEcHq16dS9mPPmml/TR9uD1OzyIToCcRhbtlgu1PN6X7kUUWVgW1BEZ7LccIMx
         lJmM9vw9fsc00HIGdDSx6YU0a5wO7YiOpPJb8OhYjMwjTbTXNFqBTROMiQiR6rNOcz
         3OEATF4JeFEcEi2AWX5MoP1vX02RAxg3gOfvmT5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 063/114] l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()
Date:   Thu,  8 Nov 2018 13:51:18 -0800
Message-Id: <20181108215106.791041209@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
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
@@ -184,14 +184,15 @@ pass_up:
 
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
@@ -196,14 +196,15 @@ pass_up:
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



