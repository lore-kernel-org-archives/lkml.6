Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F7021855
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBLBaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:30:06 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:40946 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfBLBaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:30:06 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 20:30:05 EST
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id tMp5g3tDH8uQmtMp6gllNg; Mon, 11 Feb 2019 18:25:20 -0700
X-Authority-Analysis: v=2.3 cv=XKpOtjpE c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=CFTnQlWoA9kA:10 a=Q-fNiiVtAAAA:8 a=0ATYKpzErnXFKjwkkVMA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 0B324300BE54B1; Mon, 11 Feb 2019 17:25:19 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] soc: brcmstb: dpfe: use byte 3 of registers MR4-MR8
Date:   Mon, 11 Feb 2019 17:24:43 -0800
Message-Id: <20190212012443.21819-4-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212012443.21819-1-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfO5mSS2yQryG4meHgQdu/aHB+Vz7BsNKwBnrnIKqsHtUGeP4vSKYssNz6u/EgaXj47DWVB6MnZzWHvtkXorXbprcL4zeBSdPPakmD+AKoXo34HczN706
 EynfdiGnEjxctDpxbM6Dc8thA1+3XYN/QIsHPpfMNNQkRi7NwCsnuBDR3ACbCTk14JrssQbGMKqNXIJNgi8hKHQgQ659E8Jyn3XsXgO07xOLHIEeQ2l4h0OM
 TFQxWDhxMEZLksW1wuPA9keh64usOiLbV/j8vVY5IDKXK9QkGj2I2aqx1dyapufo67OGngqls6z9d0gjqVAAIPecqehJRxHf4jTAfmUOccdewdPd1JZJkK7y
 pqN9IpOBqMaK5OKE6xHRpIR1RNGzkfgdmm4tC+nvjEBCwheee8Fc1AqPZHE55fZzrLnOuY53v5RhxvXnJEKPjxmW5epXuw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

For dual-rank LPDDR4, result data for any command is placed in byte 0
and byte 3 of the corresponding MR register by the firmware.
Single-rank RAM was supposed to work the same way. However, due to a
firmware bug, result values are only placed in byte 3 of the
corresponding MR register.

Since byte 3 works for single-rank and dual-rank setups, we change the
Linux driver to always use byte 3, thus returning the correct value in
either case.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 1095c1d95df4..fae3ac3d65c6 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -61,6 +61,7 @@
 #define DRAM_INFO_MR4		0x4
 #define DRAM_INFO_ERROR		0x8
 #define DRAM_INFO_MR4_MASK	0xff
+#define DRAM_INFO_MR4_SHIFT	24	/* We need to look at byte 3 */
 
 /* DRAM MR4 Offsets & Masks */
 #define DRAM_MR4_REFRESH	0x0	/* Refresh rate */
@@ -82,6 +83,7 @@
 #define DRAM_VENDOR_MR8		0xc
 #define DRAM_VENDOR_ERROR	0x10
 #define DRAM_VENDOR_MASK	0xff
+#define DRAM_VENDOR_SHIFT	24	/* We need to look at byte 3 */
 
 /* Reset register bits & masks */
 #define DCPU_RESET_SHIFT	0x0
@@ -582,7 +584,8 @@ static ssize_t show_refresh(struct device *dev,
 	if (!info)
 		return ret;
 
-	mr4 = readl_relaxed(info + DRAM_INFO_MR4) & DRAM_INFO_MR4_MASK;
+	mr4 = (readl_relaxed(info + DRAM_INFO_MR4) >> DRAM_INFO_MR4_SHIFT) &
+	      DRAM_INFO_MR4_MASK;
 
 	refresh = (mr4 >> DRAM_MR4_REFRESH) & DRAM_MR4_REFRESH_MASK;
 	sr_abort = (mr4 >> DRAM_MR4_SR_ABORT) & DRAM_MR4_SR_ABORT_MASK;
@@ -630,6 +633,7 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	struct private_data *priv;
 	void __iomem *info;
 	ssize_t ret;
+	u32 mr5, mr6, mr7, mr8, err;
 
 	priv = dev_get_drvdata(dev);
 	ret = generic_show(DPFE_CMD_GET_VENDOR, response, priv, buf);
@@ -640,13 +644,17 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	if (!info)
 		return ret;
 
-	return sprintf(buf, "%#x %#x %#x %#x %#x\n",
-		       readl_relaxed(info + DRAM_VENDOR_MR5) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_MR6) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_MR7) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_MR8) & DRAM_VENDOR_MASK,
-		       readl_relaxed(info + DRAM_VENDOR_ERROR) &
-				     DRAM_VENDOR_MASK);
+	mr5 = (readl_relaxed(info + DRAM_VENDOR_MR5) >> DRAM_VENDOR_SHIFT) &
+		DRAM_VENDOR_MASK;
+	mr6 = (readl_relaxed(info + DRAM_VENDOR_MR6) >> DRAM_VENDOR_SHIFT) &
+		DRAM_VENDOR_MASK;
+	mr7 = (readl_relaxed(info + DRAM_VENDOR_MR7) >> DRAM_VENDOR_SHIFT) &
+		DRAM_VENDOR_MASK;
+	mr8 = (readl_relaxed(info + DRAM_VENDOR_MR8) >> DRAM_VENDOR_SHIFT) &
+		DRAM_VENDOR_MASK;
+	err = readl_relaxed(info + DRAM_VENDOR_ERROR) & DRAM_VENDOR_MASK;
+
+	return sprintf(buf, "%#x %#x %#x %#x %#x\n", mr5, mr6, mr7, mr8, err);
 }
 
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
-- 
2.17.1

