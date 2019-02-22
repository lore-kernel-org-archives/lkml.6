Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3220838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1eZtg/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfBVCcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:32:16 -0500
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:40004
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfBVCcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8EvhLBmnV0MQEpRngvya6EgualoSwFzdIN7SSPuy28=;
 b=P1eZtg/Fwf6MB8oaNvs47rTs0py6ltGs8sBMhmt48Ssg94kAuctTkCSMgE6Hgl663Pxi3pxelqvwjbYUKCmbjo7wq3vRoosmPmzm+apWPsFVetBca4x5vXur12bVWs0M9FlGLH8ZoWi/hnsawnmknJkkU97LPL68Pa+gF9gkyNc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 02:32:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 02:32:10 +0000
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Thread-Topic: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling
 support
Thread-Index: AQHUylbQgTJCBi+vS065hKMQGm7POA==
Date:   Fri, 22 Feb 2019 02:32:10 +0000
Message-ID: <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0a1bcc8-6f09-419b-bc85-08d6986df26e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3771;23:zWy1U5c51qcltQoQZ65XXzZcPXeMRPgLsVyET?=
 =?iso-8859-1?Q?cijATPiBz9HXrgrmcu3Q0gTT0nshvLp1w8XpNUTLp/y2cIwwjHtdFuSVZn?=
 =?iso-8859-1?Q?Mem4uVvTZpZJSgOSmPPO2cZIlnkP4+qyJ0Bi5FfwotXinenASW4sO8M2tc?=
 =?iso-8859-1?Q?km9OI8OqkdU9Q9+XqzmU4xbBRlFxJxglzF4j+POzGmPfvLdoczFdZrwFt2?=
 =?iso-8859-1?Q?L5GtJ5ewelQr8SUd4a/tVjtGpslOx0UQMGxEBcYksGgi25A6jJvmXaquT8?=
 =?iso-8859-1?Q?t8PHQb24LwZ/7UL42lT5UqDHzdZMuOJZccObSg4wn34LyBeuUGkmevrnlT?=
 =?iso-8859-1?Q?N0oVaWmapJh0hYhxJ1QviDAode3AkRHulJADh4VVTFmzaTuRPm+PMXZE8G?=
 =?iso-8859-1?Q?uLaFxnBwcrWzCMj5ExJIy+3Gs65CANGqIIi9waxe1DHqCWNM63uaNOmu3C?=
 =?iso-8859-1?Q?B9Uwe/2Ez6oEly6Yha+k6qgLzmKWGlZNgyj2tCrsr6Hnr6eVdt7Js/fSLD?=
 =?iso-8859-1?Q?l5vOcuMhvAzxTCOvs8CYXSxMS+H6fuceQZ0pRfcg98lDJoUPvBULoFQPn6?=
 =?iso-8859-1?Q?ZW8AH6cyk/hLh973QI4JJpHmjP5wjdB/dBpTIQ17Ps2lFnSjzdN0rn8GKz?=
 =?iso-8859-1?Q?dMkp2JkkGJP08x3CyRXHRKFafcGXeaoGSXWkczx9JDYy0uZnv7aY0bKB+W?=
 =?iso-8859-1?Q?44kLpMKICFZ8h7/auka6Vhfv2o8cU7Y0zDV64vNReaSST+vOcFqouSc8es?=
 =?iso-8859-1?Q?3+lllX3QyBlNcPCR9EMiytos4d6PjTCodnZAgTR7ICC+0/3wkEr+dTX6hu?=
 =?iso-8859-1?Q?xHbmixyGLHx8jzTn9Ss7D+QpRzYRxEhIwXyeLaQsDqNVMXX1+VWNaQIjJ1?=
 =?iso-8859-1?Q?rTF0q8y/djaEW8bBKyjVF+f6M4aks7F/dL6hoHPebol+sniId+7S97MDnS?=
 =?iso-8859-1?Q?TlO3xm9Ry9t0EgltPz2vto9PWR8lRZjjfmmCNo1hINXaJnW18DdeBqBcRz?=
 =?iso-8859-1?Q?zlei0Yw6fCOeW0SMRDglhx0clMzXpoNSeTA2UkoyDN8esnDH7tIHXgXceY?=
 =?iso-8859-1?Q?BCy1iLWuoHORcluZAQKFosRzZy2AmEkkoNjKUD+JoMQTEED4CJuhbdyB5H?=
 =?iso-8859-1?Q?gYjQkHUxzoblWUx6ilSPdaTTDuojRAzrLaDYpOIjnqSZ3NlMjnMQfmOvKj?=
 =?iso-8859-1?Q?H4MGPNUvU2nYfPDbujFjPrdqGjEOPWK6wKItk0WpGRhSYAshpm3y+TyWOu?=
 =?iso-8859-1?Q?dzkbklfsqpfWIQsZ0Kmmuxuxcb+tb++iR/EkS7CKU46uZDivg0jgnqK+Dt?=
 =?iso-8859-1?Q?ZbQRWiZNLa/9AYEUUYcsIVaNJ?=
