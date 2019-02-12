Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D079C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599721855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBLBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:33:11 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:41574 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBLBdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:33:11 -0500
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id tMoog3t3S8uQmtMopgllL1; Mon, 11 Feb 2019 18:25:04 -0700
X-Authority-Analysis: v=2.3 cv=XKpOtjpE c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=CFTnQlWoA9kA:10 a=Q-fNiiVtAAAA:8 a=HXjB05T0r80QQ8cVDO8A:9 a=rT-qB4xickcA:10
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 65126300BE54A8; Mon, 11 Feb 2019 17:25:02 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] soc: brcmstb: dpfe: use msleep() over udelay()
Date:   Mon, 11 Feb 2019 17:24:41 -0800
Message-Id: <20190212012443.21819-2-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212012443.21819-1-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOa8J4srZrEhN50tTn1MOEt4JADVRPQ3WY0JU3yK0hx3Bs2r/IhI2aBu2sI5gxJnjcBuj3wpyTeNKOu94PUw2w6OzP5xySKUlezUWW3MSHK3owKrpfvF
 5aEDVxgG2b9ynBYcu3BNMyLxfM3sFhBqZs0nEr2Gc+GzUXmLPofEqJh89F6tF/tkJrqCbM4XiGF2ATVXAC0ZH4JuvnivbeSgUfgzlcZea3LvwT+CXWl9imps
 0+K8JWRAz1b1Ni+M4JWyqQBhQpilGwKZpH/8l3cfQGJODj6gTBLuU1Zy/Hr0P6BKsSrhFwcFs8bVqQfI/UwvL5P2WGEIjR9sn+GASnFeNjc99EczLOfmU7AX
 TJcKLS1bGi18Tm1eRCUrhI9mxVmvrLwVoog+oM3VYa8Lv5zqxAiFGa1aXrLUVo9ZZN4BVKn/7jldeblm1fTNOiNiKp+kZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

To be more "scheduler friendly", we use msleep() rather than udelay()
while we wait for the DCPU to respond.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 04599eccd604..8e1ccdb0e59d 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -111,7 +111,7 @@
 #define DPFE_MSG_TYPE_COMMAND	1
 #define DPFE_MSG_TYPE_RESPONSE	2
 
-#define DELAY_LOOP_MAX		200000
+#define DELAY_LOOP_MAX		1000
 
 enum dpfe_msg_fields {
 	MSG_HEADER,
@@ -323,7 +323,7 @@ static int __send_command(struct private_data *priv, unsigned int cmd,
 		resp = readl_relaxed(regs + REG_TO_HOST_MBOX);
 		if (resp > 0)
 			break;
-		udelay(5);
+		msleep(1);
 	}
 
 	if (i == DELAY_LOOP_MAX) {
-- 
2.17.1

