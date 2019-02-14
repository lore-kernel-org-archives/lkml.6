Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2622DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32D421B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFUuD3w7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405532AbfBNDo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:44:56 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:27424
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405203AbfBNDoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW7KHpBK+2jmFigeY0ZQHsY+bVIdcppRJut0BRKyrcs=;
 b=lFUuD3w7jlS8f6o3KRjp7Bn+b/cd23PHcpPH8reqyA+1QkcO8JVM7kzXn2/hnf4cRGjQXIsbQBV5Lgl7Is3iwd+sMi/n2Y5047iEw4WBRLEwoCjawep1BuoOohN99jTrL8SjwhG+Uh5kf09kDDD1bG/XGHCg9bR+2KH01cnQjRs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 03:44:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:44:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V2 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHUxBei1IUMOqlWBECYcHiTQj2z0g==
Date:   Thu, 14 Feb 2019 03:44:48 +0000
Message-ID: <1550115535-14488-5-git-send-email-Anson.Huang@nxp.com>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9797883f-f625-4fd5-0cdf-08d6922ec479
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3675;23:eZXMCdlmgHwNsPEmpG3Px+WZocJyAUOxAzibZ?=
 =?iso-8859-1?Q?+28BQuykkO+65JlT5/HVYKRXvXnOv7AWzOwAAkQMf6cX/0hd0ODwFbGG75?=
 =?iso-8859-1?Q?UJIX7mqcA74+Dy9kaMJR7YD1pFdjtWNL54AaR4wCX/iKw/vELJSOkfIriy?=
 =?iso-8859-1?Q?cFjTHkfVgNkczX7zHF5xNa/hgIGvQq6B0UKRJr3qwYEOXAMMDcCQF9Ive6?=
 =?iso-8859-1?Q?Ev4QnQI9Y/kFWxMAY8ZOrNfzhP2TEGIOHMSn8cccnDSJNzQ9Yuly3e7LFf?=
 =?iso-8859-1?Q?Qro552Q1Q4QrjvOGeXeUYRTfd/xBRNq5Lw3qMceq3X7OfaheUJVMWIobBD?=
 =?iso-8859-1?Q?NFcAr/r8IAq3DBjnEARpWqVeFz6c5AB5vbWtFnMrujL/tDFp9Nl/lK7GxR?=
 =?iso-8859-1?Q?ryaDsfIWm6r5giQ6hBo1L3meCfi323BAwzhGMKnxE8/NtAmJUkGrAzE1uQ?=
 =?iso-8859-1?Q?gPwIeBPkMdHXtwxZWzIFBypzxcdPrtZlx+LqQpEYk8lIjqS7FOG0kYNX1/?=
 =?iso-8859-1?Q?a4ddGR9L0TqHk5DZGWgcbISQoEfvs5/YsXqrB05hdVHi/cQrNV+CknxRvE?=
 =?iso-8859-1?Q?uk6lJQSrw8j3HeKtpBcguapfa3Z0NXeBkh6DW32iaI6Lzzrh+rX9zc8DK2?=
 =?iso-8859-1?Q?IZGYADexkb2ziRxvjs7w0D+aUMuiPZOdOtOKwanlTOI67Yp6ucODtmDfkT?=
 =?iso-8859-1?Q?viC3csEK+3Sswu8YaWwnHi70Bi5ERyk/rWBERbsq+SuCwqhQ5HLuFd2nqC?=
 =?iso-8859-1?Q?NFp1MmoL9PksWMSJIIRhXqNcTzwxjc8oc6l9pYGbuEpHEpO6syDTNb4i2D?=
 =?iso-8859-1?Q?MgiC328U7x3K1Ew3zODBv4iV1WwYiiSUwSI5vunPfvGAOqIXOvQakoYyIN?=
 =?iso-8859-1?Q?kXYWwgdevVnXTwNhdLxx21iPH1kM//SKCDIOcShX2KiYarSZoeak2sSUYm?=
 =?iso-8859-1?Q?m3W6Mo6EznUVR4zCaf1ISLmEqmpi6F2MnLpLyBdpCOLirqe99e/sEu0SOs?=
 =?iso-8859-1?Q?vVsf9CkmGasvRXRvoX2RBX7xiKwGsesBmMlJJo9Njc1r1INxjGWF05kFAg?=
 =?iso-8859-1?Q?v2QfP9Qbn6xPwIFr22+zEsfWiwvXZqbdac2bx9kbuLu9GS4LGjJS/Ib0qF?=
 =?iso-8859-1?Q?BB+4UbcMxPIm/1/JoPrz4uffO15PobnQgA+QCUsmY10QDxY/oS+7VhlMdh?=
 =?iso-8859-1?Q?tDhD4NZ+sAJAWnFUPAVZGeCkbDMuAVS/vDSqib5980c+4P66gQSJhmXBYW?=
 =?iso-8859-1?Q?NcECcdoqVPDBo9iczjE6/eMR45jCe/3QV+L7+bTPOmR79hrV0HuX5qOmln?=
 =?iso-8859-1?Q?Brxk=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3675D385528E087EBE222558F5670@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(76176011)(486006)(97736004)(4326008)(53936002)(256004)(305945005)(3846002)(6512007)(14444005)(36756003)(50226002)(2906002)(476003)(106356001)(446003)(2201001)(8936002)(6116002)(14454004)(11346002)(68736007)(52116002)(71190400001)(71200400001)(478600001)(2616005)(81166006)(7736002)(86362001)(81156014)(8676002)(386003)(7416002)(105586002)(186003)(26005)(6506007)(25786009)(6436002)(102836004)(110136005)(316002)(99286004)(2501003)(66066001)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sNsRTcLHAgi7WBdL+MAVZdPv6uA0Cg1c6bg8aZEEkWufGRp7SuxRy3/1fbpC0izGw7GCGaL8knS9SD3Eh4cCkwXH9ZSA4d4zSB1CmV8y89mxkzGt0BDjlthiXEAJz1WYLXJ8Fb6M5q+Bu8cCpmK84k6NzbcHsiux/TmbD78scIGtqZbcZ6o5AFZYR/FxuPQM+NPV80myRqFUqXiRzd7YsYMpWUBZVYo3xTPo6aqVDu+tIhNVPIJoa2aq4dRraZXRJ7cuWh0/znLxTEJn/MxaOF/sMSPrlleEvtomBqPveYxZbPro7GB9SleIa3iMig5lpCythbI0ZeB1zLl+T9hVs0cgYbyNOjKvIci+WPafiZyG6+LABTjZtD9hdALsyGJuR/Ks54aZptqToItT46OBjyTeWu3ZmQ8u/8qeht4XPTE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9797883f-f625-4fd5-0cdf-08d6922ec479
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:44:43.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX system controller RTC alarm support, the RTC alarm
is implemented via SIP(silicon provider) runtime service call
and ARM-Trusted-Firmware will communicate with system controller
via MU(message unit) IPC to set RTC alarm. When RTC alarm fires,
system controller will generate a common MU irq event and notify
system controller RTC driver to handle the irq event.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No V1 patch, just add it into the i.MX SC general irq support patch series,
to support system controller RTC's alarm function and also to provide an
example of how to use general MU irq, this patch depends on the i.MX SC
general irq support patch set, so add it into same patch series.
--
 drivers/rtc/rtc-imx-sc.c | 100 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
