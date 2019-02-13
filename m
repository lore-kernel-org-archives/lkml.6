Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97D321904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ghFGHh3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391850AbfBMQBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:01:39 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:13280
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730692AbfBMQBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7KW03SQh2l9y9Y0DgAmAq3pPFSmGgjWeJSTKmZpwW0=;
 b=ghFGHh3XLSUovkvWQb1DWVl6Cm3Z2f8T6GG3ep4QTGrfJanD8BvTxJ9Kzu7NxMMu2+5YE7AwLEIM+3IwaLEjeTUkOXecYiV2mW8Wk7tjvBljQ6dr6Mgay5sPoInqR2nd96ukQjqn2zdYu+kHwNOldOKILdV8zNzg0mQLGi3lfbg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 15:59:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 15:59:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V3 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUw7Ub4OqO1UkLH067EH1cbtXa4A==
Date:   Wed, 13 Feb 2019 15:59:32 +0000
Message-ID: <1550073243-11242-2-git-send-email-Anson.Huang@nxp.com>
References: <1550073243-11242-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550073243-11242-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0039.apcprd03.prod.outlook.com
 (2603:1096:203:2f::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0917d4d0-0ef3-4ca1-8f8b-08d691cc3de8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:QHA/XPIUafqtswGCT/DzGb9mTOedx0XxOPSPS?=
 =?iso-8859-1?Q?u7lbWxGPv+tomFsh1jq9+Djv0OB4Fwb6iXhfZwSm+Vr1NXjDpo1A0RLAA/?=
 =?iso-8859-1?Q?CWlhmuB6DfSAmzFNiqIe/ZyGRuRUKrABsezk1MM9WkGPy3zrW6Jitb//Kd?=
 =?iso-8859-1?Q?m/t7MJ99XvkRGv/8HHkHKEl06b9iacMxpOSuzqjxxDpuZmG2Xjd0gjeoot?=
 =?iso-8859-1?Q?pSDhJsfsYLC62ID6lZ42zR7UFu7HtlZQLwEz5xgkwk0bWWgEpzAQP9Ldtx?=
 =?iso-8859-1?Q?ZmOe0nlqo6RcG7//wvYspzNY/jO2WSl3wvlTaIQruN5w2Nf8fbPwD2oHcT?=
 =?iso-8859-1?Q?5Ix3inSSL0vXuu9k9KURhdFdot8GhMBCCh6LMrLFY2k6Z4ypqrELmlv+Sz?=
 =?iso-8859-1?Q?TJMAfrZbAtMSU46KNNe+RLRcGHSqYcLzdvIBqw/3KcGklpfgzmuZgQjZy5?=
 =?iso-8859-1?Q?2PYXF5Bb7h0F5Sjn8RnvdpFCDZfXq/DokY/BqpjEzISGIEtNsFzHbIr7SV?=
 =?iso-8859-1?Q?YTk/t20vme3Xq8e14EKZ2p7XL+opt+1NIFPGLOHx17SVHVZV9T6sWIICqo?=
 =?iso-8859-1?Q?1vx95ciUI4dyLRoiQwRnNupFLrQIGetoMSpaTk4k5qBLw/scdZa7+/xMtl?=
 =?iso-8859-1?Q?5LWn5TKAgl9FjxLA3C/4IuDqhd5s3YZsCYDM0T5wBul/3Raqe7R6kAfc9b?=
 =?iso-8859-1?Q?LHGuzc93UzrxoKxqA0UYNl436UuUETzoz2c4NNhTUFwTuINW+dmD/2lOO0?=
 =?iso-8859-1?Q?RO5iwIlOtRcIvVxCBcaVenxKk1wzWUgne5c20+uUW+ddD/bfZQxOx0kEuK?=
 =?iso-8859-1?Q?6lzl3vqI+ca3e9zpXfhW1ppTNxjWIpQE7gX7VTkZaXSCypPCAjecgc/CYG?=
 =?iso-8859-1?Q?3KIdQs430MSsWBRxYi6YHPRW80WxK1qrYfxM9x1k9V8uXE78uSHmWNp6/j?=
 =?iso-8859-1?Q?qPC/Jze7h4ELosyog9MIQmV+Q/Cal9Q6GCR10NolSV6l9BmjzeZjM8i4lK?=
 =?iso-8859-1?Q?sedI6EKOHbTs0L3B+O1RXbccgmSJLhx8ate0JdePjSHiNIFQ01Ow8NCIkd?=
 =?iso-8859-1?Q?EEs0Xy2m3EpkzFj00/LDavnSXUu1euvsEwadskfcvBapJRlNCjWlrqyqzr?=
 =?iso-8859-1?Q?Bzaah3qgFGYfFgEbO3iSlvNDZelvla0Z5MGgJ4GJyROi6qYGhp7idi3ngs?=
 =?iso-8859-1?Q?oTHVm8go9NmAQtN9akyEN5uOFFJXgdlWPpz2xURVux3SDqh/WCdP0mmHZO?=
 =?iso-8859-1?Q?+Mq1BgSll4IDHer/pxq/n8wm6c1xd+E0yIqjyn1mCI850zJaz5DufgvHaO?=
 =?iso-8859-1?Q?s4Rw=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756CA1C36F3F18B2D66A11EF5660@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(102836004)(99286004)(26005)(386003)(2501003)(52116002)(256004)(76176011)(2906002)(6506007)(110136005)(186003)(486006)(316002)(7416002)(446003)(11346002)(14444005)(476003)(2616005)(105586002)(106356001)(8676002)(7736002)(8936002)(50226002)(81166006)(478600001)(81156014)(305945005)(14454004)(25786009)(36756003)(6116002)(66066001)(97736004)(3846002)(6512007)(71190400001)(71200400001)(53936002)(6486002)(2201001)(6436002)(86362001)(68736007)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c/BC39cCl1u2ohLSTbDiI5y1/7aI/aKCHyPR9p3zzfXIECHWnig0HBoKxhvUiYMQDuNlLGV00nONxZoqHn/a5LlmT2uGPsQ8HjlZnwoV21cT1Z0jdPcJNox61FgDoTefF11H3aPA9FWyc+98dyPWcvl1Kv0GALhB1gg65N/BU9XEmHcN1Z4uqQRbPkmB/q+bfr/VdXf7A6YYp43nWM0GZqEZD/OK4Bv5zgqazaDUSXxPrcTdAmm5C9tSYpgal2v+LW2aRTPci9751xLBpmxB905NQFB3vFACXprZ806o17mbP+42ijzbnty8aIUcQ2QddhSra3/lpXEB2s39eOhE9iI17JuYxS82Dg8y0KTFxLQaIwxYksG8p2lw+pot1sMF0qihoIJgtgotgIsqPeXwedFDzqgxvGHIqIXEp59br2Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0917d4d0-0ef3-4ca1-8f8b-08d691cc3de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 15:59:26.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On NXP's i.MX SoCs with system controller inside, CPU frequency
scaling can ONLY be done by system controller firmware, and it
can ONLY be requested from secure mode, so Linux kernel has to
call ARM SMC to trap to ARM-Trusted-Firmware to request system
controller firmware to do CPU frequency scaling.

This patch adds i.MX system controller CPU frequency scaling support,
it reuses cpufreq-dt driver and implement the CPU frequency scaling
inside SCU clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- remove ifdef CONFIG_CPUFREQ_DT as it is NOT that critical and has mistak=
e in V2;
	- put the CPU clock check and SMC call in a separate function.
--
 drivers/clk/imx/clk-scu.c | 53 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..885bf33 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,14 +4,30 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
=20
+#include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
=20
 #include "clk-scu.h"
=20
+#define IMX_SIP_CPUFREQ			0xC2000001
+#define IMX_SIP_SET_CPUFREQ		0x00
+
 static struct imx_sc_ipc *ccm_ipc_handle;
=20
+struct imx_sc_cpufreq {
+	const char *clk_name;
+	u32 cluster_id;
+};
+
+static const struct imx_sc_cpufreq imx_sc_cpufreq_data[] =3D {
+	{
+		.clk_name =3D "a35_clk",
+		.cluster_id =3D 0,
+	},
+};
+
 /*
  * struct clk_scu - Description of one SCU clock
  * @hw: the common clk_hw
@@ -145,6 +161,39 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsi=
gned long rate,
 	return rate;
 }
=20
+static bool clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate=
)
+{
+	struct clk_scu *clk =3D to_clk_scu(hw);
+	struct arm_smccc_res res;
+	unsigned int cluster_id;
+	int i;
+
+	/* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
+	if (clk->clk_type =3D=3D IMX_SC_PM_CLK_CPU) {
+		for (i =3D 0; i < ARRAY_SIZE(imx_sc_cpufreq_data); i++) {
+			if (!strcmp(clk_hw_get_name(hw),
+				imx_sc_cpufreq_data[i].clk_name)) {
+				cluster_id =3D imx_sc_cpufreq_data[i].cluster_id;
+				break;
+			}
+		}
+
+		/*
+		 * As some other clock types have same value as
+		 * IMX_SC_PM_CLK_CPU, so we need to double check
+		 * the clock being scaled is indeed CPU clock which
+		 * matches the table we define.
+		 */
+		if (i < ARRAY_SIZE(imx_sc_cpufreq_data)) {
+			arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+				cluster_id, rate, 0, 0, 0, 0, &res);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * clk_scu_set_rate - Set rate for a SCU clock
  * @hw: clock to change rate for
@@ -161,6 +210,10 @@ static int clk_scu_set_rate(struct clk_hw *hw, unsigne=
d long rate,
 	struct imx_sc_msg_req_set_clock_rate msg;
 	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
=20
+	/* check if it is CPU frequency scaling */
+	if (clk_scu_atf_set_cpu_rate(hw, rate))
+		return 0;
+
 	hdr->ver =3D IMX_SC_RPC_VERSION;
 	hdr->svc =3D IMX_SC_RPC_SVC_PM;
 	hdr->func =3D IMX_SC_PM_FUNC_SET_CLOCK_RATE;
--=20
2.7.4

