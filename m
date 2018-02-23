Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELumjlNlGUkjYpkLm7Xr7YH76YoUEEz4h4gqAmVH9j7DPIIU4J5Y3Wx2FPV6ieoGsh6cUMUZ
ARC-Seal: i=1; a=rsa-sha256; t=1519412179; cv=none;
        d=google.com; s=arc-20160816;
        b=VEpWpIeRHHJckWbTXrP97l3FcHt6zuNDfD3RgJXo8UBOw5cSfin2wqWgtqR/Ef9MCO
         p4qFZJjwwrFKP3PqzPJ+NpFhlxew0ZY2MWOIEi1J7leoym4gYavWxql06DnepEWsex9p
         2lVMNmCkOiYaxAJpvN2HToWNRhD01GolqGqdtYlCyRHdr6lr/8bkk9dzNU391FGBQrG8
         JtDHui0kVfsuOLd4AXKnbxHr3Os19SWtIG3Inql5m4mXN3ZX/FBhv8+3Z4YKPSFdABqD
         RPSybOgqscytzn7RqsSWp4+ck1OBaPWowMPxRA5OXE59I4GoJtJ1ZkIDp0fjRTtW8IHW
         wGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5cAnjeoB+2wMCb6BR/KFhNHyj+8bruVzceLsgB5cZ4s=;
        b=hN6xN0PoMHGMIklHdmNi+fvGh5iCFwW3mo81JIa5SD725TnfxWXkxf/9UR4xQO7dnJ
         HCg3sWpt9XQLJhmojiO3e6FnLvQ575cAWUUiGW8VoxZ/nhxSEeNaYv3E/pdjikqvYSdg
         lHmFXZbSruD7b/EY3eZioutC3cAn/McAtrcnUWzh9SxS8qU8Qp+Cwyqc1x3hm9VgP8+p
         HEkEcUpVCmLiSNxp0nAAizegLx6YvXLRxCji/Qzzn9NWA+B7bw6DwJoZDYCq2Wp3cdwb
         kRhdJ+RFA2OrN5NQAROSK0P1U0q6+WWlXpznbr24xGGI2uGgH/qpvTMKigNCtXjrGOEo
         Ok2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 151/159] PCI: rcar: Fix use-after-free in probe error path
Date: Fri, 23 Feb 2018 19:27:39 +0100
Message-Id: <20180223170801.222910037@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219145981602190?=
X-GMAIL-MSGID: =?utf-8?q?1593219145981602190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 0c31f1d7be1b5c4858b1d714dcefa25f41428cab ]

If CONFIG_DEBUG_SLAB=y, and no PCIe card is inserted, the kernel crashes
during probe on r8a7791/koelsch:

  rcar-pcie fe000000.pcie: PCIe link down
  Unable to handle kernel paging request at virtual address 6b6b6b6b

(seeing this message requires earlycon and keep_bootcon).

Indeed, pci_free_host_bridge() frees the PCI host bridge, including the
embedded rcar_pcie object, so pci_free_resource_list() must not be called
afterwards.

To fix this, move the call to pci_free_resource_list() up, and update the
label name accordingly.

Fixes: ddd535f1ea3eb27e ("PCI: rcar: Fix memory leak when no PCIe card is inserted")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pcie-rcar.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1146,12 +1146,12 @@ static int rcar_pcie_probe(struct platfo
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
-		goto err_free_bridge;
+		goto err_free_resource_list;
 	}
 
 	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
 	if (err)
-		goto err_free_bridge;
+		goto err_free_resource_list;
 
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
@@ -1194,9 +1194,9 @@ err_pm_put:
 err_pm_disable:
 	pm_runtime_disable(dev);
 
-err_free_bridge:
-	pci_free_host_bridge(bridge);
+err_free_resource_list:
 	pci_free_resource_list(&pcie->resources);
+	pci_free_host_bridge(bridge);
 
 	return err;
 }