index 60570a2..147545e 100644
--- a/drivers/rtc/rtc-imx-sc.c
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -3,6 +3,7 @@
  * Copyright 2018 NXP.
  */
=20
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/module.h>
@@ -11,11 +12,17 @@
 #include <linux/rtc.h>
=20
 #define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_ALARM		8
 #define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
=20
+#define IMX_SC_IRQ_FUNC_ENABLE			1
+
 #define IMX_SIP_SRTC			0xC2000002
 #define IMX_SIP_SRTC_SET_TIME		0x0
=20
+#define SC_IRQ_GROUP_RTC    2
+#define SC_IRQ_RTC          1
+
 static struct imx_sc_ipc *rtc_ipc_handle;
 static struct rtc_device *imx_sc_rtc;
=20
@@ -24,6 +31,24 @@ struct imx_sc_msg_timer_get_rtc_time {
 	u32 time;
 } __packed;
=20
+struct imx_sc_msg_timer_enable_irq {
+	struct imx_sc_rpc_msg hdr;
+	u32 mask;
+	u16 resource;
+	u8 group;
+	u8 enable;
+} __packed;
+
+struct imx_sc_msg_timer_rtc_set_alarm {
+	struct imx_sc_rpc_msg hdr;
+	u16 year;
+	u8 mon;
+	u8 day;
+	u8 hour;
+	u8 min;
+	u8 sec;
+} __packed;
+
 static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct imx_sc_msg_timer_get_rtc_time msg;
