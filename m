Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx49iv6hSH/CJfVZviPd/pQEQUa7b29tgrNCNKi/YR9AscxkRn0g2WoLVE3F8zrBK7ptbpqjJ
ARC-Seal: i=1; a=rsa-sha256; t=1523960830; cv=none;
        d=google.com; s=arc-20160816;
        b=YEVNgbazWKu7IJfsWaomgpA1hv5STKrUBl9+21rCRRKGlVfSo8AG110CqVt6BOn00V
         bhYgLySAQ8NsEGxLxZ0puF8dEcpA9zoVKn8xAx5cwGc5Lyk8V2xYmw/gbwuSeOFRQU0D
         F6rvRFhq5ClL1dsvy1R53eNrWCXIi2OWq1/epX8qGhncyHjzBxz8s8rdkDthz3lYSwXV
         SfJ6w7mk/JqIRPPINQ3WMUeplSgRERfM5ez42tBTsxr8GUGsM6QBu2e5nEDenCDA5hev
         5RxoYpafs0YpYwZRMnvZMgtbZccNIh1SilDt2qc8LuaPw3b49V7ecVo50qRoQ4JOVtL3
         rv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XTg8yXCID6Fw6mVHPz5xnTm0e4CljfWQPD5VSHO67Fs=;
        b=0XMI0d14sPW8WcONyXyqN3wYfOAku7cK3TlnjevJLJ5kN5gvs4NyOHVv4u5k6ltyAP
         +uKw5bpzuitvhFRshd0kY2UZ6e4UmYuK4Ef1t5D2GD2meUDGLmhI1sdi/Vh+Py/hptoU
         GYAYCn71N1/hIZgpR5XsfUfo96fxz0iJO60nEF8w0AqxNVXBoJhEnGu8EFyK9Dbq3OUb
         Czmhu3xSekXPpt6ut5FFNs56HR5VNb6KDzt+vbGY84xU42+6ktPM4HwxtRGA8UJN4Ah4
         IPUsnsxKDKfxMUqg2kF4NQXPl8/u/qkR6O8361IY1xraHPx8ZE8AdJMqJfZoMoG6+lLk
         +jfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=qpUZ4Jp1;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=qpUZ4Jp1;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.54 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 4/6 v2] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Tue, 17 Apr 2018 15:51:52 +0530
