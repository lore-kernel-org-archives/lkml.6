Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA80C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357C124729
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357C124729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934437AbeFVTn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:43:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46814 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934096AbeFVTnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:43:23 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fWRxo-0002B3-RW; Fri, 22 Jun 2018 13:43:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fWRxl-0002jp-MF; Fri, 22 Jun 2018 13:43:17 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 22 Jun 2018 13:43:15 -0600
Message-Id: <20180622194315.10475-4-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180622194315.10475-1-logang@deltatee.com>
References: <20180622194315.10475-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, sbates@raithlin.com, hch@lst.de, bhelgaas@google.com, corbet@lwn.net, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com, kai.heng.feng@canonical.com, mingo@kernel.org, frederic@kernel.org, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, willy@infradead.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 3/3] PCI: Introduce the disable_acs_redir parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support P2P traffic on a segment of the PCI hierarchy,
we must be able to disable the ACS redirect bits for select
PCI bridges. The bridges must be selected before the devices are
discovered by the kernel and the IOMMU groups created. Therefore,
a kernel command line parameter is created to specify devices
which must have their ACS bits disabled.

The new parameter takes a list of devices separated by a semicolon.
Each device specified will have it's ACS redirect bits disabled.
This is similar to the existing 'resource_alignment' parameter.

The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
Egress Control bits are disabled which is sufficient to always allow
passing P2P traffic uninterrupted. The bits are set after the kernel
(optionally) enables the ACS bits itself. It is also done regardless of
whether the kernel sets the bits or not seeing some BIOS firmware is known
to set the bits on boot.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++
 drivers/pci/pci.c                               | 71 ++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a69947d9e14e..02634c4ab181 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3192,6 +3192,15 @@
 				Adding the window is slightly risky (it may
 				conflict with unreported devices), so this
 				taints the kernel.
+		disable_acs_redir=<pci_dev>[; ...]
+				Specify one or more PCI devices (in the format
+				specified above) separated by semicolons.
+				Each device specified will have the PCI ACS
+				redirect capabilities forced off which will
+				allow P2P traffic between devices through
+				bridges without forcing it upstream. Note:
+				this removes isolation between devices and
+				will make the IOMMU groups less granular.
 
 	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3fc823b756e3..116b0c9c4764 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2983,6 +2983,61 @@ void pci_request_acs(void)
 	pci_acs_enable = 1;
 }
 
+static const char *disable_acs_redir_param;
+
+/**
+ * pci_disable_acs_redir - disable ACS redirect capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the disable_acs_redir parameter.
+ */
+static void pci_disable_acs_redir(struct pci_dev *dev)
+{
+	int ret = 0;
+	const char *p;
+	int pos;
+	u16 ctrl;
+
+	if (!disable_acs_redir_param)
+		return;
+
+	p = disable_acs_redir_param;
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
+				     disable_acs_redir_param);
+
+			break;
+		} else if (ret == 1) {
+			/* Found a match */
+			break;
+		}
+
+		if (*p != ';' && *p != ',') {
+			/* End of param or invalid format */
+			break;
+		}
+		p++;
+	}
+
+	if (ret != 1)
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return;
+
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+
+	/* P2P Request & Completion Redirect */
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+
+	pci_info(dev, "disabled ACS redirect\n");
+}
+
 /**
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
  * @dev: the PCI device
@@ -3022,12 +3077,22 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 void pci_enable_acs(struct pci_dev *dev)
 {
 	if (!pci_acs_enable)
-		return;
+		goto disable_acs_redir;
 
 	if (!pci_dev_specific_enable_acs(dev))
-		return;
+		goto disable_acs_redir;
 
 	pci_std_enable_acs(dev);
+
+disable_acs_redir:
+	/*
+	 * Note: pci_disable_acs_redir() must be called even if
+	 * ACS is not enabled by the kernel because the firmware
+	 * may have unexpectedly set the flags. So if we are told
+	 * to disable it, we should always disable it after setting
+	 * the kernel's default preferences.
+	 */
+	pci_disable_acs_redir(dev);
 }
 
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
@@ -5967,6 +6032,8 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
+				disable_acs_redir_param = str + 18;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
-- 
2.11.0

