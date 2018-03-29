Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeC2WzI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:55:08 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:63150
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752308AbeC2WzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:55:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, jacob.jun.pan@linux.intel.com,
        linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 17:54:54 -0500
Message-ID: <152236409481.3266.6464716993249076762.stgit@taos>
In-Reply-To: <152236384612.3266.1451709369164076985.stgit@taos>
References: <152236384612.3266.1451709369164076985.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:300:ef::19) To BLUPR12MB0691.namprd12.prod.outlook.com
 (2a01:111:e400:5951::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e970eb1-99e6-4b53-ef88-08d595c81a1f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0691;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;3:rHmCEWHx1bF7Xlo+XO9E24A745VLZokQSFaub/o/gyEG+QRye9US9Yz58t314c9yiP4hH2RLNd1WNkG68p8sJ46qY1ZnUroGsMm2dSoOMAw4ZWIwmnVgmgLB5a+vz+f2LwYdK3SszOo7ZSvEXYmic4dNCB7aOz9uNIrrQgfBw+1JWe/65tud/ESndYvdlInkHIC3G2Cij3b/z9fS15vxJFDzf8Sbwk1TxFZodqqM8lEYVRJWv7KrE7llWWbFVHeD;25:nvfYnx6nSeHkgRefNiRP/Wt06nmaTLV6kAecOHatRYZ7fvBYdJssx7wLZb8j9jlRqpvyipDBsdu9aLuuV172FKeYdCUQGUSdw2La9qmWHjVaX6ta6X8R+4LWyvonfuDhu1+8QDsac2kQEYJbZiWqcHs1Ao44LbCx9zChJZIjllHjtI+fzrclCRi81Y4UfLCrCj/N45YS44VWXG9lHTpvpj+X+7XXUeRcQX+kDWE+EOOhwn7THD2Msb48ZZ6/lhAzuOhY6oigSaDSkTNfENatHZiTT5Fm6ivMxWkDxKArFbmep7m+OAOsrjpRokSEy6JP9GtFbD5BmRZui9xe58Gy0PChs7/4P3Ts2F8ic8jvYNM=;31:KijOxq9Yp0yYzHc/jREWboxV+VXn6ollPtXeTTdzmxJGn0PSbM7F0CJQYWlDZXgXLV/Fz9Rgh/cG48pWVco12YTb+EDgjwlGiKRGPkPZ/kKoDgekjx1zglSj+VDZUNzDfsK7aF94aaCfRI+uzCUpPtRunftRHUvtsjy9XgBZ3Ge/5IZBAzrrDT6NUIVy36rarpMzdUGaqlBDYtHwmALZKbU8+LYaaGVy34IjlSXpKRU=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0691:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;20:sW2g7b3LPp6wIJjrh2Xp0OLc0QGhFf7wrj6yKClOL6MBYGvvkkKhKFsD3t7g3QUP5fxp9ABsRyj99ppIYjh3dYonqfG9QggCLAmkOgJu6Z+ZOeQXDl71+qJ9X2X3UTU9BJhIYq5u5M0aeKLlrpqR4Jb5Iocfz0MGIg8uw17131vfm2w1vdgJF8jnf4oifl8JFsDubnPBU+CQRtdCodIL76cxrAvur01XDUtUwtsehKIhgK0vo+/3odp1TVst05mI4misnFddY281KcwLqvLstzUx1+jLstkWn3kIbCqm+LmxZn+uArC0RGs7X2GeriHx+AgSGZbkvtCQ4Es5rmrD/R1FaFzvmA7H+CXl5kR2TlwHj/ILItfXMVZuPsF6r3KJrMQlDc/GgrrVP629U6MMa6EmICsgcO//YKUIZkdEDML5EAEy8Fwb9dnwSgMUfN6VoZRyv6tpoiEV4KbGkCGYFue1T9ppphhioSjHSkrBEH59fYfQHv6KAXAPSiUKa7Dr;4:Wp5lER/E3jMFsqGVj6HPFFuo+YQZnwffTGruiW6PrkL4RPjBDDTyt8FRYkRPHKHrAFSdozCZYiRkBFK+v/jAc+Q9uAFKx78uvoKr7x0CZq0B4H3XORWdxNDAybGC4rKLcqlF/nABaPC77j/26sUMK2u/u/WYyecp7o96ol2fAjMKwHOoJ8nL2doDB8Zcw3jYXeTNSEXsCGxccI20c5UXoraZnmfGOEU1swEDwXt36jRcxoHikwYv4DBPimKNSzoQrq2pqgDry7/LTDKd1sAt0WB0zlY7u2Eujqfi/GTVSHF/60YtoTuVH5qJSY73hoFo
X-Microsoft-Antispam-PRVS: <BLUPR12MB0691D210F461C6CAD85ED338FDA20@BLUPR12MB0691.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR12MB0691;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0691;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(199004)(189003)(316002)(68736007)(478600001)(59450400001)(2351001)(2906002)(486005)(476003)(72206003)(16526019)(2486003)(103116003)(23676004)(33896004)(33716001)(956004)(81166006)(5660300001)(81156014)(11346002)(16576012)(446003)(8676002)(76176011)(486005)(58126008)(66066001)(305945005)(106356001)(2361001)(47776003)(52116002)(105586002)(230700001)(86362001)(9686003)(6916009)(386003)(97736004)(3846002)(50466002)(6486002)(8936002)(6116002)(4326008)(6666003)(7736002)(25786009)(53936002)(575784001)(186003)(77096007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0691;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkxOzIzOnJaenpxaFNWdFdUb0tBRGxzQ0NWRVltbE5I?=
 =?utf-8?B?NGd5N3hQR2FTZXdGL0hUcFlZUGI4L05SbVdKT3k4OVpMVXhaZDB6KzZ6cWN6?=
 =?utf-8?B?S3VxUlZCRXhidXU5QjdvWG42ckREMUhDQWdhOUIwRzNtZk5kM3BsS21yZXVz?=
 =?utf-8?B?a2lWYkhWaHlxdEJObGhrZmloMVZIaElSSVg1NWxmMHc5QTQyNUQ2Y2xBbk52?=
 =?utf-8?B?OHdBM2pOUVFPZHRHVDZqRVFkL2VlbzhOVFJRYVlZaGh3VGZUbUtaMlNIWUo2?=
 =?utf-8?B?dkdwOHRjSjJZb2ZDY0s5dEdaWnc2bFNhRStZZ3grQ094dmtqVGlZSTkxc0dE?=
 =?utf-8?B?NEl5eSs4N3NLN3N2bEs2Z3pya2RIZG9QU1F6akhpSE9JQjlMbjN1ZmNiS0V0?=
 =?utf-8?B?SS9vSFBlYXU5a3VqOExIVUhrNVRrWksvNGFIa1RxclFDY2trVjZWTjNpYnFa?=
 =?utf-8?B?dUJSZmdOVzZNRmFMY2ZIOVlFOTg2RXA4TlAxRFJwWkpCeTlVd2FMV0liV1do?=
 =?utf-8?B?MjBlOFVVclRWVmhobi9mdEx6SmQ5WGZNbGVyWE5ZQktnbWlKTDlFOEZUVW5U?=
 =?utf-8?B?ZFdnak1KRGFsMDBjTkM5NWRZQ1cvaEFoTGZMVHg1bERCT0gzaEtJWTh0Z0RO?=
 =?utf-8?B?d1Bpb3QxRDRPWjhFSTgrS2ZSMm1yOVlvSVUzcEdGOThkQ2RSWEJrM0VSYVVD?=
 =?utf-8?B?cFB4ZjRKd2RzVnVKMEpWWDJUWjhRdmhhR2NRV09UN1p6ZlE5Y0dFL3I2MC9m?=
 =?utf-8?B?bWlnYlRNRkZIWml5L3hzcGpoV05McGNUU0JRSUtSRUl4Qzh3ditGNUlDaFZn?=
 =?utf-8?B?RFh1SmJvTnpKdHdsWURPbGdITnhEWVF5Y1Jtd0NwNk81VDZkcDBiM0k4cDhw?=
 =?utf-8?B?dVZlYTl4b3NWQ3EycmtDcGMzSFl4SWFId2hyZHhrRWVtcDI0SmtubHY4R09L?=
 =?utf-8?B?ODg3WXlqU3dEYmV3OHZQREwxNVQ5Zmg3SlpCV1NtNjRjWlRrZmNxWS83Z1gx?=
 =?utf-8?B?Ty9TeTA3aDdwWk1rOEFqcmhpSFpQZEJXTVBTQzY1b3dzTUdkeDE0dDZDZGdK?=
 =?utf-8?B?T1VDbVpKM2tINGlkeW9qMGhDbnJhcEdNVm9ESEtVdTU1TGJ6LzY5a09Ia2hn?=
 =?utf-8?B?dFZNOWQxa2F0L05GRkp5MlJnT2xhVXBwOEJBVUlrV3V4em4wdVJMa2tUSFky?=
 =?utf-8?B?czNjTHlOYkozM0NyNTkvOXVzZFJKU1NaNVNxcFlsNnNXYjJ5RGo2cmpMaDRq?=
 =?utf-8?B?ckxTOGZ3SVIwS2RqaFhpeG9wbXg0ZGVYZUpWdGQ5c3FITG82bkxFV2ZUYTlW?=
 =?utf-8?B?YVBadlduQ1NFamtRUHJYdURWekdGWC9vWU5IcEQxZWxSNFNvR1FiMll1eTNp?=
 =?utf-8?B?QUdxL0VjOHZXREJCYVh3MCtwaHVlaUQxTkpOMWdWS3l0SG10cjVjWnBhVGRF?=
 =?utf-8?B?NFoxa28zTTZNV0xqbTFwblZvb2FvczZhei9zUzlNRURrRHh0ZWpzRW1XdWNQ?=
 =?utf-8?B?MWdGWTFScFBSWHN3M2NLdGNJYllRSjNYd3FoNy92SDlWVExPZjEydkVyZEZY?=
 =?utf-8?B?RnZlTlRnNHdKYlIvSUlya3Q1K0tlNnkxbWlpRWpLd28yRTd6TzE0Ny9BSVhN?=
 =?utf-8?B?dzVJaXVOMHhKZmRoYWFYMlF6THV1Vnp2elNlSWxmNkI4WWFWTjBCTDBJQUx1?=
 =?utf-8?B?NGc4a2lGNTdPVjF3T3J1Ky9XTTVzWWhQSkIzeWl6Zld5QVdaeGNDRzR6QzhZ?=
 =?utf-8?B?dEVTYXpUUFVvS051ZTBRNVIvd2xIdHljcno2NENnRWRJOHd6ajVUZk5pWEVD?=
 =?utf-8?B?aXV1VVk1WlZkQjN1dEpFVXQrazdOMmU0RElnUHNNM0dPZm5Cc0piRjFMWGk1?=
 =?utf-8?Q?sysp6f8wXUc=3D?=
X-Microsoft-Antispam-Message-Info: 3hD2GdO4PI/2nsRcYVNEcy53or8PuDGTtQfxBa0dUwSihJM6sGP7ZSs2dteX26J//EIIRA22dMUjIYLYNRl+KHsRrCrbTGoUMt7F878/y6pTQu7cNqywMWLXNBqV8scu/DrjAZKdMPRx0AuF4v043e1vRmTVl62T/ilAoxWpFBkSpGFtMTs4LNGRVimOKERy
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;6:2NEyGtWCiqpcildcnxE2h4N0FG50qa+JLfG6DQA4XMdYMPbejSeGJXGu6e6cFx7T2bmKE7rgSgDz32vKdn3ptMmLv3LfJSMZ1vSqmYeqECI+mJcNsFPCT27JzWU6kjW3OWr9lD2GGtedas26tHU6gYAfYCcaN795uTksXr7bUyOW8NQ3hv77POmuB99Q3gLn5WdGkIwy6evAOSS+9fPbvHhQ/8WMCPIZz+I2oFsnrHtIg+/LUtE9hVGxqD6eOROjqSsRAxrRuffhqnrsCV2FJ6D2Y/UBzNCqJ7Qa7RH5Di0oB/EU3tFi0UTGlQBXbikT6IbMGcLXyUES99ue1eC7OvZ4/WwnX54QsvEMzISACb1y7Ilw7DKD3fhFoBi6IkYGVqz8Z3SV8ecODG1FYcVwl99rllXVhPXbhFEbjD7ex3RBleXRMCj/wAkViB/GE1WvtGwZuA1Ya6aD5BO846+N6w==;5:jacP8PfvPyiSKPNjx+kQ1ShaJdTmA1ux0tPQTIGSj9UiTDL+YLmWhrBPxlMeBcsmK2HVKissedgIKbsNaHruRN7R4NKvr0Q6i7QMoAH/tvRFDJT8hVVsaC4skEUFlA9wrbr4obs37Juu+ewoyOeYp8WDQUG6W6rbcc0A1z5Lv9w=;24:QX9UpBbUZCc/fA4TPWfeejIBtx0NYTGW4yq6tnVU6nuRaPPk4QJwjtFBJGspvJuKUixHwSpe6ZBZ/5Hb0/Hw881RjqAurePimOFOVFlOyiE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;7:O+0gsR6l7xBPc5APUfz5C/LDPfWymQARH9vX/aB7BZxHArRPaTsm/RnoklXU3+U6eGjHnDpJBAWgqaf87IbhgmwHdxOpF2uVxiKSuBKZQbcSJiFR9QyehNfc7W53TRCO0Z6JljglhEMNNa0s0vOOzzdeWsZTXr+wcj+ko9oaCsuNA3UvxWtlngljA/LR1l38vDMj7xb46Y8O1j0Cjqn69YoeYt70vOBjBfLJQy7T/a23n/QdFW8H5c51eXET1qw0;20:nntO/j0mXWlkXj4ygDCCFNd9gZKYWgQ/OostTVgE5MqaRndGBtEOhBNM6sMT1cp1jMSFbhkO+8Bo2CJdGinP+Msv3jLOTjPp+ChxeQQykImrpDm6oREt3w4JipidZTdwFXTyF34OWG99tJmFCc/VqecJk9Er0yNdwV8dJXYFAVe41rfoaVAfC88tWfjfRP9/ekUKCcfoiGzQ5ZaeGJZklZgXAQ+2rQA23DzVMD+J77pXY4SRLjfoZq50aMAVnHnZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 22:54:59.6153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e970eb1-99e6-4b53-ef88-08d595c81a1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0691
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig             |    6 ++---
 drivers/iommu/Makefile            |    2 +-
 drivers/iommu/amd_iommu_debugfs.c |   47 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    9 ++++---
 drivers/iommu/amd_iommu_proto.h   |    6 +++++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 include/linux/iommu.h             |    8 +++---
 7 files changed, 69 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d40248446214..8d50151d5bf4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -65,9 +65,9 @@ config IOMMU_DEBUG
 	depends on DEBUG_FS
 	default n
 	help
-	  Base enablement for access to any IOMMU device. Allows individual
-	  drivers to populate debugfs for access to IOMMU registers and
-	  data structures.
+	  Enable exposure of IOMMU device internals. Allow devices to
+	  populate debugfs for access to IOMMU registers and data
+	  structures.
 
 config IOMMU_IOVA
 	tristate
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5e5c3339681d..0ca250f626d9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
-obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o
+obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..3547ad3339c1
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#ifdef	CONFIG_IOMMU_DEBUG
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+static struct dentry *iommu_debugfs_dir;
+static DEFINE_RWLOCK(iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_top;
+	unsigned long flags;
+
+	if (!debugfs_initialized())
+		return;
+
+	write_lock_irqsave(&iommu_debugfs_lock, flags);
+	if (!iommu_debugfs_dir && (d_top = iommu_debugfs_setup()))
+		iommu_debugfs_dir = debugfs_create_dir("amd", d_top);
+	write_unlock_irqrestore(&iommu_debugfs_lock, flags);
+	if (iommu_debugfs_dir) {
+		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+		iommu->debugfs_instance = debugfs_create_dir(name,
+							     iommu_debugfs_dir);
+		if (!iommu->debugfs_instance)
+			debugfs_remove_recursive(iommu_debugfs_dir);
+	}
+
+	return;
+}
+
+#endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 99d48c42a12f..43856c7f4ea1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -89,6 +89,7 @@
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
 #define LOOP_TIMEOUT	100000
+
 /*
  * ACPI table definitions
  *
@@ -2720,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2729,14 +2731,15 @@ static int __init amd_iommu_init(void)
 			disable_iommus();
 			free_iommu_resources();
 		} else {
-			struct amd_iommu *iommu;
-
 			uninit_device_table_dma();
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
 	}
 
+	for_each_iommu(iommu)
+		amd_iommu_debugfs_setup(iommu);
+
 	return ret;
 }
 
@@ -2783,8 +2786,6 @@ int __init amd_iommu_detect(void)
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
 
-dump_stack();
-
 	return 1;
 }
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286a0ab9..e19cebc5c740 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef	CONFIG_IOMMU_DEBUG
+extern void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f6b24c7d8b70..6dca9fe38518 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -591,6 +591,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs_instance;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 98527f9b473b..dbfff811aa25 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -412,6 +412,10 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+#ifdef	CONFIG_IOMMU_DEBUG
+extern struct dentry *iommu_debugfs_setup(void);
+#endif
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -696,10 +700,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
-#ifdef	CONFIG_IOMMU_DEBUG
-extern struct dentry *iommu_debugfs_setup(void);
-#endif
-
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
