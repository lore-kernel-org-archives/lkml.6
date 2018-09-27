Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AB6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9B921582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9B921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeI0P1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:27:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeI0P1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:27:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8664110A4;
        Thu, 27 Sep 2018 09:10:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 15/88] net: dsa: mv88e6xxx: Fix ATU Miss Violation
Date:   Thu, 27 Sep 2018 11:02:56 +0200
Message-Id: <20180927090302.318677896@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit ddca24dfcf1bec608668dd44c45d49397b70f520 ]

Fix a cut/paste error and a typo which results in ATU miss violations
not being reported.

Fixes: 0977644c5005 ("net: dsa: mv88e6xxx: Decode ATU problem interrupt")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/global1.h     |    2 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -128,7 +128,7 @@
 #define MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION		0x7000
 #define MV88E6XXX_G1_ATU_OP_AGE_OUT_VIOLATION		BIT(7)
 #define MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION		BIT(6)
-#define MV88E6XXX_G1_ATU_OP_MISS_VIOLTATION		BIT(5)
+#define MV88E6XXX_G1_ATU_OP_MISS_VIOLATION		BIT(5)
 #define MV88E6XXX_G1_ATU_OP_FULL_VIOLATION		BIT(4)
 
 /* Offset 0x0C: ATU Data Register */
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -349,7 +349,7 @@ static irqreturn_t mv88e6xxx_g1_atu_prob
 		chip->ports[entry.portvec].atu_member_violation++;
 	}
 
-	if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
+	if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
 		dev_err_ratelimited(chip->dev,
 				    "ATU miss violation for %pM portvec %x\n",
 				    entry.mac, entry.portvec);


