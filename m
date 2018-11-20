Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F80C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AC420851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KHrWY8Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKUCJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:09:41 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:58502
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbeKUCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWODNVVr/XOSSoXYZw2/ydukie6ieinc0t9aMdl1yO0=;
 b=KHrWY8Bk2F6p9UWXhA18YNSSP7IJIINpTAQl6wfNTyCjSMlS55+abiXtBJTrprc0S8EY/AQYpn9c2O5wqgCTcRW8Wofafk4FFvRxJtn6fdcNQs6v4VL3ZVrKC0zib/xPQqtsHols1XWmuuf5Xvh1mdo+yncT/6guufFcoKgWS7M=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3501.eurprd04.prod.outlook.com (52.134.4.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 15:39:47 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Tue, 20 Nov 2018
 15:39:47 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Topic: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Index: AQHUgOdDiE1aJj2J0EKRVrsOIEf6Qw==
Date:   Tue, 20 Nov 2018 15:39:46 +0000
Message-ID: <1542728371-6972-5-git-send-email-ioana.ciornei@nxp.com>
References: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1542728371-6972-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:800:90::23) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3501;6:0O5ZJUkbuHLoYcuSLJHU+xgXTu1P5ra8tTXC4CrulozJDPugQ8fd51r1JNL6CmvyJcZB4tsvKi0QdvN2z/ugEuH28zVwFK9J87oPrA8KVPszy93aF9WtsQJl87J9zIdOLsyufPSq7qjogoo2vBVWJPk1MU7Uf4UC6NEZ72mbYJCRPdyudKgNDzFBM7yA4w1KDx4xzI2fOo+X+22oHEv/XGdnRDpLzIDQbuk/MKN4fh5XFLDdbjp4V1/YILPe1auovZxFGVo9FufEoieeyXasnxV8Cjp4RHJeI4+/Aoh6xddnQiFGZx2m/SpPxamkCRAp1rdaJpj8UA+USJPMrtc32ueA2QjwKoQ4MGQR0FR4sJCnWKrTi99ccKk/iZmzpYHcxT1hvk+ZNXmmXTOTPsE9QhDJBeNMKKEan2himtvY7czAT2MNSsS9X/iR5Kkla7zUdwmojN1zQE9xyLCeM1jsjQ==;5:KLaxbrOF3lKuKT1WPkf2MlbPu07h8DxIvRtUqcqR5oaT9F6MfHISgBC49cBG3wCNDnejCJ0Upe6OqOrYX9E5gypJ6Y6GN6mxvE63ejs79HkzwEQW/J8PNjZa0M/FZ+CFR6JuJPWwdhdNwAuabjPJbmlloZc/mwzf0pp2S/hjJCk=;7:z6GoJ+RZ1w6wbdGLhFAYGAzjoMqadKmD768sSIQx8AmE0ehMREMmQqYVxJfrCX0Clg1MPcL+xtrrQjEiVEJxxISNQL3z/t99GWJ+lcFDW2zQEm7QLrOkd+3LNY7aEGaXIC4qiVIS9rbHxtLf2763Dg==
x-ms-office365-filtering-correlation-id: c92fe419-b898-4c2e-452b-08d64efe65fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3501;
x-ms-traffictypediagnostic: VI1PR0402MB3501:
x-microsoft-antispam-prvs: <VI1PR0402MB3501540A76C2E0E322052967E0D90@VI1PR0402MB3501.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3501;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3501;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(50944005)(2906002)(97736004)(256004)(102836004)(14444005)(2900100001)(71190400001)(2616005)(11346002)(71200400001)(52116002)(44832011)(6436002)(478600001)(186003)(26005)(68736007)(76176011)(4326008)(99286004)(486006)(2501003)(6636002)(6512007)(316002)(6116002)(7736002)(3846002)(6506007)(54906003)(110136005)(8936002)(476003)(5660300001)(86362001)(6486002)(305945005)(66066001)(53936002)(36756003)(14454004)(446003)(81166006)(8676002)(81156014)(386003)(106356001)(105586002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3501;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aB254XFyRhZxFUxT1o1uWfWQRMoiCxweDw5n2zMFtf9cKU1zi8af49lt42aMeZxYyc8+WRq6RdXspVs9bxG50H/6wvPQ5RxN4QqHuOzZaZRuSEtEtStKpI7zPe75PuEZwGYRtCXlT7kMFX61ZgovEgFDiV/vKfVYdY8i1nCm2C1bFzfPCovo75dG0n8VyJ80cSIT7CXV2mOtbLVXmBDjLSg2wfNUQ1nNPxk9KlD/9l9/HicsE8FTYb7PoEyZb6YbIA8UQCBdCxoFAyFiel0gK8+YOo8Q7SQRIt2HzodC3UyX/ndQQPdDtHRlaOUCLiVxE3GA6or2PH7xycCPO+9krqQneftBVBddmoaosF+G+Ws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92fe419-b898-4c2e-452b-08d64efe65fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 15:39:46.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3501
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
Changes in v3:
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
index 2f94aba..cac2dfc 100644
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
index 07f00f8..ca71275 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -543,6 +543,8 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_de=
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

