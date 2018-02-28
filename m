Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933963AbeB1Rdg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:33:36 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeB1RdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:33:10 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v5 2/3] PCI: endpoint: Fix kernel panic after put_device()
Date: Wed, 28 Feb 2018 18:32:19 +0100
Message-Id: <20180228173220.544-3-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228173220.544-1-embedded24@evers-fischer.de>
References: <20180228173220.544-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:8DKh3sCtLV8NLa8/bGNa1W8jWf8nXOAvu45iFHmqI0y8Z9ziY4+
 Fm3cozcl8PpwflF3/TzsEz/4VlL8BX2OfkDT1JAjp8Z5X7ks6jnWzSKJTmJnBic8wbxeG4i
 4Kz6KMON17H2aw04WYfE4N2ANPWfEC2hYffsyuUyGTxYLldEIxUa1jmgXWiT78VgqfMcVFM
 RwmKlFmAivBkqelwTmLMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8mt/MSmP+bg=:x5I1U8ihZG53Chft4U7G+t
 ti1OHBmUXAY0l1lPjFShIAk0RUfoNJR4ZRscb2opaKFmQdQyWfxok5WVfIzfbd9i52PLfy6hq
 Rpgp4ezrdkbr+dHPbijcEhFBEKkmyZ32oVRHEYPKp6hlmxb/rkbv5lkTowPeMU0UdI7N9naxO
 ntXgivgDPQeW7vCrH3lgWh9egYuRcEySrwBGRWFtCnwLWRZL4Xi8oHYeoIDRSHwluOzQkC8LF
 s5McVCrkp7V4jaLufOf6eX0j9K9yuZGhUJ0p2lppWMj0gb0UzVCXQIfhbm9wGz3av4JQ4/qyn
 1iYoxThWacU3kc7q+XH5pbtPh7fxHgH25nFFJgxKjcvPvL5j8pG2XCZovpsTtnj+scAXm4Dwc
 6tf/Pbqk2bPodch3UQtmqkPgq8d7m5Gy7lEtmIrICddU+ARijEnJvROvKFVnhXiTKSl/xGNWm
 olDIF94joJZk+D+50gwjAEPzFyGgiH36oqJSgvLXqKfcOKlTxLdFafJH/2Shkqgef6MwsKTKu
 nz7QLPXYcTbCLBygCW9WSsF5NEUjV9p4KWJLXmIDEo01v/jhVx+o2nr8ZJSsYq9LmMOqucxok
 RTCPfr+0H3Bi2H6BadFCv2MSFzLzngPSkAnaJUlzJOGwmwszdTbv+a8ly+8H9qgkQGqP2BD5H
 qsEfeZVjkAf0Zpa08hq5zua/CYrnV+CeuK5hECeeNs8KQYmH0Q9SUhFDRDL02Si+whS4QnEHi
 SeRgMaYSVzmImVuQuCVvznW4bHeOKH/DSHg28A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

'put_device()' calls the relase function 'pci_epf_dev_release()',
which already frees 'epf->name' and 'epf'.

Therefore we must not free them again after 'put_device()'.

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