x-microsoft-antispam-prvs: <DB3PR0402MB3771E6B2C7512FD467D35CADF57F0@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(105586002)(7736002)(53936002)(446003)(486006)(7416002)(97736004)(2616005)(66066001)(26005)(476003)(11346002)(305945005)(71190400001)(106356001)(71200400001)(8936002)(81156014)(8676002)(2501003)(81166006)(36756003)(6506007)(386003)(50226002)(186003)(102836004)(2906002)(52116002)(6116002)(14454004)(6512007)(5660300002)(68736007)(2201001)(14444005)(110136005)(6486002)(316002)(86362001)(6436002)(99286004)(76176011)(256004)(3846002)(4326008)(25786009)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xc5RREyRT51AJS6OXWf0Kh4zwPIU9frjs46CXNm1z7gnoGxLNhBhOX1WtHNNo2O3idqlvF+DD6BMCk1fjS+JpwVw9AF751nNHpL2F//1FDnx5ImlOe8gdTY+L4B1gxkY2l9HrEFO6QsjdeX3t+EYSItkBZAAc/25stBtNPYjT98A4VqH0WSGAasQz0DsOrityKM/ExNo3Wm+saFQ87qomOI3NZHSf/EBWjbOYaJpdJBMF9+zfr0Nq0Eq8ue0J+vV+yobuJkSc4eXoFsTjugbrAGntRe8MkZ1wcVpj3TDyHg5oa6iTTfx72ygZjZPk0QGSOO1aYNZpeuCiieN8IaXppCU5ylGAZUBqNRikHiLolYer50E4Hifzb3tMcARsMJM6XIvq+VubCuRA2F/9O7vv7tyJsIZPG9rT8EvVIJMwdc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a1bcc8-6f09-419b-bc85-08d6986df26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 02:32:05.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
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
No changes compared to last version, just redo patch based on clk-next to f=
ix patch conflicts.
---
 drivers/clk/imx/clk-scu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index f460526..34c7cdf4 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -4,12 +4,17 @@
  *   Dong Aisheng <aisheng.dong@nxp.com>
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
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
 /*
@@ -180,6 +185,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsi=
gned long rate,
 	return rate;
 }
=20
+static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_scu *clk =3D to_clk_scu(hw);
+	struct arm_smccc_res res;
+	unsigned long cluster_id;
+
+	if (clk->rsrc_id =3D=3D IMX_SC_R_A35)
+		cluster_id =3D 0;
+
+	/* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware */
+	arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
+		      cluster_id, rate, 0, 0, 0, 0, &res);
+
+	return 0;
+}
+
 /*
  * clk_scu_set_rate - Set rate for a SCU clock
  * @hw: clock to change rate for
@@ -312,6 +334,14 @@ static const struct clk_ops clk_scu_ops =3D {
 	.unprepare =3D clk_scu_unprepare,
 };
=20
+static const struct clk_ops clk_scu_cpu_ops =3D {
+	.recalc_rate =3D clk_scu_recalc_rate,
+	.round_rate =3D clk_scu_round_rate,
+	.set_rate =3D clk_scu_atf_set_cpu_rate,
+	.prepare =3D clk_scu_prepare,
+	.unprepare =3D clk_scu_unprepare,
+};
+
 struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents=
,
 			     int num_parents, u32 rsrc_id, u8 clk_type)
 {
@@ -329,6 +359,10 @@ struct clk_hw *__imx_clk_scu(const char *name, const c=
har * const *parents,
=20
 	init.name =3D name;
 	init.ops =3D &clk_scu_ops;
+	if (rsrc_id =3D=3D IMX_SC_R_A35)
+		init.ops =3D &clk_scu_cpu_ops;
+	else
+		init.ops =3D &clk_scu_ops;
 	init.parent_names =3D parents;
 	init.num_parents =3D num_parents;
=20
--=20
2.7.4

