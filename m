Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0945C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5B921486
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CARZRSdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5B921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeLBRtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:49:07 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40121 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbeLBRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:49:07 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 74E0F21CFC;
        Sun,  2 Dec 2018 12:49:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 02 Dec 2018 12:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
        :message-id:references:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bkazlM
        eqSQMZGXmkvr4gNc7lrThuSBOK6guOJYB5HUo=; b=CARZRSdJTO+PosEizGkLLI
        nKPsPdmrH8s1ksLnNhu8Uq6uNpWAyoiZxxyegLxC/bYF2uJiwa/JGum1auBemmBe
        pwQ2gZd1f5y++dZeRwY0HNbLxx1DJobnc8O14orGJnRZXb4w0Q0A0UCwqmZ2RnDS
        ydA57wVt+gvf9OPQwAdqREcFgNZVNUFSlLbWz188C8TwjQ+/y5SkTVZX2BmirYic
        /DC/zY/B0HnRLfiOjDsOjefNBX2Yfb7FBafiT3y8BnzzjK3fWrjf+GXoWQX2qwfD
        lk2fxx9Ar8kyfCnY6SAVXcKLo93D4T1ro2yXyDZi9gj0lH26aM9ljrJsiddJMBlA
        ==
X-ME-Sender: <xms:EBsEXPmQoJqre3gZhIa9GllcOlf4ciLjrJ-voP29EAi3RFB_c9nMBA>
X-ME-Proxy: <xmx:EBsEXG69vk54Z_IWtouXkanTPZMMPb5l_eRrDEZaSY36D4Mzuvwu6Q>
    <xmx:EBsEXAFyGB8X_HJ9rDDnruHNAqfH-k7BXLvQpfs5xkQmOytesYlaMQ>
    <xmx:EBsEXHS5m1LUWyHTrnzFyxwZKzRC_DxoGYOpJe50f_sX9et9tmf4eA>
    <xmx:EBsEXBusoo3fhFDfJ9AsBO1Raw4rNjAXxE7g0FglF-Oopij3rpnjTA>
    <xmx:EBsEXOx0XyXTzidN_4mb0YhbFMwwg2J-T6r3OKKuQy0ZoywtXu_jDw>
    <xmx:EBsEXKDIEWcDIpmo1N1oX9u7v1IDlTV8GN5OLmkYZPyrHO5b-olU2Q>
Received: from localhost.localdomain (ip5b40a57c.dynamic.kabel-deutschland.de [91.64.165.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AE6CE44DF;
        Sun,  2 Dec 2018 12:49:03 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Dwayne Litzenberger <dlitz@dlitz.net>
Subject: [PATCH 2/2] xen-pciback: Allow enabling/disabling expansion ROM
Date:   Sun,  2 Dec 2018 18:47:33 +0100
Message-Id: <a05e3cf451d692dc4b1c81c8b5d66fc75d1fa325.1543772656.git-series.marmarek@invisiblethingslab.com>
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

Newer AMD GPUs store their initialization routines as bytecode on the
ROM.  This fixes the following initialization error inside the VM when
doing PCI passthrough:

    radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
    radeon 0000:00:05.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
    [drm:radeon_get_bios [radeon]] *ERROR* Unable to locate a BIOS ROM
    radeon 0000:00:05.0: Fatal error during GPU init

Signed-off-by: Dwayne Litzenberger <dlitz@dlitz.net>
---
 drivers/xen/xen-pciback/conf_space_header.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 697d0a8..bc145d3 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -150,21 +150,21 @@ static int rom_write(struct pci_dev *dev, int offset, u32 value, void *data)
 	if ((value | ~PCI_ROM_ADDRESS_MASK) == ~0U)
 		bar->which = 1;
 	else {
-		u32 tmpval;
-		err = pci_read_config_dword(dev, offset, &tmpval);
+		u32 newval = bar->val;
+
+		/* Allow enabling/disabling rom, if present */
+		if (newval & PCI_ROM_ADDRESS_MASK) {
+			newval &= ~PCI_ROM_ADDRESS_ENABLE;
+			newval |= value & PCI_ROM_ADDRESS_ENABLE;
+		}
+
+		err = pci_write_config_dword(dev, offset, newval);
 		if (err)
 			goto out;
-		if (tmpval != bar->val && value == bar->val) {
-			/* Allow restoration of bar value. */
-			err = pci_write_config_dword(dev, offset, bar->val);
-			if (err)
-				goto out;
-		}
+		bar->val = newval;
 		bar->which = 0;
 	}
 
-	/* Do we need to support enabling/disabling the rom address here? */
-
 out:
 	return err;
 }
-- 
git-series 0.9.1
