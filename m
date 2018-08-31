Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A862C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE37320658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RZZgGP9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE37320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeHaOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:00 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:23484
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbeHaOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgiYf2Ur7sJwKj9pmaYJQNRh6lgiVq7M/phBgQs+oHE=;
 b=RZZgGP9QVTY3aMHEqTRNi8YhZFZfwIgi3jCh5sovJw5qMnnIhrBN7R4tuVKD/2oWz813w3pQmkwDqcWmiJUUWs9fbMLiC/Q/LT5mZi3kg7NNmOO3LaeEXziNhvmqvn9ZZZy8AvQkdw94GQgWoAiDT/QytwGBwOh8iGK9oyEK8nM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:32:00 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 2/7] spi: add flags for octal I/O data transfer
Date:   Fri, 31 Aug 2018 15:59:59 +0530
Message-Id: <1535711404-29528-3-git-send-email-yogeshnarayan.gaur@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 28f5055d-a3d1-4470-c67b-08d60f2cfed8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:yzveqPQgFV/4hPNWxbRBg+eE+vZdLINw/qxVDUKnnozS2tgsEzHCUIVq4wCBu4cMlv3HiRFLZ9DWkMFkl9382Lfgr6aWyexURO4Zmd8vWd+rPjIdBN67TAbBFCP+ms7FqVH4umSCOBQtJFhysy++3oaXf0Fk4MCkJz37kzuxzvLmVHPWykavH0lfeTBDvSXZtFDj91arIuuvkP74/2v9UO3LVdaEkQ2QgqLsr6+yKoTopwxlX+Z4mX5B2WfV4DnM;25:B8ql4o5cWOtijTyo6eA2+SpvDG0Qvr+Ta6aKKtXAOZxeTQ0F4m0stF+3cKZXGPj7A4HpxM8Vas6ORkJFaRI86NFwSkh2RIT54uV+lj7FlQzg8M2Q00Rn72zeKNKLbXS8GKlbPISpYfdIRddvyT1xGbckrERKkRvj1DxryqUtvwCFfoywlp2kDXlI27CdYW6sVKoOyhBvwXeqCrWhf0wiDyEfg+EA9EkJV3sy4Zl/LR86+FOHbXGdVEkhNQczER+8E5U5YcFV09lYyWfJp3g1uQpLfwOK237KWZrZ3RvoutFue0bW5sMsLZZnTaUhjQ5yVP5OHDM6RjExeEdgE0biv9waZZj9EA5ByYmFBwNIeiI=;31:0RwCCGKAiR9TdyD+YX64CXFJQ5YrwoEdvsnNnQmsZwHmuda/1HhA5yQI92xtfyg8v6vLx+jgk655JgqCP2wrpSMxaPybiMPBYD+XGDttttm/Uc4zSCS9cl+LH35AUESQQsrUCtZGPOOq6WXt/8ZoXBiCbTwI6hTjNyx/9R+3kTJwg0hmOlwo8tdBhR1z/uOAI//1J5i8pf+akeW10+U2WT6urh2QnrynAgiuzIsUBBw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:glIw7VV8s/Et/QpSUNJaXc9w9ggQRCKPPEu3j30PGvgFrAZahZzP0htAcpwWGRxEY4/a31Ur1pAYn9IJGzZoyHaUzE5FgFAMrNwvAa0+3viNbklycbP5967gXIfuPTJcSKxQtbTZN2x9B2HzHIQRKSgmiDraWUTcwuxhjfSUt0/WJusR8ChHCkYTR7IrhNDd7gyfpMX0BdAlr/mGT+W/vfulgyEZ+EBph4SvG1/TvkWmHxgYedP/zT2G9XizuJgNIuzYWk/m4VqgmFybbMy5eZpdl5fxO7z7B1PpnAccIhfCG/peVnBvrQBzwbpJYo+Bq/5p0HkZzy7ADyhCojB/KTR1nHfeH8J+4HkqgMY8RVq2AYPwSiOTYzqe7tIakFqGqgliXYtVK2h9cqgxtD66g8WvZ18trROpY6hz0BZm1XqHz/PggG5AMPYS2GsMjXc7hUXMlTrhSQEgg5h5YPiEwXpjPKXiYcOq2voMi3nScEO2SCfXRHpEqg3tJMRcf5DX;4:kBLVYf15sWuJEjKIsKCTGw8gcSOnEQ2q07iUUSHLCVuE6MWqWj3U/4IsKPhYYZ708dedn20Wl2yXMD6HFPXmbsfZx735FmMrE/tnA4GhIaBtn+KJcvbJGTOG/fPI3wj8M48+IbywxXKSDRwsoX+Yu8rUU3R5av1AAztnmjuF33tzBE2I349u5RIPk48iN+kE6gYGcE7wfo6/vtZMZMLjtuCPGI/IPIg3cHKkmOmXpwIH4jwunydyVqyNcK0rNNMGoq2rzgYbPTFK/9zKvYM3xi13PXJabxYWA8G0M5FOApI6GmGE+H7b/SGpgqYtWK2D
X-Microsoft-Antispam-PRVS: <HE1PR04MB103499F38F2E267FE3089562990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(316002)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:bToh7JCqZ/zB4nvLXHWp5Y67E6REXyxTkUvDif2mp?=
 =?us-ascii?Q?LPSztsheTbENbQRUOCy2owAnq6OHskXuHpbnY6dVAYHGzEdjd6FPLQrLdmCm?=
 =?us-ascii?Q?yghUO8wxOUeDNic33FEbyjViwK4FYJf/XlKXjbG0UagZVJ+8BFHGeDldDFIP?=
 =?us-ascii?Q?Sxjers7tyw3oaXMDYmIvlZvkaiMy34l9ldb9U/5dsq2Ulkp3p8nboBVq7CdF?=
 =?us-ascii?Q?0BnacC/dzy8Mu3gISFC35RdjEKyci/Khh34w3KgFDWrBxiLnMUxI0Q45t+7e?=
 =?us-ascii?Q?ONpAQH+KFssLjE4uvKB4qpR9I07KUTqMP7NLfzJBIy3IiTOFzJ9mHwiYnDPZ?=
 =?us-ascii?Q?+udUlsr7jBAeLbPqMBUc1oM4CeLQcAzuRPc68QkYiT8G51J8XUPY5RhrO+il?=
 =?us-ascii?Q?A4OTy8BLwtLf8aOxQ61oKk4khcRNI9IMUG5XBXJFPwKAJnhDEuQYRRbZ829Y?=
 =?us-ascii?Q?Y07yr5E+GM2z9IwAx60B7RyJrsUmIIZpAHDc3hgezmlbBuhMMUfsaiVu6Md5?=
 =?us-ascii?Q?7wajFYSDokIXn2rmeTD/T/rYSBE/wA1UQpK+kBjgYgY80lVmOVndivk6gL+m?=
 =?us-ascii?Q?mIiF5aA/g/KWXSydxkDEfokSg52p4n4/Kr4zeQUcs4GB3xuLmrA/xp9ztrnO?=
 =?us-ascii?Q?tGA+Btj+/6ztHdVkSio/HIY25DLI8Fwujs1D8n381fA33ChpTfsNOSmF06ep?=
 =?us-ascii?Q?T7aG2V0rHmawvdgjpO4oKJkjRFrCVqqU98Hux8h+1BuDXKUfydKgQT7Yo3ZM?=
 =?us-ascii?Q?KFrjUFngDWHkfwWSkk8H4tgyhm2hF+xD0xriHK27ddIrYfyfyxpnU49zjz+i?=
 =?us-ascii?Q?jye831UzU784KQVWlWyaK7aghGP16GtZIJeMbfzkZnmf2zhsAinq9RtcHMyA?=
 =?us-ascii?Q?roTrN9La8OjUWFkSKX/6tCRZYzrV6P5z2iYDT5d0yMz1WS0sGYRO4D/Qk9qk?=
 =?us-ascii?Q?sK+UoAS0M+jyt3zCQXk1rL8LJH52//qdj6WjLeMYNnqw7FNIWsEPpI2mN+E0?=
 =?us-ascii?Q?dVFvmFGewGlRgY5tjQTcbKBDbSiCuub3ygLfDx+7R0QiYdIFkGtjukCnrDqz?=
 =?us-ascii?Q?6Lv25oUxf3ydOKQYsF5dhfW1RhZY0uyOoGreQgifeWbkZS/O4RQwIp2oO0V/?=
 =?us-ascii?Q?2n8WxbrfV/xeXLfEJXaRYshYtatXnXmC7pq0a6J1ZKvLNVy4LfruAgOF+K1J?=
 =?us-ascii?Q?1VWVUUd8RRXlcCRF93wWCmaQjat3mSXang2UzSBytwys8slChHqX8Fe5Y/27?=
 =?us-ascii?Q?gZTXsGly/tlRw2zC+U=3D?=
