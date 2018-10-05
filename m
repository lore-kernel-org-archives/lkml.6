Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4129C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904F3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pswZfkIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904F3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeJEXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeJEXRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCAE208E7;
        Fri,  5 Oct 2018 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756276;
        bh=/jEupENCxSxdcp/WCuPUYvjf3pj7Z+Aw4HQCkUsEf0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pswZfkIZ/ATYNnfI3f3Sd+hrwX78X+3XVn5wXmo9WX74mjYpRjExLNmgN/z3wFWJB
         FHXv/cyzW0qcZLX+UP4cxpNS+MDRr8VsXnHXtUGyvHseiNknjc5HmZzAuf1xmBYwUO
         iUdguPk99WuLfeZZyFQa2bV4UTYrfod6917lTvxQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 4/6] net: hp100: fix always-true check for link up state
Date:   Fri,  5 Oct 2018 12:17:48 -0400
Message-Id: <20181005161750.20823-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161750.20823-1-sashal@kernel.org>
References: <20181005161750.20823-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit a7f38002fb69b44f8fc622ecb838665d0b8666af ]

The operation ~(p100_inb(VG_LAN_CFG_1) & HP100_LINK_UP) returns a value
that is always non-zero and hence the wait for the link to drop always
terminates prematurely.  Fix this by using a logical not operator instead
of a bitwise complement.  This issue has been in the driver since
pre-2.6.12-rc2.

Detected by CoverityScan, CID#114157 ("Logical vs. bitwise operator")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hp/hp100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hp/hp100.c b/drivers/net/ethernet/hp/hp100.c
index 76a6e0c77d69..034471003249 100644
--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -2637,7 +2637,7 @@ static int hp100_login_to_vg_hub(struct net_device *dev, u_short force_relogin)
 		/* Wait for link to drop */
 		time = jiffies + (HZ / 10);
 		do {
-			if (~(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
+			if (!(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
 				break;
 			if (!in_interrupt())
 				schedule_timeout_interruptible(1);
-- 
2.17.1

