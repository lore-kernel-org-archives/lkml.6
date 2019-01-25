Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50157C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1526A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="YRXS2Wxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfAYHwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:52:20 -0500
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:61874
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfAYHwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZHuxHV0NU8+OgapU5oohEFj2PhqN1HYwCqQlCRFjNM=;
 b=YRXS2WxaD3ApdQATI73y7wROcO9JuWZNoLar0FkbY7BUfDLYRXdxSMz4VIXBcccACMBAw54z+3l4AR4BUPPbU2nbVs3wjT9jOISgVYbfhd/Itj4unS8xhNbHTV43/4utrc/5u3aRNrD541iX9dvoVGPENrxY9rF1h2CDdEbHOS8=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB4511.namprd03.prod.outlook.com (20.177.255.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Fri, 25 Jan 2019 07:52:18 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:52:18 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: dw: use devm_watchdog_register_device()
Thread-Topic: [PATCH] watchdog: dw: use devm_watchdog_register_device()
Thread-Index: AQHUtILkJEgOoFDo5k+scnWOyUtyXg==
Date:   Fri, 25 Jan 2019 07:52:18 +0000
Message-ID: <20190125154604.66801c6a@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:f6::15) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB4511;6:TC7mk32yKT77g3EOsTj+L3dhGhsauP3TDJ5GwcBi9cNQF9FBHBPul5mtjugSiixwwKdqoxdOmQz9M75TSgh3awLHtAzfxezdsPt0EouX5GFTgtFvTOAYSuXO/gxBcudgtkIzzK0hBwgnmAHfknaBh+qmEaBR4hfE/giqc2N00CmY/7ULmoyb361sFFx5Y4KhoYaz8bsJ3LOqfAG3CGgE3ceWqCLIWnyqdCa1/KVA6nrUAfTAtnHuIUKuZmeRjSYx8PkW2eManedw1D0egpuJo/G2xK0MED9k+PZkw0OTLonYwqMLu4PAV66A6wbnn3a5E6AuIO7Ak/HYBJknvQ6WnuwuOBGsWQ0J7oBH7s95+v8BMwJH1kegBCkif4AaDrlRXJvf7sc7MadoyjrUrjfDW8+1aV8j2umtCKGWiiK/OIvYY36XwNdodPX/x1NhKshHQpO0Y/QShWsVTm0ezu5AiQ==;5:ymhVJSaEBIY1lc6woFuczqW9r/SOPBg9iYeUpeKsssjhipbEiEZmB+guFMkJJVJOk2d9F4OEZO1jFxMQsuy2x8EKK1/I1LI/yAZJ/vZJaq+J3ZYx1dnFf//33ZM/zT+6yJSMn9H+xse991wopqtV0VguQENnoafqry353nnXcD7xNYfuBvNKjV/UCF4vShFBi6a16e+765lUJd8C/EBRzA==;7:1kJEeAOnzFLJFABMUi0ABLM+LLIgi/hDcAXij7y2CRc0XQYz6Pw4QF4mNl+e4/azLETXIqtlAOJMXKvXs7PnO9nnbFknWYOUXFCWDGFGh1SOzMD3NmnD7xjWZSE1k1Ni7krmChG1o+kaWm4CYwjNvA==
x-ms-office365-filtering-correlation-id: 9203bd69-1e85-4fb0-a3da-08d6829a0739
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB4511;
x-ms-traffictypediagnostic: SN6PR03MB4511:
x-microsoft-antispam-prvs: <SN6PR03MB45110253D09F66B1E7EC28F3ED9B0@SN6PR03MB4511.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(305945005)(68736007)(7736002)(53936002)(86362001)(102836004)(6506007)(6436002)(386003)(25786009)(6486002)(52116002)(33896004)(9686003)(6512007)(4326008)(26005)(50226002)(8676002)(186003)(81156014)(8936002)(81166006)(97736004)(316002)(54906003)(6116002)(3846002)(2906002)(110136005)(4744005)(256004)(71200400001)(71190400001)(99286004)(106356001)(478600001)(66066001)(105586002)(1076003)(476003)(72206003)(14454004)(486006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4511;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: daBNYLY00NiidfhMH50yH/hyDdVCLmogGZMBkxxKKj+ziqFv66E5B1hpwMdHM0JRzBvi4nY6jx09JgRJ5XeSLRE6eqz7JKjl5csaOUDphEtoDah3RQR/BDoyAwubIGTpqFo/FJp/s3MPXUkv8X+AoCgMuJpEw2SAsxYfS6TU+mtQ+O7msMvVofgztWW0QwVHpn0HToH+vaaBse5mWif/DBIIQelsoo+bOiLPkq/hqD5P6ZKrJo0Inx+BDgj97aOMhqymQY7uGSPwFf1uWKExVtkYTk6lw+Sz53uCL4yUs5NrYsJ1WfrfKgzmXv9kRs07Jywbft5owdO5trGUpy3+CaVuEuLaLHODt1oQo8TB3OKXLKA39SfvTW9ZLrA9qjbF5BIS8mR5Yu6FlsRuTAVfXVO2YEGSi8nlcFq6l9vk8QA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52CB72195FD926478CDBCD3A3AC154A5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9203bd69-1e85-4fb0-a3da-08d6829a0739
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:52:15.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_watchdog_register_device() to simplify the code.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/watchdog/dw_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 501aebb5b81f..c053c2de5c2f 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -303,7 +303,7 @@ static int dw_wdt_drv_probe(struct platform_device *pde=
v)
=20
 	watchdog_set_restart_priority(wdd, 128);
=20
-	ret =3D watchdog_register_device(wdd);
+	ret =3D devm_watchdog_register_device(wdd);
 	if (ret)
 		goto out_disable_clk;
=20
@@ -318,7 +318,6 @@ static int dw_wdt_drv_remove(struct platform_device *pd=
ev)
 {
 	struct dw_wdt *dw_wdt =3D platform_get_drvdata(pdev);
=20
-	watchdog_unregister_device(&dw_wdt->wdd);
 	reset_control_assert(dw_wdt->rst);
 	clk_disable_unprepare(dw_wdt->clk);
=20
--=20
2.20.1

