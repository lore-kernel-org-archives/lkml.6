Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927A120894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BNgZnlWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927A120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389920AbeHARFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:05:02 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:31703
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389645AbeHARFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3lRvDqyEMjKu5pz2Bn9ixFm9fNYM/q8NI1ytsx3TXs=;
 b=BNgZnlWvskeVVTdh2SFfpSXaz344asa8kcn3Oix6LfhOEey7/1Fls/Yn7dF4AGOAy/VBLIMdwirCiNEYKqGRkRgi7v9ZHJEHHKDymb0bHWaLppLt6RJGdH/Bk6S6HmwAuKfCYufV7gYyt2FfvD+2Cgr4JOw+sPLF66+eytrOp9I=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 15:18:43 +0000
Received: from BL2FFO11FD019.protection.gbl (2a01:111:f400:7c09::185) by
 DM6PR03CA0029.outlook.office365.com (2603:10b6:5:40::42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:18:43 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD019.mail.protection.outlook.com (10.173.161.37) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Wed, 1 Aug 2018 15:18:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w71FIgZ6027813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 1 Aug 2018 08:18:42 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:18:41 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 5/6] iio:adxl372: Add sampling frequency support
Date:   Wed, 1 Aug 2018 18:18:36 +0300
Message-ID: <1533136716-32041-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(246002)(2616005)(2351001)(107886003)(5660300001)(305945005)(14444005)(36756003)(8936002)(336012)(7636002)(8676002)(316002)(16586007)(486006)(426003)(2906002)(476003)(72206003)(126002)(106466001)(26005)(47776003)(53416004)(186003)(51416003)(4326008)(50226002)(6916009)(106002)(6666003)(77096007)(7696005)(44832011)(54906003)(478600001)(50466002)(356003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD019;1:myqns1SU76M0UwS3N/s1xCFdf4oRQ0FUh3rRLr4+hhd5+wfGCiybuwTn9cpie1K9sbzLFTW8/GnH4iHZ6XISowXNYU73n/P3FqaGJUAFR2PcyhQTt36c8PuvGtlMEcE+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ebed9ce-2636-4e4f-3b3a-08d5f7c2113d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;3:WXtsXhQCQDUJvEhT0qATLaE9q2ptkBYwJ5cDU6E4d5aDX6aSG66o5QVIumk41/Rv7U1IUGH4zKUih2j6IaXw5e+iBEhnuTxCN/kUUtCZ23YQ2mBi8SwY8y3x+xIfSMUUO9OBAJz4g4zpx+ShjWjL0Erf3ID/sUFcFiH8GKpuO8uZP+o/eycL83ddHbLo8OO/vsavaWHidnXcMd0AKmEEPlxNhoTP8ag46aKTva+LKW5qz78Z994+UeMWRwJP6XQRtWxIVeeHeWQQGWFp4DDb2yjyvBGKyozvuUzpmcotMI2wyeBdLiCvIDRQcX+Ncrzl5/O7UmQ7Hd3jsuCAxuObuJV6EJY//wIMJwjd/ADwWBA=;25:TrhVqnVCj/QLAuYl6w4vZTWsSnxn0J4aTsXBzQcLo3H6Veh2WvAEmQnYTBTmDYSXBZMDZxCArz4wj6XexHzUxTY+pIlVZxUBCgTbyFWw3KwjgwJd/O0Ex8JB2YG0O0v6irl+rns82Uqy5BDmjp86UMzknx5PKVfI3JzaktIXUrCYiFDXvsa3i48zP/KZLCD4D/iC+7uuhwchWNxCs4QboM6IrztJkC7WFW1n2jYRW5HfYXtVqwA5n0Tldba+nh+JDQlqRje28Q3xc6cqIxvwsubJKPAFsRbCsRxMHJ2fRgBCNNeh3cTCIF+LF64dhUCVhih9+V230A4LYZFF0BSBqQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;31:1oWimv1yMebvhXPKmla+/aSpSWoWVxfONIXPUm+5Ah5b51SBjFv+/81Dqy9N6kqw3sGM/EQHGuX0LUeg/RXyuyI648OHBtaExBJN+j+EL0/8YXkxdFpPLYCs8WIIqMhDriJ7H0XvD+KwysVr3T5lxO33WHRvoFghHfl6PBQMhtt91uv9qFBdSAoK0qDF5DcVjU8MSSOnxCV4OH/j8RIEETqDv+NN+qlccNQrRlkrFbA=;20:I2KtJkC+wgB25x/U5o+OL1rjZWJYqlAB6vqbq0NfGiJKMaxHgAz0i+F792FjK4okqHlJk3POJimbzfBPWqxvDWZCzVIODKJkVTWnltPRdd2gyNZCHE/eNJlSuQaTRPumz8X41xkH3TFWEwIvDxVQ3DbVL9PWVe5JwgzUiKMQgZl5toJ7t4FOpOE6tu5Ahp3HhoVzYxbnukIPVqIrpM/sSDK9KYeJubljdYsv7Pycsa3zh2fR9/+uFKiZYQcHBBokqCZWLjI6OKbDP+iQluhBLSpM5OjvDwCIQoixt9zhaC4tzW9WIia8QvuyjzGIFXcan1DmUgow2iuNNU9EAz88XcZfSryjTN7EDxap6r02pBkzYjQDr26b6LAN7uT3wG506kXfooWdf4Sg8Qx2ZjhZ0hAzDdvtlz8gMCLLFTS97XTrw3lKi51Yvxar13/9wfcBBs73/kWRBc0+YJXy6o+ovFVm97JfdclzAGohvpauicq6Op5lm7qP32qsE7eBxtXf
X-Microsoft-Antispam-PRVS: <MWHPR03MB3136D43573814A37A43758289D2D0@MWHPR03MB3136.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3136;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;4:3sPSje6yZ1LrkGPMXNVfoApjoeBoHP/zO4WBXVcxo0W69+lWK43Bm9LOFJ4varaeETAdH2Pv7SHpbJoKixQPATHh/qq6di14mALGVw6MG545HaALRFradQHBctwTZuJ3OLSdjj/ZEdxgjAKnOPQfXRBzU0nOx5+XKXSCU/8pm7t2EJOmQzagHNDy2c/uyQ6jNBeQARdxLRRD9QHVz2rNwNsBjrS3hBveb5wh1PpOogK/GgvXqqb5utGX4mjV+JlfepePANnaVcWpCz6/TbKYMjW4x32xQtaZ9qtJ3IepFl9CModmkLu28SvO7DaRN+TD
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3136;23:3fpukLVypUY++zRYrYBUSg667hCwWyHl7QfDjep1o?=
 =?us-ascii?Q?TVDhf062fRXMFw05MCVvXFjj8l85S2X1K8sTKr6VPJC12axtCU/Wf6ZV2tDW?=
 =?us-ascii?Q?0UkvgsDcjsCmi/7nrP18oHyRmEShQBOrbX5RPhJ0QWZS3fas38cVUAr+HUCt?=
 =?us-ascii?Q?60F/VavW1M4n7jSEA4a+ZoDGOexasT4ghnbt7URkX3/4KXn38GbyyxjuY4LD?=
 =?us-ascii?Q?z2oe+XRy3mK100NhhoQ7t0ElmbxVhmhSA94FSY9vRqfVtym6TM4FfddnTTHk?=
 =?us-ascii?Q?9vPKWTE0rRgvFGVehyufnUUJtF1PMk1idUibQg1CLymrf4bxfTLGLNfjat8P?=
 =?us-ascii?Q?Pgzr8ePCU+o4B/pPBLTiBzOltNk4Pjtx31W/LIwheLM+MV4/RBH2BTRlgoAj?=
 =?us-ascii?Q?DWnHHGEErhPqkZL8Wy61XQGm42s5S30jaiRZTWmYPdNnpA8l2FQ6URfHpEJd?=
 =?us-ascii?Q?ACE5EV0a0JXFg8lGJ+h6kudTH8hzmPj+KKj9WszD7LY3Nsz3TLZlfpZjQ1D7?=
 =?us-ascii?Q?oo/Z7p8hNo/4vFs5MkcxWhynwWrMU+p7ttlcgGbqWu49b6df8jGTh1+NHk+u?=
 =?us-ascii?Q?uE7mRpDWZ00dpJhzxDxa7/kqjcpPGdrlo9raBVh7bHQRSMzi//8JWrRsW9iq?=
 =?us-ascii?Q?P3uVCZYJjA4OhzsY66f0bq5+687L0TfglQ52RUpoplT3Lo+XhqiJOLs6Q7cR?=
 =?us-ascii?Q?vmTOfx9grHT/WZ1C+c/Zmyal1oI5owYe7XYxBcdARDIg0gAzjr8wHjB4Ql0A?=
 =?us-ascii?Q?oWUp0F3U+zu6L1sh7LPb8P8Mt0Im4rHvQubkMjtWcj0XJKoNTOurHnkIffdZ?=
 =?us-ascii?Q?O13OEN59bTtQFThjRMqhQLyRO4KTKBv80inB79OX09vtqGaPEN7iAjdavy1A?=
 =?us-ascii?Q?b2GaPB1auyrz/7l7AJ15JxTRb1elq7Vpt2HkxMducjizmKEoPnvsaQ5V+HZy?=
 =?us-ascii?Q?8PaYF+dfA8GdFZ3ynqTHwrW7yNB0fPHEApqlwt681cRVWQ5+DiY8oQCinu7d?=
 =?us-ascii?Q?V7sd32eZ8pHY2iYUodFEfy4rH/PSAQL+ELmXO0Mg+oEnfEGF24HL2HvRunbH?=
 =?us-ascii?Q?OkM8UU=3D?=
X-Microsoft-Antispam-Message-Info: eY4XDiLznuEg+ifKfiqP+k7BaEIDvZN3NwTtE717bwe9Z9ew33a6E+HU0p6B4C77zXtC8L/il6qoekeNZ8w4OptRXg8LnaCxbD7+mZnhLPIh2JpSNNRgkgewUVpE28XRcyMySxal5XU3zyEQi2e1rjPM3PBT5BAGTjIgd4KrK+XZnIc0xj+Cu1DdaA0ShHuIL1WQxqZhd2guFvyJIZvKmo5j4HAYo9iPY1Pdy5WJjcWIVf3yO+ICZ8qW1bSZLvhNu/XdwMvSNyq5qUW+HFMJ2kwDNF2TtBE0WNFuzM/QfFCFsNiysE9mMHDHTwn6J/N/W9vR7GtmkItTU8eC0dfWNMuQ55pO/IglwUqNwUQjCYM=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3136;6:xLqCdS1srjb6RonrDLtZUQhRt6ScNtcK/4PixKbK1MA3LH1dyuUy5N/H5eu4AFXJLaHobCxCZOp+TnSIVRXhsgRE+tTlB4plWtJ2YeTsI/EzNNWeR5FnyHrdpgWhIcHC5cZg1CeMN/aOpmlSTTnznRBrnjwQ+tUKyGSrQLJWKpkaBLMzG+rUizBAYUYAhEWmW8r9xs73gUHgE27s5ErZt3qbdgQp2+dGc1iZ1dgiL7EsxqUKXrNOYdsAoysOTCRKnVS9hCKYgjOddlWVNdbRYVVHhl+2pv4VtO7zku6iLgSJbe63nTOvpTz5CA0ZnFx+w1HjmRPWiZzKvPc7UQ3DLpTg6VATrqsBusFNMVEn7pM5DysRWxZYeTpPSouT72kJxSCoRESA0oFSFBPoRfwuKWLmRS7AxCeZmWWtxezoauRrZ9TZlormBwihjOXpHpGIbErB52EFAmFz6Hcd3oglDw==;5:1FYqs96Tg5o0t+JW4ZCodHfi5OEFimUL5zBOS3Rf110x7GjA0agIb2ZKAOhny0H7HWyllu8gT/44SknTJR7Rj83f06qDsB+YWRxHzOinei1oXqIjM7xC2d4mD5L2o/PRC3T2ofrQxsK3MuuhfKr2CiQobH2JHN0N9xqO7n9w6J0=;7:/I/TI9ogvfy5Bjg6MaXluQanlhe8AkKs5mCZwnnEgRfA989QOwbq9AyEcJ/T6jFc4v9VPgk7G3rRbEeS/TUJ6f0ehyTUQK7VKQrjiYdIp/Iy7QSdBgBvJs18iykpELZFI8sbiWJJ7bkw7MzIyYvUVII/2XDHJ7SL0CzGadL0qYKQfeYeSotBHyVesXzQIVJxYpaT8oGQWJ3Sy0wsJXIxhkOec+PpDnGNG42+X5nvVid4XcqBYo5PTFB1jOSRfJO8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:18:42.6640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebed9ce-2636-4e4f-3b3a-08d5f7c2113d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency. Also, the
activity and inactivity timers have to be updated because they depend on
the selected ODR.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- nothing changed.

 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 68862bf..d9e4826 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -217,7 +217,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -325,6 +326,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_find_closest_match(const int *array,
+				      unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
 static int adxl372_set_bandwidth(struct adxl372_state *st,
 				 enum adxl372_bandwidth bw)
 {
@@ -651,6 +665,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl372_samp_freq_tbl[st->odr];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl372_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int odr_index, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
+					ARRAY_SIZE(adxl372_samp_freq_tbl),
+					val);
+		ret = adxl372_set_odr(st, odr_index);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
+		 */
+		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
+		 */
+		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The maximum bandwidth is constrained to at most half of
+		 * the ODR to ensure that the Nyquist criteria is not violated
+		 */
+		if (st->bw > odr_index)
+			ret = adxl372_set_bandwidth(st, odr_index);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -782,8 +841,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+
+static struct attribute *adxl372_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl372_attrs_group = {
+	.attrs = adxl372_attributes,
+};
+
 static const struct iio_info adxl372_info = {
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

