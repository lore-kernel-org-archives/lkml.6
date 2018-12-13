Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D43C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F49820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676484;
	bh=Kfhh0RiAApLoSFBsIZuV0dTWqC/lhOlUUV5GbglnF48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6wxXuilAz1LJLE8hJoyUu71xcsb1+LEeYm/Ied/8JRHSZcBpM1UvHH3ha956B4GQ
	 4gLXUzzCmE+5NS14SNC7TRaQH+v5RoFjJn4b3JMGdhFrShJvwM1oAl/b8a4PKJirza
	 uuu4HXG1odsxh2eURP3Q+VUItW/mzD7N2ni2N3RM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F49820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeLMEsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbeLMEaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9640920880;
        Thu, 13 Dec 2018 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675408;
        bh=Kfhh0RiAApLoSFBsIZuV0dTWqC/lhOlUUV5GbglnF48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkA4i9twPFTtxd6ZCgTCEWCDXtC8M7LyzLTPNS4j+DXzTucRtlW4UIA9Y2UULu6ip
         RTvBsKuBDOLsgO9rmEEL4ZVUj1hLB4kdVaSBHxLM46YCEucuPGbDLW51EKQ3cVzjc+
         eYov1vj40Y9AmeKWy8uVo+blV+6y0yR7rJ+9YYPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anderson Luiz Alves <alacn1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/73] mv88e6060: disable hardware level MAC learning
Date:   Wed, 12 Dec 2018 23:28:12 -0500
Message-Id: <20181213042838.75160-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anderson Luiz Alves <alacn1@gmail.com>

[ Upstream commit a74515604a7b171f2702bdcbd1e231225fb456d0 ]

Disable hardware level MAC learning because it breaks station roaming.
When enabled it drops all frames that arrive from a MAC address
that is on a different port at learning table.

Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6060.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 65f10fec25b3..0b3e51f248c2 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -116,8 +116,7 @@ static int mv88e6060_switch_reset(struct dsa_switch *ds)
 	/* Reset the switch. */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
 		  GLOBAL_ATU_CONTROL_SWRESET |
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	/* Wait up to one second for reset to complete. */
 	timeout = jiffies + 1 * HZ;
@@ -142,13 +141,10 @@ static int mv88e6060_setup_global(struct dsa_switch *ds)
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_CONTROL, GLOBAL_CONTROL_MAX_FRAME_1536);
 
-	/* Enable automatic address learning, set the address
-	 * database size to 1024 entries, and set the default aging
-	 * time to 5 minutes.
+	/* Disable automatic address learning.
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	return 0;
 }
-- 
2.19.1

