Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A4DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89282222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="HmWss74I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404423AbfBMQ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:54 -0500
Received: from mail-eopbgr10091.outbound.protection.outlook.com ([40.107.1.91]:36831
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404338AbfBMQ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6Z2PBv/Thlq6+RXJMzOdemJPApjfpjrgWnJIuuCm8w=;
 b=HmWss74IkpOtK1xVrIJUwWY0a0tJ4BXXnLIuEiKfSd4S+jSEXkgHEE2lhHA5PFJRPZ2rmhyncCxLjIaMRF9nt9AvWxvtdODnbK1KSaosuyfKlRTz1gAQI/sME3zQrHcGX2h9rLZWQDGdwYJ8OMfs0Gk7ZUctpL4lf35cbfs10uk=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:37 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:37 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 7/8] uio: fix possible circular locking dependency
Thread-Topic: [PATCH 4.14 7/8] uio: fix possible circular locking dependency
Thread-Index: AQHUw7lPUDJsQc0NOUOhIxr9MeZ5Fw==
Date:   Wed, 13 Feb 2019 16:29:36 +0000
Message-ID: <20190213162845.11688-8-tommi.t.rantala@nokia.com>
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
x-ms-office365-filtering-correlation-id: 60b5ba7c-61bf-49ed-3f34-08d691d071c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:7i+X4anN7ysDMcaET9hFVLAs1MPQapeOT3E7B?=
 =?iso-8859-1?Q?L+wjCryHvCbu/2UOhkSJoPgf6UlNdIU7Gf1UpG5qB0+4IrjwmX8XDP5Kqr?=
 =?iso-8859-1?Q?WYlAKs63ytBbGGuPm4o060To7MXSaAe9owiC11X8kBP9PR2fSLCotamucd?=
 =?iso-8859-1?Q?r4H+FYWiPeo4cbUtoc07el3bvZgRg+oTBOc5Au7yjPrJejv6C3NeIuO4Pb?=
 =?iso-8859-1?Q?/64xeJMjThYtU5EhAaX//TXEqkxnD2pklAM5vCVUtK4CoqKWm7pRiueaIU?=
 =?iso-8859-1?Q?AYhgnPVlIRjJ+rKo1+RSRcbixgQfqcZzoSNtZvKpbv1o3t/zFc8t8M+uIk?=
 =?iso-8859-1?Q?DG+UMXnKmHM9gxJ22cI0M6ss2yCZvoCY/c/9kkdzwHXCBoQzdIgogNaxg5?=
 =?iso-8859-1?Q?o0SerdYe5lECWvjiftwN2sjOGQsDLjPP0QB4bnX08Nf2F9btFPkXc7xb2S?=
 =?iso-8859-1?Q?Q/r/382DwPCI9WESR/FtuApF+adbkectV7E9w31OzIT/sV+4mEOtNXMAU+?=
 =?iso-8859-1?Q?xcbwYdTWwOScq4zpYIcoNJHvs+NZRj92deXCOut9yY8hzUXkqmfv6jI07V?=
 =?iso-8859-1?Q?wecPEuuYfgODmXr0GEXC7HjjZiXHaO2JCw2e3jP92vOT+HQKLbucBE+n9a?=
 =?iso-8859-1?Q?GbQ3RmH+N5Ag+wnWMqThbE1xGh+2oTMuwCjto2B+bZukQswXp19zNfvXvg?=
 =?iso-8859-1?Q?W/jyPrVfVAhnTRn1vhdlozM2/0BKTtQBvh0neZP6WDD1SZEZjWFEcM+8P2?=
 =?iso-8859-1?Q?QlrSsB8bJKAoiYzxqpI0hC5zsWaP+UnzRbVAy7ntQiSDXUvFM6JMOZvR7R?=
 =?iso-8859-1?Q?e/EBZ6C/1/aRffWdNb69AL5LYq5xh3FqYo6zxMmFJIsHrpTOMG9RBhuxYe?=
 =?iso-8859-1?Q?aMdufZNV3VXMRkBKoLJLlyOJ4r4nRgT326c+TUv7Z4u6hFkB2dsaq3JX77?=
 =?iso-8859-1?Q?uPBNVkqdt4L87UUEGDCquEm/9pY/0cw5VyuGy+cGxp8PcEpXZwm/IhKuZN?=
 =?iso-8859-1?Q?wc4P0su30o4tq+YeAViPfGlo1olA1EUvu1UGlPOMaqlLENk6jHl7JcSU8w?=
 =?iso-8859-1?Q?aWN+J+o/+AkPQOGOnx4W74YjPZmuJRW1EIK6C3Hm8mLR4Kjza2RHh3c9lE?=
 =?iso-8859-1?Q?W2blxcWO/ECXlKJs0UgRh0YdIvcI8vHJanUtFqEeTHvjLX+P2//yEEMgXa?=
 =?iso-8859-1?Q?E7EM7eAUxS/Shqme/Tp7NmKtzUPoClUuHIfWlisC9U2Y3CEnMUtQ82zfCt?=
 =?iso-8859-1?Q?mlSFwGx7ZYjQp3giLcNwXclF7AkPsl8V0zRdYGh0nOiuqL3tOR8sbEHKBm?=
 =?iso-8859-1?Q?wzLqS3XOKsjFp4BL/YtErjt7DseP2DQtNhZxet01/72jwneu6LOIWah9KH?=
 =?iso-8859-1?Q?i+7xatVQbkC/X2CZ++I2dzQwrwd7AXaazAL5E1C7Xfv6j6I5NOqJg=3D?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721F747F0F2FE134AD7A99BB4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AoaDEsyKmezkyBpdOVQFd3VmnO+oxQavUOsQCTeMcOalvwz2KPkI0LMlZBsSgBoyXTKtJBk5HxfZAgeGGvjrflEElVhQi4DvPQReyGspe6SBq1u19dfIomMKAAD3yw4W7jonAoPxZH7pIjKq3IYwALha04CnzB9rUM06Qe3pbBHxx9qJXSBl+l6+uvBX9gkjSvnomOb/BVyBHYDA6rxGQ2M19cJsjiPVA43CeeCeFuR+SqhgqiVxz1erF+ka1Fk8/+B8StOEplvlQlM7fKS4iCVCtN7pdQB4NmEjRIKkEqCvyvv2ssUIHDxDMPME9CbMs7YRxKTRIihBP9KJnbdSjGCD5999cA9c+JgA0k/nhQhIW4hFwl2jgcGg6+231a3E4To3MeLxzpAKNcR2bN3jMYFwrh2d9H/44nIitqnx0Nk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b5ba7c-61bf-49ed-3f34-08d691d071c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:36.5705
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

