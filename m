Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B85C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59C2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAzWVxog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B59C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJHWht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbeJHWhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:37:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203DC20C0A;
        Mon,  8 Oct 2018 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012333;
        bh=X1So3z3Z1o7n3Sex1lADRoUAKw+eA85G029uKSwObio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAzWVxogRgf16F724tlblg+hPpLsf/iN16JUyyRytS6fJkqSVi3dfzd8l81iFP8mw
         4162fNopQMdq5C0iCEG8ghwlyFuxR5CKFiS/Rp+uCOPCARuobfyWXxR1kJQYYxE9mB
         GBcEGQp8IsF5d8tM/C4KwTmb2sO0Xby9lfKH+M7s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/58] batman-adv: Avoid probe ELP information leak
Date:   Mon,  8 Oct 2018 11:24:31 -0400
Message-Id: <20181008152523.70705-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 88d0895d0ea9d4431507d576c963f2ff9918144d ]

The probe ELPs for WiFi interfaces are expanded to contain at least
BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
number of bytes which the template ELP packet requires.

These extra padding bytes were not initialized and thus could contain data
which were previously stored at the same location. It is therefore required
to set it to some predefined or random values to avoid leaking private
information from the system transmitting these kind of packets.

Fixes: e4623c913508 ("batman-adv: Avoid probe ELP information leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 71c20c1d4002..e103c759b7ab 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -241,7 +241,7 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 		 * the packet to be exactly of that size to make the link
 		 * throughput estimation effective.
 		 */
-		skb_put(skb, probe_len - hard_iface->bat_v.elp_skb->len);
+		skb_put_zero(skb, probe_len - hard_iface->bat_v.elp_skb->len);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Sending unicast (probe) ELP packet on interface %s to %pM\n",
-- 
2.17.1

