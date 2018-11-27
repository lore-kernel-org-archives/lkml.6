Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29FAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B5320817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5yCqO/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B5320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeK0Uio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:38:44 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:29600
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728729AbeK0Uio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJFnrGuMgQrasPgUnYsjm8AlASo9r5quTwKwoRUR4Ek=;
 b=i5yCqO/QAzDOiI1bZo7AhOrB/Pd1mA8BVpH1s6OeK/iTeAvg/yXGl7RvxsWCd1zxYjNsegVIPjjziQQLclIfcSYbSDp2wbMbTQf45gSCGYFmWFQadWSshJ1FiYSLESoBBISmyqYAoQ/XtXOal2WbJmVxzyaNMv3DAsBUC3HpECk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 27 Nov 2018 09:41:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 09:41:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH 1/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUhjVa79+5JmyLgUmAXecrBmu+/w==
Date:   Tue, 27 Nov 2018 09:41:20 +0000
Message-ID: <1543311334-8807-2-git-send-email-Anson.Huang@nxp.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3738;6:qnWSs5bOfuBQzbBz87NlrpWjvCGi5hb57kEU1rF7UsxTRkYHB19TVRJ0NckiQOBbnCqDt7aMAHYKvQ+d/UM5gpcxlwfJsqEecXtCUDtdf2DNs6aZHns4zHlGcEcrri7gY2ocIqkDhYV57lKyNw5aF2eSsojPsGkOWofUsK1b8t6kb+W2XN+jMWnmz7Uh/PR2wvhLyDJBVl+r9+HSFKXuOuKNaPJCEKf4ClwwKywL8d4YQkAvB4oeRmK5a9WIQ+eV0kU0VnD1ibHjMHd5zrhzZbIOM2s5SRjjAD5POSLy1OcJtFE0z+dxZySBsSx7YU+5lMEoRBbKWP3gnGmYzJIijztqBNG6v4DUCh1cAi6VXEvohkiJ1jFxdrI95s+Vju+z8yz9PalARFC0GGiZ3aIcl3KX/AFqT1l0lcNrLyr4ik622zWUPl4DA4bvdd41qTgOuz41n8DTk7AzTqXRdbbdow==;5:/YnLyEgsthNB7kv/hfJogvHZCJa2ooSRbv5YO6uMcECceKHT/1TnfSqzEaL4ImPeruFebTwj6xOATGmtX45z3x25ZZeU2MafZditFxmoQLIlouEwm63QJOHm2PTUikm6tx7Jifp1JIZlTLPgJ86Daz4LvbJN2GULWW3uvu3Yw/c=;7:JjK+e9Yw02QpM1wUVYw0qtbHk4gXGnrKiecpZFN0BvIn7nbmaFCkhixaTHqh7PWsj2/Y2x+K+Pm1ihFM4UWR2fEQeamhSH0GMCLeXwt8Hap+9XL0CIp0gecjzFQxloitK66GPjfhXXmmC9m6V8f3Gg==
x-ms-office365-filtering-correlation-id: 6c6c71a3-0f4e-483a-fcef-08d6544c7b2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3738894E25BC15733E567231F5D00@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3738;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3738;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(186003)(102836004)(5660300001)(81156014)(81166006)(66066001)(50226002)(26005)(8936002)(52116002)(2501003)(36756003)(71190400001)(71200400001)(68736007)(14454004)(486006)(53936002)(6512007)(476003)(2616005)(76176011)(446003)(386003)(11346002)(6506007)(6436002)(105586002)(2906002)(2201001)(86362001)(97736004)(99286004)(7416002)(106356001)(6486002)(478600001)(316002)(305945005)(110136005)(7736002)(256004)(25786009)(3846002)(4326008)(6116002)(921003)(2004002)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gxY8Ah+qBdJU8IH98V/uW39Mo5oqaRdCrcXHnHr4k5FQ0D63PQdBCjuMDVfHLod5yvsSwc1EGEjUmXute1isEoI0Jg7ShMQHwmgNLVa6Mq2NihT6nTCOVAoAtTllSUylGEGrb5VZlxB+e8PlRyJH4edhFhwTuMK+ZBEjnPebmTwHPUz976p+QxD0UQp7mgT3GMYWlpG3uRnUlvNDuPeBkKT3RY4a3jK0yX/S9WMihORuIVN6kulYQ3Zuc5Q6ubre2IgWtX7k3Cc/gLIQJBvG3URI+UChFDOR6uap5JVnhYRuGatj+rRF9itYvZ+qOM5U8wI+A7pZgdKYU1dP7+MK9DK4/yOwAvYwhAsz2aYcWGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c71a3-0f4e-483a-fcef-08d6544c7b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 09:41:21.0792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and secure rtc etc..

