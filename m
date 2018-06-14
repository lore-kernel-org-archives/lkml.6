Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 00251C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F01C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rQxmoyqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F01C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeFNGEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:04:20 -0400
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:40480
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752812AbeFNGEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYKguABsBJV90j9dFIS0EBmc1vmQc+44AXvbrZ/moZ4=;
 b=rQxmoyqzl19jAqzaEz41zKj6hE29UfwWhLCq79/TGukQlzaSS40m/vcecIQGD9WgZ+Q9B0JhXCocMkjVp0Dqw5c2RWlDA1Krl+a4sly6TL5RsFML+7BzoJ3hBs6AMVVSe0nD114JxtTz1Owxscy7YdwVTAdEhE2jxAkVxjRNE3s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:09 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 1/7] tty: serial: imx: correct dma cookie status
Date:   Thu, 14 Jun 2018 22:02:56 +0800
Message-Id: <1528984982-5074-2-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1eaefb5e-6eb0-4aa4-14f0-08d5d1bca6bb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:LEslLX0uIKJ4Uqu/+7l/v1Lr6ihF10l6WvSMIY89KqtYDWcf1GUR5i5qWHaUjYdhvDHkrW7Q7LuN6UWDd+xRUShbEDv0BCjdoNnSGGUqWXZn90LgVR3om3Hdh3VjHQusA9T7WWdJ+VNTxua+AiQFwDjFyAVGA5n7K9JS5NM/QZTN0wWIW9yj6MCLRuv8LIvLsYKXgDBLPgMI3t1nDkyhgYzDr4dHAvYZX7dJGbV0cLH7m/tpytGBItvn1TwGmiPg;25:KsJsBmnABJTO7A9mMThktaukc6e/zKv6aa/iMGKs+xFUG4SlPOMend7lR/7Ix053yx4nRGRvJ5Owbid5aMEKAdGertNgRwIihAkAq1WRvrMx2DS6GGM4lLhY/1RSTPGF3eoyU9hleGVTsDpcTfPe+6c4h4Up4R7mVNBRkp99icyV7g0JU/NU8FQl/K/2oNvfn943Bvavpwh+TeRU788IUe6+GhMJBLknLg2plCHIXhdvyaECw5HBeVf/5XLw4kuX20SVQvrmDClbw72C706jImRV28FouzCq3XWPxQYYraxmcvctRDo3YtfzqGrQDJcxp5nBG9fpEF87YMshlB9gSg==;31:QqwQmI6pinZqds1YyfxsQ7qIKrfHbYNl18PxRc3lHA7nGIXQcM6nrnXnCAJuShT/7FCOx4tOrjfgwTVmIDVJhmdXrRNA4TUpGkBTCt2sOvi5XVLpQhkPutZ5yrf/6mO0S46Vtla4K88xRa4TrHUW+WHc1FDXoUspXdlfPaJ+CdQdyoV8Tby1TwZ5tst4i2FIlX6cfWEHu/t3zfeaNJTcWOZKqYNjvCw4CjrEbsHmXoo=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:YocQUfmlnHska+qUVmHEzD3Q7siwdU5eVzt62JZRRqPLYz7VHlaOCkt6PGHOLLD0RngoB3+Ytyc4M/sXmKfbQmceLT8aKLSWu4BS8d/lDPktiO0XgaLu+RyBGeSOObpda/S/PBEZm5CKNOadkUnEJkoiMlsWPfcZjrVIbgCRMhrGGaQx7cqO4uMD0bgHLxj0osn6LwyOTjNshITVUY4bq86IyuhtpCHwR14Y34YpbiqhaW/WNuEg2DDX24L9GMn7brr7wyhW4PUm569uaKyfpAkWZqOSzxmsThHzC6cG3Cu2Nw4wTQEd4P1nOJ0V/4ghe5QJEoyj2XDxWFvcH5ZrRBrPi9+GQ/Kn1d80JzpIL9q4jeHeTo7kiZjdPmCZ3mW5BL9NYioxIsd+SuAbm9xsE+AckCURxQLo/hCY1ozF6XCkdSG8Wzm6lEXQIX1Vd2oEs5g9RxPKNIxDy4en8KWACf/bS8hhZqLBWBHxSibDsXI6zeLXk7eGyfccp1TG9sbf;4:QmEWiV1jyPPk6Dz3WxAEu7JZuW+jLhcKjhZxcW2Ixt+GO0gqh7WTuBBEr67J3hg/0WW53elCLCbQNnAUqntaT+3mANbkmNBn8CJK1elxCOSVVXjNOqsk8XXDibd7fduOyJrf17kbS2L3BMQD2TMJzuHYAvvwB6gD5M2bo5AnHoxfvdKg09Do/8ZBm2Y5V2cpsR7sG/3/IEJYL4VG9cF4v1NS+B+CJlidHGRk2JxxNHiW/VPYRJi1vDykKzLJqT+XMcNgCjGwzV8aAzotMrau03L57rgm4cD1haBRVZEaElDv3qUf+WDkIwdRDN2nlRCw
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219B67F2B3BA185E7151E11897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:ZIC80VP5gLcjdatJb68HMaI4FmRbeGYy8e/F1Hjff?=
 =?us-ascii?Q?j9Ev5LfoXZOBbEdZ+Wu4AgohCRqhgLSqaD4pXqddEWDgDaC54etDghY5/IO6?=
 =?us-ascii?Q?PZ0fIeucjsPlzjWV3Bq78pcdvfU27t4uQg0e34dzX7/uKVUOTd1eOYCmzhEd?=
 =?us-ascii?Q?HfHVweD9XqvPRizGducWvfv1Cu4fXbTQLZRnOg9QLmQA9JETgKLSq1FvKW8X?=
 =?us-ascii?Q?s7zBvrCNYq+TAhWXTo7fzm65RZWfgFGB92O6r+RR2BNWK2+7I2p63vs8N649?=
 =?us-ascii?Q?UMh0veGE91/SbZbbSjFBUmlREj4wanif3USD7rPIvkeU0jeKUOCsaYHgp4AG?=
 =?us-ascii?Q?PZmC92tghWa77ODOLHUPkw6kGxpXT+khZJSVg0Ie3iUJk9FmrsmIrqDGYN2S?=
 =?us-ascii?Q?emSFWo12mJ/TtDLOXxBkwzzAiaXTWmDHK4rkYmutYOt+yStpzhHTIZ9Oi5+I?=
 =?us-ascii?Q?rnIFH+1jll75SidJdKFC1kc74TyBXgTofTVEod/6MgAqNbkXpCdpuhanHQQB?=
 =?us-ascii?Q?d4rGuXzCfuaN78ySTq76/P3UivvdiEo7ikVA78CvUfv8EuU/uhyj9GNwQEZm?=
 =?us-ascii?Q?6Ebej2wkguI/Z/1aayXg/dEb51slFmVXh5JcxlaYQD0geb0vz5fAtf1UrnOI?=
 =?us-ascii?Q?M8gGppknqDG4Pf/uGCbH8gfOYpVefAXUTiN+OTShyFg9msf05IgrSzKGqqdY?=
 =?us-ascii?Q?nrO1XX16q5TABOTvTPEtzv2xHA2qiBgE9uYYPv7f/lzzhjmLkBRaIXdn+Tpq?=
 =?us-ascii?Q?TB+tLp4oQaK6PlseYtYxlbazJLC+zb4fsRSvtbPOFSLOYQrlDpgLaH81/+Y2?=
 =?us-ascii?Q?+VSwkN0EvhPDBxCqjVlUPSzv7RnaFPCvpZfbPkBb394mOME1XRFWm6zVhJ2s?=
 =?us-ascii?Q?wPPkMDfZvxa54raL4y5zP1C3PJx5jMsZ8XyOgg5pZTod9rMzI4TWSikGeNC8?=
 =?us-ascii?Q?sYzpJvGMIaG5WICSGR+cp4eOfs3E9O5GlnuTrgPD8QoLrrJmjoVlEIhAngfP?=
 =?us-ascii?Q?Kbm/f2aGu6hhfT28cTUd8Bo20B16EviaLkWwDmCqIX+qvNyZjSh4Bd4seJJr?=
 =?us-ascii?Q?yCn3qy7iJiw57LvElqSTFgrL7oAiMh3WdRg8dO6I5agHAiJ6+u9xPfORcYVU?=
 =?us-ascii?Q?kZRGMr+DO7rZF3x2vHXImCTrLLIU3Q2GUc2SCj7L27kn941nEin5JSYOC2u/?=
 =?us-ascii?Q?Nfv8NBfeaXne3A7KJ5K+XeyovJB9NHIBJbm?=
