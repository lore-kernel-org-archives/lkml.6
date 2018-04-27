Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpvuVrFIDnyahiaPUgjVjLqFDpbgulhwvLLfPwQz5B//DEefNmYhVBdjV7NwERcGedW/LAX
ARC-Seal: i=1; a=rsa-sha256; t=1524824886; cv=none;
        d=google.com; s=arc-20160816;
        b=wPh4RJrHlj88JNNBVoBDvcERsOPdvWCYHvyLAQZwn+tht7at/gS5fWYrZxf0KHbER4
         yobTK/2YFDxpOHDc96vHrrny7wJcmwT6yiDvdBOuCwg5Aig/fd6nmtiFH+RrcMX6kNit
         RpqZIMTH3TAV8X666gVAhS75mO8VxP+7M1bIuWbOW53O0W9m0wKvXKPpGMobbE+QkqVv
         hC2/FEhLKTwIWa+lXNSeU9x2pEKo2xzB0I6Aij8HGkyYj61oEaYFTMkU8kblnf/EqQoY
         EXK/LgObERbOKG7a1bDh03XSLI/3yNK9x+JtafXfJ77C4E2hXYxKWbvoB3g+kFa7CEZG
         jn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=qVeDFBdK2ZXg1A9kjdH58jcDdysu3NfmqWLh2ByHBu0=;
        b=IugFt913e7BCc+dal12v9a8fV0OkFDq2jZQZlXEtG3g0BUYEEAFXx+szWa3En8e9QA
         mPaajUcVjJOiniyX6nWYadWcbM1O3zSfxRXqoW2CwmHsYNlifGr7oOAmeZuH4x63c/6/
         O3RWVYGRoUYc+9Du0RsFVDa9XsSlZ5b+2BCgyXjyCOxLem9Y6UckrfhZfqRQwKpaa0Vm
         /sJ+JEYyLCSJwYs1mXuim1ieW0jzploswF7/fehq4vDAj+eF9ETL4iKM94OFwpUdw3O8
         61vkNAdhhaD6uJUkveG81E2sV+JNlK8C+RU6GdofWdjJ3/H+DYaMpOfsRLTxrhJeAtmS
         l/3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=KAIgpTEb;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.79 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=KAIgpTEb;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.79 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 4/6 v3] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Fri, 27 Apr 2018 15:57:04 +0530
