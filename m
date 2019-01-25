Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7BEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfAYJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:41:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37596 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfAYJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:41:35 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0P9f9rN003916;
        Fri, 25 Jan 2019 18:41:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Fri, 25 Jan 2019 18:41:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0P9f4Si003878
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 25 Jan 2019 18:41:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: KASAN: use-after-free Read in string
To:     dmitry.torokhov@gmail.com, rydberg@bitmath.org
References: <0000000000009ce64e0574fe896e@google.com>
Cc:     syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
Date:   Fri, 25 Jan 2019 18:41:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0000000000009ce64e0574fe896e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

syzbot is hitting use-after-free bug in uinput module. It seems that
syzbot is hitting this bug from cdev_put() path when closing a character
file. But since I can't reproduce the problem, I used a debug patch which
raises the refcount as if the character device file is open()ed before
uinput_destroy_device() is called.

----------------------------------------
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaaffe87..45fab285f189 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1594,6 +1594,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);
 	if (dev->phys)
 		INPUT_ADD_HOTPLUG_VAR("PHYS=\"%s\"", dev->phys);
+	WARN_ON(!kref_read(&device->kobj.kref));
 	if (dev->uniq)
 		INPUT_ADD_HOTPLUG_VAR("UNIQ=\"%s\"", dev->uniq);
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..0374ea00d4cc 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -299,8 +299,11 @@ static void uinput_destroy_device(struct uinput_device *udev)
 	udev->state = UIST_NEW_DEVICE;
 
 	if (dev) {
+		struct input_dev *d = input_get_device(dev);
 		name = dev->name;
+		dev->name = NULL;
 		phys = dev->phys;
+		dev->phys = NULL;
 		if (old_state == UIST_CREATED) {
 			uinput_flush_requests(udev);
 			input_unregister_device(dev);
@@ -310,6 +313,7 @@ static void uinput_destroy_device(struct uinput_device *udev)
 		kfree(name);
 		kfree(phys);
 		udev->dev = NULL;
+		input_put_device(d);
 	}
 }
 
----------------------------------------

I can sometimes observe WARN_ON() because input_put_device() drops the
refcount to 0.

