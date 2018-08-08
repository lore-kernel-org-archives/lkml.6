Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF07C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615A21741
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 12:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0xfqSPD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeHHOX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:23:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHHOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:23:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78BxiJV011241;
        Wed, 8 Aug 2018 12:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=KYec9+n3qUBOCziNFGWXpnJMQbb6SVsNV4pdryci0fM=;
 b=0xfqSPD2dLSYehLTJs3CAmyRZm3FyaFHgJCNsuToMFmWHHUreFAVwN8uqgkO5WzoPX73
 HF9Sd02kHOXzHXhS+KaLnI19dwETQ25+sBxhhaAtDb+08oDckvZAGQOvi7OGBgwHi/Ry
 0zHunsP4fl51V4x+L3NXdKWR6bghGFZ9fshpNPI0kUFfbTVGTgFGoInjRKLe6bISyPt7
 ug9GmWyaPIjeZw8DhVejoYV59OYvbaWp18KlWK5wNKYWrNinGgbv+DFAzBSN6qiU8jPH
 drq++Ne+9jl29rdSaXvJtvp4o7QjGuXyIc/7zRSlvbW2UyRn9g7EQ89j5hnluIvBpm3G ug== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kn4spwd8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 12:03:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w78C3TRj027193
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 12:03:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w78C3SaE004400;
        Wed, 8 Aug 2018 12:03:28 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 05:03:27 -0700
Date:   Wed, 8 Aug 2018 15:03:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ludovic Barre <ludovic.barre@st.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] irqchip/stm32: fix init error handling
Message-ID: <20180808120319.akmstg3ads325xcy@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=796
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are any errors in stm32_exti_host_init() then it leads to a
NULL dereference in the callers.  The function should clean up after
itself.

Fixes: f9fc1745501e ("irqchip/stm32: Add host and driver data structures")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 3df527fcf4e1..0a2088e12d96 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -603,17 +603,24 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
 	if (!host_data->chips_data)
-		return NULL;
+		goto free_host_data;
 
 	host_data->base = of_iomap(node, 0);
 	if (!host_data->base) {
 		pr_err("%pOF: Unable to map registers\n", node);
-		return NULL;
+		goto free_chips_data;
 	}
 
 	stm32_host_data = host_data;
 
 	return host_data;
+
+free_chips_data:
+	kfree(host_data->chips_data);
+free_host_data:
+	kfree(host_data);
+
+	return NULL;
 }
 
 static struct
@@ -665,10 +672,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	struct irq_domain *domain;
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
@@ -725,7 +730,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
@@ -752,10 +756,8 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 	}
 
 	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data) {
-		ret = -ENOMEM;
-		goto out_free_mem;
-	}
+	if (!host_data)
+		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
 		stm32_exti_chip_init(host_data, i, node);
@@ -777,7 +779,6 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 
 out_unmap:
 	iounmap(host_data->base);
-out_free_mem:
 	kfree(host_data->chips_data);
 	kfree(host_data);
 	return ret;
