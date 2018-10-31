Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC9DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE8920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2vuN0H89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeKAIII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbeKAIIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6C620664;
        Wed, 31 Oct 2018 23:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027276;
        bh=rBj1VNHYKWFDnGeoONJEY/CgzqejkcKemJ7jY1hdUCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=2vuN0H89Jw7mNSPylhuxnqmV/Z9r01wXRNhwp7w3yZU0xdFq8+UEKG2PBL0Z2bCEk
         rGCn/z8bqPG64/wCktqlVzLLFvPmYg18vB8OqUDbowEMFKdRbeFB2Bw5D/3Vy2FyLA
         azknR7YjnUPrc1njHp4BDGFlsvGRgeOJmQL+jjtA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 001/126] net: socionext: Reset tx queue in ndo_stop
Date:   Wed, 31 Oct 2018 19:05:49 -0400
Message-Id: <20181031230754.29029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahisa Kojima <masahisa.kojima@linaro.org>

[ Upstream commit 8d5b0bf611ec5b7618d5b772dddc93b8afa78cb8 ]

We observed that packets and bytes count are not reset
when user performs interface down. Eventually, tx queue is
exhausted and packets will not be sent out.
To avoid this problem, resets tx queue in ndo_stop.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index e080d3e7c582..4d7d53fbc0ef 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -945,6 +945,9 @@ static void netsec_uninit_pkt_dring(struct netsec_priv *priv, int id)
 	dring->head = 0;
 	dring->tail = 0;
 	dring->pkt_cnt = 0;
+
+	if (id == NETSEC_RING_TX)
+		netdev_reset_queue(priv->ndev);
 }
 
 static void netsec_free_dring(struct netsec_priv *priv, int id)
-- 
2.17.1

