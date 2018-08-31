Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FC520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MS97uu7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FC520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeHaOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:38:54 -0400
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:60224
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbeHaOix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGHasaR5g3WpOQjTgENxMdhTIk7CmIBT1snjoOPzrJA=;
 b=MS97uu7N6CxIooUZfKz2UbYJVDdZPDzmFqKXO9za0cn8CezBIPFop/7RsK14OhocoqacvJNVVjeadoa/bvWCnpQyUvCtQNhI90TEmCmnbLP6+ClAxPevCxPTaYfRgYIo6sLO3q0AsmhAv0GaoeQQfI0J7jbh60Uw4rpcR4/s0Ig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:31:54 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 1/7] spi: add slave device size in spi_device struct
Date:   Fri, 31 Aug 2018 15:59:58 +0530
Message-Id: <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::26) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49757ddc-4756-4f89-c5ea-08d60f2cfbab
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:UC9hQKX3ihY/+qKJ0Mw999baZzIssmO+7aBxugJtse/CRsfCN7p9bMEmhK2FJemca3SKb8KmovdnuEABwvLRlWU9ZZLvgDQ0RFIGVeu+qtHJ4ZTvxhFtFH/PQYYAFO+NHKmIS45xyRt4AebL2XFM47IAd7Qt7blWIh5Uk/LIzqfhzJC1hiPC5/KVFaA6p3eurfc921EA4bm2uh+TxQOlF1YESD/zBUzIKhXp8sVXGsj8bODdVQDEQGiXLYdTBzGK;25:F1crNceLY1S1+5mvcOYocKWJwMVK0mE52L3run10rO8BsXt9KGIYmfjt9SnaqfkgWebbe3xHiAUneAld9gtXVmb+oHCENXeAFVT7/2yZLgm7y40zvsn4dwiXgd66g/+jVsbDbXwkx4yjeNeIJNRnIOzKmjJWAMKSL8nXj671fyvqgKAtX+IQI9E3BZHPtga3NfqDUzOFJrHLrnqCafv19v/p4Kh/SHgtfqMWWcC2Vgl+0fyycFwLFSg+CW4+Okdsc8w6BvzxjmTzgh64ToJZiY2pom9l4UgKWY8n8DPlY5DFxZzOdMn7hbI7IoE9kf4U+0TrKq036J6lWGlrMWyDOA==;31:nl6qxbYjbm3XZv02osruH3LFSTcnJpCaTq8gQ9taqHAZQb3lA2c8hBARk5G6pMdAPPs0ynuXlAQviWm3bCuW9kzbijA1p6gIyC6TWmOtigE+8LTs/+A4j9P0SXCby229tOFve38dPIMO4d62tUhsY2hL2MJbfHjUaunqyM1sAy3hT8wam8z88CuX/A42GbUi6l8tIQW64OnONre0akJc6HkkmtJT+Ph/voc6iEvc7tE=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:0zjGdKr47bhau3okowKvDk53x6TMiyrEgq4rg0h8CJhf3VPVHGTsTOtiLRFcfYeEk6gaZF3xESLSPg0WpTOjdEPfOHgH4zuWTdHdGZ5Yw7pAk3nyAqXVsbcn1Gqe+EPZxoydh5etV79Cl5MjY3Pre8IRh4EqRXIRGaBJ3EP74igPPShmPAbehin9VBuZjvEOrcKtVQ/cgrUp/9TtUwj2JUgjhGAFblkuPQeo7iRwpddwCzvxCD5GZlhHuQF6dsxNyZQAZ2q6DeEzAyaja1UnhoxYvx5JT2VSpDkK0Q1BC/1o0PPxS78iP9g8rYEUN6EhQkQ85Gr13LEvTaJrL/1GKw2ERNsRkbID8RI1R1aVzqXncB9/O2HbnlD6HSCL59jPg54Y5NOjNYCRPhUkJkareZSi7d7QZHw/wcsNPK6N1Hr8bNA9/8ZyiZJtFe+dFiE+WvE5ov0QFj+X+8umDCtaLx0nldWw0gS+0y/8JgIE3qLwgb9cmrFqy8f9Mnvz8pId;4:vruKJuV1y6+ebkAMgTV4VAXICYUXKzOVdtClFJ6xO5CQ8fXHwSWt4yb0J1MhX8ZDOGJ2WBKIqwmT9DhKHvGkBLbeoilU3pfqm7Mi26A9pSC4pX4AiG68Zc7+WydkI5wOSV+YDp4fvYkE8eRpzjtlu6GeK8AN6v+DjNf95R2uCnwIz+/3zr1WwpXf3LKcILAo4dUpwVIT6nbpQtKbalcyiyHX3F1zmjW8DQ4YuDSa0vXw+sRU7eQMgib7gy7+FlkMQcIBWEiwG9X6GjPanXroGChNKd0QtaGNoQ86JAPJcPVkZUvNrS5rJexzBav4WUMh
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034D45BE4187A1EB3C9B5DF990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(14444005)(316002)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:li6vmjADdXr3zBWzy4CNL+uxONRwrmlLS6xAopXWY?=
 =?us-ascii?Q?+ESYc5Otk87hUDwp07TQ+XoSG4uSQnfRcwz6/4Olsr6Mi/7I2Z906CHkhb/b?=
 =?us-ascii?Q?maPmZKMxN10EQkMRux7cNd3uLop2In9upg8eoSJzof3B1FK4MNfkYXdI+ee/?=
 =?us-ascii?Q?2ka0BaDpE8iJjA5E8V2eEkJNqE+bUmgSU38MRuP8kj2UScvJL9VCk4be/o8d?=
 =?us-ascii?Q?hFZplSXBdfvMrYKUzp9TcpQamqADPdD8cTpCojQdYBxnIqcmusISQl2YEqw2?=
 =?us-ascii?Q?1BM6UoptfIZvsqVw2x17z/gIFxgNRuRporuB3Qq1xHaom3ys9U/PFhFo/hAe?=
 =?us-ascii?Q?Bon1oRH9mY5/ZZw8C3imO3he+v7zeq4oRYtmETSr2R8MBz00VufYxB+NPWt1?=
 =?us-ascii?Q?DguePDEuV1IEP7b2flZ//G7TCKTn11XyeTd1QVOYv0w1jngs8N25m2czY8YG?=
 =?us-ascii?Q?jEdc8IRDaIse0L5KGDwHvRbTqd1EzJcAv/w54oeR3IP/A+x+4qdL7N+bNyeM?=
 =?us-ascii?Q?xNttDLfPMORCnlrR0Su8XicS9Fv2s0mKYW1/ieXoI5qWezArHvfnbA5hFIyl?=
 =?us-ascii?Q?KGrKbPmv9NWXauc/LKR4Rap3dPxZfQNm28ypodBh3fb72iIJrOxQh24+HQS6?=
 =?us-ascii?Q?41qmTa10CO1ogD61GLFPiUNk/r4Cnpk9oH+AoLgNpRs8GnGS4Gb9xQamJXRp?=
 =?us-ascii?Q?RZ5AF0Z/OD+kpRXejH0xeXkSbmNMsWKHXqiTZHBTSek9jH7CXSWVWJHxPBRq?=
 =?us-ascii?Q?kbhn5byvXP0AcD60dRvhY7ti4p8BLIS0gc024DQsIGk2uhvOuI6zLHkT2hL+?=
 =?us-ascii?Q?LPoTXVsRxuS2Xqp1ptSVg9Pt7FUZa7cz1Iul1fEB1ljH4rQhsn5PR5jXGtpK?=
 =?us-ascii?Q?RsB6RgTpquQmNJ3/lpYIOjm+pOAU4FE0KpIhOa7saN9x8fRmSNdSyAoQTzZW?=
 =?us-ascii?Q?swIFVKktSyWNfq8c1M3nnBTDelLcrZ3xvBzxRVy/Dw/7Qirdkykf/IMF9Vqx?=
 =?us-ascii?Q?S9fkOXaO4x5U4/voberBO89X/xg37iznsvv/v3A48OLVS0YIPcOL128dElAA?=
 =?us-ascii?Q?Dl5FBsHqugsWO0Pzi5Z6OeZFe9RkpUt+1K9X047pvcsPNLOuc/9/SAGOs7I6?=
 =?us-ascii?Q?F5tKHUZZRanqbGMHz8mwflUyzsSwDbeiTS2LhU0HjspnXbfr1vY5XafPZJ2S?=
 =?us-ascii?Q?CdJQJMMP0eAOPV3bdoYUxEZJxxfs3PXGaTF3UU1y4SE7HtNqMxTsLEcqEfEU?=
 =?us-ascii?Q?6brjQ3G6rFHx8Ygi2w7l0OovfN6C6sihxNj7nxu?=
