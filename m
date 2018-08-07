Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78845C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BD121502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="bN3qPMIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BD121502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbeHGRLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:11:02 -0400
Received: from mail-eopbgr680051.outbound.protection.outlook.com ([40.107.68.51]:61888
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388593AbeHGRLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Pa9NnW9av97cIvxM/db7chCuSnX70RxJqeG90u/kU=;
 b=bN3qPMIHFiyE4GBUOQOCtgCS1HzQpUiORitEvSmPAx1VmmWOVh1QcYL1lYhUcxfblrIWdGpZHPzToFKLr7/W5lUBcVEibM6kMSx9TBVXT/AkdMnIY4gPxYfHUX+RLXCl3Lyg90+j+mFr/YxAZO7b0hdu6N14q2VJMIGBOYjtWpk=
Received: from BN6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:404:23::30)
 by BN3PR0301MB1217.namprd03.prod.outlook.com (2a01:111:e400:403d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.19; Tue, 7 Aug
 2018 14:55:11 +0000
Received: from BN1BFFO11FD006.protection.gbl (2a01:111:f400:7c10::1:157) by
 BN6PR03CA0020.outlook.office365.com (2603:10b6:404:23::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:55:11 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD006.mail.protection.outlook.com (10.58.144.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:55:11 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w77EtAo0029210
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 7 Aug 2018 07:55:10 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:55:09 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/6] iio:adxl372: Add filter bandwidth support
Date:   Tue, 7 Aug 2018 17:52:20 +0300
Message-ID: <1533653540-24796-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(438002)(199004)(189003)(2906002)(48376002)(336012)(486006)(426003)(478600001)(16586007)(47776003)(72206003)(106002)(44832011)(110136005)(316002)(53416004)(50466002)(54906003)(7416002)(476003)(51416003)(106466001)(4326008)(246002)(7696005)(36756003)(7636002)(356003)(305945005)(126002)(11346002)(2616005)(5660300001)(446003)(6666003)(186003)(26005)(8936002)(76176011)(77096007)(50226002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1217;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD006;1:RDeNfq6K80nhcyhqBMt7shEvKirobCS8FPYit8Uf1TbWZ+kWEMXgzvoq1k7QPPLSbqy8NXlZICdxbuysJjYlGRjfZp7tmhqYLSBq0s4eo2xDeH1yqcC3hlbP9nCJQ8bw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4b78e3a-246b-4085-cd55-08d5fc75c662
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR0301MB1217;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;3:y9F1MMKJznyx2AIK1U96kerN3dRM2SgQovTKRlnHGxGRyFW2mWO5bVR+zO6TA8aSzEFEdT1xYAjawztwvUzRU8hwqORmZO5Oc9P5mLcaPd3nTAXeuzIv/grn11ZI7dAUP7nAIf3OjF8cbKTa9Z2VP+NAghMryvK7+yXmOEOVUvWGj/U0ydpUg/UL1lIWDoSGHWULWcx1jnD29Cr+Sl7kWF4rF++ku6LKd8IHKtjWlSS6Z24wYJwSOWqMNwKdXJFXUjA/03KGq4Y2YUHwlOtENzQ72GgnpBJrci9jLwwjSge7khLXq997bLfjpCZFO5/mAxYVGAk3X0aploayK4EiQur0OKoEnHLsjpytTdY8AqM=;25:uqXnE1xy2u/OTbpQjSmwbdt03Di3StZN/yb3+4u+boqHBDN2R50CqoG3phhf18bMKl3HdAQC6I7P7VBsaeceYYZReUhwtbaqHFEW0OWDP2nPyPTED7ZZiLzuH9zdfThMY8Q9AiiV8XSaCTpls4hckhHq2mfhWSpLyYAeu9388TBTGS+WuAf43/AKj6C9vvleoNYPjNWtomW78/qGwvYB5rtlDzMCaChysjEqTzAXuTt4pNSUABauEwqlF2kdLqkPWOP1T9gyvS6xObc1LyLRvSX78ZrAgWJpeBT1RV82oF3UcXmq+nh+0lH8F9NhRWJhiHjOMFDSQwBJEqqNhgIifA==
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1217:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;31:dhllU9+hSyHonOJefkb41UAPRAxnCzk2a8cS3mTHkYacygBqxFsK/KCjoEMjM/Pl8bI95gSUICcsl0hA0yC90RC+ygF9tq9hHHBAxUeQO1+CRMZXuQ0HfiprafG4OIlOBVOWboHYaAIqF6W1hzFHjhSZP3iqoTLsEc5VHAjknRNOaMj1IeGWMbhHPNA/cqMKFjoG8pT8SHgOLQb+71PWuUWjdAWS+FPqYpoI/KsIhTQ=;20:oG86CHfgOSNyNLO1L7Jj4NMGOjcNSNRP4rkbrZ/HipbVGb3kg6qCaAG9B6mBDkShIPS5loK0sUR4DbzCXHBO6vrf74kA/7PuLDdDYyWU1s/8S5tTsS3aERsGoxbGEUDSJAmbzxT88nF0bV4TO3weRxaUqWot5gXedcXPTIGLHoNlBRE5iP22nZPRUDPPQIs7+7Mvu31YqcAEWBPtIjF6/wBaQVRTIyW8+LNiyn7bx0obzCegldejU0WUSe4mkK9+nd71mJP1Qyy28dtwGeZa0hya7YBBuTolsnKIElx5ETXj44V+/A3ROBCn8IALp51F3n5/oYgwsIg2iLgnUhbFfIr8noit+JawsTM8nDBqnqWiIxpNuDk9VmG55hofxh9yLHb2zL2RgYps2ktASOwrjJpfbk6Zp8oBJv8+s1m6gWApbrDAZiPzlCUFquxmqt8o3njMCvw9ShuKbNe9NV3oLZY5ssX26MBTQBKWAYO/CA3NnzLApYbZMuuJNexnrPQ9
X-Microsoft-Antispam-PRVS: <BN3PR0301MB1217A113893F6A426A2CBACF9D270@BN3PR0301MB1217.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN3PR0301MB1217;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0301MB1217;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;4:Q7A/S7LxBs37rXDryX6M4YOrDKc6vNwuIU2cEB4V6Tws3y9ldD4kqms4Gx3M7Jyt6psZWRzwitpQv/fWA+fLzM4uVUCSiN85mIWhWG6dolfi5ckDjpHImoYRFzgxG4QrBS1M/3LBj1utyt+y5oC34qApg9vvjJwXNuyaXfPwPivdDIiKmv1pDeTxOY6lSBQKOIOEgyZENF9WdyLcO2CeXQNNQWRQHu0xth+QDqU2OWrmWGhcBp5h+lu+PYoPVVCvxaafR8C5hRzceBWJbDEVQUDso/pSuzQGF6yJkH9ZYilk3hQpvz3Edt5RGgBbrIvr
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0301MB1217;23:3QH6nC7CBNhlchTxNv8fDpWEQSxpiyzbIcisoxB?=
 =?us-ascii?Q?aNwy8yK+Hnl9imrJdW4lH5H0UiGV1YFvaOCfidiZ5xLG2453dMuxg1Trszp1?=
 =?us-ascii?Q?CXWFKj0p3rCq9cShzpJb/VBLVZN/9/mt36ffE25CIMbTClW8P7ii8rbEJdfl?=
 =?us-ascii?Q?Mhj/XtypnXaaLrVw95CIR1Uq4Qg1PapmxggpPefHgjyTWK6ixukIHnXQPC1d?=
 =?us-ascii?Q?1nKDm1qQsIFitRD7xLXq4Ys0GHndBfMPD9SIYXV0C1ASeThldVvIIBMdNvMG?=
 =?us-ascii?Q?v+s4neYY2DP563Md0hw+6nyq9eMGnEf6f/C5exh14viEkH5sPj1utuDCSVkm?=
 =?us-ascii?Q?X8b/Qea7hb1QOgXGeMjddM2tlf+bwjq/bE0yPYbMju8c780+1ks71p5CXQ4U?=
 =?us-ascii?Q?q5aoGkkEtfsNxBLaAP6TMSYhmG+Bp1dED1cf2ZSalQ19rDpktC083HDv/UjU?=
 =?us-ascii?Q?O8ndqUt+s2AUgqVVqzArsL0j44h8eUlUk50Z+3xxP7fqa7VmhX/OhCjEbZVl?=
 =?us-ascii?Q?aAApx9cdFIjMid21WN4XsMPELnjUUEMmco4rAIQodD2e86baqbyErQoq//tr?=
 =?us-ascii?Q?6tCWrpkjVRC/bHgNfwafYBg6/JYu6HivPprgryfyeusTPUUknx/Se+yFo5gn?=
 =?us-ascii?Q?1erVTdmBU++ZrEoJKTge+gLcuK++V+7esNsik1x5gyucFX0g7vVToSIACtiU?=
 =?us-ascii?Q?aseo8mSJJX4KUsxtOOmGamMlpH3DWTKOCCQ//BVw977dIOeTHhDaipd+hfrC?=
 =?us-ascii?Q?x4b5vA6KEkak1djQzHuMhCJ/iS/eLMTTM6OriknNB3eLEdeU5YT3fhypq3y7?=
 =?us-ascii?Q?7/P/3V3nnqpFTdzzOb7ako4wwGYDrJBfPOrq5mTLtx5FAzo+e24dPpiQ2/3b?=
 =?us-ascii?Q?KU/tpB4KbuOxQ13p6Fuz68J1ON6mRL7QkHPfcR8Gjqi4Cs65z0rnhoSptVIR?=
 =?us-ascii?Q?Vp1nAchllFSjHW5MdUyoUdIG9067m0BnlNqAz2dAIAPZl+SZQElcfZ6BkINa?=
 =?us-ascii?Q?bxDr+C3zvy3oQ0PRP4yyruye8HQ6K4XGstjQnkp40T95GRfU8i8uQ8Tvtgu9?=
 =?us-ascii?Q?vQXaUmbxHzHtixQGr265aVaCfJvdc?=
X-Microsoft-Antispam-Message-Info: uFEDMRPqgjf2/o7r0TdVrLWYkaOWvHj8n34R8SqrA+dZvo09lC3vODYaWMHmMtMwSq4jOvbU0BfT3CNxetIyyW5EtwOhhpvhVN2F113fUhSTU+xcIkjtSKTKL2Mw8RCfj3uSnnFZITdYwfJ4qavt4sBl8BaTDhaqFVyLSZR6acL4/je6w02YbJIJInqJONQY75lKCFji8VKLonR2SpabaEgH0ESbo320mEFgD29tHbJWlJBTQgKNdcjnues+8jh3WiDlS8RS/hdj5g5WUYOlr/szGQ4UjXxxSPgM65N+VNM7p8l0bzp8ufoXCywPI58DhuCJhoST/I6y5LgdV8p3sGYimrGf9Eev4Ace9aag6yI=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1217;6:rztmpkRCTRgKn1VFsaP5RCXFM4dTiIgIVDFTD/AdW71P4L/tn9I5UoG2SipFoEgRzYG1gdPdc9pkxIpiJcxovRWSUK8XPQ7ti6GuGnuWoAEQD/2Z+B7CDvl2tvNn+7eePPdVvb1v3iyn6sprYleChc+7FBB0qlHAz9xGsMEMlMIVNJ/DGmSa8S1/pEEIqzX1RYq3vbW4onFTf3TrlI43KcRs5V2q7GD/BujHkz4VKtMs3eCEcL97gkU1+F5ogXBrS+uCfmp18+1JHUq9NiZb3jAwndQIKv0PBO7cJ/7JJwVvYKpLn12zf6zWiOyvsPfl2eGwXMPrHQe5j04INyeULKc/VSu1dptLWWupK2FSY3AIQbdQVK5Q+FNqxc0cBsyO9ZTJzHjpIM5YE2ZlRRGEam1G5CJTaopmCzogDZpIgvGzvVdPdMc3TsJi2H8jkLOHs97udMjRlQ+AiyC8o50qcA==;5:MNS5rvHoBV3tpyFIyaR1v/CjcqM/4gupuospkUAZbBi0nG9NzHULysBqwb/JZpb6M9YpZf6qN8itlIeM6znn76rDpV7Ea68d91qLa2gROzOuhB6oD0x34Ofx/oeKBCBPJMSKA/FLuAR9/7a9n4HMR27sTrOUVTjOue+Pcx6mkj8=;7:Qgby0CfEf6Zdkmu4p/poNf423CCYtvuJgkNnM3FpugeR3HMlGNlJN8AQPEkasYctW8nkID7ZbsdkcctYM7siaE5o967LFBs3IVqtzhG0Pg4FGayPJ+PZZm5EOotroy3xe9CnSb7MIC8whCaoBPxuGZicm5/tL10tB+Og2yk9azVJ+GKttDUK/vXljUtaGALUSj3Y1t1SlwLAyYaiEeXgsJM9kyC6vigzrgLy5eWm75Fbs8hCkxLbbJCgvC9BrCV/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:55:11.0498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b78e3a-246b-4085-cd55-08d5fc75c662
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1217
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
index 76c4a1d..c6f4b95 100644
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

