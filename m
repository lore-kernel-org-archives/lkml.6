Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C65ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910D214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1910D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbeIREkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbeIREky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:54 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0DBE9707;
        Mon, 17 Sep 2018 23:11:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        "Bryant G. Ly" <bryantly@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 089/158] powerpc/pseries: fix EEH recovery of some IOV devices
Date:   Tue, 18 Sep 2018 00:41:59 +0200
Message-Id: <20180917211715.325802074@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit b87b9cf4935325c98522823caeddd333022a1c62 ]

EEH recovery currently fails on pSeries for some IOV capable PCI
devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
certain device tree properties for the device. (Found on an IOV
capable device using the ipr driver.)

Recovery fails in pci_enable_resources() at the check on r->parent,
because r->flags is set and r->parent is not.  This state is due to
sriov_init() setting the start, end and flags members of the IOV BARs
but the parent not being set later in
pseries_pci_fixup_iov_resources(), because the
"ibm,open-sriov-vf-bar-info" property is missing.

Correct this by zeroing the resource flags for IOV BARs when they
can't be configured (this is the same method used by sriov_init() and
__pci_read_base()).

VFs cleared this way can't be enabled later, because that requires
another device tree property, "ibm,number-of-configurable-vfs" as well
as support for the RTAS function "ibm_map_pes". These are all part of
hypervisor support for IOV and it seems unlikely that a hypervisor
would ever partially, but not fully, support it. (None are currently
provided by QEMU/KVM.)

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Reviewed-by: Bryant G. Ly <bryantly@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/setup.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -647,6 +647,15 @@ void of_pci_parse_iov_addrs(struct pci_d
 	}
 }
 
+static void pseries_disable_sriov_resources(struct pci_dev *pdev)
+{
+	int i;
+
+	pci_warn(pdev, "No hypervisor support for SR-IOV on this device, IOV BARs disabled.\n");
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pdev->resource[i + PCI_IOV_RESOURCES].flags = 0;
+}
+
 static void pseries_pci_fixup_resources(struct pci_dev *pdev)
 {
 	const int *indexes;
@@ -654,10 +663,10 @@ static void pseries_pci_fixup_resources(
 
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_set_vf_bar_size(pdev, indexes);
+	if (indexes)
+		of_pci_set_vf_bar_size(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
 
 static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
@@ -669,10 +678,10 @@ static void pseries_pci_fixup_iov_resour
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_parse_iov_addrs(pdev, indexes);
+	if (indexes)
+		of_pci_parse_iov_addrs(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
 
 static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,


