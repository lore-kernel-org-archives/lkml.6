Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B42C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450F72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GhZEERj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450F72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJEXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:32 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:23280
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbeJEXqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QttvTdhbL3H01gTfrmSm4sPsxHPWTx6BQpBHN4YbI84=;
 b=GhZEERj26aSUfG3sZTKFjnXSvtfvgLOGiF0H5VUfxFRTaEPhFFuNjqO4H6B6zku77y+Z1EnqB/pL10feH6I1urdHEghjiL3WCOuDnwDURAxS/Qstncsz8OqJQiIuC8rF8FIka97wSucWz3pRZdoFvPSqSnlPQP5hxvvUj4GsnCM=
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com (10.165.45.135) by
 AM4PR0401MB2017.eurprd04.prod.outlook.com (10.166.131.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Fri, 5 Oct 2018 16:46:56 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72%7]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 16:46:56 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Topic: [PATCH 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Index: AQHUXMsGdmRxkj/X0kKtuikuCggnyA==
Date:   Fri, 5 Oct 2018 16:46:56 +0000
Message-ID: <2ff883c0a0c617a11d8df5a18a76c6f5a90fcd10.1538757338.git.ioana.ciornei@nxp.com>
References: <cover.1538757337.git.ioana.ciornei@nxp.com>
In-Reply-To: <cover.1538757337.git.ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0049.eurprd09.prod.outlook.com
 (2603:10a6:802:28::17) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2017;6:nV/lxsEaDCgkM5DXskPlzuLfLPtskp2HfN24rxSxQhy2jtl6MnAFTOc2nsbQZPzmThujpiYYkr4atfFfHcfRxWJ76of8BSdscqeVsvB+XhEU3Buv8THAQzviwCt/rDDPoShz0Wt1J7gFbNX8CQXyywlN1OWMrnGoptUYbjzzzgBAPhAphF7CPg4PdjYsxJuocuTzftAtQ/d299SJAfrVRT9WbCwNWqNVX+am7T5v5/FBjTc3UICFlmS3B2skrAEpkaqaIpIES8JbQwyt79Z4xzkF1K91xbXWyEXYBcsS5ATNg7/BQiH7i6OUdmndU+TiYqSxxpQgo6oXBWCai3xY2Cl9MTNjtMECoM6VanGc7fSeEKLee2rAJZ3qB5/w8ET7NRVmbfPyXBHXiStWHZ6kq4Ene1KCDTw/Fl14iOTz6VV3HPhGuqw6GJ7oYmTBVORUupbnvL4yWhM1z4rG3ONW5w==;5:qwbyvSIu7akWDSbBQVKPtjs8/rgPU6AOq98N773nqr2Af0CeLsjZKvRAMnka+PaXfsVXrAFmbzZXQ1jGiR8SY6jgLew8Y96S0qi4N25EiP9wgMssFbkvJKj5ffrpb8FNxGYJ1UqlxVVdDZaSEmfTi4I3YpcbTLG5qvnV3j3t60g=;7:6dWcEdBzgBW7vVvA4DrPPPbe6Fbld1p0JBf2pMSiWBNerxw1TqUbQV8PlB2IY23+eEAe0vyIxPBuVjlXlSkuOIEHNIXAW0OYYvf6hw1Wb22UDvPimwdku432zdKL5/H9ayks8Gd8qU/iXH0fcHv3B3UvjVeWnz2SSOr+xQt1uX2nqKlpZndFkOo2STyX2672AO43q9Ep9Ij6fw7vRpEB/1vNMVgMA0F+zn/ahvjgCfHQChA5YYtDX0XodyvDFx0x
x-ms-office365-filtering-correlation-id: a3c2e792-93c8-4792-f07d-08d62ae2290f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2017;
x-ms-traffictypediagnostic: AM4PR0401MB2017:
x-microsoft-antispam-prvs: <AM4PR0401MB201760B43A2B27DBF1E544D0E0EB0@AM4PR0401MB2017.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991048);SRVR:AM4PR0401MB2017;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2017;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(50944005)(6436002)(966005)(6512007)(316002)(5250100002)(14454004)(102836004)(305945005)(118296001)(186003)(7736002)(25786009)(6306002)(2900100001)(71200400001)(71190400001)(53936002)(36756003)(4326008)(2501003)(26005)(478600001)(2906002)(86362001)(54906003)(486006)(2616005)(476003)(68736007)(105586002)(106356001)(6116002)(3846002)(6636002)(110136005)(446003)(11346002)(44832011)(8676002)(81156014)(81166006)(99286004)(97736004)(14444005)(5660300001)(6486002)(8936002)(66066001)(256004)(6506007)(386003)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2017;H:AM4PR0401MB2354.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ykPuU5PZ6m5gIvagHC0IetWKflAAHNSYznZ8rh13zPxkPlTN28YDa5a1pBgPhMZKBGWGqHmUXtTAT0aThiU82FNacXOtXSRaOY/lAJn4l9w/3UywRgRYOOV5yll4xgw+OcDzBqo4DG/4VHqO/Pb5c75bLJdYMQ0XXA+6o7KPqq6CxKzhx73RWtUw6QoySt4+/9FuAIqWnVyMlwVpfQRbF2K01VN7l9CfiyVAOm+cLwYKSxT29dSvK5ykOnfQxBoAnY8kWDT9NMchb+eXnwz25PyS/5j6NGyoKTz/XZR/8q2d2GyQfny9A/GRzp71zEvMWeggrdCI3qXNrxPhECWbdGG8s8VQ0jImqncFx/k6Gl4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c2e792-93c8-4792-f07d-08d62ae2290f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 16:46:56.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2017
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
Depends on:
 https://lkml.org/lkml/2018/10/1/747

 Documentation/ABI/stable/sysfs-bus-fsl-mc | 10 ++++++++
 drivers/bus/fsl-mc/dprc-driver.c          |  4 +--
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 41 +++++++++++++++++++++++++++=
++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  2 ++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/=
stable/sysfs-bus-fsl-mc
index f2f14f4..97c541a 100644
--- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -7,3 +7,13 @@ Description:	Writing a non-zero value to this attribute wi=
ll
 		synchronize the objects under dprc.X and the
 		Management Complex firmware.
 Users:		Userspace drivers and management tools
+
+What:		/sys/bus/fsl-mc/rescan
+Date:		October 2018
+KernelVersion:	4.20
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a non-zero value to this attribute will
+		force a rescan of fsl-mc bus in the system and
+		synchronize the objects under fsl-mc bus and the
+		Management Complex firmware.
+Users:		Userspace drivers and management tools
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index dadc2f3..5a5a6f6 100644
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
index 5f862f1..badb9af 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -144,11 +144,52 @@ static ssize_t modalias_show(struct device *dev, stru=
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

