Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeB0KDE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:03:04 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeB0KDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:03:02 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v3 2/2] pci: endpoint: Fix kernel panic after put_device()
Date: Tue, 27 Feb 2018 11:02:30 +0100
Message-Id: <20180227100231.22561-3-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227100231.22561-1-embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:UkEkvuL7T4/iDg71VNKRWW2nurAMPSmRaBSb/yoyOnkCMc9fsat
 N73McjlE5JL3eEye8g7dBX6jp4aYRSoO7bpJ21TTpHCtP8jbv7iUP1o39JR9ymSGPFwbGj0
 caeA7DTwSNcjyWXhcgQMbRB+8prVWNHbwN/PQSLXsC+mE8vs+RBpRLEdlaPZXL/bpGg0BXH
 OTqxbKUPTUvlnjMtjBieA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gOQl3g50Vz4=:pR1dZVOlj90mD4n67xnB+Z
 /fUybbmPYDPE51vLhNs+nw4pf++gnbYT91lYXWxoLvWRLuPwmne5jAz4aHswOHM0wg/szh5Yz
 pBQ+4wGG1xa0YbMqIhCxe8ogJRclalbUr2IG5g8uZ17zULpi1Ysk9LOOf0c15eWlpv1cjpxSS
 q4ZUcXBhjt1dzBf9IBU48EwZ0RgurN4aT9Sm2SgzuOM+5qVAcz8uqf6WjPs5Gy0/GqeZdlFpS
 Nr8m04mwAv193a2GKjgFITshs86VzN7/vp0nVr7yrVsBhTkQ4cR5BaXCMiFSsyrweAFhDYM7p
 KG4DTXtyq7bBaqz0zv+zu4Ki2yYYB82UQ4+zJsN6F8VFWCeG4ASH04Qeymfq+qZu94BnPWPXc
 F4DFRgACRQyNUeP2hk3oZB8PgUI2rxUShYefOx+WRFriLi9y9HOqTM0IJhydgk1W3TfYo/ZmV
 Hnd04qdQpjfoUGg45QAChhdsTvsNGya5MMbWLuocw1onK4VubhwJVJzOMO61N9OHiMQsnDobv
 Lwmf5XidkImJsuy7yNFGakIJHJJS1Ey43X2O+qi1C1XLy/rZ4iJLfYkb3V8Is0OJzwl+PU5QR
 P04gB0+QdPOMMlbvxpil2mHXFPQCb38oEvvcJLco05rf5A4MhDOfuYSL2t1ov9yJSlGQKPBv6
 DjNJMyF+vAbCOQZkXvG6m+IKZ7NdObzsLJP53AquahHzwq4b9l22xd/AuBCdoA/HUryiO95Yo
 77ram7/NKuOCUD206/iMqCCaGjHYwnlcHWKLTQ==
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
