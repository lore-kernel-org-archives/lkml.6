Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD711C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFD52073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Y1615NBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfBFM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:26:07 -0500
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:2417
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730396AbfBFM0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERDDVQFvTAlIYo0H9RHvco2xlFQar8bni0VwCJ1wyhs=;
 b=Y1615NBg5MzFxKRoMxCG0JZI3+QHQZZg4OIVbWSURW5BsGOo+5i6aT53Ak83KpBwsH2HyqM/fcHkEjLFHZoc+zsoy6Hw83hQU0pl4z9lV/DHbifwaB22v4Zqb+ZAapEeLzeVp+dZVvdYCi99YzFJSctaZFS/93rF09cFk0SoZS4=
Received: from MWHPR03CA0012.namprd03.prod.outlook.com (2603:10b6:300:117::22)
 by BYAPR03MB3752.namprd03.prod.outlook.com (2603:10b6:a03:6f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Wed, 6 Feb
 2019 12:26:00 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR03CA0012.outlook.office365.com
 (2603:10b6:300:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Wed, 6 Feb 2019 12:25:59 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Wed, 6 Feb 2019 12:25:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x16CPvcx019469
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Feb 2019 04:25:57 -0800
Received: from ben-Latitude-E6540.analog.com (10.50.1.129) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 07:25:56 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Beniamin Bia <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/2] staging: iio: frequency: ad9834: Move phase and scale to standard iio attribute
Date:   Wed, 6 Feb 2019 14:25:42 +0200
Message-ID: <20190206122542.18362-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206122542.18362-1-beniamin.bia@analog.com>
References: <20190206122542.18362-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(3190300001)(199004)(189003)(72206003)(246002)(2616005)(476003)(14444005)(107886003)(11346002)(126002)(116002)(44832011)(486006)(106466001)(426003)(8936002)(446003)(305945005)(2351001)(6916009)(45080400002)(48376002)(1076003)(50226002)(7636002)(50466002)(356004)(6666004)(47776003)(4326008)(36756003)(53416004)(54906003)(316002)(106002)(16586007)(2906002)(77096007)(186003)(8676002)(336012)(51416003)(86362001)(26005)(7696005)(478600001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3752;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT029;1:9dfuxXrXrSReKVBrzyj60y5zi95kEYwh9QfhAtZPcGfLM4uD5f4pobPjTOBQxhSZj7G1LTkNhzWWdrn1aG08S2Now6bRkurEKo5QfTZ0ibXdwOGn7anqmhHNbR9DdzXNUtmYj/ZiZlEZDKqqNLunaw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d6e9f7e-5ef8-40f7-fae9-08d68c2e405a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR03MB3752;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3752;3:mHL0GMalAuY4RiTZmV1qUatZOYdbRwPXsUBu1EfA3Ncdx2ogzIFnczkfcHHMlWtA7vxmSDtdwb0MmwBuqmNxIXtjLRXNzN8st7WcLn6mKpYteTsGOPTvKaSeSsGC7j4EO7MiQwk5Y8mPqQnBmIB36KN9Z8kIDuViyLajGCRrqZ/wrbsf7CqFjGNqctGmvq0u3sTnzCmw0pMs6NJAywoTYSFueLlSzjvyBG34kShDkD1hSB0H4jXFDfqMqWWVGoZ6CY1SmV9kY6UgQUFDUxLjyUPALnCJvSTYcNIifC17xX+ymfTEuaQ/dRpmRpCf+MyZDfA6lgxCJs4KulXfDwgkpIj4IZ5eMl3KAFLlIJRjmzwRPmb3xRF76A5lyXt0DyN7;25:9m11l7rmj/aQPeYmmY+Dc+J4UoQ7XCq0ZgnMZyS1pS2Z1v+YCajWfYPl/ekXkAAfNeWRw06qbW/V0qeliKFi5zIdEETaUvxyxH9Gh8pXYNChRzA/TSN0JPNrB41Sl7tH+E93W2Ztj9+t5Nv6lp6QKmKI6+ARXTMqmwaPs6pUyBJai7BJxz+qXHADKjiN2wOhUOVO6vt5L+AGB/4/SL4yghqoU0bh41fpsLAj0xwFPvBQoHgsxOkuWLqsfEGpqG2isDOY/LL2M20dWWzwBC7UQBq1M51ppzUuVn/uq/41zwSNlQWUuz/ACRbfSA2vd0TH0KLN2fB6tIo+nFKcLZoO7Q==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3752:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3752;31:d89FqLKavI8MRrISjffcwZu9PIMHNv/wszmGTLJ499vmmcGA/pOiXWRox7PCAUa3kj1XShFTbnRWYaRiYyHX3Najw98kd0zUx+OUqjzT+iVXNKlMXqAnEdYAKACLatgBS7K3JzmfNJ2cpD5IjsOTez6dmnAoOZhTASw5HJBfKLJNoji47fcclIerFdOsR7AZOPlR9/O/rLIgZENSlGNAF4GlgPYuLFNauQx1SnyL/ro=;20:l3C+8r0erxpqscpvTILiu7kiFyozJSgYJBZQpObaH8ogpXgCNhBlxWQdAYktPkfU3ywsf2MsVFo31+QTbH4L0g/cJZcNS6mBJHVZho+myUsqgbTIUiHL3xvnQgTMxJfuxUoSUdrPOmlURrYzSg7LPLp6FJ+CMnlYYJUncadMGvcQqXj/42IvK0K9qL+GZ2v0N4h1gf0o2iIotRZGoqgdRWRprMUqz5dz9pDMdAS7CFO8fTxVlLpzpSk/t6vSh2bvMOhOIEbD6a3bhKOAroWLPqQXrJHz5glXDYaBke59xeYp1w44CKjNb3K1ljzPtSt0IlZS6d2tpSc7f8LU6+oiZizASrrRQIR3O4TrHpOUEVQUA8hKhjWBwVew2Gqip9UikUI8Wa1XolewFBfMM9NGmQWWS1UvLtLSMPzqhVWFGdrKSg49Q0LVl7/6uKK5Cwn1cAFNziN0PYdgV5AZqDzEIm+GMkHl84g68n4Hl8mQ4ZQXjjkzTjZv5tDSQLSoXds4
X-Microsoft-Antispam-PRVS: <BYAPR03MB3752AB9F06A29A6B9F2D25F9F06F0@BYAPR03MB3752.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3752;4:FPf2/H29bCk60msXRzVVz3M3oVXIERjuP0poSzcZBIop7v4QieJFWtlMdTxEYQTb7Ywc1HS0yE9tiC5Dwf0pIvzJ8TzdiGTsXPjlQYsynk7cOEltTo1fMdOMHgEzYP3PAJ0jUBcF8XlcW1TXRxUGIInvxYgzQKEANh445hUWNXLt798CKxSgBLdjM1hyN+9Hi71bV/R5cU5N3W+MQmJAom95EOY0ZERNnkUP9/ZYTe/PkwZU5yiMYw1GIAgBw66UqvP6UvIBnqrTy+p8s9LXysTyZpn0vpyInB6Ca4ErZi4XoOD/zEeuAwo544QXdDk/
X-Forefront-PRVS: 0940A19703
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3752;23:7m2CB3IoOmhT3b/qn7apvZkTgOXTSYBrNfuMEQTqC?=
 =?us-ascii?Q?8MyRc6BRsScKOIrDlxPCrSeRcyAf8O29iGqwRRSjgkTe/wEHF3nH/3c34UXp?=
 =?us-ascii?Q?S2xIw2HMfogTLA+AyROMU3EgmBClWBUKrwdMjanMYC+OnsewXhYenDHagdH0?=
 =?us-ascii?Q?TlXoIP1fbvbTxijcBMIrquGIXAYyuUdeZMqx5i4RNxtXcDh/lzir8mG0x2dp?=
 =?us-ascii?Q?O2BlkY9R1daKcf5xhfnS8dzAcQjhCRyjapZ/7cLXuD3is3UmsZ9YdTUcQPS3?=
 =?us-ascii?Q?Bxg01+KjN8Bq4xKDCTeYLK9MPtduz+/zmhlZL0/iAQciC5kj0ilDgwgFEcsZ?=
 =?us-ascii?Q?wRxuxp7GoO4C+yuUZxRYArw4aUNLqnD4JSrKNGvxJJJkNbSPNb8OuyJ6xZDM?=
 =?us-ascii?Q?X4tZh/F/0pt5wczhmED/dz8ZHk+eQLh0amurqn9YTTFFm42Bi/Rq5ybWedbc?=
 =?us-ascii?Q?jjGZ6HFk4muEgQWKqJmCoKOP8erjPx77JZjUufITQUUwEf8poUaKg514PhJA?=
 =?us-ascii?Q?1/3eeI48dW0k94ZYfbtJ0dGXjYLKnv/7MtvMScZCEi74/E0h+uVEH5vRaVh5?=
 =?us-ascii?Q?4m9alL6qvH5pFVCM8RnO0qDhVw76DgX5koxjl4lN6UdKrM41EZCvGCYEWRuh?=
 =?us-ascii?Q?NJUD7Gq3F872w0wSsMu3SDbDGFXDWzuYbnsgkxoaXv8k9pa1pJn06aMo9c55?=
 =?us-ascii?Q?ekyPFdseXmAGFXRb53fglwSSFmB39AP19hIbpBZnhVSAAFHsNbr0oT2Aem08?=
 =?us-ascii?Q?eL07Ih8bwczzVrJUgHXNooYLjeKCNIwknTtB6rYyafHroNXpsIdAYbO4IqON?=
 =?us-ascii?Q?vL6JPTFC5bMGVOw1eOtMCqc1GKe+VUGNQzJgICdd5BEJs2HMfTwlsARpA4rS?=
 =?us-ascii?Q?KwIGmqlZjTX59dIwavwV8mfdan2hRJzEENlH9AOQR28TXVONUKhVTRCaoeyE?=
 =?us-ascii?Q?x+pO3lVKK0B+aInrjOI0cPcC8K8/PtXsxLJMaGfVMkTw85ptysdrG8HvI0RJ?=
 =?us-ascii?Q?Di0VCPe4OivDaFPvO9eLDLz0oDPWmYDbZhQRgy4JEmRo6fjtIdE3RZUPHMyS?=
 =?us-ascii?Q?bKKRLAfqz9r8ZHP8ueH7IuggQKQJBFxZRuiGv1jkZFHU/nOv/1X7j75LWxsD?=
 =?us-ascii?Q?4LxG18pWTkY6Ky4xNGgWBQNw+q1hl6x8CKvnnwbx3/hAs6MnikT2rrwTeDmr?=
 =?us-ascii?Q?H+s4Q+NSFogiBs=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: biKgn//tIBRnrUaDa1SP4TOj1DoAAHG1WMR6gATCq1+jLjcAz1SosTHWppfOVT7sjYH5FLtCtwvU3BJiASbGCoe+H8OLhUxDPuvPI/LVmgk4mHbRWu28BzrI3BziVjLTWfEnZY4CdeAyzTLqRB1AL90EsZIvqfOjUQCFNAUc7kwBi6J5eUvqXxyINMMHgip92qTDxnL7pd0sN6Fpyv+sKPWWWauaxQa7RkwJH+e7/ndAwYE8e0UdaLlitBpQr8G7zKRCafaVVixxXq03gyojNzo73SFIiXtJMt//J+Bmdtwb7oqXzXtIPutyV1g2cg/qQp/SOAr7oFOXI7C3OEA+xRR8SZ1Pv+R4yZVdD10mw3NKlFZlMuGshSSSwUx7pRqyW5/oeyaXuyOulDjIs2vNKjOiqgBJNOt5bojjnAsp9/M=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3752;6:XkXIscuDDEa5F55ea+LETpp/sTsqEVZX4uBo+1fIMtD7jSlM0rBjNogoj6A4phNHGnkbwOn1TZinSxNEPhK/9UJuZNdyWHst1U4fB7BufEll9S5yp8oLw3smudoJjrboRliJ2vWPL9PpoEytK4dcV7iIjNPJy0h5LDyyh+5v0NBZir4ehrPOgCqdEHVc2FZ+Y+/4fMKC7EVrnnCqB9xBt89ioFzLD1tpC/nl3h8dc8xdDepQgMXme9G/c6Mi6HlvKhsoWr7SqmeFS/LxKesbaK4OpDsmXwWuf6EfLcY9C4qbybgSDB+nB5WVjG4cx/V8NELwjnNB49SyVUCSuRbrISfnXB6wnOGDRKmuoATxcRkF7C2cNwYtVd828gaASUlC+cSGUT3wLbpGcyYJGDI0bEwM/ugN/JRijR8EKhWGjplY3YCw4duXm2Gm7jr4SbQdhwUqNXRQ1f0VXey0kmOU7A==;5:MvmC+DEjZqkSnLEz2XhgY/lZR8M03ka+SHPpPJA9CrF+EWE63k5CyRI0+WBTPccFGJGT7AQ0/UZluVRf6z7AP6nsjfLXF0XnBSgBxOKumEge743UBSf++Y47p1OxaG9qqIGD3LSRDZ05bIeVKnGRWVWa2J2tQ6JHci1AJWHkBaSSZCYQKkKcnWuITX4e0Hx86ZWlD6UNTeJ9jAZsj2oKMw==;7:bugMIb8yYCKh6m4WZL63TZPiHgBnjmreFKwK1IHSIRvHd0FWai1+QobjucLMG9gd0bp93mPypMDG8fLO4/exO+6WhjXLnOyfMhv6pTYbULy7T/H8FQ21KMYkf0Ktnes1FDRxUFaTiM4rqw8IQUdVNg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2019 12:25:59.2115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6e9f7e-5ef8-40f7-fae9-08d68c2e405a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamin Bia <biabeniamin@outlook.com>

The custom phase and scale attributes were moved to standard iio types.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/staging/iio/frequency/ad9834.c | 54 +++++++++++++++-----------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 370e8263899e..3ecf976ddefe 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -30,8 +30,7 @@
 
 #define AD9834_REG_CMD		0
 #define AD9834_REG_FREQ(chann)	(BIT(14) << (chann))
-#define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
-#define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
+#define AD9834_REG_PHASE(chann)	(BIT(15) | BIT(14) | ((chann) << 13UL))
 
 /* Command Control Bits */
 
@@ -82,6 +81,8 @@ struct ad9834_state {
 
 	unsigned long			frequency0;
 	unsigned long			frequency1;
+	unsigned long			phase0;
+	unsigned long			phase1;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -109,6 +110,8 @@ enum ad9834_supported_device_ids {
 		.address = (_chan),					\
 		.channel = (_chan),					\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
+						| BIT(IIO_CHAN_INFO_PHASE),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
 static const struct iio_chan_spec ad9833_channels[] = {
@@ -164,11 +167,22 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 static int ad9834_write_phase(struct ad9834_state *st,
 			      unsigned long addr, unsigned long phase)
 {
+	int ret;
+
 	if (phase > BIT(AD9834_PHASE_BITS))
 		return -EINVAL;
-	st->data = cpu_to_be16(addr | phase);
+	st->data = cpu_to_be16(AD9834_REG_PHASE(addr) | phase);
+
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret)
+		return ret;
 
-	return spi_sync(st->spi, &st->msg);
+	if (addr == 0)
+		st->phase0 = phase;
+	else
+		st->phase1 = phase;
+
+	return 0;
 }
 
 static int ad9834_read_raw(struct iio_dev *indio_dev,
@@ -184,6 +198,16 @@ static int ad9834_read_raw(struct iio_dev *indio_dev,
 		else
 			*val = st->frequency1;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		if (chan->address == 0)
+			*val = st->phase0;
+		else
+			*val = st->phase1;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*1 hz */
+		*val = 1;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -198,6 +222,8 @@ static int ad9834_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_FREQUENCY:
 		return ad9834_write_frequency(st, chan->address, val);
+	case IIO_CHAN_INFO_PHASE:
+		return ad9834_write_phase(st, chan->address, val);
 	default:
 		return  -EINVAL;
 	}
@@ -222,10 +248,6 @@ static ssize_t ad9834_write(struct device *dev,
 
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
-	case AD9834_REG_PHASE0:
-	case AD9834_REG_PHASE1:
-		ret = ad9834_write_phase(st, this_attr->address, val);
-		break;
 	case AD9834_OPBITEN:
 		if (st->control & AD9834_MODE) {
 			ret = -EINVAL;  /* AD9843 reserved mode */
@@ -385,12 +407,8 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
  */
 
 static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
-static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
 
-static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
-static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
 static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
-static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
 
 static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
 	ad9834_write, AD9834_PIN_SW);
@@ -401,10 +419,6 @@ static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
 static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
 
 static struct attribute *ad9834_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
@@ -418,10 +432,6 @@ static struct attribute *ad9834_attributes[] = {
 };
 
 static struct attribute *ad9833_attributes[] = {
-	&iio_const_attr_out_altvoltage0_frequency_scale.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase0.dev_attr.attr,
-	&iio_dev_attr_out_altvoltage0_phase1.dev_attr.attr,
-	&iio_const_attr_out_altvoltage0_phase_scale.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
 	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
@@ -545,11 +555,11 @@ static int ad9834_probe(struct spi_device *spi)
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
+	ret = ad9834_write_phase(st, 0, 512);
 	if (ret)
 		goto error_clock_unprepare;
 
-	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
+	ret = ad9834_write_phase(st, 1, 1024);
 	if (ret)
 		goto error_clock_unprepare;
 
-- 
2.17.1

