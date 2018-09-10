Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D5020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aokmMgIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D5020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeIJSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:44:59 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbeIJSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82G95c9pC1Xl03/ubgEUrmP+7qVW0vR6KbsmJmk3Fdw=;
 b=aokmMgIl4Vx/718t1bZEd1Ilu7KHJxCWPZMgjHL6rOTnEYGakv4H8GKxA1tqk8rmefpfYCBLh4ZDSZMj7XbmYDTcwSax0AzKH0xJrAmSxzvWnPzFxzhqYzOAH6Nhk7vgeM1cTMtJxxR1Z4Zkf5VR3xGRarcSI3iCf93KqZLajH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:18 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 3/7 v7] iommu/of: support iommu configuration for fsl-mc devices
Date:   Mon, 10 Sep 2018 19:19:17 +0530
Message-Id: <1536587361-11047-4-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4bc69f5-31a7-4007-2d0f-08d617245a79
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:iqocZGx9q0AoV4RADre/IodDuyd750gKIZhkg/JZZvd89K1BkxxAYlKnbtS0w32pzJwFfsSZUt2HOn2sTTosmQ894M5eB/0/Mex7P/VSpRE6t2WMQksG9nRME/3PZF2JwRSI8B0s1OZuz5LY+wveOQzRM5qQWynN+AoyMm02Xh+OE87yd1xVVGXD+IDtGNuo76SNRqTI+qnalqxoTtm1rWJ/CWW8khNupylFbnZv9O4RDKbIblSmLMpH1kwRZqSh;25:U924Fw9BMxs0fSIlpPPE8h5Ziw5XTOTTdKKPPBb/SlpzLPAEhBJmwEfhwKzZWNeJAhR8YtLezfkSPILi/NzRO/DZtC+x1lew8F/Q8EMKWpSB4y9LiDuhDlzqyEcIt1TAD2sI8UVyd5z39v3JAmsBXlZ0WT++0Pk4JnpnwTjf8aEzEQ1fWjEq32uYUJw57x4FlaSIT23P1wEjnQvo4/1eLMqYoM7zryedsQXDmEb1S9FSMQO3jwbqOjuLZ+tov1uvLylYdJMMuvFs6XIF4Z4Hopymr5DCHqAf8u2KHIj8fDfrlMt2o/A8dDnGd3ZY2sjDSuvZFwDqCz+zCYPmKr2HFQ==;31:/M97ihTJoHHmUak8BAQtbxRyJtVn8uXIlbiLxZoQs2DazujfejdC788eRpSwQbXEp/nIL5n96GW22NghXESzxPLEeN7/1BBnzb5fvC96s8sLF7+ZHgTxS9DkwclI4/RrtVgV97JvlhNWZl2umGJKc4eBiAns1+m/WGwkdaur4m0ShfhnTdFu6at22RRq6B1tImNwDJXxXK+LfwAla2ZoGae5HPrP/ECnY6GC+XDEAzU=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:vMN0AaFf3yoGpJlxJe32bq/A1YEsJ/fU+efNjdX1bRbuGH0+uUIeDeiq4jkusD0vB3quNysi2lU3mWwqoPxxPTPN0u4CUzznErmrFHZ9n+JLT6jK8NWCqxsYQXRiO4cQfLPgMjjd/h9jB1onfaaFN2wW4HjKdb3AR/8dbStfMkvg32GX0+tvJEMPwcIjPoOcnJBZoASfv8IgQa1XUeXhAG5BeKfP2g2nT5+nFXXLINYd1Fr46dj+YyjVDCJREZAib+jGISiM5GuorKCDhyaJPDKdXWhIiR1yYxUCNNhMll8YjooA9DVjPsBOjE6esZhzgIJrq7FuKZLCGCDOVv/NO9FnOvW5ivzIjrDB6Rb5vwYkUcE8gXciejGI7B8H618BaFOkKR3n6s7CHpRQaT8j/qqvMdFX6P4KCmi+UVNEh2JPwR3A34Zg326pIQZH8Nc4WogJJFONusJhtcJAjXiH846lE/HAHvlL4smWOjNqTD+NJ095mCHm38VKgTV9Kjyd;4:oCTfWetZwHtf0hyZxzP6oNXsbeenD7+jPz/zcuqn6ML0JhwQuthmRgW0wX8H4psOWBEcHse6gcAL0FTqYFNpb+aPkIO5yXAdJXP0xq8CB9yLbiu127FMw6eRFym94Q5thg67pKZwq7b3tBkgVeM3NkxsOjo9psPIQl6v7R/6SkiyVs185NWENSJOq6TglLFJISTUcb0Sga5oM9QROtYWHDB4FdXv08Bd7FbByvRvok4tn+XqblrBzUY7eqMmekFW3Vke++lGsXF02nfGcf6SPanBPadQFupe716DIH0PHikzwBmP0I2y+yAkxi9e7hn7EvTOlPnRZyiNaxyySEr0S63vaPZDWQXr9Vm3tnADmhY=
X-Microsoft-Antispam-PRVS: <DB7PR04MB4476D14278DCCC207E84103DE6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:yKIC1p+8Uy7GU9Ac7/Yuq8LrIfvpeEvj9fnFGjTyG?=
 =?us-ascii?Q?bi37TKVFupsTlw0vg8OAIMEDu1TlyeQrseYTjR8dtpyH9b+vUQAeovkckeFE?=
 =?us-ascii?Q?nl1w2O6AJd/FXXHPm5feliztaFZQjQj6CY+hLsaDoyqru6lk41YXYES25wXJ?=
 =?us-ascii?Q?HpMbRHEqNqzOg8b8Y5GCnTaZK1ARXL1ednBidL58nB1f3VpOAL8UWAmz1X6z?=
 =?us-ascii?Q?FRdfgqAMUnFQeCR+sTWEzWMDjMjWr4a+Zu/TpVU/DrMdD9tc/xajviUY56hw?=
 =?us-ascii?Q?VqSQVYmh7Rq4sB+UyVBq6ytOnhs3mOXU7As4q6LVwjZ1ItciGwbEbEWFf/G3?=
 =?us-ascii?Q?dsbc6DjLxEtQZOL4p5usPDW1A9Xq3mC4hmeTcouGbRPWWam/+MRn3IGf6Tb8?=
 =?us-ascii?Q?ldcADkPAFQC1O0moAhT+Hw9NiN/CukuitoiXrP+60X6PDCR70K+XFEUbYZp8?=
 =?us-ascii?Q?zsmDVrld3mtZ9kdEFYsKw8rCAWuCmyQ3jwxqH3zg/4krWygL8h3rk0e7YDXB?=
 =?us-ascii?Q?WLyHhEZu72KnOtGurAXJ6McBqkeFHk5GlIy28v+AWmuyX332lnj93W+OYYsq?=
 =?us-ascii?Q?0lGdPkMnybAZZsWOAW1znEiaq3wbRZQSf8Fmmw4jQqpLhL7phfgxUgvW9rOt?=
 =?us-ascii?Q?u3mkgxul9VdR2jeq2k+//rwQNG2qS6CxZe3WU3HEuJ7hrF/qL9OzN6q+VRir?=
 =?us-ascii?Q?1l4EYe7FqfUUrZEyEofn9AgRgRazrnwdKCwYLcau/U7+1p9BgtM1brrzAdD/?=
 =?us-ascii?Q?LHG0tDMQJMAirgl3aoRMq4gPExrZVSSll4YuNovUrzpymazc7B2MIXsXeoRg?=
 =?us-ascii?Q?SUTPe79eYOcpcjtEWJqJ6BbYgYMb8ZywZmdtChqWeKoNSiq125G32X+jaiwH?=
 =?us-ascii?Q?C2YehIa744LH5fSazWp70frFPuagyh8uW35Ja1qP0oW5u/hWm66j/HpWGRYB?=
 =?us-ascii?Q?pCy9/2DBsGGoo5Rq55t4kzIu9SMYfLtegGM8sXv4nD/5JN/pindKK9NtWrnX?=
 =?us-ascii?Q?UDrpX615ZeGOk/xb/zqvBERYFL1rl//3iVoKwkv2cAv2sdO74Epg3Wn5F0SB?=
 =?us-ascii?Q?y+55lBuGT/3mNIVmh6hT6cgsc9/hwfvfBxvJtTrmAIy3Gf2rMEwJ3pkttIwg?=
 =?us-ascii?Q?n/t7Vi7uv1Z1MM1cl4tWQFs3hpbUuuAbEt7wgyBn2Go2izG/FUxmp31cS8uI?=
 =?us-ascii?Q?wkEY1DM5clp7SjY2/zUr7fu9Zkvq2xDfoV4WwGNaZkRO8ggHlq8oeY8tDDSP?=
 =?us-ascii?Q?uUjquneq7nRkzWXVwdNygNcxKixYL5f6CBeapm9HGzITU4u8V3KsatNUd8p+?=
 =?us-ascii?Q?/C4AduA9mfnYdnMgxnWU/Y=3D?=
