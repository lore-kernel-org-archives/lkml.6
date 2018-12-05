Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3129C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977320989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039486;
	bh=HYSfitoXfsXn0v07r81OA1G7EHrv48sx2XCaG7KgJs8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q3h9ny2Nm0MRPUfzsfyw5J82AHkv/K5dNl2jZtRZMmFNsb22XPs+ymCEVLtrVuRBs
	 v6rsBicRuS1x58aqva1H/eN04iXfQ+K6M3iXVjFrA0EA51ZJfmCPaQNNjbFwPrGduD
	 BczljvWeWGTSFjtB4gdXRxFoOnuaygwMkE/EoIxk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9977320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeLETvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39584 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeLETvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so18621746oia.6;
        Wed, 05 Dec 2018 11:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ezxjPp7MfWhvPHy3RISZoIqdQMGSMQgUfaCdOkJ9oEY=;
        b=NLZaytCuid+xH6rYjz1f3otbog65zXRO3QUFeA0k2P899FXUNExQozsCuLpVPFLN5v
         7sFKqpOOltkbakLCib0MoutsUpDBJMJ3PYRORJHQv8zcnL8Jr3o0yensMQ5Zl623SNWy
         uBCiXJTWoUmNdGlnwywbydP0V89wFsZYlPByXSyJfpk3f9O4tIstHW0SR14fKsYQRO2k
         aWmqA6h0Fy9CoV2T7THzbNbMfZZ/PIl741WvHsKQrbU65BZHnQu1GpCnhvLNO866qQlu
         el+UV+xGx8FI5GNy30yuREaMbv5i/Zy9K3W8JnI6JZn2nD6L7fWSHrTAM2cWsjDzaTtv
         Ge+Q==
X-Gm-Message-State: AA+aEWbF5/wtASCLSHHfV8o+lxkeB6dnmZvkcCjs8pNRW8bbDZ8TbCIZ
        HZl0uHv6DHxh9WOlvsZpXVinum8=
X-Google-Smtp-Source: AFSGD/XADEV++d6lwz+laoCTY6CxK/EPRuykKMmTlxQwk5OqvbWFLi3KcC0+jA9Ybe9+Dc+1q3fahg==
X-Received: by 2002:aca:641:: with SMTP id 62mr9871445oig.63.1544039477537;
        Wed, 05 Dec 2018 11:51:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:39 -0600
Message-Id: <20181205195050.4759-23-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/scsi/sun_esp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index a11efbcb7f8b..c71bd01fef94 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -529,11 +529,10 @@ static int esp_sbus_probe(struct platform_device *op)
 	int hme = 0;
 	int ret;
 
-	if (dp->parent &&
-	    (!strcmp(dp->parent->name, "espdma") ||
-	     !strcmp(dp->parent->name, "dma")))
+	if (of_node_name_eq(dp->parent, "espdma") ||
+	    of_node_name_eq(dp->parent, "dma"))
 		dma_node = dp->parent;
-	else if (!strcmp(dp->name, "SUNW,fas")) {
+	else if (of_node_name_eq(dp, "SUNW,fas")) {
 		dma_node = op->dev.of_node;
 		hme = 1;
 	}
-- 
2.19.1

