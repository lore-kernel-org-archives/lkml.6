Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELvAQzdJJgTfUOOSOqGS0VHes87OQMFe6S479ohR4jULlbjcGPDgp84mzb3zqppXEuUVxqEt
ARC-Seal: i=1; a=rsa-sha256; t=1520260220; cv=none;
        d=google.com; s=arc-20160816;
        b=hCB3aMHSKY81X6n/AQTLAoHsWPmC9zg99dIsZgnDK9pBKe5TiKuc9UPDBQAJedWpfQ
         fy91b7klg8hVmqPOieB0Am2A7bHbSsyKfemh2RotHL1AodfvvbcRirbmWPu/WM6Wf9+C
         k0LcK/ciD1tAaSVKADp/AdI0vra7zLMT+E/S4MzRDbthQWrsYgTFGPKX+WHLFgaAv9kE
         h/xlPP86fJbPkBCtadH90zTJOsZENQNh3MOUJaHPEVfFoaEchFw+HtOvXr28FtakjSQ4
         6hIswGbG/QD4qcsoyUVRiP0+O2TRbtZ4Tj+nqtMfKr22nypiHabV/3I6n8drxeouRIj7
         ma8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=vNPsGdIeRIkkU82rmFkfW5QRLHd1j3BGSym0eMANU8E=;
        b=TETjMfzNCbIQufziAuWhEavuh0PWckUrCBdeLdBZedoWtPWyzKcOrOrSWMsM9J1IhY
         A94cYDhASZqWN6hJHgRbbEujlKlGck65JewJdcX9Ql9Y43cAJLMnSYwUT0mxfH5lPLPW
         3xxFzjSIPRToxoxuGH3J0vDfPPpm4TBKekit2rPgrzFvjkdyJ1AMAL8MjPnAZcQZvaTm
         jAzBEDRQlVfUnkf9kSzRhRmJ8kbW2c01iqQj2e4QPr3KHeABTxmAX49GrvrNISYoOEEA
         mxV7RO5s/whdioL1+k9JUe1V+6+DS/PlLQfzuFi8vBBDteOG8su+Inw9lJxQJ5S2LldF
         7RVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=qstIvzVD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.64 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=qstIvzVD;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.64 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/6] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Mon,  5 Mar 2018 19:59:23 +0530