Message-Id: <1523960514-25457-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:4j/4rL6I727vbIkj3aM9FdKsJy0AcN69oSwc1A0Lp3/NKtpr80VUJ36xTAZR/QgRQbUmMddaflvlHYL+iV0uoeUVYbxm63Df0JQi8VaR32xU1f+nzsZkinfMESvDFqHXPT/1aGUl5KJhWVJyW7q5J9R4ioB+a+zI8gOj7fpyQ6yslQ0uwAuZ5ybPicWSTyWsjWBF46wGzkZm/CmYwYpzixzBTj8oo/jtJP+2D+HkS9F4jzaP2AZfgBdrXYO2bAlA;25:wUFo1/bYqphHiATY823t/tYwI5o7rLn1hoojQlaPeYvIywdrx0qkT9OQW1AtebDsnqg1LhM8W3aXXgr+fsYiJgQDa3tEnUmF1HfS2pye4H9lS2HYvejg2k5jnXPTkOmJwVMHT0Ab0ajzd72dHMkx4u61+YdA0b/AQ5Fofi/fqvwfrL2q6rr0gepS0QrHvRaKgd72YSkDoVWU66FJ5wGqK9pHpkV5TgipCupfhKG80PlfZ0+2NrNjcnKncYu7H70Q5RhQDjUjqC5d+GeasqT2vh4ohenEGjyxwrTeShXw4M0fJUXs1MAlXBv9qII9Jk8Z8qhbP/gQ2B3e6o2O+FTpNw==;31:mczOVWCgUJ/0NwAv4RuWUrNT8FcGQhV61Y2Jc0el/aZZDp5aol+oLRIsLiZQax1KGfQPTl/+pyXBig8KzFANo7qRzvVVwJVJQ8249rWI2X7FVmz/eVF7zKvuQvJmWMOEvhPrVwY/IeYzTBOFE2ikSoOrROKhKC0eJZ0L2fD5JlEdI4LDgUlQWkNmsmrFQuLNTTQgMPbP688++/D/Ke6OM7jhRttBfvC3CbL8f2PUuco=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:8IASot1HjFFeFHhVAelf0jpVGES4b0BX8DNzpsyLrIaEwzHJAV5yUayz3A+myUwUeAD60mdbWwVCt3pOpmvHx//7Pzcy77IWXhoh0Dio7X3bd30T0kyj7ct5DTcptu2qc+AfOnOlKKhm4GmkAHTr5qN4bJfrIU3aYB0UIbGRchBEek10tD70cEV215XJlzNW14euV7sYXmpMr8oVcy+xYzOvoZGVzfgM/nhqNggVb5yz+Zs2189WmV7Glj932FefaVLu29zBJSo/gZCYboHYaFhw0C2jTYSIYEEF5VH30N3a9bL0HBToXdMWqjv/OKRbfM7h9yy9wrlQPywQ1BYGb62yveSwj9zE731nnfNghTZEGz5OsU1yBbLATz1nnCY3x4ajSvWY/3gNjgmgp+vqhahNtXLfp53qouO+daNwcgun65Qqd9zGt3uDHceSWO6pcvt1/GCsu7gR29CfUt9De9YSG/EJi6X6DZceWOMSa0EZKAcokSqcknAbn+QZooGl;4:7FuRvWwr/DHvofd6MXCfAZ209etqmtd/D1XdTDVkZOINbZmK7N+GxDPlF6xk+5oktZe9I4C7P1tUEG18h604nr/Ybkwik19+vIPBPxQraIQpuNVD+bLhYXd2q4KTsp/vuCWAhkvOiOCGQMKUa1AkzVQ33BwNu7ndW0R19njR3a6gX3yXjBCAgkFFQUxkEUCYsoDpJ3s6Dny5VTmvarhsjr8KIiRcx5TR0tIUrc4HgDHhNnrZ/qicDEYRhaXwEGGufLPhgza3AoamqsVAAjOY2WAQR6amaLOVBJuHwf+bJmRtnQcGsSvpVoE7eoS7hmeg
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418FA6348798EEAAF207E74E6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(6666003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:k3gaGUOkqz5IETe8TNkxQbvIL5Z0pr8O/Peh3qO?=
 =?us-ascii?Q?pnEnmrVVwWQpAHDV+dAGmjQQe+t1kNExr0uXcGN76w6J5sallp7yoGcUOwhp?=
 =?us-ascii?Q?2miUIexFX0c4umfxkIUr8ZSivbsD6dvSQNOJVKOIRUdwWmOZBMXukNpM+TUv?=
 =?us-ascii?Q?fXXr5wEnnFo561dIZV7kBeqsazU6qKOqDChUfyFyzk2DTWfDc7Q8VRXF6fly?=
 =?us-ascii?Q?psxyrgYKTnk6gcoZGn7eKols60yZ/UlL+hyOhOqQ6VxBYKzNNGPXE6KWXg7D?=
 =?us-ascii?Q?3jNiwySOsHsBc4JORaowYJnrwyjDIGxjp0nQ/K822ohWBfYr0yhKsTiL6L5T?=
 =?us-ascii?Q?aco4l0bhhzCXnqT3d5BHGoCgBo1bt8T8nP6GK/gtFgIHjOwmghOL6BFHrE0G?=
 =?us-ascii?Q?rigfi6Mn6ofSCW0tn8bWWH2KAvnUKKDn1CFUUeylXMS2Uq4aVEwvJvb4MiCF?=
 =?us-ascii?Q?OVytC+J7NVwAEW913MtuTCZSV8pGh5DLVtYmNQ40ofKNDtBlUQKmqnTc0v4b?=
 =?us-ascii?Q?vPEyeSk9u6K6Z7CidiEDKM3eKtJNHfZGorJOLlRU7Vvdd7vIc7kpaD1R1rCY?=
 =?us-ascii?Q?lU2PDlFPz/boVAUoDIyQ4uwuT6RI7agjkBlUbk4VVLGaPhQ0wNopDoVskQdH?=
 =?us-ascii?Q?LwlOIz2RhA7zejOwiijHGimXoE5p3KFAJdBwd8jsGI2+I+2kvR3H3n71ZDLw?=
 =?us-ascii?Q?AKx23HMfaV+DXYqvS4JWY5SY/7MTbf5RmdCPwb/AJmf0i5hEOf851b+Pw51T?=
 =?us-ascii?Q?qmEN9aIAMCIs3LNMuJ77tzKS/4fK3vQGGQTM5b960/BZhFGfvPue/5jaOnzb?=
 =?us-ascii?Q?X0jovxzFxAQZkcbhi/JnzMCtAUiBUtY8vN9ML9PBIDOUs/gudp0pFIcnF0gW?=
 =?us-ascii?Q?3rwodBOOyS13w3cSq39hReRIJ22XNLw2GoZy5u7KVMgx9dvW9lvEhAGcfAFK?=
 =?us-ascii?Q?Q7fUxpq3JiEAWm2cuDpaQFt04OFfbp/IZa0yQi0IxeWNP/gaA4fKmP7KcoXO?=
 =?us-ascii?Q?G6RqrraZ+qGEtDY1Yybop7NeAyAO/3W2cRflTsfSxsAJczzs47HGIkne/IED?=
 =?us-ascii?Q?445u69k4Aj6+ADN+I4AAM9RmtRIc4BUEwvop+44A335Q+Er7O1GVneWG1Sly?=
 =?us-ascii?Q?Gm4TsMjUJQQrMEts9D+GBhYe8AWoS14kMJIF/vW2+F9i46LzVr0qENXxxk3l?=
 =?us-ascii?Q?97LUHSScsa3pDEp5MpX7SHXm5KzcSyE4cU7SaoiUkL2YyIF60jdNppAQFlv5?=
 =?us-ascii?Q?3ozfGFXCn9zBPm0J1mSpnnEHoklddN09ApacRIW2BpIWGdfPIomJbUwILf5S?=
 =?us-ascii?Q?YdrEFR1ma53IUlslxS2vsOUM=3D?=
X-Microsoft-Antispam-Message-Info: JYzbnnPiNcs8/gckJTIdwyBgr7SUeBEnheY+NeIPer6uYkIcMtYrHMbqZVVUmlYC6ycz/KI6PC2RUbBOq5uau/7xjjRAviosMAxkLY0EyinAjVdcKP1uqad3qgEy2HO+yBuJSrFBIs3+y5bmZAPYnNEsV3AEKkbaBYdge2Ns0r+7hb3NFDkzdthwNfRwKxXY
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:7xJE3wLdXHqGUXt0Ry3zg5Z63ql7OH/AoPcvzZNsdz1a9X+U05FAfZ4s0ZAc8MbfPbuZoNdY/L5585Y7mp52Q003NF19Bp8vGYwbtqdB17h40lC/K+sBbWhdn/2c+gBjl5n2XDhSBmNXvBwhjzcAp8mGhbJsmo05SkGI7SEtG05hU4RXIvt9eqO26LIccw1fhe4puFyQG6a7Wufg7IwzHLv6kK4icQ057g1nqW6Qw3pCEp9LX1yxot1mchgN0r/NR75ouVlJbapeU5D0clMTZ2Owaj0QeR5Umk/YDQnQZRmHCmSOC1yEz1W5UeN2x1ehZgFCAqfnO63ep3AeTph+dR+AfTQBuLgtSrpDiOtXV2osxzYrTKrQMIXCXLg1iUdy/W/uONQXuxCzOzFps2AYHnHrp8U/a3D8SJFgMcOq2kID56xK15Bwjotisk2CNnZHIdXs4lLVv4+cK/vpsUFFHQ==;5:rlggQaMMQBgP9kdK2NNAKYv9Eqs5ffvF5rL3ch7mnR50E5r5Rl5Wag44OgU4S6y2iylVXN5Jrwvi7qrN5y7dobUD5TxtNEyUh3451YLGpg+QsbOPASQ09HVLZdLukC7cU5Qr/QnSiPufqUpjJgK9apytdCO+sxe6W7sRArXI/cs=;24:y0NsOxTpb/kY3AkoEh/GNkWMY8hGsA1MkML58ak1ZoW5Hm9gFdEghkLAcm+NH64HUYBQDr7yrzlTF0gbERhGtbd+Lh2Rs+IvG50Xde5dcH4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:qms7owqfO7d99hB866t56mZDNcbD3S90+lJs0JWR1cJRVnbWk3ne73DGTQCRNHIlGBx7gwDfqlPccm0I7DLA5wE6+PVQF792uSc9KHhLnXRimqWr5NO+FKzmCktaKg/TI8Q5Gk6j9wFZNofMbA72ZMECxgntI3xyhxvZ21j+nCIzI5ShhUqxa2144AgDm/96tjv2qK98bQ5lRLLQ8Q2CNGGj+wJHifwAhBOlyWl9hR66dr8Ahe+cOod3h6tVpuOe
X-MS-Office365-Filtering-Correlation-Id: f78b50b9-52f2-4005-58e1-08d5a44dc2b6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:26:58.2611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78b50b9-52f2-4005-58e1-08d5a44dc2b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108381270270991?=
X-GMAIL-MSGID: =?utf-8?q?1597988751895067949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement bus specific support for the fsl-mc bus including
registering arm_smmu_ops and bus specific device add operations.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/arm-smmu.c |  7 +++++++
 drivers/iommu/iommu.c    | 21 +++++++++++++++++++++
 include/linux/fsl/mc.h   |  8 ++++++++
 include/linux/iommu.h    |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60..e1d5090 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -52,6 +52,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/amba/bus.h>
+#include <linux/fsl/mc.h>
 
 #include "io-pgtable.h"
 #include "arm-smmu-regs.h"
@@ -1459,6 +1460,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
+	else if (dev_is_fsl_mc(dev))
+		group = fsl_mc_device_group(dev);
 	else
 		group = generic_device_group(dev);
 
@@ -2037,6 +2040,10 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 	}
 #endif
