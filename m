Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF66C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5915A222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="h0pSnXvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbfBMQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:35 -0500
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:44457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732888AbfBMQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEKzq0VdkoPjyCl9ekENWjLpL+sk2Tj2QG90eAV69w4=;
 b=h0pSnXvrNnuRQmWc8VSTTQxurkieVnXVFwnawyqZZF0BSQmZWApe4V7jRqZZYgd6MIjSHurm6Tfz82mvqo1SX0pmGqEZUNT5z5l3E4gEyCEaaLR4AHGOIlxKfxXFHmWvr/m9v5PWBmHPp/XDvjVhTVF2QRoZIYyYsRi+p8Z7RQ4=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:30 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:30 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 2/8] uio: Prevent device destruction while fds are open
Thread-Topic: [PATCH 4.14 2/8] uio: Prevent device destruction while fds are
 open
Thread-Index: AQHUw7lLRBDpn/AjH0+YAVwkCxjUVQ==
Date:   Wed, 13 Feb 2019 16:29:29 +0000
Message-ID: <20190213162845.11688-3-tommi.t.rantala@nokia.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f170394-7089-4ac7-5849-08d691d06d75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:NTPLb9ghO9chB6ygf0bWuEqlMBXkY/GbHLWRi?=
 =?iso-8859-1?Q?CRgAu0/AbmIxfSZ0gYeXEpcuDGnaDZ3RUPLYbnowuzhUArbC5LJ9f3iQAT?=
 =?iso-8859-1?Q?s1VedsuxzQ5bbQayKOK9aaKGq60QIBI5NVtTiZaqyshkBXSmQaKGtk/uA0?=
 =?iso-8859-1?Q?gC53AIxleQM8ULUVNsbp60nOMq11IiDl9rIzDU/hnKBCe+OlqSLk4WaIAh?=
 =?iso-8859-1?Q?QU1b7i0kLJPMm4Ley3uR5lIUX7XMLIcJisPw5M0qbQiWuFnO/PtlI9QdjV?=
 =?iso-8859-1?Q?99fLIvDdB1JPqlTXKmJseqSSl+nNtJmNFwkAy4wipQUjXp8fPaOCOuIhtb?=
 =?iso-8859-1?Q?GweXo5lnM7lyZHiznfGz/Agzz7YUJjMORTNTdxT+G9PfJQSnxIlcG1X+s1?=
 =?iso-8859-1?Q?mMzJVAAGpfsJulZyut1+2ICvimSyW/28gmnyykRUq+azIGdt/IndU9hpY1?=
 =?iso-8859-1?Q?jA/ATa/F/My1DXqiufRnB9QX9Qn9MeugnjYVCD6H+3zsmm8p0UMFQIwzeM?=
 =?iso-8859-1?Q?hMzpOCBSAyl7a0SBZdpu7MsnNNopj/bBz2BaJnuC5AYgDQoHJTSiesJZwl?=
 =?iso-8859-1?Q?rE/mlat8qJ31k/sRTNRUZpi7vsuUzU3mO771JrcM/ERSnDDRfq50tzcNjR?=
 =?iso-8859-1?Q?8jK3xTt5e/x9OQy+hVOzpb5SS2Cz37wShF0qJPn7oJWUlLZKqcmFdCSkKj?=
 =?iso-8859-1?Q?OQ3JJGhx8edT3m4cpQJYRIal9hdH9iwC/c8qBu4vxXt5GYBA0DxGXad0bz?=
 =?iso-8859-1?Q?Fup0nIeX41Wpjey7HXJvRXmgKy8g4s/zH3bzMFtwTXVpt4hXUsjiWSjblS?=
 =?iso-8859-1?Q?e95s4uNB272/6cDaJraSVwZhvG4NNAJBI9k7jHGBAyruAxtobOQYOedFy1?=
 =?iso-8859-1?Q?R4OkEWK2Qa/TKW15z6BYwXw2tvywKSJFQfHDAfzEw/MX16eLJKXABNAnws?=
 =?iso-8859-1?Q?4SLJhKCJXtDB7dut3Vxb2wlLBms5/FJ97NUu6yrq7F9KDET50SWH2FaWhe?=
 =?iso-8859-1?Q?cFXNuSZnhpY9BEapMsRdlsLG6bTN0DajdXAfdp72SN4Ubx+nbkj67MHMCc?=
 =?iso-8859-1?Q?3DjK7mqaFBOlLybYPNEZVwe0wpvWuU5S1s2uw5nxZAljxRILtvyMMKpVy6?=
 =?iso-8859-1?Q?rkKZiknTBknMJBXp0P5LlVSzMS236XL+6kTawA/XOD95RZ7VQ0sXgxImOs?=
 =?iso-8859-1?Q?S3MtBNnB7Ei5jNoQj7z8fl5FAunn8DM95L9Orq34dzX6u738b6llOmhyhB?=
 =?iso-8859-1?Q?nXY11S+MZii0cZaI/bkv2TRTs5rsAfRrgcDn1OpvbRWhnaqicXzD4gdGGa?=
 =?iso-8859-1?Q?hHs3lRBPCteXqwgTUzUh2l/s9VV4XSTzvZDdwiyAJyN6d1BJs2g77JJfI9?=
 =?iso-8859-1?Q?7nyidSt+eW8JzT5DyTbv9Vgar/mrrnb?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721B68D3665A5104177625EB4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ca5+5vfKN9S8qmq8X+DZit7ZOwF0WnXFDCs/vaKmPe10DpNfuYbWV/qLPfVrFPPzym0i3Xjp2/iCJT+s9y6oG6P66owGrVbHlJaF3l2exK5mdXJjlvVCBPmblzfGZFIG28Sy3xSmTt3B62P7HBatr2xgEtDSBJNl1ig3VMOiPgFQtvA1npOXtTSXX2kCcn8WyYPcrffkQiTgq7XMrUvq8rdHYifNxhmWYGqO+h4+xkHdI7D5K8MROFl7tzdNKYrUTipYOaIVWhVfvwFaoOrkLk/1gx4Rxrs1do8WnWvuYwUd4hGjwj0F3Wn3lxH1jQnQ4iWTvaRoesaxjaYM5MgGSuK4IRf+7yrynzPN32J0FlFaxwfF33QP1hQ6H2EjqMFD9VlfgcCaRQZvFJ/LcoQM8xtypE+XB154HpxYQDu7o4c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f170394-7089-4ac7-5849-08d691d06d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:29.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

