Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A05C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A5E20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D0Y3y9UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A5E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeIBReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:34:17 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730317AbeIBRc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzpmkzEoCnMdgPAf1nFAxj7JynKX9Oewcew5FAdERRQ=;
 b=D0Y3y9UF42B58D9oDvLGJF1yEw6tmQ0+WUHRggc/lCHpFeu2W1FJPe6BBrwW2zuwJ/zhC4sEnTRKIQhSpnea0TZ6cWlSxrWOsxNfooVcnyeqhop1j2Z0i0RiI8mtCw5PfxtZ0Dc+psjkRhAypxol5zewQNF14XFamHRk2iLf4BQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zumeng Chen <zumeng.chen@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 35/47] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Topic: [PATCH AUTOSEL 4.4 35/47] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Index: AQHUQr8k1nzvvHcMjkCwpianvMkZDA==
Date:   Sun, 2 Sep 2018 13:16:21 +0000
Message-ID: <20180902131533.184092-35-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:arkgvmHi8yHCYGeaVuiG9C443PB1kWJ3o20XPi+v2gJImW+tAJQr6ZAUvZkfbuK77Z8iD570s7rpzWNxt9Cr255ZmgVp4OFSJumeyXMZeohww5LxmMl6Ruu+BcvT/6G8GRk+O0u8d6E8Uadcxplo/DsoMY8oZZIdHpWYu5nQQuM+HZrpAlBgd3kWo42+x/KFN6KGxi1Ff5qDhQJabfsSnz/oSJSXMvJDBJzu9gRjhCW2sHrzyE7s8o4Yn7xo4Kx9B0Xjr2U8Q0/cFt36Af8+qRiSnohyuy153bWZGLEWZ+xje/kXF+uY9bXeiTrUTwtHeTSG389Pom6p7+kLbJpvUXCC6QeJ+JfEMWxre/3KiT7USR3+Rke1jw7yqskal+UQwOJTVM0+wFdyLruokVP5nmDFn4NZvvLvnvow8Irrcb9080DK3GHmUOESRhgfcuRE5JGuWyxbb3piiZ2zsCFyOQ==;5:D1xstB2LJ3/CMfAsP5WDk2a5Ciy3w2l41uNXbbWgcA/qJr4EV26qwz5mHMThSxK7LbLuBIBFpYq+/IG2Fd+7BVJxjswmMSU8zKcEilxpfx7s0yS7+qjta5+IhjmT8VJnWkdEpDQsH3DNgZ88Q2Xt9nOUIf1FkR8ADhTAXBUXhbI=;7:0oyM/yQW7WLcHKo/QCNVmmsUyNsoLwsDrlKppWrWDwiG1sDeqB2ZLGbI5cqP5dTMgE7m6wXsO85sO/HaQZfYFOCQ6py6ErnULwGCRwFkoRL4EBel08YnsiyXBnaEJbFTjgxpiiqB8HyABK8Qs95quvyWSQfX8zlnkk/sQMm6R7vMbTzMhYz6hpPRZXyItsXTp09aXmQTsRtivZU1mcSr4Q08HFf0+/AqXNS6mRk0v1Th++Vf2PooYp/LXGuCVV1J
x-ms-office365-filtering-correlation-id: 877e3a66-08bf-4e9d-50db-08d610d64b7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167AD332EB3B9153189CC69FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(15760500003)(22452003)(217873002)(2906002)(99286004)(54906003)(5024004)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(39060400002)(107886003)(72206003)(14454004)(256004)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HxZmLwi2px7msIvd5LhTyb6FD+ghGlU0YDqa18HyFzRErc1UMgYiaUwre7lJIGXjIHC/XBDbjq0cl9NLImTYz5dPCohIL981h+f5IMuae93svJWjFHc8eq8SbEPUfSQkB/5fLANjeF/SoZKSaFCs8JIM8FBkY28VOgwG/qmDGPfUxX8rXLO9AM7QjPAAsvZ1XUlWdmM4EsD59LIkqHVWVvvCPy7PSepl1tJm09nqnDHCyDf2ZmtR/5dng7UwNhQsKbLuSqzeAfyID9YlsYu4HOX5sDn8O1S7TRPzVOcm01fXYyKDVWq1b7aY9a/lDVE2Xz8l6VszY1eYjOAw5OBql8nyp5Z1wb3kVrYs3Peurd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877e3a66-08bf-4e9d-50db-08d610d64b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:21.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zumeng Chen <zumeng.chen@gmail.com>

[ Upstream commit c2b1509c77a99a0dcea0a9051ca743cb88385f50 ]

Use devm_elk_get() to let Linux manage struct clk memory to avoid the follo=
wing
memory leakage report:

unreferenced object 0xdd75efc0 (size 64):
  comm "systemd-udevd", pid 186, jiffies 4294945126 (age 1195.750s)
  hex dump (first 32 bytes):
    61 64 63 5f 74 73 63 5f 66 63 6b 00 00 00 00 00  adc_tsc_fck.....
    00 00 00 00 92 03 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<c0a15260>] kmemleak_alloc+0x40/0x74
    [<c0287a10>] __kmalloc_track_caller+0x198/0x388
    [<c0255610>] kstrdup+0x40/0x5c
    [<c025565c>] kstrdup_const+0x30/0x3c
    [<c0636630>] __clk_create_clk+0x60/0xac
    [<c0630918>] clk_get_sys+0x74/0x144
    [<c0630cdc>] clk_get+0x5c/0x68
    [<bf0ac540>] ti_tscadc_probe+0x260/0x468 [ti_am335x_tscadc]
    [<c06f3c0c>] platform_drv_probe+0x60/0xac
    [<c06f1abc>] driver_probe_device+0x214/0x2dc
    [<c06f1c18>] __driver_attach+0x94/0xc0
    [<c06efe2c>] bus_for_each_dev+0x90/0xa0
    [<c06f1470>] driver_attach+0x28/0x30
    [<c06f1030>] bus_add_driver+0x184/0x1ec
    [<c06f2b74>] driver_register+0xb0/0xf0
    [<c06f3b4c>] __platform_driver_register+0x40/0x54

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.=
c
index e4e4b22eebc9..4a0f076c91ba 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -224,14 +224,13 @@ static	int ti_tscadc_probe(struct platform_device *pd=
ev)
 	 * The TSC_ADC_SS controller design assumes the OCP clock is
 	 * at least 6x faster than the ADC clock.
 	 */
-	clk =3D clk_get(&pdev->dev, "adc_tsc_fck");
+	clk =3D devm_clk_get(&pdev->dev, "adc_tsc_fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get TSC fck\n");
 		err =3D PTR_ERR(clk);
 		goto err_disable_clk;
 	}
 	clock_rate =3D clk_get_rate(clk);
-	clk_put(clk);
 	tscadc->clk_div =3D clock_rate / ADC_CLK;
=20
 	/* TSCADC_CLKDIV needs to be configured to the value minus 1 */
--=20
2.17.1