X-Microsoft-Antispam-Message-Info: h85+9sFCh4lXwkqyRjZPYQhyuYGDisOiEbQEM0l2MuA1GqhrGmDjZlGJEc+nBWpLVGLHzWyU7FF41Aa1/cxWgBYGxPLoDsbFyFFzPrS6GhzgxfYEoZagqrFZMQS8+Um2mDcyb9krwEo57C2gXNr01/Ks5DIXSWvmRr1YyjJGfdy4BBEEqTVGzG4OCF4XJ9s+9EPfVJc7/LUJHjozbV65wR078qyuCmI1SxsTvDo3ZFv6hW4jA8xTPBAeCIo6kZdAQPfKjBNj4TY7M7cj3prfX/jHRs3dzvb9wfVLAc8e0OEtJcJtBwWPMnyOaSZE2bMgkUzHDVfKY6qcjUCmlCjLBbzhEdDielBfrZsV1HODG1Q=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:ut2AgHpKVUJCPbKaxWt4nq5ZEA5fe98hAz4/NVJUSgD7cyEXUtpDOnHnUrainRfwps2aJk/f4BxuroJ5OuMbuEa34s1py7+QfYriW2VwfOgFfzB6dvz/YhTNC1NTmh6IFtKP/+WD8KB+WKYXV/2rUcw+wyCV6/oXv/DFMs1nqC73NHnRbuf4teaHyz/muVUeURaXuuVoPTsLSR4awg0w6TaGeX63rHlAqRDqEEzD1t4F+ceyRc73s0s3yw1aYTxdG6vw/kUX094xB2RFsAADwzgZ5tpjWDaxiUAAdVNIFEzlMz3u7f9X8D/YcUQVGOgayOZh+RYuM7azpTaaQwJoVYMiC1Jmd5JDCqOttxFxtV9A2Ekfk0mkGWdhnguRYR8eqPqixdWNefDTZCN9AcdUPzOKMctesFs5z7/AO4Vj8Hrd5bSSegrETSuuDGi+iQQzCN37H96PpWo+yKMuAu8kiQ==;5:uPlHCviO6NexsVYa5/q0c2tHwDtxrNSZNdkKpv7SE2Lz5lOtwNqkOJBMmlLgO1KzBYCgIxny/9qI24EBT2Bg0a5un867xjBTQAl+rC4JCAyk6aJrOKJ6mHJ6AOGlsvSy182VWCR9XIV4Fc6Tb2SqeevV39IpKZ2BVJtgxaVW2ro=;7:d5oMjxIi246K1575SesKJLKdfPSxF0e9ZUV3LE4UeHFHdBB56K+BfmjHZBf0BNTL2FdMpsqHUqEl/mdvSZhL0UIEfpSPvyWeQZ282HUZY7ZoB5nAHfb1FE/P3imBn7hcFcXG9BMOaAxsduZh5xAyqL3Ln87aN4cWC+quj4Qg/31RACsUoVnWh5soBiBF6KhYGRBmfOxSJz95dApGc7cI384Ey5VOY3H8uHNgpL6AlV7LhV+M4ISGrdtSQrucEI7s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:31:54.9195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49757ddc-4756-4f89-c5ea-08d60f2cfbab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'size' data variable in spi_device struct.
This is to save the size of the connected slave device.