commit a93e7b331568227500186a465fee3c2cb5dffd1f upstream.

Prevent destruction of a uio_device while user space apps hold open
file descriptors to that device. Further, access to the 'info' member
of the struct uio_device is protected by spinlock. This is to ensure
stale pointers to data not under control of the UIO subsystem are not
dereferenced.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[4.14 change __poll_t to unsigned int]
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c          | 98 ++++++++++++++++++++++++++++----------
 include/linux/uio_driver.h |  4 +-
 2 files changed, 75 insertions(+), 27 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 10f249628e79..288c4b977184 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -272,7 +272,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 		if (!map_found) {
 			map_found =3D 1;
 			idev->map_dir =3D kobject_create_and_add("maps",
-							&idev->dev->kobj);
+							&idev->dev.kobj);
 			if (!idev->map_dir) {
 				ret =3D -ENOMEM;
 				goto err_map;
@@ -301,7 +301,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 		if (!portio_found) {
 			portio_found =3D 1;
 			idev->portio_dir =3D kobject_create_and_add("portio",
-							&idev->dev->kobj);
+							&idev->dev.kobj);
 			if (!idev->portio_dir) {
 				ret =3D -ENOMEM;
 				goto err_portio;
@@ -344,7 +344,7 @@ static int uio_dev_add_attributes(struct uio_device *id=
ev)
 		kobject_put(&map->kobj);
 	}
 	kobject_put(idev->map_dir);
-	dev_err(idev->dev, "error creating sysfs files (%d)\n", ret);
+	dev_err(&idev->dev, "error creating sysfs files (%d)\n", ret);
 	return ret;
 }
