Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A58C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D78F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeHWMHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbeHWMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:18 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F20A4C74;
        Thu, 23 Aug 2018 08:38:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 197/217] soc: imx: gpc: restrict register range for regmap access
Date:   Thu, 23 Aug 2018 09:55:10 +0200
Message-Id: <20180823075514.518542959@linuxfoundation.org>
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

[ Upstream commit de2d9b5284bcb5c159c5882ac69f6bfd4dec7c67 ]

GPC registers are NOT continuous, some registers are
reserved and accessing them from userspace will trigger
external abort, add regmap register access table to
avoid below abort:

root@imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
[  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
[  108.487985] pgd = 42b54bfd
[  108.490741] [b6db5004] *pgd=ba1b7831
[  108.494386] Internal error: : 1406 [#1] SMP ARM
[  108.498943] Modules linked in:
[  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
[  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
[  108.521031] LR is at regmap_mmio_read+0x40/0x60
[  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
[  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
[  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
[  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
[  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
[  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
[  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
[  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/imx/gpc.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -27,9 +27,16 @@
 #define GPC_PGC_SW2ISO_SHIFT	0x8
 #define GPC_PGC_SW_SHIFT	0x0
 
+#define GPC_PGC_PCI_PDN		0x200
+#define GPC_PGC_PCI_SR		0x20c
+
 #define GPC_PGC_GPU_PDN		0x260
 #define GPC_PGC_GPU_PUPSCR	0x264
 #define GPC_PGC_GPU_PDNSCR	0x268
+#define GPC_PGC_GPU_SR		0x26c
+
+#define GPC_PGC_DISP_PDN	0x240
+#define GPC_PGC_DISP_SR		0x24c
 
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
@@ -303,10 +310,24 @@ static const struct of_device_id imx_gpc
 	{ }
 };
 
+static const struct regmap_range yes_ranges[] = {
+	regmap_reg_range(GPC_CNTR, GPC_CNTR),
+	regmap_reg_range(GPC_PGC_PCI_PDN, GPC_PGC_PCI_SR),
+	regmap_reg_range(GPC_PGC_GPU_PDN, GPC_PGC_GPU_SR),
+	regmap_reg_range(GPC_PGC_DISP_PDN, GPC_PGC_DISP_SR),
+};
+
+static const struct regmap_access_table access_table = {
+	.yes_ranges	= yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
+};
+
 static const struct regmap_config imx_gpc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
+	.rd_table = &access_table,
+	.wr_table = &access_table,
 	.max_register = 0x2ac,
 };
 


