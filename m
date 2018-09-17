Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F53208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OligyUzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F53208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeIQImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:42:46 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730112AbeIQIbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll113tge4coHlIlNtiLkqJFVxwsItmtG+m09u+YQNT8=;
 b=OligyUzTMWFkS4BA5ySkzazFj2zco7R5oG9sG77cyCOxNTnnd3arNIMROlcrX4k1rkaqS+hJQ77tNJmUsiAZ642/N5sCL20Lj/P6p5X3G0g1EeIM0i8q0+G0fo3NiXtX9b8gVq2efFx/QnqUWQ2Tg4hVD7Kpp8sijtD1fAw4iX8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/57] power: remove possible deadlock when
 unregistering power_supply
Thread-Topic: [PATCH AUTOSEL 4.9 13/57] power: remove possible deadlock when
 unregistering power_supply
Thread-Index: AQHUTjMPy6g/F5oZKEO5a1Y3Jj/uwQ==
Date:   Mon, 17 Sep 2018 03:03:51 +0000
Message-ID: <20180917030340.378-13-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:bGexYzqZ4zEya4Glts9fbnulKyHOo7wp277zeTzmFsSmG9LTzaGk5/CXbbbcHd3B+Tdm20gMRN971x7qmoeg/JonS7ahwXWKHsWKUVH7Lb9+p6mtl/z+ioEm0Uyh1Fgc7UNtnOOsN67/ezDnGCxjkjNbosRbgjmsqAl3EDinCDQmywquF819hrJwkexKVxauZaAgz2ISBShZKEIeyd9N9iFkYrzntHe+QzpWlUjrkMH4QkZI2dquQCFFXd3A1NgGkc8eApww0SoAafkEtiF35N6ZYUVdIoNkXUhxFqM+aNJa+tbXylaHl79Sc9ozHosJdNUtk0gC228tBJ7FYurMv3c1CDqy0/yHzzAZnaPBchxblaTSUMwFIBjqMyxkTXhU+XH0/2fcR5m+rQAccXvjcvpB4LC1O+H6p8AQ4ETL/we2bvIhNcsQscWbo010zB0N8KGfNVXXSM2a17oYJFvqiw==;5:6BajzXrYyrD6QYpbjV218rruoe/3hNurQIRKHmFUSfgO9LhvEXEKo0a1c8sqJ2jGp+0Fsmhmcn3iFLn3JIt9dfhGMVC8VvuTrwDGfi2lj1Wy/QBFDRfIEgj0hZslSZHtAvDRCeG2zBwR/5PIYvLEiSd0WmLa1bYO0T2JPc/+oMQ=;7:5s0V+LluTy0H7rv0MSOJPbrsNywJ82vTJkuUsZAuqbwKfXVKpoqCtcjwiHFVGvZWr8gXPDtuUAERUblBpuRkR/3x74rNiL/cY/8kVp8P+Gc4fYfb0a+lIRGU8fCStPxWFOli5kxFYFHsfSg2Rtcn9YLGSUrjP55SdOkLq0C3BR29YEwL3zN2woewo26fKtBn6SvWeApzO8v8WRWjKl7l4bP3ZUQ3oklb2o+e0kKtAtfxIIBwtt6vYEKRPM1whr7E
x-ms-office365-filtering-correlation-id: f53ae573-fd72-44b2-13b2-08d61c4a72d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120160723418762D512D18CFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(262661675992038)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(51234002)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qoxnQzXVaOlsfhrjN57x/LH2uWOkw4J+2h9LWQpjYE8CCGu/qQCrJnXafeYg3X5UAhBwOcVMSGw9OJMx0vulDk0P4JJIiGKQWwqcs0RuRpWbtfqousLStGF01AJhSeHByf9by8YMWp//Bul7J372hvN+JEsa8ON0meOgVbY6ynSdI41bOg1UoYDYIlE1PfYSPoNPfDgoHNiQWxC1osgWOaeCfscG2Dm2oC8Sm2Oltrcyi8YCH7zNrh9/dlplD2sjZtjicaajsNLcTQQW/N+rI3qCrNbxMSf7Y0PVrirDSQUX5jBHutAozYY4hr7lYslX7UfZ7LMGoepyOtDP7KZfG7Ac91T4AFN+7UfSM+scIBU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ae573-fd72-44b2-13b2-08d61c4a72d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:51.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 3ffa6583e24e1ad1abab836d24bfc9d2308074e5 ]

If a device gets removed right after having registered a power_supply node,
we might enter in a deadlock between the remove call (that has a lock on
the parent device) and the deferred register work.

Allow the deferred register work to exit without taking the lock when
we are in the remove state.

Stack trace on a Ubuntu 16.04:

