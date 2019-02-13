Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B00BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13875222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="DClvMrDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392786AbfBMQ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:43 -0500
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:44457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732888AbfBMQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFY8w8DTwtpA/68FJJE2ARSe86WGX3x13AL2psV/dEE=;
 b=DClvMrDhM9nLk+tiNcKve3mzqrx+3LN9RlD+Vq3fFVl68OHqRPWuoEJEzk/0wY9ShKEEUNLilmppz6KgavNY5W8i/EIuvQnSLqfhjS7KIVpW/9dZWFQUhunZxnh5hm6vR2O9NLHsse5udXVX2wxgkdofATVVGoYWgk7PSVWvqhY=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:33 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:33 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Mike Christie <mchristi@redhat.com>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 4/8] uio: change to use the mutex lock instead of the
 spin lock
Thread-Topic: [PATCH 4.14 4/8] uio: change to use the mutex lock instead of
 the spin lock
Thread-Index: AQHUw7lNHd+BDKQp5kylW+yFB2UAfg==
Date:   Wed, 13 Feb 2019 16:29:33 +0000
Message-ID: <20190213162845.11688-5-tommi.t.rantala@nokia.com>
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
x-ms-office365-filtering-correlation-id: 4b7af9cd-835b-4deb-d7e2-08d691d06fab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:CdJL4VzwWJebTnpcXzBl0sIC+Uyd6ChrbQaCb?=
 =?iso-8859-1?Q?0h7TT0oT8RBMG6CQyNU3FguJgdrb+8NLXBRqWnONOcf4HZ01e1kP7b2oB4?=
 =?iso-8859-1?Q?NEvYfZZXyB7lns2Z3oVJwMPpE7L8vhEf/CYchFe5gAshJT3XaaprJifHnJ?=
 =?iso-8859-1?Q?lSrw4k97f6ByGdeFoHUCLF1Xkvqp4Bjal+azq1ujTsetAEdEplsWwF/1LW?=
 =?iso-8859-1?Q?G3idqtePwMlVYsLOWYHxmcROkwoEqNK60sQJ0wPfLOi6I1NKVpH8JRfuGT?=
 =?iso-8859-1?Q?kLFISAdLw8XAr3L9kFRb4QKVGH/j4K4Jd3nvRU2wSaZZxoR9zpx7bY+Gp5?=
 =?iso-8859-1?Q?CkG0qbzUTjMvdGdIt0t0ny/O1tpsin6Q2sRuEGFR/+jGDueSY2gUYisMfH?=
 =?iso-8859-1?Q?j5pQ7jDtJ25epmU5LCRfZij8Fa8+uxHR+yvIXRws2QwJBABUxRMDaS/OGj?=
 =?iso-8859-1?Q?oJxxNUe8hvm6mi8sLLBaQB/ETgAydL3IbC+G0Pn4orm025vgkhOW1fu5sa?=
 =?iso-8859-1?Q?FyXDP2QC8jTAy8QylefAf8YjDFKMUF1LKHcOfKNOQVbkZJVRZ1x63wr8M3?=
 =?iso-8859-1?Q?CKbgNPX0+alBEs7V8+MpKJJGV76bf19aK0yG22zjzyKVZ/K3hVNKBeayX6?=
 =?iso-8859-1?Q?JBqeEcnkmg6oH5yFdReKDwng2LXHecAZYJ+c7MLdqYNasddos5lDxaa6z1?=
 =?iso-8859-1?Q?zqh3G2nYPnfKoBCO3cnupohLgwZp3sp2em4vMPJJANNrasXB+c+MmlDRoC?=
 =?iso-8859-1?Q?tkE3/XdJcrzQxk5vKwboW0qIyCVsJDCyd6qYwnCy4pUgs6IrfWwulIIEWL?=
 =?iso-8859-1?Q?e3+EcPOfhuAe/u6O3wztcS/jsnHQ2ih0v1d0MWs9WIz57u1npjYGMSQyEx?=
 =?iso-8859-1?Q?PBRrT31NYwrRsdnfhSpImsBzAujmn2erFuGKMB+iuu8XeEuBvgQqsmcdxB?=
 =?iso-8859-1?Q?v7YZT3qtr/a9WtIwesfDzy1wdZAprXVog0xmX8vEvOEjVjgDnlhEMqjqAO?=
 =?iso-8859-1?Q?z3kiDbd9OCnF7EowRBRLDr4sBZAoK4S38hvLSOOIxNb7H1utIYsQS9fh5V?=
 =?iso-8859-1?Q?AuACr9sJiSHCeoqs1VHnR9xNhYqko8Gfj3jYZgLnu2ZvocNVrCEz1BwIim?=
 =?iso-8859-1?Q?qh0DQeVzwcDz1FI6RfbCxTBVIIr+zfofifnSgzfjdig+V9Oy/WeYbAomDk?=
 =?iso-8859-1?Q?AjLkDtwPz2vpvNzkr8/l8YRsC9GVZVcv0K4I3WI4uUzRxrNBeZjvEAVaTC?=
 =?iso-8859-1?Q?yzQQE4lbD+e4AT2FLCUJGHP1eb0ah9Q5hIZVZLymMExtD/nUdF9/nhxBpn?=
 =?iso-8859-1?Q?rdafqkwaWGX+++YFnsmU1be0eqXEnrf2MBxou6jTlhwus/F84VcJQyKipk?=
 =?iso-8859-1?Q?70Q/C4kPlKIPkmbQ96tfc70PL1ZL7hJ?=
