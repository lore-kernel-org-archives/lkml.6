Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4220869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fioLyvnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD4220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390261AbeKQEKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:10:09 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:52974
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390196AbeKQEKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a4lrFLEtHGdgwWG/CmWK7BvwhOuVBM3a/yIp+GjdaY=;
 b=fioLyvnh0fV2yctuDImlVSIIa6F2ZfC7RsqSLroUScL+3oCGDB2PN+R7+W1O17nW3aG8528uKUhUdym0zdOnug0JOTRk3zCUNd3/k3xXBqUE7+pofJN/K5s0qlItZ/ZwHArFr8tAdvLgjbjkSR+9tWZy+3SyFRhtgYqqGuvhnJk=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Fri, 16 Nov 2018 17:55:46 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:55:46 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Topic: [PATCH v2 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Index: AQHUfdWXBGr/kqXQh0ifMBjcfLw7Kg==
Date:   Fri, 16 Nov 2018 17:55:42 +0000
Message-ID: <1542390890-3270-5-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3712;6:shUY1JKyLjQw7WIbtZDZf2+JXcBZudr7251mYsee6+XeXK1Ec9XKDhiPaWSnsiZ/1syT4el2CZPXjO3bEKmubn6Q181n3hyOGrIxKLvybTw499CpsRIyNnhcTq+J36tFsfk3ICJqLb/1lK9+zN9nmFH3zNzMT9gsrdSchoXiK/5J0Yj0Rr5bNQRhY0QTFVMPzrXSJfYKrnro65qztXeFfHutlLc2UPS8oV5m5kjxdX2r1LrmMtwBemErjXHUP8yGVW1VSLHQR+HmDeWyX7d2DySJgOHMsR1S2LAcifwRaahniBl3KwnsDNMgo44vuyfoK3DPYSyOaHFbLQG4kpsu0bj3RP1AL6MTVp5iytwD6dAJVmI5E3OMsLbxtlrJn1VGeA2hjTia9g2n6JK5oqYGwExJh5I/E/k1Ylgozjb3ID6GbuG3X69jjNZjJrQRS6TWNQbM7KWRWeG6AVBkCcrJ/A==;5:IaFr9VRaMiFNXRAb2uLJkCy+jih56TObq6PGNvJmzjjMBNUbbtU4GC+u3+Ttq4hJPRCYMU60nu89FL2N17qyUhj2vUwj4qsYkmKbMln7OECD8leKlyPqf0yKmcydYdX0TCcWsiu8d5rmn257hw9WgxnLy7uk3MX20fKW5ro7HUg=;7:XH7dD3RkvBK0PY8pqEgUHQkfZMQWWmlS/1+xJTD0KukoMB/eE7OY0IuZnEHBd4lC3kNRWroj37lDxiWwLxgsSFghIeXURbj4qYYbEdT72AQvZIqECT4rq6P28cqaes1vFABbE6DVMJazol0hzXiXig==
x-ms-office365-filtering-correlation-id: 54766ee6-6adc-4ada-1b09-08d64becb9c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:
x-microsoft-antispam-prvs: <VI1PR0402MB3712EF3427080D7D5047A0C3E0DD0@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3712;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(50944005)(6486002)(71190400001)(71200400001)(25786009)(14454004)(6436002)(44832011)(6512007)(36756003)(2616005)(105586002)(99286004)(6666004)(2906002)(68736007)(14444005)(106356001)(478600001)(256004)(86362001)(3846002)(54906003)(2501003)(8936002)(316002)(102836004)(26005)(5660300001)(52116002)(6116002)(386003)(97736004)(110136005)(6506007)(76176011)(305945005)(8676002)(6636002)(7736002)(81166006)(4326008)(81156014)(53936002)(2900100001)(476003)(11346002)(486006)(186003)(66066001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vq0GT51IQjGz36AVhvJ5jC8vcUWmkxXV6OtX/0TTebuXqpMReOFLJyQoL1eDUNlAQms8/iSvhVJD3zq7Fbxt3hxHESm0684MiVAr1sQrhg7457acXom9cwYwukeorAV1Tux3bsey96TkCnBoylm4cNdFdu3vIPl0xPLoztTkkuiv+aPldaLpRPL7z0PzfgTSonRBqn3hLlQGO1S01kBrnR0j43RYDi8LMVA5hnXeH2oLFh0VqBK2kVIYlkMcLGE1AzZB+uiD13ucSXuYdsk0Fgy4J2p69KX8DpmAJqsyTFwthza4ST55qyuvbdCKpt7aCtOmVp/TriLmfk0A34ilL634BwhlgyJ5aKX2yZWFkuc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54766ee6-6adc-4ada-1b09-08d64becb9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:55:42.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the rescan attribute as a bus attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the fsl-mc bus, e.g.,
echo 1 > /sys/bus/fsl-mc/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - none

 Documentation/ABI/stable/sysfs-bus-fsl-mc | 10 ++++++++
 drivers/bus/fsl-mc/dprc-driver.c          |  4 +--
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 41 +++++++++++++++++++++++++++=
++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  2 ++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/=
stable/sysfs-bus-fsl-mc
index 9f3a95e..e5c7f7f 100644
--- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -7,3 +7,13 @@ Description:	Writing a non-zero value to this attribute wi=
ll
 		synchronize the objects under dprc.X and the
 		Management Complex firmware.
 Users:		Userspace drivers and management tools
+
+What:		/sys/bus/fsl-mc/rescan
+Date:		November 2018
+KernelVersion:	5.0
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a non-zero value to this attribute will
+		force a rescan of fsl-mc bus in the system and
+		synchronize the objects under fsl-mc bus and the
+		Management Complex firmware.
+Users:		Userspace drivers and management tools
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index b3cde63..0d5f4c0 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -214,8 +214,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *=
mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-			     unsigned int *total_irq_count)
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      unsigned int *total_irq_count)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bu=
s.c
index f0404c6..ea8991d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -154,12 +154,53 @@ static ssize_t modalias_show(struct device *dev, stru=
ct device_attribute *attr,
=20
 ATTRIBUTE_GROUPS(fsl_mc_dev);
=20
+static int scan_fsl_mc_bus(struct device *dev, void *data)
+{
+	struct fsl_mc_device *root_mc_dev;
+	struct fsl_mc_bus *root_mc_bus;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		goto exit;
+
+	root_mc_dev =3D to_fsl_mc_device(dev);
+	root_mc_bus =3D to_fsl_mc_bus(root_mc_dev);
+	mutex_lock(&root_mc_bus->scan_mutex);
+	dprc_scan_objects(root_mc_dev, NULL);
+	mutex_unlock(&root_mc_bus->scan_mutex);
+
+exit:
+	return 0;
+}
+
+static ssize_t rescan_store(struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val)
+		bus_for_each_dev(bus, NULL, NULL, scan_fsl_mc_bus);
+
+	return count;
+}
+static BUS_ATTR_WO(rescan);
+
+static struct attribute *fsl_mc_bus_attrs[] =3D {
+	&bus_attr_rescan.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(fsl_mc_bus);
+
 struct bus_type fsl_mc_bus_type =3D {
 	.name =3D "fsl-mc",
 	.match =3D fsl_mc_bus_match,
 	.uevent =3D fsl_mc_bus_uevent,
 	.dma_configure  =3D fsl_mc_dma_configure,
 	.dev_groups =3D fsl_mc_dev_groups,
+	.bus_groups =3D fsl_mc_bus_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
=20
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-m=
c-private.h
index 16902f9..ab22347 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -545,6 +545,8 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_de=
sc *obj_desc,
=20
 void dprc_driver_exit(void);
=20
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      unsigned int *total_irq_count);
 int __init fsl_mc_allocator_driver_init(void);
=20
 void fsl_mc_allocator_driver_exit(void);
--=20
1.9.1

