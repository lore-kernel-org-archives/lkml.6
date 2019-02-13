Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19D9222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="MfvHpADe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbfBMQ3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:46 -0500
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:44457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392744AbfBMQ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvDg27OZ1z82sGctDeVPYXLmEN4Kqk4WPnB+45U9NLA=;
 b=MfvHpADeIyysuCXXFUldYvQrqHqb5Qy+sDK+3lTqNhjTj7msyIXkPbtR4INrAKCDadlGqG3Ga1SqEIG3hOWOFZguArU3h5ID2oLSrBD/THu3LEM91fNvO5ymo+JLQuSumObARk2hDrHCVMHpyUYTqmNqa2d1kKPfAxaujE0hb9w=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:35 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:35 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Mike Christie <mchristi@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 5/8] uio: fix crash after the device is unregistered
Thread-Topic: [PATCH 4.14 5/8] uio: fix crash after the device is unregistered
Thread-Index: AQHUw7lOCfZiNTpZyUmwaK0BlGT1sw==
Date:   Wed, 13 Feb 2019 16:29:34 +0000
Message-ID: <20190213162845.11688-6-tommi.t.rantala@nokia.com>
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
x-ms-office365-filtering-correlation-id: d198459a-483f-4437-5387-08d691d0707f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:fmniy0gvIPq5cNnWpKrVdgKoeSlV5IaeCR9j+?=
 =?iso-8859-1?Q?c9HDOBqG/TtH67QH5Njnv00tmXr8K7JYLC3u3ZDnmE7gBjUZBrJtY4S4lF?=
 =?iso-8859-1?Q?cbF150RuOKzU9XRGtRKfFCVeMa/o9uJ3qmiQfeNajuQhvP86UhuqFBo+XM?=
 =?iso-8859-1?Q?HNwssN6LWuQCqxqbp7JKPLzNsfsAtg2yblyMeRZSmCTXqFkdVL1d0++QUJ?=
 =?iso-8859-1?Q?y5UHHQYw1Os0CzqG6jEGNf2xEQ0S+h/36/PFHaekThKTOZ4rHNdU8ivhSv?=
 =?iso-8859-1?Q?EvErnMFTBicnXSZh0NZ/0XfhDibsKFkTbB2KUJy8o0gT4kqwma4eiHounH?=
 =?iso-8859-1?Q?9afKEqeLzaKpBc8w+GGg9t7ExFxdMJE30oIqjI7oKmu4o+WwiupwhUsjet?=
 =?iso-8859-1?Q?G9cdXsx4SweQVOgyldK06DW8b16tv8miSFNYBf20Wvx4s4/lpntF37kgTj?=
 =?iso-8859-1?Q?ExtnLwLYhgC5d8S+Wn9NPY9cnoYkFU/QVVHTxYwnc2OE50npodzJCfIiZ/?=
 =?iso-8859-1?Q?ftZiCmTdrtY9H5GrWHvO3Ms/rIABfUTVPk+Wh2WEh6bX0xjjEvwoLUGmXb?=
 =?iso-8859-1?Q?6waUgDHpT4Ge/ogjVjZ48zG4mh6Ai+d8COTofdnS0OFOKAsZFMXwVED2Tb?=
 =?iso-8859-1?Q?mFt5fXp7VLYNQ298Gr71aHHLio9flzEJPr3+BcblqmJgi8MqEYdJLzgdTP?=
 =?iso-8859-1?Q?IDcwOYaENe4u3bWH0xEi83lEEaZDm7vUsD7vNavm4bzqgKCQZdCVpuDajb?=
 =?iso-8859-1?Q?xqFtz5RHaDVJ6ybh04L0vqoyf+CPqIOLoVNck59q/M58xmmDnA30HGAO0G?=
 =?iso-8859-1?Q?eu06HkL0QPEq1821KDxKKkzLDf5Hq50JbRm4CaZh3aIdBBeQJMw1l+mQ4o?=
 =?iso-8859-1?Q?UMngU6Jmot+Dk8fcj13gXkO+A+8+rGn5ANOHAbUDKrr86JM6NnnHCmnlUZ?=
 =?iso-8859-1?Q?yWaaH8QkGfOH85nhj0iN2Z+i8QjDR7ZmPI6cSSGOOoR0aUrDtBL9pBUaHH?=
 =?iso-8859-1?Q?QtuC1JxNxfGC/qzGCnIDlqcgXTBsd68Z6cMc5fGVUY+FrSMXelZV/PcGxj?=
 =?iso-8859-1?Q?BGt8aSLh/+Rga0biRDhQNATUruLpmT9W7KvXjDds/qZ7082adiRFKq3use?=
 =?iso-8859-1?Q?2b2Q2WUbcMDwyj1NbRHmmxfsWrqxZGcj3w0szokcECyoakVDwQfOWPJKhP?=
 =?iso-8859-1?Q?vOlLuSJxaYSNNNfKmNWnZHWswNT7gt0HWz15z/Smlrfy+GVql/2Gvn2ywM?=
 =?iso-8859-1?Q?1ObRtneKYlPTBhBYljgNEo48MGhsrklEYgtk4Hc8TedEN/PbibNsL/KItA?=
 =?iso-8859-1?Q?lgwFZBJhDtmjnY+MHlZwlfk6V1nMDBe/I84UMfJTM1jVpnEMFoHQkU0aFD?=
 =?iso-8859-1?Q?FH28gOz317+LDX2hplvmZf++qbfG5fn?=