@@ -60,9 +85,80 @@ static int imx_sc_rtc_set_time(struct device *dev, struc=
t rtc_time *tm)
 	return res.a0;
 }
=20
+static int imx_sc_rtc_alarm_irq_enable(struct device *dev, unsigned int en=
able)
+{
+	struct imx_sc_msg_timer_enable_irq msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_IRQ;
+	hdr->func =3D IMX_SC_IRQ_FUNC_ENABLE;
+	hdr->size =3D 3;
+
+	msg.resource =3D IMX_SC_R_MU_1A;
+	msg.group =3D SC_IRQ_GROUP_RTC;
+	msg.mask =3D SC_IRQ_RTC;
+	msg.enable =3D enable;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "enable rtc irq failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx_sc_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alr=
m)
+{
+	struct imx_sc_msg_timer_rtc_set_alarm msg;
+	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
+	int ret;
+	struct rtc_time *alrm_tm =3D &alrm->time;
+
+	hdr->ver =3D IMX_SC_RPC_VERSION;
+	hdr->svc =3D IMX_SC_RPC_SVC_TIMER;
+	hdr->func =3D IMX_SC_TIMER_FUNC_SET_RTC_ALARM;
+	hdr->size =3D 3;
+
+	msg.year =3D alrm_tm->tm_year + 1900;
+	msg.mon =3D alrm_tm->tm_mon + 1;
+	msg.day =3D alrm_tm->tm_mday;
+	msg.hour =3D alrm_tm->tm_hour;
+	msg.min =3D alrm_tm->tm_min;
+	msg.sec =3D alrm_tm->tm_sec;
+
+	ret =3D imx_scu_call_rpc(rtc_ipc_handle, &msg, true);
+	if (ret) {
+		dev_err(dev, "set rtc alarm failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct rtc_class_ops imx_sc_rtc_ops =3D {
 	.read_time =3D imx_sc_rtc_read_time,
 	.set_time =3D imx_sc_rtc_set_time,
+	.set_alarm =3D imx_sc_rtc_set_alarm,
+	.alarm_irq_enable =3D imx_sc_rtc_alarm_irq_enable,
+};
+
+static int imx_sc_rtc_alarm_sc_notify(struct notifier_block *nb,
+					unsigned long event, void *group)
+{
+	/* ignore non-rtc irq */
+	if (!((event & SC_IRQ_RTC) && (*(u8 *)group =3D=3D SC_IRQ_GROUP_RTC)))
+		return 0;
+
+	rtc_update_irq(imx_sc_rtc, 1, RTC_IRQF | RTC_AF);
+
+	return 0;
+}
+
+static struct notifier_block imx_sc_rtc_alarm_sc_notifier =3D {
+	.notifier_call =3D imx_sc_rtc_alarm_sc_notify,
 };
=20
 static int imx_sc_rtc_probe(struct platform_device *pdev)
@@ -73,6 +169,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 	if (ret)
 		return ret;
=20
+	device_init_wakeup(&pdev->dev, true);
+
 	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(imx_sc_rtc))
 		return PTR_ERR(imx_sc_rtc);
@@ -87,6 +185,8 @@ static int imx_sc_rtc_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	imx_scu_register_notifier(&imx_sc_rtc_alarm_sc_notifier);
+
 	return 0;
 }
=20
--=20
2.7.4

