Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D213C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7E20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bE7ZaIJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC7E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeIBRVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:31 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:27886
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbeIBRVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i8iVY09s1y9/Vrm7lbnbvFDn4YgLZrktKFqM6P9oho=;
 b=bE7ZaIJTkl99p0gUeJfCzEWE3AUyAenSmGr5yYHMfSRtMms94x+DFS057MdQHq8jkhScb2Pz/aaO8T96VzojB0U/Dd5tGfObVKifWCvb3QapCs1g9gNNerKtaFtV2bMDONYZJ2Dctqv4tiCneremT5cYj8KwNUsMeYz1RByPeV0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zumeng Chen <zumeng.chen@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 111/131] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Topic: [PATCH AUTOSEL 4.18 111/131] mfd: ti_am335x_tscadc: Fix struct
 clk memory leak
Thread-Index: AQHUQr2bX/frDxhQbU+4fRlLop/QPw==
Date:   Sun, 2 Sep 2018 13:05:22 +0000
Message-ID: <20180902064601.183036-111-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:XdRFZgRHXM6DOlfm6+ujewp9+IqBH/IyPyMbpmBeXoeFBTJYsfF6cyp29ohqAUGGDy576HgdlmKWCxqy6JvLQ5OP43PYQXYBTwsZEcrQoLekY4GCTi1QkZPSLmM6urYokBj6fKH+eL9+jv+NV44m8/MY22FgpLvt7VxIqT+sOG2xTvvvoUKL+qw9fNesGYnh2fa/ZGNuKrjMRxB+r4C98lmR57hU6D7jXoW6n2j9TELNJeEddviankjSVLbwz0mMREue1wC66wPEwY0wOAYtKNDK8TZO3gv0APJP3tkzHv84tMhgJ1yNAwwvxx0ljDNk/pB0v5GlkW50aWRr9OADI4kjy4r56R9vVtW+Nqr5eQ/Zvz9FjvnvfeX0/9W7zjPCUUkSJ07zKLlu1ylwzrIRnNMl1ipilHodRkGGwCNWbB/vETLg3XSb4Kxc5EfmHNJ68fWqozM2JHyhaekjCyILng==;5:kaBU5BpNEKgCiHysOJjNK/R+9va0Ji27V6Bs41Rg++WRB4/SzOMz7dWc6oI5HoIZJZrNXj1kqmhWWy925K2iGLDureJ94kgXFuKstJGEndB1KhXBXFn7MQav1zCji8I5eklCmtkFnjOVSycKHPnWZDGRCu5tgDuG748zywe67+g=;7:iEauaTVCvfbh5Glc9uWcnh7AHFbiscfo8qRKbAbo4BSb8oWkBv7VpRDeOHR0MMk4lrSaaWMh2zHdmQHCJ+yRcXf1MGi7GBhnTfF5CIChAeV0o8UroDgDGz0btodh4JWVNPPFiUP8NlSZSYejQJR08rzrf92deSRpACQ1BinolK07xDdR/oYDQ4x0YZ+59Q2JX2arG4+n2eIULl9WJnxPE/mEOiKqt166cxto/Ef5mIJsJE7ME6WAldI8FMwiBYzY
x-ms-office365-filtering-correlation-id: 3608ac92-6f50-460d-51bd-08d610d4c7d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01840DB95D935D8DBB8E4669FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(15760500003)(107886003)(39060400002)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5024004)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XoTIQ7hrHFK6dH0bwyi0nQLmSVhnN9AiBL9zthVaOQI3kLzvGoQnmru3N9TLHDtJPQUM55Zmuo1W/KRvA9qFk5cKrdYTP7wZpoeYIJTfczWKCy5ToyFAOiu5fAcfpPl1AI4CsPtGNXQach65rt2A0mmO6ZvtKb5Fg0ObOki+V0ybdTKbFAjYYV9sVHqVWRgXoLhMpnJIv7v5TQ7K+mzd8YVbY8LGYkHWfWIjMGhnvP5Qc913dZp3DS7ffm62nzHbOjYe3qGf6eb8mgN+mBNIOYuGf09AyVC4ruAE+dGuzC+lbo+SePP9Co20AN/T4LZggxfrXyT4wrO0+JJzOBJ5SIa5QuVi/ODjr7Qus3yE3ho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3608ac92-6f50-460d-51bd-08d610d4c7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:22.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 47012c0899cd..7a30546880a4 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -209,14 +209,13 @@ static	int ti_tscadc_probe(struct platform_device *pd=
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