commit b34e9a15b37b8ddbf06a4da142b0c39c74211eb4 upstream.

The call trace:
XXX/1910 is trying to acquire lock:
 (&mm->mmap_sem){++++++}, at: [<ffffffff97008c87>] might_fault+0x57/0xb0

but task is already holding lock:
 (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0x130 =
[uio]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&idev->info_lock){+.+...}:
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff975edad3>] mutex_lock_nested+0x93/0x410
       [<ffffffffc063873d>] uio_mmap+0x2d/0x170 [uio]
       [<ffffffff97016b58>] mmap_region+0x428/0x650
       [<ffffffff97017138>] do_mmap+0x3b8/0x4e0
       [<ffffffff96ffaba3>] vm_mmap_pgoff+0xd3/0x120
       [<ffffffff97015261>] SyS_mmap_pgoff+0x1f1/0x270
       [<ffffffff96e387c2>] SyS_mmap+0x22/0x30
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

-> #0 (&mm->mmap_sem){++++++}:
       [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
       [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
       [<ffffffff97008cb4>] might_fault+0x84/0xb0
       [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
       [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
       [<ffffffff97070e2a>] SyS_write+0x8a/0x100
       [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&idev->info_lock);
                               lock(&mm->mmap_sem);
                               lock(&idev->info_lock);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***
1 lock held by XXX/1910:
 #0:  (&idev->info_lock){+.+...}, at: [<ffffffffc0638a06>] uio_write+0x46/0=
x130 [uio]

stack backtrace:
CPU: 0 PID: 1910 Comm: XXX Kdump: loaded Not tainted #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference=
 Platform, BIOS 6.00 05/19/2017
Call Trace:
 [<ffffffff975e9211>] dump_stack+0x19/0x1b
 [<ffffffff975e260a>] print_circular_bug+0x1f9/0x207
 [<ffffffff96f2f6a7>] check_prevs_add+0x957/0x960
 [<ffffffff96f30e9c>] __lock_acquire+0xdac/0x15f0
 [<ffffffff96f2fb19>] ? mark_held_locks+0xb9/0x140
 [<ffffffff96f31fc9>] lock_acquire+0x99/0x1e0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffff97008cb4>] might_fault+0x84/0xb0
 [<ffffffff97008c87>] ? might_fault+0x57/0xb0
 [<ffffffffc0638a74>] uio_write+0xb4/0x130 [uio]
 [<ffffffff9706ffa3>] vfs_write+0xc3/0x1f0
 [<ffffffff9709349c>] ? fget_light+0xfc/0x510
 [<ffffffff97070e2a>] SyS_write+0x8a/0x100
 [<ffffffff975ff315>] system_call_fastpath+0x1c/0x21

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fed2d8fa4d4d..4e0cb7cdf739 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -627,6 +627,12 @@ static ssize_t uio_write(struct file *filep, const cha=
r __user *buf,
 	ssize_t retval;
 	s32 irq_on;
=20
+	if (count !=3D sizeof(s32))
+		return -EINVAL;
+
+	if (copy_from_user(&irq_on, buf, count))
+		return -EFAULT;
+
 	mutex_lock(&idev->info_lock);
 	if (!idev->info) {
 		retval =3D -EINVAL;
@@ -638,21 +644,11 @@ static ssize_t uio_write(struct file *filep, const ch=
ar __user *buf,
 		goto out;
 	}
=20
-	if (count !=3D sizeof(s32)) {
-		retval =3D -EINVAL;
-		goto out;
-	}
-
 	if (!idev->info->irqcontrol) {
 		retval =3D -ENOSYS;
 		goto out;
 	}
=20
-	if (copy_from_user(&irq_on, buf, count)) {
-		retval =3D -EFAULT;
-		goto out;
-	}
-
 	retval =3D idev->info->irqcontrol(idev->info, irq_on);
=20
 out:
--=20
2.20.1

