Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeBZRRk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:17:40 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:35925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeBZRR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:17:27 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v2 2/2] pci: endpoint: Fix kernel panic after put_device()
Date: Mon, 26 Feb 2018 18:16:17 +0100
Message-Id: <20180226171617.10016-3-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226171617.10016-1-embedded24@evers-fischer.de>
References: <20180226171617.10016-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:alg9JALAWbk+wUBLvrmih0f+atHeD+6HOPi1tsGD+4UCw7noD6d
 vOs+YwmqFxifpZR1DHYQn49JKBxxdxIzQXUEU/rSU9876rC5mksnVu75aJP+U7xp5QfowT1
 EjAR26gtObnCHCttT63ib5WaZJA6HKxLjUaG0xPo6dQQ/eo/xBk6GWo91ttqG1N15pkdnfX
 M0D/zrdbTFG4AiOi3cCLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ug8TGNibxHA=:vGFeKrRURb9oz62wLnubEL
 px8Pv6MfZ2AFvXf42UOHUnPYhV4LjMQKTZV9pVZ1KypiL9AuikzOQlJxV69neT0beRqNF3g2W
 J3upXBH1FjrJ0H8R2BToYYMeRBaOCw+XJCNiwl09vDqCkjfC+/v/QtHECaTt6yn5Ss135pwjx
 HrF/TXbTR+bFS+M4jBAWABi7qdbXfxT/7K6/7Z3jaaG/SP4af7k36H4lIY0tZ6j6JDFm4Z8Ja
 4T6IxK5ZIqWauhsAMeufX5OHjMFD21mvxtq8U1D8jUHbw7RLTE2hwXaUb8bSG9SLojJs6nakB
 xSPSL3KTs58m0XbbbzoXY/84JYqKExtCAImNqOruyfEB8DpF8VxJCmS0mhi7TohQoARvtq4hF
 W4Vfy0um8Bdo8vdFo1RI91Y+pr1wgJ9kLFlakNuKlmcfGpBoXUcpHP12+owv6jiRWQIdpQcto
 3yEZFrDJe0F/V8BOsDSgPx2Utnl1K/7IMDThPbDUkb8yG+8BGfSbzeRMplaSPy++sgOQWWrHK
 RLzXpljhY3THPLcx95StoDAJFBsFz5q5bXYYadRqzFs8xT2mKwpt5lH9naOIZLNXrDaWw2gEd
 utRndW8d2izTcRoSYoOxElz7C6AVU9kLkd1zBzdHRIjemYFXNS2HuQigqgoDS1Uy8owy4ktBr
 6kD7NWVMHwR1Wutj78o03dxxCCX8X0MxJj7y/W7ZfgArK72yl8b55cVSAM2q3drINdkfOxw9U
 AIjuaQ6hH9tyyvpegB3s+c57H0ZimWLNhQOGwg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

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
