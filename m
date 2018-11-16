Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7948C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B704F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B704F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeKQIZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:25:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36535 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:25:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id r127-v6so20901724oie.3;
        Fri, 16 Nov 2018 14:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1WbRvv2NJm6iabRNGTD50kFNEks9ckf2ISE3MCpBow=;
        b=T+WY/QjJ5EqSrr/ezqEyb5M611Paz/Vo2ne5QPRGU2eBJRV9w8lKJT3kJ59x3UtC5I
         Z5cAgzvcbFKNWizncDCrfbPMku+dKsGpzEzy0looTDYebPu+28qi11pswkt1J+UtBUR9
         lx/Kqhz993hp8QBmbda7OYnsPY1EFePIKzIEvuYivnxuYvpCR6g/IxSqq6VEnnZYYgF4
         hWGF4dbGwrZVlTemYYub0iUq4qTcAG6BvvTKZEwmt5OPHCMWNjpCvMAZfjcHLnJpATmd
         hWkYf+zv4uKg0CZuYBAjsrc9aw6KOzpDQRUfyOb7KpwFWp3fjAY7Sg0IKRth9HHHDikh
         DB5g==
X-Gm-Message-State: AGRZ1gK0XwLbAL5FJKH0kxZR3OLceDQoPb6yoZpsksHro2qjRdqdozBY
        uJ3uOYlz845b1CMGwC3j4MtW466+Qw==
X-Google-Smtp-Source: AJdET5ff8lW0JEIMlyPPz55O4wyQ/9CsPxTFhx4jBKjq9G/ArAzQXyVDIiEr446wkJ5X0GleyCgyJg==
X-Received: by 2002:aca:e514:: with SMTP id c20-v6mr2068286oih.75.1542406278871;
        Fri, 16 Nov 2018 14:11:18 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] net: fsl: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:11:03 -0600
Message-Id: <20181116221104.23024-7-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 82722d05fedb..88a396fd242f 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -473,7 +473,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 	if (data->get_tbipa) {
 		for_each_child_of_node(np, tbi) {
-			if (strcmp(tbi->type, "tbi-phy") == 0) {
+			if (of_node_is_type(tbi, "tbi-phy")) {
 				dev_dbg(&pdev->dev, "found TBI PHY node %pOFP\n",
 					tbi);
 				break;
-- 
2.19.1

