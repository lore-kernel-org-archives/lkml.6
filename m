Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C433C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE82921741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863805;
	bh=FHMKX2/yZ8rRB/qDm6kNevReEcoWt+DC07KaLQ92Sf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WtRNmMJo5a3eb5NWtJhn8+cyQ2vOsUBn8G5UPpIUcTzJnYYxjKGEOkzWKgPO9O9oi
	 s4QGQugehV6SnB90Xr1HascP57Nq+EUq2mTUY25uDQ0X/DlKSL3C08pD4yeUSR/34o
	 uU7vcKyizAquGvTYCJYaBKqZdQRXZJaZIs2awBa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeLZWgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbeLZWgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E00218E2;
        Wed, 26 Dec 2018 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863802;
        bh=FHMKX2/yZ8rRB/qDm6kNevReEcoWt+DC07KaLQ92Sf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzU3qJzvTKrv3/4mkQEwjcowSrSj65X8/3gvRcz/J+v/nXiHKOoaUKGrMla5GA1ND
         rV+r5H8tQgw5qFyUV3GiwGhsA1UITUWC+xuWUgZVyYkiA7p+aIur5QC5n1qVmlZgj4
         YjgB/pCbUfq0/55PWJ7/6Vrh2RShHWtijNAWFNb0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/97] nfp: flower: ensure TCP flags can be placed in IPv6 frame
Date:   Wed, 26 Dec 2018 17:34:48 -0500
Message-Id: <20181226223557.149329-28-sashal@kernel.org>
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

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit 290974d434783624c13a9530a23c45f9c5ffe018 ]

Previously we did not ensure tcp flags have a place to be stored
when using IPv6. We correct this by including IPv6 key layer when
we match tcp flags and the IPv6 key layer has not been included
already.

Fixes: 07e1671cfca5 ("nfp: flower: refactor shared ip header in match offload")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/netronome/nfp/flower/offload.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index bd19624f10cf..90148dbb261b 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -375,13 +375,29 @@ nfp_flower_calculate_key_layers(struct nfp_app *app,
 		    !(tcp_flags & (TCPHDR_FIN | TCPHDR_SYN | TCPHDR_RST)))
 			return -EOPNOTSUPP;
 
-		/* We need to store TCP flags in the IPv4 key space, thus
-		 * we need to ensure we include a IPv4 key layer if we have
-		 * not done so already.
+		/* We need to store TCP flags in the either the IPv4 or IPv6 key
+		 * space, thus we need to ensure we include a IPv4/IPv6 key
+		 * layer if we have not done so already.
 		 */
-		if (!(key_layer & NFP_FLOWER_LAYER_IPV4)) {
-			key_layer |= NFP_FLOWER_LAYER_IPV4;
-			key_size += sizeof(struct nfp_flower_ipv4);
+		if (!key_basic)
+			return -EOPNOTSUPP;
+
+		if (!(key_layer & NFP_FLOWER_LAYER_IPV4) &&
+		    !(key_layer & NFP_FLOWER_LAYER_IPV6)) {
+			switch (key_basic->n_proto) {
+			case cpu_to_be16(ETH_P_IP):
+				key_layer |= NFP_FLOWER_LAYER_IPV4;
+				key_size += sizeof(struct nfp_flower_ipv4);
+				break;
+
+			case cpu_to_be16(ETH_P_IPV6):
+				key_layer |= NFP_FLOWER_LAYER_IPV6;
+				key_size += sizeof(struct nfp_flower_ipv6);
+				break;
+
+			default:
+				return -EOPNOTSUPP;
+			}
 		}
 	}
 
-- 
2.19.1

