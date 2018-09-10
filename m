Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1291DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAbbWWxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeIJSoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:44:54 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728635AbeIJSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngj95YNmm4wbigjDBUZoc9Z6XrAr3QNi+1Mnz6jA708=;
 b=nAbbWWxmTilhgveT3YFX+r0ERfmY14tbTZktWV2+brgaq60yq4elP3EuK8XsqXwEB8+NXDATyc0SPA7ikWE9baTVR0OZ3O++/8B0vnL5KrQSOPHrwyz1UmdeykEtss1+lkWVsaICErqCI4rkiYmz/CvuRcFvPyNP/gp8J5DWhOQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:12 +0000
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
Subject: [PATCH 2/7 v7] iommu/of: make of_pci_map_rid() available for other devices too
Date:   Mon, 10 Sep 2018 19:19:16 +0530
Message-Id: <1536587361-11047-3-git-send-email-nipun.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d61353d-29b4-4128-e031-08d61724573b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:rBkXZqq/0H+7qY8ZN0PWadbGnB7AL7dokQr1wH2LpHrBT4/D/K7z4iubvNg2t4QLJmPcmKatxtzdOo+nbQUgzBuxcRCAhFUXNlw3quxSFAx+Jx3C6vxiupc+BoEwnYAXRQM/KY8hc1Bv50vy72h3WiOwjpmQo6aA19iE6+pVBDvk4jFqi9XD4XDFTmXlwNCdORpor62Kz9G1nCRjX96hYrK5DBCjZosMuZlr18b4l4/Jf/kk7YchF+C/yDIK8ccr;25:/wReoJDKkis2i5hdXZZOm72z9G/pMxd4ab04W/7u0Lif2P9vLkO2P4NfwzuEqF5dQgbz7a//29wVgvzAiPfXVgG2w1BLlEYDyNn29hW5WhsJAskOylf0T5llfkrDlkZ2Wy97x+oeP06EOEvjLcJ5sBq5ANgwVvmsI+Qfq/au/lQrL8u1pMy80JlqP59Kk+TI+RV5eab2DNibS75j6jbiiANcOe8YDjg8JuetIrp+Fy0NQDyRc3qJo7HJnO0YX/rW3HQ0IwNJX8XRsSGKJq8ff3IfaX+fkxAZq1BymKx/3ecu/QWFcdhKJotavL512r9D4ePvB4qIY7DG6NaUADwBRQ==;31:LGG1+tbeUzqY3sjZyCJ7fe1v6af4NL8L7xzsU6c8vfDBfZsY5xdT9YxOnNTWmjl/NdJ1vokCNpdYuGNLQV7zIhr0ZgW9bsD1exIUnTXRjhDVmTSAtIkszcS5uSs0gfhSJxsnngKtHL7YPOhPR2nENEa6yIeDLdmh6grzjr/6HUpoqSoRVHY9AyY6BoB+/vT3ISZ4Rq668TqIkyWH4Sar59tawCg2XmlzCTQqxU7GVeg=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:xFIga6Amhq6O0KkQYRDOFe/OYJVo9vXWwe7U0DNT+1CFGCZBIvdzskKP4QWwZyqDWkNfKkIluXe7fgylPWmlRraTJMrkUkfA2oW1Ai0oY7A+RekGRRjSPbFabJyPix+YgR1gRB/sNmGVqBoCgsLeuOXhaPQBNLZX5oYMW9QFmjK81RypyYl/wHurKzgSiD2gEkeH0AIv+NvXcvJRX7kAC9sdLbpW0CdzdZoFdrEGvXFgbTRJy3n8e3N7RJb+ud1R+qvh7qXMgwtQSIgG31NholDxdOOo7txHKS6y3iaVUG6PL1iA1/+DlU7HRjKHFFwDJtQUYy+FXKKor9z6W4HvhwBT1/1sRKMJZAgBbZdmgpNEddwPpqMhwQBdX9/00ABqpARryqP4uIecwxPTIZ/w5qqkA79lrCVSqHBLuzJb0ktv57jKvDqizzeiKjm+Fn94PUlAOTuX2FNtR2Q9Ucsx/CzbqiSGGTkIRzwF993VND2KjJjiuT0vwVmNNwWlPIWX;4:ErekKLs1OTSW5B5upZ7Gl9NbQqBptbo5DVVGRg4JuOI223xQ6/e1aZ5QuYIKSyBPQgFko58lE8VQINmoTTqUdpYf41Opg/cBkCJJE2xRX+hxtop2fFhHIAjEFJJHW1THuq/VtCaYlMoSlA9eHxGmwCXYmrVqlgzERMwjRgr5NgZ3SQoZ3aEjW6q6JWrkYPfnehxB2FPhDch3d331PzxdazaNDHfxTDkB5pK61/0X6uu3HPsQcvoFyX2NItYSbrwtKk3vY0sV+duA2QsboFeF7aMEdMG8gZVZYDVDxUWm2wgTl4Gn25bH1NEULFjmNm0dPFv97+8hu7Qjus3FjEd8d+kRPAhOqSzK7jglSn9Rl7YlDMIc1RhhTWVL18//zZHKksikIfng3fi/iFyt8nW+pdP4+OiOZOj19/HT/9utDWo=
X-Microsoft-Antispam-PRVS: <DB7PR04MB4476D6DD0CDB3E32871C4C66E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(14444005)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:0OM0VeJUXVS3Ym9ImvjEX1RbOpAQUYi32SI4wVL0y?=
 =?us-ascii?Q?Al/GNhhLXtiSwG5ugytsnyTQGq79kGa5m5oZARhxLDUVymSEEzYipp+KsFd4?=
 =?us-ascii?Q?H93D03ciXL1YtQDLAIIWkYGlVHQDY0pbnTIb2qyE0kUvPRmPo502f4m9tpE2?=
 =?us-ascii?Q?lv1RsU+26yhsg5dpYKkfm7H3P20BLS7is/A46/10XaWlDOZrG+Tc3qCtKEuY?=
 =?us-ascii?Q?2jZneOXnI+ZO8L6+SVMxiXDJ707TF6IfFvf2ypK8HfGzYg/j60xnw9bn44Wx?=
 =?us-ascii?Q?Tu+h396u6jyvP+ea/o1KQx5W8v3Y5O61i9VSSaWUeF28DqvT4hADl8Yg9233?=
 =?us-ascii?Q?aaficNbS+JPOPsBBAYT+FyFRs+RHjRpS9eldM9iippBihrKugnR0RTqwRtgE?=
 =?us-ascii?Q?y+q1Q2rl7veGxxMmFjOYNiwsDOZrSV+yeKdvTlgCL8KgkeCxvyFp/QxJaiGF?=
 =?us-ascii?Q?xkb8+HSkfheXoS3NC1VJFoSTqwGYiiegunBlNVvXX4J32/UUnzbe2/za2we/?=
 =?us-ascii?Q?b9bXTjZ0WKgOBQbFeyFrRZbNZrNWcEjj7mMpXGclxASXU8Fbcr4UkFnKq9cX?=
 =?us-ascii?Q?PPF12B1PkKD0SJgOqBcHsTWeQ1zBbzX8EWAErh9pfNPtH15vPFOcs9Qh20Pq?=
 =?us-ascii?Q?UyoNVS5VH7I0+tnI48m1oByI4QBQTPW4QayapkIkM+zEtANkdcte1GsRNRpi?=
 =?us-ascii?Q?+ykNWDNa78DO+hf9LPXhCxLPiL36YoNxRHhrYk4C+y+vUSG6JEX3v4hziu88?=
 =?us-ascii?Q?JSPA9k3+8Zxt9fiimI9iZXUecovIYQVylkIvS11RapIR+d2fNg9zDjfdAbIL?=
 =?us-ascii?Q?rsaGM6KbYeA4Ik6NmYBAAMa9IgCW8quEkA9vhRxwaXT3s5Rzj8GrhA3LAtkw?=
 =?us-ascii?Q?UeQWNgvVcVOJxwVl6pJFuQjBRprHgm6hrKEF4TqARYCE90+5U+Ucqeq5s/pn?=
 =?us-ascii?Q?M82ACHFfzJf7KoK15zZW/dlac38w3SkEwlaus4valuv7264X9KsX6KnXY79C?=
 =?us-ascii?Q?7dXCa/KV42Qtm/noZ+HeijbXm0Are6UJV/qQ4BUC3wOb9T3IoRSpp4egwqdq?=
 =?us-ascii?Q?h0oCXuypVoghb0BTxBsyWaxGwrdh7s1AfB36WS01FXyZqSSEmhzKds13YfF9?=
 =?us-ascii?Q?4To42zX4eR0qodAh5msnStRkh5N6mIbfp5KvzvEUXM6pMP4H89N0KfEhhbl5?=
 =?us-ascii?Q?947F40v11nRDhHi52XBBzcrs2crW8O6GN9MzJUjR0xc/okjliJ3XhbJ5wqnx?=
 =?us-ascii?Q?FBb1qI0edteF9NzFRmRz2tYOLFEF4CDPaxdflc8qgrZAPNmmgjmtRrmlNnb1?=
 =?us-ascii?Q?8XbJ9RQJSue9GjleNZZzu9r+2983a75TIcPeMsnkHZU?=
