Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeEKOe2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:34:28 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:6061
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753191AbeEKOeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:34:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v6 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 11 May 2018 09:34:20 -0500
Message-ID: <152604926050.106201.12749369479920979102.stgit@sosxen2.amd.com>
In-Reply-To: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
References: <152604905217.106201.15533883255216330970.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0054.namprd05.prod.outlook.com
 (2603:10b6:803:41::31) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:o3WnzdwtmgH1tfMPROrwwlOsoPCqpxp2KFVRtOPQhHhtbgemCU2mz4K1Wn98SnlwYDm/CimGcdoWL1W69QpJLtJ7d0GVGTffuzFvv3zlvSBpEowSlv2//PxjJu3T27/ncj+wq19Sfz7fbFnBKfCzCkXwFKL4V2LCFsUQBJfqzRAh5XvfhTLKIbGKnOltIWkKEc7pOhzLW9bjaUG3dald6DSrlsvvGeQThnr5bD8UGXxUxVM1bbc1defmfoKdEZ6d;25:otkbLykF/+Cr4N7WO4wOQqbEsqolnQKW49XjiZ+lGATDuc+6nEP+3kmE9Axewpqk5sDvX9PfZWaTVAAFNDqvpdIcku8z34xri2d+YPjPaJRCDDV4r8joTXi7Ole/NIe/+M6b2lul84v0oLYVgnffopuXvuO520ArjG5I3R2cVAhrstRyP7at6OK7lSIreUe+43j3DuSQOfgI0OMt3owu1xjC7lWy+Mm0emZ7D3Cm2UvqEl+aDIdDzL2sxailAB7gEJ+6bAlOtjM1q1smLOMJFLQSk3Upk2EbCW94/4CRPaf6p9dssLtHCnTkFcRkYU2DbYP62h1DdL2TdD4cHiNHsQ==;31:OHp1YRDDqIJWYfz/5wjFDa97MnrMHn/VS7upm38RJ2wrceP8U8K0+Mz0Tg5L5QBp92ZnlfLFYme/aAji1KnBGAEdYJtcmYT3tyNag4D1sjqMRSB7n1CUrHlVOFKF53L3VJIZCSZ0KWvEc288t0ZQrPUJtbhmwTzxLvQdPXwXHbILz2SuRkZeMFtR1H+wDOdgVd/fY87/TEwXWMpK8fqgafsCcIlR6RjEZAgspJf+GdA=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:xk6XQoS9BZgwQ0ozbYIaMXE/mtqPFBkhvQ21ZClREzJJgwCqq4Xcqc5PVqXsEPxGfm3dvySRU6kOYtIZj3GlCrldpZZEU8yuRhGmW7jbMz8IrNyjbH5uT9eCJeUUEKTl3Ba92ziUvklPSR5tu1KSgPCnvAuDJ6L4Zh107FZD6BQM1adNuVBn9aK6b+HzhgbmkwZxQLmYUhpSK++2Vh0TSW57lEg950AfSHnrc3kPQ4RO/5jntg+u6AKxuzd26oOHrfIhHD6hqOWLVZwXAFUPDBe4NDGbnsYTbtklbLPiaR00uDa7lvmDzWogAo+ukDsSJXbTGF8NnJ54zvS+6dkVoOSmnx4QXi5t63isNERh0wCDiOYB1pUdQCk1Y8M8Zy+WeN8gre7/hWHakKQUPQzwPhrhUk+los5jpjY13im3ktmYMZLkgkVv9umHUfdF6jHH2T/ScZszLnQ69aypDW/tC12ShAYmTVpDp4UvsF8IETFGxrjBDR+O9kV+JEqLjz+2;4:OYSjFal+tJa7RqqnotdNDp/6ouSoDWwWmrHkHs3gC2qM3wth5Go4OECW+Cx4PL9EoFUa6E1FctrDtaMfC7Gu2c5IxYFoJ2AtHFS1bl5UhAbi7gM6s2LbtmT/u0T7LdfBFy9ttvXwG2CtfZI40radH37A7DaawncqVfSRgSUQNCgWgtjkuZInWe/+t9i+XbKecJTiRxCDsGo9JqsWMzZKfYU9INxFO+PF2HOBDojRAV4ptLMWugV2n+gnZ9z/TLsDFHcQUvi1jEK6v5yB6ZG4HpugIsF8ucOHB6IH3szPn0Yy5w6UqsRR9A+H5dMTo8YZ
