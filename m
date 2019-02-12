Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A97C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D123E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oqT+jukk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfBLMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:21:51 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:6512
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729269AbfBLMVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/04G/uCRd/Sik5Bx3CeDdhw6if0bhDHL3s8OMuMMBDs=;
 b=oqT+jukkHf4eTTV9DZC9Gt+tzth8bwISgaYEorA+2KMhid+gaEjHMYZen14usyxh4LqvzjJb7H1uC8TR0Irx1Q7ojnoQ/l94EbEVDKvq7enyNfQrgriA3burDU9ZPhTitAde5tnUr9ALZqIVQgdCJTqsf7DLxopg+1wqdk/HYDY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4883.eurprd04.prod.outlook.com (20.176.215.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 12:21:36 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:21:36 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/2] soc: imx8: Add cpufreq registering and speed grading
 check for i.MX8MQ
Thread-Topic: [PATCH 2/2] soc: imx8: Add cpufreq registering and speed grading
 check for i.MX8MQ
Thread-Index: AQHUws1/f5iQVkEve0S0KvAhjlA+tQ==
Date:   Tue, 12 Feb 2019 12:21:36 +0000
Message-ID: <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:206:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4883;6:GM+QM6qWL2Klt1h2IbQEbYEXNCG51dqsu/KG+x1DsShrqDPsKhpQciAMIcjh2LSejVQLpZvlyKT2Ft4iRFvdxk6FDNFMtOL9YxBmRIRwKG5W16g5wboNLCal8JmvgXo95xFzAwQX/nc2g3E4bfydAOQSUatuUEIedj6RxRR4ELgGQpmkj62Ttt7NLPVnw4dywsv1afN30fI3s72zLLLD2kiyxcUatHu9zGO9kVYHQ6fYh+83qRgKgtIypDOzg5Ftva6hF1S/KiKWKIe/TCNU3uBeWreeI0CZZ0AIaLo0VV8bYb7InwsnAUfSD1rK+hEB3Rl7vr2uILlWltyFieMghrRhzze7geM60Bdqu4dU8EEFO7x0PmIVHUwaQ7ce+9o4xGz6NKvX8dGYIqp8NqEjrsdKvyhqj+1ggnSRragnlxQYVx9PheJRLaULAy5MFKAZzFOmIlvru6Q4R04VUhkQSw==;5:LC+KNPyBK8M5eMKAq/38i9LfrwTmPCw/Uy5X1YABJH3QcYoNjuqoJPFBHOuDOuivL0pqJOrzevu/yL+3nRUaD2ltVzm2LvaBpmctPsOQWThyipairLPV8AuyW0WCrvc2/19kF/ZfDg+FJYbtRP8j/qi3sj33JpUcx4+LwpGgh4B/uFFIhPjszL0hbXe2v0W8lSVWMBmoaB//l037IZIubA==;7:5ZDM9hsGUdlAYh1sQYlGAK5feYw5MsTXnFFUy+3HWFJp2ogiknAaHCQ0jbNSDzDmJh1ObpK1JLIpwbkvmniu54WeFcNNhxfcd0NTt6HUHireB4+dOlhg+te/AyhQvrxl97Hzp6qvF+1PdehNWo241w==
x-ms-office365-filtering-correlation-id: be0e3c6a-c60c-410a-43db-08d690e4a203
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4883;
x-ms-traffictypediagnostic: AM0PR04MB4883:
x-microsoft-antispam-prvs: <AM0PR04MB4883842C8B6C340DC1D8E93EF6650@AM0PR04MB4883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(8936002)(6116002)(8676002)(50226002)(68736007)(3846002)(54906003)(81156014)(110136005)(316002)(36756003)(81166006)(99286004)(52116002)(76176011)(478600001)(66066001)(44832011)(486006)(11346002)(446003)(2616005)(476003)(71200400001)(71190400001)(25786009)(97736004)(14454004)(4326008)(6512007)(106356001)(6436002)(6486002)(7736002)(86362001)(305945005)(26005)(186003)(53936002)(386003)(6506007)(102836004)(105586002)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4883;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OqJY0I8Uk0RVl/t/QgkBGDieMzfijPvKJw+G5hFFWj4m7EgvGGEFdnEoMc/lNbIWP7hfdJ9rTicmzQa4+/hi46/6O8VRtVcZ7we9aftdukXPJ1eGecB+GNnPyow/fa/7c/+PqKooxgLXtWZMyvXOF0zcWjZqdUJJyGeXI+E//keO4uYBf3D8Y8saRnODmGvvFEfR+QDz7E75Xiol1HsD/zsmy062wUegRis/4MRn+6ethcA59jeIUMqauopgWh9qbkuR7ueUNIQBl7iBSjgdpfxsPaqN+a1lyIfOiTLf4DoiAnGH8OQNbF+Dh6D9WrVgJ/Eol/43UGJMspE30T6qABOdYjpti5UyG+buV6kGpzyswuftZu+PLsyXyefRRLGsKaO6+g4cWNvS7eWLstqx0LslVczfsz8M7IDcTebZ9T8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0e3c6a-c60c-410a-43db-08d690e4a203
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:21:35.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Register cpu-freq platform driver for i.MX8.
i.MX8MQ has different parts like consumer, industrial and auto etc.,
different parts have different cpufreq set-points, this patch adds
fuse check to select correct cpufreq set-points for each part. The
default dtb has all set-points available, then kernel will check fuse
to disable those unused set-points, definition as below:

