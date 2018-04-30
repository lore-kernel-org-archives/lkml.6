Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZqJ6oQw0o3wLWgec43M+sJRAfHcFAElF5ITrI2Y/oqk1ie4l1x/1KW6GwazZ5t7gWpxKq9C
ARC-Seal: i=1; a=rsa-sha256; t=1525069724; cv=none;
        d=google.com; s=arc-20160816;
        b=0C8CqmJG94RafLn82eJ52AVGkIqmQx7DSs7ir1MOeJ9kgyFkPcrStzQYgce0Mo5ksw
         /CW9S3Z6qfjRyrgprenYZxWIoXFgDrS1I1nikkdxfRzeck8gDFSuKksj1S7t82eP2RTO
         dkaDLj+9J9CZc/htA1aD73NAJ0SHrA+pIIwRc/7RQssKrSMBi6SyIGsNc+ZRhRfC+SUt
         BUZU0gtSKaXJU6+8GLkFWqVYe80+cfB8LRY38GR0zVxbwB/pGQ245+g8kTnqccf16GSO
         esyPsPQK/4LPRVs/VbXhT3udGbg4C1NJfXvR0w99Fyfo/U2T/pCDH+BdNIcR5J5u/g+j
         V1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qVeDFBdK2ZXg1A9kjdH58jcDdysu3NfmqWLh2ByHBu0=;
        b=poYbEn9LmuyaScOcI6cLXMp0tdfkefyYeBngqPQQWqiE+qM8By9d+AxBYqe/kK/srs
         jUdt9DIOkB7+YS559MOwxBYlCvd2B6dGYZpE2DOf2iOGXmdUueoVCNswQfW/MM5L4a75
         efdAYJxspOO5DIZNIAdUI3H1Ab1fxGjx9QXPwpBdDQ03Y8A4Fs6TnaT6W5VKnxiH3lsd
         sSQaDRxHv/t6M49WcWVGusfWZ21av8nNPqRiABtiNDXz/xPSAj0N2S2NMug5EVsjb1ev
         8O5TyuLmXRJZoVd+RZmZqA0D2IiIE2W3Lw+0LmgBo2wWck+6jBVp2h+yr8JaLmyNPabl
         zPrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=H/BIUoTA;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.67 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=H/BIUoTA;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.67 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: hch@lst.de,
	joro@8bytes.org,
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
Subject: [PATCH v4 4/6] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Mon, 30 Apr 2018 11:57:19 +0530
Message-Id: <1525069641-8523-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:3+xC1XijafBn2cQdhkAQQ0AbaQ6D8Ht8u3Je0dlniTDrgPuSVCkQFM2vHBbjsXz0tbBEuWckpBsI8Olmx8wAPMfzwJzawYV225I5CSqtLsOIBUjx4Vuufe95subbpGMbpSC17zdyNNhYzl/cITEzy+dVMmzC9yW2VquDl7yX5M4r5BElbh3buhhQMO5sRftXr15ZwPZpZg76x2FJkGzS5YV87pR4gyvjZ0ecx2Vh7BnhpKVBGy9uXf1nNIadIcqs;25:eRZDI0s3bGHOI3Lcz3ntY+RT4pmePipbqiYB62u5hhLG/hr01bKTQzDv6KszW/qKbGcspOY6fpBUashndDlDx4qmFvr51vTPO07G7tupet6sy1B22ARTbEMVHqdDBBH9qqPC3Kz6EacI0yDh+SRa1NBu43PKlybDBqFwndMYUdh2r4Vq6Oof3HxHaXH8R7eXT1TOKI5Ugixy7BDjqylTzPAJ1l0R8VljmMjpS7k8eDAkyDqIhe+q0kuMkIcdx29DBKVbm3FEN8MxIQChKKKb/jXCaairjaLlaokgd8cgQ7xV+d7zz0lSS1uwG6vMrXIyOurFo7Yih293UH8dVbiVJA==;31:YiSHiWeV/A/gFygTUzpiY86GhKh5rCjTeEgBnkvaTowlRpzsMdm1SdMd+JwGeAWjvpk/2uBGi4coff2P4HKy7qC+cXgWcKZWuUXHVrj3eKt8YRje4T3rsmsb7QYxxVi0caLXKYhJ/D8iJcUaePQESQQDPSg4gLPbyAZeBT+yyvu08uJ52oQZGzHwjHx43Ir9Oyn1b6JAqInoprgGj8mPBGP57utLIcPpfCJLNsCRftE=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:iRHbUwiEMO1SR2Uaf6DDW1VDUMpS85Zj/kcCLwPDA2stu5w3Fn6+4qOS0yyMoKz5FDB5Xe6NzWiy7oiu3snOO2WhM8/LVTaX0OSA682LmUGESXMM+QZeFPoYt6Su73GrZpWAYauFahbIhHm9JjsDgiGvWnmUAJQYe9UDP4/9zBbL2UELYbK8857RV2BSOmxSHtLtRfk4JoOALw/QiVLYORtsK2HMsCZjoZTuefFQF9vzu/ct+1KDmeVSMK/XFCV1haIiJRFrEG8YnKtqt/tiSgOkDETmFkVTT4sejX7BHVOX1PZUHVpa1lmv5OcJwFSOpOhgRLN0UpeUIWfdLPUvH+HlGiIp86XiMM0oSAM9RqULHk8BexFKfxDO1LtVDSTC+VD3q8Kra/ThFyOBcSX85h2CV981B/6U6J+NNAYOYZwnjdPUKPewyBHb0+mRekkmZUszEPN5iVhzo/xkTNIhBnk/KW4JSWIH6+RprL2pFCpgPDDLzbME8hFjaOfBdT3n;4:G2k4nPgiuh2alHqGzMFMFQCzhukzfH16Xp8aOr6Xe6g+EdvKrdu5F7WCg1U6DOCbLzpBfxQm/JmJgsvYfzx3qI9wcML7EKHz8vQ1+RFDoGAMUweGd3kFG6YIgoTrlHEKgqIPDJL+AmOtyNn69xfwdaA/26LK1Cl1Zx8rtKFHLpWE9wFPxCPS+dZUkWmZnIIvUVjkdVmMKqLYHFGOIWm1lUsJ9zKVipeWAb+sWgKY+t449x1oeo75BEE9MI99fDQxrK+oyT+3jNg4gA20hVqslIfCHEqqI/pp9DsOcQQ4+IDgVDwx5NaG1X0yBLmyhVtm
X-Microsoft-Antispam-PRVS: <AM4PR0401MB241870618856B5257B4CE60EE6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:5u08ZxSKft0MyGy7SwjuSYrHQRULIUIr9VskAUR?=
 =?us-ascii?Q?NGjsDK9LxCzJpYfmPL2UKLxRRYJ9Tz1NH4kBGWSG6tSK4RIZwMn8Sgswr5ks?=
 =?us-ascii?Q?7IUXR4cuE6qqIdaZZ6q7Yim8BvfR9Ma+NrLCMLFGDiuGHI1mhMw/4y1id36s?=
 =?us-ascii?Q?00k1ymDYnqpa6Aq1VMX0Q0ePuSMic09mGYcYyqOHMiC8vySzkvX5VEV7b6jb?=
 =?us-ascii?Q?A/EW+tb4FGQXLrdhhbwTZoBER3UZ0zTQ5owDRviN74dnMeHiZ0aHz5rFXNkc?=
 =?us-ascii?Q?wlI+C44OMEPVkbHqaq1VcH9aIbcSHyO/nHb26f48V7BW8fsxLP+kSsQ0x5Ro?=
 =?us-ascii?Q?WW6PvYEpxqbyotdh4u1qALS84tJ77vVPR/j0c5jkgjVjuur1L7Kb5AZMeeOD?=
 =?us-ascii?Q?P+l+1RLzTZcJNt1c8AoAtnmv+B+o3ltPXVVDmvEJyQ1Nfy2DTOgrkqaQ2XBH?=
 =?us-ascii?Q?YLcfTzNP9zr/FOx+bbQoTm/BXOmmB8lM9purxbKldgo1y1K1RRYARDuTcFor?=
 =?us-ascii?Q?QEUban0oSc/CYDmYs8RXAJtIkJdA+ledYpD+PgPdvk8cm4SSuwMZRdjm9zSu?=
 =?us-ascii?Q?/FStR63OrvmqtRmekHs5pWlHwCzrdWBYhQmB8vXUX1zwLbBwqjDlw2Ud/mev?=
 =?us-ascii?Q?RUYTIafIlqV9haD10+QMzpt4V3chPxcjw8CsUracjDVkTCAAb3sFu0VUqFCq?=
 =?us-ascii?Q?TdD387LEHrbRPvU1S+4TQJj5yjQ1nATGYeXgRG+I1+vI+M1UDM9KgXBTDHSf?=
 =?us-ascii?Q?zNQt9conL+gpKoAhWmmRaNJ64NB1iVV4UeFIsjLLYyKuFp789KnooAmB7nh8?=
 =?us-ascii?Q?x169glBIYeRY77oFEq78mzrUKWJIuoUb8e6Wgxa3MGAwY2lYKPFFj9+nN7bS?=
 =?us-ascii?Q?+lFLtrPa4fSOZTsOeJt7rhKnWooQBbb9kI4/lpGwhhmmroA2MVUsehJcz1XI?=
 =?us-ascii?Q?SSMRlxfFLx2JJKggMhMX+ISb/5H6q0M6+y4jwsrenJabQazPxT3KFJNTUfAr?=
 =?us-ascii?Q?5GOxjY7LxtW5y1GU7BA+4UfPUvZTgxGRsjLx3lgj3PXT+O34ABdZs+cICQ13?=
 =?us-ascii?Q?jvOLIF9LPUZkoH6vLsoRUfNrpjlD/c9cLFlSj0++8d9reGge34+9xhbpbire?=
 =?us-ascii?Q?lESI/fZk6cLuwuTpx1QoMSt1m9xzzyLF8dAktvGp8SU0QOkltDBKVn7uBOtS?=
 =?us-ascii?Q?ronVJdhehaixFu+hFI55wojXOEE57uTJNt8tKBqVxbHsa6QFadoPwlvtpnov?=
 =?us-ascii?Q?D8SdyQmfDLMCCrjia23p7sUPqcjrJ/EAIeJrmUqzO1Uee1fKjYUCWlaF/foh?=
 =?us-ascii?Q?tIHDp/ydcbRXC7uvm3DJ/srg=3D?=
