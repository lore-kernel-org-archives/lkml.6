Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeENRVG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:21:06 -0400
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:42255
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752056AbeENRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:20:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2018 12:20:29 -0500
Message-ID: <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
In-Reply-To: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN2PR01CA0036.prod.exchangelabs.com (2603:10b6:804:2::46)
 To MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1455;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;3:5PR7MwzQPj1HvyhxB9eQVrEUCcIEoP7WteCCIt5KTiTPw0Z7Xcajtlx1EvLfP7E2V2DNgz3GfEImfVrt2d1QFWL+6PHUbETKnkoIrVc+evMIDQFdjPeb0rs0BwlWh1eMcx5iNqtkU28kqbqfqAyggGfSPrYr4H39qrgQAtiixOEgFwT1v3aNk6B6wT3XvGyq0nmVKyhuFpF4OZH0NU4frZ3tjPRrVL8RAV2DgEe36bAe0nGABjxiRzfCqr4ssjpn;25:pIj5FIejepYXcw3TYyoRqb6VDrAktjAyZc+VgsyAqThcGL49MyoAocn3b36uUDm/QtpOddQAx9CxQuZ/RnqypHcy6NusH7JOYMMUhhUsPtEI1SnEqhun1gGfsR8h5Ujb12zKUgU/El1NVUSWI3YTiQC+vMbzrwfZ79+KRRUeopuv0e0hwlJgi6fYt00TU/CHGheRNRB57dWFsIZz2+yV3galeHU5d0WJA4T7gfJKpSDTu9+iYsurH6yCKRXPufhlBOKin2qlk3YsIc8j0brT0s7xKgSP+YnJItX416qCQZcvZT+eQGHu97X363gUpXLGk3IsdbzVOyUhwyA/sW24UQ==;31:dmKUQSb3nDgoZN5wy/xT+UVIb00CWq3V46VvtRJxoevhl89MpuTiXZDqfvZYVolbQxCUlzIkXQpjzYPI/1CnRZhR6YrBbTVzeUsBddkxFy+yUMSEVHPfntJYVExLdvXZSQB8zoFGCkMbMAe+DMJ3EoaVTrRWy89Sj+nl0CRCJuxy+8Lv/V35YKNXcR+B0DFmVX7X1oBQOTBzXQ/Gow+aeX531wc5EX3V3R8+ycvhoHM=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;20:UfSixqt+0mIvjl6xVPdO9WvstZCkSq0S8Xq95hTFXB0JyN7BWY8lHwc1uh/b3VGXHXp7bcjvwuGiTMf/1S2X/QUdcgedmXohHleNzoVMYEXl74drJbDt5AtyJuMXir9fm7ebaGr9ITeSrHZhux4CmgcYvc/G6hRwmdG1Bx3Xuwmsv751sUTvf6hYyVZQykD7BqomQQVK+8nu9G4qLybd0T5pTfoLkCMniL6/w2dIRorSlQKmkZa5eN5krZBi/HB4ceJMAtdv1/SToy9EJaehuB5uF3O+NkNL4ujU5zIGW8QsP5AuTRSx2oBn+mGoMnIu7/VPcy1MXQqzAKjK8arAIdFBB3ZcdKj7RzT0fkeFvv5OJxWS/4oxXBQhj+7JjD7NAMMuerPcOAjD9g+WOuAd52LoaXm8Gs4ZPxPeZWLfLk1WX0/15zRVerf1vmTdDIWU/yHHpKZrZV+PblaycgGi/MPt35QdXS3nhW2RmyM7H/jNjpNjU+k1EXI6x3IhX1iU;4:rhyfRP3sAsuj6zXft3vwl8qjIAEahM/jHKSfXujDCxHCwmFjQ2THLDZQ1sl44PmSCL0s2IkkzqdOP3mboqgydWrLG56yRalXJlDHddB1Rk8CDVsu7cfx7kzb2UGc7Lpp1Rtmwdj1QZr4A4G1fKH36waHCSkpPq+sNmhDDmZAQBFX/mY5yW7GvXoH5F1JmLuhw0Zz8cKzKsa1oi8l+pFgopsxe7aNTyGegCqiOvj7Cvv+g+0NlCAL3ge2a9S7ujcPGZ52ls5LzR71Hhg+d8g5KvX9q8uUhXgwPziSABupuNvhUIQsx80HwivraVDNSye0
