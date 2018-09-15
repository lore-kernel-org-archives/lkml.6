Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56BECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FF320866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F7X3gnIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FF320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeIOHDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:03:18 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727866AbeIOGst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYFq145tQReV9saqBFbwtlHQA6FF145QaaF+5X3FNNg=;
 b=F7X3gnIWVosm3P+JV/GPruZSeGcwW8bGNAVn5LdsQWtfHQrjLm7NXDZ7HR+i+bBhuCuQarbcqwu35deRZT+YG0lAaOzria4eO/IJjGaG/IvDr4jFlWPDOwfEddC3kE5jjeYK0MHmVRV7ase7BS/YRT9mY5VQKjFwPEhoYRTp6ZA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 74/92] remoteproc: qcom: q6v5-pil: fix modem hang
 on SDM845 after axis2 clk unvote
Thread-Topic: [PATCH AUTOSEL 4.18 74/92] remoteproc: qcom: q6v5-pil: fix modem
 hang on SDM845 after axis2 clk unvote
Thread-Index: AQHUTJO345A6G2sL1kGwm2FZ2DoPbw==
Date:   Sat, 15 Sep 2018 01:30:41 +0000
Message-ID: <20180915012944.179481-73-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:z7Km+a4W95ylIDPFYzEL+g1BP/1a0k+e/MKZ2SdxOSWQPFIMUzFC7XQqvhWmlNZRAY/hQnZN5GeiGKKPLYKYvJICjSKQU9wt/3GPTeBHUmCYoyXyyDiA5K5Lw2eBK2e169Cuc86q/CjevpvC8ECrqGwvrbmMJeLjYsixlZtu+mCHHFxUKOEBiBIOQK8IXiS6HRKm4S+4A0fDdRGRurU3BrEWJcXfgspvPA2CrnY0Orwll63oed/8wMYFWfZZDyqzb41AxbJzlPlPeVJ8tcLjwupz/oB6v89Ds9etG44T+tTqCzkS4wIv8O09ZnB5gFByK3doPnQWMyUw/MZtWc1ymswNy5Z9uIdy9q4KYHquYLHAkIqH9RFSZZzvjhRdCnSgWLP5MO2agoRWWbaYazYEkR0SrL4FIvH4EZrPDlj8ZXVyPS9e5k/Sp2KVqD+CBB9rEGxWYKh8GjpBWyZGB+EigA==;5:G09q19Cr9Fwvwlqka+ZAbbSSBFRPgUHWw1TvNbde/pxmLJeRGSwPlBqqAn5KVtsGhlUNQs3LSISKhy0cGm4PtIBDnGbvx2dYx8i2jWunxQmsxX8oPVcCpNmGFVwlS2f7RpXXK9vMXdHR0V91yUaYjnuzZ3WUVaK+cTtMHsIC9IY=;7:7GgvH61ZQy5DeGXY6d9bs3hfNQ2wprijA4dkAYWW6cbORzai90OUA4Bo70myAzsAkK00spVbrbHWlgxoJqxYFhWrCFW3tHW9fMqyuXH14oiA8Uzo7eJJZfAszUrtjjnoztw9DWKfeQUpOQDzvaQXKwg4av7YkvErXuy4OHyWSWhy3wuple86SfcynzOa3WaRL2m1Ev1wNitjT8n6WBKE9ngGg7EI1TnFh1223BG4JS2Qlw5eBFEt3LtqhlGo6FcC
x-ms-office365-filtering-correlation-id: 19871397-b22f-4540-1b71-08d61aaafa0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470C5848C7CA71842077DDFFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Pn4aOD0wZo6V43hkM4yMmb759Y+rfS3uC2pc7bopvfj8nHGS6nKzbSjuNHBZF782Lle1YHk1Wug8g3FI/b6kuB+D5xQ9/7pSXNaRQhmUkXt+V2zIxV1qA+S3Ct5aODEt5BdQVz2r2LpJgSYv+NHSHcjEkjIltWW+QwYDQCrSkh294gbBVUpSvc7o7nhePrktdkkcfYLOWAeS3FKloA495eikIjQFGpbl0i2x1uz1FkSzCF0q1qudJXIzGpFwDM5lFC7pqJ92DUZKv9Y79+wEbEj0Opjli1uXVXwyikJQDmhYKamAr46LEpSug/r6Nhj+HYGoAz/gvgWcQX0zKklK//pQYOAyT5HxVMrpQk5CPnM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19871397-b22f-4540-1b71-08d61aaafa0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:41.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit 7cbb540a3a68e4d4a8bef2d9451afb1635b5d2d3 ]

GCC_MSS_AXIS2 clock is used for disabling boot IMEM (a part of
AP boot up). With Boot IMEM disable now a part TZ/ATF, AXIS2
clock is no longer required post AP boot up and expected to
remain untouched. However if the clock is turned ON after Q6
is brought out of reset and later turned off, it results in
modem hang. When Q6 attempts a power collapse the internal
handshaking to check if AXIS2 is idle never goes through since
it is turned off preventing the RSC from getting triggered,
leaving modem in a funky state. Hence removing AXIS2 clk
enable/disable from the driver.

Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q=
6v5_pil.c
index 2bf8e7c49f2a..e5ec59102b01 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1370,7 +1370,6 @@ static const struct rproc_hexagon_res sdm845_mss =3D =
{
 	.hexagon_mba_image =3D "mba.mbn",
 	.proxy_clk_names =3D (char*[]){
 			"xo",
-			"axis2",
 			"prng",
 			NULL
 	},
--=20
2.17.1
