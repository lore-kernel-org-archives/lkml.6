Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA77C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7764120895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYsbtWOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7764120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJMSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 14:00:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeJMSAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 14:00:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9DAK00D054726;
        Sat, 13 Oct 2018 10:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=MAqXOtOyCFFbwNmmD7qG4qpcEI4bIPAYk5F0inknnNk=;
 b=HYsbtWObGiFDLUHmIysGgzUFZej5HPexmQ+n46aJSiNm4fB95R712/cBY0YXnyqbI8Jh
 hw+NjBfBUESAXbcibbXeycaI0V/6Q6AdcG2kfGErGStW1BWk3bL1ad8IaRALk1dH79eH
 dPaUHUjdVE3cl+9yr8JLAvw0YSnemRHiSMoKB37QrKPdktumxGqqyk32+DFVHX1jHdZO
 poOxQh5rPZqhZq5KqvUpd35HccemdrOK+O+ZpnyeGTE4c5v0LqPKdzv6T1C4cVivrxf9
 NnpvriQ6nvhKYWDaYakjdqWnM6goaJRWeq6mMxXvH7Cf3xC23hxASd/arTy9sSd80RXo XA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384thagv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:23:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9DAN2eY001467
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:23:02 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9DAMrsO008300;
        Sat, 13 Oct 2018 10:22:54 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Oct 2018 10:22:53 +0000
Date:   Sat, 13 Oct 2018 13:22:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Cooper <jason@lakedaemon.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe
Message-ID: <20181013102246.GD16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9044 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810130099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() function never returns NULL, it returns
error pointers.

Fixes: 61ce8d8d8a81 ("irqchip/irq-mvebu-sei: Add new driver for Marvell SEI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/irqchip/irq-mvebu-sei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 566d69a2edbc..add4c9c934c8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 
 	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sei->base = devm_ioremap_resource(sei->dev, sei->res);
-	if (!sei->base) {
+	if (IS_ERR(sei->base)) {
 		dev_err(sei->dev, "Failed to remap SEI resource\n");
-		return -ENODEV;
+		return PTR_ERR(sei->base);
 	}
 
 	/* Retrieve the SEI capabilities with the interrupt ranges */
-- 
2.18.0

