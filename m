Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB485C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37442186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBLB35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:29:57 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:38712 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfBLB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:29:57 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2019 20:29:57 EST
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id tMoxg0aBZnBo4tMoygxuBp; Mon, 11 Feb 2019 18:25:12 -0700
X-Authority-Analysis: v=2.3 cv=J8fUEzvS c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=CFTnQlWoA9kA:10 a=Q-fNiiVtAAAA:8 a=8SHd0I_PIW9-B648SIoA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id 2DE26300BE54AB; Mon, 11 Feb 2019 17:25:11 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] soc: brcmstb: dpfe: optimize generic_show()
Date:   Mon, 11 Feb 2019 17:24:42 -0800
Message-Id: <20190212012443.21819-3-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212012443.21819-1-code@mmayer.net>
References: <20190212012443.21819-1-code@mmayer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOAYmQTxl3zMxNymv1fRFLjaANYo3+g7uICio1b4AKt7wwmuZiPN320uU7dPNl+BeiTaMlVukvpKiGuu1e1lOdVt5wSCZ4muuRRGgM3KgU86I3m0bY5B
 0lDLcT0ynboThqE3g860/diULKc4Vav3H+5KkvAE/IXo3sIBheFJBfS9Pk+kILsij0TwyaCQjgd81WgEYInxSMloswUoPP/kV1wWQQzPpuw+v3SpavEQ85Hg
 qmIpBLS7j1Pc9UoLTvIvcWNEUatnouGqmBsd/RqOAcUHoWE/CHkq4XPxte5mfKE/hmqcOGbpFmi/Eg1W/JJJ0cinZQaC0W90F8JwxkC3GfyF0zdSHDtuwddI
 Loj3JGyTSNOgU2R/PUOvWn9HQYD6+nrPeAsuTJ6G5LlJQGXVSLPHoeJ+jxPkPJQr4ZkSS/IGKT6oP4rLf0FgpaEGbzKFTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

We can pass a (struct priv_data *) to generic_show() rather than a
(struct device *). For two of the three callers of this function, the
change means one less call to dev_get_drvdata(). For the third caller,
it makes no difference.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 8e1ccdb0e59d..1095c1d95df4 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -527,12 +527,10 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 }
 
 static ssize_t generic_show(unsigned int command, u32 response[],
-			    struct device *dev, char *buf)
+			    struct private_data *priv, char *buf)
 {
-	struct private_data *priv;
 	int ret;
 
-	priv = dev_get_drvdata(dev);
 	if (!priv)
 		return sprintf(buf, "ERROR: driver private data not set\n");
 
@@ -547,10 +545,12 @@ static ssize_t show_info(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	u32 response[MSG_FIELD_MAX];
+	struct private_data *priv;
 	unsigned int info;
 	ssize_t ret;
 
-	ret = generic_show(DPFE_CMD_GET_INFO, response, dev, buf);
+	priv = dev_get_drvdata(dev);
+	ret = generic_show(DPFE_CMD_GET_INFO, response, priv, buf);
 	if (ret)
 		return ret;
 
@@ -573,12 +573,11 @@ static ssize_t show_refresh(struct device *dev,
 	u32 mr4;
 	ssize_t ret;
 
-	ret = generic_show(DPFE_CMD_GET_REFRESH, response, dev, buf);
+	priv = dev_get_drvdata(dev);
+	ret = generic_show(DPFE_CMD_GET_REFRESH, response, priv, buf);
 	if (ret)
 		return ret;
 
-	priv = dev_get_drvdata(dev);
-
 	info = get_msg_ptr(priv, response[MSG_ARG0], buf, &ret);
 	if (!info)
 		return ret;
@@ -632,12 +631,11 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	void __iomem *info;
 	ssize_t ret;
 
-	ret = generic_show(DPFE_CMD_GET_VENDOR, response, dev, buf);
+	priv = dev_get_drvdata(dev);
+	ret = generic_show(DPFE_CMD_GET_VENDOR, response, priv, buf);
 	if (ret)
 		return ret;
 
-	priv = dev_get_drvdata(dev);
-
 	info = get_msg_ptr(priv, response[MSG_ARG0], buf, &ret);
 	if (!info)
 		return ret;
-- 
2.17.1

