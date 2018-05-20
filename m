Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeETNux (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:50:53 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:12149
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751428AbeETNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 4/7 v5] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Sun, 20 May 2018 19:19:48 +0530
Message-Id: <1526824191-7000-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:lYaS+PX+sZ5bVtAzuVTH1S0NDVU79Zptm68XIgnt01fT6LMxDN8xRbn4GqMIkEr4TBCVr+VTN2GoX1NEm+Iz4zTYW6q6MV0Cm5TA4QzfNgrzG7wYP5Qggs5IRxzMS5lIdBtCqE6vHRbVuM42cHKCg1Mips6MvBSu9g0Ih0bT/Wuq38EOYPzAOXdZtH4b9KFI6bAxduBo5flkfZxonCxIisxIeqZBhxkkeHJRANYy4GXY3C7QDUwLXRXIyUT4ceQa;25:n2/v5JGPDLGZ3zYyUeSa3NDV932IdWGlXCUe3GYNQ0zeEab1QHR/Ye+FHTCsG3N1gRhkNeuM6C4hSkXOMyIQniDkeKFbbVPCGJkSwppQdzMglfPYAKyVeI1gX5zNL6xwfgGymijKEByWJamhfsrcuGLphO5Z4+/J6o4e5CMSgTn1+Cxzm4+V9e3FdJma7ZMNCMRKCnX7T8KD8+Vjjo1SUXCix7Dv9i/Jv8yA4UsenAIthdkXqBzkFGlbwmula1mC/eL9WKgvTmC6yfw7VqKHvxBS55BXaO9RbJTzF0867lKmPouX2qT8WQyGMUnxnuubfsNktV0DdtlV+fu7GDS1rA==;31:cg/WEbccTE3PHFXO/nlPO+J4bNfUrXzgtMRMMa21WcnyxOmTs42mvh7K68rgEZ9iAYDAr/3ySV+TWkVwPo9Rr0STJAtGMM55SyEojF/u2swd3VYd4WZyB57p4o2Ly8ofsXT5f/+wl6Uo3aQRBl2WdnoJy17EgNuemY0R+FVo2huNSDqCz+MJNwhPBVz+TBLixClGTeHJ1/4dLGKWhYevl2FPyrts2EimUFjWc9GvTcc=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:uHyE2NKbPsrRPKrT3BPXIbM2QDNCy0e9COirTuqDU/dK8kGx1MMLdsJxkYRuGdOCgtr/tJOHi8zCMddH5MomfH+nUubkwm5cA0IOqIInnK+fjAeZFdEEHw2ATrjIwWV4MGju2Oi6M8rZEa1Mts1Vm9WTYnZl7BMzAU1SZJVDfK1VBKJ0joKZv1JglGZuENRpgz0+KuoVBVQB8CYMDhkpRXIb4o6dsb3456tuqqNg3EislYfUkOFezNuRwynK1eAgbvrvRkmdUBDJMoc0VNbUrCnx0tQY+tB4Hd12aq4MDpWiL/I7G0ds2Kfi4oToHEZ1c/jkGgeR+cFFHLLbElDVFOeAt3+CQvH4MjEkVg1Hx+zF94S7U3tUrZiL7IG3JUrcMjU0jpulOVBkc6iVl9Zo+3lF8OLN6R6yYZcBFUkpvIjeF8s8L2dHpbwu1U+xWCtEnKdK5RXPhfvtgHxpTzP7/UK8Y0vxF85pBwkH8/eMU/8l8fx/HbzKC6LFml5rwTeP;4:2QwdjYEd7QzgqTJww1NgUfe/pU3ALMHj5ucrf+NWdY094ihLJDWqU5Q3XR7InCU9UzSiMZt8f0PmWnHOosk0wyHidoyS+0dN+GqD4xDgPfS0cApZAe04uqM+Q0BF1y8XR5oJpzQvx5TCRiHfzFa61I9goBf6u7Qmxejsh8CCAwzydKir+hRDVjYI5oxSBnN6DXZoIV5WqM8685OIVtkiTMgPFBfoZKXW0VrS6D/n3wd0UNsUIobAk+TvXDLeOxMJCkYwD2hfc6DiTX1dLO77F7eJo8j/1ZhMIhgHaEDoWRMIP97coIIiJJixLRg/aE/y
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429DB31E546880C9EE602ABE6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:YxIozB+zTkYFzRWw3X3089wcgyZ0peP6i7URXae?=
 =?us-ascii?Q?x0GmxUmpu34nz59kn0aQGLg6mtqznyL2PNQmK/oC9fy/JXjTAdtF+YJfs+BP?=
 =?us-ascii?Q?ZYRKTDbT+OvH69eV8xZW5PYO47TY3EjZNSPLHUVvhBnhunV7PdZlXEq0BIDv?=
 =?us-ascii?Q?9KYWVdksznLX4MGQSb/pvnSIbEkIFbDV2U0IjGKMzIgG4jezIyFXOyi4VD+H?=
 =?us-ascii?Q?5r8YFqgV81icPeopQGYS9y7RU6wG2Xv/Mev0SvmQpOYnqg8yiJRVY9a1vkNL?=
 =?us-ascii?Q?Xux0c/2NjFPFv58MJ3a0+AvfBNlG8Sy1qM3cy5nreyJ/Xb41NovRs1oYXcCX?=
 =?us-ascii?Q?b6v9FVZjtHBiTqgHOg+14nkqwxRMY86dy6K7Pxk6TqScSkOjNJWiPs9BMywC?=
 =?us-ascii?Q?78aVbXJHJi6uqBlPjQGXLf8vMdr3NKCQWdS8j7pNMu+movQLASiSoolHehk+?=
 =?us-ascii?Q?Ovk+uUY+nsmL5RdjAG6wsvyIlZWpQv2g8RC/Z51JHxeXjUu+yreDcP9nM8sA?=
 =?us-ascii?Q?Q0PO0WyN4YrGhhW0QlbMzMBX1oGegrFYJ9pWsoFROzidlaTYTjuMpWIAb78q?=
 =?us-ascii?Q?ZtFTkn4inH6egjaMQzs8TJ0JEC4PUWcPn5VdsaHDh/TQ+ePc+JZJ7Yb98z4Y?=
 =?us-ascii?Q?CNMIaSOYUZ/Y77p7fzFdAu61/BnT8fJgo0uYF1yM1pXnS2bWT7zdVznc1tsv?=
 =?us-ascii?Q?nUg/7iCJQeET8cLJYPfddGolDCUPJrmhwVcP5z/DXuepeeqWGcAtuyue2gfx?=
 =?us-ascii?Q?aZewlUqax56vM2+h2MPK2+ARjLzaQHy08CeMkSiB7usKISs7KJvG8JbEYZK1?=
 =?us-ascii?Q?L7HJ5F8kASB81ZzmbKW/AEjC+Dste562vRpxO5NDowqJSarsb/45PuO3XN9z?=
 =?us-ascii?Q?FJrbcn1AaYptYbuMzHajs/0k6sie7+3EgocZUDcYdFY5CNa9Sw6MSbZXEG5C?=
 =?us-ascii?Q?0wKEV74CUlMdIHDufOP3rW/W70214jl2EbZfEeryqIcdPbBBTgahfo6gIwSx?=
 =?us-ascii?Q?LAp2C1RsfLsaYOPJvI7uoAH4OgmXFuXuo/5r8MICOWIbwsg59MekKrFSfRSm?=
 =?us-ascii?Q?i96T9ssFprKYJREk4UpIT5qESypZFo5kVXW4llk6z/8DGlepgFAi3UbaddS7?=
 =?us-ascii?Q?E3rPI+4bIzIQql+JmTBwNMdY6WIGQtXlbKRwmXsD+xFYD8F2k2QVrZpABPt/?=
 =?us-ascii?Q?uoUqZ+7Sw5FpirUgdQWvr9aStdE5lumo9BLsk9dbdbrKTli34a2XxNHtsIyO?=
 =?us-ascii?Q?xkR9Uzqq2N418OeK435bTWYHLm9MKT+YvCcpv6avf0VJbVtDO07a88jQb4t8?=
 =?us-ascii?Q?Gg+yzyXhQ/xva5rWM/Px0EgY=3D?=