X-Microsoft-Antispam-Message-Info: +zRtiDbKO4enDceaN7dFtgLEl9CiGTCPVRxLKU0hFJembMzvBYPE/UjjLpdpOTliE2CTKnW3kjs2aVMlIZwfqT3tcnpjeAi55tzhbroF5fOSVxnlDYjbFbI6ruj/8YWwrBhHMDupaDc1I3iqpHkUjFYGMFJITZW1olZ+frCfQG5E8zWk3MS+j3bXmv3NmRvuReq+jGXjdA9Yb2wciql82L/MjQnHrzU7U2KSo0LUfcnUGoYGD6YdQ1d4neY2wnXSd4v88lXPJKTdlQm7mvKsV8bADtolVspmdV3puV1TlGInOO1lS9zYwRP1hC7lohWGOCGM3UZst77jqL/sMyzS4dsewI5GTSFSRzJ+Lo6UwKY=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:2QhIlZJk1CwY+lpzuMJpTc22xjTyPGj/9CYr8/3Jt2L965dyFGe0GBXz3ywhm5uDvlW+yErr4OCSvAbiblLkZdJiWzjTrQvZUi2RZEJfS0MhXIKw2sYLUaGCKzv2VKYwjp/lZ2j5VPx49orgu6C3/iFxInnEsO/gRS38tZzKbFnE79OUAHSBj6kx3//mQtr+91s6W9/otOuyUI4dVhSs2l0mYCuRGe5Wefn4tQMnQPa+pi8SulBfcLxmmOXKMLOrXMpzXK0U2M3N1kgfgZ85It5oj7whvezEFgF3iLV8H8OWD4hxv3vLiuc8SRHbrE20gqKHMO0ExMiJ21llyLtLvum6guRoQ2v3+ggIIUb+AF7XILqs5DgMdG/YLJT6i7zUdE8GjhYTrySP1rJSGsat75m4QY/FAIcgJv/ZfHgld/WKcU3LxfGRiuuxzJGIORjDx1+vDktxPZZU9g0iY4fuQA==;5:s81XLYQ9iP8GV2NeTmsHUdYB90NNRCBcwTaTZXCznAjjuvYia7nA+UCykDxoWDfhghId9AHZSH1x7/AO/o61FwKZgU1OpoO1PQSe/5zHjInyL4BxgCAqr2IMaZ3YiC6Ctyk2JRJWhbEUgY3PZH1HJ8MVJDqHye6KJp91Uwt16+o=;7:Ua+6gl3aXWujTyU55a9UJK5PdV9nAkxvD4PdeeVAUeWryiw478L10lu4vFCzkQ6r4FlR4lnjjJ6V2gCEBwhMcJW7E3VmqPflNdKNP5MbKezr5QYXWomnB/qe2BYL3CWus29VVozQYO64tl6EqnD8YwhhvvSwwrpgpZ17ZEVRJrC+QRmxRcbr5civK7n4qEr76MCk6mcGrBast4pX10CswKH3oeX8VET/QknfZGthuDHxYSIBrX9BI4FM3667KANU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:12.6936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d61353d-29b4-4128-e031-08d61724573b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu-map property is also used by devices with fsl-mc. This
patch moves the of_pci_map_rid to generic location, so that it
can be used by other busses too.

