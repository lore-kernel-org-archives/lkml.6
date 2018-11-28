Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FC92081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t3D1D97W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FC92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeK1QVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:21:39 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:8386
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbeK1QVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4tKBPZ4kdgofoWSKjzCHW2vwLbEFW5OoTwnBrIJef8=;
 b=t3D1D97WsAon8R+ocNU+k9wuKL8YaZ8AxCZtlx8Qz8sWp7gvn+TMDrM4rwhC2GwkD9rRoqvo+ykBUCqvTwNXipBKyBXyOaElSTRg00dKOrvcl6ywDtCnmQDxaAVlWaA8VmOof0ZJr1Ud2FOk8P6KkDRdHIxwL/buFbypsxR8iH8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 28 Nov 2018 05:21:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 05:21:12 +0000
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
Subject: [PATCH V2 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V2 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUhtot94sZ7MkAa0mWbsGxFiWezQ==
Date:   Wed, 28 Nov 2018 05:21:11 +0000
Message-ID: <1543382119-2918-3-git-send-email-Anson.Huang@nxp.com>
References: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543382119-2918-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0140.apcprd02.prod.outlook.com
 (2603:1096:202:16::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:agJID2XgmcAVk/ctdzI3GO8oP3tQifsB0cpH/+lkGDAQcPCECgWIWq1hti/gcmMX8m0N1/GMm5UnRs+hP6097OdcCw/OfOUIByiDgTeql5Ky0peLjLVT7reoUNlZVdi0URSvm1hfnIh8L4uvbUk7yhN/bwEHXvdXd0ZC1Nm3dJaIhnXq0pI0gO7O42P7BKq95P8CRH1tCHo3stL/S9Ypeuv3frDZYPynqTCsRP0rRY3qCwY7zVbSDST9CAlRbriag2FjvacT40xsHVGdjCkDFwcPQoaMvlbnVREUlC7e8WkOMqZdJKETvaABFl/cec14WCp2x5UvZrokBWHodfXUuIULfZrcQvppYi1FSNcewAo2wlphUz0b0u2OE+p0CaQwwH3ab0exq+9kz8DpoFTq9G/fZ5WGMnIzTaX0BxQw9Zyv/5grWMNdARQO2DFa8aBJsCF11PgJILd4Oeeqi3chPQ==;5:NRnRW8GyK3UVMH9EzeJlNCxsbdXNCgw8h8aMauP29x1DfNaP3saKd1AHrJ+mrAy1/xyFTfZDoM03HoYerVw3C2y4mNEK9v2G1yZPGPEyCb5A3zBllWp3aRGTIi8G0Nxpmf7Jj7nrAH90YkYEgJOBeN2YfxMxYWv0w8QzWE5YSOA=;7:tIUgFIA8LOCjmxeBRMewclTcdwYJjcGu04xgAOYPYA1ICcsHpAUq+CaS2Yh9CcT62jUvwBqJ74eeu6BebcH/pR+5Y2dVi41rUG3TwZwuOix3edYn3NDwqzfSyJ8ZH2SBAIvv+HeEFlY2X2XB+1yDPQ==
x-ms-office365-filtering-correlation-id: 12d74b68-c098-4171-52ca-08d654f14f8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB36590D5C285AC02B51F623D5F5D10@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(68736007)(106356001)(486006)(105586002)(11346002)(99286004)(6116002)(36756003)(2906002)(316002)(3846002)(66066001)(5660300001)(446003)(6512007)(71190400001)(2616005)(71200400001)(305945005)(256004)(14454004)(8936002)(76176011)(2201001)(7736002)(26005)(6486002)(97736004)(4326008)(186003)(110136005)(6506007)(386003)(25786009)(8676002)(2501003)(53936002)(102836004)(52116002)(81166006)(6436002)(81156014)(476003)(7416002)(50226002)(478600001)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xJfiIziZ+YkT6cCrawx+OkDBLDkH+jZVZgYIaeI9ieBZa/IWjqoOK5vHNwebSah9vN4fi33QsUKMtmb0orFXEEOuh4C+FNSJ3tLWgrRA1JhAmCudpTJkYX/OME/YgFNfeBV/py3+Dmiq1IV/Nfsi35BFL3ShvsEx1qx6roe9x81HmPb95KCxz/o1x90cnZUZVgQTB/BtaWhSXokU/bR7DWOUC5wNm402ikOLbQddXLCJotni8i9xW2pL9eMHnWr9JnvkPvCgzl3kqC854t1rDqyolngYTDd+0EfgspHxVCbxOwTEhNlG/3Ok1JWVlKSZNMvxn5j59j8UHXzO3caH6mbIajUXcpE8AGotaqje8Rw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d74b68-c098-4171-52ca-08d654f14f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 05:21:11.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
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
changes since V1:
	- sort module in Makefile alphabetically;
	- remove boiler plate license text;
	- use devm_rtc_allocate_device and rtc_register_device to register the RTC=
.
 drivers/rtc/Kconfig      |   6 +++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-imx-sc.c | 107 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 114 insertions(+)
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
index 290c173..f97c05e 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_RTC_DRV_GOLDFISH)	+=3D rtc-goldfish.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) +=3D rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+=3D rtc-hym8563.o
 obj-$(CONFIG_RTC_DRV_IMXDI)	+=3D rtc-imxdi.o
+obj-$(CONFIG_RTC_DRV_IMX_SC)	+=3D rtc-imx-sc.o
 obj-$(CONFIG_RTC_DRV_ISL12022)	+=3D rtc-isl12022.o
 obj-$(CONFIG_RTC_DRV_ISL12026)	+=3D rtc-isl12026.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+=3D rtc-isl1208.o
diff --git a/drivers/rtc/rtc-imx-sc.c b/drivers/rtc/rtc-imx-sc.c
new file mode 100644
index 0000000..7212e38
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
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
+	rtc =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc)) {
+		ret =3D PTR_ERR(rtc);
+		return ret;
+	}
+
+	rtc->ops =3D &imx_sc_rtc_ops;
+	rtc->range_min =3D 0;
+	rtc->range_max =3D U32_MAX;
+
+	ret =3D rtc_register_device(rtc);
+	if (ret) {
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