Message-Id: <1524824826-29473-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:4fsvm1gh0bUy6dOhmFI3K65rmUvBspnAv1fY0u8PZotMnCjeGJUZ5vGHvaJlswrIvRzFJJmKppxjV+P5KpeuE9j1kz2POYuVQ8fQEKs4FyB9y1wowl9ka3dC3OGKkw91OsTHxcTXupj2XOZuaVr3rZ6eZ+960ilnUYe8tYtv+b4BhTH2IL1H5wNKx1Ed3ohHNd176hdzd+Rd00i0ulBhxyfHkayLFaDWyUghTTLluRfRygUE6RDfxF7fi/heraN/;25:TUK48CCPA1B2oKpXfNob4ujkWCgwDqgsyYB46ITWBebXzLv5d2QawXoLzGOYUhBUewm0Oppbrnb/sQvvuN8ZbVKqz5ee+bYkHSMPVgr+S404ZKn4e0yX/bbpezEZ9fmbkj/ZkZS3Fdh2DFctXwtxGNN5/7K3p9Ae1Slh/0nIqvSCK06t8+lM+JWh7kYNF0f3/4YuOqVj5ayc00uvsL3mjVHKjXtnv/saxpP56uwAjPbRkhDTQVQ3cwIlXbAA8KB2SSRHiGeVtm8gKIhk9htnRD4SgpEgY7jaEKXtnvKicq5M8q5CjBhYEzyhHqcnUxQE6wwivXGt1HU6hTvqQzML3A==;31:6gCNHwtEa4cNKQ/WVYVEbYPvRbSuCHjcWMW2914nT3DfPwCGu/LVS4veLv6tFXn7VyHU5T2sqVwc7J93n5/dDDow25C4B1BH+D+XXKZpciJFG6h1ae56mTFbbYsG7VTQ12Kt+C/+I5cnFcJnen7DHlhWAdTNfVsvuQUhVP7rbqxFLMaaLgZZU7aeTUdLn6/CQ5MfLEZkALhM53rk54KS86BTKX5Kd84c1hYH3EL8nMk=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:ewC4J9anMyL41Zju7yqmC+J+aU4VlUtMWQ5ZZUYCL58Vyhe45i8DAeTuSFCiry8y2XimHCnILY3O7BoyYo8O/In7wQ0qsS+moMdXDv6zXbg/ve7h5SRzJOCjqqianOs6yUYoiUwMwprIiHdWOi81SOHK4pg4JhhKbUGLmxca3aShs0E3Id9g+fdPnIEahtbpAikK5tOa7dw8x591t+Zdgp4vqMoWDqFKRJpJ22bDUm5Tab5WBKa6jmlNEO6HcAkyi3FxpExUB35XT12vstBV7ZvNTifOYXsEaA/W/eDES/k2rBgx5WdsnKKRfl8oe1apb5iHfNsi69Fg2C2Od9ivqgcun5OmYI5+MtUlkkwBqeGVBNXMP3ldoG3u8DDIC2Vezl88uAxpPZahsdP/He0MHkZJmhACKBrZricRzZY6eXugzY/ri+c/1Hi/Bn+rs2FuW6knY3ZoXAlerqHR7xI8N/1wXtoF+lPjtOitGLSrSWPfEYwG2B6lmWnqbpoKSuxL;4:IFBuxiAvvp/hDHpprZ8kd1+HsboevgPhrxjCB7Rp0vt6ZgbHDGXmnZ/+yq7ultWgpXx+2duphzo9ZEJ56rUE7ifyp+VWsmELrlpton4KgKqEJXnPalFOENw/u2V36K1wSoLaHnb6LLi3fu+0cgPH/pd+wyj4Zju/0MRLTahf/PPO9NDo3r47xneZWktL4b4C/zDFG4pZ3CGplOoEgWHz1k8WOpsy939NpuhfjXSsQNTU/OlehOGyf+krg46M8fQW0qOQHtizURTFVP+h/o3W0wFKDjxbecYJ42UxQ2GZSTiLEEt1HWvh8WyWZAg841T6
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422136E2B69DBE57A32ECC7E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:kNEgvKBRHinsvU3lWspom5FmSbKhJBcFPXdzFP3?=
 =?us-ascii?Q?sUrpdZ1/ZYYlGm65Rh/X2srK+qUTYnRwxFF4Ie9RjwmW4OCDrVPpTe1IQ1iv?=
 =?us-ascii?Q?mqvYk9JXzXIjv2PN6YDAHT6o0svFenOlgYHA+2TLdXq/Dg5VIAfvccvtd5QT?=
 =?us-ascii?Q?wyZkasjagnA4vpMchRokfo6wKh+SS7tp9Sx5bj9oHC8tsOuXVZJ+VNoSqIoT?=
 =?us-ascii?Q?JgI/3mOy/OZUwXRC19lKr3kQFZc+ASQlkgE38BlWDW3Wy3Cy8X5epDHBTqaW?=
 =?us-ascii?Q?oQWJP4Ql2+MkRhol8pUpX2FbS/NWm0XcdBs0HmOmadz4IMHxrR+OHvQ8Zkkx?=
 =?us-ascii?Q?WRh2PWiBOL1Ftki8sk2ezxLfE+Hbkd2s/8LhdLMDR0wDcI2mI0p3Imjo7erZ?=
 =?us-ascii?Q?jG8uE6851o+QIjssV+0T0MDj7yyldJAmndSYXQBuRtkrzq8Ex4BYE7ixOsNz?=
 =?us-ascii?Q?a+AUK6qnZaOfcPegFwB0nJli8f4cK1RkA4AH/3uIDUN2FyiEq0+HOKtio3Rg?=
 =?us-ascii?Q?OVtFne06wHJUHzGtvc8DUHH1PM+39vb7aiwd/3ss1zjrNAWdxoAoGlBW3whJ?=
 =?us-ascii?Q?u8N7AgmlmARqPTK5z/MAI9ZXWzOmeFyhn17u064XfSHAgkAcc8E1E2wfvCto?=
 =?us-ascii?Q?na/zoAj/0wNPCuv4w1bAnmkJSCvFx3epF+CF7r88ODzsLZkV5+b9OFKGakIF?=
 =?us-ascii?Q?jwln7K64CKKNIP1hTj8v9ZOZ4TCOMZ5qTG1JaKI4lnrs2T0ijtWAsmEI8l61?=
 =?us-ascii?Q?EMOzZmTO38gOMWHwz/x/phWl4hJ1degp3azgpMUEVspnNm2wSuRaP1zIyjeR?=
 =?us-ascii?Q?ABbFLIVZ4IUXmqEZtz9eNgaS/vW0rPAUkveYDuQVKVvOSc5PGVlbWfNtGvAe?=
 =?us-ascii?Q?2tPxshpa3a24FpZPfQyf0OWs/kCYQvufDzok+siGB5hu5nT/MbepbpqtEecW?=
 =?us-ascii?Q?qp/ZMSAr4s7wTRAmnQFpKGWbDu74VgJsF8EjXolHpP3vpRsh0fphBqb38bGt?=
 =?us-ascii?Q?+afwvJY1R99uFqotDYmkFcSnRQzIHG74AYTaPn+SWG9Vz5gbgJQyoNQN0zCZ?=
 =?us-ascii?Q?89QeDtgL7+l4X78USfKl8/Y6XDbU6IGpiM9ON/0WT0mNr9h/PGpMndw4LEVS?=
 =?us-ascii?Q?7MwvkjiZyqf4ser2RMr2tDvT5VfDXFjChQWZx0lsl3aEbgqo0ymU+I6lpzav?=
 =?us-ascii?Q?/gJknuq1Mcn3q6f2En3cxPD+fg4H0ySvdEH+becXwbO4V+pJcnEjlTZeP27X?=
 =?us-ascii?Q?Dr8KZGqVmz5GTKnQM+uG8M27+3TpySmwlTjT3CwTL6H14TgAAZ6QGCwxsuLY?=
 =?us-ascii?Q?FeZKgVTsIDLVq65yOBOrrzGI=3D?=
