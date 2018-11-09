Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD61C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D9120827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="bvzuX9jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D9120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeKJBWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:22:15 -0500
Received: from mail-by2nam03on0074.outbound.protection.outlook.com ([104.47.42.74]:9728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727784AbeKJBWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta1iOIb9ZLNq2QsifkMsCizZobh2+1tKMbeTAUpGyPg=;
 b=bvzuX9jjbMutNDWjgjzIlWd/WPROoXtzHfiTMlUb54q6748calw51eKlTrDu/jM6+E0itgvHCASZLtvZ+I9qyh369oyR3ticAzi02BPkjMf+eDx/JZ2KY+UfAWU1/HRYSAHSaHg8/uV+O8NyAfY9+Q8aYBeg3qIS6Kf+MqLGmsY=
Received: from BN3PR03CA0114.namprd03.prod.outlook.com (2603:10b6:400:4::32)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.24; Fri, 9 Nov
 2018 15:40:13 +0000
Received: from BN1AFFO11FD005.protection.gbl (2a01:111:f400:7c10::103) by
 BN3PR03CA0114.outlook.office365.com (2603:10b6:400:4::32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.20 via Frontend Transport; Fri, 9 Nov 2018 15:40:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD005.mail.protection.outlook.com (10.58.52.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Fri, 9 Nov 2018 15:40:13 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wA9FeDwA017418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 9 Nov 2018 07:40:13 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.301.0; Fri, 9 Nov 2018 10:40:12 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v4 1/4] iio: ad_sigma_delta: Allow to provide custom data register address
Date:   Fri, 9 Nov 2018 17:39:58 +0200
Message-ID: <1541777998-7518-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(26005)(54906003)(4326008)(5660300001)(36756003)(106002)(77096007)(6916009)(246002)(186003)(2351001)(16586007)(316002)(356004)(106466001)(6666004)(107886003)(305945005)(426003)(47776003)(50226002)(478600001)(72206003)(51416003)(6346003)(8936002)(336012)(2616005)(7696005)(48376002)(486006)(8676002)(44832011)(2906002)(7636002)(50466002)(476003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD005;1:kJrj8g7s8xylC2pqisADN4A6CuL8cL0wymVHMVPT/TFWP6IlgTG+Y31oYEV/PJaWwSlUKh7a/ozspn3S/vaRghBDuUrGmNdz6CBdgrHqnKJhKTdvMKv4VaJ/hFliCmMO
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339efc24-e0b1-4a8b-b4ad-08d64659a3f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:E31JHEYgFIrbXE88WiEFpBjK+9K5tudfJesgZE+ul06jtOcrdY5pxUoFB5L3U5fhXZVz2yHPOhkAd2gt6Tc+r6Vr3oCsqJkS5tPP7AQ/x0z148uEBLtym9TYk/MS4XMYi3lG3zbVwAuRJmYvieWPhvbnLZD1LBO1b+jXgv6YdTDhuunm3Z9gdjbzQNV6wBfDURrOhKdKihbiJ/JOakh8+/zqVUW1P5WzKqbfzAPIH/0jZDm3ZIbQvqMrEOH+K0m+acsov+K+9T3vS3/SSE8ZnUiMfE778FpeoSz4wltZXyp6APemm7j99CaGcz5PTO9chvUTDN3JLB1m11WNw/8vggRfEHtYUQlKxU983kVWcB4=;25:STzbU1W4cW6AspyROUhDIcJmpfy2lCWBjdU7QjyhXxpWL6XJVaXYuncHx+PlTdjtuvbAzlBbDqOmQQptPV0U15xMNKp4Q6gYFECi7eepv44IW0dWzxfYKHKTa5PUYpeOLY5fY44KpmXDhxw5CaKqB5JheQNu/pJtLMG9vHc0n8DBa3GbdMJp7Pfyd48Ju6S4q5cqCURwVaf1YNrNH9H8KZFpb3jO/1CPQCAgNf8PQSRR72HGAGottKbb9W2CfE0T3NwI86+IF3yVGUsOOa0x+JAjJeStXjzuqs0yPKV8ZVsK2WtgDG7/2BZiWCj8Eq+sSYKlZ4OGI1KBNJxOD409xA==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:QpyNeIBd+/+MV9Qau8yG4yaxDubnhe8v8nflGLu0+K/nHsBLDOkG+MGrJ5uLA6H4SQELSoCAiWAD1nEFbzG9a4XMzX7nL5pGHYQeyDWkkM9VI+K/09SC90LjLq4+4lL6yyg3+NRJ0y6WT+cBlK7xEZuFrwRjxUgFIgiGcOpD+zIvzQKEFW+AtZqVs4ySI0XBZLJ74cVpdKUrZ4a5ZW2uoa079CnUIe3v+gPd3h5aSfI=;20:PhrgpTfnKnNGRAy22mRPsUmVsXhs1Zhf5GXJWWTcUbdmpu/4DI3uNwApJER9mTqK4erFO+/7BCXN3wqkuido/RCzB4j/xKYT7rS6xcFOyjqJZLhv1IcAwTIf7xXCVKW/P+9CaVCJGu4tAZV3v+Lmg3Sv/a9QEOQCGnxYCRSOcTr5o0QMwAY7BQLY5tqBG83aGzPQlwK7OW9f0+jqa0XxsJOKR/ZjzEGKG5LPulwxst0Kg88COcoRAS6zbnkObaL2aWTHTO/DtumUaA2JrAv4d0/ZfHgLnN1wIKygLM4R+cPOyNwnEbVlSc3YngSTohpmAj8nAme9lgqUS0KLP3LpDfIL/JnPy9pNinKJQ1DPT9qrqCNVZjWMN6/1ssi8pYwvuupcIZlt71hyDPwTa7bmnETKyqJcmLIsmefdTpwP6m2VB8oqXLM2NvUD/M4Gf15cp51/bLPgwBNXl4foOttgdl+lAQbAIz8n+hWUxR1G1c38vTzFK6FdnEXkyicTFKbg
X-Microsoft-Antispam-PRVS: <BLUPR03MB550E5568F4863F9D02CEC5E9DC60@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:A3V67diZZ/F8rRQziQjR0o+Kli3Y1R3u5h+QM9IYU11BngXXW0EyniPq1foj2kKbO9nHnu451uK8I/LnFLgNJFo0dP/LaTYhUi8asTZ8hy7LLRTWhMIkwWElb6q53VXbon4GkP77AAKZbQL8BIbOQ12WPI8H9LmlxMNe+SjWcJ89SBcVopqKqh2nBu+wfbl9sBf7KyPQKksJsuNjwQgQO3A24mcdhXrr7lSCRjtd2bQ2c015xm+SYy+3ucRdF4QXLOaODFo6EB7Ej4vrNV0Ibudz2yKX9Yzn9Oms7WEx/zQxreWTkJy5Z6LieKAw1nU1
X-Forefront-PRVS: 08512C5403
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB550;23:m3YcRny/R/CcZAIvendu49X/eIkfaAtUgI3WrrnUdm?=
 =?us-ascii?Q?7CsAEqHPi/bbuoheUVQOTz8Loq7910p2a3lBLA53R/e1JtvwJ/UaLEu4pLDb?=
 =?us-ascii?Q?e00aibZH6eq/ZfmyS9CVXWpK3hYppYbUvx7r6isR2eaJ5z6ENgSpxb+P/s58?=
 =?us-ascii?Q?be4PGEJeiWn23DlVgN9XsyhQshBTK45JtwyvImeIHi/PF59pnOqRWugW0xnD?=
 =?us-ascii?Q?p90bm7I8DzbD60Trs8/NYFYM1npkSWk/ONedt2ki3ksskInUPib7Z9CaHasq?=
 =?us-ascii?Q?Ot/7fT5MEL5LekEiienxZbjIrWGZ6otFHQAWp4W2bcbCbVVkME5+6IJUlM3B?=
 =?us-ascii?Q?QqkY4ZTQ582yzdAJzJyhCaoShef8OY72y2LJp1zAWUpd0cv4YqnldXRekSh6?=
 =?us-ascii?Q?yG8sfqak/WZ1gAOycx3XbDb5TW8D39kPdnFxK6s/o3cstUaQwNqVKkaaVltD?=
 =?us-ascii?Q?bj00oMd5wCnD9c6ZE5JHTunGZu+mCSxJFfT5woFwZJlu3S8fQHX0fJotJW2f?=
 =?us-ascii?Q?7/WwIS0NKJTAG4yYoUY/EXtPFhNi1Q9D6/BWIKlrnXgKWlDR4CbI6T5zG1Uj?=
 =?us-ascii?Q?fru1crQB0ntSl7OkqtXNHk3QyTecDDNbvQeNHJbx5Ft+NETIKMYEVzC72hZK?=
 =?us-ascii?Q?MKWJKodQdAqapZda4kmajz9Kb+5GUw5jGQmne5C9+W/S6290pjyXcNJdw+iy?=
 =?us-ascii?Q?rTpuzzmtROOMhssVH08XabhPjgjtgks3ZZvk2s4J3IX1vd1g1ZR+qd98VkuB?=
 =?us-ascii?Q?TnNk4cRU+I7At6ZVuXXOYyhe34OWwpI3I4gd6mSVDZhcl0J+sDGX7yMFP6ED?=
 =?us-ascii?Q?mhs0ELrAfUgxOdIlkqZCoXQNDqPpAfESEgIeC1L+enXZ67W86UcmpnrWYL47?=
 =?us-ascii?Q?5p8pUIkp380m4a4Y6LEY7VVykA8C4wkjfIOPJn792qkRlc1kk0sh3q9kHCkc?=
 =?us-ascii?Q?K/bqY8f9u7nwq+D7kWr7nS+5xpHEvm57V0m6viqY+YmqZn7qMnK1XIebfqdn?=
 =?us-ascii?Q?vrjd+5bpG+rMO/qjgK7pMzmBxIbZkJ4W8CnIuM77CT8Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: Vaj9z/G6s5c0glCflDYdCs9aZlDJlvhNPAUpSSRlfyGH0WsU7PJISPk09r8fHfG85laxhhyOvuYQ87/qmrXuAglAW9S0JbipE45IHBSJr2rTfOibBMQpYfF4D0iNPIbtTWhV5ouT1PXsSCM/ChMM6QKQ4iU5GC1zROWfTEF5yhKmk+AR5Su/1DBTMihV2OIAgWcPvBm1MF4ud1CcxVY57CIRv8wLaZJBDAQ7ceKr8NVT9KxvYkvu1ZnVA98H05CqRv2rA/OHmA3KP7h2KXQBFK4EJkSmF0BP+w4Coe2/4cz2qVxFyQBvqaKwCtr/5+bTIWgbhcr8zskas01C1i7v3WSmqiC0aY7aPM6XUmHVE5Y=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:g7lm9Ys3qX0fkhmtIlTVb41MZQnlFmGxbN56eGL0km21WQAtN1DI3fZEBErqvMzq7lfbVOBjXshs5+Ha9qhf4y9KH9KUZ8bTxPp4whf1TULwnz+gVRhTbbbzw3BT0AcahrFoKWHEW0dV2806QezENsh8thE9KKIgM9vckrvzIth6kl85GvlNXym6vsauNf1MnIIeYNOsit4mafnH1pIapC7JCBrFxbRa8JasZzAjRVBuW8vsMf2WaKbAujZ+HxX5ZyFQYRPnliNY7/kKWljoU0/hPyVbjMN85tKQdnYmtbjbpBFsXq+TIdrclWDw/mWL1LOzKxMydVpOEYibeEJT2MZX0co795N2pJ9Vnft0oREdaczagP8lNQWot4l+p77/2MmZk5nMqIhyvRehQpAN5FalKgxJ9wl66+/nVb9DMB1Ca3aTW4hVjvRPyWTm8QW8uZGgwXBOZl/uzDgmij7I/w==;5:vOxR4pg/KTL2YS8CbTH7rHx6PYJ7iAJn6lN6tb6oTAKRhG0Hhq3UM+DDL/UMoSUfmQ4cwWvQXMHPEyvIL1Vxu7GpZg95wlkfU9xhOxNbUR5lc1CMEr8NKQAu87gprml6OnO6PmrS+/tsaYkYoayicEiLh25UdCTaEalCdyBV7aA=;7:6zVlKLHHt3uzl494O6siTRoDS1Gqfcb85RGlU3PAbD1UFG8eglQvMZm1K2ZWSVAmXZf5ekGCeWnOrard1dpdZB24gnhOu1QYYQQH+W7fKMitXUO/6GgFc5loXSiORD0PfgiKl4zFguS1dnr3ncNTuw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2018 15:40:13.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339efc24-e0b1-4a8b-b4ad-08d64659a3f5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Some newer devices from the Sigma-Delta ADC family do have their data
register at a different address than the current default address. Add a
parameter to the ad_sigma_delta_info struct which allows to override the
default address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added this commit.
Changes in v3:
	- Nothing changed.
Changes in v4:
	- Nothing changed.

 drivers/iio/adc/ad_sigma_delta.c       | 22 +++++++++++++++++-----
 include/linux/iio/adc/ad_sigma_delta.h |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index fc95107..ff5f2da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -278,6 +278,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int sample, raw_sample;
+	unsigned int data_reg;
 	int ret = 0;
 
 	if (iio_buffer_enabled(indio_dev))
@@ -305,7 +306,12 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto out;
 
-	ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_DATA,
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
+	ret = ad_sd_read_reg(sigma_delta, data_reg,
 		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
 		&raw_sample);
 
@@ -392,6 +398,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	unsigned int reg_size;
+	unsigned int data_reg;
 	uint8_t data[16];
 	int ret;
 
@@ -401,18 +408,23 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 			indio_dev->channels[0].scan_type.shift;
 	reg_size = DIV_ROUND_UP(reg_size, 8);
 
+	if (sigma_delta->info->data_reg != 0)
+		data_reg = sigma_delta->info->data_reg;
+	else
+		data_reg = AD_SD_REG_DATA;
+
 	switch (reg_size) {
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[0]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, AD_SD_REG_DATA,
-			reg_size, &data[1]);
+		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
+			&data[1]);
 		break;
 	}
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 730ead1..7e84351 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -39,6 +39,8 @@ struct iio_dev;
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
  * @read_mask: Mask for the communications register having the read bit set.
+ * @data_reg: Address of the data register, if 0 the default address of 0x3 will
+ *   be used.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -47,6 +49,7 @@ struct ad_sigma_delta_info {
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
+	unsigned int data_reg;
 };
 
 /**
-- 
2.7.4

