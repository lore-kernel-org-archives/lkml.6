Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F5120867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F5120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeICVLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeICVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:17 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A48E8CF1;
        Mon,  3 Sep 2018 16:50:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 12/56] usb/phy: fix PPC64 build errors in phy-fsl-usb.c
Date:   Mon,  3 Sep 2018 18:49:02 +0200
Message-Id: <20180903164924.699886562@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit a39ba90a1cc7010edb0a7132e1b67f3d80b994e9 ]

Fix build errors when built for PPC64:
These variables are only used on PPC32 so they don't need to be
initialized for PPC64.

../drivers/usb/phy/phy-fsl-usb.c: In function 'usb_otg_start':
../drivers/usb/phy/phy-fsl-usb.c:865:3: error: '_fsl_readl' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_be;
../drivers/usb/phy/phy-fsl-usb.c:865:16: error: '_fsl_readl_be' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_be;
../drivers/usb/phy/phy-fsl-usb.c:866:3: error: '_fsl_writel' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_be;
../drivers/usb/phy/phy-fsl-usb.c:866:17: error: '_fsl_writel_be' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_be;
../drivers/usb/phy/phy-fsl-usb.c:868:16: error: '_fsl_readl_le' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_le;
../drivers/usb/phy/phy-fsl-usb.c:869:17: error: '_fsl_writel_le' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_le;

and the sysfs "show" function return type should be ssize_t, not int:

../drivers/usb/phy/phy-fsl-usb.c:1042:49: error: initialization of 'ssize_t (*)(struct device *, struct device_attribute *, char *)' {aka 'long int (*)(struct device *, struct device_attribute *, char *)'} from incompatible pointer type 'int (*)(struct device *, struct device_attribute *, char *)' [-Werror=incompatible-pointer-types]
 static DEVICE_ATTR(fsl_usb2_otg_state, S_IRUGO, show_fsl_usb2_otg_state, NULL);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/phy-fsl-usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -913,6 +913,7 @@ int usb_otg_start(struct platform_device
 	if (pdata->init && pdata->init(pdev) != 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC32
 	if (pdata->big_endian_mmio) {
 		_fsl_readl = _fsl_readl_be;
 		_fsl_writel = _fsl_writel_be;
@@ -920,6 +921,7 @@ int usb_otg_start(struct platform_device
 		_fsl_readl = _fsl_readl_le;
 		_fsl_writel = _fsl_writel_le;
 	}
+#endif
 
 	/* request irq */
 	p_otg->irq = platform_get_irq(pdev, 0);
@@ -1010,7 +1012,7 @@ int usb_otg_start(struct platform_device
 /*
  * state file in sysfs
  */
-static int show_fsl_usb2_otg_state(struct device *dev,
+static ssize_t show_fsl_usb2_otg_state(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct otg_fsm *fsm = &fsl_otg_dev->fsm;


