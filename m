Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6618BC04ABE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1521520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GFcW8lEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1521520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIBRTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:05 -0400
Received: from mail-eopbgr720097.outbound.protection.outlook.com ([40.107.72.97]:28208
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeIBRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHmto9UCOH2aD8F0gqOWED0sUOk3SsX+dGycu3yem1U=;
 b=GFcW8lEC518spAw0c2S7x2Ujpm6nhKh7by1CxQnjbiHpWao64k6E+dNpQhYWWjAETwPkwxKyq3POUn8icUnCRkXkLAFtmU0iyRZmsU4p8c1F+KcyDG61WfgmU11t1JQPi5dtr+sgrmPPWCZFE4UGy1YV13mkBIjZdzZE2SFOvpA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.3; Sun, 2 Sep 2018 13:03:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 008/131] pinctrl: berlin: fix 'pctrl->functions'
 allocation in berlin_pinctrl_build_state
Thread-Topic: [PATCH AUTOSEL 4.18 008/131] pinctrl: berlin: fix
 'pctrl->functions' allocation in berlin_pinctrl_build_state
Thread-Index: AQHUQr1Kl66ku2QzMUaIM4kAlI4DrQ==
Date:   Sun, 2 Sep 2018 13:03:07 +0000
Message-ID: <20180902064601.183036-8-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:HS1F+uLgmNY2Sp+3TpMkW/km/RqOwAZuUMruaCdMbfjWjDDULNwCl/ct5Q1X4fU6n+m3M4otGPvha+KEl4a05XOJv8/smXkekJn3xPYFRsHwLMG3OVirq7Qn7GB76KsSlY2YjWPAVjSdhI6qBWvzhNFqyYPFWLVMgb6TiVzAC7sva7VH/7sibuQpb28SuSuU5MClydv07Lkb1e1P3uT4dYTQg6fXbUjzABpvLi5ySj8faUPNBtxBA/jabvrJeDNX+AYTEH97+NZOFu9nEKtZnSrVbtKauK19UGepPzmgITFN5ce5uOy5fJWmYmjLIV9rG1QY2mWhnSBP3DD9oDv7415Q/3WlWPgPERz0X8ROwDROOIMxjASSfa9x02QrCI+q6iAtlnMMlFqb8aiJ+OsFmct5X9a7la7VxoMpZZFt9i1lfMQRXrg312wz/HRwXLxo75B6RLX3YY69g2hp9NTzbw==;5:StZZsjMnpwMe6CBDYuCkOfoJtmaFZ3x8wx7Nv1baNIH/AbbDX4TD9PlCj070jHT///gFd2MeltaK6mUSE8Eoe0H8vowTK4NoVRZksl4os+NhWhdu8v8B+m2zYs9x2Ab15v37QzQnNvC35bqEiVFmsSnQAF+YxcVgfdRyHzhpSBM=;7:D9nBjSqtFWHVsRDrnGzj8SGOe8oyfsCewakzfyxVc9oJlkg4fc7XU4MPXC/BcD9XjsdheP2QA/ZG+Y26hahLhsMiR+5LVmSs836CeuDnLoP97K1vSEu/giioljgqpQ4J6XJv/d368yfWhyc+4StQo9I/bmUdsXS5oaBPBeBaNLgnmK79tGnMCN+PWz1NtzsfsfSubrwgXOFpv/kCKyU8BenzsmSdyQza707DbF8h7kNTEC3nEIMe7CmR6rKuUDUc
x-ms-office365-filtering-correlation-id: 0201ec80-73b0-4e5e-b185-08d610d46d8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB083774647C5F66306CE5063EFB0D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0837;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0837;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6506007)(2616005)(25786009)(476003)(2900100001)(4326008)(6116002)(1076002)(3846002)(106356001)(305945005)(66066001)(7736002)(105586002)(10290500003)(2501003)(72206003)(478600001)(5250100002)(217873002)(11346002)(10090500001)(446003)(76176011)(6512007)(6486002)(256004)(53936002)(81156014)(14444005)(8676002)(81166006)(68736007)(14454004)(22452003)(8936002)(99286004)(316002)(102836004)(54906003)(110136005)(2906002)(107886003)(86612001)(5660300001)(186003)(486006)(575784001)(36756003)(86362001)(97736004)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ccGdmMbvdYx7jASYDOYXZ+zBHyjwRHtsfc5kwMHIJZF7DbQHl20uU3RzVQNZ5iiH9oBOtJrtp2mdDYXUk2qArsdPfIqqjqseupyCzkqGSobtEGf1IkbTbkKiIOUPSzY6pittG6qaoJc0UnXHtvDQ/b/OgZs6IEWxOtq2Oeu7FDU9nZwclw84JjoY/rgIWXt9IXgEKe/l4hl3jOG8XcsOs3yz/qNOYZlF28CJw/esBeA3h6NzYwe0HvqSlsLHEtTBifx6Ob/HnZHCi2+/aTWZASTDQ2XBBrVgCmrLMbB7BAFC9DdjSnrTsz8FRQMYXa38c+XfpuNj1mI8xy53QjLClIwYPjLDRYnD76Yq/ABqUxg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0201ec80-73b0-4e5e-b185-08d610d46d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:07.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit b5031b7db77dc47f474f0efc2b2552c32b7bb59d ]

fixes following Smatch static check warning:

 drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
 warn: passing devm_ allocated variable to kfree. 'pctrl->functions'

As we will be calling krealloc() on pointer 'pctrl->functions', which means
kfree() will be called in there, devm_kzalloc() shouldn't be used with
the allocation in the first place.  Fix the warning by calling kcalloc()
and managing the free procedure in error path on our own.

Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marv=
ell Berlin SoCs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berli=
n.c
index d6d183e9db17..b5903fffb3d0 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_=
device *pdev)
 	}
=20
 	/* we will reallocate later */
-	pctrl->functions =3D devm_kcalloc(&pdev->dev,
-					max_functions,
-					sizeof(*pctrl->functions),
-					GFP_KERNEL);
+	pctrl->functions =3D kcalloc(max_functions,
+				   sizeof(*pctrl->functions), GFP_KERNEL);
 	if (!pctrl->functions)
 		return -ENOMEM;
=20
@@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_=
device *pdev)
 				function++;
 			}
=20
-			if (!found)
+			if (!found) {
+				kfree(pctrl->functions);
 				return -EINVAL;
+			}
=20
 			if (!function->groups) {
 				function->groups =3D
@@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_=
device *pdev)
 						     sizeof(char *),
 						     GFP_KERNEL);
=20
-				if (!function->groups)
+				if (!function->groups) {
+					kfree(pctrl->functions);
 					return -ENOMEM;
+				}
 			}
=20
 			groups =3D function->groups;
--=20
2.17.1