OCOTP offset 0x440, bit [7:6]

'00' - Consumer 0C to 95C
'01' - Ext. Consumer -20C to 105C
'10' - Industrial -40C to 105C
'11' - Automotive -40C to 125C

cpu-freq set-points definition as below (datasheet Rev-E):

		Normal		Over-Drive
Consumer	1GHz@0.9V	1.5GHz@1V
Industrial	800MHz@0.9V	1.3GHz@1V

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 107 +++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 108 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 506a6f3..d6b529e0 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
+obj-$(CONFIG_ARCH_MXC) +=3D soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..3896310
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP.
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#define OCOTP_CFG3			0x440
+#define OCOTP_CFG3_MKT_SEGMENT_SHIFT	6
+#define OCOTP_CFG3_CONSUMER		0
+#define OCOTP_CFG3_EXT_CONSUMER		1
+#define OCOTP_CFG3_INDUSTRIAL		2
+#define OCOTP_CFG3_AUTO			3
+
+static void __init imx8mq_opp_check_speed_grading(struct device *cpu_dev)
+{
+	struct device_node *np;
+	void __iomem *base;
+	u32 val;
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
+	if (!np) {
+		pr_warn("failed to find ocotp node\n");
+		return;
+	}
+
+	base =3D of_iomap(np, 0);
+	if (!base) {
+		pr_warn("failed to map ocotp\n");
+		goto put_node;
+	}
+	val =3D readl_relaxed(base + OCOTP_CFG3);
+	val >>=3D OCOTP_CFG3_MKT_SEGMENT_SHIFT;
+	val &=3D 0x3;
+
+	switch (val) {
+	case OCOTP_CFG3_CONSUMER:
+		if (dev_pm_opp_disable(cpu_dev, 800000000))
+			pr_warn("failed to disable 800MHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1300000000))
+			pr_warn("failed to disable 1.3GHz OPP!\n");
+		break;
+	case OCOTP_CFG3_INDUSTRIAL:
+		if (dev_pm_opp_disable(cpu_dev, 1000000000))
+			pr_warn("failed to disable 1GHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1500000000))
+			pr_warn("failed to disable 1.5GHz OPP!\n");
+		break;
+	default:
+		/* consumer part for default */
+		if (dev_pm_opp_disable(cpu_dev, 800000000))
+			pr_warn("failed to disable 800MHz OPP!\n");
+		if (dev_pm_opp_disable(cpu_dev, 1300000000))
+			pr_warn("failed to disable 1.3GHz OPP!\n");
+		break;
+	}
+
+	iounmap(base);
+
+put_node:
+	of_node_put(np);
+}
+
+static void __init imx8mq_opp_init(void)
+{
+	struct device_node *np;
+	struct device *cpu_dev =3D get_cpu_device(0);
+
+	if (!cpu_dev) {
+		pr_warn("failed to get cpu0 device\n");
+		return;
+	}
+	np =3D of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	if (dev_pm_opp_of_add_table(cpu_dev)) {
+		pr_warn("failed to init OPP table\n");
+		goto put_node;
+	}
+
+	imx8mq_opp_check_speed_grading(cpu_dev);
+
+put_node:
+	of_node_put(np);
+}
+
+static int __init imx8_register_cpufreq(void)
+{
+	if (of_machine_is_compatible("fsl,imx8mq")) {
+		imx8mq_opp_init();
+		platform_device_register_simple("imx8mq-cpufreq", -1, NULL, 0);
+	}
+
+	return 0;
+}
+late_initcall(imx8_register_cpufreq);
--=20
2.7.4

