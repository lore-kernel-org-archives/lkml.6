Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B852147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="MpkMBw6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfBSRBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:01:54 -0500
Received: from mail-eopbgr780088.outbound.protection.outlook.com ([40.107.78.88]:44960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBSRBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ovu453p7F1e/4k7mg0C+F3lnEg5Yb+cxHohqDNu9gg=;
 b=MpkMBw6T5UQQq8sRt3a1w0vw3jeVB7VF3KESG7fFGJcb1w6LziUEWqDt2KDeCcedUQ2aRGe94p+PzUZSFZ+6m53Mi2QL3fGExqcaPsE07ZiTyg2r7EwG6v/C6ywSvcuilq6skYN9RE2+AsKpzwl/YKmWpQGE90rBJvAdxymApJM=
Received: from MWHPR03CA0053.namprd03.prod.outlook.com (2603:10b6:301:3b::42)
 by CY4PR03MB3062.namprd03.prod.outlook.com (2603:10b6:910:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.19; Tue, 19 Feb
 2019 17:01:11 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR03CA0053.outlook.office365.com
 (2603:10b6:301:3b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:01:11 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:01:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x1JH15As029449
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:01:05 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:01:05 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <broonie@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] drivers: spi: core: Add optional stall delay between cs_change transfers
Date:   Tue, 19 Feb 2019 19:00:36 +0200
Message-ID: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(189003)(199004)(476003)(486006)(126002)(72206003)(44832011)(426003)(50226002)(336012)(186003)(305945005)(7696005)(7636002)(51416003)(316002)(2616005)(356004)(6666004)(478600001)(8676002)(8936002)(5660300002)(4326008)(36756003)(107886003)(14444005)(50466002)(77096007)(26005)(2906002)(6916009)(47776003)(48376002)(246002)(16586007)(106466001)(54906003)(2351001)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3062;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9defc34-e903-4a67-fbfb-08d6968bd93c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR03MB3062;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3062:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3062;20:suGAzGikLeX1yaUNTQgL2aSeUdPLZhIVbpJ6ix3BbwEC7VF8PbiqcPfpt7PHTLdGQ80WKF+qNDuN2T4Bg8O8GahGfHpSHUTVxBUMbJuJMIt74vRFzeucdLFSnm7e1EAY9upnTa/vXduTMsYaCLF9NAb4t4CW4Rq2zrgt6B1dpSeCAif2nA9NUCRqaPbo6tCA+rSJtNHdo4F5qIXCy0y4wPpOpojCpdtKzhBcdVKQDmI7kGjehETWYVg6C1M7QSWVUWq1WgXOHiOB0d38hHb3ulD0O0Rad9OZ3o7BnitDH79LIr/UJG6qT5nSbetwotTARE7KxYltNAZTVxC4YiA8990GWlqi+otGbsY+fw5MPG1fSHsRtOTFTLjCtLDiWqxIUAb0bQqKHqKZ7cNNF0wq0XniUjmuDupVox82ZiWB8sJIsxjGhsAbqwSmKdNfcHDeR9N878TGPVFx7WQNhs+GLABUgzfpcwJNJi2s4dish53kkrUeECMSVkqe6gWlWr2J
X-Microsoft-Antispam-PRVS: <CY4PR03MB306224C7EBB0529D403FDAE39D7C0@CY4PR03MB3062.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3062;23:tyzdtrxSowrX/IZMLw1eIMMZgdhvTDcZmF0wXhkwv?=
 =?us-ascii?Q?xdOZJVMs5IU3rqlDCGhmYAcoTEWpiNzRzURlouoZc9cRu5Myyv+SLi1Hgoxg?=
 =?us-ascii?Q?RzDOsNSpVVJaby5a+jKcWn1ixbf/IHnYXB+Y3bfUM8zTwO0oi/GP+4C2dfiw?=
 =?us-ascii?Q?ygFA7nLgODab7smYqAunC1Sr1Y+225o16SDYa+L6O71Ff0Mrcw7BEFp9fGjm?=
 =?us-ascii?Q?sNpG0eIR6515ushB+8Ui+mD7xA2kHOSyp61e9oJVMUw9qSO3EKLfK/MHKE1H?=
 =?us-ascii?Q?QhwlzM+f8egjpxqu45CyHYxoI7RigrEie44zU3uSU0rW0Lkv6Ypz9aUCW5j3?=
 =?us-ascii?Q?9G/aivByj4lX8zcjhXF9aNygH3Q5LcjqQ1xWmWOiFOdbU1i2dUHoK2O4+Zdn?=
 =?us-ascii?Q?HiOaYPM9nxwO5rR/OjyqqPspZWDL8Lo0YFFI0litBzy1RnG5CsRQvLbA97O2?=
 =?us-ascii?Q?5upUbTv/YZeRur70ucmpN0KevQs5DBzwZy6LlCeGR5HTH44Gle8FRcavJcWM?=
 =?us-ascii?Q?jURzdvALrCcH5N+mNb9UmjG/oNMcZpzXUFBwd4E2tavbiZHfcUwUCVYm3fgT?=
 =?us-ascii?Q?gwmtPZrPnEV9Ckg5oKATqZCOiZspeVq8oBTr1CzsE5WZgidp3Mz6zlqR+jqf?=
 =?us-ascii?Q?2kI+eQHec7c3NmFPCPEO0QbLG6m3SYqzowEPX9ziJqGarqZR46VzTofMlQ8w?=
 =?us-ascii?Q?T/rhd6bh+EEGuML/tjH0A+Afm/x9lBM7poVMhNwBRMT/JNFiSz+9Irtk9ZL4?=
 =?us-ascii?Q?X14CMG0L2IAk0YC7T/CsrnG32hK7LB5N/LNgYjpawnxyeNk1RuaHzAkriovg?=
 =?us-ascii?Q?cRdrZ+Uune8QZTPVwWspKvgoyB3fJPZSQKwIpPSBnDPJAgsyAlqeywlJG1de?=
 =?us-ascii?Q?IVOkjhvqqgS19h0iyTBczvEzfY/oLrsZZNsoqmYbMA59jl8ZEBqlhXL3ehwE?=
 =?us-ascii?Q?XW39hRTi+jGhz6unlEp3Yjzbfn4u71xQZf8/NEdzHzJokAfPzCIghjEkXylG?=
 =?us-ascii?Q?0j0foCgTSUQPqgKC8KsHdPe?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iE4eFDZmk4MYzIUNPr+fdPW+AHQurtDVJgWE9EUBTSYN14pJ746ApG5FlIt2m1LEjD02facXUixxaeaQx7PRYmqBxt7X+gASQaoV4VLmu9DhtlZEdC4z7Q82QYQYb9yfBKZIe7lddTqp4XHdhwnMY/8UAXbpEDZqM18DMjdOqMaeWYpMYplPN8tSMtj+a3rajYvT/AuVcZVITbNuFQSN1dGdA32DiKTx0xFfIyRRlGg5Z8v1dMILN6wF4zU2EdYWL8tcDDGDkw4qg1G+nKXz4ZckIWmuX/g8Gyq3AY65d4sjFbFNF+Xzkk7SNo2pj2/TARmm5W0yhcMtJJmWrAzxUk9HiAOT7Kr3K/IrN0KYkRoSC2xg8SDroTMwrSwQSQxkacIUP9WstORe0kbBYKEbr5ZDXHJGdXnpMU+nU8Ijs80=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:01:09.5910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9defc34-e903-4a67-fbfb-08d6968bd93c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Some devices like the ADIS16460 IMU require a stall period between
transfers. The default value of 10us are not enough. Introduce a per
transfer configurable delay.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7..717b92a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1144,7 +1144,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				udelay(xfer->cs_change_stall_delay_us ?
+				       xfer->cs_change_stall_delay_us : 10);
 				spi_set_cs(msg->spi, true);
 			}
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922..273774c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -702,6 +702,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @cs_change_stall_delay_us: microseconds to delay between cs_change
+ *	transfers.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
@@ -788,6 +790,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		cs_change_stall_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.7.4

