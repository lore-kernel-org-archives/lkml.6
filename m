Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeB0KDB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:03:01 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:48357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeB0KC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:02:59 -0500
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH v3 1/2] pci: endpoint: Simplify name allocation for epf device
Date: Tue, 27 Feb 2018 11:02:29 +0100
Message-Id: <20180227100231.22561-2-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227100231.22561-1-embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
X-Provags-ID: V03:K0:SbaB3svq6W235Ds0c3wdWDBY/YqkMBmwDkqZAffAF8vUgCwTsMy
 VLK39rjvAu2xsX4Sqg/iXF+CHewfagsjX2rhYga6UCRGQW2ViJbw1CRdDuAAE1ffmh6Tgk2
 emTc9PbKd239gLdMvDk9cOFUzaK8Ik07zPShBxzwaJ4QLaSPPj/7jdQjjSqzdzA8aWtfOFO
 k8uYra+wkcE4Jx914qmgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WPb25tUCObI=:vTsCSmHZ5oUcd8O1BdF3pF
 f9gue//OAbBiTPle8BjTXxQbVY706nR71t1j/2FzvACf+nmSBff00/K4WAsBCTiT38hInm1Wc
 xcl6hZIanIJD/CiRmErgN1lM4Zt2cPEzWWUggB9SaQZzWslUzhcPUvumvO2kLHDaNL5YF7tgc
 +zUFLHsw3Vb/NhRWwr3pZSK5Cf7XahrNS6ErrV9wsRUEQPtHVJS+I6m+RYPTwwIcS7GViQxGB
 pMYDLOqI3prQhGXjb4KtTwBWSDYe4Wp8GdLVElyVByBrVCy6ROk8/cf4YVn0MW1qGnJGqvrMI
 1arAEaMsXVmYRMBDbFKvs6lI6AzplticQmDdeQe+rjqL2zfmkpUyUI+7bld5rJDE6e8HkBPkv
 FWoTSQPK1Ap5y0nfHRiEh8Zw8kjWdneMe5kY0hZoRv/u8mdV6862K6yUBrmHFGuE0K/lFKTva
 baJYisP3dVGT7HtlZTZuwwa5KXOOIexEnNSfaiDQV6A3GUbpcqVwcZpbTmaBsR3IJLb9NsTTI
 OoeJzeTqBnn7a6b7DsjAhkapOwwi5pYpXScd+3ueIo7cvpaI41DufgKmYXsDcFq7DaUBps4lo
 N5SKv9pTkU1AuTcIh3ohoTDmQo7Jn2bEMTYmWBGeNeZxYR7ubiKw1XUdYxlxx0fDe0dcmv/5n
 sIJSVYgMS+fWptL9nelWvk2z+M0aT4osdpBvw9CvHAtymFyXE6UE5Zfs2c4pHs4/cZ+cg/iyC
 e/ZbMO90kxRbOnCXxjuxKgupO5jhFk04RAuHoQ==
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