X-Microsoft-Antispam-Message-Info: Trmc+wirsYQMWUSU4Smb0RZ3AUY1gLtMsgLrLQp/T0mfI1jSQ9y8tWE8HsewddlKPoF3d1mD91alTOYg3d/O7wKyMnPbZJYRzqrYYbp5/c3hOtQeOFFAxXZKZ42opdkkvV7vAKl5dBMmJsUUDYVzKnfCcGDTxeNELWB4GTgEBb/Eo6h5mI+JHhENCWIifqERmNO6kPhBC/Ap71Ip/IXgEA0+//rglt0uLdeRgxh3pcPCsQC6H4ltwTOoI2lgqsDkn96AzVlXibaEBpmRB9NGr968KAqQz/xijZLHFWiwGnKE/zOCmyLFvmQ2FzIupbXvXVoK+MKeXZ5N+UL8RQ17N2K+B6j3JraepDgPjROIYYc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:3TB96ryT6NQ1g81CtZjoOF4JLCs9P2a68JCaydCLYTOqPmNiT87pSj4dZxTs7sbQGSnFS8WPEiSIAkQ/Plxa8SW9juhAbRkmXJ4quG7oSTroUY4Jls9JdGSClkMb+NyE7P9e36G3RLLaFpwqEUxJAC7uQRvlL3FQvFl17+QH7osJwHKiciYhGU01sCTxy9idCDy5SZjuTjO6OXS0uAKEoOe9pzb6NPdZE/zJlL/koRQIJUbtpJ9UF8OmAJ3K6BicbrSYbUvr9uOS66VUu5kzsrFdazj4Pxz7FDtKIoJ7T9O1hUuPUCTLqeYyvu1YNNJPpbufQX+qVPwwB29AzXJvAPkp1SeX+XCB6P6KdrKIoLRPLppoGTCZQgJhPug8P0o0piSY8F2PeDRoNLsxJgPPcQu06Toy/ipPmL29q533plcty8ux/13zZMGnNzbOSE5zqLo5s73OCqVZsOd765Ox+w==;5:Z46RsOtVrisw1FaSl0DXtzvVpEg4bn4325JyKg2swcZnYfU35gMbU52jsLWJrFKM+EzfNgkfCpPiPXkH9W1BwxMQCKA5tNSa6BKbfzI5nR6APkloVSNicczUivXgsXKOi03TZlSnkzy3IJrOFFNRKli+19cV2SXZ2tM8A7hGGD8=;7:oLkwGD3fWEL7PzQOgVe9RRBaxzvGJ8ZHhBUHliPeWCLth1XXNaJcbKTSRDQppQvcJgtdK/qsnvbJMy2iHPpAXj3iYDUDpNY3ReLvSpZesrWlj2m+oghiojY2tgrvG4JipSG2bhXS5NU/DFtsemh5SlYRuK0ePDgLDnj/bLLxsXxAto4zsNgyhMcejQ5GR4hIHWyptvO3bEA5lB6qALn+GL5CGY/+s/8p+kTP47OzxH3Wn7b4r3z1FGZTIN6rgLDo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:32:00.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f5055d-a3d1-4470-c67b-08d60f2cfed8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal I/O data transfer
Required for the SPI controller which can do data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 558aeed..180f277 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,8 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define	SPI_TX_OCTAL	0x1000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.7.4

