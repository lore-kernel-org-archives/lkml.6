Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18A520840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18A520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbeHAUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:21:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404151AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6249212DA;
        Wed,  1 Aug 2018 17:11:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 284/336] PCI/ASPM: Disable ASPM L1.2 Substate if we dont have LTR
Date:   Wed,  1 Aug 2018 18:50:19 +0200
Message-Id: <20180801165039.889885398@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 9ab105deb60fa76d66cae5548819b4e8703d2056 ]

When in the ASPM L1.0 state (but not the PCI-PM L1.0 state), the most
recent LTR value and the LTR_L1.2_THRESHOLD determines whether the link
enters the L1.2 substate.

If we don't have LTR enabled, prevent the use of ASPM L1.2.

PCI-PM L1.2 may still be used because it doesn't depend on
LTR_L1.2_THRESHOLD (see PCIe r4.0, sec 5.5.1).

Tested-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aspm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -400,6 +400,15 @@ static void pcie_get_aspm_reg(struct pci
 		info->l1ss_cap = 0;
 		return;
 	}
+
+	/*
+	 * If we don't have LTR for the entire path from the Root Complex
+	 * to this device, we can't use ASPM L1.2 because it relies on the
+	 * LTR_L1.2_THRESHOLD.  See PCIe r4.0, secs 5.5.4, 6.18.
+	 */
+	if (!pdev->ltr_path)
+		info->l1ss_cap &= ~PCI_L1SS_CAP_ASPM_L1_2;
+
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL1,
 			      &info->l1ss_ctl1);
 	pci_read_config_dword(pdev, info->l1ss_cap_ptr + PCI_L1SS_CTL2,