----------------------------------------
[  122.491394][ T7080] kobject: 'input32' (00000000de092799): kobject_add_internal: parent: 'input', set: 'devices'
[  122.497790][ T7080] kobject: 'input32' (00000000de092799): kobject_uevent_env
[  122.501716][ T7080] kobject: 'input32' (00000000de092799): fill_kobj_path: path = '/devices/virtual/input/input32'
[  122.510123][ T7080] kobject: 'input32' (00000000de092799): fill_kobj_path: path = '/devices/virtual/input/input32'
[  122.517230][ T7080] input: syz1 as /devices/virtual/input/input32
[  122.522334][ T7080] kobject: 'event3' (00000000317a3ed6): kobject_add_internal: parent: 'input32', set: 'devices'
[  122.531090][ T7080] kobject: 'event3' (00000000317a3ed6): kobject_uevent_env
[  122.536589][ T7080] kobject: 'event3' (00000000317a3ed6): fill_kobj_path: path = '/devices/virtual/input/input32/event3'
[  122.545052][ T7080] kobject: 'event3' (00000000317a3ed6): kobject_uevent_env
[  122.549900][ T7080] kobject: 'event3' (00000000317a3ed6): fill_kobj_path: path = '/devices/virtual/input/input32/event3'
[  122.557276][ T7080] FAULT_INJECTION: forcing a failure.
[  122.557276][ T7080] name failslab, interval 1, probability 0, space 0, times 0
[  122.564580][ T7080] CPU: 0 PID: 7080 Comm: a.out Tainted: G        W         5.0.0-rc3+ #142
[  122.569018][ T7080] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  122.576320][ T7080] Call Trace:
[  122.579087][ T7080]  dump_stack+0x154/0x1c5
[  122.582643][ T7080]  should_fail+0x61e/0x720
[  122.585679][ T7080]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  122.589436][ T7080]  ? lock_downgrade+0x880/0x880
[  122.592499][ T7080]  ? ___might_sleep+0x2fe/0x480
[  122.595518][ T7080]  __should_failslab+0xec/0x120
[  122.598995][ T7080]  should_failslab+0x9/0x14
[  122.601869][ T7080]  kmem_cache_alloc+0x47/0x710
[  122.605051][ T7080]  ? refcount_add_not_zero_checked+0x1f0/0x1f0
[  122.608359][ T7080]  ? netlink_broadcast_filtered+0x6c/0xa30
[  122.611721][ T7080]  skb_clone+0x122/0x360
[  122.614463][ T7080]  netlink_broadcast_filtered+0x793/0xa30
[  122.617568][ T7080]  netlink_broadcast+0x3e/0x50
[  122.620668][ T7080]  kobject_uevent_env+0xd51/0x1150
[  122.623565][ T7080]  ? wait_for_completion+0x400/0x400
[  122.626488][ T7080]  kobject_uevent+0x1f/0x30
[  122.629334][ T7080]  device_del+0x673/0xaf0
[  122.631925][ T7080]  ? __device_links_no_driver+0x230/0x230
[  122.634885][ T7080]  ? mark_held_locks+0xaf/0x100
[  122.637857][ T7080]  ? _raw_spin_unlock_irq+0x27/0x80
[  122.640594][ T7080]  ? __input_unregister_device+0x13b/0x480
[  122.643650][ T7080]  ? _raw_spin_unlock_irq+0x27/0x80
[  122.646334][ T7080]  cdev_device_del+0x1a/0x70
[  122.648825][ T7080]  evdev_disconnect+0x42/0xb0
[  122.651291][ T7080]  __input_unregister_device+0x1e3/0x480
[  122.654279][ T7080]  ? kasan_check_read+0x11/0x20
[  122.656777][ T7080]  input_unregister_device+0xa4/0xe0
[  122.659590][ T7080]  uinput_destroy_device+0x216/0x270
[  122.662130][ T7080]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[  122.664850][ T7080]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[  122.667560][ T7080]  ? kasan_check_write+0x14/0x20
[  122.670157][ T7080]  ? proc_fail_nth_write+0x94/0x1c0
[  122.672623][ T7080]  ? map_files_get_link+0x3c0/0x3c0
[  122.675253][ T7080]  ? __handle_mm_fault+0x20c0/0x3290
[  122.677842][ T7080]  ? map_files_get_link+0x3c0/0x3c0
[  122.680187][ T7080]  ? __vfs_write+0x111/0x7f0
[  122.682372][ T7080]  uinput_ioctl+0x4c/0x60
[  122.684486][ T7080]  ? uinput_compat_ioctl+0x80/0x80
[  122.687204][ T7080]  do_vfs_ioctl+0x1a9/0x1100
[  122.689530][ T7080]  ? ioctl_preallocate+0x1e0/0x1e0
[  122.691855][ T7080]  ? lock_downgrade+0x880/0x880
[  122.694111][ T7080]  ? check_preemption_disabled+0x3b/0x240
[  122.696603][ T7080]  ? __sb_end_write+0xc6/0x100
[  122.698842][ T7080]  ? vfs_write+0x224/0x4d0
[  122.700991][ T7080]  ? kasan_check_read+0x11/0x20
[  122.703610][ T7080]  ? security_file_ioctl+0x87/0xb0
[  122.706099][ T7080]  ksys_ioctl+0x94/0xb0
[  122.708161][ T7080]  __x64_sys_ioctl+0x73/0xb0
[  122.710525][ T7080]  do_syscall_64+0xe7/0x570
[  122.712669][ T7080]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  122.715185][ T7080] RIP: 0033:0x7f5160b1a839
[  122.717311][ T7080] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  122.727007][ T7080] RSP: 002b:00007ffe75b27308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  122.731413][ T7080] RAX: ffffffffffffffda RBX: 00007ffe75b27310 RCX: 00007f5160b1a839
[  122.735723][ T7080] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[  122.739593][ T7080] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f5160e00038
[  122.742850][ T7080] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  122.746101][ T7080] R13: 00007ffe75b27420 R14: 0000000000000000 R15: 0000000000000000
[  122.750271][ T7080] kobject: '(null)' (00000000eccc95ba): kobject_cleanup, parent 00000000317a3ed6
[  122.757125][ T7080] kobject: '(null)' (00000000eccc95ba): calling ktype release
[  122.876948][ T7080] kobject: 'event3' (00000000317a3ed6): kobject_cleanup, parent           (null)
[  122.882151][ T7080] kobject: 'event3' (00000000317a3ed6): calling ktype release
[  122.885425][ T7080] kobject: 'event3': free name
[  122.888374][ T7080] kobject: 'input32' (00000000de092799): kobject_uevent_env
[  122.891710][ T7080] kobject: 'input32' (00000000de092799): fill_kobj_path: path = '/devices/virtual/input/input32'
[  122.897786][ T7080] kobject: 'input32' (00000000de092799): kobject_cleanup, parent           (null)
[  122.903563][ T7080] kobject: 'input32' (00000000de092799): calling ktype release
[  122.907255][ T7080] kobject: 'input32': free name
[  122.923983][ T7085] kobject: 'input33' (000000007fe64e92): kobject_add_internal: parent: 'input', set: 'devices'
[  122.933592][ T7085] kobject: 'input33' (000000007fe64e92): kobject_uevent_env
[  122.939795][ T7085] kobject: 'input33' (000000007fe64e92): fill_kobj_path: path = '/devices/virtual/input/input33'
[  122.946505][ T7085] kobject: 'input33' (000000007fe64e92): fill_kobj_path: path = '/devices/virtual/input/input33'
[  122.956466][ T7085] input: syz1 as /devices/virtual/input/input33
[  122.961981][ T7085] kobject: 'event3' (000000003c8d2a0d): kobject_add_internal: parent: 'input33', set: 'devices'
[  122.970126][ T7085] kobject: 'event3' (000000003c8d2a0d): kobject_uevent_env
[  122.974416][ T7085] kobject: 'event3' (000000003c8d2a0d): fill_kobj_path: path = '/devices/virtual/input/input33/event3'
[  122.982226][ T7085] kobject: 'event3' (000000003c8d2a0d): kobject_uevent_env
[  122.986290][ T7085] kobject: 'event3' (000000003c8d2a0d): fill_kobj_path: path = '/devices/virtual/input/input33/event3'
[  122.994321][ T7085] kobject: '(null)' (00000000263f9149): kobject_cleanup, parent 000000003c8d2a0d
[  123.001522][ T7085] kobject: '(null)' (00000000263f9149): calling ktype release
[  123.041730][ T7085] kobject: 'event3' (000000003c8d2a0d): kobject_cleanup, parent           (null)
[  123.047963][ T7085] kobject: 'event3' (000000003c8d2a0d): calling ktype release
[  123.052144][ T7085] kobject: 'event3': free name
[  123.055887][ T7085] kobject: 'input33' (000000007fe64e92): kobject_uevent_env
[  123.059898][ T7085] FAULT_INJECTION: forcing a failure.
[  123.059898][ T7085] name failslab, interval 1, probability 0, space 0, times 0
[  123.067534][ T7085] CPU: 2 PID: 7085 Comm: a.out Tainted: G        W         5.0.0-rc3+ #142
[  123.073308][ T7085] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  123.081085][ T7085] Call Trace:
[  123.084204][ T7085]  dump_stack+0x154/0x1c5
[  123.087890][ T7085]  should_fail+0x61e/0x720
[  123.091337][ T7085]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  123.096751][ T7085]  ? lock_downgrade+0x880/0x880
[  123.102104][ T7085]  ? ___might_sleep+0x2fe/0x480
[  123.107205][ T7085]  __should_failslab+0xec/0x120
[  123.112120][ T7085]  should_failslab+0x9/0x14
[  123.116677][ T7085]  kmem_cache_alloc_trace+0x4b/0x710
[  123.121206][ T7085]  ? dev_uevent_filter+0xe0/0xe0
[  123.124370][ T7085]  kobject_uevent_env+0x22c/0x1150
[  123.127605][ T7085]  ? wait_for_completion+0x400/0x400
[  123.130996][ T7085]  ? software_node_notify+0xd8/0x2b0
[  123.134068][ T7085]  kobject_uevent+0x1f/0x30
[  123.137137][ T7085]  device_del+0x673/0xaf0
[  123.140102][ T7085]  ? __device_links_no_driver+0x230/0x230
[  123.143361][ T7085]  ? trace_hardirqs_on+0x52/0x1d0
[  123.146222][ T7085]  __input_unregister_device+0x379/0x480
[  123.149280][ T7085]  ? kasan_check_read+0x11/0x20
[  123.152249][ T7085]  input_unregister_device+0xa4/0xe0
[  123.155458][ T7085]  uinput_destroy_device+0x216/0x270
[  123.158365][ T7085]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[  123.161375][ T7085]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[  123.164555][ T7085]  ? kasan_check_write+0x14/0x20
[  123.167372][ T7085]  ? proc_fail_nth_write+0x94/0x1c0
[  123.170416][ T7085]  ? map_files_get_link+0x3c0/0x3c0
[  123.174171][ T7085]  ? __handle_mm_fault+0x20c0/0x3290
[  123.177902][ T7085]  ? map_files_get_link+0x3c0/0x3c0
[  123.181524][ T7085]  ? __vfs_write+0x111/0x7f0
[  123.184877][ T7085]  uinput_ioctl+0x4c/0x60
[  123.188445][ T7085]  ? uinput_compat_ioctl+0x80/0x80
[  123.191368][ T7085]  do_vfs_ioctl+0x1a9/0x1100
[  123.193809][ T7085]  ? ioctl_preallocate+0x1e0/0x1e0
[  123.196311][ T7085]  ? lock_downgrade+0x880/0x880
[  123.199013][ T7085]  ? check_preemption_disabled+0x3b/0x240
[  123.201867][ T7085]  ? __sb_end_write+0xc6/0x100
[  123.204412][ T7085]  ? vfs_write+0x224/0x4d0
[  123.206756][ T7085]  ? kasan_check_read+0x11/0x20
[  123.209168][ T7085]  ? security_file_ioctl+0x87/0xb0
[  123.211779][ T7085]  ksys_ioctl+0x94/0xb0
[  123.214142][ T7085]  __x64_sys_ioctl+0x73/0xb0
[  123.216377][ T7085]  do_syscall_64+0xe7/0x570
[  123.218674][ T7085]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  123.221573][ T7085] RIP: 0033:0x7fd9b2d0d839
[  123.223703][ T7085] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  123.233417][ T7085] RSP: 002b:00007fff66a27408 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  123.237353][ T7085] RAX: ffffffffffffffda RBX: 00007fff66a27410 RCX: 00007fd9b2d0d839
[  123.241290][ T7085] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[  123.246692][ T7085] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fd9b2ff0038
[  123.250315][ T7085] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  123.254325][ T7085] R13: 00007fff66a27520 R14: 0000000000000000 R15: 0000000000000000
[  123.258552][ T7085] kobject: 'input33' (000000007fe64e92): kobject_cleanup, parent           (null)
[  123.263643][ T7085] kobject: 'input33' (000000007fe64e92): auto cleanup 'remove' event
[  123.267107][ T7085] kobject: 'input33' (000000007fe64e92): kobject_uevent_env
[  123.270908][ T7085] kobject: 'input33' (000000007fe64e92): fill_kobj_path: path = '/input33'
[  123.274726][ T7085] WARNING: CPU: 2 PID: 7085 at drivers/input/input.c:1597 input_dev_uevent+0x5a2/0x7b0
[  123.280249][ T7085] Modules linked in:
[  123.282624][ T7085] CPU: 2 PID: 7085 Comm: a.out Tainted: G        W         5.0.0-rc3+ #142
[  123.286383][ T7085] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  123.292981][ T7085] RIP: 0010:input_dev_uevent+0x5a2/0x7b0
[  123.296185][ T7085] Code: e8 53 5b 25 fd 44 8b 4d d4 e9 03 fb ff ff e8 45 5b 25 fd e9 c2 fa ff ff 4c 89 ef e8 58 5b 25 fd e9 52 fc ff ff e8 6e 62 f3 fc <0f> 0b e9 51 fc ff ff e8 62 62 f3 fc 49 8d 54 24 30 b9 ff 02 00 00
[  123.306200][ T7085] RSP: 0018:ffff8881e2187830 EFLAGS: 00010293
[  123.309423][ T7085] RAX: ffff8881de5a6180 RBX: ffff8881df2c6e88 RCX: ffffffff8475e852
[  123.313674][ T7085] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881df2c6ed0
[  123.319246][ T7085] RBP: ffff8881e2187868 R08: ffffed103be58ddb R09: ffffed103be58ddb
[  123.324930][ T7085] R10: 0000000000000001 R11: ffffed103be58dda R12: ffff8881df2c6bc0
[  123.330307][ T7085] R13: ffff8881df2c6ed0 R14: ffff8881dd3a6940 R15: ffff8881df2c6e88
[  123.334329][ T7085] FS:  00007fd9b31fd500(0000) GS:ffff8881f5a80000(0000) knlGS:0000000000000000
[  123.338555][ T7085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  123.342050][ T7085] CR2: 00007fd9b2d9fb24 CR3: 00000001c370e002 CR4: 00000000003606e0
[  123.345922][ T7085] Call Trace:
[  123.348590][ T7085]  ? input_add_uevent_bm_var+0x130/0x130
[  123.351864][ T7085]  dev_uevent+0x330/0x5e0
[  123.355017][ T7085]  ? device_get_devnode+0x2e0/0x2e0
[  123.358047][ T7085]  ? vprintk_func+0x68/0x190
[  123.360969][ T7085]  ? add_uevent_var+0x20c/0x2f0
[  123.363992][ T7085]  ? cleanup_uevent_env+0x50/0x50
[  123.366933][ T7085]  ? kobject_uevent_env+0x347/0x1150
[  123.370025][ T7085]  ? device_get_devnode+0x2e0/0x2e0
[  123.372997][ T7085]  kobject_uevent_env+0x487/0x1150
[  123.375921][ T7085]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[  123.378942][ T7085]  kobject_uevent+0x1f/0x30
[  123.381699][ T7085]  kobject_put+0x33c/0x400
[  123.384375][ T7085]  put_device+0x20/0x30
[  123.387304][ T7085]  uinput_destroy_device+0x158/0x270
[  123.390182][ T7085]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[  123.393163][ T7085]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[  123.397616][ T7085]  ? kasan_check_write+0x14/0x20
[  123.401440][ T7085]  ? proc_fail_nth_write+0x94/0x1c0
[  123.404393][ T7085]  ? map_files_get_link+0x3c0/0x3c0
[  123.407191][ T7085]  ? __handle_mm_fault+0x20c0/0x3290
[  123.410014][ T7085]  ? map_files_get_link+0x3c0/0x3c0
[  123.412668][ T7085]  ? __vfs_write+0x111/0x7f0
[  123.415202][ T7085]  uinput_ioctl+0x4c/0x60
[  123.417633][ T7085]  ? uinput_compat_ioctl+0x80/0x80
[  123.420355][ T7085]  do_vfs_ioctl+0x1a9/0x1100
[  123.423053][ T7085]  ? ioctl_preallocate+0x1e0/0x1e0
[  123.425574][ T7085]  ? lock_downgrade+0x880/0x880
[  123.427945][ T7085]  ? check_preemption_disabled+0x3b/0x240
[  123.430867][ T7085]  ? __sb_end_write+0xc6/0x100
[  123.433322][ T7085]  ? vfs_write+0x224/0x4d0
[  123.435527][ T7085]  ? kasan_check_read+0x11/0x20
[  123.438404][ T7085]  ? security_file_ioctl+0x87/0xb0
[  123.440847][ T7085]  ksys_ioctl+0x94/0xb0
[  123.442940][ T7085]  __x64_sys_ioctl+0x73/0xb0
[  123.445627][ T7085]  do_syscall_64+0xe7/0x570
[  123.447876][ T7085]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  123.450354][ T7085] RIP: 0033:0x7fd9b2d0d839
[  123.452589][ T7085] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  123.461381][ T7085] RSP: 002b:00007fff66a27408 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  123.464806][ T7085] RAX: ffffffffffffffda RBX: 00007fff66a27410 RCX: 00007fd9b2d0d839
[  123.468105][ T7085] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[  123.471712][ T7085] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fd9b2ff0038
[  123.475028][ T7085] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  123.478476][ T7085] R13: 00007fff66a27520 R14: 0000000000000000 R15: 0000000000000000
[  123.481837][ T7085] irq event stamp: 2904
[  123.484128][ T7085] hardirqs last  enabled at (2903): [<ffffffff81552310>] console_unlock+0x670/0xd00
[  123.489864][ T7085] hardirqs last disabled at (2904): [<ffffffff81006087>] trace_hardirqs_off_thunk+0x1a/0x1c
[  123.496220][ T7085] softirqs last  enabled at (2888): [<ffffffff86c00673>] __do_softirq+0x673/0x987
[  123.501609][ T7085] softirqs last disabled at (2869): [<ffffffff8140c0f5>] irq_exit+0x195/0x1c0
[  123.505845][ T7085] ---[ end trace de7fa7a05c9c270b ]---
[  123.509700][ T7085] kobject: 'input33' (000000007fe64e92): calling ktype release
[  123.514678][ T7085] kobject: 'input33': free name
----------------------------------------

