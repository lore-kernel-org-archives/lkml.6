Return-Path: <dongsheng.wang@hxt-semitech.com>
X-Google-Smtp-Source: AIpwx49cXUBw2DqABE5QBJI4AQOXGcIzCsu4n/lUtDMXaOPc0Ar/4uPOOOxrF0703NDYgdAWsMNU
ARC-Seal: i=1; a=rsa-sha256; t=1522317694; cv=none;
        d=google.com; s=arc-20160816;
        b=m5s05O5CrhvC6zTchHG0q0yOupbOCTJTano30K62gljERa9yAh7My6+m05xlCo9pXh
         Bre/et8MRju1KUAshyyko0M0gjupzKOMm+l7BJlTd2Q9fpUfzpxUdic8nDm1qUK7iyE0
         8629BQwh0TA7c0X6QkuBLePL6Ut1xa01Rj+/gZ9KIG+QAEPNVXtRjbmsgClh522mFiEA
         9sksTnvJ8AJPaHx9shdCguANfTkZ6Oga/1glnBcoNr/9I32Y5LHtfv1tjmjzqzdJBQCI
         4miv9o8MI9aofYj9GbrdCR97OvMfxqJA+Hwv3T7dS7J/duNCe73MLVyZ6JgiH0vn3K5W
         thcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=uxJx6Ov7M1bVAJLtFxxKmpxijzRKNa7DHU0k3o6mxJ8=;
        b=eIDL112y/puv9LlsBtrVvxAk2IFk6JeGV8eNVUILMKxhGSlPl718PXhxlsBnyjnqGY
         soWzcP1ctJwpY9602hdbuux9N2ndEZjcFaLcNXqNuurtWgbZTh/bushwkCCNj/mU217m
         Tklpc6PrxVxJ6bF02UfKB76KNBWVt4KTJsu4XBpMKa5t9UjUSGVCCDH11EqqhLWkvSnX
         R0FduYB5NrXT0UuHNBBx0CKxNXOPXsxF7y+ovN40f9YqGSLo9oOgX0TDcfGqhf6ozrOx
         tDgetkvLcMMyK7yPEZ2SKWe0CmFLv5ecAXIV1SSD53fAIhWMEPehhY5vp8aSofQMa98l
         PvrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
X-ASG-Debug-ID: 1522317692-093b7e77020c070001-y9GDlS
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To: <rjw@rjwysocki.net>, <lorenzo.pieralisi@arm.com>
CC: <gregkh@linuxfoundation.org>, <hanjun.guo@linaro.org>,
	<sudeep.holla@arm.com>, <yu.zheng@hxt-semitech.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wang Dongsheng
	<dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 2/2] ACPI/IORT: use swiotlb_dma_ops when smmu probe failed
Date: Thu, 29 Mar 2018 03:01:00 -0700
X-ASG-Orig-Subj: [RFC PATCH 2/2] ACPI/IORT: use swiotlb_dma_ops when smmu probe failed
Message-ID: <1522317660-11080-3-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1522317692
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9567 1.0000 3.8473
X-Barracuda-Spam-Score: 3.85
X-Barracuda-Spam-Status: No, SCORE=3.85 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49406
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265798784882877?=
X-GMAIL-MSGID: =?utf-8?q?1596265798784882877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If SMMU probe failed, master should use swiotlb as dma ops.
SMMU may probe failed with specified environment, so there
are not any iommu resources in iommu_device_list.

The master will always get EPROBE_DEFER from really_probe
(dma_configure) but in fact SMMU has probe failed. The issue
causes all of masters failed to be driven.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index e2f7bdd..a6f4c27 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -774,17 +774,45 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
 	return ret;
 }
 
-static inline bool iort_iommu_driver_enabled(u8 type)
+static int iort_check_dev_dl_status(struct device *dev, void *data)
 {
+	struct fwnode_handle *fwnode = data;
+
+	if (dev->fwnode != fwnode)
+		return 0;
+
+	if (dev->links.status == DL_DEV_PROBE_FAILED)
+		return -ENODEV;
+
+	return -EPROBE_DEFER;
+}
+
+static int iort_iommu_driver_enabled(u8 type, struct fwnode_handle *fwnode)
+{
+	bool buildin;
+	int ret;
+
 	switch (type) {
 	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+		buildin = IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+		break;
 	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
+		buildin = IS_BUILTIN(CONFIG_ARM_SMMU);
+		break;
 	default:
 		pr_warn("IORT node type %u does not describe an SMMU\n", type);
-		return false;
+		buildin = false;
 	}
+
+	if (!buildin)
+		return -ENODEV;
+
+	ret = bus_for_each_dev(&platform_bus_type, NULL, fwnode,
+			       iort_check_dev_dl_status);
+	if (!ret)
+		return -EPROBE_DEFER;
+
+	return ret;
 }
 
 #ifdef CONFIG_IOMMU_API
@@ -919,8 +947,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 	 */
 	ops = iommu_ops_from_fwnode(iort_fwnode);
 	if (!ops)
-		return iort_iommu_driver_enabled(node->type) ?
-		       -EPROBE_DEFER : -ENODEV;
+		return iort_iommu_driver_enabled(node->type, iort_fwnode);
 
 	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
 }
-- 
2.7.4