X-Microsoft-Antispam-Message-Info: r8pNtpE0LC2WjogLQnUYGrNbYzeAfaSieZkGE8CQd6rGTMTu3VzDWjbGsXBRI4fcrhr/zJiEM1HFIiKbh7NQS5sEar3KYEgcq53ZDsxQnnUAlAevN0tXpO3RR+I2JWft0V/5oAltBqVIYMJfJ8ovP5CUi7kDF0HJcrIypSYGO4Ts41XEdlhfOcjZtGsb4vud
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:uaBwluNuKbMatYPMOD0BdovjFcF3L9/yc5zxslvQtmwXJXdodfKgD1zKTuqc+K3q8zE9CkwUsI3edq53E6c0b1F5JNZsx85bnCtzH+NFw6KYD+C7lJMMJHkJ1920DWoba7ifEq7Y3FxoZBcYWKk1cvDIvayGneZvoCF095JGiloDpbsNzvT8IPEEZiKzZPLgm6oBVZO9INQIo5s2Ka/u6r7pTpgmhBEocg17aCQNkICNXrmHHIBjoHGgovFpvF55uLDjAq1HEVQOPHZsGNHvpPW+FTjiigRV9gexN4MZ8/OoV5UceyvwvldJaH+sNDd3BIbf+iJ2mRY08coWBGxejf8adD9hPtVn19GumcNY6WCyROKvo1JpEsGzqUrT4J5V8gowN51291l8+K9XjfB5B7e9BB+NDXqB9aDbabLeQIdEinDQoBtvX62afm0HufvgSIhBk0zVbLkAlALGgMFxeg==;5:s/Xv62MRWG2NhyH+joKGdpta3RJIonb6R1/pwhdxLxs3eixnA+uRSMaGPVVMxjjVRmEydiJYnyFJ2yimSePrOoLjXy/3o3GHMwVrQA9Ig+1BJ+M0oyqTCAeoYWgyEx56r/rYotVZMRuYG6MJpuWn2RbjDUWHwwf4g2hyzei7bzw=;24:HwRAwMfXhSsZjK50A7caBPrFiD2xAYx6xJLeLeBnyR2MPh1KAluY4eFkyKMlyu9eFtVyFyldiUS0yS4yGfxh8nr+R1uOSpVvNEwW/EhTLi8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:8uoxSNnFhDLSl9Kd/6syNv+xf1qN54nsqmZ4LJU4q0xxf9Vf+afp1H+w0pJ76EZhKffH07i3XSQSAWqT6MHqW/uByPsM0q7Ro0FABU7lJ17v+2XtZ8pb6xh9m9Uw0lCAIiUYpDHJFpgJ9yyZ59WBakMHA+IZiAIMGmAHVjd1rprGkyQIWuh9VNsfYa8uL3ottrT1aHR683MDKMuVQzt8iU5MvYjWQ84SkT8GUyTyluvzdf/UGI7a8wEkjlOQrsgM
X-MS-Office365-Filtering-Correlation-Id: df4ab331-5b47-45c1-0e85-08d5be58ad13
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:37.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4ab331-5b47-45c1-0e85-08d5be58ad13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d2aa2320..6d4ce35 100644
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
index 19938ee..2981200 100644
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
