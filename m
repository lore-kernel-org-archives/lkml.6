Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CEA2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hLsxGfhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CEA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJROnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:43:42 -0400
Received: from mail-eopbgr40054.outbound.protection.outlook.com ([40.107.4.54]:28931
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbeJROnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGHC5J7+fAAET3IvFQGHhHbtyi7iT2b1MiHlC1kSKP0=;
 b=hLsxGfhiFf7mxGO6aUxAcoQ2RdFJToMbqF8UfKMA0WNc1tqKKE43QfmYNs7rS1slg+eQK6idX2Zs6MNTHZDChTXm/pkCR52F8j6GBtzm1xxo/zUatmv5TxSgIOGclc7tbdp/+AQb/aS4BWJMVboOV9EOhEjENfpyA1zykfO2xYI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Thu, 18 Oct 2018 06:44:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.020; Thu, 18 Oct 2018
 06:44:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clocksource: imx-gpt: add support for ARM64
Thread-Topic: [PATCH] clocksource: imx-gpt: add support for ARM64
Thread-Index: AQHUZq34n7moOQqvFkGEc7IBlg59HQ==
Date:   Thu, 18 Oct 2018 06:44:09 +0000
Message-ID: <1539844776-23921-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3675;6:j8UZ/VXIE6ThFmSjFwaKsxkCRlHvL/0XnVam6tETvBrMpN+s1gQD8XFCcMZs4ZxpaXqMTnLiE6Oe2BCIs1DaBj8mdqx3x65BL2owXUF/paXvCsRyuTPZ4EIY9lXj+UWhfrEfJ7vKmn70iJfGOfxguz50E6Jv7qiqhsG0DbYZLAxBdKqfD5PzpK/Vd15LCu36uKwjPtXjVUtI2/NpuI5DNYxveyimdu3/n7aQSRxeG4SKr5pNoUkwd4R3E4MstXCUOXG1qx2x0npXEDAFMjbKadyA0F1/lPM1YWLd/DiiTt0jeHPl+J/Vs/OPQ/Z9a8m6WC/yQKnPNkfqdvdKymk7TTOgamC3rqbm3AwvVq/cMC+bVEiKhkW/wQLak8W5h4Whh/13A3DgVSWv6s/2tNKseTTDbkvuNLhS9dYnA1ovJSF+ZhYk2u+OtbPOOtoqABjy8/hSE2Tz/BacUJzs5B9+GA==;5:XEB0Bc43dfjXtfwRGyBiLI/iU7vmRuUzWU4lxydAT43LGy3p+VmjIcSvM6+mNyhvAqgOgMJHx3cL53tGHhTsBN5eubRUytI/tZkQvdQ09My9yRlNy6sU3Oc/NMNyaR60haVrxvCsoD8cZbatUS8wX+6YiqaYPmUOOEFH8XGslF0=;7:YRCfyKzZi3o5DPJXG6sd+5+47uCGI9c1zdT0n2mO+cL4aSyhzphTD3WA17eJXA+9AVhbDIwUlyo7doG5+v0QpXu5xgyWlSwM1oUPV0SLaLj3Gf6WyWmRg6XcVsdFYs4Qz4cBxJNRuuJ0b6h9mM29j1HouO6ciyUNNG6IS8cJUrnmZh2XWvoo/l6LgaVfjAkbT94//5nxchroBRA9ZLXuyqAQrVXB4Tqv2az/KTXcVuoIadqdHiyKFc4NXimBUrVR
x-ms-office365-filtering-correlation-id: 81eee3d5-22b3-4bda-2393-08d634c51b09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB367514506DB47AD355A3CE7EF5F80@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3675;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3675;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(3846002)(6116002)(508600001)(14454004)(4326008)(106356001)(5660300001)(25786009)(36756003)(2906002)(316002)(97736004)(6486002)(53936002)(6436002)(6512007)(71200400001)(71190400001)(105586002)(2900100001)(2501003)(5250100002)(66066001)(81156014)(8676002)(1857600001)(81166006)(186003)(26005)(2201001)(102836004)(486006)(86362001)(99286004)(110136005)(8936002)(50226002)(2616005)(476003)(386003)(7736002)(6506007)(256004)(52116002)(14444005)(305945005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SB9lvaaxKg4LTsIrixA/dD7gAt0LBk8bEEoX2a1PjTWk1r5PiL+y33CQ33TZTqRIegtEBMxrN1K0KOb+TX75+61HzB4DXVyuEBUD4aXBtZ99yT6dM9FseUkNyktRK3bhWT3dOSQDPvYKRCNopla9nHCyCWPfJuSbOgD682OOx4U9eVIm1Nl+kmZJ5MDmYwI1QLChI+cuIGq+PsABhc+6IsWeI/x4+ck/HbU8lVmVIIap+vb9mZyB82tOMa7iFozp7NBUoPznbz6qb8jQugUCDZLXKmiZv7ZpswaoDgO6CcqChSC1ySqzWhdkw+1R4E/SxRjX+UTBFe88s06Um3tovv91wB2UDbew4jfxDlYn5ZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eee3d5-22b3-4bda-2393-08d634c51b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 06:44:09.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows building and compile-testing the i.MX
GPT driver also for ARM64. The delay_timer is only
supported on ARMv7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/Kconfig         | 2 +-
 drivers/clocksource/timer-imx-gpt.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..e519f1a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -580,7 +580,7 @@ config H8300_TPU
=20
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
-	depends on ARM && CLKDEV_LOOKUP
+	depends on (ARM || ARM64) && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
=20
 config CLKSRC_IMX_TPM
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/time=
r-imx-gpt.c
index 165fbbb..a3d6ccb 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -141,21 +141,25 @@ static u64 notrace mxc_read_sched_clock(void)
 	return sched_clock_reg ? readl_relaxed(sched_clock_reg) : 0;
 }
=20
+#if defined(CONFIG_ARM)
 static struct delay_timer imx_delay_timer;
=20
 static unsigned long imx_read_current_timer(void)
 {
 	return readl_relaxed(sched_clock_reg);
 }
+#endif
=20
 static int __init mxc_clocksource_init(struct imx_timer *imxtm)
 {
 	unsigned int c =3D clk_get_rate(imxtm->clk_per);
 	void __iomem *reg =3D imxtm->base + imxtm->gpt->reg_tcn;
=20
+#if defined(CONFIG_ARM)
 	imx_delay_timer.read_current_timer =3D &imx_read_current_timer;
 	imx_delay_timer.freq =3D c;
 	register_current_timer_delay(&imx_delay_timer);
+#endif
=20
 	sched_clock_reg =3D reg;
=20
--=20
2.7.4

