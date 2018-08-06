Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA1FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8393521A12
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KShT0vAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8393521A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbeHGBhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:37:46 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37127 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbeHGBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:37:45 -0400
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so25289323oib.4;
        Mon, 06 Aug 2018 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WXbpsYMTz/QG1vzL3x5MJRxezLdU4OG6c9SB+TpFWA=;
        b=KShT0vAS5hdq8cmK7p8xAxvFu3GTtkHqyiyOhMk3kF3ZqC81EslEflDrsAFnSN/YI/
         BGa6s6HkJiekjU/j4+xd26gWrMfB2h0X1LB1J7dWFb/2aOs1MvDY88W4nn7ve0YW1pFW
         8iJLbjZEVZzvg9Mz+Msi1vS5h5xZmdar9mebyCKKQKtCsHvhRegcKWVgPsWqrrFQfB+e
         J21rrtssA+i2kQQTZ9s54nt67p4nVvPs7PLLjo4TIsgb110om0+O2bdd4Rm5LMoy0bs/
         jyRx9nCf94AG5R8OxEVd0bfFMBa8NUAfNnhhTTEsSEIVRDNGXyMmfxlF/OsyisXMh88p
         VCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WXbpsYMTz/QG1vzL3x5MJRxezLdU4OG6c9SB+TpFWA=;
        b=Un/bTc+XZbJ4UBBTjV2QBnj57I7OtqJ2CS1+ol8gZ0cgR/1fbhG96AdHrNK61QgaRP
         d5Ryp2Uh3LRMXVJE1nbDoZHC54mz9/m7uokIjG5zOR8pQpfgxS0pyE/CZmQeyAc1Eyde
         9gIkzRXBrfkhHscX7kKoZKtZMk8M8WJk9vaG04YVackqQ4vtZYK6MTo2uFfE4Siij2Jg
         zWmLWeiOGq5UvPm17KhfjXDcU5PMsJ2JeQuDsvCSW8FIY2J/G+Kaf8SLkIPHYW/qBT0g
         +WpTaKKd87ow/EzzOoIrklWoKxysbp0yDwfxEhcoOUuAJr4BYJB2L0I178pOmWiMMXS5
         +SHQ==
X-Gm-Message-State: AOUpUlGNfA85gv+tJUdpuZKC5/Lg9h0fAL7xoAYe66NWANVqti63yrrB
        OPf1d/fAuF3izw78ukXAu0ou5VF2a+0=
X-Google-Smtp-Source: AAOMgpcqOUA/kNzkVMbDdq5HkfCHfTJrwB4RWKrpc/P5ByRsBSjCYn4QtKuK5YdKRDODlfCDhs4ckQ==
X-Received: by 2002:aca:a641:: with SMTP id p62-v6mr17010358oie.151.1533597981033;
        Mon, 06 Aug 2018 16:26:21 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id w13-v6sm10613328oiw.51.2018.08.06.16.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 16:26:19 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH v6 1/9] PCI: Check for PCIe downtraining conditions
Date:   Mon,  6 Aug 2018 18:25:35 -0500
Message-Id: <20180806232600.25694-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe downtraining happens when both the device and PCIe port are
capable of a larger bus width or higher speed than negotiated.
Downtraining might be indicative of other problems in the system, and
identifying this from userspace is neither intuitive, nor
straightforward.

The easiest way to detect this is with pcie_print_link_status(),
since the bottleneck is usually the link that is downtrained. It's not
a perfect solution, but it works extremely well in most cases.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci.c   | 22 ++++++++++++++++++----
 drivers/pci/probe.c | 21 +++++++++++++++++++++
 include/linux/pci.h |  1 +
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 316496e99da9..414ad7b3abdb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 }
 
 /**
- * pcie_print_link_status - Report the PCI device's link speed and width
+ * __pcie_print_link_status - Report the PCI device's link speed and width
  * @dev: PCI device to query
+ * @verbose: Be verbose -- print info even when enough bandwidth is available.
  *
  * Report the available bandwidth at the device.  If this is less than the
  * device is capable of, report the device's maximum possible bandwidth and
  * the upstream link that limits its performance to less than that.
  */
-void pcie_print_link_status(struct pci_dev *dev)
+void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 {
 	enum pcie_link_width width, width_cap;
 	enum pci_bus_speed speed, speed_cap;
@@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
 	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
 
-	if (bw_avail >= bw_cap)
+	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
 			 bw_cap / 1000, bw_cap % 1000,
 			 PCIE_SPEED2STR(speed_cap), width_cap);
-	else
+	else if (bw_avail < bw_cap)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
 			 bw_avail / 1000, bw_avail % 1000,
 			 PCIE_SPEED2STR(speed), width,
@@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
 			 bw_cap / 1000, bw_cap % 1000,
 			 PCIE_SPEED2STR(speed_cap), width_cap);
 }
+
+/**
+ * pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ *
+ * Report the available bandwidth at the device.  If this is less than the
+ * device is capable of, report the device's maximum possible bandwidth and
+ * the upstream link that limits its performance to less than that.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	__pcie_print_link_status(dev, true);
+}
 EXPORT_SYMBOL(pcie_print_link_status);
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 611adcd9c169..1c8c26dd2cb2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pcie_check_upstream_link(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	/* Look from the device up to avoid downstream ports with no devices. */
+	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
+	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
+		return;
+
+	/* Multi-function PCIe share the same link/status. */
+	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
+		return;
+
+	__pcie_print_link_status(dev, false);
+}
+
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* Enhanced Allocation */
@@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
 
+	/* Check link and detect downtrain errors */
+	pcie_check_upstream_link(dev);
+
 	if (pci_probe_reset_function(dev) == 0)
 		dev->reset_fn = 1;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c133ccfa002e..d212de231259 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1087,6 +1087,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
-- 
2.17.1