x-microsoft-antispam-prvs: <HE1PR0702MB37211BE0DA08D935C21681D1B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5gdimT92vQFUcE018fh544toUVj6f6ninCEWAp411DyrhLjaUhqsS114gf5Fs6Y5wYQ23aAdF1ETShc7ZNmWf8aptb7L7q/tvSPSlcihsy2UCH6+WkiH2L0UqjDCn+QljlYHAi/KGwlf0jDNZjTGoegkwWeuZ47O2DUVJPMfMOFEl7K9r8ToVEoSGQU0jJV7trdFhoPvGKP5sYAMXxIUdYk//+CGWq2jPHnd9nfQwhS9UfB0ueaQXjFHTcjpZkkb7SPgZDqtzsCrVvJGm5FnVUPIMmjgXjXVwr/jtwGelv62qELn6KoCnbhfVPX9lZR6Kyq0WqE9Ml/zI1vtrjn4nypVekMYLVnA/H4hGL7nmogUUnW4HUX3CG1SxNL0JprcqeJwlxN3gjC8c0Xmc+jr4yU3WLkAp8hlJ2vcK90pecI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d198459a-483f-4437-5387-08d691d0707f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:34.4030
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

commit 57c5f4df0a5a0ee83df799991251e2ee93a5e4e9 upstream.

For the target_core_user use case, after the device is unregistered
it maybe still opened in user space, then the kernel will crash, like:

