Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D2C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7A2172F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ks5UEulc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED7A2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHTSOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:14:46 -0400
Received: from mail-eopbgr680077.outbound.protection.outlook.com ([40.107.68.77]:28883
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbeHTSOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I65aMg8iLj4oGGmOI6L5ev+vxzoFCV06ROKZu/Paolo=;
 b=ks5UEulcN4UG8pldbNtt+ljeDFeT4Ql2X8EEhLhXxfDQDmFxDoTloNYvkCqa+hxW7iDUagweZ09VaerEiAypyMUrkY4Q1tlt/PZePk2MHdtsXhZTINEGEmRlcKwOoEUOEwup+v6tlU4Rg68zTtqx6JbNMWw+5GnAGuDFlerq9PM=
Received: from BN3PR03CA0108.namprd03.prod.outlook.com (2603:10b6:400:4::26)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Mon, 20 Aug
 2018 14:54:40 +0000
Received: from BN1BFFO11FD015.protection.gbl (2a01:111:f400:7c10::1:181) by
 BN3PR03CA0108.outlook.office365.com (2603:10b6:400:4::26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1059.19 via Frontend Transport; Mon, 20 Aug 2018 14:54:40 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD015.mail.protection.outlook.com (10.58.144.78) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 20 Aug 2018 14:54:40 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7KEsd4C020417
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Aug 2018 07:54:39 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 20 Aug 2018
 10:54:39 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/3] iio:adxl372: Add sampling frequency support
Date:   Mon, 20 Aug 2018 17:54:27 +0300
Message-ID: <1534776867-18812-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(2906002)(26005)(77096007)(186003)(336012)(14444005)(5660300001)(72206003)(246002)(8676002)(106466001)(2351001)(126002)(486006)(2616005)(476003)(6666003)(6916009)(53416004)(36756003)(44832011)(426003)(47776003)(48376002)(16586007)(8936002)(106002)(54906003)(50466002)(316002)(4326008)(50226002)(107886003)(51416003)(7696005)(305945005)(356003)(7636002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD015;1:O5eX6en95mmxmaWotcOCYdEv+DNb97FBPtKZsE1qbof6d2R1Qdvtq1e4F4Lfrm5Hd0/qbhmduA5Wa/V9XftJtNwfByPbCZenZgSBLH6J4Kdc9KjYNKxvS/z/7ycGHEWZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab59fd59-6f90-4dcc-0714-08d606acdb3a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;3:3uX3+aObx6mhyti70XDJFD1JxibrBNVEyQugkx+4DDztxl4syH5TC0Er3njqVeRlFBf/Ei7zJAPjsENct2LfM2diT3BJFeaM5WzSr5B3/0lsgA+dVI8CrKBD3FtLxmGd23H9c6+5yxX2y1FSHQTo7sB9W/bRX9FtUAjw6V/B2SkltP9spmN58xHBhIx/BaZY3eU6uWsj1AjkKhhrmtGywe4H4G3umFxxuNqe2yq1J4pEuTMgvkSOEaAUYUZsTWirpiEnWfOsBPdeEr3kxPDEcSouM8BFA8qOvHgSU9tmcVPFG815oH6e4LdTQ2Dx4Vu2C8gY8sh/PAqWkD106fPDnH5Xg17Bzv6SolygXWjvmKI=;25:W7lM0tQG2ZGaYvZ/nB++CpLv7I8JWs/JuaT0qrOQEYKXKrNxURViPZm35p3q49WjZI1Ij465BNDzNisWIiCH5zAlHqVwTzBY9L2uRzleDQ72oNx3VgmW0RNyv4kfP6gmlZsfMq1/u0cWpBvswprzKGSMmxNXEcATE3BlFKhToZs9+kz26yIjGhS7dZ9ee8SvpQi8Xy8OYG4WMGlNq6o+l31sAfXwyzknfY/wYVSqwZ33p37YYfDIh6yjFybrxU8C15rGzKq5MgYpinwpx+rZfHqn2UGY0kwHJbvV+uxOUTQtFitGbydMaqHQknnyCOxEzfHJspFNvUtTgS5TIteiuQ==
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;31:NtxVibbYhfVN7cT1XwsDYARHktV+hvny0PpBD9IcCjI2kMbPtkrqzUuPM6OmNy6MfKU2oouNUhXGV3glSDtX1JZwTBf2Vx9NV9JG/875LbE/u/FTVOeIcttOhmk35viseTyvEH6ncXbIB2IZt/rEOI4I2oTBUlkrb8TiZvgqG6ohjXWPSaPyNcQ4mjTlTKggX9lXdMUAx++j2VXiMsmUzDd1xsd2Faiq12QxH9ItagM=;20:tS5Tz/oi19+JdkkgHCbQUQD48lFKMZS3tKIWpyy5Dih/0zI12A6xsoQ+HY04uJdaMLFq/V6sGP3ryOgAhEOcnFQ0FYxaL2fah38pS1Czm/881QFxG6Q4q6XWYoP6mX8Ui4wVC5Tb88u1PuPoJPCyhAQ0hrQA1rmv3m234IZO83wr6yLjF34vizRqWYpgUV6orsB5pMKLk/uZT1zgWwk3cRi+z5q9Qjp7shBFKaX1gWa9+/XmC6HWDBsfLgHmOEmRny9/b1Pv1K+roLfU4hDAErBcQfoHG3Vrf3gnsf6JsTTY0pR0qC/dCU+B32Z6yQpjEmVL+DYN7pMIYEjUXE248/TJTzcfMh4Qw8WQ6DmnYmHtjjaeYrJj8NmmIAZviJ/xGFSspopbNAKSEz5KpnBlxaA9DpApNp0QVupJTzfxgBDV2J+GmMkMKMp9B+bDehEh07WKTQsa//ksrohYnPt7v+vmmVox+AxqA6Fd/JcN4n8LY9d2G9ZIifXm/2JWJXRJ
X-Microsoft-Antispam-PRVS: <BLUPR03MB55133CFB76C38826AD1F9BF9D320@BLUPR03MB551.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR03MB551;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;4:SpjEeCAtNwt8yGgyJGohV3Ps9BiAYI3jesUHxItb/GEjgRfTK6cQzrITz2wHQ/B9n/3HM4Ivq0S8/WfEH1jEHjgaWuCWVJ5osbwRsczUj521IDv1RqqoPcq6EKRI6jhtqViM8ZdTJgjXx0YRH0+GjzWEmoGX7kYTDdJIbFNZpUbLqHVMRuG20aSmdAoaU/u0xcrkOxqS5r31pqpmX4CbvvdBuEZOf3WR2u8W8HzMhgkT78gb77liuxHrRLsmwk6YG5iClpbNaTT9p4oPZTYH0hcQdYb4ZekWjTSn4IIWTphfrQTScXLZV/E32fK2uB7s
X-Forefront-PRVS: 0770F75EA9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB551;23:N47h1hd4vy3IoKdLOeyZFjSBUCrQIrDPPtK8RehcB0?=
 =?us-ascii?Q?nN/4MNA9ePRt9RpevaIfLo/mg6lPC1nJK0xE/5ny19l+6Kfc+bYTj9XhSqH3?=
 =?us-ascii?Q?WwQz5GgGJUjO2gJgKURhCur10o0ePYf5113H/WApKBTtRf9aM4/xWtPjfSA1?=
 =?us-ascii?Q?4rc02vzN+5kWUlk1x9ulV84gyCNVy9PWYhM6Y4EAP4WsTsgp0hD26TX2M1x5?=
 =?us-ascii?Q?bNWMtJCerOrD8RMEq/GDPpDqq7Qtq/NcoqWPAHZN9O3AJfCGlC9g0vh/SvnI?=
 =?us-ascii?Q?vGBo1Njg4Ezbz/cxskp0CNhwKFB18l+FQbyn9y26iA4HS6qbjCXtZm0Q+BtS?=
 =?us-ascii?Q?WIq3mC2hUAcl84PkW2yT9zijIQ5NzC6ZIjKKt+IL7UBy/YAGz5fofhcgQrgK?=
 =?us-ascii?Q?CyqpMAUc71hTWp7IXw6OBhc7H7169TOZz/UCehNGZ3C/9CTx7g/3ej+doPf2?=
 =?us-ascii?Q?Uo2x20Aw9xzVRa8Cz2In3LMGw4J85VG18HmnO45SbMDp7QOXypPklrIwSlDX?=
 =?us-ascii?Q?02fY+EvY/UBcSE+ALU8hFBZWaQN4E+Z1xi6qhVrKbhnaIBR35Z1NET6wbnEj?=
 =?us-ascii?Q?xpLh4el2WlwoqSPYFZEoyuSQTBD/qZmAaRHEDdh0ryOfPV/BgqDO43kZDvHP?=
 =?us-ascii?Q?zTq2bA07UeanXf6qFhWCHEIBO0PPo2LTK+rMChgwLoRqUaD+NcPLene0UTJU?=
 =?us-ascii?Q?65zgcbK0eA5OHTHhzmFwOru0r+ODCPiTct3izn8AHZVWMG/b9ctpHHnUkjwj?=
 =?us-ascii?Q?XQOVlDd40DS+tbX2dk73ycXkjWz8AGpH9OzWW5Z5rSt58GZrYgjvA4IhHmSe?=
 =?us-ascii?Q?dL1VZMpRuYqf1py2ZlZx0uEiB+FT3lK1Uv/8k4/9bhhP0aEYa5X6C7uGi06Y?=
 =?us-ascii?Q?bx+F+CY8kZRjhU7aQMZa5G3uJTB6wPxxFwCMFgTdAdCjXEpv+0jABzfCnf6J?=
 =?us-ascii?Q?w+CbpHjjijmRl+lZUyiDUvZthDVyxVEaSn/46rnE17mUAdbUmAHiDcBdL49s?=
 =?us-ascii?Q?zFZPOqF0zqTRqeBot1zUVTOd8JlOSRAJc8SAt3MPQu+suytW+b4Vi2ZlGS+I?=
 =?us-ascii?Q?dexGA=3D?=
X-Microsoft-Antispam-Message-Info: fbnaCcLMwRvFisjj7f9eFKweyEQ4QE8DJ0P4CJ35gSijBH0Zod5wUStC6BU4/NkdjHv/t7XlupvKC8s3+B6evKdK0ndqTX3PXe0+A1oeJx9EGZpgQe8D3y1/+rniQa/kkzhTIQ+RNQtYrn6KBYyaIIgOVfiA6WL+i1EA2IA1nMwiE5e36VN7dCd1DAZNnTOysBcoraIHPL5kE7pkDguLSbg242anMMCsx4QeKin39vG2ZpKB/1nfPf1LIXS443gpM9lEYo9tn9B3w0b93IhaAj7qxDXAu2qXY2l4p6TPg0osj+cAZnV9ZgtZZOu/DsnidFpyoULK2d/TVfskfa4BLbJ56fHF1eeTvrBB+mZYojY=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB551;6:a+55AqFFJhc+KKWLJy7j8ajmk2gQbQpf/ec8Ip5WqEseDTHd2a7EyaMinoRDZUWMgesU2j2vCN9udvumRAAHgJHvA1GAwGzgV+heuL+cJpsuo6prV0LBpHsfQyZa79w8PFI9OSOczDyfTwgJ/8BRoe1DouI/CjoZTRiiLivCMKCZHcbD1DNUAzzJDUTrw2WskE6EgJ6VCZR1WJUiMyrDmh4fllzPg8bc1Ee8KetjOrXnga002vkTbmPccP8q54JyV4iOlzQTnEUQ5r6NFI8TIUSHX8ENCzj42FB4Gn9kzx/5hOlP04tMa98K1FJ9IDxnVfGNFrHpt6/UmKQIxjgW0minSkDQfTEKzNwAGWe2Pi6jwBL7YgqMfnMBmEPIwMyMebD8eKFYL+O8KQ4+MdaP30aAcxSfysiABtgC2JZFueMz17xPt89lZmsJNs8mHfD41HU7AkeG6Bf2R0hBrwA16w==;5:0K77ywExw9rhcDMgK3Hl9n0yRoLOqq8IjU60ZUUQcBoeKKoCqqXccDE0FBtbDY2ECSi52+iv1q7Iyhz4AMd5rhhMAFen42c64cRjqGGuih+h/nBuE5ofuEN9P4hKre5L9zEgs6MXnLySkssRxFJ4AFA0y6PV/qdorbaTq6zr1mU=;7:SqDiuMM35UKVIdXQMX4744h2IPAPiPtmZ7mLtsFAy4czzXo7Z115qcRUY4kokVROf95U4Cka1/6f4oH2F9sXhQX2nLjGTUAyRRYvXeaRueuQwSvBWwqEfFXf5JxlCmag1Kst1RvfbtPB3H2cScjDTk1neJNCTDkOXpkVvZ6nnBNkAE/HKlybAS7+Cw5iDe2uqsTpa7pjK2P+3Zs7D+LIVOfeKeTPynQIqXyTEhFG79yzHu1QZh+gKpVX/YRXCcA1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 14:54:40.0408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59fd59-6f90-4dcc-0714-08d606acdb3a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
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
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 5a039ba..6281e4a 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -223,7 +223,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
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
@@ -631,6 +645,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
@@ -778,9 +837,22 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
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
 	.validate_trigger = &adxl372_validate_trigger,
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