[16072.109121] INFO: task kworker/u16:2:1180 blocked for more than 120 seco=
nds.
[16072.109127]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
[16072.109129] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[16072.109132] kworker/u16:2   D    0  1180      2 0x80000000
[16072.109142] Workqueue: events_power_efficient power_supply_deferred_regi=
ster_work
[16072.109144] Call Trace:
[16072.109152]  __schedule+0x3d6/0x8b0
[16072.109155]  schedule+0x36/0x80
[16072.109158]  schedule_preempt_disabled+0xe/0x10
[16072.109161]  __mutex_lock.isra.2+0x2ab/0x4e0
[16072.109166]  __mutex_lock_slowpath+0x13/0x20
[16072.109168]  ? __mutex_lock_slowpath+0x13/0x20
[16072.109171]  mutex_lock+0x2f/0x40
[16072.109174]  power_supply_deferred_register_work+0x2b/0x50
[16072.109179]  process_one_work+0x15b/0x410
[16072.109182]  worker_thread+0x4b/0x460
[16072.109186]  kthread+0x10c/0x140
[16072.109189]  ? process_one_work+0x410/0x410
[16072.109191]  ? kthread_create_on_node+0x70/0x70
[16072.109194]  ret_from_fork+0x35/0x40
[16072.109199] INFO: task test:2257 blocked for more than 120 seconds.
[16072.109202]       Not tainted 4.13.0-41-generic #46~16.04.1-Ubuntu
[16072.109204] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[16072.109206] test            D    0  2257   2256 0x00000004
[16072.109208] Call Trace:
[16072.109211]  __schedule+0x3d6/0x8b0
[16072.109215]  schedule+0x36/0x80
[16072.109218]  schedule_timeout+0x1f3/0x360
[16072.109221]  ? check_preempt_curr+0x5a/0xa0
[16072.109224]  ? ttwu_do_wakeup+0x1e/0x150
[16072.109227]  wait_for_completion+0xb4/0x140
[16072.109230]  ? wait_for_completion+0xb4/0x140
[16072.109233]  ? wake_up_q+0x70/0x70
[16072.109236]  flush_work+0x129/0x1e0
[16072.109240]  ? worker_detach_from_pool+0xb0/0xb0
[16072.109243]  __cancel_work_timer+0x10f/0x190
[16072.109247]  ? device_del+0x264/0x310
[16072.109250]  ? __wake_up+0x44/0x50
[16072.109253]  cancel_delayed_work_sync+0x13/0x20
[16072.109257]  power_supply_unregister+0x37/0xb0
[16072.109260]  devm_power_supply_release+0x11/0x20
[16072.109263]  release_nodes+0x110/0x200
[16072.109266]  devres_release_group+0x7c/0xb0
[16072.109274]  wacom_remove+0xc2/0x110 [wacom]
[16072.109279]  hid_device_remove+0x6e/0xd0 [hid]
[16072.109284]  device_release_driver_internal+0x158/0x210
[16072.109288]  device_release_driver+0x12/0x20
[16072.109291]  bus_remove_device+0xec/0x160
[16072.109293]  device_del+0x1de/0x310
[16072.109298]  hid_destroy_device+0x27/0x60 [hid]
[16072.109303]  usbhid_disconnect+0x51/0x70 [usbhid]
[16072.109308]  usb_unbind_interface+0x77/0x270
[16072.109311]  device_release_driver_internal+0x158/0x210
[16072.109315]  device_release_driver+0x12/0x20
[16072.109318]  usb_driver_release_interface+0x77/0x80
[16072.109321]  proc_ioctl+0x20f/0x250
[16072.109325]  usbdev_do_ioctl+0x57f/0x1140
[16072.109327]  ? __wake_up+0x44/0x50
[16072.109331]  usbdev_ioctl+0xe/0x20
[16072.109336]  do_vfs_ioctl+0xa4/0x600
[16072.109339]  ? vfs_write+0x15a/0x1b0
[16072.109343]  SyS_ioctl+0x79/0x90
[16072.109347]  entry_SYSCALL_64_fastpath+0x24/0xab
[16072.109349] RIP: 0033:0x7f20da807f47
[16072.109351] RSP: 002b:00007ffc422ae398 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[16072.109353] RAX: ffffffffffffffda RBX: 00000000010b8560 RCX: 00007f20da8=
07f47
[16072.109355] RDX: 00007ffc422ae3a0 RSI: 00000000c0105512 RDI: 00000000000=
00009
[16072.109356] RBP: 0000000000000000 R08: 00007ffc422ae3e0 R09: 00000000000=
00010
[16072.109357] R10: 00000000000000a6 R11: 0000000000000246 R12: 00000000000=
00000
[16072.109359] R13: 00000000010b8560 R14: 00007ffc422ae2e0 R15: 00000000000=
00000

Reported-and-tested-by: Richard Hughes <rhughes@redhat.com>
Tested-by: Aaron Skomra <Aaron.Skomra@wacom.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Fixes: 7f1a57fdd6cb ("power_supply: Fix possible NULL pointer dereference o=
n early uevent")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/power_supply_core.c | 11 +++++++++--
 include/linux/power_supply.h             |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/suppl=
y/power_supply_core.c
index a74d8ca383a1..9e05ae0430a9 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
@@ -138,8 +139,13 @@ static void power_supply_deferred_register_work(struct=
 work_struct *work)
 	struct power_supply *psy =3D container_of(work, struct power_supply,
 						deferred_register_work.work);
=20
-	if (psy->dev.parent)
-		mutex_lock(&psy->dev.parent->mutex);
+	if (psy->dev.parent) {
+		while (!mutex_trylock(&psy->dev.parent->mutex)) {
+			if (psy->removing)
+				return;
+			msleep(10);
+		}
+	}
=20
 	power_supply_changed(psy);
=20
@@ -944,6 +950,7 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register_no_ws);
 void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
+	psy->removing =3D true;
 	cancel_work_sync(&psy->changed_work);
 	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3965503315ef..ad97baf7b8de 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -249,6 +249,7 @@ struct power_supply {
 	spinlock_t changed_lock;
 	bool changed;
 	bool initialized;
+	bool removing;
 	atomic_t use_cnt;
 #ifdef CONFIG_THERMAL
 	struct thermal_zone_device *tzd;
--=20
2.17.1
