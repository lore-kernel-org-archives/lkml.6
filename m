Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5087C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EBE20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6Zhbfti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EBE20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeKHDXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbeKHDX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:23:29 -0500
Received: from localhost.localdomain (rrcs-67-79-197-43.sw.biz.rr.com [67.79.197.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA624208A3;
        Wed,  7 Nov 2018 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541613121;
        bh=SCfjFI72ZliedsViQFWiX/Xb9nSBdgE202Prn8Nu58E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6ZhbftidWUpLd37BiY/E/0DImspYAKLBAMTIGSTmShlBAHwMAWgVDtEcBs7bvUnP
         qP3dcgIIo51AhzbjnY/5orVRdiAuj6I1sQItkX4XqAATRFimPL9slHBhhOGMJUssXc
         NdtImrRkqAr6JD6zHy4Kgu4PIixnoNFrZ2HyI4gg=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 4/4] zynq-fpga: Only route PR via PCAP when required
Date:   Wed,  7 Nov 2018 11:51:48 -0600
Message-Id: <1541613108-29660-5-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>

The Xilinx Zynq FPGA driver takes ownership of the PR interface, making
it impossible to use the ICAP interface for partial reconfiguration.

This patch changes the driver to only activate PR over PCAP while the
device is actively being accessed by the driver for programming.

This allows both PCAP and ICAP interfaces to be used for PR.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/zynq-fpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index bb82efe..57b0e67 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -501,6 +501,10 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
 	if (err)
 		return err;
 
+	/* Release 'PR' control back to the ICAP */
+	zynq_fpga_write(priv, CTRL_OFFSET,
+		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
+
 	err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
 				     intr_status & IXR_PCFG_DONE_MASK,
 				     INIT_POLL_DELAY,
-- 
2.7.4

