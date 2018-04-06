Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDFNSE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:18:04 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:31187
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753149AbeDFNSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:18:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for AMD
 IOMMU
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Apr 2018 08:17:53 -0500
Message-ID: <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
In-Reply-To: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR1101CA0006.namprd11.prod.outlook.com
 (2603:10b6:4:4c::16) To BY2PR12MB0694.namprd12.prod.outlook.com
 (2a01:111:e400:52df::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75641174-3a37-45bb-40b4-08d59bc0d06c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:fFkei7YO4fkf9QruXZA+p+Uo1JdcVrSIzCfvwoLLPZhYtQcAifv4vV6fz5aFBXbLip7lnOYAybq/O1aJp8wOs6u4u11bameEE7Jq//3zWcDLoUCexrPPBlwkKsiFzkcr2y/V9GIBLMZHBLBMy+/eqw3aOZTsypkA+ol4ksbrhns8pnSlgrDLQ/m3wrIhvkm7FOgNbfIq5a0A0iMOM7p1zfNrmcoAoKuMQdHb68M2InKtZSPBtR/nPZvqmc1iVhRT;25:FDByE92kmnK3juKKYmrmLHAczeklWAZ+wirzXng9js0sHItvA8oXW8pS3acphvgkUjpf8Y21bKls/IN8WVAGK5on2QGiphGFVxmzPUb8Y/IfRfTW/IIBnlLg7/1nRX/EeeFVna8tWwELkKV4EVnl9PukgWLi1OzZfsHZHw2Ou7bn4rn2f0O2GtdQSq6Yeuu8iSDe/hwckuc2fZpRoPlCFQfxTKsC7pIcDZq8m5WqyELmibul2kjy02duUxlTHNJrShUIkdXwgn1D2LydTkCtt04N+G3+57pH2+MHJAktALF7mubetQdcQ81L4wI7XO6R8Uj0cby9EGrrUpPDRHEuAg==;31:qstmnNvZxwRXyNQtkGdYj1Z6cmmKXwwEGQ4aciWj7qq69k6uPPm7ImDM1h9WTSY3k5jMVN9FVBBzsmMLq3LWSd+vQJ0YIzEG9Nu6xPns7WnJ+pVZsLoBNz7zg4GUaao44HCmAV+3Mjdt9C4RX8yEwTvJKxwZYIqli9dcy0o4cxg912Ba6Ssif9iH/zulkW6DxdanjI7BAV5eTvtBbFtESoAvvnaOsIgSNMqTCjLpuQk=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:7d/qbbZUw2FWoCbK3s2GIznRVK0bM2fDHfT/1e6O2Kd6ymZZglN0kjMqtb7p1vHDd3l5HWlo0rGoj87It6lJadHN8c22oZDpHxBw/mp7zEIjIDbyYfscx/YrDVsBpsj+BXZv6nW3PYULjfX5vs0lfprJ+/q26IP3c1oqNDmfep7WZyvupT5JywAUTyfj0CEUXLLHGEz3FYm8vXLI2ZYwlp/OZpOFiEIYtUT/+bLZ+z40iyxSMCmyL0jtx9mDZjTxNU7CblQg+rFDssxk0GEzohal3xydoJ/Vkp3CW5KZh+JQUbOKYUrS7TMF8v2SOjIJbsgDxsuCQtjxyI2M/XyymMeTmaWkzNW+cLjlJ2abN+XNzk8cU5vYBtkRGKzTX9k9wZK/8tqYV5mt9vGV8vKi2lhQlokN5h6snRiEx/hXUG98aakrZYT3Nm/Y9Fb842P0EL45+kLB5Di5qzgCaQC1699QvZ/QmoanNsUstyeRJYdGghhmNFVn/VznbSybFSJ1;4:G4bKcMvvp9BDhLQYjL180bGPmipbjSrgIxW6dQOmQhkpy7xsdQQqr/hztsGh9J5lBMQDOZvuyAvppzb1zoJWMVxyT+9QG9/rB+L85ZMYjCBcZLdj+3aZUxqNw6EMKrUiLSLrtpHd5rucnR1uXNQXGRqW69YltBCinLUaCgTfNMNnFFvPK1h9fXMkTdy/VeDnuZ0dTtyMPfn/mYSzQF8FCshSu68y1yBSIOwRgm9mrTkaJ5K0ByBDZgt59kg89EkAUd7Ek7yTjtBF6+ixXdPDteMmZWy3RhLuX4AhQrCTMTqYlgJcBiJU/LVfCrR54lVG
X-Microsoft-Antispam-PRVS: <BY2PR12MB0694F854C44B022DD5F9A59CFDBA0@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(39380400002)(376002)(189003)(199004)(486006)(956004)(11346002)(50466002)(58126008)(446003)(16526019)(476003)(186003)(316002)(52116002)(47776003)(76176011)(7696005)(23676004)(2486003)(53416004)(55016002)(53936002)(66066001)(106356001)(6916009)(6666003)(478600001)(4326008)(25786009)(8936002)(86362001)(59450400001)(305945005)(105586002)(386003)(68736007)(575784001)(103116003)(2906002)(6116002)(3846002)(2351001)(97736004)(26005)(5660300001)(2361001)(230700001)(8676002)(7736002)(81166006)(72206003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:sosxen2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOjJlWHo0VUVLWXR4K2FKVXc4TmN3cDJFeVdH?=
 =?utf-8?B?SE1qeVNkR2ZtZDVORWU1eUJpMmRlN01Tdnk5TEt3VEgvTGpBK1M5STArMDYy?=
 =?utf-8?B?aHdEaGNybkFvWllFSEdNa2t3QnAyTU5KeEI1MWdpbTJUOW4xNk80QXFtZWhJ?=
 =?utf-8?B?VnZEM2sxN1c0dExUUi81VzJNalVlMW8rWS9ERGw0S0ZNYVVCbnBZOTJxUGll?=
 =?utf-8?B?UjhHbldPalFTcHBCa1Jhc1pYUGNQMVlBWTY3ckpXY21tbmo2MTc2ZVI5blc0?=
 =?utf-8?B?TVBmV2VTUGQvUE9GUlVBaktFa0FUMU9oWWR0SkZ2L2pva1hhQStUK250eW00?=
 =?utf-8?B?c2ZCWXZhaDZmSU5ERkFpSEhnaVVCam52WjU5MG1ndVBHL0RNakptdXJHK0dR?=
 =?utf-8?B?aTA1bFVyNHhNM3JCa09FdjB4T0RxL1lQVHdKM0RKbjFaVmRLZXhIZXE5ajBV?=
 =?utf-8?B?QmFnVVJ3UGp3M3NrWmsvZEg2K2ZRb2ZnMnVYSSsxcVpwSnlKVzdqY1FsaDNl?=
 =?utf-8?B?R0d2TGpqSjJXWXR5bis1dHg5NGNMeTBTd2tWOVFUbGhvdHN6L0JCRmlwOUUy?=
 =?utf-8?B?aHJCVVBMTFBSbjdxYlczU2d2dDBacWlkU2FDUEVCVkd6ZVBkTjgrbmd6T3ZH?=
 =?utf-8?B?dXZnUWNveStaN1JLdDJiUGdsWFVrUnBpdVEzOW1nUU14MUJNSzBERjkwOW51?=
 =?utf-8?B?c3VPTlRXV0dwSHBKTFhPekdVT3Y3TnRTNmpXWWdmTkRobWFHWkJkYzZsNGpp?=
 =?utf-8?B?QTZxaHh3REx0ZXBoai80dWkrWGkzb0ZKdkpCRjVDMUNka2s5VFV4MEdVa28y?=
 =?utf-8?B?M1RMcXYyR2dWUjZjNlp0TUdQaVVTNlMvZVdINVBSSFJBSFRWNCt5TXYvSVlE?=
 =?utf-8?B?dFgzd1VrcS9pR3NkclJTZkFuYm9kQXNLb1dhOHJ0RWN0U1Q3RFFyL2MyeFkv?=
 =?utf-8?B?cUtQUEthOE1VZFNadFBDQlVwblA0WkovM211U2NBWS9zTUVUTFFDaUxmZ2Vu?=
 =?utf-8?B?NjUzdEdUc1RHY1VzY3NqNzlxK0Y1THZsOFczWnkrWWdMYXppUFRTdnB2YnF3?=
 =?utf-8?B?Sml6emdhYzdjN2wxWUNGY1FlV1FMWk1FV2xncjdWQTFEN3pnUFB1elp4cDNH?=
 =?utf-8?B?RGRpa0pXTkhUc2tNWWo3b0FUZ3gyQjBXTW4yUlZuRkZqOWFqZmNCMmJRblZD?=
 =?utf-8?B?TEhTMFQ1dHJVR0EwMG5JTXNhQkZCYWU5U0VhSTE1eW1pTitpaGk1MU5DOWJZ?=
 =?utf-8?B?YzhtSkcxUGt2N09qSlAvYjZjK1l2c0h3QlFrY2VpbVdlZHB2RVNqay9EaVFu?=
 =?utf-8?B?YVRGeC95eklQMmVVVElFanFMQXY4UHZua3RFYXp3aTJJVW1TRWtXRkNDR1o5?=
 =?utf-8?B?STAxUDR5MCtjcWsyaUh4b1o5ay9TK080TnN2NFZvNjZhUFNyN3lMQ0paR2Zl?=
 =?utf-8?B?V3owQzMxL0toSjdONEF3a2NpOTFKcjIraC9rUytVQUdZdHFXWm9RMk5YVGdY?=
 =?utf-8?B?bXhSTlVyRTJIRFNZdzdRMTFMMHp4V3paWi94Q1hhRGpHTjhtSnowUENnalpO?=
 =?utf-8?B?bE9JL2FVa3BJTVhGSjhjNWFPNXVZSG5hellMZ0F3VW9Sb1Q5MU02bmF2ckFL?=
 =?utf-8?B?ZUk3MlllL2hWK3BEUmllUkd2aXo1S0wrTTdzb2k2UFlzSno4MTVSTHhsemRX?=
 =?utf-8?Q?/bRGg+2hdtxrEqPTvc1j4/rAEPVesrgD4rsgMv9?=
X-Microsoft-Antispam-Message-Info: MEvtntk0n+P6DVM7SD7LfsKYt7tpwYT8hl1lvk/7NqSCYNDC/9u+pzbXV35y2YDeSm5gXwsshqPxlzun5diz3fhmXEh/uArhWv3+WYNvt+KFAa0HRZOP7zTLXvWdY1z9o+E7TmCzKqZIudKHMJOVj0z0o3nYaRn+qY6hLezduHgdrtFL8ckcppKhDyH7OCfU
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:TIr4P+wXMEWfY0j4jBqaEUqyjnSfXO35sizD3CECr/sj2wX9gMbLI9coG0k2GvMk7QkE6PtvKgXmgrEZJKzYOTmHd6JpMyV+gwDMdWJmkrq+Zhy4KtsMpyK+geGjqHNkEfDHNNZjq7J12HJUdkrSp5x0MRJlUPHwCnJTio6KX44/sNxaLzvYfnDrBbrJJC1RTD2K/4BZsZ4WoOxElTqdtJai9wBU5p1SBL9pyZ1/Mn1GGJDO48kgMKt60OVgDEkGx22NiPJdtkuBr6F2ATgtxDrWeLVFT3UqEvjfn7ZYz4LSrTF8A7HegUoWPtw8jzQJwBE21LMSrBoDOK6Sr8elnWRlidx3N8SVr31/66t7FTcIFRLBvPqsVPbEOmQLw27HPeNA5Pt6L06QsE1IF7wqOsyX88vBzn8v50+9Xauo9osiEJYnKrLRZ3UlQSeW0bHfFebORlcfeN4SwbS9eAw8hw==;5:JQN/puzzQZYL3Ma/T3F1wxzuatDianpEFCzM+m6Za6m5cv0Ru/o/VuaEdiEgxkmS2IW2yHQwdbHEsSEqfQ+nAIUqknJofcZqyHxXMQT1fZirGmFR+4wkGq2tkr3T3rZC8SpxjFMEtWFiNwmnHVMvaF69NDXhj364jAY6D666io8=;24:4wC9AaSW3Rt6OxIVOKj4J+Zy//DJIGfHELZZN9SAFmKr2edZUG2OWEeABjYviCq32vz1vsR1q4yxlx9MbhOJLenKxxOPhvlgjoPrzp0lWYE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;7:3TTY19QzgSQ4BHaEVbtTqHJIgg9Q2THwujE7kSPMWbW+MMqShUaAOT59wHBXw3p0OxciAeXBhVpCW1/RZSHnpLCWt4wYt18ZsnXIar5QAZceGhlHyJDB3YNOl6OzQ1c/XcFvVCNQqroybtGvnpDMsTLIJW+0XPfHNkrE/r59PhMuYj1c1WKg8MFXQCY/Oru5mksB4AAGAQuJsUXovoSCbN+ESImt5ltDn7ktIernAWopyiA0Tk3+uXjwmC7IL5Sl;20:jqX8Zo5o63v+66KcRpPS9MIjKV2o7UAB3XfKnhDmQ8M7K5/5Kyz0ZjoFTKsazWs+/aA3N2A9l56FwqVUbkNax6S8dVpq2Q7JLsbgJh6dIpXSGyYdXJDs87GCz4d1q/M8iHLFzuFvqJ2lPpkhzpJUl6+JMbEu+SXzzBAeyDyEqmSWljf35AKQzXqNtrGhucatvmbh6YdstHaEb/eje2uT/HmAXj+fXL8rr39l3nSFsJxlq+wSGdilM5cTwCy8g/dt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 13:17:57.1043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75641174-3a37-45bb-40b4-08d59bc0d06c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a skeleton framework for debugfs support in the
AMD IOMMU.


Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu_debugfs.c |   45 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 +++--
 drivers/iommu/amd_iommu_proto.h   |    6 +++++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 5 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5eb1121d54b9..0ca250f626d9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
new file mode 100644
index 000000000000..282100a655b3
--- /dev/null
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -0,0 +1,45 @@
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
+	struct dentry *d_top;
+
+	if (!debugfs_initialized())
+		return;
+
+	mutex_lock(&amd_iommu_debugfs_lock);
+	if (!amd_iommu_debugfs) {
+		d_top = iommu_debugfs_setup();
+		if (d_top)
+			amd_iommu_debugfs = debugfs_create_dir("amd", d_top);
+	}
+	mutex_unlock(&amd_iommu_debugfs_lock);
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
index 640c286a0ab9..daf7f38531f9 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,6 +33,12 @@ extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
+#ifdef CONFIG_IOMMU_DEBUG
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
