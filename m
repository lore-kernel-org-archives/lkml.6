Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeB1RdR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:33:17 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeB1RdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:33:13 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v5 3/3] PCI: endpoint: pci_epf_create: remove goto labels
Date: Wed, 28 Feb 2018 18:32:20 +0100
Message-Id: <20180228173220.544-4-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228173220.544-1-embedded24@evers-fischer.de>
References: <20180228173220.544-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:yG/eeXtoHIq7h8Q98/gCIU1bo7vncKwDcRnzu1FU+nJ5YGOZWCb
 sj5oyMKjFwuUYrDZCCVdf8dnpfXOn3PIzioNAzZY8g7kd3JQvgaxpVlgDtljRoip3yDWvm4
 Kh44vr0CUx1UgB+BgsHnviMIS1v8ps+SZAQ+vrgLR+l6D1Q2+uxxO6rCggLeB24MPq+rHan
 ZANql6DOw/YV7NUHyuE3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zFFcqovk87E=:rrxp0uDspemBRNNQFgGlnb
 sIZDuYuVmqhzz6HDdAiBeLdAqRKB7i+jh4S/l1wE+avkQV7DpGFCaftptcrB5NPQZdLm1yvBL
 lJ5zQY6sv0yjQA0u3ayei8FyV66dogqHykfs3rNdUbutbdSs4t2cP8hMs87aP+i8xgLMBO1Iz
 8bRvmnFM7CyM8HwY6r0q3/BUIqD0ip+UnZ5QC7rOyOGMwz+ie63I8jS2Bid9cSKc9deq4Yhgm
 tX51N5Q40RE/6Wap0VBRnNHggNjHsFsGryMxmGEziAdfBiiZjK3ZSs47S0mpgImkB4tPNufd/
 J7XYS55JfgmyXDN3Rik+qWunN/P95LEK2kQJXnAFnqfjzMK2WkrgfTCAhsQTWkKgyzq/NV7li
 ymk+D/4eOi8NM3ZotyP+fFLyiKVC2OWGUfwBAe4bkYYrNdbDga23iXdjAVoFDPHbniIeaqhyf
 rAgf/JMoHtf4b6gXXLBXaO3GhRfAOi+MXDAiqIdSbT2hIliSJx3KrRsbyetk0xlpDhqCb6Cj5
 HJcE1AqQfRvKxKz6K1095WZ/obrZHA0UNi9jqgBWN2P3EOzb+5Twh6TC0f68ELaSmN9NoW2w7
 /L6MYJrXPYYmw2Kv07av6+UbCrdB+yAciIEGE5803bOs6NFBqKaxIc8SNzvJPDYQKw9hu+LxD
 p3w29uoKOnsLljFnmnEbe8aKUeveulZ6KBWFXCNA/hZGk9zK1gRj0pBPP9PcKgtystoUW8jW4
 er7zNkbUZ08Rt+7Y+G344D+evYzfui4m892GBQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Removes the goto labels completely, handles the errors at the
respective call site and just returns instead of jumping around.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 1878a6776519..59ed29e550e9 100644
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
@@ -221,24 +219,18 @@ struct pci_epf *pci_epf_create(const char *name)
 	dev->type = &pci_epf_type;
 
 	ret = dev_set_name(dev, "%s", name);
-	if (ret)
-		goto put_dev;
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
 
 	ret = device_add(dev);
-	if (ret)
-		goto put_dev;
+	if (ret) {
+		put_device(dev);
+		return ERR_PTR(ret);
+	}
 
 	return epf;
-
-put_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
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
