Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbeB1RdK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:33:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeB1RdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:33:06 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v5 1/3] PCI: endpoint: Simplify name allocation for EPF device
Date: Wed, 28 Feb 2018 18:32:18 +0100
Message-Id: <20180228173220.544-2-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228173220.544-1-embedded24@evers-fischer.de>
References: <20180228173220.544-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:ly9bmLk6qg0VB7I4P/p0PJJyLPAG6YiP8sqhSyU+imrAFqufseY
 jWWAuaINy65EkxgWS3J43sYjhSPQXHrERvP0afMq91FDXZCAL5G3CpfXIk222xuJ91JlE4/
 aBUBJDVOcM4ed5DfheBSr2LIPEsDCIAlQ0miMwbIT/QKl3Ythu1olM5YHjoEoLk+03VVEF7
 tICs8qsIdux4uiPsXEceA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XwDtVfLD3nA=:+K2fIuyztMZsnvqYYE6JuX
 bxlPpvGwF7pEFi3awVHhN2sQo3UxvFjDXHs4TJ82RNh0l1pLheZr2+odJDXrJRdzvdff7D/lm
 W/H4UayKEytg5EJvX/eJyra5h8tNicpm3eJcJuQul9g5fr/gEOtLoSSBGYInx+JFzF1BsJGBl
 RmDY1U95pHWm5AoZFdUPz+4rkria8lg9pYhmeGQVr4hp4jhE04/3sRFvE5g4/SNCvHOUDU4Am
 8QnCFJ3lDVZgxDpe2TAocN1jGV+ouRL+2+cfcxga7l2ZdzXWMaEOeS/EBoMLiK4sB/gJPSA4D
 H4UvzVISFmSRhu2YcqzdhGmyxlVfrDsyjQuVP0Ix3wHylZzPLZ4m/cYEqop9+NHpwzmuOCZpA
 q0WO2FHerQ+5MJluS0k/InFZb5ariJ9wYPOXzU7HR75MH15ov6zjKUe801dGmAP//rJxYFC/y
 bR31e+5nBF1L7CwnUlFuq0Giog7kUHRF0rSMIE4dJMeWu4cTsTaHIpZN4sVscVwBS2/j8Zw5j
 NnVDHUb4uogk4EUKbrQBZi/iuz/GCDRkrikD9CJhcrSZQjmY2OAj8YU7Ar49KLmaxmHbeZ4+S
 yhda5oD1L4vdufy3tJNCR8aQ4rUL2RcClgTtUtGkAf64QiKx/ghztp4PHrrdltygjdrv/tFrj
 lDU9D8IwubI1eM7Ajl3W0EEfvxy2ytpgOIaptbwbZvrtNOfcreWg9xwLbqiqiLnKkkQeLtGEP
 CEuuv3R3bYV7qz2AQNZadeCrUVSYO3fRViTkQw==
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
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