X-Microsoft-Antispam-PRVS: <DM5PR12MB1449B69A0A528A24F97E581AFD9F0@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 06691A4183
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(199004)(189003)(81156014)(2906002)(8676002)(956004)(11346002)(446003)(16526019)(5660300001)(476003)(7696005)(186003)(66066001)(47776003)(53936002)(7736002)(305945005)(50466002)(316002)(386003)(8936002)(55016002)(81166006)(575784001)(486006)(76176011)(58126008)(59450400001)(23676004)(86362001)(26005)(52116002)(478600001)(4326008)(2361001)(25786009)(3846002)(6116002)(2351001)(103116003)(68736007)(106356001)(105586002)(6916009)(230700001)(97736004)(53416004)(2486003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOjc5V3hHTDY2SkNsdkp6eVFmSkJXbm5tOEpK?=
 =?utf-8?B?S3NpczlvM25PQy9Ud3RkWW96OWYzNTNlQm1yMnBMbWRsejlTc1hES2ZTcEpz?=
 =?utf-8?B?YnZQbDZRaklZUXJKUlEyQlp1WGhzUmhqbUsrUnhNMkk5SE5MdURKdTg0UXBO?=
 =?utf-8?B?bWQ3a0sxNS9hN3BwTHlhaHhVWnJXWGUwMmY2Slo5aXo2a1NOdHRzSHRTelFI?=
 =?utf-8?B?MW92RGpqK2Vnblc2RzhVNlFJcGNJcThrU3gzOTJ6RTRLMWE1ZUQwMmpQMkFz?=
 =?utf-8?B?VnM5dk9iN1BFYVhXd2dXelpBcExiOHRhR2h2cXR2b1dLOTc5bWhOVGVXQnAx?=
 =?utf-8?B?K1VJbkVRWmtqa3ZFcURuZEwwWVlrbGpUNzhCVmttVzZDaXJ6OHgxMmdSczhj?=
 =?utf-8?B?MndoR0lOTnplY0ZyRndHdFZkUlBkNndaWHRFY0FHUUxTalF3Zmx2bUFNK2lk?=
 =?utf-8?B?MnU3ZWQvMHRvS3doK1pabzdVSWpHQ3dFckJyVTVkVWRhbHRTLzJXUWtrZ21h?=
 =?utf-8?B?MXpMN21sZElaR2dsdnNWSGMxTFQ1WDdveUlyejViWk80aXU5em96enM1Ukhr?=
 =?utf-8?B?QlkxYThlay9YY20waDNqaGJwdWNFL2hIVmdrSEdyZHU4Q3V1dmNXZFNOWFAw?=
 =?utf-8?B?MmsrQVBiS0RGTEtnMHU3aGwyOGF3ZlBDQ0NoS0ZKcG5wMi9RM2tNNWFvL0JT?=
 =?utf-8?B?TThUVTRoOUJFeDNlYzF3Y2lWTGtjZzNmU3ZIaHcySlNpOUlyS045cmN3dU13?=
 =?utf-8?B?NVhpdFp1NDZmT0doL2ptQWtQdS92QnZ2TkNlcTIyTkI2dUMwV09tTU93M29Z?=
 =?utf-8?B?bnNzNHNWa3lvaHpDVXB5TGdoWldNcXY3ejlTcnowbnd3cGJmbGMrUnFOYlJQ?=
 =?utf-8?B?a1NYV3ZmcjNTTUdQYTJBWi9RSWxUZTNhRTlBZjdsWUR1MnRUeCtTT3BjL1ht?=
 =?utf-8?B?YjNmSkpDODZjZEtsUzFoelRQNm9TNjJxN3kvTXlXbm1QeGZMOStrOEYrSlVT?=
 =?utf-8?B?bU9YNktpV1ZWeGVJbjUrWnFNeW9VQktESjZ0bmtic3BaUHJXRVBqQW9yWlN6?=
 =?utf-8?B?Zmk2Vzl1VTFlc1lQR0hPM1l5cFBYN3lXMVdmL3ovanlxRjBEb0txTWc2U0Na?=
 =?utf-8?B?Smh3bXY2c2hqNG1UdVlVYU9nRUQ0ZEpVdjdTcE1GeXBySUNZQU5pdVVnQ01U?=
 =?utf-8?B?bExPemdkQ01wUEZreDJrdHljTzl1R3pyUmM0Y09CWlY0TGhJRzF2Sy9RU0Rm?=
 =?utf-8?B?VVZtWXZ0VDU0WGxsTGhadnhzS1RVcCtKR3pCMkNadUZ0bVBrdWFvclpqaFNq?=
 =?utf-8?B?bVhWNnhHY2lzTmQ4MnFMNkxrOTRmZDk4R3JQbjI5Y2Fxa1QxUzVsM3c0YnRR?=
 =?utf-8?B?R05BdGl2ZHhqaVd0RHFsU2VraFRlVEFvRTAzdk5EUEg3eVZjcGtLMmtZckZW?=
 =?utf-8?B?UGN0UXlvUDBWTTdKNjl6V0x0cW4zbEVVb3lCSDJrRHNqYjZVeHF5ZGxLaWNL?=
 =?utf-8?B?UlIrWWtzZ2d3Rm80dmtTYlg1ZjVpcmlkTWdvcmx0MWE3ZzQ4cElBOG9XalRr?=
 =?utf-8?B?bzJReEdWS2c0OU4zNDNjTEdQN24yOE5raUFVVTJtajNaSkxHN3FjOE5iUGYw?=
 =?utf-8?B?V01INkpqZ3JqTEJJQmkydHY4aGdpSFUyanQvMU1PcmJlbHdLNzM2T1FkNzln?=
 =?utf-8?Q?D7q2EdTNb99+ezHizo=3D?=
X-Microsoft-Antispam-Message-Info: 477KNhCf0gJo8iqmXKVwZ8s8FMnNPqAc9qb/ILVdfEqUvhoJltuFbxMojzdPj64iSrm7M4AFBfkZKIaPCH8iLAcxjiN7cq4OXSJ0dn1xzNq1Gpi7VpdT9WZgM7mnRZtf9C4DTBxJMln6Xh8BUEgloUJD88P2xsJ2qTfVKlBJ4xB2papUz9B0beMwfQtCsOYP
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:ZjPA+Yuz7mwiSTAPw98UUGAGWsufQDDQT0yCbAHjhnWLGRfECduO/KdkZ4rRmmBdomscxUD/KBvTRRgjQ7vXlCMSPAMLJ+oOxuMJgI1xs6enInW+ur3wHLnc+oqA3tcjOIv40g0hwNfR99Sp4NROIAS00zfm8UM8dgYNMNrQQXco849eK+4yTClckTW/NJljPPzRgzBhyHsM46g459mPpkikod5ZSf7dPL8jg5KdIb57Y5ibiK1taWe+skppyTfFSYT5B70Wskq9wrTHfno8GadCNPCXblR/m4ILwUE+ms9azQ7wLsKU+6KwsHwE7swIGvNMJQ/OLj9QLisMCjcvoLnlPhfnT4yaXBeu3MfpzH4ART222mVyRQMOWHSKpOYLJZdJFcoInH6cSKshhgna1IRjT7ugzVyte42+r31ToPo2edP52Efs6hrfBfzEPdFhctcxeDlDFNVU+b/U6MLhRw==;5:Ps6pc+jpWmWtvZ/76TzsPHyWkXNQdBN29siGa+oWglzA0paIS+HLoPwryki/aJ+ZHtBQc2Qb/k/jJFt2LmCEDL+T/IvA/og5aUuM4KCE5x0f4dDszWa6le9wsJz82BBtnDrkDoSxpGF84+9R4/CO+6UbhE/3Tf7hFKXX55CpG8E=;24:wm1g9oKH1+VLsV4I7B1gsgUcDQezVDnv0bVpiW+s5g5hfuZK/osBALRPGqm6jDJvgqHCW54QTQEWleXJmuDFF457hMDW+/jBGScC5p2254o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:T9VA5isoRTIWwAQjuxA/3BEm09H8iEngNjNPrcINxvS2G0fLjQZglMsWav9QyF2H0PlTZjJppmJWVutsBoWdh3Yr4RmzEYsod+HK6OAIdwl9UeSBaBss9g3IvdkonNJzsLJ5foW5Jq1f67Ra/Cxaw4StjVeaLx7bQ5fVN/XuuWfPhD29KJEIQRkv10t8xu0AFxZFYDWErvA54QDYjKvUXDdCnPxyw83fykO3BWpOpuGvl+WtyLRYfDu9BkhN7Yn+;20:nNIvilElMhcpqOWFQnDTJBb/J1FmjWfDv4FeEABN9E9ikoVyCqX59DFF09Sf/Dj9PF8waVSRodF7Sm+u/2n4EV/mkutUOC2KbchROnisk5f4kW6mEBaI02NQJYCEpZDfz9UGrtmPydfsxNSJFjTPkGE54rTLkPpH2MAaYquRGRm9ms85nFI5DLo6dlQTmd48eE/3kCNxjcDZ2jdXKJl2PUi0dAKCsDHCjmi+fIAXQtU7WmyWoc0UP6qWRZjkDkd4
X-MS-Office365-Filtering-Correlation-Id: 4ab9433e-b432-4be9-5c72-08d5b74c4a6f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 14:34:23.3721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab9433e-b432-4be9-5c72-08d5b74c4a6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Makefile            |    5 +++++
 drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++++--
 drivers/iommu/amd_iommu_proto.h   |    6 ++++++
 drivers/iommu/amd_iommu_types.h   |    3 +++
 5 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 74cfbc392862..dd980f7dd8b6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
+
+# This ensures that only the required files are compiled
+ifeq ($(CONFIG_IOMMU_DEBUGFS), y)
+obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
+endif
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..6dff98552969
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD IOMMU driver
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/pci.h>
+#include "amd_iommu_proto.h"
+#include "amd_iommu_types.h"
+
+static struct dentry *amd_iommu_debugfs;
+static DEFINE_MUTEX(amd_iommu_debugfs_lock);
+
+#define	MAX_NAME_LEN	20
+
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+{
+	char name[MAX_NAME_LEN + 1];
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs)
+		amd_iommu_debugfs = iommu_debugfs_new_driver_dir("amd");
+	mutex_unlock(&amd_iommu_debugfs_lock);
+
+	if (amd_iommu_debugfs) {
+		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+		iommu->debugfs = debugfs_create_dir(name,
+						    amd_iommu_debugfs);
+		if (!iommu->debugfs) {
+			debugfs_remove_recursive(amd_iommu_debugfs);
+			amd_iommu_debugfs = NULL;
+		}
+	}
+}
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575d1677..031e6dbb8345 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2721,6 +2721,7 @@ int __init amd_iommu_enable_faulting(void)
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -2730,14 +2731,15 @@ static int __init amd_iommu_init(void)
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
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286a0ab9..39053f11dda3 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+#else
+static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+#endif
+
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 1c9b080276c9..2ca0959ae9e6 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -593,6 +593,9 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
+
+	/* DebugFS Info */
+	struct dentry *debugfs;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
