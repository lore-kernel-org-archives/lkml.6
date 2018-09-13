Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF44C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A4A204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeIMTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbeIMTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D9C9D19;
        Thu, 13 Sep 2018 13:56:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 084/197] PCI: Match Root Ports MPS to endpoints MPSS as necessary
Date:   Thu, 13 Sep 2018 15:30:33 +0200
Message-Id: <20180913131844.891255417@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myron Stowe <myron.stowe@redhat.com>

[ Upstream commit 9f0e89359775ee21fe1ea732e34edb52aef5addf ]

In commit 27d868b5e6cf ("PCI: Set MPS to match upstream bridge"), we made
sure every device's MPS setting matches its upstream bridge, making it more
likely that a hot-added device will work in a system with an optimized MPS
configuration.

Recently I've started encountering systems where the endpoint device's MPSS
capability is less than its Root Port's current MPS value, thus the
endpoint is not capable of matching its upstream bridge's MPS setting (see:
bugzilla via "Link:" below).  This leaves the system vulnerable - the
upstream Root Port could respond with larger TLPs than the device can
handle, and the device will consider them to be 'Malformed'.

One could use the "pci=pcie_bus_safe" kernel parameter to work around the
issue, but that forces a user to supply a kernel parameter to get the
system to function reliably and may end up limiting MPS settings of other
unrelated, sub-topologies which could benefit from maintaining their larger
values.

Augment Keith's approach to include tuning down a Root Port's MPS setting
when its hot-added endpoint device is not capable of matching it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jon Mason <jdmason@kudzu.us>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/probe.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1725,7 +1725,7 @@ int pci_setup_device(struct pci_dev *dev
 static void pci_configure_mps(struct pci_dev *dev)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
-	int mps, p_mps, rc;
+	int mps, mpss, p_mps, rc;
 
 	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
 		return;
@@ -1753,6 +1753,14 @@ static void pci_configure_mps(struct pci
 	if (pcie_bus_config != PCIE_BUS_DEFAULT)
 		return;
 
+	mpss = 128 << dev->pcie_mpss;
+	if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
+		pcie_set_mps(bridge, mpss);
+		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, max %d)\n",
+			 mpss, p_mps, 128 << bridge->pcie_mpss);
+		p_mps = pcie_get_mps(bridge);
+	}
+
 	rc = pcie_set_mps(dev, p_mps);
 	if (rc) {
 		pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
@@ -1761,7 +1769,7 @@ static void pci_configure_mps(struct pci
 	}
 
 	pci_info(dev, "Max Payload Size set to %d (was %d, max %d)\n",
-		 p_mps, mps, 128 << dev->pcie_mpss);
+		 p_mps, mps, mpss);
 }
 
 static struct hpp_type0 pci_default_type0 = {