X-Microsoft-Antispam-PRVS: <MWHPR12MB1455AEF553DA2590A1CF45B8FD9C0@MWHPR12MB1455.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1455;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1455;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(52116002)(53416004)(6916009)(105586002)(956004)(7736002)(106356001)(26005)(8676002)(476003)(4326008)(2486003)(23676004)(25786009)(103116003)(6666003)(446003)(7696005)(316002)(486006)(59450400001)(68736007)(386003)(2906002)(305945005)(66066001)(3846002)(76176011)(230700001)(47776003)(55016002)(11346002)(53936002)(50466002)(2351001)(478600001)(81166006)(2361001)(16526019)(97736004)(81156014)(186003)(86362001)(5660300001)(8936002)(6116002)(575784001)(58126008)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1455;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDU1OzIzOmN0RkIweEZtcWpMSTd2MnphSEhqWnNXekNR?=
 =?utf-8?B?V2RXaCtqSkdhSzU4MVNzamkwb0FlTVpUeDd5T2tjTjFhcFB1REJSdXVoR1Bq?=
 =?utf-8?B?MDBaekUxOGw2VFNmZHFqN2t5cHRQbzFMOUUvV0RNV2ZWbnFJL1FUQ2ZHVXQ2?=
 =?utf-8?B?MG92YlREVlE5M1ZmZnpNaUtmTURIQjA0cGZxMGtrbW50VE5waGd0VkZaVjJ0?=
 =?utf-8?B?SDZnbzNySW1RRENUWGtLeXkwNVFQV3MxTjdIbFpXRGVOVEJmU1NJYTlPdEU2?=
 =?utf-8?B?V3R5Vng2Q2FMZWxBaVlZdGhGQ3hKa3VMT2NlNDlaRjJTUlVaT3JxYWkxMmRN?=
 =?utf-8?B?eUNqc0p1RnRnc0FvZDZBYm9wbm5ldWh5QUxtR2Z5UXBTS2gwL1NtSGliMUlG?=
 =?utf-8?B?bmFERkdWcWp5TzN0ZXRpVEQvTGh5VjR6UkZWYnFhaUlGRHh6U0lJRmIvZGtP?=
 =?utf-8?B?azdXdWdZdTdLU3VqM2VGMzlRZW5teGVpSHo0OSt5TUlHV2RXNzlubG5Lc1Bw?=
 =?utf-8?B?d3U2cTJLNmFaaGdTbzFVUGZxVG8yZWJPWkVGNUl0RTFJZ2NSU0F0clhWR2hB?=
 =?utf-8?B?TjVhUjh2TmZKQTlKaHhjajN3U3VQajF0d0VsNlM0dGpLTHp5eHhrK2NCOFJB?=
 =?utf-8?B?MC9VU0JtWHNVRHNWVmg1alRuZm9la2VFR2NRQjZuaUZ5SmNWL2ZBSXIxNWZv?=
 =?utf-8?B?VDVudWRhQzU1VDV1VS9OazEvOE9KSjhwM1kvM2VuVmVrM2lFVU9DUmI2VkQv?=
 =?utf-8?B?amgwU2ZnVXFWVkZQWkFEeHJ6WVNxenIvQlJ6bEhBbUY2UzZURHdRN3pUYk9L?=
 =?utf-8?B?ckxHOGZzSzZuOUhUZEFjejFkMXZRTHFxNkQ1ZSt1Ulg4dy8zSlFWUTdHSEk1?=
 =?utf-8?B?eDBiOG5CTEh3ZFFKUzFISTJPVjNZbm9LTWVOOTYrdENlTFV0Y3Z4dFdLQ1pk?=
 =?utf-8?B?VnI4d2w0Z3pLNlZmVTdKRmpNL1BYM0R5d3FrM0Q3RVFobVNoalMwMkR6YWJY?=
 =?utf-8?B?bWdsbmpIS29CL2xLSEQ0OS9xWi9jejBNVmJzTVUwM3dObllENkhIOGlVbmQx?=
 =?utf-8?B?M2ZhWk0yWXhyRVFBNFdEaEZGR1BqcFNha2phVXNYVEE3Zkp1bGRBOW9qcTAz?=
 =?utf-8?B?TGVmKzl4TjVwOVpxQitwUmh2RHYvZEVaTHlFUllidUhrKzBjTER2VTFlOUxZ?=
 =?utf-8?B?MEVrQnJ3MFFqUFU1djRHdTZKbUZMaS9FS05MTm5hNzhjamw0ek5tN2lzUEVv?=
 =?utf-8?B?VldhT0RnMVFxYjdBT3R3VmdZRVVqalhaZUx0M3R3YytrWnplR1hKWXJubUxx?=
 =?utf-8?B?VzBKaE5pUkYxQmZoWnN6UW5TVXo2S0NHRytuYXREcXdiaG1mb29ZZU4wNVBi?=
 =?utf-8?B?N3dwamFMek1keXdxOHJTRVd6MC8vTGFScldEeDFRNzNBUHZiazVZVW5MczZW?=
 =?utf-8?B?RzRkK09DSnZwVnhpSU9RMHlNdXZnVi9Kb25EUUFlVDIzYUxsTUd2YjhSSjQ0?=
 =?utf-8?B?NWIycXMyYXJ1SWorcVVEc1gwOUtGZEFGeStidGprd1JYWHlmZFp5aGxwd2Nw?=
 =?utf-8?B?VlVZUlVPMG0vQnZaRHVxallSeVdwTTdjaDUxMkJPNzBCSzFmdHZhYzZGS1BS?=
 =?utf-8?B?UGZtcU91MC9tYWlhTHpZVUZLUEw2di9yZ2txV1hUTnkveUJ3RnUrQm1aMHFI?=
 =?utf-8?Q?fOzK0wnNlR6x4Ftv6onrTWIgBRjCgulZHPFrMU+?=
