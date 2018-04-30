Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZqiRdjEDl8cvM1tv94iMMz7PA6I2uTiRdckpkxKbt40bfiq/vebX9OXI/ksxFqypRNQFIy1
ARC-Seal: i=1; a=rsa-sha256; t=1525069717; cv=none;
        d=google.com; s=arc-20160816;
        b=iNCBc8xK3nZY7gv+n7BtZEmNOxi96aHHp03y/2nalObMmkR4S2rfslbzcFqfToUa0e
         9Qy1KNrlvdAzmqSgynQYu04SaTWZ5/pRoIq9HGJ/kT7IYnM6Fu9oBQUlBVZG+LnUmwSj
         l09bphjNz8UCg/gHb366xxqWVW5F7QjuSbzwuxWL4KAZrsMe0Jyh8UONY9tzdHuWnhpS
         ikln0YWmBFgW8ELZjA10P+wF+vZjvkMXrs0OqvCWsUsP0cansew2cOk/mWK5OYvIYJHz
         FI+EiSP5Eu9sRFYjEswVMToM16Cy318vNbKcxzlsPMxmGB/5wPumYvkoqPVdAyClq16I
         VwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GT71q3ErxsD1K0lUb/wZp5bm9eIFTYzYsNSawVBmaME=;
        b=vyOtWkcU4QG7LF/0ht+SJ8fzQusuawAJRViPRZN5tj7dnML1sNcgP+p3vB3nuLlI1Z
         fohmyG5u/y2/lm1298TTk+19cWSOnV1b0N3SsdN/8+UYRK7PdyWpk7diKy8objd4Hf9M
         UlJXI9TzFWEb5pucFjz8aOKeuNqpNAFG5EsNA/M/RAAFGlfJjHFS7NtsJod5G6ylYz8s
         WKU8xFR6EY7ZLt1Qhmi3Z2gd4DJYku1Ku3IcRwkLc/xRbwxVL6xphpGP1u3vrDFZlORR
         z0VZz8G9Vze57bCLXt7VX2J+qYr35tmWbS0axqjiI2ReVa1uUZc6m6NByYcoG/P6QIPH
         MxUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NwVeAB5T;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NwVeAB5T;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Subject: [PATCH v4 3/6] iommu: support iommu configuration for fsl-mc devices
