Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D94EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106DE20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vo8iXNml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106DE20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbeGWSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:03:05 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:36744
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388329AbeGWSDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDZKIHyR2034iUyRWQVawtltx+astMShveJjBdzqC+Y=;
 b=vo8iXNmllFkxJun3vOpUrUJBfK9I33fIp7uB0fNaEiYUgQOuqNGofIIe1zs4cxw7DPmNd5wxxc7HRSui7V3hvObXxVp/C1tZsjddR1lKCFFsBMOO3ueHAdgtR4+Sr+LD+kyfcsLDJw6ZwCMQeHrEps2H4rJMSf8RbJm2qwlUFLw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (2603:10a6:803:69::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:00:46 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, ruxandra.radulescu@nxp.com,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, robin.murphy@arm.com
Subject: [PATCH v2 1/4] staging: fsl-dpaa2/eth: move generic FD defines to DPIO
Date:   Mon, 23 Jul 2018 12:00:22 -0500
Message-Id: <20180723170025.2259-2-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180723170025.2259-1-roy.pledge@nxp.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-to: roy.pledge@nxp.com
Content-Transfer-Encoding: 8bit
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:805::34) To VI1PR04MB4494.eurprd04.prod.outlook.com
 (2603:10a6:803:69::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7709d918-d4f1-4ea3-a1ce-08d5f0bdd6c9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;3:4KwJdjx4R/CMTvflFmG3dnMCN8hlYSLWWPUShA3tVEcTeP/6WqcZoX5dUIL2zIG/IZqvMLF73ec5pPNpA3t6AliFCYBToOgzG+xym79t0td+8BI4A+LoqXXSMJsrO13O+SAwzkWbiaJzTPlROtkI/JuUYr+kKRliXCs3dHUuOEjT2VzsyqnFTigWpePyf6QFIKwQs7YmMzDET4p2DMUCAKgU+OPx6C6ly6ixs4v2IUcFCuuVBQVGYJK1FKdDNAl8;25:nG/AsBk6XY0G7hygfkSTiXy0tKXHulbrGV9Y1kxqLIQeS5i8KaCFMC9VSRpfYOgd+3f8JByFgShYASTg4tmD+j6GYoPfEHrgpmP+XHJdfKdXgl4cN714kc6rBW1OkYh4a+pY6ewanx7w/vOO3B5Xq+yhJZeq0EVdMeD5lSSxtOXIC5DvW8K3U9xCQXO20qDzQK5U292ueH5TkGhYfo0JZKjnhdYrqG2CI3qXwHlWGuOotKsMVp/KG/zoZprVgD2nGflwahuZluopzFe4XeaCgYy6fAv7HevXbV4Zw/rQcWnc1VW687f9rMf+jA+iyVP6JF8r9dB4cQgYus0grIgyLA==;31:MPrMZXmaUBjMIZi8C3QCFrMKsb1vY3wJQOA/2UK3+3yH0lURHV+K7FsIi60IVO7tgJNNsI27VbThcTDjxCQBjeDMMoLoEzGsCO0ZjOEfX8vIwykK5B0JAuIJcIYTEg68fXQ6zVwa4f2cC5vVxLYy5/iIUJwU47Re6nU2ZqgLQmAnxOJdh07SgMUtq17q6Kg2ajG4krE0i9O8B5ouju49L0R6Fm1ErQkZ4WiRGw6+TC4=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4494:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;20:SgW0vcM5ttDfPpIxbeH3CQyHLGoTdFrjw+dJYTYTrkm+XxVG4nRCmt7xT0ayUm6iY/TOfMgwLt3WnfeLNY1EARa3GQ4rFzcXFXTTE4oFrD6nr1HNdPJUDx3h969KccFR86qNFzvmv627J8W5TUT/57ArUaxnpHRlhw7hAMdZlUwX55c0TCwU1XLv2IkeCMkcCM1+MkegdVkx7PgIUZMMhhhwiRS1aVfDYe8Z2D0BdYA2iOahgUQ6rNHYjgXXLzcDOmMfC2664zKP2BW70lceScDYClwZyT/tksMoBb+MdEePoCLe9lnN7lSafc6B/6brEmAwj0rSZUB+UOumTf15z/SNNJ0AgQrGfreRkLzY+H6RBcfbh5r7jPOJv9hMeg7+7lWE6ur7kW5gUE94ERKsF7ZVzxms3SxOTZTMrigs8aL0lmd1VmKBVqCuf/txyLiim/m5VzSmF1w4uXoPNFbqBUBS/9CXbjhscdVTPmvEOqgngTtjs/KUq+zipe0D9tS2;4:0KgfwQoWhaImRfN/tRhC32MNlKCRIdrUmnLTwTmlNdweeleodYfurd6DztXgPbfFhwxDFwlwSFBQtZLpd185EkS+BMBP/nLRWrSY7lDwXeVqyZOK9B3JufMyRnGkGqV/JIF58L8JO4NlE3bjAPbZLRUy1mClvTJMSpMrZMLpNA60Sb0Lzqb5TORL5sybGrfVdeki1EIBBMHTjAZjrMv9V/LPeh7ZUbOM2ggQZFc8/naBktXcvsHtHNtZVtjA11vNG1pv9PJV/rN3Euwsjsbc/MWka4ihI8usKx5JSAf9HKjZgHAfCvfv1usUmYeF+At/
X-Microsoft-Antispam-PRVS: <VI1PR04MB4494E27143D5B07AA83A52A286560@VI1PR04MB4494.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(7736002)(386003)(6506007)(76176011)(105586002)(5660300001)(6666003)(186003)(2906002)(16526019)(6636002)(26005)(47776003)(8936002)(316002)(81156014)(3846002)(6116002)(50226002)(53936002)(476003)(4326008)(68736007)(106356001)(446003)(11346002)(956004)(2616005)(25786009)(14444005)(43066004)(6486002)(575784001)(50466002)(66066001)(52116002)(478600001)(8676002)(23676004)(86362001)(2870700001)(3450700001)(1076002)(44832011)(81166006)(36756003)(486006)(305945005)(6512007)(97736004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NDk0OzIzOkM4VXB2ZEdCR3gxY0xGM25iSGphYVFUZ1N6?=
 =?utf-8?B?Qkp4ZUdiSXRENDhJRGJjR3FoenlMT1FpaEJXdnZlajdONERZYkpHQXhPQVZL?=
 =?utf-8?B?bGk3d1l6QlI1Wjd2UXhPaW9wR1dGWndaZmhYNWZIb0RpMStQQW94bFQ1a1N0?=
 =?utf-8?B?SnIyTktKR1E0Z3RjdkE1WU1BZlVKTGY0UE1CY3h4Z0RxOEFzbUZ5Z0k4NFRu?=
 =?utf-8?B?d2hJTHo2M0NZd0JSOVZlY2xFZjBGdjRna0dXQ21WOGg0NVhFN3I5dXQ2TlhR?=
 =?utf-8?B?WUpaVjg0ZWZzM1pmamJrS2lOV0VDSzMrRFdIQm1SK1pEc2JPQVY1R2NIZTlm?=
 =?utf-8?B?UmxlRVZRd3AweVNOMVQyek55TFlZRm92K25KSkJmRXVmbFNiMjVpVVVxbjZh?=
 =?utf-8?B?NVIwZUREV3JTN3JjRTVZODJWdlNOT2x5bk9vdzNYVW9rMld3RUpuemhqRlEz?=
 =?utf-8?B?MytqM2dWQTBEaEQza3VpVjBRNXVOUmE0VWphR1BoZXZ3aHExWHV2N0FFNk9q?=
 =?utf-8?B?L3hzVmxsNGROWjZ3ajlHWVhkbmFrbFlSY085Mk9tZW9pLzByNEVLY1hoUXlQ?=
 =?utf-8?B?bi93T1YyOUt3WDBiT0hlNVpyMUd5Y2p6bG03WHd2VE9ncVpOMy8wTjZvZVFN?=
 =?utf-8?B?blg2TW55WmZEK3dLdFY1MkQrOWliRVJHd2ZiaSsycUkvbXBZUUxIa0tlY2N0?=
 =?utf-8?B?Q3o2QTk3ektxM3RQM3F2d3RURzhiNkdQL3YxRnB5VS9vbDYyQ3I5KzBEelRX?=
 =?utf-8?B?MGFGKzlZNXhsZER5NkFZV1JZbEdlSGhTTmpZc2JISnNLMHNVL2txSjBmNzdP?=
 =?utf-8?B?aVlianBzT2xZWW9CMHJHakp6Zm9OT1o0QnNxSDJLWHpKVkNHczA3aWx2MS9v?=
 =?utf-8?B?ekJhMElKTmFGaHFmL1NCNUxoMFhDK01SSk9ZK3JETXh0cEZHeVlUL0MrUFFl?=
 =?utf-8?B?OGNacHVHVzEvR3NTWHVWZFhrVTZUYitKUVA5RHVmMXVFZW9OamJwRk8rQ2xv?=
 =?utf-8?B?emtLVTdnUWhRS0ZyWjd3S0NnUCtDRGlqUEhJNHFja1ZtWExhaG1WNU5yQVZz?=
 =?utf-8?B?ZEFFUzQzYUVjQzVrR21TT0dsWnNnR3pPUFVRRzZsUkFQcTNXczhpTUppQndz?=
 =?utf-8?B?Zk8yVkE2eFdpVklGdWl5emRGZmxyUXQ4ZUdmaDdiRnI4eE9JVUs3emhySHQ5?=
 =?utf-8?B?bVhkZk5oNzlZRkNCRVBsK2lOb2djYVRtYVVGNnd0UGJwRmFOUWRCeHl5RHRj?=
 =?utf-8?B?VnNsQlFlT1owMkVUb2pDVDduQ1EvcXdJUHBOZTdXQVRkeFNhY0ZKaUdSbUpL?=
 =?utf-8?B?elU3ZUlhdmg5YzdvOG4yU25hc25UVlpZWVRzMkVrYUtsMmw2NTBGUzVqZ24w?=
 =?utf-8?B?UDNNK2VjL3BkMW1xMm5JTlVhQnJzT2lqU1QwaFBXYzg3RTM4aENKL3BFQmhG?=
 =?utf-8?B?bzBpQytXb3RRRk5abUZxbkVwWW0ySmprOTVlclFmdE9NZk1xd29MYitTL1Fa?=
 =?utf-8?B?alA0Q2xQWEFHMGRWN1dMU21jOW9hVjFWallPbmdvMzQwWTlENlYwQ3RqbHhj?=
 =?utf-8?B?RWhTOHp3aXRXWDI2ZktZNzk0NXplcWtDM0g1VU5hU1hvVm5QanU2RzB3Witu?=
 =?utf-8?B?emEvdjFZMGFWS0U0VjN5T1RuMHg0V2pZdFFWc1VGSWNmSWlpRnNWeEU3WXRI?=
 =?utf-8?B?WTVBWWpOQ3hZTWYzcFEzMDkxZjRXVmxiUU1kYUorcnA1N083cEdyUFllbC8x?=
 =?utf-8?B?Tk5Yb0RCaVR6Q2RtY2s0dz09?=
X-Microsoft-Antispam-Message-Info: TV2k/+VqXFFkGxYYQCqdNAzJT+pExl1aEja7whD9h8mshn6k4J6Mkbcq3SnJdUtHcRfWoFQAQaJOUP1r1s4pQqjOY2TxJn0Z8PYBpDkiDu69G0YyVtwPnCAq1vU+z3AwaqoHVngOtHExzB2lfD2HxSgDrpa7QsoLcXk3kiCRU3hjWHFv9S5EA0AS71m+AAvI62WujuH8LuTdU6KmxvJnZV/eEiRRnSSfi2EslKcx90fitR+IVUHUlqEhd2YndtxURXl6T/VsY7XGL9amoOq3ghwA6kjYeogSC7PYdG6c8TU83yfKcLXxUnnZEQd9PhIM1D7TDPQ2JnX8mK+6h7QEZi2kuWVJZIAXCF/lEItNfao=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4494;6:6qHG/QAcMNx16/yyY0ZqXfMD4p60cXc8eEVyZcnAnpb8KeRwYv642koF7AupjaCvTjCYNhm5HviaoRgxHTjP0GAzi7yz4sTHMYzpzEvsyWEKV3UziEn166avp8jkOqQcsstsx4qH7vdTTCBzMvmdrPosTZShAzut+oIYcUDQ9W4xbOEetxaZ1ZISWd5ApkFrdH6uBWaRbrZNKmS9Pg7Ifw+GGDSZwmD/lsrpmxePwX8MSNeBw2Xius1xxuCTXXiYWptyxZ63wRyUE4S5ytmk8KWc6GXPpHdSjkS6M0XS4K2+rBx4ihbLdroekF4PiitrP9fz561VFlo5ZK2RptLLaI5RfyRTISVFXW/rmtw2b7EEn0BOlkVjC+msO0LkPQ1e/gDxwZXRYVsbQhO5eCgRnHWfAGnRUvC4JKh0r+rnJ8h3vIYzouf9QeZREXOpBM4UW164ByY3sqKuchFBgo34rA==;5:LkvIWoeXMF7xW9dWSiFSwC6f+EsU3PG/0DrSvBIuGM+sCbbOxlYber15accoIJNplNQZaq5wdO+BBZ3OuygVKKtGrrkOdtusbS1ZJJkO862pJDPnEix2kG6geBbvl1sdLwQCVHrPG/Zr7yu3Ou6t9k4292FfPotF8mPdvmiGXqs=;7:Cn46CoprVF6+iU54GVnKmfd0HH0C3jF1V+EnIXU+kon8/unwhCFjZvUPSXj/wTN5y2mrRdk5wnncCx5mjRXhHMLMhK2sq8M3JfpskQCV6jhF6F85aFJaDQL8FDpb+MaGiS/GMUB8M4BErSjtEjoGXW1YEQzLbxKFvLzqFSkRUvxzGmocgWEB1c3wX2w3QxWK5Qxnsg4apdVyZNRagLA0QYLd1wS91Zu6TZC1rSGs+/zR6nnVevWQj1E4KD+ASqZO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:00:46.6910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7709d918-d4f1-4ea3-a1ce-08d5f0bdd6c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

Previous commits:
commit 6e2387e8f19e ("staging: fsl-dpaa2/eth: Add Freescale DPAA2
Ethernet driver")
commit 39163c0ce0f4 ("staging: fsl-dpaa2/eth: Errors checking update")

have added bits that are not specific to the WRIOP accelerator.

Move these where they belong (in DPIO) such that other accelerators
can make use of them.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Acked-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  4 ++--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 18 +++++-------------
 drivers/staging/fsl-mc/include/dpaa2-fd.h      | 12 ++++++++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 3963717..d5f0ac5 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -455,7 +455,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_format(fd, dpaa2_fd_sg);
 	dpaa2_fd_set_addr(fd, addr);
 	dpaa2_fd_set_len(fd, skb->len);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		enable_tx_tstamp(fd, sgt_buf);
@@ -508,7 +508,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	dpaa2_fd_set_offset(fd, (u16)(skb->data - buffer_start));
 	dpaa2_fd_set_len(fd, skb->len);
 	dpaa2_fd_set_format(fd, dpaa2_fd_single);
-	dpaa2_fd_set_ctrl(fd, DPAA2_FD_CTRL_PTA | DPAA2_FD_CTRL_PTV1);
+	dpaa2_fd_set_ctrl(fd, FD_CTRL_PTA | FD_CTRL_PTV1);
 
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 		enable_tx_tstamp(fd, buffer_start);
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 905a4e6..9269cb0 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -124,21 +124,13 @@ struct dpaa2_eth_swa {
 #define DPAA2_FD_FRC_FAICFDV		0x0400
 
 /* Error bits in FD CTRL */
-#define DPAA2_FD_CTRL_UFD		0x00000004
-#define DPAA2_FD_CTRL_SBE		0x00000008
-#define DPAA2_FD_CTRL_FSE		0x00000020
-#define DPAA2_FD_CTRL_FAERR		0x00000040
-
-#define DPAA2_FD_RX_ERR_MASK		(DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FAERR)
-#define DPAA2_FD_TX_ERR_MASK		(DPAA2_FD_CTRL_UFD	| \
-					 DPAA2_FD_CTRL_SBE	| \
-					 DPAA2_FD_CTRL_FSE	| \
-					 DPAA2_FD_CTRL_FAERR)
+#define DPAA2_FD_RX_ERR_MASK		(FD_CTRL_SBE | FD_CTRL_FAERR)
+#define DPAA2_FD_TX_ERR_MASK		(FD_CTRL_UFD	| \
+					 FD_CTRL_SBE	| \
+					 FD_CTRL_FSE	| \
+					 FD_CTRL_FAERR)
 
 /* Annotation bits in FD CTRL */
-#define DPAA2_FD_CTRL_PTA		0x00800000
-#define DPAA2_FD_CTRL_PTV1		0x00400000
 #define DPAA2_FD_CTRL_ASAL		0x00020000	/* ASAL = 128B */
 
 /* Frame annotation status */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index b55b89b..2576aba 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -67,6 +67,18 @@ struct dpaa2_fd {
 #define SG_FINAL_FLAG_MASK	0x1
 #define SG_FINAL_FLAG_SHIFT	15
 
+/* Error bits in FD CTRL */
+#define FD_CTRL_ERR_MASK	0x000000FF
+#define FD_CTRL_UFD		0x00000004
+#define FD_CTRL_SBE		0x00000008
+#define FD_CTRL_FLC		0x00000010
+#define FD_CTRL_FSE		0x00000020
+#define FD_CTRL_FAERR		0x00000040
+
+/* Annotation bits in FD CTRL */
+#define FD_CTRL_PTA		0x00800000
+#define FD_CTRL_PTV1		0x00400000
+
 enum dpaa2_fd_format {
 	dpaa2_fd_single = 0,
 	dpaa2_fd_list,
-- 
2.7.4