[  251.163692] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000008
[  251.163820] IP: [<ffffffffc0736213>] show_name+0x23/0x40 [uio]
[  251.163965] PGD 8000000062694067 PUD 62696067 PMD 0
[  251.164097] Oops: 0000 [#1] SMP
...
[  251.165605]  e1000 mptscsih mptbase drm_panel_orientation_quirks dm_mirr=
or dm_region_hash dm_log dm_mod
[  251.166014] CPU: 0 PID: 13380 Comm: tcmu-runner Kdump: loaded Not tainte=
d 3.10.0-916.el7.test.x86_64 #1
[  251.166381] Hardware name: VMware, Inc. VMware Virtual Platform/440BX De=
sktop Reference Platform, BIOS 6.00 05/19/2017
[  251.166747] task: ffff971eb91db0c0 ti: ffff971e9e384000 task.ti: ffff971=
e9e384000
[  251.167137] RIP: 0010:[<ffffffffc0736213>]  [<ffffffffc0736213>] show_na=
me+0x23/0x40 [uio]
[  251.167563] RSP: 0018:ffff971e9e387dc8  EFLAGS: 00010282
[  251.167978] RAX: 0000000000000000 RBX: ffff971e9e3f8000 RCX: ffff971eb83=
68d98
[  251.168408] RDX: ffff971e9e3f8000 RSI: ffffffffc0738084 RDI: ffff971e9e3=
f8000
[  251.168856] RBP: ffff971e9e387dd0 R08: ffff971eb8bc0018 R09: 00000000000=
00000
[  251.169296] R10: 0000000000001000 R11: ffffffffa09d444d R12: ffffffffa10=
76e80
[  251.169750] R13: ffff971e9e387f18 R14: 0000000000000001 R15: ffff971e9cf=
b1c80
[  251.170213] FS:  00007ff37d175880(0000) GS:ffff971ebb600000(0000) knlGS:=
0000000000000000
[  251.170693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  251.171248] CR2: 0000000000000008 CR3: 00000000001f6000 CR4: 00000000003=
607f0
[  251.172071] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  251.172640] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  251.173236] Call Trace:
[  251.173789]  [<ffffffffa0c9b2d3>] dev_attr_show+0x23/0x60
[  251.174356]  [<ffffffffa0f561b2>] ? mutex_lock+0x12/0x2f
[  251.174892]  [<ffffffffa0ac6d9f>] sysfs_kf_seq_show+0xcf/0x1f0
[  251.175433]  [<ffffffffa0ac54e6>] kernfs_seq_show+0x26/0x30
[  251.175981]  [<ffffffffa0a63be0>] seq_read+0x110/0x3f0
[  251.176609]  [<ffffffffa0ac5d45>] kernfs_fop_read+0xf5/0x160
[  251.177158]  [<ffffffffa0a3d3af>] vfs_read+0x9f/0x170
[  251.177707]  [<ffffffffa0a3e27f>] SyS_read+0x7f/0xf0
[  251.178268]  [<ffffffffa0f648af>] system_call_fastpath+0x1c/0x21
[  251.178823] Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 =
48 89 d3 e8 7e 96 56 e0 48 8b 80 d8 02 00 00 48 89 df 48 c7 c6 84 80 73 c0 =
<48> 8b 50 08 31 c0 e8 e2 67 44 e0 5b 48 98 5d c3 0f 1f 00 66 2e
[  251.180115] RIP  [<ffffffffc0736213>] show_name+0x23/0x40 [uio]
[  251.180820]  RSP <ffff971e9e387dc8>
[  251.181473] CR2: 0000000000000008

CC: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
CC: Mike Christie <mchristi@redhat.com>
Reviewed-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 104 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 4441235a56cc..262610192755 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -215,7 +215,20 @@ static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct uio_device *idev =3D dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", idev->info->name);
+	int ret;
+
+	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		ret =3D -EINVAL;
+		dev_err(dev, "the device has been unregistered\n");
+		goto out;
+	}
+
+	ret =3D sprintf(buf, "%s\n", idev->info->name);
+
+out:
+	mutex_unlock(&idev->info_lock);
+	return ret;
 }
 static DEVICE_ATTR_RO(name);
=20
@@ -223,7 +236,20 @@ static ssize_t version_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct uio_device *idev =3D dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", idev->info->version);
+	int ret;
+
+	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		ret =3D -EINVAL;
+		dev_err(dev, "the device has been unregistered\n");
+		goto out;
+	}
+
+	ret =3D sprintf(buf, "%s\n", idev->info->version);
+
+out:
+	mutex_unlock(&idev->info_lock);
+	return ret;
 }
 static DEVICE_ATTR_RO(version);
=20
@@ -417,11 +443,15 @@ EXPORT_SYMBOL_GPL(uio_event_notify);
 static irqreturn_t uio_interrupt(int irq, void *dev_id)
 {
 	struct uio_device *idev =3D (struct uio_device *)dev_id;
-	irqreturn_t ret =3D idev->info->handler(irq, idev->info);
+	irqreturn_t ret;
+
+	mutex_lock(&idev->info_lock);
=20
+	ret =3D idev->info->handler(irq, idev->info);
 	if (ret =3D=3D IRQ_HANDLED)
 		uio_event_notify(idev->info);
=20
+	mutex_unlock(&idev->info_lock);
 	return ret;
 }
=20
@@ -462,6 +492,12 @@ static int uio_open(struct inode *inode, struct file *=
filep)
 	filep->private_data =3D listener;