X-Microsoft-Antispam-Message-Info: gjvP/8XDPRELqxy70jNEUABvvM/+adxopdRF14HVC+2Ez+pyk/hehnGvQSxcP72HbRHdjeqWYTCvGRF5Dp/trWs2Qr3GILM8KRDuNn3acZgYA2Asg7GUtKQYE+WQG9oh5ypuocUJrfwfxnXq+2D8CNLQsqjZDpKgeSHaKSef8rkucRQv9FpQ/xhkIm0j/GaW
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:YRUtFTaxRQSPMPh4D+HCzQIVmLZApUps66ak8NTp2FYhdoqdvVND25BVD94nl11YnYkZwdQIDMeodxWrkc8jrXwsqCWD1nJV6bg5d7QM7OE8Hw08kVV6lFx85eWPzn3yjhaYkRygB7J+Y9qqxaTcNLL27CMAPZASomESVUFMU7YbDLLMBbVlV1fpQ72OvGA0zz1Pal9ZuYMzFHhzrHQzTKe7qWl/nmKBWj7RPcD5F2uXBFIn4roM87QWEL64gRfkSWLSdV6DhKfd1c00QYGLTJfPO/eD9BtTInexc8TbZroZ/DxYbxsP4bIoqAtw5IY5rb5udHK8Bmk4XAUwEurPJaAFDp1Kv7ny0pXFBv5zC8BIe//7OBalCjgGomrLdvMkpXvGF4+spx3RBXld3Y0LUo3BowWIQcG8lC7k0kXzagjmLSqhkTLwQRmonuEPoL7fYE2KcO/aXBoX0rCEas+DHQ==;5:W//bavJpFHhd0Ia+pL1zQpjQ0JxEvH4FPZH42oYyqRLALYa2gDnSKHaOWbroHeLiitTGiyROd6B0x1YbC2SIeP5yFIIwL96USGAi9xei3ITO3Znt7tzCYo5Fytj7r4ZJ3DcopUc10TIUlKhGmbr8TRTls0FLijnssBa5yA3DmF8=;24:YoArHbYI5mbTndgoGEMPqX2FXpbOw93AfJei9dgMYV04NuHThWbgH6TKjIaXS8WC0/X9SjrbyaKK7pgPi46ZrONE/SC0t8gUl+75o6pv6Ww=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:uKFmX04nUaGxHbPthJCt52zG5vaShkmzjUCcxXvGekpyuYQjSU2hOgYjRVQvOuJmLp6vaODvPQbv8xCFketuLp63NCVjgvm+Okres3qocORDPmBtjtzYnAqRsfAFKiGT9lwvW4yfoRGZUlyd9jU5LFmCCi40UV2gXOlMwab9HEWBOAHaGusZ75LspYT+rJ20UTRB4TtWfefkSquJacUegKDkZyN+/7NeKddotRCB//Ni3Y82iZXhbDmWkNzj3zZr
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:09.1425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaefb5e-6eb0-4aa4-14f0-08d5d1bca6bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct to check the right rx dma cookie status in spit of it
works because only one cookie is running in the current sdma.
But it will not once sdma driver support multi cookies
running based on virt-dma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c2fc6be..b83bc2c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
 	unsigned int r_bytes;
 	unsigned int bd_size;
 
-	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
+	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
 		imx_uart_clear_rx_errors(sport);
-- 
2.7.4