X-Microsoft-Antispam-Message-Info: 7seGbyTQ1k9opEnwnbnIAYuIpUYPA29hBIZOuKciZf2Jy7IJtYZH+UmIeRKkJVF0MGyt4U5myhO3iTXz+vfIKFSZsZDUF5IPRemgqjIgSDXYKklpLxGk26kzlHHdkVybQUyNEIOwMbqjiGXKdI+1eOOKJEOMGersEMG9aRCLu8HJv/djjaeeSm1+BtPvJ8IlNGKLVONDmSIl9oISGiQRKXqOQtuCoU9xs0k0mSbqwHmV9QbZWTTdd9Cms1mxMNvTN8u/RCqZrUib6pWz1m9HNFjj7cNvPX/z1ztF4SrCFtYCj62MGX75tRp4nY1VrKv1OFI8mH3fpwvgT26Lcy3n70AqlUjN1ZM8bjJZyvLN5J4=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:8i9UhhJFawqHkFWfT/yYelnf9multTfSt3JdArlq9RjpU5Uqb1mtPqnPuVzF5WS/FqQBy94bM2wIZVFQoZbA0ZZGjio7CTRqsGuizXXPqqJnXFn8VwHqn63jopJStphZ+g8psNQaqGqqb+sUDUcW8FaBbsHdRoFj0NqrZUE1SvcX5OSXNB4XHE9fBQN320ZFPSO1i6u6IF7HDahwIbOaPlwfa/mf8PGvjTeUdrsz/O9SzcJFB9e+EjIex6lRvgpGxPbGvOPB00hQqZHR8FMas3GLw6GnrDapYS8rjTV4DMOZg8+CrglwWwPoLSwpaXwpik6mRveGV+1U1UMmeQFu44L4Fh/e3TNmOq+IIQXO1l5nzLphjuSVBOVsrM3g2x0KUGT7+SBv5iL1moCjF9DnC3YpLn1r5LSdoLOGn4Ho1YMwC69PMSgodhmYk//xuQbR5fB7A+BwBCffaqlSgE2McQ==;5:0uLCloU/hz6FZWWEZq8LX1a6Q2mwEWxDBr61/cblhTfL/FEcARZieBoptCqM6uzayWbU3COKi9ecxJ4SyTbjZpzxVErxjbMUauItifB3aIFrjUcnquiayJRoevUg2TmxYdQKRiFz4JI9vNO3XThbWvIeS7/QIcy46T7YIEOWH0A=;7:uui2ykKlOvBJEULwXZwolJeRwWR0oxtdS4298eCs5Zy9Hz/tQgLJjOcp27xP3nqgrzrVvlouZZKuvbMgmNP0jhonUFtWcnyVCcZWT04Gm+wsEGDOHXL3kN+2edeqHlrN3BRFKMq6cHEgrXJiJi91pR+NK9CBU4FvUCiw9zsmIcChd4dF9rr4bVNhBp/2u/HriCukV5dv74u8aznkR+2jBZ2U45oAfZGCYPe7cgnnrzhyMt1zLWX2eqpiMUR1OPua
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:18.1826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc69f5-31a7-4007-2d0f-08d617245a79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With of_pci_map_rid available for all the busses, use the function
for configuration of devices on fsl-mc bus

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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

