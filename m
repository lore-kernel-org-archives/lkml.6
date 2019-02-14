Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CB5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385BB21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rJwFqxdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392658AbfBNByu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:54:50 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:35065
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbfBNByt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHkYAJ4t/SYAqFMpMYi9fxYycrMV51Pn/LP5JnRobNs=;
 b=rJwFqxdB81iPZ2hhBT0EwrgGJX8k8yY3BfqdqHRyjRRoPAM5KMG3MW+ISDwAgUov98v6pJo+8hBjpU8s6wGdBylesmakNwiBmq0BM59nTyVAv8+0EUXvJdAb1B8BkbNbOwg/PLD8jgct4I84wANt7wj+KDjKVnsQCn4xAxYgF2w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 01:54:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 01:54:08 +0000
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
Subject: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUxAgs8uuWj5mH40eZScOWTh4APw==
Date:   Thu, 14 Feb 2019 01:54:08 +0000
Message-ID: <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e606a76c-6eae-401f-ef0c-08d6921f4ed8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3850;23:4FNKRApOwAKW4q5nr94Tazm5SuV6kTd72NaoT?=
 =?iso-8859-1?Q?ZagQA8NxhS3LImGV31bY+9+/sf7eM97qfwNku/dA3pPt7NPnSCQR/pRAF5?=
 =?iso-8859-1?Q?bnLgDCRCN0sLq4iNfAppzk/DKBNNdQyFLNcK37WMZvVuvKlo9HnEu5wOUc?=
 =?iso-8859-1?Q?BTP0vD6arN4PUE8YiN5wBuIT+2Er0PDOmW6wQvcs1qKtyZQUrPQuBQZKnv?=
 =?iso-8859-1?Q?KEAYi1EncCa3I2ZCUq+dgoRH9ZC/n2yQH1dP5O5FRdkNA27lppeZtOSN1N?=
 =?iso-8859-1?Q?zPpR4MYUfQFpOnAl9RJGLmKkdZrVrEemm2V3cpTikhAqW0WtAC8mm+blKl?=
 =?iso-8859-1?Q?tZ/auBfuUA4xbQfN0PS6jGYYz8uAAUfsf36LxOnivpdjJnBYAfqJrQzVcb?=
 =?iso-8859-1?Q?yM8g3DuCG9s62yJSu4Vj3ruyrbsytpyzYvQ9iYghjWP5vUXZzvHnsI/Vgf?=
 =?iso-8859-1?Q?TUqY0Qsfe9Msay3i2TYTGe6plMRZyo28TBPfkqFRdk7oN7der1CwWN93r7?=
 =?iso-8859-1?Q?qWCsoXXbcCU9VztnXW556nEpTJn/ZoZBY86Qt6gfEMMJ0VeABkKrKTOidM?=
 =?iso-8859-1?Q?kP/0ms14Kzcpojv32FKZGtq2FEMdUs2Snlqmd7GJcYKDb/ogcu+vk3FQXl?=
 =?iso-8859-1?Q?0Ii6fJbFd4eEwHE20BHeEVDfOQFWt6qoAOr9a+/4zbprmPtYS9F/1EkYN0?=
 =?iso-8859-1?Q?iCLDskEag8JLpIsWVLrdMkCkos1i+Jg2EqKJ97hecKX/Qes6th6/m16O7W?=
 =?iso-8859-1?Q?voLlu8ZetLgrOXzY4JMNU4o8EyRqkNMj2LCaXTNm0sa3/ooFNj6WEluZFZ?=
 =?iso-8859-1?Q?YppitEWgXjurJ5+BbKTBMx1mWuUIJ8MzSo9F1lMSEaI+mOIC62tzMpFkND?=
 =?iso-8859-1?Q?g/+FdDDSUYUzjCQcg6tw59pX2V0CQFGTa7vTEhHKETklBthKAnq5OcHP3i?=
 =?iso-8859-1?Q?9xNSuWFHCfKI9N5rBB76P+kHI+N7hvQbVGzrS/+UCVzY6K5bxh3W9c4SUI?=
 =?iso-8859-1?Q?025m5mPhSa388KiDyVC2I0bi8nKa7FXgVbJ3SyeN11uhmnh6UeVRrVZrm0?=
 =?iso-8859-1?Q?s2U7QOm5D1n8DB3UHSPDNCdcVnjm+2CeHZePokop8i5JmJSddQ+e9ZvFVp?=
 =?iso-8859-1?Q?uEJoiTx6emDwbl4/ecjvdThYjE7ShiX/ditpvIBlBBglNLiMhSIgIEmFl2?=
 =?iso-8859-1?Q?euKNbLv6wPTjB3dOOKmA6UM9snbnI/LovFt9oGHItvg+gBuDmjSVOToKf3?=
 =?iso-8859-1?Q?Iun3OcqMcpiFOLPs3dDWmd+FMfHbukN9l1uLj2S2gNfffzI7dVu8m/82x4?=
 =?iso-8859-1?Q?AVsI=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3850364F0D04B0BAA84015DDF5670@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(256004)(71190400001)(76176011)(52116002)(6506007)(7416002)(99286004)(6436002)(2501003)(14444005)(6486002)(6512007)(4326008)(26005)(71200400001)(14454004)(386003)(102836004)(478600001)(305945005)(2906002)(2201001)(36756003)(105586002)(3846002)(486006)(81166006)(11346002)(476003)(97736004)(66066001)(106356001)(7736002)(86362001)(186003)(8676002)(50226002)(53936002)(110136005)(8936002)(316002)(81156014)(2616005)(68736007)(446003)(25786009)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w0AT72hred62x86/+U4KGgkNJwQD530hOMlYCiZkbz57GhR6G6FfUjWjanvwyV8yY1zosNka5YhGOan3XjpGilBxoi6Bbq70s9VD2LOyGjGijKT8961TDpjCRbe1RcRWf/n8YGc1zFrwekI0lM1UoxoBVRwPzvFs9LN5aWFg6wRfOF6xKImWtJYWGIfIUxFNgjzCRxXlFpmWoFQd00lW0trpbnGaYWLhoNvb1uq9MCe5gK7V0tNL/cmNcENmEah+vYQV2Jd4GzUPvLPG/HzVIH1nEQ6iy4f5IoMF44rjVd45BEa5TP3idEe3zvaMCUmDlfnrru1BwaUjqeuF2M4/8i/zX8WkMitWLoL6rZxqANekCMF6R2BSZsn6BRX5YLiFCkIn0LlN57rsXF1JQbHn4uHv0QQKVg3wmy+Tyw7XtJg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e606a76c-6eae-401f-ef0c-08d6921f4ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 01:54:01.7308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
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
Changes since V3:
        - use different clk ops for CPU clock to avoid runtime check in clk=
_set_rate;
        - use rsrc_id to determine whether it is CPU frequency change and a=
lso to get
          cluster ID for SMC call.
---
 drivers/clk/imx/clk-scu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 7ccf7ed..c234a6e 100644
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
@@ -145,6 +150,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, unsi=
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
@@ -232,6 +254,14 @@ static const struct clk_ops clk_scu_ops =3D {
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
 struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_id, u8 clk_type)
 {
 	struct clk_init_data init;
@@ -247,7 +277,10 @@ struct clk_hw *imx_clk_scu(const char *name, u32 rsrc_=
id, u8 clk_type)
 	clk->clk_type =3D clk_type;
=20
 	init.name =3D name;
-	init.ops =3D &clk_scu_ops;
+	if (rsrc_id =3D=3D IMX_SC_R_A35)
+		init.ops =3D &clk_scu_cpu_ops;
+	else
+		init.ops =3D &clk_scu_ops;
 	init.num_parents =3D 0;
 	/*
 	 * Note on MX8, the clocks are tightly coupled with power domain
--=20
2.7.4

