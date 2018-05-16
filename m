Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbeEPUAr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:00:47 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:53612 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750778AbeEPUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:00:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GnAABrWvZah2Oa6ERRChoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGEFoEJKAqLbIxwgwhfklaBeAuEbIMMITQYAQIBAQEBAQECAQECEAE?=
 =?us-ascii?q?BAQoLCQgoL4I1IoMUPxIBPmgBBA4FCIMbggGtZ4hXgieIJYITg2yEdjKFTQKYM?=
 =?us-ascii?q?gcCgTmNEIxzgiuDSIpqgSUcggtwgxOCIA4JjhdvjjYEgSqBGAEB?=
X-IPAS-Result: =?us-ascii?q?A2GnAABrWvZah2Oa6ERRChoBAQEBAQIBAQEBCAEBAQGEFoE?=
 =?us-ascii?q?JKAqLbIxwgwhfklaBeAuEbIMMITQYAQIBAQEBAQECAQECEAEBAQoLCQgoL4I1I?=
 =?us-ascii?q?oMUPxIBPmgBBA4FCIMbggGtZ4hXgieIJYITg2yEdjKFTQKYMgcCgTmNEIxzgiu?=
 =?us-ascii?q?DSIpqgSUcggtwgxOCIA4JjhdvjjYEgSqBGAEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.49,407,1520917200";
   d="scan'208";a="189048288"
X-DLP: DLP_GlobalPCIDSS
To: <linux-input@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: Sometimes unusable i2c-hid devices in 4.17-rcX
Thread-Topic: Sometimes unusable i2c-hid devices in 4.17-rcX
Thread-Index: AdPtUHPJyKWX8uzJSz64ldcK7U9jWw==
Date: Wed, 16 May 2018 20:00:16 +0000
Message-ID: <33968d382800467bb71d1733f2f2fd58@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GK0pgD000989

Hi All,

I've been running 4.16-rc7 on an XPS 9365 for some time and recently moved up to 4.17-rc5.
Immediately I noticed that i2c-hid devices (both touchscreen and touchpad) were not working.
Also when shutting the system down or rebooting it would just hang. (magic sysrq still worked).

I figured it was an easy to identify regression so I started a bisect but it came up with garbage
that ended in selftests shortly after 4.17-rc2.  I realized that's because is still will fail on 4.17-rc2
occasionally, seemingly after trying something newer and warm rebooting.
So it seems like it's "worse" after 4.17-rc2 (doesn't work at all) but semi reproducible on 4.17-rc2.

Not sure if I'm chasing some initialization race, but wanted to see if anyone else was running into this
or has some ideas?

