Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F07EC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3802084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1hdu3Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3802084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeJEXqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:31 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:59411
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeJEXqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd7qTx2qe1GI5jcuzyZ59rG8WThdyySy05kzI2UC06M=;
 b=f1hdu3Ez1iGp3mKuujSCRCFEL+2UBFRi3sjsLSuSoCv/Pk8+FHbSV41ovY88wFmnIhhWbud2fj+9R1PHJVhRXn6/2xE3PXMsPojMRjF/sbcHKoST54sLf6Ke7y6goO05wu9GdsK3M7mlAcuD/Xv6fkBYT0qONlXGAG6Xg+BX1/0=
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com (10.165.45.135) by
 AM4PR0401MB1875.eurprd04.prod.outlook.com (10.166.130.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Fri, 5 Oct 2018 16:46:55 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72%7]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 16:46:55 +0000
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
Subject: [PATCH 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Topic: [PATCH 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Index: AQHUXMsGB5Rm/uH7+kuh96bRkW+Sig==
Date:   Fri, 5 Oct 2018 16:46:55 +0000
Message-ID: <dfbbd123c31ea851581154ab7ab82cfb895c3d11.1538757338.git.ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1875;6:BZMXYl/nCK6TXMOHfEwq7zs9MJNVSjuFJJja3ywFslxjyTTSIwJpvY2ScT5Rh+yYwlpdaCL3z4uVD9WLoGvYAputSTpdzIhPRM+Ej8BcoiAIeh3znl7BGDdNgS9kclpakn7FWaUiR/LJetXf90sNvCKGC8xeobW4hGEvq+5L6XgVT+E2rCDGaRqMtRcNSuem8HbbFuwkeIoWNpZL0UB9JhLV7ooiHxvLMgfkhTuz01jceorI/Z7HH/l9KE8gqV47JV0C2syGhG6xAxXM4qfcFa+y9828ojiZWKLDivDdRMO8yxoZg8AcnuJOaOzKznMDn3jROjsi09INHdWORtjB6iIHPRNsZyI25jVWMYzZ5ex0/vgPB1slU6RK+51nHSBLgaKsWBgwPJm6XERIXuKwpetQDBgePANcs4qze05KbY21vCkfX6+sNercgjqiIXGj/fZoOTvsRTAIrjcjdmYkkw==;5:hnfg+tzHNRbZ5Eej4Dt/eAOVNRYZcoVqnrwbmRZyzjxWtnnyGPldnzg/1S4j8dslNVD2jtXxuwofYPxrUHoM12/SEeeF9udF3+5w0vVnJTRKviMIIr0BWJ3n0tWL8TwB/k9988xJhglgVBJ0NzNH4Cn0cDJKByjH2NPh6OSGhIc=;7:S9YYDPc9aI8bweJTKTAZ2D0pXx6tQbzF0y1ZTaOIkXsQcRBnJce75aTrYiIcF1qHoL7Lgk3iGD5Lovyc95eBc8IKtFWj+0Pb04L4A6D+cT64y3RuhALP+hAmJS55N3NAB3EFZuLNqII9k2V38MRybUUym6dwH6G8gpYMXOvMaET6DVhVVY8IpPcS1x89JX4fW40S355DdOWGPkkvqL+Hk0pF5GJzTxJ/hQwykhjDDHJF2s6tQ15s6xX/vYePA+ao
x-ms-office365-filtering-correlation-id: a17bd803-c31b-4f41-1e6f-08d62ae2287c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1875;
x-ms-traffictypediagnostic: AM4PR0401MB1875:
x-microsoft-antispam-prvs: <AM4PR0401MB1875BC187EC76BE721504A7AE0EB0@AM4PR0401MB1875.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR0401MB1875;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1875;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(366004)(346002)(50944005)(199004)(189003)(4326008)(99286004)(386003)(2900100001)(6506007)(110136005)(6436002)(106356001)(6486002)(105586002)(5660300001)(68736007)(11346002)(476003)(446003)(256004)(14444005)(86362001)(186003)(44832011)(102836004)(2616005)(71200400001)(71190400001)(52116002)(36756003)(26005)(76176011)(486006)(6116002)(3846002)(81166006)(8676002)(118296001)(81156014)(316002)(6636002)(7736002)(305945005)(8936002)(97736004)(53936002)(14454004)(2501003)(54906003)(5250100002)(2906002)(6512007)(66066001)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1875;H:AM4PR0401MB2354.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yZ762U9Xc0NofGjoPO8mPbKgMpOGIINOQ/T+dP73A38NP0hZqMBol/YvdXfZE0cYpmvWXIXTCQrT6vzOp/5HCdMgbqgSw7CEMXPgJ+wngIw2VLCw5QfO0t5gISZJHAJm3y9ok+n1F6305SO2MCu+SFlNOkOMk3bRBKpZYp7mZX8EQxlnvllNBm3Q0bebKTzGBcjPhvQ5VpEXOoYvX8vj4agMAz7ooSMGEC5uxIJMCmaN+L0HfzdtM3dmQUQ0x4Y9DksXgkG7+4L4Lam5Oaf8RET6mhIcamvCoEUjhmxjZV7e6e9ntJLvr9m2bnmJbUJcxL0HW+h6Fm3e6dzIcyzEadqYU8bQJsK2QlUH7Z9/jdg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17bd803-c31b-4f41-1e6f-08d62ae2287c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 16:46:55.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1875
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
 Documentation/ABI/stable/sysfs-bus-fsl-mc |  9 ++++++++
 MAINTAINERS                               |  1 +
 drivers/bus/fsl-mc/dprc-driver.c          | 34 +++++++++++++++++++++++++++=
++++
 3 files changed, 44 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/=
stable/sysfs-bus-fsl-mc
new file mode 100644
index 0000000..f2f14f4
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -0,0 +1,9 @@
+What:		/sys/bus/fsl-mc/devices/dprc.*/rescan
+Date:		October 2018
+KernelVersion:	4.20
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Writing a non-zero value to this attribute will
+		force a rescan of dprc.X container in the system and
+		synchronize the objects under dprc.X and the
+		Management Complex firmware.
+Users:		Userspace drivers and management tools
diff --git a/MAINTAINERS b/MAINTAINERS
index 0ee7e17..57e1509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12023,6 +12023,7 @@ F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
 F:	include/uapi/linux/fsl_mc.h
+F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
=20
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index 52c7e15..dadc2f3 100644
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
@@ -686,6 +713,13 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
--=20
1.9.1

