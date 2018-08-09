Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B36C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDAA2238F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDAA2238F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeHIWaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8C99308FBAD;
        Thu,  9 Aug 2018 20:04:16 +0000 (UTC)
Received: from gimli.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52B510018F8;
        Thu,  9 Aug 2018 20:04:14 +0000 (UTC)
Subject: [PATCH v4 1/3] PCI: Export pcie_has_flr()
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Thu, 09 Aug 2018 14:04:14 -0600
Message-ID: <153384505430.15793.4988988835441214121.stgit@gimli.home>
In-Reply-To: <153384487209.15793.15203778129263981368.stgit@gimli.home>
References: <153384487209.15793.15203778129263981368.stgit@gimli.home>
User-Agent: StGit/0.18-136-gffd7-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 09 Aug 2018 20:04:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcie_flr() suggests pcie_has_flr() to ensure that PCIe FLR support is
present prior to calling.  pcie_flr() is exported while pcie_has_flr()
is not.  Resolve this.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c   |    3 ++-
 include/linux/pci.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2bec76c9d9a7..52fe2d72a99c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4071,7 +4071,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-static bool pcie_has_flr(struct pci_dev *dev)
+bool pcie_has_flr(struct pci_dev *dev)
 {
 	u32 cap;
 
@@ -4081,6 +4081,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
 	return cap & PCI_EXP_DEVCAP_FLR;
 }
+EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 04c7ea6ed67b..bbe030d7814f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1092,6 +1092,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
+bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);