=20
@@ -381,7 +381,7 @@ static int uio_get_minor(struct uio_device *idev)
 		idev->minor =3D retval;
 		retval =3D 0;
 	} else if (retval =3D=3D -ENOSPC) {
-		dev_err(idev->dev, "too many uio devices\n");
+		dev_err(&idev->dev, "too many uio devices\n");
 		retval =3D -EINVAL;
 	}
 	mutex_unlock(&minor_lock);
@@ -435,6 +435,7 @@ static int uio_open(struct inode *inode, struct file *f=
ilep)
 	struct uio_device *idev;
 	struct uio_listener *listener;
 	int ret =3D 0;
+	unsigned long flags;
=20
 	mutex_lock(&minor_lock);
 	idev =3D idr_find(&uio_idr, iminor(inode));
@@ -444,9 +445,11 @@ static int uio_open(struct inode *inode, struct file *=
filep)
 		goto out;
 	}
=20
+	get_device(&idev->dev);
+
 	if (!try_module_get(idev->owner)) {
 		ret =3D -ENODEV;
-		goto out;
+		goto err_module_get;
 	}
=20
 	listener =3D kmalloc(sizeof(*listener), GFP_KERNEL);
@@ -459,11 +462,13 @@ static int uio_open(struct inode *inode, struct file =
*filep)
 	listener->event_count =3D atomic_read(&idev->event);
 	filep->private_data =3D listener;
=20
-	if (idev->info->open) {
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (idev->info && idev->info->open)
 		ret =3D idev->info->open(idev->info, inode);
-		if (ret)
-			goto err_infoopen;
-	}
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+	if (ret)
+		goto err_infoopen;
+
 	return 0;
=20
 err_infoopen:
@@ -472,6 +477,9 @@ static int uio_open(struct inode *inode, struct file *f=
ilep)
 err_alloc_listener:
 	module_put(idev->owner);
=20
+err_module_get:
+	put_device(&idev->dev);
+
 out:
 	return ret;
 }
@@ -489,12 +497,16 @@ static int uio_release(struct inode *inode, struct fi=
le *filep)
 	int ret =3D 0;
 	struct uio_listener *listener =3D filep->private_data;
 	struct uio_device *idev =3D listener->dev;
+	unsigned long flags;
=20
-	if (idev->info->release)
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (idev->info && idev->info->release)
 		ret =3D idev->info->release(idev->info, inode);
+	spin_unlock_irqrestore(&idev->info_lock, flags);
=20
 	module_put(idev->owner);
 	kfree(listener);
+	put_device(&idev->dev);
 	return ret;
 }
=20
@@ -502,9 +514,16 @@ static unsigned int uio_poll(struct file *filep, poll_=
table *wait)
 {
 	struct uio_listener *listener =3D filep->private_data;
 	struct uio_device *idev =3D listener->dev;
+	unsigned int ret =3D 0;
+	unsigned long flags;
=20
-	if (!idev->info->irq)
-		return -EIO;
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq)
+		ret =3D -EIO;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	if (ret)
+		return ret;
=20
 	poll_wait(filep, &idev->wait, wait);
 	if (listener->event_count !=3D atomic_read(&idev->event))
@@ -518,11 +537,17 @@ static ssize_t uio_read(struct file *filep, char __us=
er *buf,
 	struct uio_listener *listener =3D filep->private_data;
 	struct uio_device *idev =3D listener->dev;
 	DECLARE_WAITQUEUE(wait, current);
-	ssize_t retval;
+	ssize_t retval =3D 0;
 	s32 event_count;
+	unsigned long flags;
=20
-	if (!idev->info->irq)
-		return -EIO;
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq)
+		retval =3D -EIO;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	if (retval)
+		return retval;
=20
 	if (count !=3D sizeof(s32))
 		return -EINVAL;
