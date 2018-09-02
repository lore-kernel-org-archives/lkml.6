Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709AC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5E0204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="d9NC7PQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5E0204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeIBRYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:05 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:20016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbeIBRYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt0XXJoAWyjo9mzJLfJzLljrW/rDAbB3dTSQZ/WRuD4=;
 b=d9NC7PQBVEhYq4AMnYwqGDY74o19B7dVrHqQaUaQ1d2sfaFGPOscMtx2fIkegdW/SESnIurAnwgjtzCropNXGzOBDCFvOEtTuurOFD752O4N/Qc9odQn6p008hfnv49ofkLr62/G5ldZvRZu24G1ieJzfpW7OaDHjGou5XnB+/k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zumeng Chen <zumeng.chen@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 75/89] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Topic: [PATCH AUTOSEL 4.14 75/89] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Index: AQHUQr3u6JdTMmoXLEWIhazkXTrdHg==
Date:   Sun, 2 Sep 2018 13:07:41 +0000
Message-ID: <20180902064918.183387-75-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:rvCMw6KXm/xu/+s7yqfzrHDhWWwtLD7TmTSS7XK28SZp+dsQECMosrx05Z02AKEpiILmiCqs2bgTnuWsUxPQujx17aOp4fHKKM7Y4cAIqMCcGAf8Yu/3f5iSGP/nfZpMlUPwu9kZRBV/BdjDbPNLLDz0DrjfqPr8kUEPxhPKHMaLdUxLy6S4X4a7wRo2+7iFLsZwdjaFHAKSFlHvSCh/QPc95nFVSgsKPZMGsCkKTc05ErRxVwMn4GWd1DYto/4CyzBSvzAhL4EZMdbFPOhC5CaLNC8v9hwqYycBW9DEhU76ll5u0huWz8mXucwQxkvPLSv5ZoBbEjgsKcl/zzTeIci+Aki4A6RsvsDkfCtGlX+jeRD6bTE60R+BaNLC9qNcrB+TsqrmHyddjLRzLHf745e0Oo5Fexmxfw7vNLQFGvT6+NJJ3qseDXd1OSbw98b4ZT39U5hrYRnkdRqdgzjfjA==;5:7peQhIgUg1jCYfVnMf9m0QPFFQslCJVgpBFMagYQ1YHeDxlt2RHCmkiX9feNhbE5Cs9GRfGzh7OSV1nGJKdl4nI4D6Vd8OfI4Hv0QihsB2uqQLdrvQIAzBuUsYjIcR9l1NM1MPNdmo/+SaS4/EdrTMazFSB+H65/YFwPoMM0SXU=;7:+nZ23a8axd8VWtuSAm7zu+0vKCxsThcNzR/cqrH34EKEbpx4mN2s3mhbbwJZbez8fZfrbqCzapWHo3BCdpFxRZ84hHz43narPYswdaxwU28oz0Ii0L7hFEpvFSzwBTndsMk2DU1uSlpskH6/wsLkya9tVN8lL7Ib2tQ3RJ/RI0VJQLq23eOFTrdCQjR6PouzmkLjaiObpWSGmOgnZwz5sZLeg5JmQ1a+z9oJo51omR//fNkQ3sueDzCgQRE+TcwK
x-ms-office365-filtering-correlation-id: 44cb2d0b-89f1-483c-7948-08d610d522fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01492B62A3AE09472E37D928FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(15760500003)(186003)(6666003)(107886003)(25786009)(1076002)(39060400002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(5024004)(217873002)(36756003)(575784001)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wfluV37OKWQuhETJUh+0tg+1lNHvipTpkAYITtbW9QV+0OMp9fYXViXcegvnBZigocNDG42v9IU1Jq9h9xdKJWtcR/GqspOGuslK5XHqJW7AuSWlRkdKSsvOG/s8perHZGwJevsV8JyMbyFQGbIoSHThW8HMQELbV834J56TG9NkiKO4FNUfBvn9olMp2Ek8BwW1VZi1IL/uUwpbKoM5avx40AVCvSlomnmVxYYncqIc3rDFpxQHbUZ5W3a1r+01kVA4GIg5I7xRWEhNEazJ/c/+UdBq2MPjNjFg30Fwr/PWxZYP2z8RKwMuw8z27cBiEbHp5BTh8ZYyFJ2NJdU6H0bVbgU0XAxHFmqAM7u/PbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cb2d0b-89f1-483c-7948-08d610d522fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:41.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index 0f3fab47fe48..7dc1cbcd2fb8 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -210,14 +210,13 @@ static	int ti_tscadc_probe(struct platform_device *pd=
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
