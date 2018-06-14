Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F309C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wUk+vsEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E677B208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeFNOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965099AbeFNOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16FBF208DA;
        Thu, 14 Jun 2018 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985264;
        bh=5eK0SNaaqbJogctCI/B2QUYxh9aQHwPIGZzNZ2b89g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUk+vsEduAY3zMoNwwZNIz08q14Y4oMCFOQ/hHfnGd6caDttCcw8u6f2M1Vn28flv
         kw3RVcEw+ZudiFJRAEIR+hF9frfTubGmnz45xWvMI2aQ+dyGf4JINxrw9vJGzJScBf
         eqEYZwUYrDaEpvRCKwLF7Zc2XzgoiVwQv1jO40BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.16 11/43] usbip: vhci_sysfs: fix potential Spectre v1
Date:   Thu, 14 Jun 2018 16:04:15 +0200
Message-Id: <20180614132135.586620724@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit a0d6ec88090d7b1b008429c44532a388e29bb1bd upstream.

pdev_nr and rhport can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential spectre issue 'vhcis'
drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_ss->vdev'
drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential spectre issue 'vhci->vhci_hcd_hs->vdev'

Fix this by sanitizing pdev_nr and rhport before using them to index
vhcis and vhci->vhci_hcd_ss->vdev respectively.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_sysfs.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -10,6 +10,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "usbip_common.h"
 #include "vhci.h"
 
@@ -205,16 +208,20 @@ static int vhci_port_disconnect(struct v
 	return 0;
 }
 
-static int valid_port(__u32 pdev_nr, __u32 rhport)
+static int valid_port(__u32 *pdev_nr, __u32 *rhport)
 {
-	if (pdev_nr >= vhci_num_controllers) {
-		pr_err("pdev %u\n", pdev_nr);
+	if (*pdev_nr >= vhci_num_controllers) {
+		pr_err("pdev %u\n", *pdev_nr);
 		return 0;
 	}
-	if (rhport >= VHCI_HC_PORTS) {
-		pr_err("rhport %u\n", rhport);
+	*pdev_nr = array_index_nospec(*pdev_nr, vhci_num_controllers);
+
+	if (*rhport >= VHCI_HC_PORTS) {
+		pr_err("rhport %u\n", *rhport);
 		return 0;
 	}
+	*rhport = array_index_nospec(*rhport, VHCI_HC_PORTS);
+
 	return 1;
 }
 
@@ -232,7 +239,7 @@ static ssize_t detach_store(struct devic
 	pdev_nr = port_to_pdev_nr(port);
 	rhport = port_to_rhport(port);
 
-	if (!valid_port(pdev_nr, rhport))
+	if (!valid_port(&pdev_nr, &rhport))
 		return -EINVAL;
 
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);
@@ -258,7 +265,8 @@ static ssize_t detach_store(struct devic
 }
 static DEVICE_ATTR_WO(detach);
 
-static int valid_args(__u32 pdev_nr, __u32 rhport, enum usb_device_speed speed)
+static int valid_args(__u32 *pdev_nr, __u32 *rhport,
+		      enum usb_device_speed speed)
 {
 	if (!valid_port(pdev_nr, rhport)) {
 		return 0;
@@ -322,7 +330,7 @@ static ssize_t attach_store(struct devic
 			     sockfd, devid, speed);
 
 	/* check received parameters */
-	if (!valid_args(pdev_nr, rhport, speed))
+	if (!valid_args(&pdev_nr, &rhport, speed))
 		return -EINVAL;
 
 	hcd = platform_get_drvdata(vhcis[pdev_nr].pdev);