'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
functional change done in the API.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/of_iommu.c |   5 +--
 drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/irq.c         |   5 +--
 drivers/pci/of.c         | 101 ----------------------------------------------
 include/linux/of.h       |  11 +++++
 include/linux/of_pci.h   |  10 -----
 6 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b..811e160 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -149,9 +149,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_pci_map_rid(info->np, alias, "iommu-map",
-			     "iommu-map-mask", &iommu_spec.np,
-			     iommu_spec.args);
+	err = of_map_rid(info->np, alias, "iommu-map", "iommu-map-mask",
+			 &iommu_spec.np, iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549..c7aac81 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1995,3 +1995,105 @@ int of_find_last_cache_level(unsigned int cpu)
 
 	return cache_level;
 }
+
+/**
+ * of_map_rid - Translate a requester ID through a downstream mapping.
+ * @np: root complex device node.
+ * @rid: device requester ID to map.
+ * @map_name: property name of the map to use.
+ * @map_mask_name: optional property name of the mask to use.
+ * @target: optional pointer to a target device node.
+ * @id_out: optional pointer to receive the translated ID.
+ *
+ * Given a device requester ID, look up the appropriate implementation-defined
+ * platform ID and/or the target device which receives transactions on that
+ * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
+ * @id_out may be NULL if only the other is required. If @target points to
+ * a non-NULL device node pointer, only entries targeting that node will be
+ * matched; if it points to a NULL value, it will receive the device node of
+ * the first matching target phandle, with a reference held.
+ *
+ * Return: 0 on success or a standard error code on failure.
+ */
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out)
+{
+	u32 map_mask, masked_rid;
+	int map_len;
+	const __be32 *map = NULL;
+
+	if (!np || !map_name || (!target && !id_out))
+		return -EINVAL;
+
+	map = of_get_property(np, map_name, &map_len);
+	if (!map) {
+		if (target)
+			return -ENODEV;
+		/* Otherwise, no map implies no translation */
+		*id_out = rid;
+		return 0;
+	}
+
+	if (!map_len || map_len % (4 * sizeof(*map))) {
+		pr_err("%pOF: Error: Bad %s length: %d\n", np,
+			map_name, map_len);
+		return -EINVAL;
+	}
+
+	/* The default is to select all bits. */
+	map_mask = 0xffffffff;
+
+	/*
+	 * Can be overridden by "{iommu,msi}-map-mask" property.
+	 * If of_property_read_u32() fails, the default is used.
+	 */
+	if (map_mask_name)
+		of_property_read_u32(np, map_mask_name, &map_mask);
+
+	masked_rid = map_mask & rid;
+	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
+		struct device_node *phandle_node;
+		u32 rid_base = be32_to_cpup(map + 0);
+		u32 phandle = be32_to_cpup(map + 1);
+		u32 out_base = be32_to_cpup(map + 2);
+		u32 rid_len = be32_to_cpup(map + 3);
+
+		if (rid_base & ~map_mask) {
+			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
+				np, map_name, map_name,
+				map_mask, rid_base);
+			return -EFAULT;
+		}
+
+		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
+			continue;
+
+		phandle_node = of_find_node_by_phandle(phandle);
+		if (!phandle_node)
+			return -ENODEV;
+
+		if (target) {
+			if (*target)
+				of_node_put(phandle_node);
+			else
+				*target = phandle_node;
+
+			if (*target != phandle_node)
+				continue;
+		}
+
+		if (id_out)
+			*id_out = masked_rid - rid_base + out_base;
+
+		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
+			np, map_name, map_mask, rid_base, out_base,
+			rid_len, rid, masked_rid - rid_base + out_base);
+		return 0;
+	}
+
+	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
+		np, map_name, rid, target && *target ? *target : NULL);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(of_map_rid);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 02ad93a..e1f6f39 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_pci.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 
@@ -588,8 +587,8 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_pci_map_rid(parent_dev->of_node, rid_in, "msi-map",
-				    "msi-map-mask", np, &rid_out))
+		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
+				"msi-map-mask", np, &rid_out))
 			break;
 	return rid_out;
 }
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d088c91..91600e0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -357,107 +357,6 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
-/**
- * of_pci_map_rid - Translate a requester ID through a downstream mapping.
- * @np: root complex device node.
- * @rid: PCI requester ID to map.
- * @map_name: property name of the map to use.
- * @map_mask_name: optional property name of the mask to use.
- * @target: optional pointer to a target device node.
- * @id_out: optional pointer to receive the translated ID.
- *
- * Given a PCI requester ID, look up the appropriate implementation-defined
- * platform ID and/or the target device which receives transactions on that
- * ID, as per the "iommu-map" and "msi-map" bindings. Either of @target or
- * @id_out may be NULL if only the other is required. If @target points to
- * a non-NULL device node pointer, only entries targeting that node will be
- * matched; if it points to a NULL value, it will receive the device node of
- * the first matching target phandle, with a reference held.
- *
- * Return: 0 on success or a standard error code on failure.
- */
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out)
-{
-	u32 map_mask, masked_rid;
-	int map_len;
-	const __be32 *map = NULL;
-
-	if (!np || !map_name || (!target && !id_out))
-		return -EINVAL;
-
-	map = of_get_property(np, map_name, &map_len);
-	if (!map) {
-		if (target)
-			return -ENODEV;
-		/* Otherwise, no map implies no translation */
-		*id_out = rid;
-		return 0;
-	}
-
-	if (!map_len || map_len % (4 * sizeof(*map))) {
-		pr_err("%pOF: Error: Bad %s length: %d\n", np,
-			map_name, map_len);
-		return -EINVAL;
-	}
-
-	/* The default is to select all bits. */
-	map_mask = 0xffffffff;
-
-	/*
-	 * Can be overridden by "{iommu,msi}-map-mask" property.
-	 * If of_property_read_u32() fails, the default is used.
-	 */
-	if (map_mask_name)
-		of_property_read_u32(np, map_mask_name, &map_mask);
-
-	masked_rid = map_mask & rid;
-	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
-		struct device_node *phandle_node;
-		u32 rid_base = be32_to_cpup(map + 0);
-		u32 phandle = be32_to_cpup(map + 1);
-		u32 out_base = be32_to_cpup(map + 2);
-		u32 rid_len = be32_to_cpup(map + 3);
-
-		if (rid_base & ~map_mask) {
-			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores rid-base (0x%x)\n",
-				np, map_name, map_name,
-				map_mask, rid_base);
-			return -EFAULT;
-		}
-
-		if (masked_rid < rid_base || masked_rid >= rid_base + rid_len)
-			continue;
-
-		phandle_node = of_find_node_by_phandle(phandle);
-		if (!phandle_node)
-			return -ENODEV;
-
-		if (target) {
-			if (*target)
-				of_node_put(phandle_node);
-			else
-				*target = phandle_node;
-
-			if (*target != phandle_node)
-				continue;
-		}
-
-		if (id_out)
-			*id_out = masked_rid - rid_base + out_base;
-
-		pr_debug("%pOF: %s, using mask %08x, rid-base: %08x, out-base: %08x, length: %08x, rid: %08x -> %08x\n",
-			np, map_name, map_mask, rid_base, out_base,
-			rid_len, rid, masked_rid - rid_base + out_base);
-		return 0;
-	}
-
-	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
-		np, map_name, rid, target && *target ? *target : NULL);
-	return -EFAULT;
-}
-
 #if IS_ENABLED(CONFIG_OF_IRQ)
 /**
  * of_irq_parse_pci - Resolve the interrupt for a PCI device
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f..f4251c3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -545,6 +545,10 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 
 extern int of_cpu_node_to_id(struct device_node *np);
 
+int of_map_rid(struct device_node *np, u32 rid,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -931,6 +935,13 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 	return -ENODEV;
 }
 
+static inline int of_map_rid(struct device_node *np, u32 rid,
+			     const char *map_name, const char *map_mask_name,
+			     struct device_node **target, u32 *id_out)
+{
+	return -EINVAL;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index e83d87f..21a89c4 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -14,9 +14,6 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
 void of_pci_check_probe_only(void);
-int of_pci_map_rid(struct device_node *np, u32 rid,
-		   const char *map_name, const char *map_mask_name,
-		   struct device_node **target, u32 *id_out);
 #else
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
@@ -29,13 +26,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
 	return -EINVAL;
 }
 
-static inline int of_pci_map_rid(struct device_node *np, u32 rid,
-			const char *map_name, const char *map_mask_name,
-			struct device_node **target, u32 *id_out)
-{
-	return -EINVAL;
-}
-
 static inline void of_pci_check_probe_only(void) { }
 #endif
 
-- 
1.9.1

