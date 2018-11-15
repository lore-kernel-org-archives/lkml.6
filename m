Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A0BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650A42245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ubOOTg9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650A42245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeKPBUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:37 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:38369 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPBUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:37 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181115151218epoutp0408a7a164bd2d8666d609c69d0a92cf3d~nVOSe3vG01320613206epoutp046;
        Thu, 15 Nov 2018 15:12:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181115151218epoutp0408a7a164bd2d8666d609c69d0a92cf3d~nVOSe3vG01320613206epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294738;
        bh=kI6p2vhZEB2TrffD0NC5XE86qwf1DYaZqTO2jCgozeE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ubOOTg9Gf3Zd+yuluBGo5tH/pECDaWn0/1ju4+1j3KOxpCHb+ayRKXa73fBRevj7H
         2wVGgZ5QmJinxbmBmhYkbfYg1CAdKcpel2BGhJryVUXR8K8lat03hWkTDP37leDHf8
         a0+CMJL3LZWA5/C0Wf+bGoyHt31iuZ2iwDb9xaDw=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181115151217epcas1p1f188cdb4992f4f511d0faef1fbad73ae~nVORxM3-E0985709857epcas1p13;
        Thu, 15 Nov 2018 15:12:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.D3.04072.1DC8DEB5; Fri, 16 Nov 2018 00:12:17 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181115151216epcas1p3413d9586bf941aa086bfc5cd620d45d9~nVORKx0RF3140631406epcas1p30;
        Thu, 15 Nov 2018 15:12:16 +0000 (GMT)
X-AuditID: b6c32a37-887ff70000000fe8-3e-5bed8cd110bf
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 44.B9.03701.0DC8DEB5; Fri, 16 Nov
        2018 00:12:16 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:16 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/9] soc: samsung: add exynos chipid driver support
Date:   Thu, 15 Nov 2018 16:11:31 +0100
Message-id: <1542294698-17470-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCmru7FnrfRBtNXSlncWneO1eLvpGPs
        FhtnrGe1uP7lOavFqzMb2SwWTlvOaNH/+DWzxfnzG9gtpvxZzmSx6fE1VovLu+awWcw4v4/J
        4uWRH4wWa4/cZbdYtPULu0Xr3iPsDgIev39NYvS4dafeY9OqTjaPO9f2sHlsXlLv8X7fVTaP
        vi2rGD1+vtTx+LxJLoAzissmJTUnsyy1SN8ugSvj9fwnTAXzdCp6dl9ga2DsV+1i5OSQEDCR
        +Dj9PHsXIxeHkMAORok77a/YIJzvjBLfl0xmham6PvM6VGIDo8SFs1NZQBJCAr8YJWbtVgGx
        2QSsJCa2r2IEsUUENCWu//3OCtLALLCXRWJaUxcbSEJYwFli6bQ+MJtFQFXi8uMzzCA2r4CH
        xNVNvewQ2+QkTh6D2Mwp4Cmx/Ww7M8ggCYHXbBJL73WwQRS5SLx+vpUFwhaWeHV8C1AzB5At
        LXHpqC1E/XRGiTe/lrJAOOsZJdacOcYE0WAtcfj4RbANzAJ8Eu++9rBCNPNKdLQJQZR4SNw/
        eoUF4uU5jBLHlixjmsAouYCRYRWjWGpBcW56arFhgbFecWJucWleul5yfu4mRnD0a5nvYNxw
        zucQowAHoxIPr0H522gh1sSy4srcQ4wSHMxKIrxudUAh3pTEyqrUovz4otKc1OJDjNIcLEri
        vE+k5kYLCaQnlqRmp6YWpBbBZJk4OKUaGOudFqi6fngY///QipM11XPnHf165+T/lwuylpus
        c/DknOhtIvDChmlCmmRLxZLlptxPi2d8l+6qMrFta/LnS7oxbUW+eX3Ep7Om27u5DihqN1gG
        KQf96pPKuvOr5731wqliXzbcFej8XHnMyvvm09kfGqxOfdj5oSjps2p2zIfQI3P0JtVkZyqx
        FGckGmoxFxUnAgDyvJg9+gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd0LPW+jDVbs0bG4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLV2c2slksnLac0aL/8Wtmi/PnN7BbTPmznMli0+NrrBaXd81hs5hxfh+T
        xcsjPxgt1h65y26xaOsXdovWvUfYHQQ8fv+axOhx6069x6ZVnWwed67tYfPYvKTe4/2+q2we
        fVtWMXr8fKnj8XmTXABnFJdNSmpOZllqkb5dAlfG6/lPmArm6VT07L7A1sDYr9rFyMkhIWAi
        cX3mdbYuRi4OIYF1jBJnjv1lhnB+MUo8PfKeFaSKTcBKYmL7KkYQW0RAU+L63++sIEXMAntZ
        JPa8vQeWEBZwllg6rY8NxGYRUJW4/PgMM4jNK+AhcXVTLzvEOjmJk8cmgw3lFPCU2H62HaxG
        CKjm898z7BMYeRYwMqxilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAgM4m2Htfp2MN5f
        En+IUYCDUYmH16D8bbQQa2JZcWXuIUYJDmYlEV63OqAQb0piZVVqUX58UWlOavEhRmkOFiVx
        3tt5xyKFBNITS1KzU1MLUotgskwcnFINjFFv07IvfuUvTy5KOdn6zS7w5vc7b/QfH5r49d2a
        Kab9Wzb6fbzVll6mXa21TXTa9QcvEieZLTgcWrLlT6x+zwf/Ge8nnLN9t+zL42uJ9012iuna
        XNgRcfbKrJpTQQJ3EjrPOCSffyo9/4zlhUCzc2Vuxt9mx+1MOm8cL6Wfemhx6s5q8aLPj28q
        sRRnJBpqMRcVJwIAUk0gs14CAAA=
