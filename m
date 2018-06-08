Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Is3HExEYGlvWewAAmS7hNA
	; Fri, 08 Jun 2018 05:45:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 303FF6089E; Fri,  8 Jun 2018 05:45:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/bEWV2F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9706C60275;
	Fri,  8 Jun 2018 05:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9706C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeFHFpt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:45:49 -0400
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:49664
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750837AbeFHFpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmbGNauAC0dORskYzSpYD8BwWMBjp6NT4pHz9Yganlw=;
 b=g/bEWV2FM8njvANwx0xcs6HMqjF3GMRUzbG/bIDyNahsstgEHxf4t3TAuNsWSeZ6CvkvqfXsBNKaQxq9bcZ09Ql9FlIa1j/kpye820Y84jV2kfBIKstuuWhwYDErkW65Hv3evjdNkqq55/penLNF8cHKMTk+vWiwp76F6mM3nwQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:40 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 0/5] add virt-dma support for imx-sdma
Date: Fri,  8 Jun 2018 21:44:45 +0800
Message-Id: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:Vg2KnMvNr3l8R9ZlKZmo4fQVY1+L0TKWe8wvt2CKhZBHwNe4agOWw4ztHwJcM+QsyDnwM4NLWYcDh7jMJiUdE0wTE0exdNb9mqG3a9bZi8srZ5Fq+z9eZtulRwknVwg31H+kbmAa8l+PQGlT5U85Emc9bx5MxpWbAUJXUKC3BKXKWOlGdGg2JPm8wBviUBGpf96+jqYJR45CuSZ/gwtFjldqmkgVf5L3QWJz7/M1Eu5BuIDkMsZ9QUl07bBeKxdl;25:vV3uBxDNWNNr5zOUL/35vPZnNKMhabWD9yPiI32UmSXknCBrnz9clraQ9NDMdgcMoklcsXOO52x+a1LuYuFMRsx2/x7akZIxDmghS8fxNzCW7D8D4knGkQ1kANmlyJ45GDOUy9ynM7v0V1NxS42MCEymVvW/XyaFQL9T3A4DSDgAfQOkgCa6J276ykRMb2LQYLPjH52b9V09XYsRKXZetxiSQLf/1W02HH2rVQdv5w8pCtlggTw39/wdIgiAj7326Db49+0FzxuTH+/qz65oXnBc7nzsCrkwvMY/mxswahbesHvQdb9CmBnnOu95XI0Bb90+DYJzmy0fHgzUpAneTw==;31:hk6b9C7e5NYKlxccISh4Vz7oOKmORt7arqVrtlfRAacGfIIePpSihYdqobYtqssnFCEqCpqI+ToQks3Spl3cIsqTF+yJjQ7pAFieYJ95/m52kNnKwm1IayFjBKEXAMqeMzlM27vjFb2rURuFpfVWEhDfdybzdJ+xEky+qvyfAG4oD6/8VMXPTpAqljsTiDpSvE0DBelSCtOzCprEOeMvo8Dhap8TIC4/lurfym8IPC4=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:5jisEwyEDOCFHk65D6MTFfbjguvCgEBguoWnH0Q7avqK/RRLpG4k73+Z43UXVIY4M3B/69c/U5vJuwf52MR74RERuYhjc5BgM7n6EtqkK7cbGa+L6dIGCd0t9YEe23m9ryH2KLTk0HnE5h+4jJkoYpdbQBuXAlBuSopCIMZYniScJw7IpElbCDC5uu3E8XJ/vFJU0KSrGTy/o84Z0/H2LNRUBSWJKV/S+P2JUuHZTBIUbWUAS+PNjzmJzUnTolIwWGWtf/xyMr+NfcrH5xiIi15IZdGhile3aN7hicKUUdo7wBptVidMHV8i1uU+ta+xx0bdhgaXsOrZxC5KCx3vouFk4ORNEXblUb5FduiyoH0wgrnlKiOgt+xfGEhDusn9ME5rxqrHBDJoLFVR3IkgQ4Ntk0YFoY3MyXb8NJwn6gva7z2tVGAx9qJwbXafXVHOiN1UtT3l9tZVP6GxNODKfW539AaffX7uRXiVvy7A5nIdFl7pf5HbTZb07xs0iQx0;4:1LqL5r5i3qC7qyRGS/tSbk34MNAdu9X8bVgnOP+IxO7f4cXu+kxhnZ41XZjKqLe4H+Sla2YeRpxJ+PKblYxg9vbowLFP2wLpWTDXZo7dHqYOzxcTydg3BvQdGBlii1xX91fYIz63dLTM3F7G7owEbsQKW9VbqTDwmz3TRl56ngj7JMlVIoRCH0tx6tTtMc1JsYQ8F3kGfLnbph2HMJJGSgy/Fy3jtSOsBEvIDDWVkC1orEjpxClU4yFPdEplohI07QotsRgx2IaSGL2vkU362Q==
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232A9EC0EB5AE3FCEED5504897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(86362001)(25786009)(51416003)(26005)(59450400001)(316002)(4326008)(81156014)(2616005)(956004)(476003)(50226002)(486006)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:Ls0ia783VrhHNdbm/d/urzkd1nQ+y3t8FXvUK9zU9?=
 =?us-ascii?Q?l+2sZYU5+8GfVt1AkAf/M8qZDuML7Su4yCbQDrWaPFf9Fn8Q8gtwlE9SHcZ9?=
 =?us-ascii?Q?gXPBH5gXXjjS5rGsdb0hJeK4skxKbUjlAqguO/P2djM4qhqETJkFgCUA7niq?=
 =?us-ascii?Q?1PT0JMXaaJ/Gn2SG5FQkEJAC/fJL8yn6q7DLK9dpAMmaa9WLLwuRW2i89e7U?=
 =?us-ascii?Q?McPEFQfwAVxF1wnRQDIAdDdwI7hB1EixYPGWoxIhD+uBl3OkjYEvE0Tk5L7O?=
 =?us-ascii?Q?do1iIMteGtAR06U5yRaRi/93SL8zlr+VQVVfYp71v0pGMHR/CTI1nH7QF3dw?=
 =?us-ascii?Q?ybMczwoDFpMG5IBL8IDtlWtEkE35gvTSXz/bk+ZJxkUCuT5SVQia6aKLTdqp?=
 =?us-ascii?Q?8yo4bxQPLbGDwK/kLvj531rEvIBEw+xLOfSOsakqhEY60Ddg0YnfJOC3kUCc?=
 =?us-ascii?Q?cOiWxYN3QSPaAcCCxkWvvl9221OV3VIfv+VA3h/S77qV6OzXqgK178j85a9K?=
 =?us-ascii?Q?cfuXFsj+j72+lu634JkEZI9TU5KZfU7pAuubnfcLolAkJ0S7ogjBT9DXAaW4?=
 =?us-ascii?Q?akqMThljo9LAvHH3b78p+m3+jPbSyweCRoOSKeQ/8tEV19OhT/ZFnuJVGLTX?=
 =?us-ascii?Q?nQ+RRKv9lq1BHLv66AFeosrT7VbSgYbqTwGIzlR2PKjD2ErBRhahwUkUjrK1?=
 =?us-ascii?Q?AtMGtTL0CHE6IKGSjKxRMxRBvTH3u8QZXPILhJ091/3LCKYvOKC5jZRJbaAI?=
 =?us-ascii?Q?Nv7VGsBpy1YixJXZttjlLvCEMjBEPx8wXvvWk8GFWkR4xUH5dqTL7GbsqVVj?=
 =?us-ascii?Q?oHrND/sxiS0eyzd1Z/gO0wYzqwN9kGoo2+LS6cOVrOd6Gxhy0I/ZIMXMXAX5?=
 =?us-ascii?Q?dQYD7QhFegblgqJWcO8YEEoQ0dIBAMlLWKG1G9ZeS0Ip1HCrA0QXQHC1EEKU?=
 =?us-ascii?Q?uBX7oCGXM14hRLY8LYDsSXGoFegh1Yb9ZbMESI9jpNzDJiaefJYxmX2rWid/?=
 =?us-ascii?Q?9rn7gtQ1TcMwLa1DrBI0hwnb3A41x2/JJxN0SdfW5Xr07Ax40vRfD834P8ao?=
 =?us-ascii?Q?vvyUUR+AtLaySw/ZH3l4ueqclyAB1nm6XNYsDs++tTBT/wpZKkflS5nSIvJv?=
 =?us-ascii?Q?bz4I39RHsw=3D?=