@@ -569,8 +594,10 @@ static ssize_t uio_write(struct file *filep, const cha=
r __user *buf,
 	struct uio_device *idev =3D listener->dev;
 	ssize_t retval;
 	s32 irq_on;
+	unsigned long flags;
=20
-	if (!idev->info->irq) {
+	spin_lock_irqsave(&idev->info_lock, flags);
+	if (!idev->info || !idev->info->irq) {
 		retval =3D -EIO;
 		goto out;
 	}
@@ -593,6 +620,7 @@ static ssize_t uio_write(struct file *filep, const char=
 __user *buf,
 	retval =3D idev->info->irqcontrol(idev->info, irq_on);
=20
 out:
+	spin_unlock_irqrestore(&idev->info_lock, flags);
 	return retval ? retval : sizeof(s32);
 }
=20
@@ -809,6 +837,13 @@ static void release_uio_class(void)
 	uio_major_cleanup();
 }
=20
+static void uio_device_release(struct device *dev)
+{
+	struct uio_device *idev =3D dev_get_drvdata(dev);
+
+	kfree(idev);
+}
+
 /**
  * uio_register_device - register a new userspace IO device
  * @owner:	module that creates the new device
@@ -832,13 +867,14 @@ int __uio_register_device(struct module *owner,
=20
 	info->uio_dev =3D NULL;
=20
-	idev =3D devm_kzalloc(parent, sizeof(*idev), GFP_KERNEL);
+	idev =3D kzalloc(sizeof(*idev), GFP_KERNEL);
 	if (!idev) {
 		return -ENOMEM;
 	}
=20
 	idev->owner =3D owner;
 	idev->info =3D info;
+	spin_lock_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
=20
@@ -846,14 +882,19 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		return ret;
=20
-	idev->dev =3D device_create(&uio_class, parent,
-				  MKDEV(uio_major, idev->minor), idev,
-				  "uio%d", idev->minor);
-	if (IS_ERR(idev->dev)) {
-		printk(KERN_ERR "UIO: device register failed\n");
-		ret =3D PTR_ERR(idev->dev);
+	idev->dev.devt =3D MKDEV(uio_major, idev->minor);
+	idev->dev.class =3D &uio_class;
+	idev->dev.parent =3D parent;
+	idev->dev.release =3D uio_device_release;
+	dev_set_drvdata(&idev->dev, idev);
+
+	ret =3D dev_set_name(&idev->dev, "uio%d", idev->minor);
+	if (ret)
+		goto err_device_create;
+
+	ret =3D device_register(&idev->dev);
+	if (ret)
 		goto err_device_create;
-	}
=20
 	ret =3D uio_dev_add_attributes(idev);
 	if (ret)
@@ -883,7 +924,7 @@ int __uio_register_device(struct module *owner,
 err_request_irq:
 	uio_dev_del_attributes(idev);
 err_uio_dev_add_attributes:
-	device_destroy(&uio_class, MKDEV(uio_major, idev->minor));
+	device_unregister(&idev->dev);
 err_device_create:
 	uio_free_minor(idev);
 	return ret;
@@ -898,6 +939,7 @@ EXPORT_SYMBOL_GPL(__uio_register_device);
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
+	unsigned long flags;
=20
 	if (!info || !info->uio_dev)
 		return;
@@ -911,7 +953,11 @@ void uio_unregister_device(struct uio_info *info)
 	if (info->irq && info->irq !=3D UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
=20
-	device_destroy(&uio_class, MKDEV(uio_major, idev->minor));
+	spin_lock_irqsave(&idev->info_lock, flags);
+	idev->info =3D NULL;
+	spin_unlock_irqrestore(&idev->info_lock, flags);
+
+	device_unregister(&idev->dev);
=20
 	return;
 }
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 3c85c81b0027..6c5f2074e14f 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -14,6 +14,7 @@
 #ifndef _UIO_DRIVER_H_
 #define _UIO_DRIVER_H_
=20
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
=20
@@ -68,12 +69,13 @@ struct uio_port {
=20
 struct uio_device {
         struct module           *owner;
-        struct device           *dev;
+	struct device		dev;
         int                     minor;
         atomic_t                event;
         struct fasync_struct    *async_queue;
         wait_queue_head_t       wait;
         struct uio_info         *info;
+	spinlock_t		info_lock;
         struct kobject          *map_dir;
         struct kobject          *portio_dir;
 };
--=20
2.20.1

