Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC42710C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CC42710C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753789AbeF1Mfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:35:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40768 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbeF1Mfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:35:46 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 08:35:45 EDT
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1CAC20015D;
        Thu, 28 Jun 2018 14:27:11 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F03E520015C;
        Thu, 28 Jun 2018 14:27:11 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 838BF205ED;
        Thu, 28 Jun 2018 14:27:06 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net 1/2] fsl/fman: fix parser reporting bad checksum on short frames
Date:   Thu, 28 Jun 2018 15:26:50 +0300
Message-Id: <1530188811-8918-2-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1530188811-8918-1-git-send-email-madalin.bucur@nxp.com>
References: <1530188811-8918-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FMan hardware parser needs to be configured to remove the
short frame padding from the checksum calculation, otherwise
short UDP and TCP frames are likely to be marked as having a
bad checksum.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 4a2d960..ee82ee1 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -324,6 +324,10 @@ struct fman_port_qmi_regs {
 #define HWP_HXS_PHE_REPORT 0x00000800
 #define HWP_HXS_PCAC_PSTAT 0x00000100
 #define HWP_HXS_PCAC_PSTOP 0x00000001
+#define HWP_HXS_TCP_OFFSET 0xA
+#define HWP_HXS_UDP_OFFSET 0xB
+#define HWP_HXS_SH_PAD_REM 0x80000000
+
 struct fman_port_hwp_regs {
 	struct {
 		u32 ssa; /* Soft Sequence Attachment */
@@ -728,6 +732,10 @@ static void init_hwp(struct fman_port *port)
 		iowrite32be(0xffffffff, &regs->pmda[i].lcv);
 	}
 
+	/* Short packet padding removal from checksum calculation */
+	iowrite32be(HWP_HXS_SH_PAD_REM, &regs->pmda[HWP_HXS_TCP_OFFSET].ssa);
+	iowrite32be(HWP_HXS_SH_PAD_REM, &regs->pmda[HWP_HXS_UDP_OFFSET].ssa);
+
 	start_port_hwp(port);
 }
 
-- 
2.1.0

