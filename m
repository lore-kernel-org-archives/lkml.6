Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE429C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A32176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeLTIY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:24:58 -0500
Received: from ozlabs.ru ([107.173.13.209]:54764 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbeLTIYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:55 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 38ADAAE8035F;
        Thu, 20 Dec 2018 03:24:51 -0500 (EST)
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
Subject: [PATCH kernel v7 16/20] powerpc/powernv/npu: Check mmio_atsd array bounds when populating
Date:   Thu, 20 Dec 2018 19:23:46 +1100
Message-Id: <20181220082350.58113-17-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A broken device tree might contain more than 8 values and introduce hard
to debug memory corruption bug. This adds the boundary check.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e06043b..c6163b9 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1179,8 +1179,9 @@ int pnv_npu2_init(struct pci_controller *hose)
 
 	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
 
-	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
-							i, &mmio_atsd); i++)
+	for (i = 0; i < ARRAY_SIZE(npu->mmio_atsd_regs) &&
+			!of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
+				i, &mmio_atsd); i++)
 		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
 
 	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
-- 
2.17.1

