Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF971C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C622206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lhzHKkYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C622206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeK2My1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:54:27 -0500
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:61808
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbeK2My1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1Zoo9YjiIa4fFKVpdcwPIu6olWviBJm2D9CI6ZI3tk=;
 b=lhzHKkYQCjl3qcsLbopt88yLIQJ2dXQyxUV1S17zKDxiFQ2kQ7QYtuWOOnvYqXIOOpKN0zmTawlGlesIhnFr5yCe4DqaUoLhQFtT37i/FTPhFzFhQyTwMGsJbcysF8BEvRSjjEqQ/R1yB2V5506d7PvfajVzMb/SCAPBG21MPcQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3930.eurprd04.prod.outlook.com (52.134.71.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Thu, 29 Nov 2018 01:50:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 01:50:11 +0000
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
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUh4XdMkdvaBq+50CIziMq0Y1OPw==
Date:   Thu, 29 Nov 2018 01:50:11 +0000
Message-ID: <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3930;6:FQedETAklCcaj6f1q1iIuO3OkJZkIYwiW42J28fSn3kd6l0VhPor6mqCdNCO4pnfCpDCNpqUFijW1H/IhrihcV0Y4nExEz1/7s/EgUvv+xFLkwImcITSKb5+lVXeKqeMAZWefqNJzMb2jTkFTIHVttk+s8zIuA0doQDhUd171SxCRldHj6BV7gwJFfTyqeMBFppv0aasjs5NpSY3EyPML5MLfgDlGW4GDkw9mgexKTPNER7uOG11rAFfybDPV2IlzITF33TY2ntGlNKj4F3ZKUAvj4NQy1mVOPO++XgqgkjyUlSf6BLhHo7KwD+IlXiddk7U5/eJ6HNJAnyVqKCw1yiPhB2P+WgqeSoYf6pBQ/b8CkmWg4g1X3G+CpfVV3nUjW7nBJpj1JdwTXeAqTjp1IHqE2orpNG7LArdY3uKM3q1F40+rCl5LxmW4LK0O49obsSR341pVyAKKzpaqCb4ug==;5:30BPWEuua+qNnHGlVifs9/1mwfgXgHRID6BgGia3/+3b/mJ8nK8FLxYIg+Sdzc8RRXuA/6Ou0alc8AvixphVJr55Ehk/UhhihL2vXUb7pzu5Hl7n/G68dOn17kPHHbGe+eJFtnsHd3WitAViZ2oie1poXaLCdSFG3raxofMB884=;7:mVwVzZ/BBgdNdazOniderkkJDQoLCL9WjQL7+nvQDdlCqz1Fp9rdgnECJ0ZO9hCXyc7K+YgzGuCJCqJg+eH/wEYUdC85Nicj3049HhiNXzfxplUDwnaGSWF227v+pNkg9SBAYMasfohjzn17S+7wYA==
x-ms-office365-filtering-correlation-id: f96029c3-f5d7-4b99-f057-08d6559cffec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3930;
x-ms-traffictypediagnostic: DB3PR0402MB3930:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3930FF5A2ED79D9DCC42E856F5D20@DB3PR0402MB3930.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231453)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3930;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3930;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(366004)(54534003)(189003)(199004)(110136005)(2501003)(316002)(3846002)(6116002)(52116002)(7416002)(71200400001)(14444005)(305945005)(76176011)(478600001)(25786009)(6512007)(53936002)(7736002)(14454004)(99286004)(36756003)(5660300001)(97736004)(4326008)(446003)(86362001)(81156014)(6506007)(81166006)(102836004)(8676002)(2201001)(68736007)(6436002)(6486002)(50226002)(11346002)(386003)(2906002)(105586002)(186003)(106356001)(2616005)(26005)(256004)(8936002)(476003)(66066001)(71190400001)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3930;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SSM7U/BHMpTzTenHwANozvojZntqSo+looqIIpVD64mNU3lyGNnQ8BOeeodrNHaG9nBvCiqwH2remcS2eqD99WrPm0sg52pckFxNFtgwArTXnD8O/WS7B5wxBbNKCMdfSJSu8NvF8mCx+AJTx49aYhRoAQpTGkZ5XS2U7V3578gZ+uqlZGs4bfQsoS8F2MHF57rb6LTu0XI1gvgg97AYxOmyO0QcIS9PHIWh7akMAQc+FMyfO/4rT3cg4sc4LxtkWYo6ctwJuSpFoBDY1PPgBqz/FCYZJVsa2vxUzOXw9QEHwJrEF6GusP6TGonexWT3WG2+L8ud9iOCHG8+blI+OL9+/aCkcLP9vQe5A57HqKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96029c3-f5d7-4b99-f057-08d6559cffec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 01:50:11.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3930
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
ChangeLog:
V3->V4:
  *remove unnecessary headfile included;
  *fix potential memory currpution for the message responce;
  *update the compatible string name to start with "fsl" instead of "nxp".
 drivers/rtc/Kconfig      |  6 +++
 drivers/rtc/Makefile     |  1 +
 drivers/rtc/rtc-imx-sc.c | 98 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 105 insertions(+)
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
index 0000000..5976a2e
--- /dev/null
+++ b/drivers/rtc/rtc-imx-sc.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/firmware/imx/sci.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define IMX_SC_TIMER_FUNC_GET_RTC_SEC1970	9
+#define IMX_SC_TIMER_FUNC_SET_RTC_TIME		6
+
+static struct imx_sc_ipc *rtc_ipc_handle;
+static struct rtc_device *imx_sc_rtc;
+
+struct imx_sc_msg_timer_get_rtc_time {
+	struct imx_sc_rpc_msg hdr;
+	u32 time;
+} __packed;
+
+static int imx_sc_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct imx_sc_msg_timer_get_rtc_time msg;
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
+	rtc_time_to_tm(msg.time, tm);
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
+	imx_sc_rtc =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(imx_sc_rtc)) {
+		ret =3D PTR_ERR(imx_sc_rtc);
+		return ret;
+	}
+
+	imx_sc_rtc->ops =3D &imx_sc_rtc_ops;
+	imx_sc_rtc->range_min =3D 0;
+	imx_sc_rtc->range_max =3D U32_MAX;
+
+	ret =3D rtc_register_device(imx_sc_rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register rtc: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx8qxp-sc-rtc", },
+	{}
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

