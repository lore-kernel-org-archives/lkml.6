Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C81220869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="frPz2qXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C81220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390282AbeKQEKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:10:12 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:27157
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729353AbeKQEKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElDDRLVtkzkRw8dDNARpZTl/xnDlCZH761grbm7KGtc=;
 b=frPz2qXEXwFZLifb5ocQBiMi4CP+zRbAA2JM3Il2+eAnBhH56LNP9VblMpYos0m5EaL9TrNOV//0vOf216rlEMST1itC1GfgvR43k0Q+id6Rv82GfgLQ/fnFPDaPWUP0tuWJanJ0iuYEg1uJFFtzrk8bqfLUTFD7rQLlkiS4LrA=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Fri, 16 Nov 2018 17:55:45 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:55:45 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Topic: [PATCH v2 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Index: AQHUfdWXs7bF8a4cW0yiDoyvofZXTw==
Date:   Fri, 16 Nov 2018 17:55:41 +0000
Message-ID: <1542390890-3270-4-git-send-email-ioana.ciornei@nxp.com>
References: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3712;6:lWb7jF+yuBFPX0pPF+ztcDS5zOk7eXFmteAgHgt+YOvDD2TNPmr56EfB+7ofgR+3S4UqeL+kB3sAIEwAHX66HvNZZNxXVLvYgqZ8RzjsSC4m7bpd/7W+3YlJMIDyIKxIpNFiUZWuS9fIcBCzdnZcyylM+BAfzK3CgNUTop7VxK5EYMkhArZWiisZx+25fWKxCBbz9jAn0hjxJwWYM5spuv/5DJN3xdIlpTgiwL1LLnIs08WW6DVXngeKdJOK4CdE6QamWjk26QCfLdaT4Rbeg/f22mA/s/affTCtCjS+Lfl5ct0jaXlENx/JLMjYuTL9sstDiPHS8vabm29cM2xCIJDfG7JoYRfWqAHNbkaRD+8p2NBV5QuRVkK3njvbhxeotlzjATNf4T+h53Z9tMbdyce6tQACFtNFeP4m7tr9dlsNnECZ//XT4qDvPK2i780sNa4CC056zC7h7rHytgmH4A==;5:+YkJPMQcEVWU94TcU5NEgY2cUyNsv9mdqMepEwy5szG4A/6U7k3tIgWiGBDYaan+VEekjAK2hCfKKnLBr8GASrj0x7Z7hdbKQyDseP3+T5LQmnVZj2NF6KzLjsdr5SKcDojlEa3TIPxhM9ToUvCE5G9nNcodLxHUyrZdcR5zpT8=;7:Bwce0iLLbRJkxxW8+odvv2HjVKZj0PsnKYkSUwt7Wpkzr+5+MxzT6caqbnqZYkR+X5DjkBOvok/qGB2UG4kWnuLcjYxgH20wUeX/EXahWA6ReW5HN+sDYk3ONZa25+tOUxsCT+SFFg6ZSa/EKY+EtA==
x-ms-office365-filtering-correlation-id: 0147b774-8b27-4774-bf6a-08d64becb97a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:
x-microsoft-antispam-prvs: <VI1PR0402MB3712B56F6917D3EB1BE97AD9E0DD0@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3712;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(50944005)(6486002)(71190400001)(71200400001)(25786009)(14454004)(6436002)(44832011)(6512007)(36756003)(2616005)(105586002)(99286004)(6666004)(2906002)(68736007)(14444005)(106356001)(478600001)(256004)(86362001)(3846002)(54906003)(2501003)(8936002)(316002)(102836004)(26005)(5660300001)(52116002)(6116002)(386003)(97736004)(110136005)(6506007)(76176011)(305945005)(8676002)(6636002)(7736002)(81166006)(4326008)(81156014)(53936002)(2900100001)(476003)(11346002)(486006)(186003)(66066001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PeWyQ1qzrA7LANJjRIye6zSU1wfm+fdxJ0O59ADjcLAhf9Q2Y8G/FQGiCp25fEPnfq1arChxfVepOCW4TidPXSQEASNr59EWKc1xY+nkRD1dESg+aaydrF+PDdTlau5sMGFf9kaAlcYUwVkXya1tDbpfGHY3tf9zoyAwOS6rnSdSpok4YFr0XBhk0jc0qUTx31erezJbQGqbLC55GydOcLIqzgRzSHnUBoXo5g4COLp/hQsr3RtIg65dzKAlJdTwYfJy40Z7qLtYqjueGe23Snco4cSrP330CDIA0wiTmc9eH1WgNrgMVlusKU+wPbI6lAgrgW1rRocHcRqAKWJYZg44Xomf7/pyhzEwOoNbs18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0147b774-8b27-4774-bf6a-08d64becb97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:55:41.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the rescan attribute as a device attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the root dprc only, e.g.
echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
   - remove the rescan dev_attr on the remove path

 Documentation/ABI/stable/sysfs-bus-fsl-mc |  9 ++++++++
 MAINTAINERS                               |  1 +
 drivers/bus/fsl-mc/dprc-driver.c          | 36 +++++++++++++++++++++++++++=
++++
 3 files changed, 46 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/=
stable/sysfs-bus-fsl-mc
new file mode 100644
index 0000000..9f3a95e
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -0,0 +1,9 @@
+What:		/sys/bus/fsl-mc/devices/dprc.*/rescan
+Date:		November 2018
+KernelVersion:	5.0
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a non-zero value to this attribute will
+		force a rescan of dprc.X container in the system and
+		synchronize the objects under dprc.X and the
+		Management Complex firmware.
+Users:		Userspace drivers and management tools
diff --git a/MAINTAINERS b/MAINTAINERS
index e841cc4..7b76a80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12283,6 +12283,7 @@ F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
 F:	include/uapi/linux/fsl_mc.h
+F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
=20
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index 3919d9b..b3cde63 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -354,6 +354,33 @@ static int dprc_scan_container(struct fsl_mc_device *m=
c_bus_dev)
 	return 0;
 }
=20
+static ssize_t rescan_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fsl_mc_device *root_mc_dev;
+	struct fsl_mc_bus *root_mc_bus;
+	unsigned long val;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		return -EINVAL;
+
+	root_mc_dev =3D to_fsl_mc_device(dev);
+	root_mc_bus =3D to_fsl_mc_bus(root_mc_dev);
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		mutex_lock(&root_mc_bus->scan_mutex);
+		dprc_scan_objects(root_mc_dev, NULL);
+		mutex_unlock(&root_mc_bus->scan_mutex);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(rescan);
+
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
  *
@@ -692,6 +719,13 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
=20
 	mutex_init(&mc_bus->scan_mutex);
=20
+	error =3D device_create_file(&mc_dev->dev, &dev_attr_rescan);
+	if (error < 0) {
+		dev_err(&mc_dev->dev, "device_create_file() failed: %d\n",
+			error);
+		goto error_cleanup_open;
+	}
+
 	/*
 	 * Discover MC objects in DPRC object:
 	 */
@@ -788,6 +822,8 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 		fsl_mc_uapi_remove_device_file(mc_bus);
 	}
=20
+	device_remove_file(&mc_dev->dev, &dev_attr_rescan);
+
 	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
 	return 0;
 }
--=20
1.9.1

