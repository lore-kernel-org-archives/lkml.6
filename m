Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187B22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUbj+SBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187B22089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeKZVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeKZVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D32921104;
        Mon, 26 Nov 2018 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230067;
        bh=7NOd1hMWgwEE+mFTcMuToxVqPnwEMDXLJoPZzdb9Z6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUbj+SBhge3OI2N6ZvGJFLEXTVmho3glrU+mIMlUHbZZMXQmB3iDySjrsxOc/cS03
         kgN5/Dqng4GcvYh591znMUn0V0G9HWOQbc+3kMOZkgEXHQ1YTz4igrXlXWMnLkLNQO
         MLyAG6SQMDUab+Q9HZtjmYkjBeHZU4X3mODNXsFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Date:   Mon, 26 Nov 2018 11:51:39 +0100
Message-Id: <20181126105054.941598787@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5d1e9c2212ea6b4dd735e4fc3dd6279a365d5d10 upstream.

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

While at it, also fix a related nfc-node reference leak.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: stable <stable@vger.kernel.org>     # 4.11
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Josh Wu <rainyfeeling@outlook.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/atmel/nand-controller.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -2077,8 +2077,7 @@ atmel_hsmc_nand_controller_legacy_init(s
 	int ret;
 
 	nand_np = dev->of_node;
-	nfc_np = of_find_compatible_node(dev->of_node, NULL,
-					 "atmel,sama5d3-nfc");
+	nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
 	if (!nfc_np) {
 		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
 		return -ENODEV;
@@ -2492,15 +2491,19 @@ static int atmel_nand_controller_probe(s
 	}
 
 	if (caps->legacy_of_bindings) {
+		struct device_node *nfc_node;
 		u32 ale_offs = 21;
 
 		/*
 		 * If we are parsing legacy DT props and the DT contains a
 		 * valid NFC node, forward the request to the sama5 logic.
 		 */
-		if (of_find_compatible_node(pdev->dev.of_node, NULL,
-					    "atmel,sama5d3-nfc"))
+		nfc_node = of_get_compatible_child(pdev->dev.of_node,
+						   "atmel,sama5d3-nfc");
+		if (nfc_node) {
 			caps = &atmel_sama5_nand_caps;
+			of_node_put(nfc_node);
+		}
 
 		/*
 		 * Even if the compatible says we are dealing with an


