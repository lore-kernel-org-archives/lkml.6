Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C99C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D50220671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D50220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=topic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJWO7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:59:31 -0400
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:49584 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727512AbeJWO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:59:31 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 10:59:30 EDT
Received: from atl4mhob04.registeredsite.com (atl4mhob04.registeredsite.com [209.17.115.42])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id w9N6VWSs002403
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:31:32 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail03pod0.registeredsite.com [10.30.71.205])
        by atl4mhob04.registeredsite.com (8.14.4/8.14.4) with ESMTP id w9N6VTxu020597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:31:29 -0400
Received: (qmail 8254 invoked by uid 0); 23 Oct 2018 06:31:29 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 23 Oct 2018 06:31:29 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-fpga@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org, atull@kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] zynq-fpga: Only route PR via PCAP when required
Date:   Tue, 23 Oct 2018 08:31:19 +0200
Message-Id: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
it impossible to use the ICAP interface for partial reconfiguration.

This patch changes the driver to only activate PR over PCAP while the
device is actively being accessed by the driver for programming.

This allows both PCAP and ICAP interfaces to be used for PR.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/fpga/zynq-fpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 3110e00..f6c205a 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -497,6 +497,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
 	int err;
 	u32 intr_status;
 
+	/* Release 'PR' control back to the ICAP */
+	zynq_fpga_write(priv, CTRL_OFFSET,
+		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
+
 	err = clk_enable(priv->clk);
 	if (err)
 		return err;
-- 
1.9.1

