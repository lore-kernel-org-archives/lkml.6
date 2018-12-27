Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861D21902
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eJaYp7Dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbeL0ROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:14:55 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:60698
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728664AbeL0ROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cTy30umQRbngbCO0UFlX+2TS1jCNAFUoXKXdYwMEUg=;
 b=eJaYp7DnukWeLtLcuN6oO6/YvT1slPBjNY0LOIy9yojGqVYyxhs392YQdJXKFqlIu1BH3dLvIL1L0juhFG/CcVgqFLN95Cxa6UVg/WevQcYujJda4SO7Ndi7p3qVREMdwoFk/Bu9tQhiK9ucFUI1XxZaISdj+2dC29Mz5FJK7NI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5427.eurprd04.prod.outlook.com (20.178.116.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 27 Dec 2018 17:14:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.027; Thu, 27 Dec 2018
 17:14:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Topic: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Index: AQHUngerKaedheUOE0OdzOpUuVXDPw==
Date:   Thu, 27 Dec 2018 17:14:48 +0000
Message-ID: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5427;6:+fskWIJCrt5qETjnmfbePtE3GceutJsWTQOwHLvqExwPdOJnvE2S/4ucOkvv/hjbGcM7VrTCFI1I0HRMeecPlFjJnaghjx5HxTngjBCHyYGAV7B3DhOF8OV75TFJvm3PlD2hy6s+3XWEtRPAcN9wZWUSUTd4x6NXjKwt2JwYeuIXtMRumev/Vp6oaBjGRxfFShU7XAaPmddOmoDmRed1sYF4YKrophNzFM00YUmWpKt3oUUYQck5KXIVC+zvp1dhOqHlR+mxRXNAFlaOckoOOxhpMUG8S0JCkQSk+cm4cs3mGly4Oww83iy11X+ifKa5p0GKKoAXtrWANg4gHyzWNfHFcxQ1EA620JG4xbCQqTL97Ay8HI2W/JKOX8CFfJjhBvxoBkU15FLOY7RKWq2hKLKnSMps56dUhh+A36dBE1vYsqHRaq4ZVxU1pJR6pgjse+iXv9oXWGUtLQzrzRZgLQ==;5:McyEVeiMVs4vMHil1P0iCoXyigCCE306ZrWRFN+GyGe7MqNP/KAMPTL3xgJVd+/Wdh4MKpzqt79msDRJ5LqxiiOdNhmoodpHqG070ro9mERV3/83eujHq2Nayzqv+nbBvv4Ba7t66tjktnr+cAhmxRjgJY1X2GKORYB/ki5W8j4=;7:z1PC1DJ8NZ4fGm/8RBmAkHJ37p5kKKWjLdXraay2TOKi0yLWsjMGQEwVfYIFtXOPMj0TGTh7zqqk4ztIjss+N50uVbhiyuWSZz1Yt48zQD0sdilJE8WngIOIIzXF+GDHc2FbLFmicrrvkAA40PyQrg==
x-ms-office365-filtering-correlation-id: c2c9c871-2dd3-43b5-34fe-08d66c1ece28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5427;
x-ms-traffictypediagnostic: AM0PR04MB5427:
x-microsoft-antispam-prvs: <AM0PR04MB5427CF57C09B9AF8B4A2EB1E80B60@AM0PR04MB5427.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5427;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5427;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(52314003)(199004)(189003)(8936002)(97736004)(5660300001)(53936002)(4326008)(5024004)(3846002)(50226002)(86362001)(6916009)(316002)(966005)(256004)(14454004)(2616005)(14444005)(71190400001)(71200400001)(476003)(478600001)(7736002)(36756003)(305945005)(6116002)(39060400002)(6486002)(217873002)(68736007)(486006)(2501003)(186003)(2906002)(99286004)(25786009)(6306002)(54906003)(102836004)(6512007)(44832011)(6436002)(5640700003)(7416002)(8676002)(106356001)(105586002)(2351001)(6506007)(386003)(81156014)(81166006)(66066001)(26005)(52116002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5427;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gzUPVIHohWAlRn6dwanv20LkYOQI9GTBvLOGTWgSBFRqz9lq1k+bJZC6Tbzm05A4JIu9QgUdWDBibX3+HLgEP2ssZtw5jK31/nXSBs+jqE3VOK2eD2QME1KYyW3NRGyXu2vaJ4EbzbrM1n88dujHz04PWNGGNWJDxH0CakW25P03i/rQdfUfiQ2UNRSyFT4m5UStSKforYiceLhPkZKV1ix4YyT/zuLT+iCsh3PghnOlJRe6Dekxkvvpt3s4OuvJ7W363WmwWlir8Ezdno3vr8IXS8SiECFhbru2M1f5x96AWIRAS89M0wp+wL1P5LjA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9c871-2dd3-43b5-34fe-08d66c1ece28
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 17:14:48.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently attach_dev() in power domain infrastructure still does
not support multi domains case as the struct device *dev passed
down from genpd_dev_pm_attach_by_id() is a virtual PD device, it
does not help for parsing the real device information from device
tree, e.g. Device/Power IDs, Clocks and it's unware of which real
power domain the device should attach.

Extend the framework a bit to store the multi PM domains information
in per-device struct generic_pm_domain_data, then power domain driver
could retrieve it for necessary operations during attach_dev().

Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
introduced to ease the driver operation.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
This patch is a follow-up work of the earlier discussion with Ulf Hansson
about the multi PM domains support for the attach_dev() function [1].
After a bit more thinking, this is a less intrusive implementation with
the mininum impact on the exist function definitions and calling follows.
One known little drawback is that we have to use the device driver private
data (device.drvdata) to pass down the multi domains information in a
earlier time. However, as multi PD devices are created by domain framework,
this seems to be safe to use it in domain core code as device driver
is not likely going to use it.
Anyway, if any better ideas, please let me know.

With the two new APIs, the using can be simply as:
static int xxx_attach_dev(struct generic_pm_domain *domain,
			  struct device *dev)
{
	...
	if (genpd_is_mpd_device(dev)) {
		mpd_data =3D dev_gpd_mpd_data(dev);
		np =3D mpd_data->parent->of_node;
		idx =3D mpd_data->index;
		//dts parsing
		...
	}
	...
}

[1] https://patchwork.kernel.org/patch/10658669/
---
 drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   | 23 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92..1aa0918 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1343,6 +1343,9 @@ static struct generic_pm_domain_data *genpd_alloc_dev=
_data(struct device *dev,
 	gpd_data->td.effective_constraint_ns =3D PM_QOS_RESUME_LATENCY_NO_CONSTRA=
INT_NS;
 	gpd_data->nb.notifier_call =3D genpd_dev_pm_qos_notifier;
=20
+	if (genpd_is_mpd_device(dev))
+		gpd_data->mpd_data =3D dev_get_drvdata(dev);
+
 	spin_lock_irq(&dev->power.lock);
=20
 	if (dev->power.subsys_data->domain_data) {
@@ -2179,6 +2182,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
=20
 static void genpd_release_dev(struct device *dev)
 {
+	kfree(dev->driver_data);
 	kfree(dev);
 }
=20
@@ -2320,6 +2324,20 @@ int genpd_dev_pm_attach(struct device *dev)
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
=20
 /**
+ * genpd_is_mpd_device - Check if a device is associated with multi PM dom=
ains
+ * @dev: Device to check.
+ */
+
+bool genpd_is_mpd_device(struct device *dev)
+{
+	if (!dev || (dev && !dev->bus))
+		return false;
+
+	return dev->bus =3D=3D &genpd_bus_type;
+};
+EXPORT_SYMBOL_GPL(genpd_is_mpd_device);
+
+/**
  * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domai=
ns.
  * @dev: The device used to lookup the PM domain.
  * @index: The index of the PM domain.
@@ -2338,6 +2356,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index)
 {
+	struct pm_domain_mpd_data *mpd_data;
 	struct device *genpd_dev;
 	int num_domains;
 	int ret;
@@ -2366,6 +2385,18 @@ struct device *genpd_dev_pm_attach_by_id(struct devi=
ce *dev,
 		return ERR_PTR(ret);
 	}
=20
+	/* Allocate multi power domains data */
+	mpd_data =3D kzalloc(sizeof(*mpd_data), GFP_KERNEL);
+	if (!mpd_data) {
+		device_unregister(genpd_dev);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mpd_data->parent =3D dev;
+	mpd_data->index =3D index;
+
+	dev_set_drvdata(genpd_dev, mpd_data);
+
 	/* Try to attach the device to the PM domain at the specified index. */
 	ret =3D __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
 	if (ret < 1) {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b5d728..106d4e7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -144,6 +144,11 @@ struct gpd_timing_data {
 	bool cached_suspend_ok;
 };
=20
+struct pm_domain_mpd_data {
+	struct device *parent;
+	unsigned int index;
+};
+
 struct pm_domain_data {
 	struct list_head list_node;
 	struct device *dev;
@@ -151,6 +156,7 @@ struct pm_domain_data {
=20
 struct generic_pm_domain_data {
 	struct pm_domain_data base;
+	struct pm_domain_mpd_data *mpd_data;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
 	unsigned int performance_state;
@@ -262,10 +268,17 @@ unsigned int of_genpd_opp_to_performance_state(struct=
 device *dev,
 				struct device_node *np);
=20
 int genpd_dev_pm_attach(struct device *dev);
+bool genpd_is_mpd_device(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
 					   char *name);
+
+static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct device *d=
ev)
+{
+	return dev_gpd_data(dev)->mpd_data;
+}
+
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -311,6 +324,11 @@ static inline int genpd_dev_pm_attach(struct device *d=
ev)
 	return 0;
 }
=20
+static bool genpd_is_mpd_device(struct device *dev)
+{
+	return false;
+}
+
 static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 						       unsigned int index)
 {
@@ -323,6 +341,11 @@ static inline struct device *genpd_dev_pm_attach_by_na=
me(struct device *dev,
 	return NULL;
 }
=20
+static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct device *d=
ev)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
--=20
2.7.4