This patch adds i.MX system controller RTC driver support,
Linux kernel has to communicate with system controller via MU
(message unit) IPC to set/get RTC time and other alarm functions,
since the RTC set time needs to be done in secure EL3 mode (required
by system controller firmware) and alarm functions needs to be done
with general MU IRQ handle, these depend on other components which
are NOT ready, so this patch ONLY enables the RTC time read.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/Kconfig      |   6 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-imx-sc.c | 104 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/rtc/rtc-imx-sc.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a819ef0..3b9642e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1677,6 +1677,12 @@ config RTC_DRV_SNVS
 	   This driver can also be built as a module, if so, the module
 	   will be called "rtc-snvs".
=20
+config RTC_DRV_IMX_SC
+	tristate "NXP i.MX System Controller RTC support"
+	help
+	   If you say yes here you get support for the NXP i.MX System
+	   Controller RTC module.
+
 config RTC_DRV_SIRFSOC
 	tristate "SiRFSOC RTC"
 	depends on ARCH_SIRF
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 290c173..965725f 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_RTC_DRV_SC27XX)	+=3D rtc-sc27xx.o
 obj-$(CONFIG_RTC_DRV_SH)	+=3D rtc-sh.o
 obj-$(CONFIG_RTC_DRV_SIRFSOC)	+=3D rtc-sirfsoc.o
 obj-$(CONFIG_RTC_DRV_SNVS)	+=3D rtc-snvs.o
+obj-$(CONFIG_RTC_DRV_IMX_SC)	+=3D rtc-imx-sc.o
 obj-$(CONFIG_RTC_DRV_SPEAR)	+=3D rtc-spear.o
 obj-$(CONFIG_RTC_DRV_STARFIRE)	+=3D rtc-starfire.o
 obj-$(CONFIG_RTC_DRV_STK17TA8)	+=3D rtc-stk17ta8.o
diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
new file mode 100644
index 0000000..2466b55
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
+
+struct imx_sc_ipc *rtc_ipc_handle;
+struct rtc_device *rtc;
+
+struct imx_sc_msg_req_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+} __packed;
+
+struct imx_sc_msg_resp_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+	u32 time;
+} __packed;
+
+static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imx_sc_msg_resp_timer_get_rtc_time *resp;
+	struct imx_sc_msg_req_timer_get_rtc_time msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
+	hdr->func =3D IMX_SC_TIMER_FUNC_GET_RTC_SEC1970;
+	hdr->size =3D 1;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		pr_err("read rtc time failed, ret %d\n", ret);
+		return ret;
+	}
+
+	resp =3D (struct imx_sc_msg_resp_timer_get_rtc_time *)&msg;
+	rtc_time_to_tm(resp->time, tm);
+
+	return 0;
+}
+
+static const struct rtc_class_ops imx_sc_rtc_ops =3D {
+	.read_time =3D imx_sc_rtc_read_time,
+};
+
+static int imx_sc_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret =3D imx_scu_get_handle(&rtc_ipc_handle);
+	if (ret) {
+		if (ret =3D=3D -EPROBE_DEFER)
+			return ret;
+
+		dev_err(&pdev->dev, "failed to get ipc handle: %d!\n", ret);
+		return ret;
+	}
+
+	rtc =3D devm_rtc_device_register(&pdev->dev, pdev->name,
+					&imx_sc_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret =3D PTR_ERR(rtc);
+		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_dt_ids[] =3D {
+	{ .compatible =3D "nxp,imx8qxp-sc-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_sc_dt_ids);
+
+static struct platform_driver imx_sc_rtc_driver =3D {
+	.driver =3D {
+		.name	=3D "imx-sc-rtc",
+		.of_match_table =3D imx_sc_dt_ids,
+	},
+	.probe		=3D imx_sc_rtc_probe,
+};
+module_platform_driver(imx_sc_rtc_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX System Controller RTC Driver");
+MODULE_LICENSE("GPL");
--=20
2.7.4

