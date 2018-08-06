Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F14FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49AF21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uvBgSKtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49AF21A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeHFORr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:17:47 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:45111
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731180AbeHFORr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG1fO3rSmTzb6j4vkImfrzlZg50lp/UX50w6HuHDIDA=;
 b=uvBgSKtlk1FMDggadSwT7avdrNUggpjoM7c2enw3JH3cjwGG7xHQsjAuS8sQAS67JFN7Xj4o/rVPLffa5Vyh/WC/MoTwvImq+Kf/jPFVXIeQaRoQN8cxmsfe8taf87XIjEoQ5v6KoUQpPZpJWnceniavZJVrUTDnkzl37Q1zzbY=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by DM2PR03MB559.namprd03.prod.outlook.com (2a01:111:e400:241d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Mon, 6 Aug
 2018 12:07:51 +0000
Received: from BN1BFFO11FD025.protection.gbl (2a01:111:f400:7c10::1:144) by
 BN6PR03CA0092.outlook.office365.com (2603:10b6:405:6f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Mon, 6 Aug 2018 12:07:51 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD025.mail.protection.outlook.com (10.58.144.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:07:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C7oDv013201
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:07:50 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:07:49 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/6] iio:adxl372: Add filter bandwidth support
Date:   Mon, 6 Aug 2018 15:04:47 +0300
Message-ID: <1533557087-10401-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(486006)(426003)(356003)(76176011)(316002)(2906002)(50226002)(246002)(478600001)(51416003)(50466002)(5660300001)(44832011)(336012)(7416002)(47776003)(26005)(77096007)(305945005)(7696005)(7636002)(186003)(8936002)(446003)(48376002)(72206003)(2616005)(476003)(4326008)(36756003)(126002)(8676002)(54906003)(106002)(110136005)(11346002)(53416004)(106466001)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:qGnMSDt6g59ymttgUotNT17MiKHdXNhl4xuaBLG8ritEp3wu7c9QO42VofuUTvUbatDw+MVncZjhH56ISfYoB3gHYtH9w1GPlBpZf4UVcfKheFUsxNfn9RU9i26oyu0y
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf572db-19a1-436f-0429-08d5fb953b7d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;3:Avf3JaxIk+u1dzBaTlwNwrphxXJTFPGA9VUTRLbpuzgqBf36HIAAmTswmRZijfufUe0VlnhFcbssmvzjIA4GsHnAwJzas1YCrco3YVunsLyb1egu4K84jxiH15GKWJViySsTj9tuuy8fUymliOtzxwOt3/9lz4jQn8CzJfnkr1ug2h2sMkJp+QgPNblu26MYSR03tzH4eYlBWVro8p/8JVydMaMDFtwQqarnzmO8e/3fm+jNF1q2jRUn8YnasJ2AgKUGrZjRRTiR6UtkehIaXvHzQwWMyLlzMJIQfn8zcLiaEPGnOh4Ecx05PDHtq/74NCkn5g94AcPDBBFDUbFF2fXu1UpUEhZfJXaLa3DjDYI=;25:D5TIJA2lwzaB0N1EQC4udWT4vpZvNhf0JnAKSv5V5DZ6XWxmCajYDMaZIxsnchrVXdLKLck0ziHIOTE8gk07NSmqINfdXXhA5a0S4afSgoPQjO7SA95xOY5ahjraddLBLUZQAeBpikvuL/Gk1PtkBfgrNiwS1W6xQJnQ3x6XVt7cADD1hcZPj0UW0ZIcbobh6ftwEgW+3pfU9Y0VmjtnWbCiw8o+Wcp45gaBXvmM/op/G/EkRr6WdZmhxsEQI2T9PTs8qHsIG7QlX+wE81mY+xzD4nR2J45QJLy2LPPIfCFsDL7H14V/uJqJ3K992/JnjiTVbfZNf2/gPVlWqhp6IQ==
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;31:g+x6hw9vbpDg4mlB3faPQ9Nlfj4DrL47uCLP+pWnkJCVgNV1Jhcxiivnj8/pwjtLP23wyrRw1BhPfgVkg4Hfb8uT9S80oW2a6dcmUvOR+mtPtRQRLK0xDTpGg40CCOCysLHUZ/ERFnebR/fdO6+1RSjHlCDsn26ANBtscDVgrKjfkSMi4lA/cbqMLujhjywYxmNzjC6kH5gxEyxvs+OZ9Z++8ZaPHr93srl1PmuHHhw=;20:q7FiTEWq4cQth2zPuAoESc9Gh4OOe3lnMtA8zDjarJDnxBv2i9VU101l037T4SvSI2sa7l1AiPMLz/SVbxhgnuwkR2Rdqq9dVPhy2AlagE9Ki9cMjU4TYhR7TSc3Rjo4XBKY4mXy4bIXSicfxMJCStnLwMgSKQaQiNCrKWDyM+VhZykn2DBpfAiU+Wx0KVW/IIgMBYjm13/B24U3D04D3qwaAoiiFiYO+PelHr2WKkLN0iHUzckPpxRE42dguswpvVtvgGLpbN+vDssUWrzS2WbzbciH5Jc7KyiahSICjObvICzKXN47InsO4tvcF/4zZClON40Og6wOERM3q1PlKDzLz74BRCSWIQWufpyjqDcfTLf46i4zBAdGHJyNxBlLHmYxpyQs/dkwKjV+nvKBYQT/hFv4oz8IBlWJpfIyh0F28zjTisEpjezTW0rC5XcBzkPwmnoauRWpxk8IE+aqOipGg4ADRhQc7ZJTFHLRDuIfSS7ZHCnZHkirfOZ1a1li
X-Microsoft-Antispam-PRVS: <DM2PR03MB5591A45F2651EE0B94F1BC59D200@DM2PR03MB559.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB559;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;4:/dVM25uLT+gZSusjS7BONVOLYIhpblEnPKiOu7Onq6dKlzpXrYLPBqkZhgJyiIjaIoN+oRgrU52s9+KCEtCPB20wQIcELIAO+NYtixwNm1rghOXXmYu7TI2WjXB0DHMSHD9W6nes7jqjQLDLFFsXsrKn2l7fDUne40yxJuMJX7VFRBCQ2vwysr/LO+ng+Veyo09sY0CsbY9UYQj80G1w+UFAR+/nUODGupoK1f5DmbjsYyniWoDl2z1asJ0Z/rMdPrRfpFVBiTrZSYKltxGN/c8eQN5/lR6CHOTrgjjGrWpKNdJKZCUiApX4lNclblCQ
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB559;23:Jxxff9DFv6FRtlTEhnikN/Lo3geKGp8wFUML+iPiYJ?=
 =?us-ascii?Q?SdLEYNY/WIsktXNdWoVBkzb9s4l94lx7GGb/wMP+VRW60gZPpcVxLT9wzTfu?=
 =?us-ascii?Q?5GC9oFrX5NyakUvkDUfsGBgCLj3zOmbAeUAuh9uO07PkTMeiskIRdS7oEr2p?=
 =?us-ascii?Q?qGw52SYmPBxn48VNTGEzfmgkU8sTaRugY9azKjPvphVYbACHi2KI1MY5kZp/?=
 =?us-ascii?Q?t1pWxlzENagCq/gXcSnFOcuzSU+MLnet7WKVz3siOxohjYjpCeDYBDgDBquj?=
 =?us-ascii?Q?CDvdaJizjBPVwg3rkt8fQA3L5clArqLK/XgOMFzn/hcr6EJu3s7JPjGEz43z?=
 =?us-ascii?Q?rdiSctuhVllTUt5DQmVy3p2nqEuV+tBvG9WUc+EweAXaBQ9iEChiEcQm45du?=
 =?us-ascii?Q?HoSONPJBpuVBYAEMI2poAHbPZvCqTrHyrXa4W6sbsYxs17NhN/NTJXkd6ZtU?=
 =?us-ascii?Q?fIVcDMxftdNP+zPqroeKkX73XZeEtmJMpAipyIFFTOIvUQ4wTtp7JdX+sEjY?=
 =?us-ascii?Q?d7toNR2YrySnaC58Do4MlB9TafhdUmPpM32ts/nDaBdf52cPElIiM/VKXELN?=
 =?us-ascii?Q?VQz//n4JJpzwJi32G2LPLW8RjZ2K2ro4j1YJvciwSjbxrRX/Ez5hy6eeoVxa?=
 =?us-ascii?Q?Wqqk8dweuihw64iWbbb2TDNG6VovoK45AIX5DHgxpQkiVnacCSHfmjZEQZMM?=
 =?us-ascii?Q?YYuQcY5LfAt0cjfQR0RAIcXtMYxxCL3tq/5pzNkFm0y+EDC8iGt9uDqcTLiQ?=
 =?us-ascii?Q?SgPByrsWAyURHVsjO80QYt+FC/3WlTcsomDSP7UXzVB62lcxzIPSwJU1VI5R?=
 =?us-ascii?Q?8tekDWJrjkPnhT77MO1AGH7TPnm0rZeVF9KYwjGN22xwYdnCVMXwhugBA1hn?=
 =?us-ascii?Q?FpQeuQK0vrNVKOJhan0X2i/dyXm4hJb+52mJlkSvkr/JvnqQ6+1K7Rzndzgb?=
 =?us-ascii?Q?KakaBu9OiYpBKq+dNqcJrks92z8/E7aeyVkyqR8/JhtyCzUsk8ZJ/UeFFlUT?=
 =?us-ascii?Q?UE6IhA+GF4BpPMgbZdFdn5N2Ukcy9vqha0+RNhEhLV1QmeX9eC7dH/zdkREl?=
 =?us-ascii?Q?oufMo=3D?=
X-Microsoft-Antispam-Message-Info: G3h5DlOAs/n0/1pFbkq1ejuXIUI8XFTSQXWQbluW+ES3sPFAgqwTz3noUjTFICp4qSJpG9X88dmhMOZhmlW+LltB4VPQ/6R3EIfEvgVD/F2CKNFJSJjAFMUVwcZYsnF/2Y4290sVlzVYhjk4BGjbxVrjuZYi843PEcP6MXWrGJKJz2Iq+nCpPcWbFgYx2Vz57bvIQdfRzfANz+XPiKoNPjAlMhGAkvpPZ6qCA9y815XnhmFOmZ/OKXGQN3lB/2AfqcuGDpA4ak1X1WYm9Azx80QDphYtYVKvu2pOVDTZnHMpU65Yds9k+iHQ0L657A3LFYVqhc+nvTy6AUsaj1KhXkySj/0I2AcDRB9qIHqw/gc=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;6:hyypOL1aA60ipI6I3HxVLGHhNI++B6oBJJmg0voTg4i887hPyOIKnkaT9VsFRJyM/Zi8OS7l/cwMD84L7zUC/vhbn0c9jcI2St0/SzHBWABC811zcaT1O4U9HE+adzHs0YxSfoa7opy2PXvu+rIbhd5oyXnuxf0D6tIMYjB4P+xcnRRLZpjasK8ttEY0pPAP71/TVr4uIbXWLYQAu/CIif/r1q4/bDx8hz2JLsNPje2AFpFs65AsKS2oCY9FiMlg/a+pummye+toTGK3Xkx5uWH6wQBp+L+Gznxdw3cBiICfQnPVSw6ym3kvhrtNWHGrDI0HMCDR0KRpybPViXurQR6+Y2EpQJKZoSTcI8dohHagfhcG90yQFK5N6VSzkOaka/nHNFTEJetnTxDtP/EbcdQeaHSa8OEkpJ5PF1Z7oP8fAhODnQ3xEDVqrISgF4Wrz5IzM8P2qSQ9vT3BsdhPPw==;5:wAR2Wwa6OJPuUQp9WdOvIL4TTDsFqa9IeBnuOGPWFq0TkLcMoNEIblexZMztkaQW1MJsO1qnmG9yldjTSWmaMxRQOItNkvGWyoI8NujyfwIUrjR9s3v5VkcadwzLbbesxCZOcrpqoRj/rfr/rNZN9yPWyxw0CHeKJ6/Xh9Cqhv0=;7:H6AMsMW+C6xCTp3PKClJ+l3Vojyfuh9oiGssLpfG+T/jPuCiGx7cdbCRXLmEAPWa6QYGRkAcOL5INFq2t/CeT3YRmxW05rswTcDY1WdrH4vbUew+jlL95KmwSqOJSSDonflbVquBN8l4s6svk3fvIfNnERdEdUdYAeuGs8zh6Vs8a3mjshH0J6ghb5Sh/oqYCnbZg8Lf4JhVicR3Byn5hMJBX4+xxaHPkwiJIxmQ+LGy94xZnjpusHIUnZpeASVI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:07:50.7665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf572db-19a1-436f-0429-08d5fb953b7d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
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
index d991d1c..58e2f61 100644
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
@@ -823,9 +854,12 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
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

