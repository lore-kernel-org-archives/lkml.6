Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D806EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DD021523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IprD35sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DD021523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbeITNG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:06:58 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:24331
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731305AbeITNG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFvDXoBETCnFhcfjyFK8WcqFr/nEtdpYbRd7baC0+Ck=;
 b=IprD35szaCP1jadQYzeh2jk17QWu0yK2kE+LdOKlH4uZI1/50sot4ybm/Jrsaq6Q69SOCgiP3Rtq3rFva0RHTlUaaFgGtvYkd3+uVEghQdp0auF6gHDJ9FMmKLVJkXQWTmfCzn72uY7Mocm9/1vi4E32LetsYatfK2cXQq+tHEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:73::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 07:24:48 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     jslaby@suse.com, fugang.duan@nxp.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail data
Date:   Thu, 20 Sep 2018 23:26:00 +0800
Message-Id: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0047.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::35) To AM0PR04MB4530.eurprd04.prod.outlook.com
 (2603:10a6:208:73::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4fe28d-ed52-4bdf-6a5b-08d61eca26d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4530;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4530;3:9W1ez9C9HIiP5CHHFYrUZI0EhnTG+mCLQ4ePHt6XU1IniVAgR2zwfwuJQ03pk19kUQqg0BcVCca3LVq3CliZfvaBHQt1ag/oRVwRJ8dHgfC61JiLUfRX/loy+PHq4kqU8LvD40xXjvr63DQd3rGi3P2hKizO+8K0M8BUFf7Y7gal6JTUlRmh4v7EHGjtotcv0vFkkQ/LNMFCL1JFHooN2xNyMrgOBXfJRLxvA5B9vA8NMP1X7I4yf+6rB5QHbf9b;25:5I4lm1jfZ4PT7fRIOXyRzjFh9EG3BNCsPnr04Gg93Yn54eX+mEjVyqR8VS4IpxiJkTxYlo/h1tc48Wlv+EV1cxEwJ/q6s0/Wb0UiZhpRiIOjDLdTWzkK6jzo1iYypYMkPYzTykF/uk6ge4DxA/u9kXo5VAOv1wMInpZITGaBqFLK5YSuIcZFN252wD2ZgmWeC3sL0uCUgr+n+m6HijjMItr0xKXQqC63dMt/GC7S/jY5RuFW/EwuAS3tPVjwObFoK+Kl6NX4WQGM/uOSxz7DZRKIVAYY8pGCHhWIAtA60UbKTKBytD2NmyK7RjyCE0fuVCUHU1zLPkkhT3Cl7t/q8w==;31:0DXQxU4gnLsNjlqlbgcEcFEvHWG4kB3jOSND7px/GZl3njokhrhMr6lxXlMpli0SJx6hSxXZEUPU5pYC+BXKj5Xf0R9GPqw2cU0ZjQc1Bm+2GdlLEzTzNJ4ISg9/XYQp97qyIoQryXlsldc5+M+aZKTAlI8ssFO1mhccNFneRlhmgv38AhCt5PEHhu4eicgpuXuAYSbJmeQHRqbSagX8YzIspoBJbrd+aUGSoDT56dY=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4530:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4530;20:UckuLzCpdTTD51WaXWoSSKN7YfXzLTGidKf8BsrObvLUMpMzLU1Mp69BxriaIN2Rd/8P4KOSnfipp5CTxWZzLkV2gy/Szfcbl2bohQ0NQ9B8MsCCVM3IrOK8TY35dMUOAnwkMDG3HSmCgYqU6adV0VJ2TzPdWlm0udeu1svaB+NrR4TB9XV8o4HQvde7cJLS9DZgoi1KPUYR+e0G91qs5z01ZoFb5viZeB6AH0AGug8YzSuvS516rDjs1OjpNhnx8ERe134y+hjkFamwFkUFKxmW2LVQMHr3cLXJZ/h4VYGCs9VYQDmkge94vxOfy9qVqc2bEOVjOKb8s7eEsSlT2JrDexvptA/wkZJxvmxkff/YY8gd4sw+JnF1acCnC2VyRMNTSS9p1jEUvdvPp6KiHDbX1b/NU4Q30e3A2APuoIOyZ6RO4gV/iNd/Ot3OiuPuUVvbSHfRoEqrTdmA/UyqRHlTstaivHVeXlvo6b+M6WEbwaWduKMquQMg5BHXJ//e;4:u1+pcbepLkRqfinFops09qopc1hK0WL8YiS+W8qgXMGNKzA278I8yKtB6YuoWO/mD8oMd7R1gvibbWr5Gb2WVMFsROtzzCsFT5CRlfXqVce4P41mgbJmiAyqoZmqsJVPQtf5SME9M4eGwxx+fBNjImnUnJAzLHPBHAg///p3QaEcErVgicquu+GjwSm3eDHCkQVOhnI5dfXqS/oD9/MY1Z16jILuGTjtV5MQXECwVjhvS3QwO5+/GCAo+xsJFopcO4sCh+gtuSgErAXIqio/yYzuKx2oN76yYpAA1OmFV20VSaorb4s0b1g4f8g4PoHP
X-Microsoft-Antispam-PRVS: <AM0PR04MB45300679687089C536A5D2AE89130@AM0PR04MB4530.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4530;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4530;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(476003)(2906002)(6486002)(4326008)(6506007)(6512007)(7736002)(68736007)(2616005)(386003)(486006)(956004)(305945005)(53936002)(16526019)(26005)(8676002)(186003)(6666003)(50466002)(47776003)(97736004)(14444005)(105586002)(36756003)(3846002)(6116002)(66066001)(8936002)(16586007)(478600001)(5660300001)(316002)(51416003)(48376002)(81166006)(575784001)(50226002)(81156014)(25786009)(86362001)(52116002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4530;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4530;23:CtkoXVBYHRpESsNekM54VBnhaKLglTzSY6mkD+8Nf?=
 =?us-ascii?Q?4l9Bw5EA/b8+7kT5jbB7/Rvxq1c+KttGQY0lt/CocH79kavxvop5NhhN3BvK?=
 =?us-ascii?Q?9DxuXf2KcISiX8gj8KK+jf4ucfX/DF1WekwAt5I1/SZCbGaRywOtXMdWufDb?=
 =?us-ascii?Q?SQ7YKCKX0PRGBw4SOI6LQi4y3Na12byjUDQrEu1yw3r2jFBx0yFuKZ6rkmgO?=
 =?us-ascii?Q?OOBAHpPOjVFEh9kSPnGlwpvej1555Bd4ey7kgiAd88ZA74b8B5rIC2MeYkOg?=
 =?us-ascii?Q?y6HaTQHNBYPzMxHuErndodrh3AAcA6TGiHEOaP69v+CQfd0NdlgxSV7NQmGA?=
 =?us-ascii?Q?i6KU1f4gP7VlpkaEGljrTapObrhRrSiE0TNrzvf/MjNF8idGyKfgIZ01CDVt?=
 =?us-ascii?Q?OlGlo4AqbVZEALjH2i42z3Wl4uv+qjtPf8vPpsKraegpEchgDGqLIp8LBRds?=
 =?us-ascii?Q?WvXdmQ9Isi7DwrnXK9wQs/+HKFMZIO/8uCnuNuNNvPJqY/p95Wn7ea/Mc+0g?=
 =?us-ascii?Q?dFIGfDexiGElnXsgJNmjpmy2F00z3FYbZ3Dpci1C5YWz6WqG0JvCqqKfprWk?=
 =?us-ascii?Q?sIgEysMcdKO0xjWpMqSXQSRkaVT8Vri0Q1Gq+ndEEUBgiPpNloazpUgDD22l?=
 =?us-ascii?Q?rfCbTcv0lh+0DiYV5zaaxCga34W9PzncY+muBc3KWZLtV5MgZLOBcsHusTFw?=
 =?us-ascii?Q?iYof8P/e2mwPfFytZYYK0E58dpIDE5qFA0hJmqrlBYGlW39tHwJX1JQTAh5Z?=
 =?us-ascii?Q?cDF3diHnrqrFkwBHp6aiBtFuvlgF7FHFhsjEvwB9KZZpxsyCy/yLLcG7+kat?=
 =?us-ascii?Q?4PB9S4fcNsqitlG7Et86DGVr80sCHQnXdDw4KBrKLN9HfWWRkf9AjmAWUtwL?=
 =?us-ascii?Q?LAwtOXrv0PvisqmWbpJzMJkyyYEl3DLuNHMSCXaJyrzViJVOfgssXQcKeXi+?=
 =?us-ascii?Q?RvKvNjgQkXuK8ZdbPHVnZc1VAV4nsdaGuSIkP2J9ZMRluHQ5GYbW/Z8iBY4e?=
 =?us-ascii?Q?9PwtbZVqkdUdwenk529OQycBDCsIHYM7y4LoIEo/1jmiBFtZHHmkvo4oua+f?=
 =?us-ascii?Q?KF+tBWjdW8xdddrEWSwYKSo8Od3Z4Mh2HomG+xHHyt1GF8Joed0XBzEaBdiX?=
 =?us-ascii?Q?XQErlh2uAhatA2EWO/apnBgbjCN7vFg?=
X-Microsoft-Antispam-Message-Info: /vIpsGTPyy5f1P3SMoSMCkguyJF2iA77AeuksiB7VOoIyDTpLSY9+GH2bfRO2xeUDN7xJQSg98mSPhq7qUanBgwo/5X9ruREbjWMKoVWnFWJygiavoZ8BDKxGt0amAlGWJDC2LTH2fpfmB13BWzmTz65IZ+k0TDEwt3bEQXeudK5PFZIFx1P9hh4jnaRCdppvFqUP8wCbPsdExF/oIzV+DzpjMxCmLZ1Ht4C00ZVYuSXzCzbcH/dzHtYIxgXpqwJuEEO0VQb4HgD+FaUD0Tc88GIaeyWYNEk7Zl79rF5QW0llukVc+bsBsgZx0InHSFgIHlxF6Y+O92Cm7eVxaW15ZOZ78Y8LdcReUBTLOJKPKA=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4530;6:UAqyrAoxtxgVFBOtnQa6eDdrRvgWjcfM0Dzqq8OFAtYJkfq0P/liUFh+xhSnnNBMsKGk0MW3B2b4UE9lqBabHYWSJWY9OG6fTng7SldcJicM04nrwppnsALfBlyNPhMMQkr9aHRABchZ2LY53Wt1IcIB0XF/EWfESkzAQlKuIzmO/0+gvEo9UCApcC8WOjIvX3XWgt6wTIJlTXJeS3Sb48cBI0tYDKH8cLrnaZx+h5C9+2y9Gy9xTT+thDU1o9tYxg8R7Vs0DK+9wS5XRYRrtn7SoccYzEIB7VNbfH6YVAz9q5kYqUkqmVkmhdIG0DkaikB++g7wyAL5uO6m8MRFZNxaInknQA6dpK9iKHGcmcX44qZE06E5rpWwoYnp/0xFNNP6rIoahCyrxNtzGu+HTsRU3L6+WOZdGfQzR9YwSdW0YeECnUoFsXGI7JAPpr1WZDBbg1vfeKxvJv/3fCJetA==;5:msYuCn44kaZzktj4iPij8XA5zMBm3/3Si8e+iBKwAodKq3+H+pUDJY2J4CJF+VTO8K2IQ9qQYumJcBvpvbDi3PyhzNB4joH+ZZcDtucZ+1K6SRcyFWHe0pgtAeSTMIe3y1lmAmEwnqw6W5EW9RH0PJPfO20g6UTaN6zBaTiLc6s=;7:TRrPqZrKKrREyhRlfhtYGdraw4S24wx62/NWjU+LnBzqnSL+XvxpJvEImhu/hRz22TGwOmZ3jbTlUhYOSli2vSVWnjRr2PFtSseynODrL6TOBKMBHiq+sTpMRE03WgU+onph6pbnwdueKv4zazJ5LM+vw9aSMcmAVvkjH/bD4Xu3qRwlE+xO6CF2uEqVEMWUHdEbfW50sI+4Z+qEhlpnLg7Z828SjjWPU95jYaTUH6m3+GKjO7oIfEjBZcf4vg65
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 07:24:48.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4fe28d-ed52-4bdf-6a5b-08d61eca26d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable IDDMAEN in UCR4 to let sdma script has the chance to detect
the idle status and transfer the last tail data with the interrupt
notifying uart driver.Otherwise, the last dma done interrupt of the
tail data in rxfifo whose size is less than watermark may never be
received by uart driver.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa..bbb1693 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1278,7 +1278,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 
 static void imx_uart_enable_dma(struct imx_port *sport)
 {
-	u32 ucr1;
+	u32 ucr1, ucr4;
 
 	imx_uart_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
 
@@ -1287,18 +1287,26 @@ static void imx_uart_enable_dma(struct imx_port *sport)
 	ucr1 |= UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN;
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 |= UCR4_IDDMAEN;
+	imx_uart_writel(sport, ucr4, UCR4);
+
 	sport->dma_is_enabled = 1;
 }
 
 static void imx_uart_disable_dma(struct imx_port *sport)
 {
-	u32 ucr1;
+	u32 ucr1, ucr4;
 
 	/* clear UCR1 */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~UCR4_IDDMAEN;
+	imx_uart_writel(sport, ucr4, UCR4);
+
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
-- 
2.7.4

