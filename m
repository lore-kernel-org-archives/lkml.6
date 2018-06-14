Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5EC64C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09560208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="daNx8mWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09560208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936282AbeFNOGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936266AbeFNOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C55208DA;
        Thu, 14 Jun 2018 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985182;
        bh=vEAKO/YvHO9KMQZBwi3+GAZZFY6v5dlf+Sjot+mku6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daNx8mWV6qWb3QFximKQYIdJa1QUkGsob/2GMOoNfFidhn3ZGYGgdVOuBEgGzjDDy
         GUIxcZ5UcjYYj/n2NDYSh5cP71VrvNCCHWOGlex3qFfmxTxmJy3PYMLG/DJj7ACaGr
         P1f5Yu4dYqLe0xM6GqNNZYfeSmCecyVeNTspT2hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.17 20/45] usb: gadget: udc: renesas_usb3: should remove debugfs
Date:   Thu, 14 Jun 2018 16:04:11 +0200
Message-Id: <20180614132127.857851073@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 1990cf7c21ea185cec98c6d45a82c04481261e35 upstream.

This patch fixes an issue that this driver doesn't remove its debugfs.

Fixes: 43ba968b00ea ("usb: gadget: udc: renesas_usb3: add debugfs to set the b-device mode")
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/renesas_usb3.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -333,6 +333,7 @@ struct renesas_usb3 {
 	struct extcon_dev *extcon;
 	struct work_struct extcon_work;
 	struct phy *phy;
+	struct dentry *dentry;
 
 	struct renesas_usb3_ep *usb3_ep;
 	int num_usb3_eps;
@@ -2393,8 +2394,12 @@ static void renesas_usb3_debugfs_init(st
 
 	file = debugfs_create_file("b_device", 0644, root, usb3,
 				   &renesas_usb3_b_device_fops);
-	if (!file)
+	if (!file) {
 		dev_info(dev, "%s: Can't create debugfs mode\n", __func__);
+		debugfs_remove_recursive(root);
+	} else {
+		usb3->dentry = root;
+	}
 }
 
 /*------- platform_driver ------------------------------------------------*/
@@ -2402,6 +2407,7 @@ static int renesas_usb3_remove(struct pl
 {
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
+	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
 	usb_del_gadget_udc(&usb3->gadget);


