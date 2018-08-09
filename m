Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8758EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F1821A74
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vxzegNnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F1821A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbeHIMed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:34:33 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:12896
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbeHIMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyc7ioe8Dnf+A8jlYlMZ429tjoVS+WywWnx6u39ry9o=;
 b=vxzegNndadAxNsVVFIUzxvJUARc/r9v7tquqdlCYHzk6CCQLGzkt2wpLUidi87V3uHRijvs5RmDq51HpXMs3z/2vZdnzF3ITy39HSlFB84v7V0UpnytVESNfqkW2qcRroc3S4ztgpgojsiNnQG37+cSKbFROtI1JO/xkN/4UIIc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3911.eurprd04.prod.outlook.com (2603:10a6:209:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 9 Aug
 2018 10:10:17 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: imx: add lock for registers save/restore
Date:   Thu,  9 Aug 2018 18:06:08 +0800
Message-Id: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:2e::22) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6298e96-9285-43e3-ac1f-08d5fde04ff2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3911;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;3:6g6oxxaAEZfnuJ+ruhPllqbHCpQnjx99qLwwjU06+2DZ7Zprk58PSHXFUkqE3pmoDX7pJ68xs1qMnRCgIDpqvDjsxbivbH0HmWl7WOiqmN/nvJMWD8/6+TOfnTXQvqQg8AW5Ijs+U21pLoxoaMBa1hlSSXNCFDHawMy0ZhOpTWj9FTlxQYYG7Ud/mWV1iDiCIU7Qjl2OVtoPrdlEWtkUiPtj9E6uB7JrWS6PxHy7UBHXJhw7kfcDeLReYiMsUX1A;25:yNhTncAV0AKn73NWbcKx0IPKxAehOt4nTtVo5Gbmx1Ytnn1Z62vYob60j8tEtBTkZm71pGczs1sQeBV2LTVPpFfqyH3sAbEPa6zj0jMK232zGmPxddq0uFFMHxEDgt816utyt3J6wjcNR5zmgDIrZckZOZVy3ucF9ViCaS4hiesJ+3qFCW0VCFUeLUQ4aiV7zNfir6g03b7CH1aCNLedhM1UErfzezr4A2Al5mv4TRDMwkjGED/nOkyyIyFS6JDMVBxJHQ/WI1rjef7aVkzZjy8WcAZ/u8S0SUM23sihkLMb8CAxDc0LyOhWTmPdQBM8YGFHBimMEF9j7NZbb9JXWA==;31:AyJjdQ73ntP0BpZLdyvDatoiNksGs+JDu2rTiu5TeBCWjdhrzKixHUgZO9xQjo5voPGcM28ip8xatAztfkWXmb/Zq2Ok8KfkfIiZGJXgFlFdoD9BGLYwhO+VxZxsR5aX9QWQzZTCrT9bB6dEMKTCr4WIxML8YQ1BKQpNJkxScSRgqqjFz3zrFIQIwZZ1zuM6ahBIJE2FJcA7AInH0sm9ugHkuVTjqmOpiaRcNRSxjTQ=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3911:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;20:Ivbx5PhBQg1zRjK7FKFQIuqxnVP9j2EK8sp1uGUZ0679E2L1F4G1Kp6/ayQKzP3oseARDsAIVwr0u1g0xQjYNVtPSbs0mTmvNWMQZUjGzDxwuiJSSKBJ690DeHbS2zXd7eapEFdjRJv8H+wihBr+njTbo+A9wlc1kmnnSOicLtGXjgcMsE0qPu63gOA+18D+X2Bm5ZkIK98f/YEO3ArwUv6BrmPq79pQBQwZW/eT9DWEGdG1nQ29UgWK9GeXgAoJk40zomSdyb7spVdM4Fkv+ehXfAxOjk+8badzj/Rahv7PsSosiJ4/UL4kVNALDqDGS5p0OUCKqlt3JQaX7WsuJ5V6jCxSFp6PUhloV/O+/IuIGR9de799aXPjM6FtZXkVg9OC6BXMsWUSW9bPL2I+Ac81wWmlam4vZUGxEJiLgLVZtvt4pnpo/O76DOdUlMdSJgqTllhZCFUnvN5QOuCwadz2gUlBHGH70hGH5q3ZVRtyGYJPHdNLOa+JrVOnw93d;4:IMeCjeLaa4W3HsVpvye6YIniR5NMFQBx2pcszVAZkWjaeloezQejONqXGdMCi926mS60Z60IJNRbCIo41sIOidyLnUVs69QhLw3R7zvYgV7hCFOeFqL3fP5e7Dviu80HTVMjZnTo3dz6KOz7bTU6T9+tLLF+9jaDfexhXBrLjWGw0ZIu99c+rph6XiUQyImT9tEiD4v3yOLONsNllUeLyMUFe+bcB+DVfviUoK/lS8ktOpSulKQ39FQy0bkiCcJOm5FdZyIpKvLDlhB1Jwo9I7S17COg4yKv7iQMcrZMmRmUB/bqzbmoGcZMUfLZ/mko
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3911772E512F3D7A50D1FBF2F5250@AM6PR0402MB3911.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR0402MB3911;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3911;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(7736002)(50466002)(6486002)(48376002)(386003)(6506007)(97736004)(476003)(956004)(2616005)(486006)(478600001)(6512007)(25786009)(53936002)(4326008)(81156014)(8676002)(81166006)(105586002)(26005)(305945005)(106356001)(16526019)(186003)(8936002)(50226002)(66066001)(5660300001)(6666003)(6116002)(68736007)(14444005)(2906002)(3846002)(575784001)(47776003)(52116002)(86362001)(51416003)(16586007)(316002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3911;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3911;23:TVvAdXCb5gkEpyJ3UWWN6gOPNYA8eI1TKuHD6OK?=
 =?us-ascii?Q?m93TtdT36Tg9Yfgaj0/9+Fo1TexRsqU0r0NEUUd3rxa50LjhI7JoHauJ6piL?=
 =?us-ascii?Q?bTWnYDB2s9YNZnJPfxxvZXM4G2wvdM0KuvVX2o8r92Dr89tEndnvljty4FLP?=
 =?us-ascii?Q?6K3+s06ErvfyjkovFWCt4d0h95+Eop9v9A74Mpt3y0nvBCXQ7R7SpzP9rP/q?=
 =?us-ascii?Q?JQRzUxk5Ht+jZ0rujtU92eSVMYZm+TUP8+OP3dtxIFrAmGSD76Ii6yegDLpH?=
 =?us-ascii?Q?JfyNpCIhtrJLSaKcLXXFWWeTxJWP6EgfpqQkttq7fIilz+EQn7WypPbEx9qr?=
 =?us-ascii?Q?SKEfDs2g9ZW+PB8oQ0YRIEXBwy9ZT6bMkYgv75LiUvzkwDCOAeMI/elspRdH?=
 =?us-ascii?Q?Hh8xo/tNTKxaCg6jvQOEzGIoxRswyd3GR2MbJRBXL7x0n5MHyu3U75bj/fdP?=
 =?us-ascii?Q?L1i1BEV9ugQRYJH/qMSVjeVK6e/SfcJAD0+MEr3BRPC8KgGS55EnzAj7yfK8?=
 =?us-ascii?Q?xB/CUrrI1lTzAxwGZwPJincp0UOkiKC1qo2lFk5XcUdmPmJXFnp738eoq5eR?=
 =?us-ascii?Q?aXNpVkmnKQWPT+BKKTM4c+M8efSNlKP15PcOIhaBb+t8YJAYFev33g4oxqzd?=
 =?us-ascii?Q?gTjy11AhEfOFcBVfABmI2OQ1Vp0yWnN0Tioj6MASPafEWf2qhB2FtOQqgsSB?=
 =?us-ascii?Q?QNjzXOzdQz/E4ZOabfuNp6okRiHv5gWT4gjI19TmWxEyx20VeMvGQS57vjma?=
 =?us-ascii?Q?6bi49eR1qeBGE+ciL6HMRq6azBnSwRdRREZJzfjv6DlcLTynVMUvdQ0thDK1?=
 =?us-ascii?Q?Clqa98hLTURPAI5J0z3Ms2V2qdnq+7LVvazn8ELnuCwdr2oeO3chTu+gizvv?=
 =?us-ascii?Q?z/r8p1Wte1o+dhfCoet2vOVPkrEtrVQkz7NONrtfGKaQdkShGvsYrq8Zt1BA?=
 =?us-ascii?Q?XCpyu/ZXTqjXmwE0kmL0HiE+nkUFeuPiawTFrFkY/fy3j3Jl5rro5vMYh5d9?=
 =?us-ascii?Q?MjXRubXoo9zEZDbXQZBXh7HxwnH+WZzyhFLNCzXSY+9UBp3BvAQF1NFezotg?=
 =?us-ascii?Q?GVVCd0sUoo3KeFlxWDVQRljJcTiq+pDgrEiOGLU4v8UvbBXV2GZ0CUmWeRwZ?=
 =?us-ascii?Q?+fyByFyjxUNqpBDLHwMOxjnhAs5jO7lDF?=
X-Microsoft-Antispam-Message-Info: puR4lnH9LDAPJeAna3xHIOSQQVYXxijbvEoY5XWlhmVuyKMhM/qt6Y2nxJ0PswEYT4sTbHxtqiYHc9itDDB/I2RGzuv2Y9bYjP3CvVShEqvBBcHxYF2AvpyxtIyS3yW85Z/PeEZOKxDnIj38eDMqIcUFOW+9q6DMPlFYOMLEdGkAWCd9b+XjtBnVDajJmSRk5ih40WT8GYFN3yZN8RKpaokfklXN/bN6qbNctA/sE6KjmR+drVE9LUoi5GT9DrWarKcKMdiKuRmxbUgYUS2QAr4ziORaa3INs6PFAqFzZbKCo8vl6zgfEWeGGDXn4B7tN2dFLIbSHz4GdBeZeRV1blsG6qWJL+BV08w0tpF/Kzk=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3911;6:aHvYYndiqiL8SNE1mSr+D/FVimGK6d4JhITZW6FYrewCSuwfGNvlJcG4akGin/MtATukszUsU9FUl5exdQjxhSkUWkUCD4H3CXlH5xv5enfd7Ka7bQzqersAUT44DGMnfZ6D00U/Q7WghrVT/oHsxFIYwPCa4ALJeayOfA4MYo7qrygYQeyKbAB4p2EFWQVpy4oYxzFa22DMPc3LHvV1miZ9/JfGDvmrRapyDfanbALk2M1YkJjL9eSI5mhnk4NtZhPVNeMIJv9EPB+OGXPFTuVnb93il2OoTe+ke0aPvek+5tbbb5T+JvFi1r3QZhVvGD5A21t4WhCUt5OO+p5D72wGUNtHQSuPnwPd8jHZrlp+DIcinfbgK68lC+OuZst5ivz6Vm+V1QdWW2fhYt6LOKhnQP18Nd9f5sM3tUjdIklI1Lba090wr/w4zWoe7mDKPHY+9/uuEOmwpDvMBDNTbw==;5:FohrZ0mOMaRCo+yRqs1+vGIn2V71JTapdWoRmSBfsZ6HJoeWIh/RrtOnwhLei59zeJbe5J/1QymwS0DK6DtfbEuejCE8KkdueCeow4mDbBy9yiNeE/0oRGDyGrtsyvOi/BaORf4MwmwSB9cLWRgea7+U02nE6Xtd1kZEOzIWs/I=;7:AHSOdWCayrwKLHLx0e/96+TvCUKCUXWkzV6cqu7G28y6juhlibKIenvQByggM1FkOHr+SCDjAr2z5+YOwS3ZERV0zDnzBNPBPqcFHSHCFL0hVyV6TnDDajNdq03jtNep3CufhWXIfmukEPK3lTwS5kz8Rz4aNM3nAEdzI/OTYnbar7WYLDUKy5MQT0+YMsHxMMB2M/w6x+AlJH64RsUti7cjC8aacWl0cHI+S1CRs+aiJfzXD5MP9eydejJhHBtD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:10:17.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6298e96-9285-43e3-ac1f-08d5fde04ff2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In noirq suspend/resume stage with no_console_suspend enabled,
.imx_console_write() may be called to print out log_buf
message by .printk(), so there will be race condition between
.imx_console_write() and .serial_imx_save/restore_context(),
need to add lock to protect the registers save/restore operations.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa..a09ccef 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2376,9 +2376,12 @@ static int imx_uart_remove(struct platform_device *pdev)
 
 static void imx_uart_restore_context(struct imx_port *sport)
 {
+	unsigned long flags;
+
 	if (!sport->context_saved)
 		return;
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
 	imx_uart_writel(sport, sport->saved_reg[5], UESC);
 	imx_uart_writel(sport, sport->saved_reg[6], UTIM);
@@ -2390,11 +2393,15 @@ static void imx_uart_restore_context(struct imx_port *sport)
 	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
 	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
 	sport->context_saved = false;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_save_context(struct imx_port *sport)
 {
+	unsigned long flags;
+
 	/* Save necessary regs */
+	spin_lock_irqsave(&sport->port.lock, flags);
 	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
 	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
 	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
@@ -2406,6 +2413,7 @@ static void imx_uart_save_context(struct imx_port *sport)
 	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
 	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
 	sport->context_saved = true;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
-- 
2.7.4

