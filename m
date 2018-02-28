Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeB1NID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:08:03 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:41685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeB1NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:08:01 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v4 1/3] PCI: endpoint: Simplify name allocation for EPF device
Date: Wed, 28 Feb 2018 14:07:17 +0100
Message-Id: <20180228130719.31218-2-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228130719.31218-1-embedded24@evers-fischer.de>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:HPeWfnBRZ0AC4rTCc6OZZXBrUMpVCVFQXpMp4MGxctTYTCc49jK
 nfDMOMmSLHvOsV6127O+CkOZod2HLhdXYXpGkvPKEcFtiVOxfn6wKstaIqTyVwnjpAXckEc
 75Ts2Z2BVZkyY0HL7T8h2SuuAl1WZjKUeC6VlLWmFdGOuvNNiXsEdGTEZtues91WbfTJR0p
 JpeMTbvUAAmH4gfZkZVPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nOMk4k6pMoE=:5wI4HsSlJAqtpSCViN+ut7
 S/K5TrJ0qcmHHahJhDATfzNMykJqDqISSArG2GzfxQlz1lk5fE5ipPlZ0B7w1+ofc5QrLpJV4
 4SSuJ76MjrEjkxkre+Y5DHktX2XSE0/ZP33KE4HRZj3TnadRtbI/esFVimisE/5LbjvUxPTp2
 PONf8w1qGQvDq+lgrhiBkDidmioNk/ddJOfuTZXPdgppftRtDmyfF8UUzUPgEspFsBRxVRRYg
 GEJsZR0PeAq5I8ImrGS+eEs9lKYdU0AbxQF1JRbD2RUm8rs3FO/QzLoectajvgJxJpTsGM7ap
 Mb2miWSzsO9WmDe1qlLi65mj2GYpU+ittU54/XWNR3N7W6U8U0M5xvp9Mq5e2fSj4tn4xcOFD
 IpNRErRugZQvqfkm/29z5ZtaBp9WD7U/rNixhwh44sKFYer9cFPM+J84QOMAMnjXGyhJ4hzv6
 O6iRXZWnalpS+2Ptoo648yaX3lbMcz0HEWl6Uhnn/rPd6NY3n5j09Y48GHgi9dCqSMtWVQChi
 3vOK4dq5skmE8C6NgsVagQedD8fb8FT9BxbgnOTYAAU13KzTJOnJZiIU7NIIGtYX8xbwQE7HG
 S+WAEiC/CcBuOsjfCzBTNZK8Gr0EI9VWTEFDaEzVw9reAZ63wUufgKYEEavX415iXxzXmv1Gv
 nNDz6VTKENma7+1etaga13sQTvyXcSStG/lXG6pdmrqMQ7TMFRLKlGy578kgUnEFqzy53JCBM
 fjL5NFmLsuLQkSxwq6+Q3wXBcM9z/EJi2x3ULg==
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
