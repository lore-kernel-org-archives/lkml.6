Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4/EViwK0VsFY62vUHHt1e2LAmOAF+7PxkbNGhB2sKZfSdWns+rmAqzolXxzV62Y7yXIlXHG
ARC-Seal: i=1; a=rsa-sha256; t=1523960819; cv=none;
        d=google.com; s=arc-20160816;
        b=ySGbfKoGVbZ2T/6KJCjGsWENmlRNPX3tPpdG5iAHhqbewzUMhPZaX/jUBrT8R1dDO0
         dbveUq7Xg6Gg7TuXDLgp0FmvUucKyOevFek+gr8PbF13OVyW211KiRayA7jd3SECV71a
         /r9wdEjrfULIsBWkwnTa8DmyMOvaX82YYtlwoIPTnihEneG8q/3uWRbM0eYcZx++3e0U
         nworgfJjmnC5KnEDD3eCwmmFfUSZLDsfhf+i/oAFCvSnkFSBx79CRa2slni79qgWX2mX
         W8MsA2yFLXq+v2Anjrtv1N4pRq+rxfriG+KweEXgo4WbcBR+28Gw/PrLbxX2lAjt3lxp
         CKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=NFp+kXMWUfbKOWu/gjkoODpLBn7LiKI7I4UBD0kLgtY=;
        b=XWbCpijeEpWQd24R5ExVkgfbPUCW3e65CBEOm+mQ5UPFvAwhPapSQM2OORjsPUftdd
         vLyGL8W9zlw+MiitMo4SC6LgU2pbgQFSDlyRbMdSjVaGtiSNZABVqWYS9A7lNNXBC6O3
         kt3jFXrAy+ifjPA+YeXIR0FU+iSSGibQfWifMfma8iKDruX6lIwTPXcivDzhinX4OSeK
         khi03K7o+42GqgWuKYaISqC4XpXTBpYNDumJ1Rvlh+yYciioY/z7PjBC0n1R1LatTxGr
         NgO5N1yzPm467RmYhnOodGcWyyL1FYXsYtCEDztfy6ZoKup+MXR7GO2jbrIOKZucVb0v
         741w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=BvyVOL7K;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.87 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=BvyVOL7K;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.5.87 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH 3/6 v2] iommu: support iommu configuration for fsl-mc devices
