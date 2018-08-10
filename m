Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD7DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22989223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="rFZGeRWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22989223EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeHJLTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:19:05 -0400
Received: from mail-eopbgr700052.outbound.protection.outlook.com ([40.107.70.52]:6510
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbeHJLTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJQlXuVii75YJ8Fwsez0bQPE7lE/cJP9yZfHNZcoA/c=;
 b=rFZGeRWX5mjZW0RhLN6Z880PzyBMEWwK6nmibxG2O99NZe5vh2rzfhyh6YT4NUcI8qHr32e7GrBZlT6z65ayz2m7qIDRx4wgj/kcoNTpnniXF+ctetXeDLvgCz5HpDRnZq6+1f0fApndvzHsGPCsI8JBnI5TyBO7GTDYL9CtKCs=
Received: from BN3PR03CA0059.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::19) by CY4PR03MB3125.namprd03.prod.outlook.com
 (2603:10b6:910:53::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 10 Aug
 2018 08:50:05 +0000
Received: from BN1BFFO11FD020.protection.gbl (2a01:111:f400:7c10::1:183) by
 BN3PR03CA0059.outlook.office365.com (2a01:111:e400:7a4d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.20 via Frontend Transport; Fri, 10 Aug 2018 08:50:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD020.mail.protection.outlook.com (10.58.144.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 08:50:03 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7A8o2VU019627
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Fri, 10 Aug 2018 01:50:02 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 10 Aug 2018
 04:50:01 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 6/6] iio:adxl372: Add filter bandwidth support
Date:   Fri, 10 Aug 2018 11:46:23 +0300
Message-ID: <1533890783-13456-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
References: <1533890783-13456-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(336012)(110136005)(186003)(36756003)(50466002)(446003)(426003)(6666003)(2906002)(77096007)(16586007)(44832011)(26005)(316002)(476003)(8676002)(106002)(486006)(478600001)(72206003)(54906003)(4326008)(48376002)(246002)(11346002)(356003)(2616005)(305945005)(7636002)(7416002)(76176011)(126002)(5660300001)(8936002)(50226002)(53416004)(47776003)(106466001)(7696005)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3125;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD020;1:UMXBivLZ+9QgC9w3fq4RAJJZh1y9ezFOX7h6wduB8GFqXq7WKgzIRG7gWQFbvM2TiuP8EIy9WkM0jvkqLIdhK76nMjpGhjcxGZPWojCGsk0TsBE9JuhIexgPgzMOZR5v
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129c50a3-b839-4597-f1a4-08d5fe9e4406
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;3:B1M/38MjsKH6mOmNsmCv3ziqsac+Knn7KIBwKR3WB9RYItGkb8WQrzKfNxGPOVs7IkhSxPHDb3OyiNR+mv1Qx6OiGlB62XfsH/ufg8jC/iGeprxwWBVZyy6mgChbN9WJEtFeGJK/1u9CnKbbog7rz2TnOrYQGOzUqu0CVVIFaasYBwq93lqWdum8JlwXyR9sEbmMEOFHnT7Oy3l3qzMnuhFWKVsnDPXcpeU7qxGxz5sCckaJ5o2ENYNqiCu/k2mtxPCtUQhCQ9xC4WRJn+0co+XeNaEkNOPuTKFHqad0KZkeHzNtG5PYGrnJmf8BaUhv5LH+PbliS9vZTgLndXxSnO6xz30cpY63DsgTCtQY43M=;25:krH1PWNOGrPg4fdPhmi5uRyLRwV4TTO8/URBU5DSfu8d3VS/1GCZzO6v+LadoWhd44q18RPs2XRwdBpNNNVVYyxTEeAsG1SrkKU2/YXls3Sh+L1gc3E6K1Y0nANVk5dd5qVnIJOz3qLvBGf75EIH70V9AueCTPcJ0C27TcTyj1QwWWdTHz4jSw3ZipLrTI/l3j0x5OD/zKRn5W307/6wpjyxWVU1LEfEVcUO3LJC0Nnjq3cpIl2aN0ptF6yC+MSZKRORx9VhIjYgXd59Pf7pAIlJcsb3f8zMjSoWLvNbRgzLoe/7uYE1CUSi0VoIPMrPGSTWp7T0qd8Dhc57hCcsiA==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3125:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;31:n710cVp4hgMRU+4NdDti8LH3Y29RnJVsSDtKfJ5/Kaw3eSKFy6Q6WaKrQeDYpAur0H3+rUba51iF1nnylcxag2ZciEv2BeoPSWPMitqmEBaJsa6YDjtUg/MqW1nQ7ftT3dRUCN+OSex7VpByV5mTCnvVvsfdkmErov5sj8eriH3oPG9IMPXRwWJvTJ2Rz5vTgt3rE/p4iWfKye5KP1uChQI+LMCQQwM5bZBibPY/NF4=;20:CmKockRarQdan5wkuMSuG0GIVulBX76IJRq+Uju08oodIXrKmBd0ai2s4MG8m4he3FkrQNz+d0AIaJgFh1SXVhS+qL8qVxP1IyGaBkwuLiWDhDbYadEUpQZGoM1k8Ukv0HgVKFdqbRQCliFe9BLKlxVBOMc4yPl8qoN967rXySbGK1+am/HSuO1RlenNH8YYyNXguwnMYUV7vVGLcauxr5UVBrpdPbfqiFzQrXOz5oletBKqr4gd1hi63OpJtIEBZssk7clw6A33S48s6OH+WrOjM+0tEuVojK6Xu4kUYcreU96JLch3Fv5/MuzNXH3qpMrycY1xd/c/f7bEFyOr4/IJISaQywY1XB+rKGHFOgN5Bw370Aw7K4ssqHdRFZSfdQZP9HZ/RMb6BK13BxvHDxJA34mQ7V9o+gVYgaZ4vn8IS9swbZCxGlMMk0gBY0LZCMMZLQAe1Wy+11ws1zJuvwdgIcZHybgXL7EVw/3zX3PDxCzlaRNoA50LVRspvtV9
X-Microsoft-Antispam-PRVS: <CY4PR03MB3125CB4761F7BF976B4F040B9D240@CY4PR03MB3125.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3125;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3125;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;4:+yL7CC6qKk6ZAr+A22CxT0hvdmC8Aye0yAN3mYlL4FOzl3jUWY6W7+AHGAOiIR9SQbKhw0BFDIvbFa3BTZU5Vr3OdmYOrl5+NtH53Bz1YG0J9MyWYmvv7fMGBDwLEJMzDeENbq/rVL5RMbmvLlrf//6vgQVQqWTqrUzv2Z4bLFmBFbI9EJ3NB3hGZxzZQlsLWvw9hhWIb6g9kJi5q/DmlZQfElINWjiptCxCKq22I+0bTAeIUKO/wnjaVLQI6ZBbiBSvG4jwMRqM/6RQtAAhsBGn2aILnjIJOQHr3kRBwLWQz7w9ReIUw35ZHHmN+Wvs
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3125;23:zH4iSIsdtuud/HVzVQF02r+LUTKCc+3H+kkJOCDpk?=
 =?us-ascii?Q?TlRX94bHbyVbrjdSeEd3c+qJkL8AJBDtgx6iSp+dX+hSZ4xAMzv44/HAmHth?=
 =?us-ascii?Q?6i7qoYuabgVUNDPcVPvWrW+wFa94MdPcZauPzh/PxrI8p8dbkaTVohwZJ3MO?=
 =?us-ascii?Q?1M4THqfSePB5/NkAKpmwb7+Ct+uw5POahlU3UGdK4IIzl623TvS1AG2/AjqA?=
 =?us-ascii?Q?FhxCi+5yFnpupY1+1hM05Sn1j/tBT86FT4gGIuRIErYijeUYt9vilRPKB4ap?=
 =?us-ascii?Q?j62w8chpjAcciHDplorJZweQN+clOTXxqdcaphcbSgS+9Xzj//y1o6nDIMFd?=
 =?us-ascii?Q?aoQS07H28TGd3sj9tGh0PAjcDKz+CisrX23wvBDNzUiLMqOnW8ttE0gBlD/g?=
 =?us-ascii?Q?sZqFOU4ifygUbjR5FjBwz3Wl9HLSx7jcAVoPdIEGtMy45kTQCqzivsZHrkVf?=
 =?us-ascii?Q?th5a1BrWoUEzwkrXcKg1+C9p+e3AVFHob21+bQ5a7v2UEJyxSSzJlY201/MF?=
 =?us-ascii?Q?rMufFJxptAggiBACKbUoLsS5juYH6ljNqmnbCprXfra0RmavfafjosXXQdx4?=
 =?us-ascii?Q?iYy4oK2EDa/phmYO7BDHkqwvOrqKWWk59Exz7oxJFIpxEKTbaAYVbdfC/dys?=
 =?us-ascii?Q?4Axy3XEo67P7eXVGDmgkgGXx1p1+rTrId9gE9sPjKvwVxsmwMCE5qj0p4wp5?=
 =?us-ascii?Q?5H7MReMJ80jX8XuuusG2K4GXs6RQvYnyus4j8uRREsoF4tjIt2uG4JQnWCWk?=
 =?us-ascii?Q?dbzgNO7ObT6BB14Mu4lojbABYU3/gVeMKicGeDsz2u64hdPP/DeB8w8LDuVX?=
 =?us-ascii?Q?GqjCNVsYIb25P4QSVURBzc/E6rhXZ7drSrt5abtCRGEGGkIwmjC1zjLqph2B?=
 =?us-ascii?Q?Ieret3deexKLyS3csBV25fPvw8FZOGISHStOyUWUfygPEBAcNg3sWPsz3xra?=
 =?us-ascii?Q?lvbThhTd8OnyeyU3xx2ZnFFn+s8n7GXFU/IXLs10yM23DYTu4Ofls9VKClhJ?=
 =?us-ascii?Q?X+EPANXuk2NgUZ8XTLMgYOsJ03NyJTcJ88CnBm3GvhHMf8JmIWilW/g+Hv9t?=
 =?us-ascii?Q?1ly1Qp0oJIQn1oxdvzi4wHKhFRl?=
X-Microsoft-Antispam-Message-Info: iTB8P6HaDJOjZ5dhha6bg33oLAqKnGU2jhpT+PqCRVzITRs/QElBLe8XfdANj8LbV0//jw2/VajRloRmBRwEe1Wgq8sbE4swDqe2VF3IjIhjjbgDxP0FEJJEQ2uPrrHSAm1nB2B9o41rjqCNfA29p8lWw6mqVOSZxD/1FbMa98YmHKcqIgI+ZlaQpo5XEhBEXxFsmCCNbLTjIGHNvlKVy7RXay8/MXgIN34G/G5FIbx+Owij8PXzt3vMH/JLB6AMe7PtUzufHIGltkdUxKR7lxN8jMfQ0tn8YtvEbIRzKNih9BH+bbJ3yf26d/O1LnQqDz5uDQSGVlq6yA/wDI85QUcpgutCcZRDpVtDPPzEPnc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3125;6:0giSQiAE7a6J51N93ecC+UxckcznVpzsHho3a4koGVeaDeFLA+y2LWw5DcQU1QKrj+b+S4RzVmOb/jYbnqse4GXCzTK827pOBsEViG4ulmH9OmcYjbp05P67poAUdPRGew3o/uIp6NE0C0S952OEpTr7E7mqQDO4+qREdN+iPA1P3qtOjHI1gjCraL8YCf2XHcwJSQfCSZzebd4oHqrPW/fOYTTsCmpdZvs+qhyOTFJ4aOvAcYzZf71kLyv+lD6mxnAFHd5xDJifcc4Wo/uEX1kDmx4Bm5d8P7jKMRMJeYQUHlUY5Bq1vgAEYpZqOsNkfkUTCDCzCYnk60AZi2mErQjOupt4pjaE0YQmL12UQSQI0S/zsk6UT9f6+fjw/HPGWZ2cD4OVVc03bJ18klwqHwzl69v2gQDP2nnd0xGuDGn3iDFGvSTL0hv+LTtkWYBznUbM/y8E4kWOsSQW3jSZDA==;5:lWpSVIZ9UL4lqKC/YKbQAq3kqp473wboa2Z4DzmR5JVEK5O5tVNG5/R/n3KzJGuCBa7woTmyS/oBQQkN3ywJ6ZeZhnxLXoWJX4BVwagIGqLm5xqs3UMQZ9wksdR/4+OispadcLgJvsW0a+MqtURTE2SZ0eel3uPLo/bT0r6RxMI=;7:+gK/exqb88kLAklmcYAYCzV6KWkckByXsbIbnXyB60aUpVaXsSqWsgSKQNWB7XG+0mi5U5MK1TNKzKZiryrNcCqYtsV58Y0yBGh96f91AGZdYVxMCARxCSPfkUYgX4yX07SpsRDx9o+HIL4d2L2eZ6eBxe7J5Czz75F8eDu/mz1zRsIQ29rxPA9Hg4CHbuMHQJBMb37uAtGQhTWBPoe9O0bkEXwWPIfqYYYW89aV46AoIK/7N7Y5Cv2yZqzlx/jA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 08:50:03.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 129c50a3-b839-4597-f1a4-08d5fe9e4406
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the filter bandwidth. The
user can also read the available bandwidths which are always adjusted to be
at most half of the sampling frequency. Furthermore, the currently selected
bandwidth can be read via the read_raw function, while the write_raw sets a
new bandwidth value.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index fedb623..7097775 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -202,6 +202,10 @@ static const int adxl372_samp_freq_tbl[5] = {
 	400, 800, 1600, 3200, 6400,
 };
 
+static const int adxl372_bw_freq_tbl[5] = {
+	200, 400, 800, 1600, 3200,
+};
+
 struct adxl372_axis_lookup {
 	unsigned int bits;
 	enum adxl372_fifo_format fifo_format;
@@ -224,7 +228,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -648,6 +653,9 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = adxl372_samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = adxl372_bw_freq_tbl[st->bw];
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
@@ -658,7 +666,7 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl372_state *st = iio_priv(indio_dev);
-	int odr_index, ret;
+	int odr_index, bw_index, ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -690,11 +698,34 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 			ret = adxl372_set_bandwidth(st, odr_index);
 
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
+					ARRAY_SIZE(adxl372_bw_freq_tbl),
+					val);
+		return adxl372_set_bandwidth(st, bw_index);
 	default:
 		return -EINVAL;
 	}
 }
 
+static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i <= st->odr; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d ", adxl372_bw_freq_tbl[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
 static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -826,9 +857,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 };
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+		       0444, adxl372_show_filter_freq_avail, NULL, 0);
 
 static struct attribute *adxl372_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4

