Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C67C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF6240C5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CF6240C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeGAVQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:16:28 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58681 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752407AbeGAVQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:16:26 -0400
Received: from localhost.localdomain (unknown [62.214.191.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B13BE2012BA066;
        Sun,  1 Jul 2018 23:16:23 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] usb/host/pci-quirks: Only reset USB bus on NVIDIA devices
Date:   Sun,  1 Jul 2018 23:16:07 +0200
Message-Id: <20180701211607.7833-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, on the AMD board Asus F2A85-M Pro there is a 100 ms delay as
the USB bus of each of the two OHCI PCI devices is reset. As a 50 ms
delay is done per the USB specification.

Commit c6187597 (OHCI: final fix for NVIDIA problems (I hope))
unconditionally does the bus reset for
 all chipsets, while it was only doen for NVIDIA chipsets before.

As it should not be needed for non-NVIDIA chipsets, only do the reset
for Nvidia devices.

Tested on Asus F2A85-M PRO and ASRock E350M1. The USB keyboard works and
the LUKS passphrase can be e
ntered.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/usb/host/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 3625a5c1a41b..f6b1a9bbe301 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -784,7 +784,7 @@ static void quirk_usb_handoff_ohci(struct pci_dev *pdev)
 	writel((u32) ~0, base + OHCI_INTRDISABLE);
 
 	/* Reset the USB bus, if the controller isn't already in RESET */
-	if (control & OHCI_HCFS) {
+	if ((pdev->vendor == PCI_VENDOR_ID_NVIDIA) && (control & OHCI_HCFS)) {
 		/* Go into RESET, preserving RWC (and possibly IR) */
 		writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
 		readl(base + OHCI_CONTROL);
-- 
2.17.1

