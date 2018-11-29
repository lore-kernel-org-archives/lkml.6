Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1073FC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zlzcHlFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCED0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbeK3Bee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731995AbeK3Bed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCAA2146D;
        Thu, 29 Nov 2018 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501740;
        bh=29enooqc2sWuci1d33hdARvzsXd+ubESPVazKVv5Nvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlzcHlFTFfW5tZyqZS4/bo2AEiIF+P56FhHhDeBU+0Nsve06VNNPNUOykd3fd+KcW
         ULfYsjqCIHDpD+WNyXE1cozh+YCHu8+OOf7yZmS+3oiH8X5+zgm+pZU+I78UBuYytW
         cQssG7Mx2pQb7eqPsfum+7Oiwrl++YwVNTtXujzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 007/110] usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()
Date:   Thu, 29 Nov 2018 15:11:38 +0100
Message-Id: <20181129135921.537632380@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

commit 7b412b04a0c7000293008231ce8413056abb1982 upstream.

In dwc3_pci_quirks() function, gpiod lookup table is only registered for
baytrail SOC. But in dwc3_pci_remove(), we try to unregistered it
without any checks. This leads to NULL pointer de-reference exception in
gpiod_remove_lookup_table() when unloading the module for non baytrail
SOCs. This patch fixes this issue.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms
without ACPI GPIO resources")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -283,8 +283,10 @@ err:
 static void dwc3_pci_remove(struct pci_dev *pci)
 {
 	struct dwc3_pci		*dwc = pci_get_drvdata(pci);
+	struct pci_dev		*pdev = dwc->pci;
 
-	gpiod_remove_lookup_table(&platform_bytcr_gpios);
+	if (pdev->device == PCI_DEVICE_ID_INTEL_BYT)
+		gpiod_remove_lookup_table(&platform_bytcr_gpios);
 #ifdef CONFIG_PM
 	cancel_work_sync(&dwc->wakeup_work);
 #endif


