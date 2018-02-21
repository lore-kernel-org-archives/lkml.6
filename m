Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224I6ZvixFQjwHHCBli6VmiObJpY0KNI+RLVdkDaZmaDz+/oWy50JBxTW8/aIhrVJ6GFTWuA
ARC-Seal: i=1; a=rsa-sha256; t=1519218672; cv=none;
        d=google.com; s=arc-20160816;
        b=XSPYgkKZSKOazXkoOVsL0At/mPTtGhp8HHdbPM3x99HWHsOMF2iSMsosq06BoT2hNL
         Jc6B3TlLMAccz5bX+WzEVLkXneW9hFqMKaF6qLPcgZAGvtoZbgDFo2mv2c8cJv4yG1fj
         5DP57CEgViNYPVNOLdNFSf8bYBuUsNjxRz+hBarljmz8KKShwEVx4RYy/fjS1312JE4R
         aD98vrmoKyXvIH1D91zHFweVAo/6cOoQ86dXgOrpiCsNRT4cowNOkctLos3ryQ9G9v/b
         2YLj5tGA/LRSAVtX7oijF52Ky4BHX8d4pul5Wc7m+FqQLPaxZyR0IivEG7ebNNmyrKHL
         Bnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F7R0yb6/xQZhnKGaETaoPhlVTjLCt4MUktwrH/ZkrjI=;
        b=YnJy65cPqGQYchoy4F8hh0OSN3E0MnjWkgfHTA6W2BfwVWMlTM9+3jUuCTsEg7ftEw
         NLgK13DdA8AzdGXTez9kfvaP/rwMMol9lDUCzyKkKHoM7QXHiAuF0kU/fCb4imT/lOnb
         A4fJjZYIiz+sM7Z9ckJKNQ+C06XvpEw43HFSJ+HIvGChE6g5UJf7LwOLx7ej0BE9zmWs
         qNRPh4n58PMVAesZFboXM8S0N7iwk8YA+tb2xMgnU85xgWkBOC5wLZvxcU4LK+AJJzl4
         62EkSm1RVGVwY+4yfjCYiFou/sz8Yj6zuzTZz5dh1ALzFQROtviC6KYQDSUl1hcX9B/Z
         Hdsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Ray Jui <ray.jui@broadcom.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.15 116/163] PCI: iproc: Fix NULL pointer dereference for BCMA
Date: Wed, 21 Feb 2018 13:49:05 +0100
Message-Id: <20180221124536.543759033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015823077676863?=
X-GMAIL-MSGID: =?utf-8?q?1593016239041781966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Jui <ray.jui@broadcom.com>

commit 3b65ca50d24ce33cb92d88840e289135c92b40ed upstream.

With the inbound DMA mapping supported added, the iProc PCIe driver
parses DT property "dma-ranges" through call to
"of_pci_dma_range_parser_init()". In the case of BCMA, this results in a
NULL pointer deference due to a missing of_node.

Fix this by adding a guard in pcie-iproc-platform.c to only enable the
inbound DMA mapping logic when DT property "dma-ranges" is present.

Fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
Reported-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-iproc-platform.c |    7 +++++++
 drivers/pci/host/pcie-iproc.c          |    8 +++++---
 drivers/pci/host/pcie-iproc.h          |    2 ++
 3 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -92,6 +92,13 @@ static int iproc_pcie_pltfm_probe(struct
 		pcie->need_ob_cfg = true;
 	}
 
+	/*
+	 * DT nodes are not used by all platforms that use the iProc PCIe
+	 * core driver. For platforms that require explict inbound mapping
+	 * configuration, "dma-ranges" would have been present in DT
+	 */
+	pcie->need_ib_cfg = of_property_read_bool(np, "dma-ranges");
+
 	/* PHY use is optional */
 	pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(pcie->phy)) {
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1378,9 +1378,11 @@ int iproc_pcie_setup(struct iproc_pcie *
 		}
 	}
 
-	ret = iproc_pcie_map_dma_ranges(pcie);
-	if (ret && ret != -ENOENT)
-		goto err_power_off_phy;
+	if (pcie->need_ib_cfg) {
+		ret = iproc_pcie_map_dma_ranges(pcie);
+		if (ret && ret != -ENOENT)
+			goto err_power_off_phy;
+	}
 
 #ifdef CONFIG_ARM
 	pcie->sysdata.private_data = pcie;
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -74,6 +74,7 @@ struct iproc_msi;
  * @ob: outbound mapping related parameters
  * @ob_map: outbound mapping related parameters specific to the controller
  *
+ * @need_ib_cfg: indicates SW needs to configure the inbound mapping window
  * @ib: inbound mapping related parameters
  * @ib_map: outbound mapping region related parameters
  *
@@ -101,6 +102,7 @@ struct iproc_pcie {
 	struct iproc_pcie_ob ob;
 	const struct iproc_pcie_ob_map *ob_map;
 
+	bool need_ib_cfg;
 	struct iproc_pcie_ib ib;
 	const struct iproc_pcie_ib_map *ib_map;
 
