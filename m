Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70F20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yalr4Adw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A70F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeK2RJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:09:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeK2RJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:09:18 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDC42086B;
        Thu, 29 Nov 2018 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471506;
        bh=ppjPW4VdteKhB0lKcR4N38H4GWiHyzm1PLSRBwSRRYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yalr4AdwrBAocSQzxdTo2K6PKNVw8zCQTbYNw03NUBuDIY7keX/KP2GedUFlyOavW
         Wc3Nw5gKhKHezF7To6Ih6cDJ9cxGyncxlrbx4G+rkJ9q3J2oStA7GGkJFAb8Bas+lR
         aQTwOyuIvC0gjB0u7D+mePS3hIOJRHTO/G1b4AuM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/13] qed: Fix PTT leak in qed_drain()
Date:   Thu, 29 Nov 2018 01:04:37 -0500
Message-Id: <20181129060444.160434-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060444.160434-1-sashal@kernel.org>
References: <20181129060444.160434-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit 9aaa4e8ba12972d674caeefbc5f88d83235dd697 ]

Release PTT before entering error flow.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 35e1468d8196..b8ae6ed5c7ba 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1124,9 +1124,9 @@ static int qed_drain(struct qed_dev *cdev)
 			return -EBUSY;
 		}
 		rc = qed_mcp_drain(hwfn, ptt);
+		qed_ptt_release(hwfn, ptt);
 		if (rc)
 			return rc;
-		qed_ptt_release(hwfn, ptt);
 	}
 
 	return 0;
-- 
2.17.1