Message-Id: <1520260166-29387-4-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac56a29f-40ea-4b15-86d7-08d582a59dc7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:BDZ9l2naw+QnzywOlvyUmVNyP43jAA79TvTwk4UWlNPcl4kYspHein+IzhzZuAoRLfXa10KKxndQv0EjUlc/V5P+g+ty+vNbAxohRGEU+uTYOU2tPfheBXsgLgMJ+s2ANliCm4XK6rNp7oN1ZS17OlzigyvhEpVWPXXdnFW26d/414eVOuX5ekIudfpdvIqb6xu1jSLCAaQugyghDvz8bsGpYQPrahOW7Zuq954rdmxjxRD24zjYB+nSWZTnXiCS;25:nFyDdiRptyNyUvmZ5k2Ivs43MlU9NurCth0EmgPi2hlYLDJV7PvzSRZUZJO7tnyjfni0xcG1JItIKJOEZAVyMFqMo/VmF2Yy2zh+LXWfGcRK0Kux/GXmNEFVxn1jh3rDUP7FEnKLR+sn7KzrSNNuNPdYIY3EIAzaHuN8T5IdgovMnKEYBTJGC7qmJZrQelpW8tzgE0YOVYG5JG1lZqxiFcPEn5V/B6lwoY+wa3dYztL8va763USq8dWRRoD6CVxZ9HF+GMbcuWEW+pg0Mq5k4cjOa3bU3PZBhE/mawknAjZZ6HYaZBxEZj723B9QR1OW3gZGKmtEvEYnbi2juiXXbQ==;31:fDfhQ1C+abpZMwjqLIuiTWo8nRF4BKFqsNGRjMo7mjORCW4NUpUOlpJibeYDL4o9hTBkxaOOuc2SOTo+oumZtk7XobE0sWjKPsFffXch/v5Ox7JJgwR4n2wyn8dovR+RvZunXASsg1/zl3SPMwERHSTrQlLMc+j/3r4077b4WGx9ST832Gijnnvgxr/2WNMXjLRuFR9oFHHzYZCDs1/qiDICE6CELUONCu2UgVRWsiQ=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:7N/P+qTDsZl7eHUy0grhL1lGqpGYBpLXmfG1jqMEaREf7uXFhKNp7/eZp8X1QC++4LRzm6TZki0nzCGNBSuk6QKf1eZOgmsd3AhsApWwHxQj40yciOS2aNw44oLagIiNxQd355FUgo5ZltsoYnzc2wTzS3OC78kU60WBU38/7WLGmIH1Fx0U4/0lewjDpC/9wVyVcBCxUp8Wt2mm0BXFRiQdsEtwB2LhrrMso0doaPMy0y6gw275uS4t1CqkBoLSZ+puJi6Qxu78u+7LeIwqo5f8TkWTPzbsZNuQxyqDGlekLREkVv0JtmKVxnpWIvWW38Vy87+ckMkd9RE6D1j0jfBMGt4UGq8PaPz1GPRI8nd19QifRUkEDqMzQG5VQY0cFtmzeS5YCmLbctHNVWElIWXl5VdVyAxG/XwcdeKPQqlpTTlO/DrPoHZ/2bgZZDj/ALvAh/5Vl9lYhJzMMDU27rdexyWk5scbdrRAaxa9PKVzKMxYfZgcMn4nC2NqIErR;4:/g/UCQFJH1W5aAnp6ZHhef/WCmZPUp25QaYWHVDfPDzTqKPcxn8JshNI/FSe2fabnUVj3pCYOi1gyGjhrcT9mcwjoM7/lExQh7kCTrvF1rGYYIZK3PcbXBNSObmp3CQobyIhVkR6z0+SYFVnBdakD96OwycLAlTbuA13wSe17NE9vrMxVXvV4ZZB2rURId6XUL2MWDFBfrpn63yT6d0WhZUzhTWPVUZ33eiBUZ6gpCi1nE+V1l633Oa/Jysqwo5mEpkSvoihO9rI7nI3wfl+uRz/aE6BNGhuoZZsdwUMOr+6awOMygKHR+3R2bSedF4/
X-Microsoft-Antispam-PRVS: <HE1PR0401MB242547B36DE1D4F9596CBDB7E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(6666003)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:AzwsV9r2dT60d2XnrhzfzuVvoaR0anjQ68Pv9rC?=
 =?us-ascii?Q?kXsZPko6r1QeEhL1QYmuuSv+37pzv9cEtOXw+6GCO7bVMA41LorkY331O3CC?=
 =?us-ascii?Q?XsqQacfq3sWU2og31kRqj5uWo5AxDziJOH11UxTN+Y/EyJG9US6Nsopflq3t?=
 =?us-ascii?Q?mRmvt2hLedXiZhenZ1xXwPscFk4VdS33Y7Mc2zuc6psjEQX1QXglXswWyLNV?=
 =?us-ascii?Q?yya6BKSNymDsY+FmunM59o9/x9hVcOpC2iCycpmOX3ppnshSL+Q0Iq+pbrBi?=
 =?us-ascii?Q?1JehCffGGNoDegvaVYx/slu8iwPjirWMAQZobal/8xWZCSimqHtzl8LqUwKr?=
 =?us-ascii?Q?tKYDovc1Y94oQy3DTb7YExqxjcdNPw39DP0Cf8whMklfav+zrJyiGXvcv0xW?=
 =?us-ascii?Q?DPtj51cbsaQCUxysYp9WoAkpvaHSJX2ywu7HEekDR2tyaDiK2V/SEeiFh88l?=
 =?us-ascii?Q?ZgJiQ2e8oKlO+0G79Uo8VKPIr4qVFw4ar+5UpreDzETnTPHPBIE+w7I0PLfT?=
 =?us-ascii?Q?MT5qU5th2J9NBEWDvxx7j+jAJBFX2Oqk/nxFkgGFeWcVZLfZJSWGNRA57EO+?=
 =?us-ascii?Q?AmYQ9hOb5cYLHuuk0LPJgPZ/ABlU5EI8IvDaWd1yHziaVhAvMLH0rIMFabAU?=
 =?us-ascii?Q?1DKnYsBa1hYI6rBMPX9rJ5d9vhbWuzGoXWxPNwgp8hm1VKHLQTdBkfDs/uy1?=
 =?us-ascii?Q?Si4v/0WJM8dhFyS08meg5gdcz6uuG7R3tm88g+OzmWe6CENVgFNCAz62rsGF?=
 =?us-ascii?Q?ztxQFGlFue6LgPTuFvGv13N5uxoCra5Vuis9xlFu3QY+JvOUNmMGQ1E+Mdte?=
 =?us-ascii?Q?aI8HGEXmKFQe/3GenIM4nzNMHTWBc5ZOijKaDAyEnisyVK57xqv1uzUS+guO?=
 =?us-ascii?Q?2VzDzNO6GyzF5D6TL1FEmOh6DogKIzsPjAliGy/kSS79jQeRy5XZ4Y2ubaEk?=
 =?us-ascii?Q?v0iRI7o6Yn+mTxYPoJV0joWuEkkzXHziJ+Ix/xLXzPFgtGs+QtCD61gVjpuN?=
 =?us-ascii?Q?z6+iy9IJqFRp61IlBGjbqBAAxIzVPvRpbMM6NJnoJUSebb2N4yP2gxEMcdWo?=
 =?us-ascii?Q?weERIzEY/yKECz6u87CCki23HHRtQI9UVcwWXFpdCMgELSs2OCN8TX4Nv3bR?=
 =?us-ascii?Q?yjvDBP0JjSMDuHjvXfb7awX/ByA7vMQe0xenXz/e9/CWSszLUjXNWZTyB/IL?=
 =?us-ascii?Q?bf6AIFmP6mTNIW9++gOXA3IB+XVGCDHtfNqE+?=