I also tried reproducing the problem without raising the refcount,

----------------------------------------
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaaffe87..45fab285f189 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1594,6 +1594,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);
 	if (dev->phys)
 		INPUT_ADD_HOTPLUG_VAR("PHYS=\"%s\"", dev->phys);
+	WARN_ON(!kref_read(&device->kobj.kref));
 	if (dev->uniq)
 		INPUT_ADD_HOTPLUG_VAR("UNIQ=\"%s\"", dev->uniq);
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..131591b5babd 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -300,7 +300,9 @@ static void uinput_destroy_device(struct uinput_device *udev)
 
 	if (dev) {
 		name = dev->name;
+		dev->name = NULL;
 		phys = dev->phys;
+		dev->phys = NULL;
 		if (old_state == UIST_CREATED) {
 			uinput_flush_requests(udev);
 			input_unregister_device(dev);
----------------------------------------

and I can sometimes observe WARN_ON() because the refcount drops to 0.
Therefore, I think that we must not assume that kobject_uevent() won't
be called after uinput_destroy_device() called kfree().

----------------------------------------
[   96.531017][ T6997] kobject: 'input21' (0000000074dfd11f): kobject_add_internal: parent: 'input', set: 'devices'
[   96.537254][ T6997] kobject: 'input21' (0000000074dfd11f): kobject_uevent_env
[   96.541162][ T6997] kobject: 'input21' (0000000074dfd11f): fill_kobj_path: path = '/devices/virtual/input/input21'
[   96.547745][ T6997] kobject: 'input21' (0000000074dfd11f): fill_kobj_path: path = '/devices/virtual/input/input21'
[   96.554230][ T6997] input: syz1 as /devices/virtual/input/input21
[   96.559539][ T6997] kobject: 'event3' (00000000648730df): kobject_add_internal: parent: 'input21', set: 'devices'
[   96.569883][ T6997] kobject: 'event3' (00000000648730df): kobject_uevent_env
[   96.574314][ T6997] kobject: 'event3' (00000000648730df): fill_kobj_path: path = '/devices/virtual/input/input21/event3'
[   96.584282][ T6997] kobject: 'event3' (00000000648730df): kobject_uevent_env
[   96.588860][ T6997] kobject: 'event3' (00000000648730df): fill_kobj_path: path = '/devices/virtual/input/input21/event3'
[   96.599355][ T6997] FAULT_INJECTION: forcing a failure.
[   96.599355][ T6997] name failslab, interval 1, probability 0, space 0, times 0
[   96.607828][ T6997] CPU: 3 PID: 6997 Comm: a.out Not tainted 5.0.0-rc3+ #143
[   96.611875][ T6997] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[   96.619039][ T6997] Call Trace:
[   96.622211][ T6997]  dump_stack+0x154/0x1c5
[   96.625318][ T6997]  should_fail+0x61e/0x720
[   96.628678][ T6997]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[   96.632461][ T6997]  ? lock_downgrade+0x880/0x880
[   96.635613][ T6997]  ? ___might_sleep+0x2fe/0x480
[   96.638996][ T6997]  __should_failslab+0xec/0x120
[   96.642133][ T6997]  should_failslab+0x9/0x14
[   96.645003][ T6997]  kmem_cache_alloc+0x47/0x710
[   96.648132][ T6997]  ? refcount_add_not_zero_checked+0x1f0/0x1f0
[   96.651502][ T6997]  ? netlink_broadcast_filtered+0x6c/0xa30
[   96.654754][ T6997]  skb_clone+0x122/0x360
[   96.657877][ T6997]  netlink_broadcast_filtered+0x793/0xa30
[   96.661063][ T6997]  netlink_broadcast+0x3e/0x50
[   96.663850][ T6997]  kobject_uevent_env+0xd51/0x1150
[   96.666808][ T6997]  ? wait_for_completion+0x400/0x400
[   96.669819][ T6997]  kobject_uevent+0x1f/0x30
[   96.672838][ T6997]  device_del+0x673/0xaf0
[   96.675412][ T6997]  ? __device_links_no_driver+0x230/0x230
[   96.678471][ T6997]  ? mark_held_locks+0xaf/0x100
[   96.681207][ T6997]  ? _raw_spin_unlock_irq+0x27/0x80
[   96.683928][ T6997]  ? __input_unregister_device+0x13b/0x480
[   96.686962][ T6997]  ? _raw_spin_unlock_irq+0x27/0x80
[   96.689979][ T6997]  cdev_device_del+0x1a/0x70
[   96.692532][ T6997]  evdev_disconnect+0x42/0xb0
[   96.695109][ T6997]  __input_unregister_device+0x1e3/0x480
[   96.697885][ T6997]  ? kasan_check_read+0x11/0x20
[   96.700421][ T6997]  input_unregister_device+0xa4/0xe0
[   96.702971][ T6997]  uinput_destroy_device+0x1e3/0x240
[   96.705894][ T6997]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[   96.708713][ T6997]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[   96.711453][ T6997]  ? kasan_check_write+0x14/0x20
[   96.713866][ T6997]  ? proc_fail_nth_write+0x94/0x1c0
[   96.716386][ T6997]  ? map_files_get_link+0x3c0/0x3c0
[   96.718808][ T6997]  ? __handle_mm_fault+0x20c0/0x3290
[   96.721446][ T6997]  ? map_files_get_link+0x3c0/0x3c0
[   96.724169][ T6997]  ? __vfs_write+0x111/0x7f0
[   96.726353][ T6997]  uinput_ioctl+0x4c/0x60
[   96.728983][ T6997]  ? uinput_compat_ioctl+0x80/0x80
[   96.732259][ T6997]  do_vfs_ioctl+0x1a9/0x1100
[   96.735345][ T6997]  ? ioctl_preallocate+0x1e0/0x1e0
[   96.738758][ T6997]  ? lock_downgrade+0x880/0x880
[   96.741859][ T6997]  ? check_preemption_disabled+0x3b/0x240
[   96.744752][ T6997]  ? __sb_end_write+0xc6/0x100
[   96.747207][ T6997]  ? vfs_write+0x224/0x4d0
[   96.750131][ T6997]  ? kasan_check_read+0x11/0x20
[   96.753300][ T6997]  ? security_file_ioctl+0x87/0xb0
[   96.756922][ T6997]  ksys_ioctl+0x94/0xb0
[   96.759615][ T6997]  __x64_sys_ioctl+0x73/0xb0
[   96.761779][ T6997]  do_syscall_64+0xe7/0x570
[   96.764036][ T6997]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   96.766695][ T6997] RIP: 0033:0x7f02ca03a839
[   96.768823][ T6997] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   96.777498][ T6997] RSP: 002b:00007ffe08c4e418 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   96.780999][ T6997] RAX: ffffffffffffffda RBX: 00007ffe08c4e420 RCX: 00007f02ca03a839
[   96.784750][ T6997] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[   96.788895][ T6997] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f02ca320038
[   96.792533][ T6997] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   96.796682][ T6997] R13: 00007ffe08c4e530 R14: 0000000000000000 R15: 0000000000000000
[   96.802099][ T6997] kobject: '(null)' (0000000056da26df): kobject_cleanup, parent 00000000648730df
[   96.808680][ T6997] kobject: '(null)' (0000000056da26df): calling ktype release
[   96.856008][ T6997] kobject: 'event3' (00000000648730df): kobject_cleanup, parent           (null)
[   96.863416][ T6997] kobject: 'event3' (00000000648730df): calling ktype release
[   96.868646][ T6997] kobject: 'event3': free name
[   96.871768][ T6997] kobject: 'input21' (0000000074dfd11f): kobject_uevent_env
[   96.876871][ T6997] kobject: 'input21' (0000000074dfd11f): fill_kobj_path: path = '/devices/virtual/input/input21'
[   96.884436][ T6997] kobject: 'input21' (0000000074dfd11f): kobject_cleanup, parent           (null)
[   96.891397][ T6997] kobject: 'input21' (0000000074dfd11f): calling ktype release
[   96.896877][ T6997] kobject: 'input21': free name
[  106.244899][ T7002] kobject: 'input22' (00000000e09f1862): kobject_add_internal: parent: 'input', set: 'devices'
[  106.251101][ T7002] kobject: 'input22' (00000000e09f1862): kobject_uevent_env
[  106.255895][ T7002] kobject: 'input22' (00000000e09f1862): fill_kobj_path: path = '/devices/virtual/input/input22'
[  106.262394][ T7002] kobject: 'input22' (00000000e09f1862): fill_kobj_path: path = '/devices/virtual/input/input22'
[  106.269457][ T7002] input: syz1 as /devices/virtual/input/input22
[  106.273526][ T7002] kobject: 'event3' (000000006eb448c2): kobject_add_internal: parent: 'input22', set: 'devices'
[  106.281027][ T7002] kobject: 'event3' (000000006eb448c2): kobject_uevent_env
[  106.285352][ T7002] kobject: 'event3' (000000006eb448c2): fill_kobj_path: path = '/devices/virtual/input/input22/event3'
[  106.293562][ T7002] kobject: 'event3' (000000006eb448c2): kobject_uevent_env
[  106.297761][ T7002] kobject: 'event3' (000000006eb448c2): fill_kobj_path: path = '/devices/virtual/input/input22/event3'
[  106.305312][ T7002] kobject: '(null)' (00000000192e3ebd): kobject_cleanup, parent 000000006eb448c2
[  106.314030][ T7002] kobject: '(null)' (00000000192e3ebd): calling ktype release
[  106.404201][ T7002] kobject: 'event3' (000000006eb448c2): kobject_cleanup, parent           (null)
[  106.410653][ T7002] kobject: 'event3' (000000006eb448c2): calling ktype release
[  106.414781][ T7002] kobject: 'event3': free name
[  106.418206][ T7002] kobject: 'input22' (00000000e09f1862): kobject_uevent_env
[  106.422387][ T7002] FAULT_INJECTION: forcing a failure.
[  106.422387][ T7002] name failslab, interval 1, probability 0, space 0, times 0
[  106.429765][ T7002] CPU: 0 PID: 7002 Comm: a.out Not tainted 5.0.0-rc3+ #143
[  106.433704][ T7002] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  106.440953][ T7002] Call Trace:
[  106.443818][ T7002]  dump_stack+0x154/0x1c5
[  106.446842][ T7002]  should_fail+0x61e/0x720
[  106.449962][ T7002]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  106.453392][ T7002]  ? lock_downgrade+0x880/0x880
[  106.456771][ T7002]  ? ___might_sleep+0x2fe/0x480
[  106.459873][ T7002]  __should_failslab+0xec/0x120
[  106.462960][ T7002]  should_failslab+0x9/0x14
[  106.465843][ T7002]  kmem_cache_alloc_trace+0x4b/0x710
[  106.469001][ T7002]  ? dev_uevent_filter+0xe0/0xe0
[  106.472264][ T7002]  kobject_uevent_env+0x22c/0x1150
[  106.475338][ T7002]  ? wait_for_completion+0x400/0x400
[  106.478399][ T7002]  ? software_node_notify+0xd8/0x2b0
[  106.481321][ T7002]  kobject_uevent+0x1f/0x30
[  106.484081][ T7002]  device_del+0x673/0xaf0
[  106.486758][ T7002]  ? __device_links_no_driver+0x230/0x230
[  106.489994][ T7002]  ? trace_hardirqs_on+0x52/0x1d0
[  106.492762][ T7002]  __input_unregister_device+0x379/0x480
[  106.495713][ T7002]  ? kasan_check_read+0x11/0x20
[  106.498448][ T7002]  input_unregister_device+0xa4/0xe0
[  106.501178][ T7002]  uinput_destroy_device+0x1e3/0x240
[  106.504219][ T7002]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[  106.507369][ T7002]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[  106.510320][ T7002]  ? kasan_check_write+0x14/0x20
[  106.512855][ T7002]  ? proc_fail_nth_write+0x94/0x1c0
[  106.515504][ T7002]  ? map_files_get_link+0x3c0/0x3c0
[  106.518111][ T7002]  ? __handle_mm_fault+0x20c0/0x3290
[  106.520647][ T7002]  ? map_files_get_link+0x3c0/0x3c0
[  106.523352][ T7002]  ? __vfs_write+0x111/0x7f0
[  106.525728][ T7002]  uinput_ioctl+0x4c/0x60
[  106.527934][ T7002]  ? uinput_compat_ioctl+0x80/0x80
[  106.530418][ T7002]  do_vfs_ioctl+0x1a9/0x1100
[  106.532667][ T7002]  ? ioctl_preallocate+0x1e0/0x1e0
[  106.535138][ T7002]  ? lock_downgrade+0x880/0x880
[  106.537821][ T7002]  ? check_preemption_disabled+0x3b/0x240
[  106.541370][ T7002]  ? __sb_end_write+0xc6/0x100
[  106.544464][ T7002]  ? vfs_write+0x224/0x4d0
[  106.547441][ T7002]  ? kasan_check_read+0x11/0x20
[  106.550570][ T7002]  ? security_file_ioctl+0x87/0xb0
[  106.553765][ T7002]  ksys_ioctl+0x94/0xb0
[  106.556910][ T7002]  __x64_sys_ioctl+0x73/0xb0
[  106.559835][ T7002]  do_syscall_64+0xe7/0x570
[  106.562861][ T7002]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.566361][ T7002] RIP: 0033:0x7f5185ef6839
[  106.569153][ T7002] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  106.577796][ T7002] RSP: 002b:00007ffc7a800078 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  106.581248][ T7002] RAX: ffffffffffffffda RBX: 00007ffc7a800080 RCX: 00007f5185ef6839
[  106.584590][ T7002] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[  106.588145][ T7002] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f51861d0038
[  106.591466][ T7002] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  106.594767][ T7002] R13: 00007ffc7a800190 R14: 0000000000000000 R15: 0000000000000000
[  106.598818][ T7002] kobject: 'input22' (00000000e09f1862): kobject_cleanup, parent           (null)
[  106.603916][ T7002] kobject: 'input22' (00000000e09f1862): auto cleanup 'remove' event
[  106.607654][ T7002] kobject: 'input22' (00000000e09f1862): kobject_uevent_env
[  106.610810][ T7002] kobject: 'input22' (00000000e09f1862): fill_kobj_path: path = '/input22'
[  106.614563][ T7002] WARNING: CPU: 0 PID: 7002 at drivers/input/input.c:1597 input_dev_uevent+0x5a2/0x7b0
[  106.619879][ T7002] Modules linked in:
[  106.622530][ T7002] CPU: 0 PID: 7002 Comm: a.out Not tainted 5.0.0-rc3+ #143
[  106.625853][ T7002] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
[  106.631813][ T7002] RIP: 0010:input_dev_uevent+0x5a2/0x7b0
[  106.634771][ T7002] Code: e8 53 5b 25 fd 44 8b 4d d4 e9 03 fb ff ff e8 45 5b 25 fd e9 c2 fa ff ff 4c 89 ef e8 58 5b 25 fd e9 52 fc ff ff e8 6e 62 f3 fc <0f> 0b e9 51 fc ff ff e8 62 62 f3 fc 49 8d 54 24 30 b9 ff 02 00 00
[  106.644676][ T7002] RSP: 0018:ffff8881d14af828 EFLAGS: 00010293
[  106.648039][ T7002] RAX: ffff8881d287c300 RBX: ffff8881f06ab748 RCX: ffffffff8475e852
[  106.651852][ T7002] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8881f06ab790
[  106.655867][ T7002] RBP: ffff8881d14af860 R08: ffffed103e0d56f3 R09: ffffed103e0d56f3
[  106.659628][ T7002] R10: 0000000000000001 R11: ffffed103e0d56f2 R12: ffff8881f06ab480
[  106.663397][ T7002] R13: ffff8881f06ab790 R14: ffff8881df8f6640 R15: ffff8881f06ab748
[  106.667175][ T7002] FS:  00007f51863e6500(0000) GS:ffff8881f5a00000(0000) knlGS:0000000000000000
[  106.671480][ T7002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.674937][ T7002] CR2: 00007f5185f0ce70 CR3: 00000001f075d006 CR4: 00000000003606f0
[  106.678832][ T7002] Call Trace:
[  106.681490][ T7002]  ? input_add_uevent_bm_var+0x130/0x130
[  106.684669][ T7002]  dev_uevent+0x330/0x5e0
[  106.687697][ T7002]  ? device_get_devnode+0x2e0/0x2e0
[  106.690950][ T7002]  ? vprintk_func+0x68/0x190
[  106.693977][ T7002]  ? add_uevent_var+0x20c/0x2f0
[  106.696886][ T7002]  ? cleanup_uevent_env+0x50/0x50
[  106.699818][ T7002]  ? kobject_uevent_env+0x347/0x1150
[  106.702810][ T7002]  ? device_get_devnode+0x2e0/0x2e0
[  106.705952][ T7002]  kobject_uevent_env+0x487/0x1150
[  106.708937][ T7002]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[  106.711886][ T7002]  kobject_uevent+0x1f/0x30
[  106.714689][ T7002]  kobject_put+0x33c/0x400
[  106.717543][ T7002]  put_device+0x20/0x30
[  106.720071][ T7002]  input_unregister_device+0xba/0xe0
[  106.723306][ T7002]  uinput_destroy_device+0x1e3/0x240
[  106.726319][ T7002]  uinput_ioctl_handler.isra.10+0xf63/0x1940
[  106.729383][ T7002]  ? uinput_request_submit.part.9+0x2b0/0x2b0
[  106.732442][ T7002]  ? kasan_check_write+0x14/0x20
[  106.735090][ T7002]  ? proc_fail_nth_write+0x94/0x1c0
[  106.738758][ T7002]  ? map_files_get_link+0x3c0/0x3c0
[  106.741915][ T7002]  ? __handle_mm_fault+0x20c0/0x3290
[  106.744697][ T7002]  ? map_files_get_link+0x3c0/0x3c0
[  106.747313][ T7002]  ? __vfs_write+0x111/0x7f0
[  106.749911][ T7002]  uinput_ioctl+0x4c/0x60
[  106.752365][ T7002]  ? uinput_compat_ioctl+0x80/0x80
[  106.755102][ T7002]  do_vfs_ioctl+0x1a9/0x1100
[  106.757552][ T7002]  ? ioctl_preallocate+0x1e0/0x1e0
[  106.760368][ T7002]  ? lock_downgrade+0x880/0x880
[  106.762722][ T7002]  ? check_preemption_disabled+0x3b/0x240
[  106.765380][ T7002]  ? __sb_end_write+0xc6/0x100
[  106.767791][ T7002]  ? vfs_write+0x224/0x4d0
[  106.769997][ T7002]  ? kasan_check_read+0x11/0x20
[  106.772590][ T7002]  ? security_file_ioctl+0x87/0xb0
[  106.775012][ T7002]  ksys_ioctl+0x94/0xb0
[  106.777240][ T7002]  __x64_sys_ioctl+0x73/0xb0
[  106.779549][ T7002]  do_syscall_64+0xe7/0x570
[  106.781756][ T7002]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.784388][ T7002] RIP: 0033:0x7f5185ef6839
[  106.786485][ T7002] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[  106.795212][ T7002] RSP: 002b:00007ffc7a800078 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  106.798602][ T7002] RAX: ffffffffffffffda RBX: 00007ffc7a800080 RCX: 00007f5185ef6839
[  106.801823][ T7002] RDX: 0000000000000001 RSI: 0000000000005502 RDI: 0000000000000004
[  106.805440][ T7002] RBP: 0000000000000005 R08: 0000000000000000 R09: 00007f51861d0038
[  106.808818][ T7002] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  106.812112][ T7002] R13: 00007ffc7a800190 R14: 0000000000000000 R15: 0000000000000000
[  106.815416][ T7002] irq event stamp: 2868
[  106.817657][ T7002] hardirqs last  enabled at (2867): [<ffffffff81552310>] console_unlock+0x670/0xd00
[  106.822995][ T7002] hardirqs last disabled at (2868): [<ffffffff81006087>] trace_hardirqs_off_thunk+0x1a/0x1c
[  106.828472][ T7002] softirqs last  enabled at (2864): [<ffffffff86c00673>] __do_softirq+0x673/0x987
[  106.833767][ T7002] softirqs last disabled at (2855): [<ffffffff8140c0f5>] irq_exit+0x195/0x1c0
[  106.837681][ T7002] ---[ end trace 781f472231e721f9 ]---
[  106.841772][ T7002] kobject: 'input22' (00000000e09f1862): calling ktype release
[  106.845524][ T7002] kobject: 'input22': free name
----------------------------------------



From ea8886899e01184801e4c2db2a21892b6006c2c4 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 25 Jan 2019 14:12:58 +0900
Subject: [PATCH] Input: uinput - Set name/phys to NULL after kfree().

syzbot is hitting use-after-free bug in uinput module [1]. This is because
uinput_destroy_device() sometimes kfree()s dev->name and dev->phys at
uinput_destroy_device() before dev_uevent() is triggered by dropping the
refcount to 0. Since the timing of triggering last input_put_device() is
uncontrollable, this patch prepares for such race by setting dev->name and
dev->phys to NULL before doing operations which might drop the refcount
to 0.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/input/misc/uinput.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..131591b5babd 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -300,7 +300,9 @@ static void uinput_destroy_device(struct uinput_device *udev)
 
 	if (dev) {
 		name = dev->name;
+		dev->name = NULL;
 		phys = dev->phys;
+		dev->phys = NULL;
 		if (old_state == UIST_CREATED) {
 			uinput_flush_requests(udev);
 			input_unregister_device(dev);
-- 
2.17.1

