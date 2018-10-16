Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A8FC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AC32145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQqJ1oEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AC32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJPMB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJPMB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04FA2148C;
        Tue, 16 Oct 2018 04:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663215;
        bh=UaHElfiqchPHBa2BINHijD7rcfWc55ShWaaVv1Hfwgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQqJ1oEii997Bz1bri/V18eZoPktP6txCAwT1cnPp4i8qWx2cI6gaSsnkTS+mvoTu
         DnqNqenrfd50+2Sko4QKwZxYcgx6QvrAM0ddIcDOY8Juo6oTX1DdZ/XVTU2d7m0cU1
         XpCw7VOuFJv/wZuDh+yGB+kpIFv1Oud9gV+ZyWns=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mahesh Bandewar <maheshb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 077/100] bonding: fix warning message
Date:   Tue, 16 Oct 2018 00:11:58 -0400
Message-Id: <20181016041221.135528-77-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 0f3b914c9cfcd7bbedd445dc4ac5dd999fa213c2 ]

RX queue config for bonding master could be different from its slave
device(s). With the commit 6a9e461f6fe4 ("bonding: pass link-local
packets to bonding master also."), the packet is reinjected into stack
with skb->dev as bonding master. This potentially triggers the
message:

   "bondX received packet on queue Y, but number of RX queues is Z"

whenever the queue that packet is received on is higher than the
numrxqueues on bonding master (Y > Z).

Fixes: 6a9e461f6fe4 ("bonding: pass link-local packets to bonding master also.")
Reported-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1c2d25a603c1..2b01180be834 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1194,6 +1194,7 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
 
 		if (nskb) {
 			nskb->dev = bond->dev;
+			nskb->queue_mapping = 0;
 			netif_rx(nskb);
 		}
 		return RX_HANDLER_PASS;
-- 
2.17.1

