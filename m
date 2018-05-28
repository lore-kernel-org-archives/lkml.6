Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933555AbeE1T3d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 15:29:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:11894 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbeE1T33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 15:29:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,453,1520924400";
   d="gz'50?scan'50,208,50";a="51209042"
Date: Tue, 29 May 2018 03:28:37 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Blakey <paulb@mellanox.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org
Subject: 499ac3b60f ("test_rhashtable: add test case for rhltable with
 .."):  WARNING: suspicious RCU usage
Message-ID: <5b0c5865.OyImQN/qidpWgxPc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ"
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 499ac3b60f657dae82055fc81c7b01e6242ac9bc
Author:     Paul Blakey <paulb@mellanox.com>
AuthorDate: Sun Mar 4 17:29:49 2018 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed Mar 7 10:44:03 2018 -0500

    test_rhashtable: add test case for rhltable with duplicate objects
    
    Tries to insert duplicates in the middle of bucket's chain:
    bucket 1:  [[val 21 (tid=1)]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]
    
    Reuses tid to distinguish the elements insertion order.
    
    Signed-off-by: Paul Blakey <paulb@mellanox.com>
    Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
    Signed-off-by: David S. Miller <davem@davemloft.net>

d3dcf8eb61  rhashtable: Fix rhlist duplicates insertion
499ac3b60f  test_rhashtable: add test case for rhltable with duplicate objects
786b71f5b7  Merge tag 'nds32-for-linus-4.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux
47b9cef067  Merge branch 'akpm/master'
+--------------------------------------------------------------------+------------+------------+------------+------------+
|                                                                    | d3dcf8eb61 | 499ac3b60f | 786b71f5b7 | 47b9cef067 |
+--------------------------------------------------------------------+------------+------------+------------+------------+
| boot_successes                                                     | 64         | 0          | 0          | 0          |
| boot_failures                                                      | 0          | 42         | 37         | 15         |
| WARNING:suspicious_RCU_usage                                       | 0          | 42         | 37         | 15         |
| lib/test_rhashtable.c:#suspicious_rcu_dereference_protected()usage | 0          | 42         | 37         | 15         |
| WARNING:at_kernel/kthread.c:#kthread_park                          | 0          | 0          | 0          | 15         |
| RIP:kthread_park                                                   | 0          | 0          | 0          | 15         |
+--------------------------------------------------------------------+------------+------------+------------+------------+

[    9.686452] test if its possible to exceed max_size 8192: no, ok
[    9.687647] Average test time: 452222504
[    9.688324] test inserting duplicates
[    9.688994] 
[    9.689266] =============================
[    9.689946] WARNING: suspicious RCU usage
[    9.690634] 4.16.0-rc4-00130-g499ac3b #1 Not tainted
[    9.691470] -----------------------------
[    9.692150] lib/test_rhashtable.c:502 suspicious rcu_dereference_protected() usage!
[    9.693728] 
[    9.693728] other info that might help us debug this:
[    9.693728] 
[    9.695055] 
[    9.695055] rcu_scheduler_active = 2, debug_locks = 1
[    9.696139] no locks held by swapper/1.
[    9.696799] 
[    9.696799] stack backtrace:
[    9.697538] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.698766] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.700172] Call Trace:
[    9.700607]  ? dump_stack+0x23/0x39
[    9.701207]  ? lockdep_rcu_suspicious+0xfd/0x110
[    9.701990]  ? print_ht+0xa3/0x3c1
[    9.702574]  ? test_insert_dup+0x871/0x955
[    9.703277]  ? my_hashfn+0x30/0x30
[    9.703871]  ? kstrtoul_from_user+0xd0/0xd0
[    9.704587]  ? jhash+0x1c0/0x1c0
[    9.705144]  ? my_hashfn+0x30/0x30
[    9.705726]  ? rhashtable_rehash_alloc+0xf0/0xf0
[    9.706510]  ? test_rht_init+0x3d2/0x7ff
[    9.707196]  ? test_rhashtable+0xab6/0xab6
[    9.708062]  ? do_one_initcall+0x65/0x270
[    9.708738]  ? kernel_init_freeable+0x1d3/0x2c3
[    9.709508]  ? rest_init+0x1d0/0x1d0
[    9.710137]  ? kernel_init+0x12/0x1d0
[    9.710759]  ? ret_from_fork+0x3a/0x50
[    9.711399] 
[    9.711667] =============================
[    9.712346] WARNING: suspicious RCU usage
[    9.713032] 4.16.0-rc4-00130-g499ac3b #1 Not tainted
[    9.713873] -----------------------------
[    9.714558] lib/test_rhashtable.c:507 suspicious rcu_dereference_protected() usage!
[    9.716129] 
[    9.716129] other info that might help us debug this:
[    9.716129] 
[    9.717461] 
[    9.717461] rcu_scheduler_active = 2, debug_locks = 1
[    9.718551] no locks held by swapper/1.
[    9.719206] 
[    9.719206] stack backtrace:
[    9.719937] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.721178] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.722561] Call Trace:
[    9.722992]  ? dump_stack+0x23/0x39
[    9.723600]  ? lockdep_rcu_suspicious+0xfd/0x110
[    9.724383]  ? print_ht+0x11d/0x3c1
[    9.724981]  ? test_insert_dup+0x871/0x955
[    9.725669]  ? my_hashfn+0x30/0x30
[    9.726252]  ? kstrtoul_from_user+0xd0/0xd0
[    9.726977]  ? jhash+0x1c0/0x1c0
[    9.727527]  ? my_hashfn+0x30/0x30
[    9.728113]  ? rhashtable_rehash_alloc+0xf0/0xf0
[    9.728887]  ? test_rht_init+0x3d2/0x7ff
[    9.729557]  ? test_rhashtable+0xab6/0xab6
[    9.730437]  ? do_one_initcall+0x65/0x270
[    9.731123]  ? kernel_init_freeable+0x1d3/0x2c3
[    9.731881]  ? rest_init+0x1d0/0x1d0
[    9.732492]  ? kernel_init+0x12/0x1d0
[    9.733119]  ? ret_from_fork+0x3a/0x50
[    9.733769] 
[    9.734047] =============================
[    9.734718] WARNING: suspicious RCU usage
[    9.735400] 4.16.0-rc4-00130-g499ac3b #1 Not tainted
[    9.736234] -----------------------------
[    9.736925] lib/test_rhashtable.c:508 suspicious rcu_dereference_protected() usage!
[    9.738481] 
[    9.738481] other info that might help us debug this:
[    9.738481] 
[    9.739797] 
[    9.739797] rcu_scheduler_active = 2, debug_locks = 1
[    9.740894] no locks held by swapper/1.
[    9.741552] 
[    9.741552] stack backtrace:
[    9.742287] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.743526] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.744907] Call Trace:
[    9.745344]  ? dump_stack+0x23/0x39
[    9.745944]  ? lockdep_rcu_suspicious+0xfd/0x110
[    9.746739]  ? print_ht+0x195/0x3c1
[    9.747345]  ? test_insert_dup+0x871/0x955
[    9.748042]  ? my_hashfn+0x30/0x30
[    9.748622]  ? kstrtoul_from_user+0xd0/0xd0
[    9.749333]  ? jhash+0x1c0/0x1c0
[    9.749889]  ? my_hashfn+0x30/0x30
[    9.750494]  ? rhashtable_rehash_alloc+0xf0/0xf0
[    9.751279]  ? test_rht_init+0x3d2/0x7ff
[    9.751948]  ? test_rhashtable+0xab6/0xab6
[    9.752809]  ? do_one_initcall+0x65/0x270
[    9.753510]  ? kernel_init_freeable+0x1d3/0x2c3
[    9.754281]  ? rest_init+0x1d0/0x1d0
[    9.754887]  ? kernel_init+0x12/0x1d0
[    9.755509]  ? ret_from_fork+0x3a/0x50
[    9.756147] 
[    9.756416] =============================
[    9.757108] WARNING: suspicious RCU usage
[    9.757782] 4.16.0-rc4-00130-g499ac3b #1 Not tainted
[    9.758613] -----------------------------
[    9.759289] lib/test_rhashtable.c:519 suspicious rcu_dereference_protected() usage!
[    9.760855] 
[    9.760855] other info that might help us debug this:
[    9.760855] 
[    9.762186] 
[    9.762186] rcu_scheduler_active = 2, debug_locks = 1
[    9.763272] no locks held by swapper/1.
[    9.763930] 
[    9.763930] stack backtrace:
[    9.764669] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.765894] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.767288] Call Trace:
[    9.767718]  ? dump_stack+0x23/0x39
[    9.768320]  ? lockdep_rcu_suspicious+0xfd/0x110
[    9.769103]  ? print_ht+0x245/0x3c1
[    9.769698]  ? test_insert_dup+0x871/0x955
[    9.770409]  ? my_hashfn+0x30/0x30
[    9.771000]  ? kstrtoul_from_user+0xd0/0xd0
[    9.771699]  ? jhash+0x1c0/0x1c0
[    9.772255]  ? my_hashfn+0x30/0x30
[    9.772834]  ? rhashtable_rehash_alloc+0xf0/0xf0
[    9.773633]  ? test_rht_init+0x3d2/0x7ff
[    9.774307]  ? test_rhashtable+0xab6/0xab6
[    9.775170]  ? do_one_initcall+0x65/0x270
[    9.775849]  ? kernel_init_freeable+0x1d3/0x2c3
[    9.776615]  ? rest_init+0x1d0/0x1d0
[    9.777243]  ? kernel_init+0x12/0x1d0
[    9.777864]  ? ret_from_fork+0x3a/0x50
[    9.778508] 
[    9.778776] =============================
[    9.779457] WARNING: suspicious RCU usage
[    9.780153] 4.16.0-rc4-00130-g499ac3b #1 Not tainted
[    9.780984] -----------------------------
[    9.781652] lib/test_rhashtable.c:529 suspicious rcu_dereference_protected() usage!
[    9.783211] 
[    9.783211] other info that might help us debug this:
[    9.783211] 
[    9.784537] 
[    9.784537] rcu_scheduler_active = 2, debug_locks = 1
[    9.785672] no locks held by swapper/1.
[    9.786326] 
[    9.786326] stack backtrace:
[    9.787075] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc4-00130-g499ac3b #1
[    9.788294] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    9.789685] Call Trace:
[    9.790136]  ? dump_stack+0x23/0x39
[    9.790729]  ? lockdep_rcu_suspicious+0xfd/0x110
[    9.791513]  ? print_ht+0x310/0x3c1
[    9.792117]  ? test_insert_dup+0x871/0x955
[    9.792808]  ? my_hashfn+0x30/0x30
[    9.793423]  ? kstrtoul_from_user+0xd0/0xd0
[    9.794137]  ? jhash+0x1c0/0x1c0
[    9.794686]  ? my_hashfn+0x30/0x30
[    9.795271]  ? rhashtable_rehash_alloc+0xf0/0xf0
[    9.796140]  ? test_rht_init+0x3d2/0x7ff
[    9.796822]  ? test_rhashtable+0xab6/0xab6
[    9.797690]  ? do_one_initcall+0x65/0x270
[    9.798372]  ? kernel_init_freeable+0x1d3/0x2c3
[    9.799135]  ? rest_init+0x1d0/0x1d0
[    9.799740]  ? kernel_init+0x12/0x1d0
[    9.800380]  ? ret_from_fork+0x3a/0x50
[    9.801028] 
[    9.801028] ---- ht: ----
[    9.801028] bucket[1] -> [[ val 1 (tid=0) ]] -> [[ val 21 (tid=1) ]]
[    9.801028] -------------
[    9.806754] 

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.16 v4.15 --
git bisect good 1388c80438e69fc01d83fbe98da3cac24c3c8731  # 13:32  G     11     0    0   0  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 98577c6aa2cddf73d55b6f1e2825a1f333ea1723  # 14:07  G     11     0    0   0  Merge tag 'chrome-platform-4.16-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform
git bisect good efac2483e8f289cd879e750075e63a9d16897e65  # 14:43  G     11     0    0   0  Merge branch 'for-4.16-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
git bisect  bad f1869a890cdedb92a3fab969db5d0fd982850273  # 15:30  B      0    11   27   2  tty: vt: fix up tabstops properly
git bisect  bad 9ec7ccc8f4f89843991cf692e89fc1fcbca85c83  # 16:10  B      0     2   16   0  Merge tag 'drm-fixes-for-v4.16-rc7' of git://people.freedesktop.org/~airlied/linux
git bisect good 76c0b6a36a1239494a5ae3c0dc83208a8112c483  # 17:03  G     11     0    0   0  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good 9ce207880d8e4b20b6c1bcd82c749970c2b9e6d2  # 17:37  G     11     0    0   0  Merge tag 'mmc-v4.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect  bad 394c73d396284897207dbb1bad2a43e621cb9dac  # 18:02  B      0     1   15   0  Merge tag 'modules-for-v4.16-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux
git bisect  bad c4f4d2f917729e9b7b8bb452bf4971be93e7a15f  # 21:10  B      0     3   47  30  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect  bad 5a9f8df68ee6927f21dd3f2c75c16feb8b53a9e8  # 21:36  B      0     1   15   0  net: dsa: Fix dsa_is_user_port() test inversion
git bisect  bad 652dfb2b31b076153c73106863a4a57e5318c152  # 22:21  B      0     1   15   0  Merge tag 'wireless-drivers-for-davem-2018-03-08' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers
git bisect  bad 17cfe79a65f98abe535261856c5aef14f306dff7  # 22:50  B      0     5   19   0  l2tp: do not accept arbitrary sockets
git bisect  bad 89036a2a9852f70dcec97d5962974fe806828382  # 23:38  B      0    11   25   0  Merge branch 'for-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
git bisect good 25b5cdfcce1b57971840505dfc78556bd12dea6d  # 23:41  G     11     0    0   0  dt-bindings: net: renesas-ravb: Make stream buffer optional
git bisect  bad 803fafbe0cd522fa6b9e41ca3b96cfb2e2a2222d  # 23:41  B      0    12   26   0  fsl/fman: avoid sleeping in atomic context while adding an address
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 02:30  B      0     1   46  31  test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 02:38  G     11     0    0   0  rhashtable: Fix rhlist duplicates insertion
# first bad commit: [499ac3b60f657dae82055fc81c7b01e6242ac9bc] test_rhashtable: add test case for rhltable with duplicate objects
git bisect good d3dcf8eb615537526bd42ff27a081d46d337816e  # 02:44  G     31     0    1   1  rhashtable: Fix rhlist duplicates insertion
# extra tests with debug options
git bisect  bad 499ac3b60f657dae82055fc81c7b01e6242ac9bc  # 02:59  B      0     1   15   0  test_rhashtable: add test case for rhltable with duplicate objects
# extra tests on HEAD of linux-devel/devel-spot-201805280757
git bisect  bad 2596d8a199c5af892e078928af7ce19aa92c0e7b  # 03:05  B      0    13   30   0  0day head guard for 'devel-spot-201805280757'
# extra tests on tree/branch linus/master
git bisect  bad 786b71f5b754273ccef6d9462e52062b3e1f9877  # 03:05  B      0    37   51   0  Merge tag 'nds32-for-linus-4.17-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux
# extra tests with first bad commit reverted
git bisect good 79f277eeeff640b44a201bd5fcf00db69d022f6c  # 03:22  G     11     0    0   0  Revert "test_rhashtable: add test case for rhltable with duplicate objects"
# extra tests on tree/branch linux-next/master
git bisect  bad 47b9cef0672d53ecaaba7e7733ece9da05ba47d4  # 03:22  B      0    12   26   0  Merge branch 'akpm/master'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-116:20180529023116:x86_64-randconfig-r0-05280826:4.16.0-rc4-00130-g499ac3b:1.gz"

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
377+iS63/gdKKbIQq9UAAA==

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-ivb41-70:20180529024328:x86_64-randconfig-r0-05280826:4.16.0-rc4-00129-gd3dcf8e:1.gz"

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
AA==

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-ivb41-116:20180529023116:x86_64-randconfig-r0-05280826:4.16.0-rc4-00130-g499ac3b:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.16.0-rc4-00130-g499ac3b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0-rc4 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
# CONFIG_TASKS_RCU is not set
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_RCU_NEED_SEGCBLIST is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
# CONFIG_MEMCG_SWAP is not set
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
CONFIG_CC_STACKPROTECTOR_STRONG=y
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=m
# CONFIG_VM86 is not set
# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_KEXEC_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_RANDOMIZE_MEMORY is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
CONFIG_X86_X32=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV6 is not set
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=m
CONFIG_LAPB=y
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUGFS=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
# CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS is not set
CONFIG_CFG80211_EXTRA_REGDB_KEYDIR=""
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
# CONFIG_CFG80211_WEXT is not set
# CONFIG_LIB80211 is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_SIM is not set
CONFIG_NFC_PORT100=m
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
# CONFIG_NFC_NXP_NCI is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# CONFIG_PSAMPLE is not set
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_IRQ=y
# CONFIG_DMA_SHARED_BUFFER is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_ATA_OVER_ETH=y
CONFIG_VIRTIO_BLK=m
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_USB_SWITCH_FSA9480=m
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=m
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
CONFIG_ATA=m
# CONFIG_ATA_NONSTANDARD is not set
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
CONFIG_EQUALIZER=y
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
CONFIG_MACB=y
# CONFIG_MACB_USE_HWSTAMP is not set
# CONFIG_MACB_PCI is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_MLXFW=y
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
# CONFIG_WIZNET_W5300 is not set
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=m
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83822_PHY=m
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
# CONFIG_FIXED_PHY is not set
CONFIG_ICPLUS_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROSEMI_PHY=m
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
# CONFIG_REALTEK_PHY is not set
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOE is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
CONFIG_USB_KAWETH=m
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=m
# CONFIG_USB_NET_AX8817X is not set
# CONFIG_USB_NET_AX88179_178A is not set
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
# CONFIG_USB_NET_SMSC75XX is not set
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
# CONFIG_USB_NET_NET1080 is not set
CONFIG_USB_NET_PLUSB=m
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
# CONFIG_USB_NET_CDC_SUBSET is not set
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_IPHETH=m
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
CONFIG_USB_NET_CH9200=m
CONFIG_WLAN=y
CONFIG_WIRELESS_WDS=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_BRCMUTIL=m
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
# CONFIG_BRCMFMAC_SDIO is not set
CONFIG_BRCMFMAC_USB=y
# CONFIG_BRCMFMAC_PCIE is not set
# CONFIG_BRCM_TRACING is not set
CONFIG_BRCMDBG=y
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_WLAN_VENDOR_INTEL is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_PRISM54 is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_ATUSB=m
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=m
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PCF50633_PMU=m
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=m
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65912=m

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=m
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_THERMAL_EMULATION=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
# CONFIG_MFD_CROS_EC_CHARDEV is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=m
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_ABX500_CORE=y
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_TI_LMU is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=m
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=y
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_SMS_SIANO_MDTV=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MT20XX is not set
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
CONFIG_MEDIA_TUNER_XC4000=m
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV6110=m
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
# CONFIG_DVB_CX24116 is not set
CONFIG_DVB_CX24117=m
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=m
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=m
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_AS102_FE is not set
CONFIG_DVB_ZD1301_DEMOD=m
# CONFIG_DVB_GP8PSK_FE is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=m
# CONFIG_DVB_LGDT3305 is not set
# CONFIG_DVB_LGDT3306A is not set
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=m
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_SP2 is not set
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ASCOT2E=m
# CONFIG_DVB_HELENE is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
CONFIG_FB_AUO_K190X=m
CONFIG_FB_AUO_K1900=m
CONFIG_FB_AUO_K1901=m
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_VGASTATE is not set
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
# CONFIG_SOUND_OSS_CORE is not set
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CP2112=m
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GT683R=m
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=m

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_HCD_PLATFORM=m
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=m
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_CHARLCD=m
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=m
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_QCOM_GLINK_NATIVE=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_BMA180=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=m
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=m
CONFIG_STX104=y
CONFIG_TI_ADC081C=m
CONFIG_TI_ADS1015=m

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
CONFIG_CIO_DAC=y
CONFIG_DS4424=m
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#

#
# Phase-Locked Loop (PLL) frequency synthesizers
#

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m

#
# Multiplexers
#

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
CONFIG_DS1803=m
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=m

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=m

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=m
CONFIG_SRF04=y
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=m
CONFIG_TMP006=m
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
# CONFIG_BTT is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_STM=m
# CONFIG_STM_DUMMY is not set
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=m
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
# CONFIG_XILINX_PR_DECOUPLER is not set
# CONFIG_FPGA_REGION is not set
# CONFIG_FSI is not set
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=m
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_PROBE_EVENTS is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=m
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=m
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_HASH=m
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_UBSAN_NULL is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=m
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SHA1_MB is not set
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=m
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=y
CONFIG_VHOST=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m

--=_5b0c5865.DAKjKskoLlO/VURPfOzCP7DTn4iR7fPuI8tkEdud90EhZnNQ--
