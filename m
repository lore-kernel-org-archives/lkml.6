Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DEAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC3208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JjjLOOo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEC3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeIQIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:52 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728972AbeIQI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ38m8YbC2u0t/Ycg7OQVGYorLhedLmxGziUGEWMYwQ=;
 b=JjjLOOo8ijNtfdKU3PPkg8jSK6SQbfHXKdzuodwN54KOstNGRaT5QL9LSjipZsaYKK0JAvEzRsSN5yHZ1k8SD08ocjsPjx1dY0VDTXDNuG5HsZtX9DpW6kShG8DeCFIwj+CLbAVfrto5ac7zJIJ9CpiIlST/GJ13gyK5L/Og0/4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 37/87] scsi: target: Avoid that EXTENDED COPY
 commands trigger lock inversion
Thread-Topic: [PATCH AUTOSEL 4.14 37/87] scsi: target: Avoid that EXTENDED
 COPY commands trigger lock inversion
Thread-Index: AQHUTjLp5iYyAlzDIUuoocgvpefuBw==
Date:   Mon, 17 Sep 2018 03:02:47 +0000
Message-ID: <20180917030220.245686-37-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:Y+SWDs/X3c/lk/1k+7xnEl72IsypGKrDdi8HORw+P9s0Ha4QWG2LJgUu/8iCD5rwXZpFC2C0wgduuYaTRMZNHQByDibEZwu0OwXJ49f3o/DsFr9RR3bcEixPtBc5s9yRJmkFhKl32nn6wPdGleqACCsnOAyEy24I4/REHQYIAUyVuDF4QPHzTouxfMBmm4EdtmSckAK+jyckmsxdbV+yr3kkj+VTjJezkZyi0U+Ogj3EoLsCEsQfjrfsLrcIqZJyVI8gFQjlVJk7LqbdGMZ0LkrT4lapVo1b+eFszpg1+MicAkurjQ7wU7Y2/XwgQ/9IKdhm1INS+1sLlCoNv/QuotYVEzHyZvfOLAns5wXl26iTAHmYhG3SePLdqokoRKCW9NhpNTGUmnwdhbkmJuBFkfanG1Dbqeh8ZJffdymD4K4xgcwqlV3OAtLXpFHtuLnH2JG0V0lyK6J3aotXnp9MVg==;5:ikjlhgGGB60VCNAIDvkFjzEEHWaOY9Rz43oNZ4y2MK8yMw4TRNmlhs55pfMcTRgZ/FvUpBe83Znc4ireHTN+wLdyROAjLt4cH17k8GTVLrEfDRVkr1dpoWJV/toJ9D2Kxa8yPDlxATWKAnhSL9f3AyiCFpXqwRb0Or5PTppEcWk=;7:2OH2I8QwLEwajwAD3mBPSIlCfH//CVO39q1CUJBR2QUn1D67TTFsIBXXdKER1wRn1IFuScMNcpoGSrIpuEw5OBfEFckhloUDPhkEQYrVDv95x7HRm0DWUxfw/bxXuUnqnsTrmBa+ziXf6LnG5IoJm+hzN3J2VB0MvXbJY6LLhf7eg2xMUb6rNpCwLqith34JOeFZXAQ5wGYpfrr+H0icLoZCRIprGVuOH9Mj46UaMpzKbuaiGn6TrgskNRy1Dt49
x-ms-office365-filtering-correlation-id: b6ed7dfa-23be-41bd-2f18-08d61c4a3f7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776A8F726F57CAA1BE6E0E8FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +b7aCQq0Q1YA9xoUbIQq1+0+CzAMBJZJP0bz0wD3KBjMFB/4d8C90KCEFbQiTOb7zw5NV5uIPzALlG0WCQ84Qvq7BNYNHbWwicFkADRI2atqYTn0mA/JaaaHnQDxzdjxnlESq8wnnE3rIE5Xv87AgRU3K1h0hCPxZHUJ1TLoYzVk/31d87Vf7L7nbvTTAyXzvJvaZJGJXITzrcxKX8Y/OtOzZV2UKOYU0Jn+BRuE+98trzWWvf4ySfyJ9CHJyBrP3QfaUr2i/lUZ1OP6ZZHGjDZ2nb+m0wQSZB93pIg/7b8P3/QWMBrJ8p+ZXfGzFbkJoUNWkt28CzBM28SzeOOhBSuBB1pThdTk6r1CJgnNO+4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ed7dfa-23be-41bd-2f18-08d61c4a3f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:47.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 36d4cb460bcbe2a1323732a6e4bb9dd783284368 ]

The approach for adding a device to the devices_idr data structure and for
removing it is as follows:

* &dev->dev_group.cg_item is initialized before a device is added to
  devices_idr.

* If the reference count of a device drops to zero then
  target_free_device() removes the device from devices_idr.

* All devices_idr manipulations are protected by device_mutex.

This means that increasing the reference count of a device is sufficient to
prevent removal from devices_idr and also that it is safe access
dev_group.cg_item for any device that is referenced by devices_idr. Use
this to modify target_find_device() and target_for_each_device() such that
these functions no longer introduce a dependency between device_mutex and
the configfs root inode mutex.

Note: it is safe to pass a NULL pointer to config_item_put() and also to
config_item_get_unless_zero().