X-Microsoft-Antispam-Message-Info: oo4lGfdjgaxLsLs4qaN9d6NXtxbDGLa0xpeIT4g8TOuQq7OXdvAuTlIY2LlUEa1Ie9+OXZWPpSz5wpx5rJFv3BTwmXkfHIi8s+H1fkNpIjlEZ16tUbkxR3xtiS6uhpmzFtzf7R8M/IelDX9Xwivf+LEvUzv9kFtbIl5c3i0KzIAbaop7xN2ncfKal0xjGVOt
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:jUwa6Ak5bPQjFQNbuseqHIpnn8x3VGY+eBEV5vrZvALg6LRVHVMPAoViqsiwSifnmB+sdn5Nz7Te95xuB1QNWyJhGv4E6WGSHvdoUFulmz/RIJoXIpjq1P4xJU1YUzujfJ2NicVBzS5tt71tS8u6jQZN33bZ3zWm7AnRNlToFsBzsUest6mo1gxPB2Wxn9oryEa0199wt9w8d8Muo7zchtJ66MtNffifki/EoGXlTo86K5bhDA3eiAZl9YZ/vGLojkAVrwCmVeZXZTIQqYFqoxDf+a/r3hs4ngLwilNtanSZrQiUNyu8oFgJn0yKyXi1s4l5BqMrd8DBiAjR0av1Z0oNAEfmXLaz0qwAU3SScrQ=;5:SdwdONxTJUa8YYylLUfHVn08jUdye7HbutDM5ZKOM3r46PCXttWJ7uNxcW6X0EiWeGaMmWepKBdFDzwa/rHs2c0HcXVMeO53X8gIxlr9N5+wKrCURApFf2kn/UJSYuN3jq74dG8CRZSd3HWwxgcVx955Q/5S9UF1OMnCOGLT13A=;24:3EgyAuu+h+indM+kqjLOXzyK6YWjnBCSvPb4qeJQGXWwCxKnL892d/m0tU9LwBzSIgn9/7IqviujpB0CPkSDEtfZite/Uo1fvmgZleFxq8M=;7:LoR6BUQoDvtMsMQ76PAEXR4WOpzRY3lcc46NGSJ4LirFimL0v6MUAYLuo5IBBfdfpkTFjDaRjtjhRCczjyMYZDAu6h8DK2lzBvTjvF03mFUoylhzzYR/xC/Ahbrphp8pXBxXQuvW+O2MgP12OS1JCAhTVVpBzRSTcgwT/VaEtRSx0RrsPMWoReNAwed8F47PtOAucy+VbJYG9DjTb64C2LgIyjMAUqHBU9UXz70s1lD0ZFon1RR2+BNnGbYEXM19
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:13.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac56a29f-40ea-4b15-86d7-08d582a59dc7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108381270270991?=
X-GMAIL-MSGID: =?utf-8?q?1594108381270270991?=
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
index 765ba41..ae9382b 100644
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
