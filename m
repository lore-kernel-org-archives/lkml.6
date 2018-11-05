Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB992C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2C2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GS6meeV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB2C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeKEK1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:27:33 -0500
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:37904
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbeKEK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxtZZiVN/1FHB/Vzm2DtRO1c6e2bFC/veDoPsYBdfWc=;
 b=GS6meeV0xFV9yAzBUOSMkwQJi7WR54qX7TIpvVmvS/aG1Ecl0YcfW0coKjldIf5nnDNKBwakJ70shNCF7CEA+JYCFL678PCjmsEDPHaGAgsVMU27rdMjP9NKGwMWfgiCt9mlCuxwqB6ZuB0+DZ1DkrqS95APoTdNBCA3mDo7wEk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 01:10:27 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 01:10:27 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/2] clocksource: imx-gpt: add support for ARM64
Thread-Topic: [PATCH V2 1/2] clocksource: imx-gpt: add support for ARM64
Thread-Index: AQHUdKRWw5FruFWK9EOTcQFBS7imcA==
Date:   Mon, 5 Nov 2018 01:10:27 +0000
Message-ID: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3642;6:CVXwl4GPg8Udp1s5Oser6gjOnQm0s73aY4nB4A1Gwim42pLsX9IC0voRBlHJCb9Nb/DcPRHt8jgSOc6WP8zobyg2eqCFcbqOIJtL27kRh+njN52S707sp2+Sgxn4gqaFDpCU5T0cPDGlN64wXHjUPqUub6YU59O9MruvVZcxp23Wl+cvSX0bQij3ytyndD3tIM+PvFBlQpO1D9IV9jrJSfsLJavl/orjm1OFmdm1MSj28FT01i1GyTBWmOcI3Z1W+uHni4RS5AgxcIobxCg+Wyl/43uAuEDfzFm4/GpiBgcnk/JeAdu6TH8oXLD1H+jzMJypI9/eFx/XOqqC2lf0E9sZJ6EZ76zNJ+iUWKfNsC+SPvZcRWYZWhp8iLZrBn9V+/6lP2OTF8uTQEghWDpq+W19UQEFXKIUqWNFmo1V3/UAiuy8XZyQwypiBqIQJZyUM79OzgXKNNZfiKPs65NSPw==;5:ZnRerh2S5MuI5xhvRiera/3fbKf8kQPASn2ivijsbFVZ2qDCcsnCgztTsiQRgo1DbiT/C9L0hmAlZGzThC96OirQlDH5v/a51KWAT6bAwGolu2WgDr8kBRbHAfpGUY0nuG3FKuPYcWgmYZKi4PMf3q1EFAeTVQTRuFiiynO1aag=;7:uDooSrPcFAAUN58JBQ3r071tjV3j0vDquH8txAZfdCqWB36hBKDQwsF7PhH1P6lUKFGhJ3B0GajGJBAU74xCNxEzhxqILgIU3W4YP3Au24KmwaSbl3x5R7daf0auQ/MR+BXjFQlexKIs9SfMPbkzrA==
x-ms-office365-filtering-correlation-id: c461a45d-dbc5-4aa2-8c58-08d642bb78ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB3642F3A3A211E9884E3EDC5EF5CA0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3642;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3642;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(2616005)(6512007)(2900100001)(2501003)(316002)(66066001)(6486002)(110136005)(186003)(4326008)(53936002)(305945005)(7736002)(99286004)(97736004)(478600001)(36756003)(68736007)(5660300001)(105586002)(2906002)(14454004)(26005)(8676002)(476003)(25786009)(50226002)(3846002)(6116002)(8936002)(71190400001)(71200400001)(106356001)(6436002)(86362001)(256004)(14444005)(2201001)(81166006)(6506007)(386003)(81156014)(52116002)(102836004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FRf9hGYs5hJtTeDfpXABqffycUUYW1gqLV21mtDB78o74LBPhr0IkZB/cU/H6L4wS2H+vvNwOVlBiEI6uM44kw2Eq4mwdrSOCmENTkzNtkb51lWxWxo/3VaINPzwQlsU4WY+PMq8NCMPDC4FafBsJGUcjWeSZlonsd9xAXb1ZNjt/XNQt61GQC5RJVElpIFuVsWk7HgEkfzJdNOIVW05ZToLvc8YEddVm9mvYJcX10nH3wm5GiSwal2LmNokYev1FB8AY5HbZNzukPaQWvPWPwXSTLuSAHcD348gdQz08ydc0I6xUFrzjHT1uqF1sB8jYn/MqFZBPJobBRqEML1Q+ivNhnGL5iY+A3+0aP+nbZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461a45d-dbc5-4aa2-8c58-08d642bb78ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 01:10:27.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows building and compile-testing the i.MX
GPT driver also for ARM64. The delay_timer is only
supported on ARMv7.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 drivers/clocksource/Kconfig         | 2 +-
 drivers/clocksource/timer-imx-gpt.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 55c77e4..5e892ca 100644
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

