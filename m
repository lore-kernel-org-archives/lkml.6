Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD62ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA96C214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0g+ZR34L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA96C214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbeJYWyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbeJYWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:09 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89139208A3;
        Thu, 25 Oct 2018 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477271;
        bh=iROB2lFz13Ms++6tgn5UEhtXSEDe1Nojtrp1/U3H6sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0g+ZR34L7u+h2AQoCLrNV9/ZPdGIRWOHOfUKFDWqRD2EY2BzJBbhumLWqBs9RJmQN
         gCaAC0i/njR8az0tgEEfO0M5UKN6Db1o6JcNLmhYwh1BoUfL558MCbBHEVXMiCAEjU
         C6/ZFl0wZPIZaZCe74cFHOHsaKpo3Xu3nOsWfYGs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 88/98] PCI: Fix devfn for VPD access through function 0
Date:   Thu, 25 Oct 2018 10:18:43 -0400
Message-Id: <20181025141853.214051-88-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

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