x-microsoft-antispam-prvs: <HE1PR0702MB372161554FADEC7DCEDB3626B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +kTSxm16Peo6hhPupQedrepEX7WkLPRT28WvoaWfjr4Bw8i+6PshGLDtkZBKwbRgPKUw4/aUwO6IY478ix0o53pSPMWjrtbdkEyNaUVqNwTuvB1eWpASRYpLFNJNVa6FUCqIeb4UB0loMnNoesdMvrIyRAoOWXrA05kVj9Pkx3VSaNlBXKiH+lNyfMsIrskARaeL+PTqDD9nAnz9vflQOxAZ8EcMPrk8J1oXdj71HrIX0+4eKlDNuMEMPbfNj9jZtZ031ljEm3bBdkdDxVgIoWZwVBw5eS0RakVKhr78bx/owVpLlEzQ/gBIGCrbbM7NtZM1UGasIugK/nW/m0nO00e2NDWnUZ7EcvyWNde7W62YBiEVazhqeaafryyXLVGTx2HrVUDz2ZBTMNj0eFrwyray2jytPb4PYwkdEryWDhg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7af9cd-835b-4deb-d7e2-08d691d06fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:33.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 543af5861f41af0a5d2432f6fb5976af50f9cee5 upstream.

We are hitting a regression with the following commit:

commit a93e7b331568227500186a465fee3c2cb5dffd1f
Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Date:   Mon May 14 13:32:23 2018 +1200

    uio: Prevent device destruction while fds are open

The problem is the addition of spin_lock_irqsave in uio_write. This
leads to hitting  uio_write -> copy_from_user -> _copy_from_user ->
might_fault and the logs filling up with sleeping warnings.

I also noticed some uio drivers allocate memory, sleep, grab mutexes
from callouts like open() and release and uio is now doing
spin_lock_irqsave while calling them.

Reported-by: Mike Christie <mchristi@redhat.com>
CC: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c          | 32 +++++++++++++-------------------
 include/linux/uio_driver.h |  2 +-
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index c97945a3f572..4441235a56cc 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -435,7 +435,6 @@ static int uio_open(struct inode *inode, struct file *f=
ilep)
 	struct uio_device *idev;
 	struct uio_listener *listener;
 	int ret =3D 0;
-	unsigned long flags;
=20
 	mutex_lock(&minor_lock);
 	idev =3D idr_find(&uio_idr, iminor(inode));
@@ -462,10 +461,10 @@ static int uio_open(struct inode *inode, struct file =
*filep)
 	listener->event_count =3D atomic_read(&idev->event);
 	filep->private_data =3D listener;
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (idev->info && idev->info->open)
 		ret =3D idev->info->open(idev->info, inode);
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 	if (ret)
 		goto err_infoopen;
=20
@@ -497,12 +496,11 @@ static int uio_release(struct inode *inode, struct fi=
le *filep)
 	int ret =3D 0;
 	struct uio_listener *listener =3D filep->private_data;
 	struct uio_device *idev =3D listener->dev;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (idev->info && idev->info->release)
 		ret =3D idev->info->release(idev->info, inode);
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
=20
 	module_put(idev->owner);
 	kfree(listener);
@@ -515,12 +513,11 @@ static unsigned int uio_poll(struct file *filep, poll=
_table *wait)
 	struct uio_listener *listener =3D filep->private_data;
 	struct uio_device *idev =3D listener->dev;
 	unsigned int ret =3D 0;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
 		ret =3D -EIO;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
=20
 	if (ret)
 		return ret;
@@ -539,12 +536,11 @@ static ssize_t uio_read(struct file *filep, char __us=
er *buf,
 	DECLARE_WAITQUEUE(wait, current);
 	ssize_t retval =3D 0;
 	s32 event_count;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
 		retval =3D -EIO;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
=20
 	if (retval)
 		return retval;
@@ -594,9 +590,8 @@ static ssize_t uio_write(struct file *filep, const char=
 __user *buf,
 	struct uio_device *idev =3D listener->dev;
 	ssize_t retval;
 	s32 irq_on;
-	unsigned long flags;
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq) {
 		retval =3D -EIO;
 		goto out;
@@ -620,7 +615,7 @@ static ssize_t uio_write(struct file *filep, const char=
 __user *buf,
 	retval =3D idev->info->irqcontrol(idev->info, irq_on);
=20
 out:
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
 	return retval ? retval : sizeof(s32);
 }
=20
@@ -874,7 +869,7 @@ int __uio_register_device(struct module *owner,
=20
 	idev->owner =3D owner;
 	idev->info =3D info;
-	spin_lock_init(&idev->info_lock);
+	mutex_init(&idev->info_lock);
 	init_waitqueue_head(&idev->wait);
 	atomic_set(&idev->event, 0);
=20
@@ -940,7 +935,6 @@ EXPORT_SYMBOL_GPL(__uio_register_device);
 void uio_unregister_device(struct uio_info *info)
 {
 	struct uio_device *idev;
-	unsigned long flags;
=20
 	if (!info || !info->uio_dev)
 		return;
@@ -954,9 +948,9 @@ void uio_unregister_device(struct uio_info *info)
 	if (info->irq && info->irq !=3D UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
=20
-	spin_lock_irqsave(&idev->info_lock, flags);
+	mutex_lock(&idev->info_lock);
 	idev->info =3D NULL;
-	spin_unlock_irqrestore(&idev->info_lock, flags);
+	mutex_unlock(&idev->info_lock);
=20
 	device_unregister(&idev->dev);
=20
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 6c5f2074e14f..6f8b68cd460f 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -75,7 +75,7 @@ struct uio_device {
         struct fasync_struct    *async_queue;
         wait_queue_head_t       wait;
         struct uio_info         *info;
-	spinlock_t		info_lock;
+	struct mutex		info_lock;
         struct kobject          *map_dir;
         struct kobject          *portio_dir;
 };
--=20
2.20.1

