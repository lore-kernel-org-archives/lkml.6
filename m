Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA2FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D792148E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D792148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeHWLrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46390 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeHWLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5074C7B;
        Thu, 23 Aug 2018 08:19:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 014/217] soc: imx: gpcv2: correct PGC offset
Date:   Thu, 23 Aug 2018 09:52:07 +0200
Message-Id: <20180823075506.200162367@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 3637f12faf507b0a4b8ac1e7115fc99583ab1db3 ]

Correct MIPI/PCIe/USB_HSIC's PGC offset based on
design RTL, the values in the Reference Manual
(Rev. 1, 01/2018 and the older ones) are incorrect.

The correct offset values should be as below:

0x800 ~ 0x83F: PGC for core0 of A7 platform;
0x840 ~ 0x87F: PGC for core1 of A7 platform;
0x880 ~ 0x8BF: PGC for SCU of A7 platform;
0xA00 ~ 0xA3F: PGC for fastmix/megamix;
0xC00 ~ 0xC3F: PGC for MIPI PHY;
0xC40 ~ 0xC7F: PGC for PCIe_PHY;
0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
0xD00 ~ 0xD3F: PGC for USB HSIC PHY;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/imx/gpcv2.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -39,10 +39,15 @@
 
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
-
-#define PGC_MIPI			4
-#define PGC_PCIE			5
-#define PGC_USB_HSIC			8
+/*
+ * The PGC offset values in Reference Manual
+ * (Rev. 1, 01/2018 and the older ones) GPC chapter's
+ * GPC_PGC memory map are incorrect, below offset
+ * values are from design RTL.
+ */
+#define PGC_MIPI			16
+#define PGC_PCIE			17
+#define PGC_USB_HSIC			20
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 


