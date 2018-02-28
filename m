Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeB1NIN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:08:13 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeB1NIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:08:10 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v4 2/3] PCI: endpoint: Fix kernel panic after put_device()
Date: Wed, 28 Feb 2018 14:07:18 +0100
Message-Id: <20180228130719.31218-3-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228130719.31218-1-embedded24@evers-fischer.de>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:XPa+0CJa6B+YjHMf3rrlQuMPQxX2WrpPO3ZVgZBeNiEibvMxHbF
 MBe2RK2QLDfqt+GB392gk+JsZ5VHWLI6MRf4e3lwVMEfndmTZl55YeEAa6da8bhNtoVPCpy
 YaR8vFoNWaJVKrcvwZnn79G1y+CjHnlSk9HzqT+h00UsRFM7MgxgNAbhYNSi/Ccw+8tyEyx
 2Z6Zw7thLjOuXioWD66yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xn2UtWJQvmY=:z5UeUhs/Sbt3bLUv9Y3kru
 2JgiGP9og5bj1Qpj5KZF9rlkCcVw8NLL1e/xlyqpTVd4vxIOBjUjVc1t0yES9DTlMEIVamn4k
 fYTW7ICsVvb9RsER4/wGaNVg0uVL6otWPWD7SEepoQSp+C66SpQls1kRMu1fqOzL2msGwNFK8
 oUfAIz5lSrMBDb5Olu76WDuY9A5izm6QvyMcTReskwNoMILtVN2gq2QVkcFhdaFZJp8/UoO+7
 7mi/Hg6e939Od4QG8lO+nIK3hIGhKcTM08mDmP0KlOQD5Hzi/Zd4DaXizbgJeFMu2staR3CtU
 MEUoVOA40msx1ihWki7LoTznF/Lmptn19dscvmDZ71Dw2zaOkLPck650hZHFL2z8+cciR28Qv
 8pVCIn1yKrm4xPVBbtHytqpTgarDDyr5U3BOwMh0Jhwrjk9HXPyFFjs5+81d9BbikDeywFT2B
 4dn1j4pPc+yflKrO/F8lzAMRx8QQAP2+mVr8GfAVr1NMPV/zfatIiyQXRdl3yim8RnGwGHRe+
 2/+0re9M8gXUe7LemwpP0Dxl8rO5V/VFEv2HMyQQGPSqsVFKRtprv7vloljioOOrQAXD6a+QA
 A4Ly7xfuXGiFfYGXoJAxuMNrU/BXz+jAZsV2NuB8lPGQS8rZjQQir3K3ghQ+/UcZOa6MsJY+J
 WBU62/2sFUIvTbVsLfMRWi7yRoShds6MQ78DP5NvxYNyLURa85jKMY5pwWDKs1f38TEr7ZuDa
 nIRFPcbdZUgLndGhGw9jR4VYuyOldNMV7vgvKA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1f2506f32bb9..1878a6776519 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -232,7 +232,7 @@ struct pci_epf *pci_epf_create(const char *name)
 
 put_dev:
 	put_device(dev);
-	kfree(epf->name);
+	return ERR_PTR(ret);
 
 free_epf:
 	kfree(epf);
-- 
2.16.2
