Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F7220834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LHFKc3hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F7220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbeLBRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:49:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56557 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbeLBRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:49:05 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D03021ACE;
        Sun,  2 Dec 2018 12:49:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 02 Dec 2018 12:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
        :message-id:references:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=49bskc
        ZkUJXAp2I9Y2SM/899ZrR0sdi2zLdZ030oGsk=; b=LHFKc3hynhvMPay/636TzU
        34ZRWKfd3Wg9LEezSHkj6UkQXvwiholW6znHnihaQhOXIvrhJb8Wys13ViRAgQOE
        9HUDrMqhwIvpcL+W7LcwjQSurRsUKyZ/cRJhp5UessQad2IY9dXiTbAaUMWmUNDq
        pFUKfALZwdK5P/7zslZTrW1qXDj2FiY49YnuWdUwKyPfxgvqLBbHR5HkqJayrNVB
        UVQPiRRWUrN/5tla1aF+syfw9RlMDE6jM3cQY84O8wNhoPZtDbrRUJ4C/wXzIvwe
        HzvZwqnWy8gSg7ET9mEK7qGr6EayrqJLtvtSNFkal1pvFALpMS7ChMJZkf216v8Q
        ==
X-ME-Sender: <xms:DRsEXKglU5ejj8_3QDDOtIZlScomZuJfD4Bp7jTy2DNySgSY2iUcLA>
X-ME-Proxy: <xmx:DRsEXFdWTI4EHFJ7KRtNnq-2ziHttGotZYbewlLF2eUVO_zUVxf1Bw>
    <xmx:DRsEXC6vwb_GAtXzw5Ltz1mANFZrk0A1dqOBvD_i-VT29Z9ymynDNQ>
    <xmx:DRsEXKJwu21xbd70cHY5782WL-XUBYs22cusexoiJE59xad_KhUVnQ>
    <xmx:DRsEXKzEpmilwVKgTivz6X3v8wFmxHbHDDkvCYmI1F8cv3WIYj2UlA>
    <xmx:DRsEXCIYKdFmo0cZmR8iDiCVgQFYQCwwxHICywwaT76pAXmRtmyQHA>
    <xmx:DRsEXL86tRgvXApXolGA7ewbJaxUeFDKP42weYy8VwVdcy4qc-1qkw>
Received: from localhost.localdomain (ip5b40a57c.dynamic.kabel-deutschland.de [91.64.165.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D88DE4535;
        Sun,  2 Dec 2018 12:49:00 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Dwayne Litzenberger <dlitz@dlitz.net>
Subject: [PATCH 1/2] xen-pciback: Fix error return in bar_write() and rom_write()
Date:   Sun,  2 Dec 2018 18:47:32 +0100
Message-Id: <f5ea0f3c2e29a96b59e409e4ae4c62de11a05fc8.1543772656.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Litzenberger <dlitz@dlitz.net>

Signed-off-by: Dwayne Litzenberger <dlitz@dlitz.net>
---
 drivers/xen/xen-pciback/conf_space_header.c | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 10ae24b..697d0a8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -135,6 +135,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
 {
+	int err = 0;
 	struct pci_bar_info *bar = data;
 
 	if (unlikely(!bar)) {
@@ -150,17 +151,22 @@ static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
 		bar->which = 1;
 	else {
 		u32 tmpval;
-		pci_read_config_dword(dev, offset, &tmpval);
+		err = pci_read_config_dword(dev, offset, &tmpval);
+		if (err)
+			goto out;
 		if (tmpval != bar->val && value == bar->val) {
 			/* Allow restoration of bar value. */
-			pci_write_config_dword(dev, offset, bar->val);
+			err = pci_write_config_dword(dev, offset, bar->val);
+			if (err)
+				goto out;
 		}
 		bar->which = 0;
 	}
 
 	/* Do we need to support enabling/disabling the rom address here? */
 
-	return 0;
+out:
+	return err;
 }
 
 /* For the BARs, only allow writes which write ~0 or
@@ -169,6 +175,7 @@ static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
  */
 static int bar_write(struct pci_dev *dev, int offset, u32 value, void *data)
 {
+	int err = 0;
 	struct pci_bar_info *bar = data;
 	unsigned int pos = (offset - PCI_BASE_ADDRESS_0) / 4;
 	const struct resource *res = dev->resource;
@@ -193,15 +200,20 @@ static int bar_write(struct pci_dev *dev, int offset, u32 value, void *data)
 		bar->which = 1;
 	else {
 		u32 tmpval;
-		pci_read_config_dword(dev, offset, &tmpval);
+		err = pci_read_config_dword(dev, offset, &tmpval);
+		if (err)
+			goto out;
 		if (tmpval != bar->val && value == bar->val) {
 			/* Allow restoration of bar value. */
-			pci_write_config_dword(dev, offset, bar->val);
+			err = pci_write_config_dword(dev, offset, bar->val);
+			if (err)
+				goto out;
 		}
 		bar->which = 0;
 	}
 
-	return 0;
+out:
+	return err;
 }
 
 static int bar_read(struct pci_dev *dev, int offset, u32 * value, void *data)
-- 
git-series 0.9.1