Date: Mon, 30 Apr 2018 11:57:18 +0530
Message-Id: <1525069641-8523-4-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:16XVRAHihTRqTWNBTUwP/v9SgIRjA7EghAoNbAsBEznFJxiR9DQgkfjME5dSTVWLyTUS+2DZD3DPVGe+KpkYrqpQ7W0boEMyXctXvpacu3AkmL+hYEQNWeG8rkS6pAYUI64d9/RxU+Kouf1qVuQGzFu67i0nAbbMmcY7AmcAnKKGrteL+iBj+6eK3Ak9L8qatw2vMIYTsmjWoGcmpACHLcrSb5SvU+ApdawFwDsystA7nIUBNz/bP+8WKJhF119k;25:cHRd/kVgG6fipriTxr31dOYKCWz4BF9YGSChpKR+0NVgCnPeHJlucvWxkNPakJZqqmyGj3EqsB2wPyzFVijGIr/aTaoXUEv44CRNNtl0o/u0OWeP4ibUiewhrGXm9XOv2NFkQ1HDZxxGJTpjMABGTLDsoTZlTnvYcMz2N1J2DW3C83Lx5cRpbO9mdoAUpnTxWB5IevB4FQwn3xuV2h3NNt+6uItxCkKLfWT1FdZDl3cv16u7Uk5JPOIj79e6ShcFA6/DJcM4tNVaHON5JnBW5Z+f28u/yRdV/DKk8W0bPu4Fs9FWPZ/2wcjUFpdayjUr3lgSMCIkGwOS42L3aEYDQA==;31:N2OMhjAconfgoZ1Q//25zzxIcX+Y/VNwa8l/Da6h6YPL+ZrrsmBz02v/3RtdR5v/eE2GaPJnuVS3wbMHvOCT2amm0n7RZwSo3rqQ7jybkBbFTEL4iP6HQE/AhpddM8qbHEhqXk59u4013XV5GgpFefWaFkj779xi6Vc3QfBE5lqc5l9JnoHM4ulPGxptLR4vnmka76rxzgYQIRafr69aim1I2Fmm/A57/R66ul99BWE=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:i/A4r5le380KkvLpncF9q+rsjDHk226cwWlZ5pTM29TgbA+X6xe3JNsLJ2bol0g5g7N4bEPJRxvT4A4p6WCy+geK9GAbZ7U/ydGWRgFNpe1gPzzqz0P+wUzJxNQG2Tzsln3rKneRMQS37lg8sb9GkwAJjSExob86+e4nNsBoyAhGvQxEB0k4vdDW3d9TDeI/j8od8wgB3gY1ihBo3gri3R5IHzsyCXmntaoOPMednjiBuhCmWxsZt2oTQfXUu+yuT2Vg+PCIhKhruyj02+JG9Im8NpU3u1Soif4cZM+FqfkMPzOeKGvsRMRg1sKUW4T/c/E9H2maICCoQcbBO4DgflDlNPu98IxYTcpTl8ru+m9UxMKKsmE1wgNAK4eenRpPPUC+FAiu3vkp6Gm/ho2HPBroU0NErZGmZYrs9tM9wo9UWiKEShXOmGuGv0jpke661iVM4DoIH0y6Aj+TCu0ZJP5SwjwoYxkFi8S9kQrTm5mk2rYsL+ESgnrCaCd7CkrW;4:6V6UvRUex6yWarsvENvXU7gZHYXmj7c3hF91rkiufn3QbePPz+CSPmbyVu3I0MA/4Q9Y3CkVI5CSoW+o9LnQOtmE1AP1XMt6x9rnV6UoOzL1n3umVWVLsMcDhTx0VydB77iayK07FLGa7O2rmkM5kO7dBFgHoz1SHu5sH0pyUcvIgU5uZWKFDGMnyr5+x4rlRsFDqBKRwQMfe41/0nIDI8WWxjE4kE31DP3QekwPS6MEK5Oev9U9oxBjdCGutZq6aOXselodZMvXgmiLzdmF0CJAvUonSjRbOezaQHv5NVYfTUxBP+xFjB011+Qh5wqd
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2418E734FF5D00A8FCC3E1D7E6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:4QlPQmBWdACHXIcNAZlW1Ex7unW5pEXOApDd5mw?=
 =?us-ascii?Q?xBcs5EnByKlJqQ13Jo5ow0ryoBbzYhGZlfTwvszOXULJfo7qf81uJz+wIjF+?=
 =?us-ascii?Q?OjHE2C2azFPHb7+gTgpGSVceenbX5bnvle8HmwykzwdpDrNAd+ReJVo7tFJ9?=
 =?us-ascii?Q?KZ8Yz2dsdUQ5zLvnSfK0XHcmFu00EKSaHP6HcoMbhswcONW4xzK/Urln2o1f?=
 =?us-ascii?Q?NlcaRGIrE++aycv9rsNKtPFfgEmWlEyyZh29myj+UW+/oZN/Xg9bwlqncRqb?=
 =?us-ascii?Q?bSJPobkKM6W16MJGLNWuTcHwjqmwEjsk3Puvt6ZczciQfnrf0nWeag7yEOF6?=
 =?us-ascii?Q?FU0AZ7XK1xUwoxFAZvqmBH9WPfuqLj2pPzOaoxUWxNdAObd9eGXjQ7Qfa1LN?=
 =?us-ascii?Q?9CLGhMFK8jllLDIFfpMcW+PfODM34mUZCf6tQiXu27b8d67t5d2k28rKgDEx?=
 =?us-ascii?Q?BE7fFtOcTAT01PSWAbVdELYqSRRTrIMLcdS6CimhxToQp1PW+VXFiex+UuZ3?=
 =?us-ascii?Q?IoSHUMx1hoHErswwC9y1tSHMv+vSsUwh75shV6HTGEuXTRUfmd7Rhyd87mzD?=
 =?us-ascii?Q?McSRYbAFoDS40sksiRVZ9tWfIBYHYVlyg1KRRUj7qfxZVr0xEz5rRRanecxh?=
 =?us-ascii?Q?w7L9rJe+h5vt8bGfZxIUuVEfsGfTfDGn3LuGOISneMpF1tfYnsUXRo5vuMo9?=
 =?us-ascii?Q?Lhn37Fd6D0OkI7coLxQCbw4Y76bTKj/VL3KdOyffoKqDUuy9NhJ3J5lnuZ/h?=
 =?us-ascii?Q?e3IqQ9otvm4ssEjCp0JH4eVxIc0tlrxqLBWFdp8UdQdf2s3mvwontGzS7sGQ?=
 =?us-ascii?Q?2AWfquXg9QYlmuTKmTvpIUxlDYkD5IwZgKRVAGz3xVoECZZbPhtMgnnEsBLO?=
 =?us-ascii?Q?nNvrTD9BnFov/UNL6jrJx55M/gC2uO2bKvQSVzTxdpiX5PwzNN/AS3uiBrnP?=
 =?us-ascii?Q?H/ZWnM9uyNdawDKOTiVntXG7mjHydJ3TPZ2nyAb7CwxIvUdERGYJjNfao0Ol?=
 =?us-ascii?Q?RTwK2bK3qySIRlS6BaecSD4Ou3WY3HoXVuKqImhFoIUtQsRjMQ/cYBgXKkIu?=
 =?us-ascii?Q?Ukl7BDJ0jqcFRY8QJKb5rQQx/Bp1Drn8/V2A0tyJA/K2l/t7uEwAgC0kb5Bx?=
 =?us-ascii?Q?A7NjZvcDQQ+Eih12tWPy9tZpT+CWjgqSdU7msHKpH+C4oB5EHFeplKNbwPjs?=
 =?us-ascii?Q?596BE7vur/zQw0pnluKsP6skdLcPzBp9siVfZ0YCEtiAOIrO0uK6rpI5eMGP?=
 =?us-ascii?Q?iZG/3ha0F4hiPgl22LDSxWHSd1gZEDIp9X/mn/WFaYKUjJwB77+gDw8YK1ih?=
 =?us-ascii?Q?azyQdfBeSGFxZC3YQ1ms41hk=3D?=
