Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3D22176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeLTIYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:03 -0500
Received: from ozlabs.ru ([107.173.13.209]:53954 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeLTIYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:02 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id BC72BAE8010F;
        Thu, 20 Dec 2018 03:23:57 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 01/20] powerpc/ioda/npu: Call skiboot's hot reset hook when disabling NPU2
Date:   Thu, 20 Dec 2018 19:23:31 +1100
Message-Id: <20181220082350.58113-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skiboot firmware has a hot reset handler which fences the NVIDIA V100
GPU RAM on Witherspoons and makes accesses no-op instead of throwing HMIs:
https://github.com/open-power/skiboot/commit/fca2b2b839a67

Now we are going to pass V100 via VFIO which most certainly involves
KVM guests which are often terminated without getting a chance to offline
GPU RAM so we end up with a running machine with misconfigured memory.
Accessing this memory produces hardware management interrupts (HMI)
which bring the host down.

To suppress HMIs, this wires up this hot reset hook to vfio_pci_disable()
via pci_disable_device() which switches NPU2 to a safe mode and prevents
HMIs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Alistair Popple <alistair@popple.id.au>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v2:
* updated the commit log
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9ee7a30..29c6837 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3676,6 +3676,15 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 		pnv_ioda_release_pe(pe);
 }
 
+static void pnv_npu_disable_device(struct pci_dev *pdev)
+{
+	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
+	struct eeh_pe *eehpe = edev ? edev->pe : NULL;
+
+	if (eehpe && eeh_ops && eeh_ops->reset)
+		eeh_ops->reset(eehpe, EEH_RESET_HOT);
+}
+
 static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -3720,6 +3729,7 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
 	.dma_set_mask		= pnv_npu_dma_set_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
+	.disable_device		= pnv_npu_disable_device,
 };
 
 static const struct pci_controller_ops pnv_npu_ocapi_ioda_controller_ops = {
-- 
2.17.1

