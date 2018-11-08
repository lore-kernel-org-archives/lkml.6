Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1958920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwyhEX3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1958920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeKIIRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeKIHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:02 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9538920892;
        Thu,  8 Nov 2018 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714194;
        bh=ZExUvJSTwHCZ3mlAePFowVOgZZOjZDF1gWFERXCa2Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwyhEX3GZ04XALR0namjrU75Nfjfj5d4BmUA7AqlAcXRPfrVKlPDC/pvwkl/k5OAI
         v3jfg8J3SYhXQNJA4jCYng9/xb4XSve4bmleib92Z7dTDu5qpVs35800YoNCYV8sgX
         CsOtYYL6mDBChu/SG21pyt2LSiTB0Kh+zYU2UWn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Myron Stowe <myron.stowe@redhat.com>,
        Mark Rustad <mark.d.rustad@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 116/144] PCI: Fix devfn for VPD access through function 0
Date:   Thu,  8 Nov 2018 13:51:27 -0800
Message-Id: <20181108215106.388149049@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9d9240756e63dd87d6cbf5da8b98ceb8f8192b55 ]

Commit 932c435caba8 ("PCI: Add dev_flags bit to access VPD through function
0") passes PCI_SLOT(devfn) for the devfn parameter of pci_get_slot().
Generally this works because we're fairly well guaranteed that a PCIe
device is at slot address 0, but for the general case, including
conventional PCI, it's incorrect.  We need to get the slot and then convert
it back into a devfn.

Fixes: 932c435caba8 ("PCI: Add dev_flags bit to access VPD through function 0")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
Acked-by: Myron Stowe <myron.stowe@redhat.com>
Acked-by: Mark Rustad <mark.d.rustad@intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/access.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 7f249b9ab2ce..2f15e7bb9f44 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -355,7 +355,8 @@ static const struct pci_vpd_ops pci_vpd_pci22_ops = {
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 			       void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ssize_t ret;
 
 	if (!tdev)
@@ -369,7 +370,8 @@ static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
 static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 				const void *arg)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ssize_t ret;
 
 	if (!tdev)
@@ -388,7 +390,8 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 
 static int pci_vpd_f0_dev_check(struct pci_dev *dev)
 {
-	struct pci_dev *tdev = pci_get_slot(dev->bus, PCI_SLOT(dev->devfn));
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	int ret = 0;
 
 	if (!tdev)
-- 
2.17.1



