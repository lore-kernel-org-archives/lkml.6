Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeBVXHr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:07:47 -0500
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:20512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752022AbeBVXHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:07:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 4/4] MIPS: Octeon: Add a global resource manager.
Date: Thu, 22 Feb 2018 15:07:16 -0800
Message-Id: <20180222230716.21442-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222230716.21442-1-david.daney@cavium.com>
References: <20180222230716.21442-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:100::32)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbea1231-41d1-4cee-338c-08d57a491212
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:PWffSqd8DaLitNfQi71j1EQpaAp07EC5sy7gN2Q+xZCmdLXxYn5mVz2Ey6NwnEnUumSVNyLC7Y1kGt1fN2fNZcY7hKsN7W7yNIGvO7hRTpCIbIaGHWNz5hbwlPXGZT4X8U6YYKvJ7Zj4O8HKm+2k1oXhKgsKERtlQkL/cEgAMGpbwy5YlByummaTUckvovFyRYBqMJwXirYMZgbMBLK9iN0mL7tbbyAHnfiohZ6AS1ti1YIGjgJNemsUFK5k9/XR;25:QD0Phdu6Op1kfBvAEx0KRcRxKD3dYA62bxejzjkTjLY40wz67bo2EC+mTzA8KNtNAvmCi7xTtSqryaUOGpwhQR2gNLwvlLh9fhD8oLut4Q+AqtQKNMHwMTTsxyOqVHjoO1Ti2BHnxFzgnf0JLXfT6JYPdAmVF5LIsylhCFbLf7tLMvOLlXicS9MmPABtiASC1pcjSp3q6g1c6kVcChdzJqk2NOz0sLbhz772tNc30WGhrkVIP5kpscijZt2mL+Ajfn5weAVFLlToinrvaToX0tsiv4FoUXznMl4m/YLp/jedVjCF1fHNeokfQyIzlJPvB56zYc/C8K2wLjf1/BIqvg==;31:voR1LzVftfsLk9AcU3DOv/KYnAAvzzc1Pw9oTcO2Xx/XNGco9LIqNFdxn/A4VujVTz5F0qEEQDknOYZhM+xgEccDniS2mNZ9biEwS7+GuEOfjfs717iq1ogGulblQdAw7mWCQDZ0w1WFFGcqs7QWaJlS/VXor+yDuk87ou4/LHea9nShjA8HGfeIZ8TN3A9FERRTPoSIarB4DejZscWzTIq6yVBhTcXdwhVdlmPV80M=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:Y4wNhlZaVH1bSjS9s4p6zg2+12IlETM86oIWwXssNiz5C78S7kIki0N2NDBok9u6vYlb5tG3Y4I6keypVXbwRndqwotqYwiGtOmUUCFQAWJdxiBN2q09svgMeQ2HfK0TCkAUAiFx2VKyqvf0LFCxzoOJ/8GbnvR5wb6XXbrlzUTPU1rPaXImjQ98UT0879QDWP6Bia9NPn0LFLRq9pwUJURz908qb/9vpTqfrrhClfdJtcNy89JPqXrNVs9pAzJQihpoGmlYC2LJBHNSh3RmnIhjasRsELXYFaB5AxYN71CfttaN/+ZAoj1rPZNv4nOf1TOTCOZpo5I8COv51bdWoESovIwxITVsGIAtQfntSOOFaq4rYQSLk5FgPQq0PJ1XZ/qciEfP57ulkVM5CB25/qEAqUIXMVIGDu3NsglSiEpKST85Bah7MJRwYDn2/rWV6vmFU4RMY5HGNtxchAtlJaGcTxEuiM2+OlA5t+BQL1Gt+pr96+bVhR7X9nnCFrtZ;4:eXxJ1HuzJFCwqIUN0iEm2LmYvCrProJEv4C+MGMPqN3QGlsljPt8LctXKa69uX5G4Ml1pI3JCZZQ0sTMLzE9O7oxh5GGCCGGM5QAhEK8Pa4mzhFRdYm6EYMkUNtmtEoXW+/2M+vTuatSsos7Z1gcmS/skVk1HtkOfaI8KaPUEz7XLaHd4L/4zJC/XqiEmX2OqtmxHGODWyuH7dl6rg3BNddGmsacnN0wEweM1xRnDIf8vQdg+iun9huCWoxTsoEyo+9PJfg8tUQBFST9FG2N8Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180AA73E8B086A2EE94ECF397CD0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(53936002)(305945005)(53416004)(66066001)(107886003)(6486002)(69596002)(47776003)(6512007)(386003)(59450400001)(6506007)(26005)(5660300001)(50466002)(8676002)(81166006)(16526019)(81156014)(478600001)(316002)(16586007)(54906003)(8936002)(72206003)(48376002)(25786009)(4326008)(105586002)(50226002)(186003)(68736007)(3846002)(6116002)(2950100002)(1076002)(6916009)(6666003)(36756003)(2906002)(7736002)(52116002)(86362001)(76176011)(106356001)(575784001)(97736004)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:K4ngAynSrngxZg6GTUgMetzTJfEldxfzX/G9mySy8?=
 =?us-ascii?Q?8YNSINNslOnMnvuUz5t+3EzFJ8lMAH/1mFqHGMw/qs+on//8H99kieT6kXUy?=
 =?us-ascii?Q?femMR8vT8EPjMXb0zlQDADTQDh8iA50gD+n0+yribWmVZUu+UIMMTu/V/KbD?=
 =?us-ascii?Q?H5N4pI3NLZXL/9t1dF8IKY1QuFUtiObdBU60Y9UW2GxgypZfa3tvVk6vX9bW?=
 =?us-ascii?Q?hYeRtnliuRL+jD/XdeF/Mxjv8JgsJ1Ao2ZBJ+D99xXQFSGdvqgaDtyLJP0bQ?=
 =?us-ascii?Q?bnFl8cb3bmHp5w0ZJq5BEqXGmfrepTZoNDx8r/i+/7SKe9g/Qv1CmHgeSpGY?=
 =?us-ascii?Q?Z3THnI2yr7FlpyN7fYWbQIjetlgmP6qRhL7xPC02LMdGl2tOlDkCw9zoY8Vz?=
 =?us-ascii?Q?4bJOIuU2Q2a7TX7frhaqZMLrzbnILL3OrbMAHaAUvuisiqXFT0Dza04tqjQD?=
 =?us-ascii?Q?hS/B1mFf8GNxctcFomacGqaUf79NC4dcBo21yOC5lDknALwEh3dbz75PToji?=
 =?us-ascii?Q?k3VXiCiZYQmAkAa+tYvB7Kabu7AwDlXQe9nClAaXZ/0xkW+7/kSF5yOdjmra?=
 =?us-ascii?Q?6zk3l72oZxGghffSoIWzkxcR1NJGWcfWgw0Su4CnrfLVUrcvy+e21kHd7SsB?=
 =?us-ascii?Q?ESNyyivxLsI2nXgFC3X5NxbPHd0+QQcSdAzKM5siLWFpKWBPR1KxZGm88GRb?=
 =?us-ascii?Q?dVDuorHqgpki61YMB7BpJo10iUMvNNaN+uKdXCjILPjO5UpQWEVIxyFA9kft?=
 =?us-ascii?Q?sOnqArW8fskNFizmbymiYxEqjvStdLFSg1onHudVWxVohGki4MDpvK7XvwiT?=
 =?us-ascii?Q?6yoKJqWpRzLHQFQXzybtlyNRzBojp4PaqbEOmRXHJCcutXdCdt13dEghp2KR?=
 =?us-ascii?Q?Rr991TqxJih6M3qwMI9U4CTI5q1BJWezfmkR8DXikB17vRYfFLkKEarddmWF?=
 =?us-ascii?Q?v8sAOCSQhEU2/x8yTxvu/rFKzTbfKz3k22lD096SSPoB7sGtrndL6yxGWnCR?=
 =?us-ascii?Q?5sbeU451GVh8QrVVMhfGM4YAL1bWNtHMpMM++jwdty2yHsJyBudnUBptU4P7?=
 =?us-ascii?Q?nDU0YBoO2Q/tgZv+9fiQj4ulzQk6PEJdO6JTlKfe5vGiGlkkLUI2UfsHYOzq?=
 =?us-ascii?Q?zsT2rIB9CuMk6gL3B9OKh8S6rADWrwYtx3ZLRu3mAx5LZO6mUA+A2cN2DEM7?=
 =?us-ascii?Q?WmQPpCHOIq/61lLxM5inptvjg1EkXAnM29oOhp5zWHlNe69nrd95UcfhBU6D?=
 =?us-ascii?Q?pXGzGduopglqEmPzAeyQIiNMr0gV/bY04N8RFpr?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:YeMfJUaXXuD0SKQYQB6oUJntYigKAHhhkOBLoBQZ7EKPQCHO1mIqCixq0lFGiuK3mNlPdGvjU5YC0ZjFJWAXKJRjmrdnqvwSjuHdH/sdGvKYMY9x1a2Wldk5czfMjLx3vMlD6/CRV7wByecfwe3zwNX5TO0MDxqXHdksCCD/PftF3J4TIgUJY3j6AqlFD0V0XudkM47gdGJUkcQVUDBACOzHNecClzECfFUj6d2ha5WHsUvGyyrwSHn6vr6X+Uc9wOBucc8WUxNo79EgnKyfdu8lZVhDdM4+vts7VhXyWUS5wrN67yISqHN16uCgph+gmqiU8CVb95BkfExTnvwC4n3FM3SKIRahEgklDD4LoAo=;5:qw3jdLrq5Fs+CK+GL+iN2Van0O+2Hq7UJ4bgzFI3gATPgXh02pqxRfEG3BpRd2ccS9hZwlGdxZP3/byO5S/GZB9b6OPzvnglA/RELkdJKQEth3G1czUgaWVK/MPIM8wYoHrAO1lL1/eFBLx65V0HFq1ssPv9b+wC/0LArrypFeU=;24:fHp6hNa9S1xWPoGsBhW5yfjjd0zAnu6NkCNFs4lvH9E/dNJ30BXxJojU4KR2cYSxNumObhMDGPjcA44T249ohqxovJv99oyHkTOyJyIX5Pg=;7:75WVYnCnDIV2oudQOpF5aEFXiRWzmHiaJjqVKJInGvopk15HyIUAavl+9sd/jdh+7gi1efdDFBLbjxyVMNY/tn0U0i3THTw08hIZfDdSxrzGkO9GPv7DUgW7N9hqX4aMtjjgI0z6bHvdMoGX1Qd3CL/WM/kltJE5657EfxjY/oEaQE/EWU0OdEkOgo9D53ybmyfht2lymLWdzjQXPLWqYyd1b7RFxLbiuyYqU5YyIRXNnpMCBB3ZPi7o9yyDG4eh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:07:33.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea1231-41d1-4cee-338c-08d57a491212
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Munoz <cmunoz@cavium.com>

