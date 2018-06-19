Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FE9C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B2HFOmVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8F7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030524AbeFSTnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:43:45 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:39332 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030373AbeFSTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJhchO013459;
        Tue, 19 Jun 2018 14:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437418;
        bh=8RlblOSc7AB8wmEKQxY3Q9urf0Rn1vadrIb43GEIQSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B2HFOmVmKz+OjVbB/y7HE2Nhrq401LduufrDbC3WaLabAXII8lnr9Qk/FaMfjOc8H
         fPIT0zArfESL115YZ5CGvipcIAgzXuDHMit7QWR5IwiTTAUFaXXI/jHC9CzBbpE7Hq
         /X+/dohXv8rPpjguYIM7J+p4Rp2U5JeEkA75qZ+8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhcvh024514;
        Tue, 19 Jun 2018 14:43:38 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:43:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:43:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJhbvN032510;
        Tue, 19 Jun 2018 14:43:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 4/6] mailbox: ti-msgmgr: Move the memory region name to descriptor
Date:   Tue, 19 Jun 2018 14:43:35 -0500
Message-ID: <20180619194337.31522-5-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194337.31522-1-nm@ti.com>
References: <20180619194337.31522-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For newer generation of the hardware, the naming of the region is
decided at integration level and there could be additional regions
as well. Hence move the region naming to be described from compatible
descriptor.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC: None
RFC: https://patchwork.kernel.org/patch/10447653/

 drivers/mailbox/ti-msgmgr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 7d2eb4b359ba..7167cc708f44 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -48,6 +48,8 @@ struct ti_msgmgr_valid_queue_desc {
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
+ * @data_region_name:	Name of the proxy data region
+ * @status_region_name:	Name of the proxy status region
  * @num_valid_queues:	Number of valid queues
  *
  * This structure is used in of match data to describe how integration
@@ -63,6 +65,8 @@ struct ti_msgmgr_desc {
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
+	const char *data_region_name;
+	const char *status_region_name;
 	int num_valid_queues;
 };
 
@@ -531,6 +535,8 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.queue_count = 64,
 	.max_message_size = 64,
 	.max_messages = 128,
+	.data_region_name = "queue_proxy_region",
+	.status_region_name = "queue_state_debug_region",
 	.data_first_reg = 16,
 	.data_last_reg = 31,
 	.status_cnt_mask = Q_STATE_ENTRY_COUNT_MASK,
@@ -582,13 +588,13 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	inst->desc = desc;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "queue_proxy_region");
+					   desc->data_region_name);
 	inst->queue_proxy_region = devm_ioremap_resource(dev, res);
 	if (IS_ERR(inst->queue_proxy_region))
 		return PTR_ERR(inst->queue_proxy_region);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "queue_state_debug_region");
+					   desc->status_region_name);
 	inst->queue_state_debug_region = devm_ioremap_resource(dev, res);
 	if (IS_ERR(inst->queue_state_debug_region))
 		return PTR_ERR(inst->queue_state_debug_region);
-- 
2.15.1

