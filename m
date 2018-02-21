Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226q9A+R0Z1e5aE4QPVbdH/fk7BtDhdz9ylGUoKPQWGB2C1X4oqvkZYLTtgGNjN+Upi47ddW
ARC-Seal: i=1; a=rsa-sha256; t=1519218276; cv=none;
        d=google.com; s=arc-20160816;
        b=WHoeSYUrkSxTXS8GJfKbF9QPcfmomhPMJolTF7gya9EvGf0fsC3N3ANDFfWO1B1zup
         wAyepxOykU4uEvqJCrXUYPVsGyCPeCTgKxLKJx+KqOmoOkTDghpuq2b5WCNHQjPmhhfI
         tvKwGM4kGReprDmMwwE6h5GQBd3BpiS233cXVH/sVkC6U0ZCaATMhCxzeZjwkhhI/A+d
         cLGys/Oo8BiAUJLpvzfVCIptLM8HiwAd/zMG9JesstDvi1b6PugIPddC4hyFBYbq79ej
         ixJpAk7XFGEUuwzkUUFfWoaWwk6nS7KW3koWrqn4OiU/xIgv2f77iqMk3VbemfwKtMut
         bu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k3J0rczhxVxi/MPMzUuvxV8Q573DiVIgeL8Oob96GzU=;
        b=DABXjgxJrsKMqslTkOja+rZxP7ZWlAIDqj483cTJfyNjfh/XO+K/Bqhxldd+iI+Dbz
         PnXgQO2vVlTQwV8d2UPQvap4dyIS8cUO8XDJXG98gGU1wnuI0FQuQ/3zs34lQyK+1Hof
         UTMTbhULP1gK5l6Jy90sBkd/JyHioWzkXFw3alEJYZzNO3s/vK5WFT95PM5nWUp/c0e6
         +9Bqs+WC0dSc/aSgDq8hABrCOQ8fgUPBCD8LQCuhRhIBO3IEVXn75ge4FHL12S/jISQg
         T9A+f28aWQpShn+N8aILos2fhJa1ZC0FqidooTArd9dykT5aUSCzOLoQBFLmmKSUKu9Y
         IPdw==
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
Subject: [PATCH 4.14 114/167] PCI: iproc: Fix NULL pointer dereference for BCMA
Date: Wed, 21 Feb 2018 13:48:45 +0100
Message-Id: <20180221124530.631413932@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015823077676863?=
X-GMAIL-MSGID: =?utf-8?q?1593015823077676863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1396,9 +1396,11 @@ int iproc_pcie_setup(struct iproc_pcie *
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
 
