Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2698BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEF520868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570319;
	bh=nPtdFiAJQ21DenT+bjFy7I17yy/o/UYJxoEZGe4hlOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9dYxtjrq2MoJVN1QPEq0IliesJ8wneEZzUsQ2ss7YbQIFmzzD3NHe+2goWJzFcgq
	 fUVlafFghE5YSFTPR7Ca/Gku3Flf660E/enR9kBIVO3ozstYRcx6YNbO4G8t+lYgXt
	 XJcKcWWSW/tvAEBEhTn3Yy2ZvxhZzUcITgLd5NMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfAOQih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbfAOQid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138A020873;
        Tue, 15 Jan 2019 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570312;
        bh=nPtdFiAJQ21DenT+bjFy7I17yy/o/UYJxoEZGe4hlOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqejvuV/nqVu8ciTO7egXo5lGvoszN/95sAvAfMS/W4UwSw2T68eZJx99RiQQCZiu
         zPYWVHP9DORA+tTEZ2YEw9VAVn15k3wAJ48y2ME/oHCILXtfk3bgcY5PBkdhjrqCzp
         JI7dAxR31pIGVvUb2lmWDXo78TDQg2W6t7/n33cU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 45/51] PCI: altera: Rework config accessors for use without a struct pci_bus
Date:   Tue, 15 Jan 2019 17:35:41 +0100
Message-Id: <20190115154853.643101946@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit 31fc0ad47e2e0b8417616aa0f1ddcc67edf1e109 upstream.

Rework configs accessors so a future patch can use them in _probe() with
struct altera_pcie instead of struct pci_bus.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |   64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -330,22 +330,14 @@ static int tlp_cfg_dword_write(struct al
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 *value)
+static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
+				 unsigned int devfn, int where, int size,
+				 u32 *value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
 	int ret;
 	u32 data;
 	u8 byte_en;
 
-	if (altera_pcie_hide_rc_bar(bus, devfn, where))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
-		*value = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -358,7 +350,7 @@ static int altera_pcie_cfg_read(struct p
 		break;
 	}
 
-	ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
+	ret = tlp_cfg_dword_read(pcie, busno, devfn,
 				 (where & ~DWORD_MASK), byte_en, &data);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -378,20 +370,14 @@ static int altera_pcie_cfg_read(struct p
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
-				 int where, int size, u32 value)
+static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
+				  unsigned int devfn, int where, int size,
+				  u32 value)
 {
-	struct altera_pcie *pcie = bus->sysdata;
 	u32 data32;
 	u32 shift = 8 * (where & 3);
 	u8 byte_en;
 
-	if (altera_pcie_hide_rc_bar(bus, devfn, where))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -407,8 +393,40 @@ static int altera_pcie_cfg_write(struct
 		break;
 	}
 
-	return tlp_cfg_dword_write(pcie, bus->number, devfn,
-		(where & ~DWORD_MASK), byte_en, data32);
+	return tlp_cfg_dword_write(pcie, busno, devfn, (where & ~DWORD_MASK),
+				   byte_en, data32);
+}
+
+static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *value)
+{
+	struct altera_pcie *pcie = bus->sysdata;
+
+	if (altera_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+		*value = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return _altera_pcie_cfg_read(pcie, bus->number, devfn, where, size,
+				     value);
+}
+
+static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 value)
+{
+	struct altera_pcie *pcie = bus->sysdata;
+
+	if (altera_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return _altera_pcie_cfg_write(pcie, bus->number, devfn, where, size,
+				     value);
 }
 
 static struct pci_ops altera_pcie_ops = {