#dmesg | grep 'i2c\|hid' doesn't show any obvious errors when in this state of non functional hid stuff.
[    2.398649] i2c /dev entries driver
[    2.881651] hidraw: raw HID events driver (C) Jiri Kosina
[    3.683583] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]: enum_devices_done OK, num_hid_devices=5
[    3.701259] hid-generic 001F:8086:22D8.0001: hidraw0: <UNKNOWN> HID v2.00 Device [hid-ishtp 8086:22D8] on 
[    3.702204] hid-generic 001F:8086:22D8.0002: hidraw1: <UNKNOWN> HID v2.00 Device [hid-ishtp 8086:22D8] on 
[    3.703063] hid-generic 001F:8086:22D8.0003: hidraw2: <UNKNOWN> HID v2.00 Device [hid-ishtp 8086:22D8] on 
[    3.704276] hid-generic 001F:8086:22D8.0004: hidraw3: <UNKNOWN> HID v2.00 Device [hid-ishtp 8086:22D8] on 
[    3.704557] hid-generic 001F:8086:22D8.0005: hidraw4: <UNKNOWN> HID v2.00 Device [hid-ishtp 8086:22D8] on 
[    3.750710] psmouse serio1: synaptics: Your touchpad (PNP: DLL077a PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
[    7.030446] acpi INT33D5:00: intel-hid: created platform device
[    7.199178] i2c_hid i2c-WCOM482F:00: i2c-WCOM482F:00 supply vdd not found, using dummy regulator
[    7.246638] input: WCOM482F:00 056A:482F as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM482F:00/0018:056A:482F.0006/input/input11
[    7.246873] hid-generic 0018:056A:482F.0006: input,hidraw0: I2C HID v1.00 Mouse [WCOM482F:00 056A:482F] on i2c-WCOM482F:00
[    7.275279] i2c_hid i2c-DLL077A:01: i2c-DLL077A:01 supply vdd not found, using dummy regulator
[    7.304107] input: DLL077A:01 06CB:76AF as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL077A:01/0018:06CB:76AF.0007/input/input14
[    7.304212] hid-generic 0018:06CB:76AF.0007: input,hidraw1: I2C HID v1.00 Mouse [DLL077A:01 06CB:76AF] on i2c-DLL077A:01
[    7.657123] usbcore: registered new interface driver usbhid
[    7.657124] usbhid: USB HID core driver
[    7.722876] input: Wacom HID 482F Pen as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM482F:00/0018:056A:482F.0006/input/input15
[    7.723148] input: Wacom HID 482F Finger as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-6/i2c-WCOM482F:00/0018:056A:482F.0006/input/input16
[    7.723611] wacom 0018:056A:482F.0006: hidraw0: I2C HID v1.00 Mouse [WCOM482F:00 056A:482F] on i2c-WCOM482F:00
[    7.768275] input: DLL077A:01 06CB:76AF Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL077A:01/0018:06CB:76AF.0007/input/input19
[    7.864201] hid-multitouch 0018:06CB:76AF.0007: input,hidraw0: I2C HID v1.00 Mouse [DLL077A:01 06CB:76AF] on i2c-DLL077A:01

However in this state, I can't rmmod i2c-hid.  It just hangs the system with this trace:
[  243.033779] INFO: task kworker/u8:0:6 blocked for more than 120 seconds.
[  243.033793]       Not tainted 4.17.0-rc1+ #37
[  243.033798] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.033804] kworker/u8:0    D    0     6      2 0x80000000
[  243.033826] Workqueue: events_power_efficient power_supply_deferred_register_work
[  243.033832] Call Trace:
[  243.033850]  __schedule+0x3c2/0x890
[  243.033861]  ? __switch_to_asm+0x40/0x70
[  243.033868]  schedule+0x36/0x80
[  243.033875]  schedule_preempt_disabled+0xe/0x10
[  243.033882]  __mutex_lock.isra.4+0x2ae/0x4e0
[  243.033890]  ? __switch_to_asm+0x34/0x70
[  243.033899]  ? __switch_to_asm+0x40/0x70
[  243.033906]  ? __switch_to_asm+0x40/0x70
[  243.033914]  __mutex_lock_slowpath+0x13/0x20
[  243.033920]  ? __mutex_lock_slowpath+0x13/0x20
[  243.033927]  mutex_lock+0x2f/0x40
[  243.033933]  power_supply_deferred_register_work+0x2b/0x50
[  243.033944]  process_one_work+0x148/0x3d0
[  243.033952]  worker_thread+0x4b/0x460
[  243.033960]  kthread+0x102/0x140
[  243.033967]  ? rescuer_thread+0x380/0x380
[  243.033973]  ? kthread_associate_blkcg+0xa0/0xa0
[  243.033982]  ret_from_fork+0x35/0x40
[  243.034012] INFO: task systemd-udevd:308 blocked for more than 120 seconds.
[  243.034018]       Not tainted 4.17.0-rc1+ #37
[  243.034022] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.034027] systemd-udevd   D    0   308    279 0x80000104
[  243.034033] Call Trace:
[  243.034041]  __schedule+0x3c2/0x890
[  243.034049]  schedule+0x36/0x80
[  243.034056]  schedule_timeout+0x1e7/0x360
[  243.034066]  ? ttwu_do_activate+0x77/0x80
[  243.034074]  wait_for_completion+0xb4/0x140
[  243.034082]  ? wake_up_q+0x70/0x70
[  243.034090]  flush_work+0x12a/0x1e0
[  243.034097]  ? worker_detach_from_pool+0xb0/0xb0
[  243.034107]  __cancel_work_timer+0x112/0x190
[  243.034116]  cancel_delayed_work_sync+0x13/0x20
[  243.034122]  power_supply_unregister+0x37/0xb0
[  243.034127]  devm_power_supply_release+0x11/0x20
[  243.034135]  release_nodes+0x107/0x1f0
[  243.034147]  devres_release_group+0x7c/0xb0
[  243.034162]  wacom_remove+0xce/0x120 [wacom]
[  243.034178]  hid_device_remove+0x4d/0xa0 [hid]
[  243.034187]  device_release_driver_internal+0x155/0x220
[  243.034198]  ? __hid_bus_driver_added+0x40/0x40 [hid]
[  243.034208]  ? hid_destroy_device+0x60/0x60 [hid]
[  243.034215]  device_release_driver+0x12/0x20
[  243.034221]  device_reprobe+0x30/0x50
[  243.034231]  __hid_bus_reprobe_drivers+0x45/0x50 [hid]
[  243.034239]  bus_for_each_dev+0x64/0xb0
[  243.034250]  __hid_bus_driver_added+0x2c/0x40 [hid]
[  243.034256]  bus_for_each_drv+0x67/0xb0
[  243.034267]  __hid_register_driver+0x6f/0x80 [hid]
[  243.034275]  ? 0xffffffffc07f5000
[  243.034287]  mt_driver_init+0x23/0x1000 [hid_multitouch]
[  243.034296]  do_one_initcall+0x4f/0x1ce
[  243.034303]  ? _cond_resched+0x1a/0x50
[  243.034315]  ? kmem_cache_alloc_trace+0xb8/0x1f0
[  243.034327]  do_init_module+0x5f/0x219
[  243.034335]  load_module+0x24c7/0x2be0
[  243.034348]  __do_sys_finit_module+0xe5/0x120
[  243.034354]  ? __do_sys_finit_module+0xe5/0x120
[  243.034363]  __x64_sys_finit_module+0x1a/0x20
[  243.034370]  do_syscall_64+0x54/0x110
[  243.034380]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  243.034386] RIP: 0033:0x7f2ec539c839
[  243.034390] RSP: 002b:00007ffcfc620298 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  243.034396] RAX: ffffffffffffffda RBX: 000055d6a0147ec0 RCX: 00007f2ec539c839
[  243.034399] RDX: 0000000000000000 RSI: 00007f2ec507b0e5 RDI: 000000000000000f
[  243.034402] RBP: 00007f2ec507b0e5 R08: 0000000000000000 R09: 00007ffcfc6203b0
[  243.034405] R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000000
[  243.034408] R13: 000055d6a017b3a0 R14: 0000000000020000 R15: 000055d6a0147ec0