X-Microsoft-Antispam-Message-Info: aFNYf2zsK0EYVQnEmjFYlUuFhuPRh9rVh6hk/xHQG00vCGrLIQY2QE1ZeiN2FEjt0L8jelLigZV7uiN7QuyO7aj0R7wyWD8PGLOuAoieclGOKjvhiV4YRDxGC8TdkZKTaKVUMB6YvFv+RqR27Kx+kCi3jgzLRCBz4uwmTiZiMx+DY9Ohz7Epqh1UgyaTecqP
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:OA5U3JAW7RlsoF5FwUXS3j2FhH8DU3HOnwkd6p/Q/iDm1DHpeH/KpKckgQzTWMQSv1hCU8XBRSjWmRq5LDVoBESC9qeE3XMHJ22wdY7IcaTmjBllxql9whz2/EdeTb1NPb9ZahAQaveFtIu20PyIu5JtCreasmmymFmxk7HxHGZu9Hb1LkXGUerr32bGo1yPtWToVhK23SbAJt7G69i5Eks3raCmXZk/nu6zudAKPbWknbceAPVAFUXqjt+PjPx8iD01TgFTdCT6OqkcRUeHcA6CNxdH6N25L53iQ8qM1W6wQU4UtFyerqGD2ACyq+R+uqMp/bCitSd42a84wrxzy5CowQPjV40sLlvSk0t47p++AJgMxy0uvLsDm8WorQWog9+cYiDF267NYYY2Ard3btYm6WWAubKn8+zukMqYzIVUVntREu4NqD6iOLL6WyP7LLssYbR9KoIbwm+bxj3KOg==;5:bOQ7vf+IO7DR8xTuAosJYHoyUNE3WFH1pG3mUcX7TYyKirV2CJ6HluSx1jwrV8szYshfGb9ZX/plbZVxvOq56XbnoL+mvF32N2lAj+NEfaT//8h5b7NDhng3fvmsy2siITHGYZLAVUjlmra9nOsWSnH6aMIKDkogNyuZLOmZhRw=;24:bDWj7S13wtzQroeBsfpuYx+QKKV4RkwIMmHwfNSAqJHr6bEU08whxGURzL0b4o+JJFfe3YbWj9X2DfuAsHexe34ks+0FXXoqgtPxFpwA4zA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:Q/Ol0pW9rI63uBpPvUu4HzkzXShduiEHpQnOyDEOJr4IOV7CGcmRMqlUbfQ3ojXFyrzUjQn+zEgTxIgsBK5FQ3hjsgh03CmXFyEGffD98tAW6HbTthMubjRdwjjG7li0sIzkzqAD/LhelasLB8IphR5FRLujBV2WvoOJCK5Ekt/J2itQbEqHo339CtvhBcnD2CmKR+EHTW49fmlCTTGNS/C1gFoWsTH1Td/Ddox19Rtci6/i4A2N0c9hXkaeaSs9
X-MS-Office365-Filtering-Correlation-Id: 58ab5259-6bb4-439e-b137-08d5ae639d73
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:36.7728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ab5259-6bb4-439e-b137-08d5ae639d73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894780231677107?=
X-GMAIL-MSGID: =?utf-8?q?1599151511568780668?=
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
