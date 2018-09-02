Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C678C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8D52077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IFpw7sdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8D52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeIBRiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:38:14 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:4252
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbeIBRbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra21b5jdOx5VAH9iaT0GOLgfQHUIyI4dHJMMLeAAJb8=;
 b=IFpw7sdJ0QMT/O42q58LL45+EcJA3KGljo9ab3VGO1yG03xq6r9GlcQ7WfmHABDv7Rd+oDyU7nSiCl3k3dPqGj7ibnj+9+YcG0ItgTD0dNUbYIFRm7raLDHimf9hNJvSncFrDl0oSAzAcM/6il5CuvkVzHXNlpxBtIRSk7DzTCk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zumeng Chen <zumeng.chen@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 49/62] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Topic: [PATCH AUTOSEL 4.9 49/62] mfd: ti_am335x_tscadc: Fix struct clk
 memory leak
Thread-Index: AQHUQr723BlBIcUzqEah0BFybjGNuQ==
Date:   Sun, 2 Sep 2018 13:15:04 +0000
Message-ID: <20180902131411.183978-39-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:H0tFWlmroz3uHbdqOiiomTYBvcF1KKxy9SKIBf1txQqRYLwxrwQR3kktLLzX7jo+T1rHnzXigOMSEowooITuW5OvhkaeIXq+I2zuBDS9fSfAwllMLwKPCUN3qHXiRVvNXN/i6iz3sXDYbbnGUxcZz7LKFj4r9sN3p7586QLcuRMYSBABQEGTLWm0vwtTwLbRfEr8VvKBGDj/XBhrUiiiCRpXK5PWtT2Up2DKx1pmzeuJrOtZr5t7aVtijzDP9pse4QmfC5vmanBqlM+7y+TJQymZYz7dyxMyVKycWyBJBNkEMbA2+3MZFSine7bjEonNJw7+EiyHrqpqMmPLsnvaW5ODzE8zZKf74r0gxwj3lY6H8IZTGn5t3ibvbJbxA0E0ntl1gdtAoc20z3ekXfcdZjgpobHo90KiAxcyShLq8DMZz1w+OD4GID+63i9iQdoZUCPuVTxWsBUFSDNX42/woA==;5:83ZpfZON/E7x25W+nTEEDPhItSGrkyrIFf0URlvrqp+8LNLEc6Y5p1bEDIZtEyQ2wh1qkTD3GMewOYq7+a4s6Rc7gF5qhbjlP4ppkBpju4p0GBerN/r3M1gUwNW4IvI6v6jzHjcXu3qMvmZ+zZ+s4kF356dVOJMCXyEMvDz4DN8=;7:ehC2lY928+FwANkvtA3SF+BKAuY2bM7C7ui8jAnDFppAfSxrlJOeCk6+gVwH9telcpZPr1OIiubC8+S359+yBNvX7y34d7YiNEAwovRfb7nQiRQN6KEhSKGEwTB/JAyAB43FCPMigiR6J0FO5RLoxh5elSSaAnnNzDJ5VTkamH4WOQNvGNFuua+PfAtfFJntjbDr8dR8nQRNYBKyaWFXNDIWr/LG5y6JGzIAl3YVb+1p/1tWimqdkfVQ4w5ZbTdh
x-ms-office365-filtering-correlation-id: f214059c-35a5-46d6-d9b0-08d610d6281a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741914F98921C5D8493AB02FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(5024004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(15760500003)(6666003)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003)(505234006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0Ral161VMZqtdxgDUZ8NAz4kgEUzZYdas7WmXviRU69J5PmICNhI925gc8tQz307ud6O7w2aKx+d5T3OOZ3KwOsUV/ziB5eThcDomelY70Vw+cswOaTJ6l47haiOontJsYnWU3Qu9n2WgX64ARcVgy+DGnlIOXZowtSGx9M4DfK2K1hLAweRTciJaVVLOoiY39DiWrbkxdHamLXBL74kHtopeXpz58F9xODDi8Jdue1gfESNUl5YzHVa8J5Q/5UXemNw8MyldMRMfmpwzY8gIBqVw77FjGXQf1gRrrQ0xIyq2kHcZ3d1KxNVkC1/L0yGZbp/lwoNVXFT1jWKR4yyo5oTjDiFH57ZYmGdJ1cw6OY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f214059c-35a5-46d6-d9b0-08d610d6281a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:04.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
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
index c8f027b4ea4c..798f0a829637 100644
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