Date: Tue, 17 Apr 2018 15:51:51 +0530
Message-Id: <1523960514-25457-4-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:Qo17uNmOmovURFw0htoY2B2sT/Mxb4G8rEjZsruNoLCT7cF6jdjrNvud2/tsMuz/KYWx2CW9r4nM1Yoz1xCJfhdk01qON4u63S6WQJ8qBp9sITwsBoub+pn36f0/LTZ5kTYbk6PCMwgEVCCzdJAMgNjNLM7DBOHn26eT3fkcCCzUC00tzDRniaAV8aKHKxid+HNi09JYiMVOYnm+gP+kHSOAMIkIvnjGgeQncRmOyKhSoSwU2gMhzBRuH5LeWlDd;25:dFZhNQa3q2fefszvk59qzjiR5TeWkoZaXSo+0dKqo5Oe6sgfir2WAvPxm1+sQJ5+GHrB66UIgoh1MOalCvYBv+32t6lKusrqdHeoU/xLwgQwQUKwcvwi7HmeIHzHV7TDtPybVlhzceLXHms1Zuwm6wSpGHTSSgI3OSovG5kNjpJXPkiAk/HtUvwZb9Fqv6/t6PE3aiIxYYkzHthFWQK/qFektxA8RNxJZNwyEXQy3b7jJ2igMlVt3CmFOqHD65klo+le0lO4J0WblGXJYkcE6gXVi1xHb2y+6OKvZafPyTCg4KwSZ+2all/RK7uJzsxtlgnRdrarkDFB13rrE+z//w==;31:J8t6mBR3WCoHrUC1dVfXaWzlLij32pHRyN9XdT2fE/l0zovFLyGnJz5bFa7Vcx+EartbTsPTvfR/o30XA1gY8nM9LGciUIhLvUH9IYCaKyT8IHRcxEHbGNHQFHGXEUdHM1ffVnWtVqffAuDIt4K+FGuq9FxBtO0eeOzIxYd1isEZjJxhMkBNY/y9k1/rB4UeRJPYoqKfXKdjwiXZSERj5DEBpQ+DB4oT9Buo4FrUbtg=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:P8LjaH5rolkGFmusTDmyCx8pF6iM2lNqmvefLFwsncffbkGvmMAKkHltg6NQbEtvgMRqK2EVoHcd1MNUvqvw+BAH1sX4Tr9wEWQNYdLblclvTTPVOrXqfhrbhJZEPs+B+sZV6IUfns34r2MlXusd/gDccTQB2n52jNUfE8wa57tFdDhsM5Mm78PztJbT5fF78ZZ3vwD7XQRwfuFfEj64wh6thkStCG+hJjZJgzbaRO7sckFPcx9VdxBPYL/GVn1ZjsjO4vsiHwMwuYlYooWWBVJojhn0eg0s7ssqd1BqcMDarXvyWCvTrbRk17r6NLVxedDz/W32L/+0VhvxXG1OYiOkpS8jHhKigDiLjtg1jOPHMseD0mktHqkohBuK2FKJ38/FcspP9Bab/Rj4qUsx2BpRcEgZPGh/cEcxG+QY0fDw86oee7cgx7WqSO7wzfWCaqIqPor0Ag902AQlwMYB09UlGbe6j2FBWRpvV+qHqkkp6uBh2iZGgvHgyRkX/8TT;4:THC0MxMvBrZ2CZzt9VocMHYUr5GaLGwsAQnxD2hskqSlmNCIXzVzL05HLxiSNusHyLOC33lJbQ5QeK8BpSqtSp/8x4cX8fbDvXTBjwKbkY9I1o5A7v1pkizlimeXf1X03nxrltSDEvqufVB/hDZ+NCBt+Til3qC1t05Zqe7AM4ipMw2Q5/SV4IxI4IleMfeoSmbFTfRMZDXAXkYpa/dTOSCBG/91Dz+ipXovmoksJ64HOVqK4uq2hRkZU2RTSXkOGHLSN0mTlVPitwFeMhkTQVr2tM2H1DgO2JtqZ5/asy0qP1h/PPbJumVPsi5aq6Tk
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418D4521D013DD3F8041484E6B70@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501359)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(39380400002)(346002)(189003)(199004)(6506007)(386003)(2616005)(446003)(11346002)(316002)(486006)(97736004)(956004)(16586007)(76176011)(55236004)(6512007)(186003)(16526019)(44832011)(48376002)(476003)(86362001)(8936002)(7736002)(8676002)(81156014)(81166006)(6116002)(3846002)(2906002)(53936002)(50226002)(66066001)(68736007)(5660300001)(478600001)(25786009)(39060400002)(5009440100003)(4326008)(47776003)(36756003)(106356001)(305945005)(105586002)(51416003)(52116002)(26005)(6486002)(7416002)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:8KyL1AK/+14R7stYnUeu8STr0XQKJJxBvrlodVJ?=
 =?us-ascii?Q?gsOE5xz3GN1r/dRqWdlu3dnqTTqClIFNtoeVQyl+wFMsaxiD6WpK9rwDTCB4?=
 =?us-ascii?Q?9AikGxHOHWbmo9XcyiAjNANa9i5lPWR/BVaxIFT/dcXqi319Vytdsnynlu2s?=
 =?us-ascii?Q?DF1m4BpLw0vnAK7S9xMVo5tICt8AcF2jBkCg9Ud18oem5xRiEvy0RxGUwrNT?=
 =?us-ascii?Q?CjevEPcULC6c+8pGQEC3MkJMFQG/liEYjdvMoa2k4ff4MhF8zVDoRKczesd+?=
 =?us-ascii?Q?I4YgUHB0Msu87O4Py/L/WU5UWcoYUkarlqpxU8GyVdVTC9CBpXe4M+mlFpWQ?=
 =?us-ascii?Q?Avzz3H6wFldvxPybo/LIa8YyIJVqzp/Ey2cepH45uqzpkVnk0eyJ4XRJuhHa?=
 =?us-ascii?Q?tDUO1ZpazZH+ilaozkU7VmBN7RscNB/9vt6UwJAfAsVEaImJq0LtJdq1Zug+?=
 =?us-ascii?Q?8xfbY8zXyK5a5a9QpkVT1QpP2nBv5xFyAohUFNPES06PgU2WQeJ6w7UlpmP9?=
 =?us-ascii?Q?ReCR6FdcNfEv6yINdC4sKC/qnD1Of87wAAYvDQzruPvM/asclVadJA41Ty+s?=
 =?us-ascii?Q?gjQxCeKMCR823+b9ykH6IItt5y61+VTOUdBYHYCAqbJPxclKUJbCjVdMOJaF?=
 =?us-ascii?Q?qR9BEkJzEaBk4MMgOgYIZ2piDyUzH8F6xZMC6rTwpej6leIreBaLR7r0Vlsh?=
 =?us-ascii?Q?34R1AZnMW3gt2OmzcXTr2KQ6DgLLX5kZLZgKQEAhi1sz+3lQDujEUACqC7AQ?=
 =?us-ascii?Q?fG/L/bSKA32Q6GCfWlAyqPUeB4D9i+Rgwu+f325PIoks1hECRE/yc0MfESCG?=
 =?us-ascii?Q?ONArnuwqdtW7tHPs+ChXPEYzTbkx0EiJTb0E+re6DZGZvYwvBm1z77yzpL5M?=
 =?us-ascii?Q?pw7jPbwZgTh+bTd2+y8DV6ZBizpdG9+YMi1KyIMjBcUqpzoIeOhN2lrPV72n?=
 =?us-ascii?Q?659cUofS/xM8/ZsgLn1oZzUBIhSuDMqyu60Ox+0eKrdfLZc5c2Q0ukmpGuIP?=
 =?us-ascii?Q?W4HsI4RmB6sOktGgM/BtUOuRXyjszNJ6JcuhfnhwaA84aDJUdeXoIlLq67cs?=
 =?us-ascii?Q?WMhi7JNDRmv79iGe9AeU6DVhfn2stpW+sRq2iFF4Pv1DgMvKd7du9O45w4+8?=
 =?us-ascii?Q?RQ8imliOadlzUi195iIhimnSTj8g2y++zWP7qc2F1OCDOJawyV8i3Z81IZeG?=
 =?us-ascii?Q?Z3S7gMfFqzYn9sw9RHnD7GEmAExiad1FAqNKm/WnCq7W4tiPJ52bokHMQ7RP?=
 =?us-ascii?Q?i5EmiCYz2+Y+uudXFtOHSj206BA3TyO4KZ8imY6CwDB2aS7me8d3GL8LhZaC?=
 =?us-ascii?Q?bfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: IdWemEcI4UU9kpAW7C4t+yL+XcFsgxDRzRBDh/Phfyx4SsV/n8aRck9HP9H1t3NOsee8p5bm3W0ciubUnZsL3hxkDu8+fz5TZvghmU5hDPu0EU+pCWrQHt20KtF9NnBTjUGJ13wMx2YjUh5Kji7ffQBNfRePPwWTOQ+MWiAZT/XLYQZysqj7b2Jf1IuzfMty
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:xboEM3hyUA7QCm4zwWstG6d1qs2tf9R82yq4UOwFw+RJmdbAULAr0jKkM1NHNI4aXohR5lw/zmisg9SD2oxAFCOLEaFJ5o19CSK23Qg5KI+39Yv410kiv82Qq7tOxnQCyWhjCW6HFcxCdlGSSQpCeYuDDkZ7sd22vTp8P7Y67Wet3HTlDinlrgLCCR9veYD1Apra22bS1GUrNgmK+jYcqUgUpBLnx3uBDnCQxpxaPMh1TwZMXKM29VJUIT6+ZDPjllKI4yqq8SS7AYe41/+FXa9+Fr00oAEsyQLs/9b5BnxH0CdToydH24hzx+juOhqP+bvYpRhPOPibc4BLy0oP9uLMGnBjOjtjs76uAMX9KQm/LVTwKWKJIVdGULEk58hbEcLC772B0407ipTVG+6p+1ziu8BTKZl1HknM5qTCpjqN3varCknyW68zZJn3ZNkAVSYVrVrNxYxPQyvxETjIxg==;5:ANaNelP9Ke0Put0b8hbpgFerCYg2omay46kN2qU+MvETpFYbtovINOHpWzLDotg3uZ7PhpkVHEzqhj68yMxb0LBglj2bJ5C0zvtsywKd24AWE5H6S3qWIwxPq55lLvFf9dLZWSVo9ZMWM4ZvWooR3fopzgzqLxun0Z226DdgV5A=;24:puJ/AlzQc+Tu3KpeUboyM/x2t6gFXyP4iOWMEMODyQTwVvbk+wtKQGA+3EAtTneQHD2vUzhH5XxZ1jOs+tOYvsT9Qtg86R7JTgPYBG4CXvo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:YUHh0J5QDwrFIh/SJ8HpdSsqoM3h6PHACAvrRcfsCImXfkbSSzvJpKVY0l/BiNlkenNuAZNGh69HNp4bTVH5L2kvofA3IadvGRBowf+XRfofZ0mi9wvxdLvv0xE4Jj0VRwdndfFmTrY3LMXC3BV+GjEC8Dc3rwld16ULiL6e3qp5OpJA4qyMPHp5bWKV3j/BsTgUVStMB+7z6x0ObbK4MzxaO1FOwo1W8WUNGNQA2uiZbvRPlO5uXf/5cFuzT8Gx
X-MS-Office365-Filtering-Correlation-Id: 1b9f9841-65de-4481-b2e1-08d5a44dbee9
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 10:26:51.9018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9f9841-65de-4481-b2e1-08d5a44dbee9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108376505725447?=
X-GMAIL-MSGID: =?utf-8?q?1597988740336249417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4e7712f..af4fc3b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -260,6 +261,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
+static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
+				struct device_node *master_np)
+{
+	struct of_phandle_args iommu_spec = { .args_count = 1 };
+	int err;
+
+	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
+	if (err)
+		return err == -ENODEV ? NO_IOMMU : err;
+
+	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
+	of_node_put(iommu_spec.np);
+	return err;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -291,6 +309,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