After slave device scan, spi_nor_scan, size being assigned to this
from MTD layer.

SFDP read is being requested before completion of spi_nor_scan()
routine, thus populate device size before making read request
to the SPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c  | 6 ++++++
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 include/linux/spi/spi.h       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe260cc..6c7ad86 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -124,6 +124,10 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	/* for case of SFDP header read commands, populate spi device size */
+	if (flash->spimem->spi->size == 0)
+		flash->spimem->spi->size = nor->mtd.size;
+
 	while (remaining) {
 		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
 		ret = spi_mem_adjust_op_size(flash->spimem, &op);
@@ -215,6 +219,8 @@ static int m25p_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
+	spi->size = nor->mtd.size;
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6042df8..b066bed 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2864,6 +2864,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_S3AN)
 		nor->flags |=  SNOR_F_READY_XSR_RDY;
 
+	mtd->size = info->sector_size * info->n_sectors;
+
 	/* Parse the Serial Flash Discoverable Parameters table. */
 	ret = spi_nor_init_params(nor, info, &params);
 	if (ret)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..558aeed 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -127,6 +127,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line)
+ * @size: size of the connected slave device
  *
  * @statistics: statistics for the spi_device
  *
@@ -168,6 +169,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	u32			size;		/* size of slave device */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.7.4