X-Microsoft-Antispam-Message-Info: RkDItl3P+1Lt4INQfsMq4DrmFV+pf50Ad91wwctQBjP/kubDwnt/ZHUeO2a9H7zP4SK0aL07iMBxt+JuhvOpE3+HX7VOudE3EwOAtLcUxPZfVp20MDgk9r9UsoQ/fKW71IBL8czMBifwJiDhI0XXQIKCHUw1DK2aH1I+/q8EddiSMc7D7o5QpiDnfGhCL3aW
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:90kM14ACwhbAdegls7nBUBXPfipmm2K70oaeuwbr/OWldmlkyqH8vu1K5I5jjbnlbFotj156Eex7B+1Oz4M7f+Qfj8WH1/IkEajWgPQ3nwGKk4mjckrXuGaZDZxa3nC2jGFcnr42C/AtN/dZrVhiGAHNIkUz0AUi5oqTtmVth9u1F+6kSndkR8MitNR7CRcGtj+4gCiRXTfkUzT5c8Ft6koRDPwaMFNKX/zyTEvYdwbjgAXI0Xk4QbWvaAnZjTKNye8rDkrM9Sa++OyUnDzYqLI3qP++0TcFrL8EfjQUj8eJOZUMBmdgv3DBwYwOLR9dF3kYBkMO2BCFzBsXr6w2cJcG+VUBE8M1XDPCzt3n6RMhcUBT1xYMtkHKRqxa8ixbqmNf1vIe4s2Xz5ILk1ykXI47Cq1bknXw3JI8FnfFxu3+X3anUiLPtcU94QwnIG4mxHz16uWHM6nvN4lV9N18pQ==;5:wYKdvFMcHOxGhU2/SBrzzYx7Mw/mDMrbjBpvtrJV0BTMek16oTCQ3KXzjdzqJ/MyT4S9Eo54k1P2JPzrMERitxqe+f/bf2jmLtWU4CJn5F2Xh7hFFGfY/fvnfwr6ItwIpUcVsVKEydl5dLFrIEHTef2UFcpzzjmkPef9/k/POlQ=;24:MTEliqpO5+GxpFbuDkHZsrwkYBmeG3iT8CVY5MsUERQ/4ec33I9Q54Y7ixdbPk0WO+jtEu3W/ZnE6xBB5MeY11XqeuqHJ8VvrfOisj8Cz/8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:FfxC+XHgDSzP1kgUx6je30eksIcAzNI55pRflBYsdt4CDwW3sClJ7rjt/dIhG1tC00V5Pd+XBLz7SqlbyGfeV73+UJ32zHiRXAr9d98a8i6vbWWGx+pClXe9SSTH4gagPJmJ4M9ao2T2CV0r9MTJ1GO/mseBLU7piY7pPSv0XzxIMJr/ojYpVqSg6rEEmhU4IeWNGeMvwitn65rq34DORAkvHIbRJW/dUNStIwFA4sP4tqxRBpGZdcR0Dpq/UBpF
X-MS-Office365-Filtering-Correlation-Id: 2db6387f-bb58-4245-ed93-08d5cd031302
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:40.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db6387f-bb58-4245-ed93-08d5cd031302
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unneccessary 'pending' list.

Robin Gong (5):
  dmaengine: imx-sdma: add virt-dma support
  Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled
    during interrupt"
  dmaengine: imx-sdma: remove usless lock
  dmaengine: imx-sdma: remove the maximum limation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap

 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 392 ++++++++++++++++++++++++++++---------------------
 2 files changed, 227 insertions(+), 166 deletions(-)

-- 
2.7.4
