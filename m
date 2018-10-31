Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC48C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9FE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9YM54d8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9FE20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKAIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeKAIFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:05:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A28420664;
        Wed, 31 Oct 2018 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027143;
        bh=tin9VUn5KBBLYgnFfPiCXX+PD8SLNdQ9X2aZueU12go=;
        h=From:To:Cc:Subject:Date:From;
        b=B9YM54d8eUvfjAoZuOpjvyOl4C0G6SSFCGsYSw+BTwQHQDJhOmZppUYmIBCDT7hUy
         jE+m2KjqCQFdXj5/6YCkL/w9JDPouyBG1bhwfy5IYjphVX4+5f48HTBO1KEl1x3jQ4
         eQOZO6+VdbJF/XSnJkPdggFSxUepQSpcLG1Wz9ms=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 001/146] net: socionext: Reset tx queue in ndo_stop
Date:   Wed, 31 Oct 2018 19:03:16 -0400
Message-Id: <20181031230541.28822-1-sashal@kernel.org>
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
index 4289ccb26e4e..d2caeb9edc04 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -940,6 +940,9 @@ static void netsec_uninit_pkt_dring(struct netsec_priv *priv, int id)
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