+#ifdef CONFIG_FSL_MC_BUS
+	if (!iommu_present(&fsl_mc_bus_type))
+		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+#endif
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69fef99..fbeebb2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/fsl/mc.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -987,6 +988,26 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return iommu_group_alloc();
 }
 
+/* Get the IOMMU group for device on fsl-mc bus */
+struct iommu_group *fsl_mc_device_group(struct device *dev)
+{
+	struct device *cont_dev = fsl_mc_cont_dev(dev);
+	struct iommu_group *group;
+
+	/* Container device is responsible for creating the iommu group */
+	if (fsl_mc_is_cont_dev(dev)) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return NULL;
+	} else {
+		get_device(cont_dev);
+		group = iommu_group_get(cont_dev);
+		put_device(cont_dev);
+	}
+
+	return group;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f27cb14..dddaca1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -351,6 +351,14 @@ struct fsl_mc_io {
 #define dev_is_fsl_mc(_dev) (0)
 #endif
 
+/* Macro to check if a device is a container device */
+#define fsl_mc_is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & \
+	FSL_MC_IS_DPRC)
+
+/* Macro to get the container device of a MC device */
+#define fsl_mc_cont_dev(_dev) (fsl_mc_is_cont_dev(_dev) ? \
+	(_dev) : (_dev)->parent)
+
 /*
  * module_fsl_mc_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..00a460b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -389,6 +389,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
 extern struct iommu_group *generic_device_group(struct device *dev);
+/* FSL-MC device grouping function */
+struct iommu_group *fsl_mc_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
1.9.1