X-Microsoft-Antispam-Message-Info: lYgkDOMBGyl+1LER52veap/9hgUEHsAgdiinyEyR4SoBFLoLCP4KA0Cvg5TlOiSBFBOA0q7ZBId1eoIyVFmUEgmyeLStG6mhx2bTW+bZkgM9FN8vy16TnPY/ht5x17uYcYeVfXxGb9Rn1DYouessq68EPGYQ2AqAwlJv/U98phjNFdRLHWmMDBzoWrSrmTVl
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:NdausAW/l7HtwI7vpL5H/4pP8vf+tJELkOnjA8MGkU7FNAd6eqFfWiPnPTKzxDfa+McUkFuVj3USCYoPGLEsSqk/3wTPuRP341ZlmzqI36NLjupOZQWZOKj2xmx7kUHZ0ejYM1SuaukOw5p4sx7l062Tzd0n1+MrAhtlrUrc+vHdfV3b288TJ5dFDfcawcOPl1JHr3SW9jcvO4WoXTG3uIF/lP1Jmv3I/m5emX3tBXx+jhyIDcvQzJoIJ4HB28COOThHcvD/OcZJv/MSivHRBYudkyVemHbYCGXoiFHDMaee3Q+GagYNDRmThPsY2K4m9n5a8rWJfgrSfoAJCL5R2qCZ9LtrBbkNgqi02fBehv0Zm+IO8koDHiqcXtykH7Ok0y3E05+Ks1ZwxHMCWcDvHkhHr5kflWTg9vIz4u9q5kd+lE3Hx1zz9wr8ZiGxRfNF+A3niGfFAIu55gpLDJSS+w==;5:bphumfdJIE80Ghre44kSHceR/dPHGb55F4SsTL6RFAyaXf2QwEzjG6yBV7HwWgYYM55XoL7hGwEsRWyG1QSf2/mGLsvqxiRudFkJdYmHfT9oNM6e9uR14tlw7zGRrC/jVoC7mfqhD/jnV2Mw0uKluxZNIX1WS8vvHJMDsCO4N0o=;24:YZeCz4SNdeY7EJrsXarlvoYAnZaTpeSFzPCmXb324prou26X9AbN6pAPb8qk5CP90ltTohiVsMJ4QB7az8JVlPWZqxGNpl1zDs1n8U6ZP0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:yR3XtDFLU+BnvI7ECPS0I2w87KNndsp6Hf4q2qNT6fEaNNXhDn/5eiqm3CIdgyCfj+VpGV7ONLiTcCM/QRe2qQUTcaKoNs6zkebSMFk4GEtUEVSzsQ/Lq1bsaZ0Da6b3GVKuE6u1moD2dMTXHJwdStb2V5zyClMkargN9VOKwS5dMoycA+v/kiicz8o3Q5wSjnD9DOrP0i1fGockO0FZNwI610p1jWEpGIU7B8pmKXshUI3l5M5YNUFOwamz0sKI
X-MS-Office365-Filtering-Correlation-Id: 3aea9fa4-f3f2-41e3-5193-08d5ae63992f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:29.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aea9fa4-f3f2-41e3-5193-08d5ae63992f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894775327119081?=
X-GMAIL-MSGID: =?utf-8?q?1599151504365293808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 811e160..284474d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
+#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
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
@@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
+	} else if (dev_is_fsl_mc(dev)) {
+		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
1.9.1