=20
 	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		mutex_unlock(&idev->info_lock);
+		ret =3D -EINVAL;
+		goto err_alloc_listener;
+	}
+
 	if (idev->info && idev->info->open)
 		ret =3D idev->info->open(idev->info, inode);
 	mutex_unlock(&idev->info_lock);
@@ -592,6 +628,11 @@ static ssize_t uio_write(struct file *filep, const cha=
r __user *buf,
 	s32 irq_on;
=20
 	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		retval =3D -EINVAL;
+		goto out;
+	}
+
 	if (!idev->info || !idev->info->irq) {
 		retval =3D -EIO;
 		goto out;
@@ -637,10 +678,20 @@ static int uio_vma_fault(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long offset;
 	void *addr;
+	int ret =3D 0;
+	int mi;
=20
-	int mi =3D uio_find_mem_index(vmf->vma);
-	if (mi < 0)
-		return VM_FAULT_SIGBUS;
+	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	mi =3D uio_find_mem_index(vmf->vma);
+	if (mi < 0) {
+		ret =3D VM_FAULT_SIGBUS;
+		goto out;
+	}
=20
 	/*
 	 * We need to subtract mi because userspace uses offset =3D N*PAGE_SIZE
@@ -655,7 +706,11 @@ static int uio_vma_fault(struct vm_fault *vmf)
 		page =3D vmalloc_to_page(addr);
 	get_page(page);
 	vmf->page =3D page;
-	return 0;
+
+out:
+	mutex_unlock(&idev->info_lock);
+
+	return ret;
 }
=20
 static const struct vm_operations_struct uio_logical_vm_ops =3D {
@@ -680,6 +735,7 @@ static int uio_mmap_physical(struct vm_area_struct *vma=
)
 	struct uio_device *idev =3D vma->vm_private_data;
 	int mi =3D uio_find_mem_index(vma);
 	struct uio_mem *mem;
+
 	if (mi < 0)
 		return -EINVAL;
 	mem =3D idev->info->mem + mi;
@@ -721,30 +777,46 @@ static int uio_mmap(struct file *filep, struct vm_are=
a_struct *vma)
=20
 	vma->vm_private_data =3D idev;
=20
+	mutex_lock(&idev->info_lock);
+	if (!idev->info) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	mi =3D uio_find_mem_index(vma);
-	if (mi < 0)
-		return -EINVAL;
+	if (mi < 0) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	requested_pages =3D vma_pages(vma);
 	actual_pages =3D ((idev->info->mem[mi].addr & ~PAGE_MASK)
 			+ idev->info->mem[mi].size + PAGE_SIZE -1) >> PAGE_SHIFT;
-	if (requested_pages > actual_pages)
-		return -EINVAL;
+	if (requested_pages > actual_pages) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	if (idev->info->mmap) {
 		ret =3D idev->info->mmap(idev->info, vma);
-		return ret;
+		goto out;
 	}
=20
 	switch (idev->info->mem[mi].memtype) {
 		case UIO_MEM_PHYS:
-			return uio_mmap_physical(vma);
+			ret =3D uio_mmap_physical(vma);
+			break;
 		case UIO_MEM_LOGICAL:
 		case UIO_MEM_VIRTUAL:
-			return uio_mmap_logical(vma);
+			ret =3D uio_mmap_logical(vma);
+			break;
 		default:
-			return -EINVAL;
+			ret =3D -EINVAL;
 	}
+
+out:
+	mutex_unlock(&idev->info_lock);
+	return 0;
 }
=20
 static const struct file_operations uio_fops =3D {
@@ -943,12 +1015,12 @@ void uio_unregister_device(struct uio_info *info)
=20
 	uio_free_minor(idev);
=20
+	mutex_lock(&idev->info_lock);
 	uio_dev_del_attributes(idev);
=20
 	if (info->irq && info->irq !=3D UIO_IRQ_CUSTOM)
 		free_irq(info->irq, idev);
=20
-	mutex_lock(&idev->info_lock);
 	idev->info =3D NULL;
 	mutex_unlock(&idev->info_lock);
=20
--=20
2.20.1