X-Microsoft-Antispam-Message-Info: c4LHhcxEpM39wpOypsAovjBtGp4xltk7zw59QPHH4WGm7cLapH0d1ZxlGt5aH+pMk45tva09fG+bICOsK7+xUhiYITF8jiRN4Uktkw2mN91srPh6UmCTxHnaQ/Q0XNhYo3kXyFATGXgT12OMs06fQTBAI7FKF6bmtlD3MaWoxazhhKA3bM2H+FU3zx7W/yxT
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:wVA4H2iFXQlpj33fQ5XB0lQxb2gIL+ZArFTxAOUbv8qM1jIDZbveJCgW/OVNMkooQyRiafbsmsJUHJPQbSsmEyJA7vOWvcgYs5Enh6ZJThMKnQpSZ3bDAOkXZAPuEz8AlETEiClZXFEZwmRGJC2fDoGCWlg+0prqRUH/KyX9DoY+pXkxTpAnKPTq5wM1cfBX4lNandANtIhp8K2agDcneWXGY2y+Hi9i6VYT6n88o0bwkX0QVHWALYK8sZkShvvBBoN4qeHJjJS+rpa2dph1YHX0TNeHEsDAevZWIrmk41CXZ8DtV01XF45dgixsU97L1nOMVQO53+rYyb5IVic1jhYLilffoFDZhe8PCLumsfr2+JwvNpSD0Czpw04/Thid0ZdjOwWeZgSyHcKpflW8Xa2av8kHdZ7wL341eJ4u20qF9O++qNDOiitmkFiAUOm/Qc4TZW+Ig+9vJ2oDLyEc8w==;5:jgdBtd9UgXOnveZi6UMOLKRUAoP6ExBIQm61PF6xv+NXOKe36ZW6gahG3Gd525u6FHeiJUhnVPwla35GfyIRH6REqzkQk2sooEfG5r+yrWoZcsQPnflvEG6gwtfCMFnnBXTx7lLrqgecqTlUcqL9Gd1Pmm6EZj6J5hmIzT08N1I=;24:i5/0aGFASQzfNU+9I9uFnMV/YaJR2wRDUEnZdGhe38d7+lWyDRbt9uSS1ppjsC72B4i86NZMwEQ08UE3ttij3UaFM0/yDY5hREoL84BAo4Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:NEh6TzPXaYfzTCsm8Jcc9ZNTcZg8V2n0aTcbXaM6hzG6+kI7ARmVQF8/DFqap4lWBp00ZC0Qe80x3XAAh5Kky04TbMk9/SDsHwEAxjL+XKH7kx2f4kHUUrLLTdVGmplwciCn6GlDLJcc/0cUl4s2+Y6SL8nVcUzJ4rP0ysOWULe/mMkHnveQF9YZIUTTvrGXNKOz/sILnRcxNQqQHdV7qvBB4kqpzb/ElQYuz4IGuLcVNoxoDKW1g7GYauaWCdwE
X-MS-Office365-Filtering-Correlation-Id: a727028c-c487-43b1-592e-08d5ac298ecf
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:27:59.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a727028c-c487-43b1-592e-08d5ac298ecf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894780231677107?=
X-GMAIL-MSGID: =?utf-8?q?1598894780231677107?=
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
