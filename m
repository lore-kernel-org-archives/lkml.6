Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LpQJx60P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3124A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeIQI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:39 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbeIQI0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQkSUoR+mLvIuY9D0D1Qhim4iFp5RoV12a/EJDhr+/A=;
 b=LpQJx60PNnFVRtQ73vEuohxAeC8N31SJ3tXloqs6/V2TnI5MiRPBPv4yFkHk+WcBq/0EYlL1nyolZSjIgxYUTkM/XMZ9oL4rgtKWAUKuQNk6SaYWz72uy7PA3aNsCzhY0BPL+U5swQlLpfVWhwD/l5AMo8dRluyJs2JdTCEWxBY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 051/136] scsi: target: Avoid that EXTENDED COPY
 commands trigger lock inversion
Thread-Topic: [PATCH AUTOSEL 4.18 051/136] scsi: target: Avoid that EXTENDED
 COPY commands trigger lock inversion
Thread-Index: AQHUTjKgI6QKzwOO9kyjkVIkm0od+g==
Date:   Mon, 17 Sep 2018 03:00:44 +0000
Message-ID: <20180917030006.245495-51-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:Yd70BBjLTlv1ayZ0+6PH3Y1F8+/oqf9Q0gjmityl62Lk7hS292BsvO4neuaTAQRToPaq62fXyXb0UBYgYSIICEQG3VPs4pZuK8UUXx4iqc0qqAJt9gVLZU3usLgWRRfe7O6u4V8hg30w5c32r+sUC6tvlXDSIgJmRid0cZcd2ik9mBAfLJ0dUi8o/w6GRBo5Bd34+SSQjxsg9xxMCKOgcopKYGcZ9Wssxbo76dVptDzVfAlj6gzq3ZXlcXXw3/iZfSzyILAHXSE7nyD0S/jeH3WEZOOu/l4viyr+QWSvj08RUu8wKVK0E0CcbQqI0qJB6OQNRaVYpJF6qOc2xWOTn84SiodS4roauw5+3muiTFtBExGX3V6PFu8sIsgmr+fxWTNURGGET8s/wdSLWDAxClgHqvSTgx/SiFHsX/UxMF1zfvFVqfZ1y3ochY9yoLGukpZ3iM6XiWDDFFbVh604gw==;5:EHVPw6KWjgpx0L7POPX/rYSvFAFmvC+tCGmnzozjAPzlY5gaIMKvxaffZJHR8Kn7FmKlD4p3acSYMRlOnNsZt7lDKjnD/4yL/EC+qcUgkk0x4NVhin9K5V8LB9dh+KMx7jGkerW5Ov9F7WNZGRLzQAfj22eslNhOW7/dSDcdPoA=;7:3WIsEE5+EKi28X2OMZ8Fefhc8g0ZNYesasP8vJXeRNXXTSH3eFyiFa4/M3ewwB4c/WtTm4i9YUiMAMSO0Dgl4KYJgyQtbHOeyXdLDGyqjcsoRyfKBRRETIfHn5eqIfsEJJ6RGdoyyFkgCs6BBp+6Fh3uPXkVZixXZibfQtGB8zslcb2n2Re+nGO4uDasAHgn5luBe5OjkmCGA4dkE0G+kZ91J3D8vCEwDb+k0O6G/TkNwHtcoSSLoN/tyrWtqdvC
x-ms-office365-filtering-correlation-id: abd425ad-92d3-4932-a178-08d61c49d3e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167A3FD4CE9DFF2EB549308FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: HS/6xvBHiCwh4NPOr33CtSpaBb6bGtEprkQfWF2gTwWNUHXvctT6a703tfCp5J/59d119Jp5MxvwPGOq2v0QwXSg/Yhykoubi1m2Fwcf4Jd6nD5AM6yXSDTUc6gzj00ncJ56CV0hcv8rXt3aK1XSOHK9CzL8OFmzL+47WF62p151Hkxkx+fE6VKKqyqbiPeKYQ2d12Y0KqFYGf9b2Efw0RLsTUXS6rZZynsxB7yfoJtg7qYRF75F/lcUEhoWmnUkQ/hwHRJIEenkW6BJAcQ4Vp/rY4Bba6DKhzfRjRGyL5M6IpXWqo0WMQ/byU61YwsxK4l7uU5EQmvgH8MaasHlXgFoc+gbbMZ7b3SMv/s4unc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd425ad-92d3-4932-a178-08d61c49d3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:44.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index e27db4d45a9d..06c9886e556c 100644
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