X-Microsoft-Antispam-Message-Info: 1gjR8mWpa0bV5akgBPxVpJfEKINH8LRoVVHIDcYx+kPiaG8R3e7g6jlFkRkbfg1RD5bGJUPZ8GlxVN9+UHMYSIEhJCHlQyxkKCcpT8BnEmf1hSkM52w0a4kZXJ/DiSrggVpdliIgSTluUh/Tj3BLgz7Z+9gemS31u1Q8l1Zoh7PZs0oiF1ooEk2XZgMiDmWj
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;6:u3rEyVy3Ebu376GYqf0Sgp6yCrV0+C9HcXTkruGZ1R+so7KX2Om8pmDsAEhJBr3O7cLezCB3ZhAA7ulww3aL/QdnjDlNat6nE4luJo13Te1/p6muAzjyDxPAN9UhODMNIpXpWQraispipGJGPiaE22v5spkXuSXlitEVpdYhcTQXGeaSuifhpWoGPm44BSbN/iP3JaVECn2T6IKIvheCS2ffyag4qEWghNsOWol69yLzXFgckWVTZeiYCYjXUUjvGOy1hqvsik3fuRA83GBt1YlcXXNn2m1Hq9YXtYPcL19+8Q1Equ2x6ZFWGInDirSOrSWIX21ePHLwUyCTGE50tIegFJejIZ6AiWaP7UyZF0ptss0U5ia8joA1RroOZETLT3jnqG2NrEQsH9rlDt74b+Og6YQo02FSSVJnZFahOLaWxEtqmYTja0XRDEj4l7VQ5pFdDwvQfS/FqCLopnLaQw==;5:0nzruYrcA26qlF/AieWHbyAsd7r5hZyx7ojDwlmcUdeYXdryJk6rIhfg1dMLF8xPnc0OWQXJ1fPGn+nUbSYRUPnW2e6v7m3DlcdclcaQZkLQi21DC83FJmKCPHNlMHN7b0N0VtthDUozR3JbjxSngd/xsj6wD3HlqGFMg7e1AsM=;24:HcR89+o8pO0qh0hrhxjAWBY+/v86z4XHhnr7usucDlkgsk7AEWf+/HCnhwCk+cBdudE3IZ1+Q3IZgQ01YQhexmgmgx+RQC9aBawgCDtOQKc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;7:BVDWcfOPSuXwAgN1+6UuefL4oEo1AW3PywjQ3aPDFqJuz12o8qQW3d2wE7n+HF+xPYIC9GaGcyPzJ/z1wKJALrZgaeCoYkOxg/3M//9zcopuV0NkAg8NKJ0hXb5MZiKFYKsKaPKRKvbd2FXdmOq/grfCmA8HarjXmVlyZHyTQRd5bRHH14XtHiehMkvWelaau05C3kGw0GynaDpunsBkG7i90aywWNl2uZ8v8Iikf8PC0h136PpLFAIpO0oyLpra;20:/r+cbgEQG3NvIDAuUGPCAuMTXPChL4wMFsB9rZHJuFgyAl/LHGjLfFfSSEFQBW/4BfAgwT0Pq0Tg1YHVXnhyfxw74eK0UwaPpahPhN4R/M1xI6/6jwN+wELX9ZdvGCq4s0fMuRlCOFm9IdFkaPlYVjseGhkCQo1abuyaYkdKulfRG0+f90/Q/A5SLuuT7Fklp6Rjx40S4dOdCXCzRLp1Urt6lBvnQCHM4ntmkcE3PneGmSjOFyYL37uJtLs2BxPD
X-MS-Office365-Filtering-Correlation-Id: b697cda6-e18e-4c09-d1b8-08d5b9beffab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:20:32.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b697cda6-e18e-4c09-d1b8-08d5b9beffab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
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