This patch prevents that lockdep reports the following complaint:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
4.12.0-rc1-dbg+ #1 Not tainted
------------------------------------------------------
rmdir/12053 is trying to acquire lock:
 (device_mutex#2){+.+.+.}, at: [<ffffffffa010afce>]
target_free_device+0xae/0xf0 [target_core_mod]

but task is already holding lock:
 (&sb->s_type->i_mutex_key#14){++++++}, at: [<ffffffff811c5c30>]
vfs_rmdir+0x50/0x140

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#14){++++++}:
       lock_acquire+0x59/0x80
       down_write+0x36/0x70
       configfs_depend_item+0x3a/0xb0 [configfs]
       target_depend_item+0x13/0x20 [target_core_mod]
       target_xcopy_locate_se_dev_e4_iter+0x87/0x100 [target_core_mod]
       target_devices_idr_iter+0x16/0x20 [target_core_mod]
       idr_for_each+0x39/0xc0
       target_for_each_device+0x36/0x50 [target_core_mod]
       target_xcopy_locate_se_dev_e4+0x28/0x80 [target_core_mod]
       target_xcopy_do_work+0x2e9/0xdd0 [target_core_mod]
       process_one_work+0x1ca/0x3f0
       worker_thread+0x49/0x3b0
       kthread+0x109/0x140
       ret_from_fork+0x31/0x40

-> #0 (device_mutex#2){+.+.+.}:
       __lock_acquire+0x101f/0x11d0
       lock_acquire+0x59/0x80
       __mutex_lock+0x7e/0x950
       mutex_lock_nested+0x16/0x20
       target_free_device+0xae/0xf0 [target_core_mod]
       target_core_dev_release+0x10/0x20 [target_core_mod]
       config_item_put+0x6e/0xb0 [configfs]
       configfs_rmdir+0x1a6/0x300 [configfs]
       vfs_rmdir+0xb7/0x140
       do_rmdir+0x1f4/0x200
       SyS_rmdir+0x11/0x20
       entry_SYSCALL_64_fastpath+0x23/0xc2

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#14);
                               lock(device_mutex#2);
                               lock(&sb->s_type->i_mutex_key#14);
  lock(device_mutex#2);

 *** DEADLOCK ***

3 locks held by rmdir/12053:
 #0:  (sb_writers#10){.+.+.+}, at: [<ffffffff811e223f>]
mnt_want_write+0x1f/0x50
 #1:  (&sb->s_type->i_mutex_key#14/1){+.+.+.}, at: [<ffffffff811cb97e>]
do_rmdir+0x15e/0x200
 #2:  (&sb->s_type->i_mutex_key#14){++++++}, at: [<ffffffff811c5c30>]
vfs_rmdir+0x50/0x140

stack backtrace:
CPU: 3 PID: 12053 Comm: rmdir Not tainted 4.12.0-rc1-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 dump_stack+0x86/0xcf
 print_circular_bug+0x1c7/0x220
 __lock_acquire+0x101f/0x11d0
 lock_acquire+0x59/0x80
 __mutex_lock+0x7e/0x950
 mutex_lock_nested+0x16/0x20
 target_free_device+0xae/0xf0 [target_core_mod]
 target_core_dev_release+0x10/0x20 [target_core_mod]
 config_item_put+0x6e/0xb0 [configfs]
 configfs_rmdir+0x1a6/0x300 [configfs]
 vfs_rmdir+0xb7/0x140
 do_rmdir+0x1f4/0x200
 SyS_rmdir+0x11/0x20
 entry_SYSCALL_64_fastpath+0x23/0xc2

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
[Rebased to handle conflict withe target_find_device removal]
Signed-off-by: Mike Christie <mchristi@redhat.com>

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_device.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_co=
re_device.c
index e8dd6da164b2..84742125f773 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -904,14 +904,20 @@ struct se_device *target_find_device(int id, bool do_=
depend)
 EXPORT_SYMBOL(target_find_device);
=20
 struct devices_idr_iter {
+	struct config_item *prev_item;
 	int (*fn)(struct se_device *dev, void *data);
 	void *data;
 };
=20
 static int target_devices_idr_iter(int id, void *p, void *data)
+	 __must_hold(&device_mutex)
 {
 	struct devices_idr_iter *iter =3D data;
 	struct se_device *dev =3D p;
+	int ret;
+
+	config_item_put(iter->prev_item);
+	iter->prev_item =3D NULL;
=20
 	/*
 	 * We add the device early to the idr, so it can be used
@@ -922,7 +928,15 @@ static int target_devices_idr_iter(int id, void *p, vo=
id *data)
 	if (!(dev->dev_flags & DF_CONFIGURED))
 		return 0;
=20
-	return iter->fn(dev, iter->data);
+	iter->prev_item =3D config_item_get_unless_zero(&dev->dev_group.cg_item);
+	if (!iter->prev_item)
+		return 0;
+	mutex_unlock(&device_mutex);
+
+	ret =3D iter->fn(dev, iter->data);
+
+	mutex_lock(&device_mutex);
+	return ret;
 }
=20
 /**
@@ -936,15 +950,13 @@ static int target_devices_idr_iter(int id, void *p, v=
oid *data)
 int target_for_each_device(int (*fn)(struct se_device *dev, void *data),
 			   void *data)
 {
-	struct devices_idr_iter iter;
+	struct devices_idr_iter iter =3D { .fn =3D fn, .data =3D data };
 	int ret;
=20
-	iter.fn =3D fn;
-	iter.data =3D data;
-
 	mutex_lock(&device_mutex);
 	ret =3D idr_for_each(&devices_idr, target_devices_idr_iter, &iter);
 	mutex_unlock(&device_mutex);
+	config_item_put(iter.prev_item);
 	return ret;
 }
=20
--=20
2.17.1
