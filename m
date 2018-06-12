Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5AA60C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AF208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSAmfFpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeFLAVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:21:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45160 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934643AbeFLAV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:21:29 -0400
Received: by mail-qt0-f194.google.com with SMTP id i18-v6so22139276qtp.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47Y2wR93qclqlv5ZINfXplaxowHIThS2SV+BbG68R/U=;
        b=gSAmfFptwz7Q4ul2I0PQ05VZv86uJgj32dXN3PiWWDF0n6qpG73rnBhUXwdsGsz0D5
         XkeXZpIf8I9lPXS7U3AH45xXcwwEUvRqVmN/t6AHUpSlFRqaTUcHRjbzXZeqC/Q8tRhH
         mXzpH2uSdSIiM0X4M5vYcYjpSCNTMzme7Bjag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47Y2wR93qclqlv5ZINfXplaxowHIThS2SV+BbG68R/U=;
        b=i8ZooiNP/RYLEDdlB0bVYB9KCeGcUYt77+RDX95RE6xn3SHk/KNWNvvPx/xFmzHHg+
         TDOppotJZWS8NajSJZziHQRWdw1W3klC5TsNXZGtco+YzREZpt3XaZ44YYbR3ZVyX3gb
         9DCaNLLWTHAHOeBpcrZxd+nU5CHHmazyWLbODlYTI/Ytl5KEN/jgPEiffvXaXeeyr/Rn
         exbk1G7dNs6IynZDBixC2uW+Rk9XQMDMFc2XXrnqDEqrSD/g/seBgSmvqcVMkZWReSL9
         nDEGP2g+PVMZdqSyys3UN3xC/KMGP4xlJhLnMf3U4ikpWGJRV7Vh6/o4ULwojIIvzCld
         FlWw==
X-Gm-Message-State: APt69E2/+Ipw5uNC9zYmoNq3rb3/jL2QzXJq2ZbZ40/qcYPCHQnSnCcT
        sVzhIs2dVY8hMSNQ93SqEOEvYAViLJA=
X-Google-Smtp-Source: ADUXVKIE84F06LJOEyx5sTDlcR21ovceeXu0z9zjx1E/xHCJqFy/p363hrZ3O73JVmO/TshAAyB+OA==
X-Received: by 2002:a0c:cd13:: with SMTP id b19-v6mr1336875qvm.83.1528762888403;
        Mon, 11 Jun 2018 17:21:28 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31470299qtc.12.2018.06.11.17.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 17:21:27 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 3/5] PCI: iproc: Disable MSI parsing in certain PAXC blocks
Date:   Mon, 11 Jun 2018 17:21:05 -0700
Message-Id: <1528762867-16823-4-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal MSI parsing logic in certain revisions of PAXC root
complexes does not work properly and can casue corruptions on the
writes. They need to be disabled

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 680f6b1..0804aa2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1197,10 +1197,22 @@ static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
 	return ret;
 }
 
-static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
+static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr,
+					 bool enable)
 {
 	u32 val;
 
+	if (!enable) {
+		/*
+		 * Disable PAXC MSI steering. All write transfers will be
+		 * treated as non-MSI transfers
+		 */
+		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
+		val &= ~MSI_ENABLE_CFG;
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
+		return;
+	}
+
 	/*
 	 * Program bits [43:13] of address of GITS_TRANSLATER register into
 	 * bits [30:0] of the MSI base address register.  In fact, in all iProc
@@ -1254,7 +1266,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
 			return ret;
 		break;
 	case IPROC_PCIE_PAXC_V2:
-		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr);
+		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr, true);
 		break;
 	default:
 		return -EINVAL;
@@ -1480,6 +1492,24 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 }
 EXPORT_SYMBOL(iproc_pcie_remove);
 
+/*
+ * The MSI parsing logic in certain revisions of Broadcom PAXC based root
+ * complex does not work and needs to be disabled
+ */
+static void quirk_paxc_disable_msi_parsing(struct pci_dev *pdev)
+{
+	struct iproc_pcie *pcie = iproc_data(pdev->bus);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		iproc_pcie_paxc_v2_msi_steer(pcie, 0, false);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
+			quirk_paxc_disable_msi_parsing);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
+			quirk_paxc_disable_msi_parsing);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
+			quirk_paxc_disable_msi_parsing);
+
 MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
 MODULE_LICENSE("GPL v2");
-- 
2.1.4

