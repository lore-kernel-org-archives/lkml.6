Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863B72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550074113;
	bh=UIQE35139V11IOLHEZmrZZdv+9BZJtImez6vXdgnVV8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i2MWSDnNCoyfgaWo3NjSN+pD5YMOZI55uTmlQ1tfwZMVqf26Psykxh9HaXQMcn90R
	 un5D7joQ2zrjdfGd3nhMR4MrDVuJAH5Ao3ulY0XLcoWWtxkLxIQ7tYU9PGGAIem9fh
	 aCBPcX40gR+RZJTVIRI2u7rwZIa77STc+MFr3qy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbfBMQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:08:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41966 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbfBMQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:08:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so4943264otk.8;
        Wed, 13 Feb 2019 08:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XnbXfZW5UqKnm7T4Tfw4mA9FpQDbLcwwfMQTvEh1Vao=;
        b=B+x6k6doXlwh1L0mAbuKx+QBrTDegv1gkhlgXKui6ocZPeTxXq5vsYDH0I2Ig67RWZ
         LBBJnB9bizuYRH9akzs5tPTJa9lP+AMEjB7nJmEll5Fw8g7v8nxzP1gS4I7f2WKPvVKA
         EPHWhezBfkj6gtG1nZsRcFV7rkVkEnTfAjZ5GTuJ8XHe+C8LKgmngZG1SBPANbBn8H37
         ZlXlgeannb7uN0+dLJVraGQUugBpRD7T3DwJAQ7WL6uMMgFUP40hcoSvPIS61pfC72w4
         Gb3TMuXOy4proZ0eHsNNhvkRXs3H0jQITw/983WhWcHef/JeaBPZQ93XPTwocKhFuqXq
         xKjA==
X-Gm-Message-State: AHQUAuYGd214GGY2DfJanucKiYszhvr/YiYdTCquSd0tBUhQNVTAWz3O
        lsRADkefLAUmLuMzZ+NQgw==
X-Google-Smtp-Source: AHgI3Ib1WA8L/jE+BT8TeduzdbA43Qx4dLZcflAvuEJ0GSgeBi1zHCClTKbGZxgFQn0WlamkkOApTA==
X-Received: by 2002:aca:c5d5:: with SMTP id v204mr671477oif.104.1550074111020;
        Wed, 13 Feb 2019 08:08:31 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m5sm4022129oih.16.2019.02.13.08.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 08:08:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: qlogicpti: Use of_node_name_eq for node name comparisons
Date:   Wed, 13 Feb 2019 10:08:29 -0600
Message-Id: <20190213160829.3923-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

As prom_name is not used for anything else, remove it.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/scsi/qlogicpti.c | 3 +--
 drivers/scsi/qlogicpti.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index e35ce762d454..0e22512bd3e4 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1314,8 +1314,7 @@ static int qpti_sbus_probe(struct platform_device *op)
 	qpti->qhost = host;
 	qpti->op = op;
 	qpti->qpti_id = nqptis;
-	strcpy(qpti->prom_name, op->dev.of_node->name);
-	qpti->is_pti = strcmp(qpti->prom_name, "QLGC,isp");
+	qpti->is_pti = !of_node_name_eq(op->dev.of_node, "QLGC,isp");
 
 	if (qpti_map_regs(qpti) < 0)
 		goto fail_unlink;
diff --git a/drivers/scsi/qlogicpti.h b/drivers/scsi/qlogicpti.h
index 884ad72ade57..2b6374e08a7d 100644
--- a/drivers/scsi/qlogicpti.h
+++ b/drivers/scsi/qlogicpti.h
@@ -364,7 +364,6 @@ struct qlogicpti {
 	int                       qpti_id;
 	int                       scsi_id;
 	int                       prom_node;
-	char                      prom_name[64];
 	int                       irq;
 	char                      differential, ultra, clock;
 	unsigned char             bursts;
@@ -379,7 +378,7 @@ struct qlogicpti {
 #define SREG_IMASK                0x0c   /* Interrupt level            */
 #define SREG_SPMASK               0x03   /* Mask for switch pack       */
 	unsigned char             swsreg;
-	unsigned int	
+	unsigned int
 		gotirq	:	1,	/* this instance got an irq */
 		is_pti	: 	1;	/* Non-zero if this is a PTI board. */
 };
-- 
2.19.1