Add a global resource manager to manage tagged pointers within
bootmem allocated memory. This is used by various functional
blocks in the Octeon core like the FPA, Ethernet nexus, etc.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Makefile       |   1 +
 arch/mips/cavium-octeon/resource-mgr.c | 351 +++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h  |  18 ++
 3 files changed, 370 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 7c02e542959a..28c0bb75d1a4 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -10,6 +10,7 @@
 #
 
 obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
+obj-y += resource-mgr.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
new file mode 100644
index 000000000000..74efda5420ff
--- /dev/null
+++ b/arch/mips/cavium-octeon/resource-mgr.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resource manager for Octeon.
+ *
+ * Copyright (C) 2017 Cavium, Inc.
+ */
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootmem.h>
+
+#define RESOURCE_MGR_BLOCK_NAME		"cvmx-global-resources"
+#define MAX_RESOURCES			128
+#define INST_AVAILABLE			-88
+#define OWNER				0xbadc0de
+
+struct global_resource_entry {
+	struct global_resource_tag tag;
+	u64 phys_addr;
+	u64 size;
+};
+
+struct global_resources {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u32 rlock;
+	u32 pad;
+#else
+	u32 pad;
+	u32 rlock;
+#endif
+	u64 entry_cnt;
+	struct global_resource_entry resource_entry[];
+};
+
+static struct global_resources *res_mgr_info;
+
+
+/*
+ * The resource manager interacts with software running outside of the
+ * Linux kernel, which necessitates locking to maintain data structure
+ * consistency.  These custom locking functions implement the locking
+ * protocol, and cannot be replaced by kernel locking functions that
+ * may use different in-memory structures.
+ */
+
+static void res_mgr_lock(void)
+{
+	while (cmpxchg(&res_mgr_info->rlock, 0, 1))
+		; /* Loop while not zero */
+	rmb();
+}
+
+static void res_mgr_unlock(void)
+{
+	/* Wait until all resource operations finish before unlocking. */
+	wmb();
+	WRITE_ONCE(res_mgr_info->rlock, 0);
+	/* Force a write buffer flush. */
+	wmb();
+}
+
+static int res_mgr_find_resource(struct global_resource_tag tag)
+{
+	struct global_resource_entry *res_entry;
+	int i;
+
+	for (i = 0; i < res_mgr_info->entry_cnt; i++) {
+		res_entry = &res_mgr_info->resource_entry[i];
+		if (res_entry->tag.lo == tag.lo && res_entry->tag.hi == tag.hi)
+			return i;
+	}
+	return -1;
+}
+
+/**
+ * res_mgr_create_resource() - Create a resource.
+ * @tag: Identifies the resource.
+ * @inst_cnt: Number of resource instances to create.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns < 0 for error codes.
+ */
+int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt)
+{
+	struct global_resource_entry *res_entry;
+	u64 size;
+	u64 *res_addr;
+	int res_index, i, rc = 0;
+
+	res_mgr_lock();
+
+	/* Make sure resource doesn't already exist. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index >= 0) {
+		rc = -EEXIST;
+		goto err;
+	}
+
+	if (res_mgr_info->entry_cnt >= MAX_RESOURCES) {
+		pr_err("Resource max limit reached, not created\n");
+		rc = -ENOSPC;
+		goto err;
+	}
+
+	/*
+	 * Each instance is kept in an array of u64s. The first array element
+	 * holds the number of allocated instances.
+	 */
+	size = sizeof(u64) * (inst_cnt + 1);
+	res_addr = cvmx_bootmem_alloc_range(size, CVMX_CACHE_LINE_SIZE, 0, 0);
+	if (!res_addr) {
+		pr_err("Failed to allocate resource. not created\n");
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	/* Initialize the newly created resource. */
+	*res_addr = inst_cnt;
+	for (i = 1; i <= inst_cnt; i++)
+		res_addr[i] = INST_AVAILABLE;
+
+	res_index = res_mgr_info->entry_cnt;
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_entry->tag = tag;
+	res_entry->phys_addr = virt_to_phys(res_addr);
+	res_entry->size = size;
+	res_mgr_info->entry_cnt++;
+
+err:
+	res_mgr_unlock();
+
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_create_resource);
+
+/**
+ * res_mgr_alloc_range() - Allocate a range of resource instances.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested start of instance range to allocate.
+ *	      Range instances are guaranteed to be sequential
+ *	      (-1 for don't care).
+ * @req_cnt: Number of instances to allocate.
+ * @use_last_avail: Set to request the last available instance.
+ * @inst: Updated with the allocated instances.
+ *
+ * Returns 0 if the source was created successfully.
+ * Returns < 0 for error codes.
+ */
+int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
+			int req_cnt, bool use_last_avail, int *inst)
+{
+	struct global_resource_entry *res_entry;
+	int res_index;
+	u64 *res_addr;
+	u64 inst_cnt;
+	int alloc_cnt, i, rc = -ENOENT;
+
+	/* Start with no instances allocated. */
+	for (i = 0; i < req_cnt; i++)
+		inst[i] = INST_AVAILABLE;
+
+	res_mgr_lock();
+
+	/* Find the resource. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index < 0) {
+		pr_err("Resource not found, can't allocate instance\n");
+		goto err;
+	}
+
+	/* Get resource data. */
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_addr = phys_to_virt(res_entry->phys_addr);
+	inst_cnt = *res_addr;
+
+	/* Allocate the requested instances. */
+	if (req_inst >= 0) {
+		/* Specific instance range requested. */
+		if (req_inst + req_cnt >= inst_cnt) {
+			pr_err("Requested instance out of range\n");
+			goto err;
+		}
+
+		for (i = 0; i < req_cnt; i++) {
+			if (*(res_addr + req_inst + 1 + i) == INST_AVAILABLE) {
+				inst[i] = req_inst + i;
+			} else {
+				inst[0] = INST_AVAILABLE;
+				break;
+			}
+		}
+	} else if (use_last_avail) {
+		/* Last available instance requested. */
+		alloc_cnt = 0;
+		for (i = inst_cnt; i > 0; i--) {
+			if (*(res_addr + i) == INST_AVAILABLE) {
+				/*
+				 * Instance off by 1 (first element holds the
+				 * count).
+				 */
+				inst[alloc_cnt] = i - 1;
+
+				alloc_cnt++;
+				if (alloc_cnt == req_cnt)
+					break;
+			}
+		}
+
+		if (i == 0)
+			inst[0] = INST_AVAILABLE;
+	} else {
+		/* Next available instance requested. */
+		alloc_cnt = 0;
+		for (i = 1; i <= inst_cnt; i++) {
+			if (*(res_addr + i) == INST_AVAILABLE) {
+				/*
+				 * Instance off by 1 (first element holds the
+				 * count).
+				 */
+				inst[alloc_cnt] = i - 1;
+
+				alloc_cnt++;
+				if (alloc_cnt == req_cnt)
+					break;
+			}
+		}
+
+		if (i > inst_cnt)
+			inst[0] = INST_AVAILABLE;
+	}
+
+	if (inst[0] != INST_AVAILABLE) {
+		for (i = 0; i < req_cnt; i++)
+			*(res_addr + inst[i] + 1) = OWNER;
+		rc = 0;
+	}
+
+err:
+	res_mgr_unlock();
+
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_alloc_range);
+
+/**
+ * res_mgr_alloc() - Allocate a resource instance.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to allocate (-1 for don't care).
+ * @use_last_avail: Set to request the last available instance.
+ *
+ * Returns: Allocated resource instance if successful.
+ * Returns <0 for error codes.
+ */
+int res_mgr_alloc(struct global_resource_tag tag, int req_inst,
+		  bool use_last_avail)
+{
+	int inst, rc;
+
+	rc = res_mgr_alloc_range(tag, req_inst, 1, use_last_avail, &inst);
+	if (!rc)
+		return inst;
+	return rc;
+}
+EXPORT_SYMBOL(res_mgr_alloc);
+
+/**
+ * res_mgr_free_range() - Free a resource instance range.
+ * @tag: Identifies the resource.
+ * @inst: Requested instance to free.
+ * @req_cnt: Number of instances to free.
+ */
+void res_mgr_free_range(struct global_resource_tag tag, const int *inst,
+			int req_cnt)
+{
+	struct global_resource_entry *res_entry;
+	int res_index, i;
+	u64 *res_addr;
+
+	res_mgr_lock();
+
+	/* Find the resource. */
+	res_index = res_mgr_find_resource(tag);
+	if (res_index < 0) {
+		pr_err("Resource not found, can't free instance\n");
+		goto err;
+	}
+
+	/* Get the resource data. */
+	res_entry = &res_mgr_info->resource_entry[res_index];
+	res_addr = phys_to_virt(res_entry->phys_addr);
+
+	/* Free the resource instances. */
+	for (i = 0; i < req_cnt; i++) {
+		/* Instance off by 1 (first element holds the count). */
+		*(res_addr + inst[i] + 1) = INST_AVAILABLE;
+	}
+
+err:
+	res_mgr_unlock();
+}
+EXPORT_SYMBOL(res_mgr_free_range);
+
+/**
+ * res_mgr_free() - Free a resource instance.
+ * @tag: Identifies the resource.
+ * @req_inst: Requested instance to free.
+ */
+void res_mgr_free(struct global_resource_tag tag, int inst)
+{
+	res_mgr_free_range(tag, &inst, 1);
+}
+EXPORT_SYMBOL(res_mgr_free);
+
+static int __init res_mgr_init(void)
+{
+	struct cvmx_bootmem_named_block_desc *block;
+	int block_size;
+	u64 addr;
+
+	cvmx_bootmem_lock();
+
+	/* Search for the resource manager data in boot memory. */
+	block = cvmx_bootmem_phy_named_block_find(RESOURCE_MGR_BLOCK_NAME,
+						  CVMX_BOOTMEM_FLAG_NO_LOCKING);
+	if (block) {
+		/* Found. */
+		res_mgr_info = phys_to_virt(block->base_addr);
+	} else {
+		/* Create it. */
+		block_size = sizeof(struct global_resources) +
+			sizeof(struct global_resource_entry) * MAX_RESOURCES;
+		addr = cvmx_bootmem_phy_named_block_alloc(block_size, 0, 0,
+				CVMX_CACHE_LINE_SIZE, RESOURCE_MGR_BLOCK_NAME,
+				CVMX_BOOTMEM_FLAG_NO_LOCKING);
+		if (!addr) {
+			pr_err("Failed to allocate name block %s\n",
+			       RESOURCE_MGR_BLOCK_NAME);
+		} else {
+			res_mgr_info = phys_to_virt(addr);
+			memset(res_mgr_info, 0, block_size);
+		}
+	}
+
+	cvmx_bootmem_unlock();
+
+	return 0;
+}
+device_initcall(res_mgr_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cavium, Inc. Octeon resource manager");
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index f01af2469874..4dafeaf262b5 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -346,6 +346,24 @@ void octeon_mult_restore3_end(void);
 void octeon_mult_restore2(void);
 void octeon_mult_restore2_end(void);
 
+/*
+ * This definition must be kept in sync with the one in
+ * cvmx-global-resources.c
+ */
+struct global_resource_tag {
+	uint64_t lo;
+	uint64_t hi;
+};
+
+void res_mgr_free(struct global_resource_tag tag, int inst);
+void res_mgr_free_range(struct global_resource_tag tag, const int *inst,
+			int req_cnt);
+int res_mgr_alloc(struct global_resource_tag tag, int req_inst,
+		  bool use_last_avail);
+int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
+			int req_cnt, bool use_last_avail, int *inst);
+int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt);
+
 /**
  * Read a 32bit value from the Octeon NPI register space
  *
-- 
2.14.3
