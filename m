Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeC1LvJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:51:09 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:53987 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeC1LvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:51:06 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, cyrille.pitchen@free-electrons.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Sekhar Nori <nsekhar@ti.com>,
        John Keeping <john@metanate.com>, Niklas Cassel <niklass@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/12] PCI: endpoint: Handle 64-bit BARs properly
Date: Wed, 28 Mar 2018 13:50:13 +0200
Message-Id: <20180328115018.31921-9-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328115018.31921-1-niklas.cassel@axis.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a 64-bit BAR was set-up, we need to skip a BAR,
since a 64-bit BAR consists of a BAR pair.

We need to check what BAR width the epc->ops->set_bar() specific
implementation actually did set-up, since some drivers, like the
Cadence EP controller, sometimes sets up a 64-bit BAR, even though
a 32-bit BAR was requested.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 91274779e59f..d46e3ebabb8e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -380,6 +380,13 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 			if (bar == test_reg_bar)
 				return ret;
 		}
+		/*
+		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
+		 * if the specific implementation required a 64-bit BAR,
+		 * even if we only requested a 32-bit BAR.
+		 */
+		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
+			bar++;
 	}
 
 	return 0;
-- 
2.14.2