X-CMS-MailID: 20181115151216epcas1p3413d9586bf941aa086bfc5cd620d45d9
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181115151216epcas1p3413d9586bf941aa086bfc5cd620d45d9
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181115151216epcas1p3413d9586bf941aa086bfc5cd620d45d9@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

Exynos SoCs have Chipid, for identification of product IDs and SoC
revisions. This patch intends to provide initialization code for all
these functionalities, at the same time it provides some sysfs entries
for accessing these information to user-space.

This driver uses existing binding for exynos-chipid.

Changes by Bartlomiej:
- fixed return values on errors
- removed bogus kfree_const()
- added missing Exynos4210 EVT0 id
- converted code to use EXYNOS_MASK define
- fixed np use after of_node_put()
- fixed too early use of dev_info()
- made driver fail for unknown SoC-s
- added SPDX tag
- updated Copyrights

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
[m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/soc/samsung/Kconfig         |   5 ++
 drivers/soc/samsung/Makefile        |   1 +
 drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2186285..2905f52 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG
 
 if SOC_SAMSUNG
 
+config EXYNOS_CHIPID
+	bool "Exynos Chipid controller driver" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select SOC_BUS
+
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 29f294b..c2a8fbc 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
new file mode 100644
index 0000000..5cb0188
--- /dev/null
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define EXYNOS_SUBREV_MASK	(0xF << 4)
+#define EXYNOS_MAINREV_MASK	(0xF << 0)
+#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
+#define EXYNOS_MASK		0xFFFFF000
+
+static const struct exynos_soc_id {
+	const char *name;
+	unsigned int id;
+} soc_ids[] = {
+	{ "EXYNOS3250", 0xE3472000 },
+	{ "EXYNOS4210", 0x43200000 },	/* EVT0 revision */
+	{ "EXYNOS4210", 0x43210000 },
+	{ "EXYNOS4212", 0x43220000 },
+	{ "EXYNOS4412", 0xE4412000 },
+	{ "EXYNOS5250", 0x43520000 },
+	{ "EXYNOS5260", 0xE5260000 },
+	{ "EXYNOS5410", 0xE5410000 },
+	{ "EXYNOS5420", 0xE5420000 },
+	{ "EXYNOS5440", 0xE5440000 },
+	{ "EXYNOS5800", 0xE5422000 },
+	{ "EXYNOS7420", 0xE7420000 },
+	{ "EXYNOS5433", 0xE5433000 },
+};
+
+static const char * __init product_id_to_soc_id(unsigned int product_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
+		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+			return soc_ids[i].name;
+	return NULL;
+}
+
+int __init exynos_chipid_early_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	void __iomem *exynos_chipid_base;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	struct device_node *np;
+	u32 product_id;
+	u32 revision;
+
+	/* look up for chipid node */
+	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
+	if (!np)
+		return -ENODEV;
+
+	exynos_chipid_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!exynos_chipid_base) {
+		pr_err("Failed to map SoC chipid\n");
+		return -ENXIO;
+	}
+
+	product_id = readl_relaxed(exynos_chipid_base);
+	revision = product_id & EXYNOS_REV_MASK;
+	iounmap(exynos_chipid_base);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Samsung Exynos";
+
+	root = of_find_node_by_path("/");
+	of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
+	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+	if (!soc_dev_attr->soc_id) {
+		pr_err("Unknown SoC\n");
+		return -ENODEV;
+	}
+
+	/* please note that the actual registration will be deferred */
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	/* it is too early to use dev_info() here (soc_dev is NULL) */
+	pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		soc_dev_attr->soc_id, product_id, revision);
+
+	return 0;
+}
+early_initcall(exynos_chipid_early_init);
-- 
1.9.1

