Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeB1NIM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:08:12 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeB1NIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:08:10 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v4 3/3] PCI: endpoint: pci_epf_create: remove goto labels
Date: Wed, 28 Feb 2018 14:07:19 +0100
Message-Id: <20180228130719.31218-4-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228130719.31218-1-embedded24@evers-fischer.de>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:XPwokUEX7QA6P/BqA5kDe5tv0/20CIJ+X4B/fL+cECIBIvO9wHm
 /8Jz3o6AmYDowxJHVh2SxRPOQ6NB/bpHZ/thMYJH+od9mZfOQmqDIrrurAwpDGIDjvIXPlR
 Idskv3t6Xv70otJvUXq5Oq51XrGQLsHvDTYWLVg5VZOYmMwUv7o6ccMZ1Tkx4U5ueqotpa4
 YVD3GUL8qnm0wbX0Zdc4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5GwQzuyWLBg=:2MXuApsg5Vlw/y1/qWW5Xo
 rgdmfGdfY/YIaTEyg62mQlN5LWoG3vEK6qUTUq69ZqbyVkQVSSlMonH6lUnYmRu/0HtX0vDo1
 dgOxjoU1WrYBtH93QZBglyI1tcfaiBnLkdHw5AYwRrnsny/aJiPxcqDqhVnlmDCuFjxUKsO4j
 0EvfsKcFRrBKaB+l7CROCBCdGvnZD+hAGDuvst+aEcIOctcnHq1fEcZ5zqjcJrps4Sx1vc3tt
 xPYAKKjnLqFSEaC5IKuAsZ/qmGB5EoNADZY94Okwod/WEX6EiqmEsSGx69H0V4yUN24SpG1tt
 8nRawJKjxHsJDOM1XzQG7tRw2JDLXzVMYPWdaWx0WY+SLdXGtSWA+aBdHHR5lnnbI42qBJ+W2
 wKa62vtQISnnF9R+PGOkFSSkQG3K0kFbUJCc/ZTGyQ7x7kMtSf4OzcC5SM023F/+dbmSphvoz
 IYSa11giSaNUms9D8ivNg8Kjoah8dSEaTR9UVK1qh1pr1VH+88X47S1kcjDysdkSgzyxUm4RQ
 3VeG9/z9UIvrfD1CaZJchNXhZOEiJ14i1mYprTWpH7zDerzBmMFgRGBSuVgVl9bJ7tdJq1EAB
 JsCorTpIzV/y6M07z90JpmPnP0TPE5hOZ3oBvuNJ5SkMCxCfDJITg49sFGUTidNFbIiocrw4t
 oyA8sbp0aa6R2d+wLttrieSqyMoz1KN6aaQaS+8/ssWmb60LQ1bpLBRLubG3nATJCMTVb9OKl
 YEJ54Rz1Skfo146U3oY4lqM4qWgM35zvzQEbkA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Removes the goto labels completely, handles the errors at the
respective call site and just returns instead of jumping around.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1878a6776519..cf2c4f6590a0 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -203,16 +203,14 @@ struct pci_epf *pci_epf_create(const char *name)
 	int len;
 
 	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
-	if (!epf) {
-		ret = -ENOMEM;
-		goto err_ret;
-	}
+	if (!epf)
+		return ERR_PTR(-ENOMEM);
 
 	len = strchrnul(name, '.') - name;
 	epf->name = kstrndup(name, len, GFP_KERNEL);
 	if (!epf->name) {
-		ret = -ENOMEM;
-		goto free_epf;
+		kfree(epf);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	dev = &epf->dev;
@@ -221,24 +219,14 @@ struct pci_epf *pci_epf_create(const char *name)
 	dev->type = &pci_epf_type;
 
 	ret = dev_set_name(dev, "%s", name);
-	if (ret)
-		goto put_dev;
-
-	ret = device_add(dev);
-	if (ret)
-		goto put_dev;
-
-	return epf;
+	if (!ret) {
+		ret = device_add(dev);
+		if (!ret)
+			return epf;
+	}
 
-put_dev:
 	put_device(dev);
 	return ERR_PTR(ret);
-
-free_epf:
-	kfree(epf);
-
-err_ret:
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
-- 
2.16.2
