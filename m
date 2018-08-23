Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D08C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B048208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B048208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbeHWMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:39:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeHWMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:39:07 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB29D93C;
        Thu, 23 Aug 2018 09:10:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 4.17 319/324] PCI: Skip MPS logic for Virtual Functions (VFs)
Date:   Thu, 23 Aug 2018 09:56:25 +0200
Message-Id: <20180823075012.064462672@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Myron Stowe <myron.stowe@redhat.com>

commit 3dbe97efe8bf450b183d6dee2305cbc032e6b8a4 upstream.

PCIe r4.0, sec 9.3.5.4, "Device Control Register", shows both
Max_Payload_Size (MPS) and Max_Read_request_Size (MRRS) to be 'RsvdP' for
VFs.  Just prior to the table it states:

  "PF and VF functionality is defined in Section 7.5.3.4 except where
   noted in Table 9-16.  For VF fields marked 'RsvdP', the PF setting
   applies to the VF."

All of which implies that with respect to Max_Payload_Size Supported
(MPSS), MPS, and MRRS values, we should not be paying any attention to the
VF's fields, but rather only to the PF's.  Only looking at the PF's fields
also logically makes sense as it's the sole physical interface to the PCIe
bus.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200527
Fixes: 27d868b5e6cf ("PCI: Set MPS to match upstream bridge")
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # 4.3+
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>
Cc: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1677,6 +1677,10 @@ static void pci_configure_mps(struct pci
 	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
 		return;
 
+	/* MPS and MRRS fields are of type 'RsvdP' for VFs, short-circuit out */
+	if (dev->is_virtfn)
+		return;
+
 	mps = pcie_get_mps(dev);
 	p_mps = pcie_get_mps(bridge);
 


