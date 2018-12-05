Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09504C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1481208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039556;
	bh=TsyDBUmThhpyMGlOS0gssXM9VHvtNt+Dt+B1j6u2gE8=;
	h=From:To:Subject:Date:List-ID:From;
	b=WYAPpMeQM74TWZvhfqYlzU9yawHkncgc6hIMn1J4CFXgzTFGw8yoPdXq73b5h45oz
	 7/IeZUAuTfJDh7MQqYVbdKb3sPxWrUrm7eEHg/42jSKfqpMyfwRphprhMjtiUrX26H
	 t9ZBC7f14OfkfUozr+JqOiaxz29YHiitSrdzxNpg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1481208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeLETwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:52:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35483 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeLETvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so19834948otj.2;
        Wed, 05 Dec 2018 11:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emH1g9Exn0OVhGYnu7c/NjHtAOZPINdJqKI6tPl+TjQ=;
        b=YK756hyoWIc3qbjXPo71p+T8ShW3FDgF2fKfReFm0MSwAN4mjXJ51pq9B2VZ/y4cu+
         i10x73AD4lJ/tky7dUsqXxn/ux4i+7h41HUctZiY+SouKQWRRM2mU9Jg42OFmUgdwtqR
         Pe+GA0tBw4+ZeeHdE3bjcdf799kYg5ODe2jp6nIwiG6LQxr3kNW9ykLR0MUIyEqpTCnP
         clCunUx/ZPOBke8LRAOG7JdDJVyDXbOXTz1/wPodn/FN7WC0Y6u/XqGGsLXqQPJoLqE4
         Qm2HAJN8fOxgG/zILUr9rT9qsHTvWVL1x13Oe8R7qrzBTLiXhTokqNqifhCaFWgfWAhn
         DPyQ==
X-Gm-Message-State: AA+aEWYNyn26vyKCLH8Vq3AYU/KQ8tjPch1CYnMs4keXEwLh+XpkTisR
        IO5W2qOCxQDPZRXHgSaQ+10pdss=
X-Google-Smtp-Source: AFSGD/Warp6LrKBHpP4gZYXi3wZBWtH1lu4Z9toVbq/TOoHfoHPqizwBKW6nVOEhJIZdCsXYtZ9mMg==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr15762434otl.196.1544039478376;
        Wed, 05 Dec 2018 11:51:18 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:17 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qlogicpti: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:40 -0600
Message-Id: <20181205195050.4759-24-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/scsi/qlogicpti.c | 3 +--
 drivers/scsi/qlogicpti.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9d09228eee28..4f14963c4270 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1315,8 +1315,7 @@ static int qpti_sbus_probe(struct platform_device *op)
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

