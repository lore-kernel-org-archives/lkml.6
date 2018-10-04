Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1840D213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CufoaQ8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1840D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJDPnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:43:03 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:64779
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbeJDPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAVRD8M58pASWtSy3XObgRqod/eUyA0ztQImlbmKSb4=;
 b=CufoaQ8k0hEPBKXSvZ2ZyBqBPNKgWUwjMOjI+QlzTZho89VIs81DMuFWMR7PGl9A3bQ4n8XDilPTlSJdS77dGVUw/9Zsl2EOslM/mPeZFSOzwmNGUXWF7AzvQ3ntFIL9Fl+0LO+BiO3g8AuTDPI/VOBHtVNlyvTPbtsw4w2XBeU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1025.eurprd04.prod.outlook.com (2a01:111:e400:8442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Thu, 4 Oct
 2018 08:50:38 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 3/4] spi: nxp-fspi: add mode flag bit for octal support
Date:   Thu,  4 Oct 2018 14:18:39 +0530
Message-Id: <1538642920-3843-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To AM2PR04MB1025.eurprd04.prod.outlook.com
 (2a01:111:e400:8442::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a8ced3-8f9b-482a-0fd0-08d629d67787
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1025;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;3:AiTveoktA4RKSr2MT4ZlbXSPT057hG28xOIRkRE09iIR0WLR97nx1ouztM2lO49oQBSxFJDJnVJp2rJWx6MUeP04qM6AFU5r/fbuG/scidakPANMlCpOCH/cbBOBV1yBK1ORZ6q6I7llybBxy2dBWNq+lzZtzJobSMjLMO7gM9/h7DSBFwJA3ZAz0IGZJxRA8jPaBoXweVUmGatIUm/QvxOvjYjbY1Rw9br+EeM93aSIlwu3otxpqSXTCpYPTxAb;25:Gr8j0cs32wNAxKlJBdxx3CK05pIgHtKz3ggXC+EybuD6mLnaVY38/45MKztJY/lLgOTmDqZlexEZBQv4FW7fIuU/TG6RL3uHh5ne70ArQD7LS2oFJK83JNL9unnkGVgTHys35h/+mC9ixWZGINWOE09a1FqiHS7g865Rz0W6xMmWfwU9UnDZ44tp5rmGhnYfifGxLDcc8GrkhxTuW7x25wDqR/1m8NSiCOFFmvQlPb4klHqtvf8pEA5RaWD7CGfCiEg6ExxmNLvnUITGMOK+McthReidMAtGVujCerjCAiWgh9Dk2vEJR/qYYeJXJ2I5MXLG1M2N0Bx0Nq9ZsFri+Q==;31:g1azERlSRzsuG/I6SXXKucawHtvh/P56PUBAVJ3HYpRqjNY+PT44GbLj6EFxL8J/QZ8PJZrnZQSaoke7Ae9zxOeoLzU/uiQYejjTy6t2QPouu+2EmBIYosv7zC1SpsfvYlNQYxq1bvSVRPvZhsirdTYBbIZcP+llQcA9lekXwWEGW60rvtwWvhmr8WE2xC9yPZMM56v927Kwst7oab4/eQvW/jK3bdFDn8l30Z+3M7o=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1025:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;20:h6FVyjZa4+xpJRCFKXwI0sKRsObVZhdwpPM3invnYvDeT9kXL+UUnOuiX9vOgGUdSWEd1UiiwDcYAHLK92vKyvFV/2VF7TGjdAKguOioA56/p6BZTZjHSyHnmE/SBABXxJmxaRvg8WVEc3/BXhA5kSxoyZp7jl+S1EoARMYiTMtty9g2fcWwdVyvpXt2Imn3cDGOvL0tjH/awGa9J2NzxPYlFDTecHsW0tF9U+VV8aQhBlejPIqCyY/E9ejAna/BpD37zznV0hoHZj9wWPO9F9iZTSW+WO43wyvTSE7cRsAlFoKpyvEQkuJJ1YiHtpQcChlkb5+lnDz8e+Gx1sUelT00wkhlWgFqB5foolUDza6aCEvBkMiuNSMwwbTi0BWoBPR4xSJOCu9gxLRLshuFPQ4Ug+4OdUJ9YFKZXqsAztT95/Qk2KZPlimk15K7lpl63vCMLiEZWomWDASpwn13jP04akjeLAoGjHCa4RWX6ibLUKV+uT86O3v8kuclKFKT;4:5fgrbkBpHJuerDwUGYI3r6rZc9oHxSoAlGTm161YJtAc+TUaTIEMC+JeMU6AHO25oAMR+NG+w+Lw8roqkpSWjrpCxmEZe/75+P9YFY1FIV6nQGULTTdmX8XxMSVQVV3XPBypiga3zKzI2STB+JXTm/+gj6y0FGWdBjuHUeSBNXDFI5Yi+Fc72r00exfor+Kugen23TiSxGGQXtzcvfmwwN89Zwclvv8DyXF3IgUSRq39rejeZLNXTE8HZ989nj5DBLVgGJwj28hUEsZTitSCKHzPUYymnDgx5+SlIswinpsOGmoU0pyFZSIyl7Wdus5m
X-Microsoft-Antispam-PRVS: <AM2PR04MB1025AEFB63F60BB808F0686499EA0@AM2PR04MB1025.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1025;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1025;
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6512007)(8676002)(3846002)(6116002)(7416002)(476003)(11346002)(2616005)(956004)(446003)(66066001)(386003)(52116002)(16586007)(51416003)(6506007)(81156014)(81166006)(6486002)(486006)(68736007)(8936002)(316002)(106356001)(105586002)(25786009)(26005)(48376002)(7736002)(76176011)(2906002)(50466002)(186003)(16526019)(478600001)(53936002)(47776003)(50226002)(97736004)(36756003)(305945005)(5009440100003)(39060400002)(55236004)(4326008)(86362001)(5660300001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1025;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1025;23:NvFFSgfyAgYdm+2Spu+rSRYycJJMmIUg4PRL0YFqh?=
 =?us-ascii?Q?0pPOPUmPgq2O8w+InFTX1VOsi+RQm47d13gh3nsPFi+rv9f2OXQAQMYrkADh?=
 =?us-ascii?Q?rfrApJ04xDkYMauFTsdNgkmhp8vitx2hIohS1rKL4BL/Us21yy7cavW3olWk?=
 =?us-ascii?Q?pT28nq/o/Ufho3Oew5O4R8kNG7ax5CUYpwhVGNrTpT4qxmKzZGcu2L+c88kq?=
 =?us-ascii?Q?hrb60xgv92hetwlAsMC7T/jFzsvGlBzSrm2OEBKfZNsS/5SwAWGVrQC1yLN5?=
 =?us-ascii?Q?ZinZfv+8MC8VvJkq/XO1kRihpKnilXKSeQ4bcT4hChyjGvnrD6hOcaE12Kq0?=
 =?us-ascii?Q?SSXmYkfp0xpf2hBLxF7skPvZI/F4mdMgxLMjuvQdUZd1eRo3WviLhFszriqY?=
 =?us-ascii?Q?zfTtmBB24a5UoguVGn9CcryQ9VhQD3NxJeqxdxK0+xHrPElZcXDjLOvNbl0h?=
 =?us-ascii?Q?f+nBk8Xf1dlfybm/wQKXU0jKLmi9zEY9CPMnYBZc9ydH7+0A3NqJrI0rygif?=
 =?us-ascii?Q?kVPfILYrjWaVq/EESlgAkU+fe109P//uu2dx+6UsLEHDUFrKgk2CX3eNygL7?=
 =?us-ascii?Q?gjgQ3KhI1HxN+6uvwR3pXQHK90OOrkxmzv9sPAtCzuxh+PZGfysYy42NHzEg?=
 =?us-ascii?Q?zhuSXF8Nsg72r1YWowsip2zheZ8+IpNuL/3lIVeCGbnAQBVbl0XU+dWLvK8i?=
 =?us-ascii?Q?/CJhmuo+vT4kXmFbZVKS/gLaeTIAlf6aQsbf4KgmjJblOIQzgFzp3mJDT92D?=
 =?us-ascii?Q?k1Ht1f+UQXGaEEmMD/J8E0VyRgF8K3kw1zDjlRbjaGXzf5XAe/YseUEzQS2P?=
 =?us-ascii?Q?gfsCdb8UtvfEZCPnFXSaCsUTGySTQ6ci1pvRVl2hGyGFB4MrYrBvvxslyr7t?=
 =?us-ascii?Q?H8YwTljBuNJNaTn32ZOseu3OwbfxWVBv7mxAfaQST0IGvWhh9ot8cN/IYRI0?=
 =?us-ascii?Q?1AOMQjLYmbP8rlz3LX7++LY3gQeAG/0nMcl1sM8YvxnakaMlSmaoqOqax6gF?=
 =?us-ascii?Q?zKWn98vEG2YiQv/sMxnqQ0QOlrg/Uj5o3atqgWCqvf6ulHi8UvHqyT8/nTjN?=
 =?us-ascii?Q?le197V6iYiBXaiTvX067RfK3885zffFi8pziokvNv9EteDV4YYkT4taL0vA1?=
 =?us-ascii?Q?oK25d4FEDyLc0YeJ01AIXxGUlMHM1kcHSyR59o7fc/bVRrTDazQRHyE0bWBv?=
 =?us-ascii?Q?D3LAwNJISvLnPcak+MtKDBt+ia4Y7Xj+bJCYHUITdUugU36r5ti343x/6L47?=
 =?us-ascii?Q?qQLuEJCBlrwFmxkKNE=3D?=
X-Microsoft-Antispam-Message-Info: /ndhAALs+UU8H3uCdMhR0vWadb6ZdU/iuUHvV3BiIkJ9ke1GtPCfKTvkf28Fqs9LfGE/tjxgfi2fSSqWb53Y4ShPs+kwGy+HR85UNhZwTpMcub1FieGEk+zks3tT6tR0x68ZHzULNSJQNKH1AIfidC4UoDrPNSkJmiS/Ku7Q5043XhAhd9nRuvN+WaXpBq4IEnBXBWkeHRTZ51APcD7Bn3niNVU29qANPI0PFw6a5/hRve/+InJbmM18TbvV7a8imPEaq+2KveS6aNAtxfiDoG1eSmsYddwR6NZyYsp+7L67kYs7OdXLQxcfFnt1Rq4zZTyvNteZqehpqSP6a7qYn8Epi84V4KXeLXphxC3b2+w=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;6:MJc1A+CTQMM8CjXTEnj6evpMeuMR2iWICGvBpVp5O6zLQr0MLGnvezY+S/d4SgDqRUhuTOdQCyliG0vJH00QyO0IWVQE0a1FEGUnDPT2PA/6lp5cqsF+Ynob5VjPWhauv8oHA1zg0pQ6J6o+HCgp42wNQcGzPWw0jhxCh6ZaQKSittqVYvz+q5gLnntVEOmnoQP/TKFUaVP9A4Ej1qusLgeDpaM5yn0TkQcGQdaq38UMYcyjnSXSeZ1IiZES16A3XUcQCt7Szpg3fIec5Xi9XkD11UL4PVbHJK7ymkqz3/wupqNjxtdvJvU/8KQ2sddC1jqtnogDK3WDHKf0ULriWyy07N6nnoGShbHXyPuf+XXl/qtpwhomvFcabOunvphzTpoHM+xMBS4NkgLyUKN3pa86aP67+WMemKTPY8XGrQsbPMVMRcswdy9K2AwCNoAR3JIyVQtPxOzq9UsYX0+j4g==;5:s+0gbHq8f8hdUaxdRRriGFDSMbW7idhIqlznNjU5YeLphwGJJfhyE6C9bN9EV+fpUF8YzfLXNUbGn937BpJryyBwzD06hJ53rdkqjJqvkZA5JTt63xrczePvgoAomRy7vPvE/ingGs+MBwXT0eNqxA4ojRbXIrtQ9xdwutXWofI=;7:NOca9mxl3ZjhUK8s1j+XwnnEQcxayGrSIXGb0cPXQy/+xZvP6X3bRHvdxTF554XoQxnEzlPFe8CbHSfB/RqNSisJka/PVaLvc1A6XwMukghf2BiazIZXLDOAknCIGip7cnWDAxGDizLRLmyfndCsB3K9ZnJ0pjBBacxVL51ruKmT5gnWwpOA/QSmq2NL4OhU2IPpCzOPal7z2V0Fd+suzRo9onW/9MPDjSv/t6n7UdBRYlxyx4DJdVnbWvFo7PJg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 08:50:38.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a8ced3-8f9b-482a-0fd0-08d629d67787
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports octal mode data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0967651..ebab44a 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1065,8 +1065,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
-	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-- 
2.7.4

