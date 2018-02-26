Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeBZRR2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:17:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:50497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeBZRR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:17:26 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v2 1/2] pci: endpoint: Simplify name allocation for epf device
Date: Mon, 26 Feb 2018 18:16:16 +0100
Message-Id: <20180226171617.10016-2-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226171617.10016-1-embedded24@evers-fischer.de>
References: <20180226171617.10016-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:18E+JROigLzvCotAfcdonpamBCq6RyEfN8QTfpjP6QQ10aH1MDe
 E7vmxth7o15cyh9R1AKIwjVs3ZGNXgJZp7fYYr8NPXRV4+ooAg1rPc0gG0BLXWyoDWVVslX
 b6uGDzWIDhssLCzHQBJhas0TiVamCFB0K/abv3+10T9zip9mzCyInFy4womefO5NK0BWXJC
 xABMU9NcuF8t/9paoMY6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sk3dvVlg70U=:77uPoKlyhLwOe4VmB3P+zH
 mjNjFYBQdw00mk8McaPKeL0FzpVVIuCBLxQCgFxPeL40DqypHG2gJsKZcTHZKzIUJKBHyoRpb
 gt9+h8za6LhywJssTLgH7xA1ICc/x9AJaErcg/+cI/b35vTtKzX9BJJ2j2UW3IJwJCCfBhTB2
 Aq8L7uCxhTleqRoVJ7ph2lxdZPdlywNK0UxoNF4VRUMf5M4MeMovAaeHrb+4T1x0hS49UQKsx
 c+d015LtZWfZI+Hxc5r+dI6qe3WG6JN7YAvwEeIPDBldj7oU2UPywjmpOR08ESpGbopVwuSov
 TStUdo2TfKFWo2udhBek6pd0e/EiZuoLzho6Cv+3JOxow2yE7WgViMKxjIpn5/mYqGfYihkgj
 QuNVH/eCLcybADyVRV1cQzqcR0zDxDYBhR8VvCVwBxkB4oG5DA3XdTHcSFrC/tbR9ZVYFifA/
 xQs1k4TuGh7vRPQq/LyfPiTLBewHgGqtg9+iaa8p2aqSHa2eZrjhL+SeZIB53lyCY12aJ4eC1
 SzLgBOo4yrCrfLOSpd/BGwBJUNcwtI+XAYCiVKqlMqrnpx0HEchvNHsk7T2jazAT4zpaa+/WB
 NXJTGS5l1sZvf26uIzegZ0kgpzwvw82T6jhH7/hnfFnIMg2CF4pwBztJ3+JzWkVdRoSHvi1Nj
 P84PELVsPUE73ZkWktxzSsV5l3KlAWwuvwSgn2ppd5WxSuRSkVSj7UFDW++UFsBj3ipPAdkgW
 UDy99wKjWQSCW6Lq437RVc3697ONl6ZqBrbF/Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

This commit replaces allocating and freeing the intermediate
'buf'/'func_name' with a combination of 'kstrndup()' and 'len'.

'len' is the required length of 'epf->name'.
'epf->name' should be either the first part of 'name' preceding the '.'
or the complete 'name', if there is no '.' in the name.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 766ce1dca2ec..1f2506f32bb9 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -200,8 +200,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	int ret;
 	struct pci_epf *epf;
 	struct device *dev;
-	char *func_name;
-	char *buf;
+	int len;
 
 	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
 	if (!epf) {
@@ -209,20 +208,11 @@ struct pci_epf *pci_epf_create(const char *name)
 		goto err_ret;
 	}
 
-	buf = kstrdup(name, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto free_epf;
-	}
-
-	func_name = buf;
-	buf = strchrnul(buf, '.');
-	*buf = '\0';
-
-	epf->name = kstrdup(func_name, GFP_KERNEL);
+	len = strchrnul(name, '.') - name;
+	epf->name = kstrndup(name, len, GFP_KERNEL);
 	if (!epf->name) {
 		ret = -ENOMEM;
-		goto free_func_name;
+		goto free_epf;
 	}
 
 	dev = &epf->dev;
@@ -238,16 +228,12 @@ struct pci_epf *pci_epf_create(const char *name)
 	if (ret)
 		goto put_dev;
 
-	kfree(func_name);
 	return epf;
 
 put_dev:
 	put_device(dev);
 	kfree(epf->name);
 
-free_func_name:
-	kfree(func_name);
-
 free_epf:
 	kfree(epf);
 
-- 
2.16.2
