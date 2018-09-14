Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23258FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677642146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677642146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeINOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:15:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:10446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbeINOPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:15:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 02:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="xz'?scan'208";a="83468641"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2018 02:01:27 -0700
Date:   Fri, 14 Sep 2018 17:01:51 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, lkp@01.org
Subject: [LKP] [tty]  f26eb68a52: INFO:task_blocked_for_more_than#seconds
Message-ID: <20180914090151.GH7632@shao2-debian>
Reply-To: kernel test robot <rong.a.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
In-Reply-To: <20180912001702.18522-3-dima@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-4.9):

commit: f26eb68a52bb7302d220133440c1438143f2c7e1 ("[PATCHv4 2/7] tty: Hold tty_ldisc_lock() during tty_reopen()")
url: https://github.com/0day-ci/linux/commits/Dmitry-Safonov/tty-Hold-write-ldisc-sem-in-tty_reopen/20180912-182135
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing

in testcase: locktorture
with following parameters:

	runtime: 300s
	test: cpuhotplug

test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt


on test machine: qemu-system-i386 -enable-kvm -m 256M

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+----------------------------------------------------+------------+------------+
|                                                    | 59ce4b9e1e | f26eb68a52 |
+----------------------------------------------------+------------+------------+
| boot_successes                                     | 0          | 0          |
| boot_failures                                      | 12         | 14         |
| INFO:trying_to_register_non-static_key             | 12         | 14         |
| WARNING:at_mm/page_alloc.c:#__alloc_pages_nodemask | 12         | 14         |
| EIP:__alloc_pages_nodemask                         | 12         | 14         |
| Mem-Info                                           | 12         | 14         |
| INFO:task_blocked_for_more_than#seconds            | 0          | 8          |
| Kernel_panic-not_syncing:hung_task:blocked_tasks   | 0          | 8          |
+----------------------------------------------------+------------+------------+



[  245.080051] INFO: task lkp-setup-rootf:500 blocked for more than 120 seconds.
[  245.082850]       Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.084673] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.086455] lkp-setup-rootf D 6516   500    498 0x00000000
[  245.087766] Call Trace:
[  245.088391]  __schedule+0x4b1/0xe80
[  245.089322]  schedule+0x25/0x60
[  245.090178]  schedule_timeout+0x275/0x4e0
[  245.091105]  ? __ldsem_down_write_nested+0x1aa/0x300
[  245.092217]  __ldsem_down_write_nested+0x1b2/0x300
[  245.093286]  ? ldsem_down_write+0x2a/0x2e
[  245.094305]  ldsem_down_write+0x2a/0x2e
[  245.095211]  tty_ldisc_lock+0x16/0x40
[  245.096104]  tty_reopen+0x3f/0xc0
[  245.096892]  tty_open+0x3cf/0x450
[  245.097718]  chrdev_open+0x9c/0x1f0
[  245.098511]  ? security_file_open+0x99/0xa0
[  245.099512]  do_dentry_open+0x3d5/0x5d0
[  245.100428]  ? inode_permission+0x95/0x180
[  245.101351]  ? cdev_put+0x30/0x30
[  245.102138]  vfs_open+0x2d/0x30
[  245.102898]  path_openat+0x9e1/0x17d0
[  245.103733]  do_filp_open+0x6a/0x120
[  245.104541]  ? _raw_spin_unlock+0x22/0x30
[  245.105439]  ? __alloc_fd+0xa5/0x170
[  245.106309]  do_sys_open+0x13a/0x250
[  245.107118]  sys_open+0x22/0x30
[  245.107980]  do_int80_syscall_32+0x94/0x1c0
[  245.108982]  entry_INT80_32+0xf3/0xf3
[  245.109865] EIP: 0x6fe9c305
[  245.110672] Code: Bad RIP value.
[  245.111607] EAX: ffffffda EBX: 0906aa54 ECX: 00008241 EDX: 000001b6
[  245.113034] ESI: 00000241 EDI: 000001b6 EBP: 778ae6f4 ESP: 778ae5ec
[  245.114594] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000286
[  245.116119] INFO: task jshn:542 blocked for more than 120 seconds.
[  245.117633]       Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.119174] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.120929] jshn            D 6708   542    541 0x00000000
[  245.122290] Call Trace:
[  245.122871]  ? __schedule+0x4b1/0xe80
[  245.123749]  ? schedule+0x25/0x60
[  245.124554]  ? __mutex_unlock_slowpath+0xbe/0x3b0
[  245.125670]  ? schedule_timeout+0x275/0x4e0
[  245.126623]  ? __ldsem_down_read_nested+0x137/0x2c0
[  245.127726]  ? __ldsem_down_read_nested+0x14b/0x2c0
[  245.129035]  ? ldsem_down_read+0x2a/0x30
[  245.129943]  ? uart_write+0x220/0x220
[  245.130875]  ? ldsem_down_read+0x2a/0x30
[  245.131729]  ? tty_ldisc_ref_wait+0x1e/0x40
[  245.132637]  ? tty_ioctl+0xe2/0x970
[  245.133451]  ? do_raw_spin_unlock+0xb2/0x130
[  245.134501]  ? _raw_spin_unlock+0x22/0x30
[  245.135428]  ? handle_mm_fault+0x16d1/0x1e80
[  245.136368]  ? send_break+0x110/0x110
[  245.137240]  ? do_vfs_ioctl+0x84/0x9f0
[  245.138181]  ? __do_page_fault+0x40c/0x840
[  245.139146]  ? up_read+0x67/0xd0
[  245.139870]  ? __fget_light+0x81/0x90
[  245.140672]  ? security_file_ioctl+0xe/0x50
[  245.141676]  ? ksys_ioctl+0x58/0x80
[  245.142436]  ? sys_ioctl+0x16/0x20
[  245.143195]  ? do_int80_syscall_32+0x94/0x1c0
[  245.144160]  ? entry_INT80_32+0xf3/0xf3
[  245.145021] INFO: task dnsmasq:555 blocked for more than 120 seconds.
[  245.146852]       Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.148826] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.151131] dnsmasq         D 6772   555      1 0x00000000
[  245.152449] Call Trace:
[  245.153009]  __schedule+0x4b1/0xe80
[  245.153808]  schedule+0x25/0x60
[  245.154561]  ? __mutex_unlock_slowpath+0xbe/0x3b0
[  245.155609]  schedule_timeout+0x275/0x4e0
[  245.156560]  ? __ldsem_down_read_nested+0x137/0x2c0
[  245.157693]  __ldsem_down_read_nested+0x14b/0x2c0
[  245.159001]  ? ldsem_down_read+0x2a/0x30
[  245.159885]  ? uart_write+0x220/0x220
[  245.160702]  ldsem_down_read+0x2a/0x30
[  245.161522]  tty_ldisc_ref_wait+0x1e/0x40
[  245.162581]  tty_ioctl+0xe2/0x970
[  245.163314]  ? do_raw_spin_unlock+0xb2/0x130
[  245.164286]  ? _raw_spin_unlock+0x22/0x30
[  245.165257]  ? handle_mm_fault+0x16d1/0x1e80
[  245.166260]  ? send_break+0x110/0x110
[  245.167082]  do_vfs_ioctl+0x84/0x9f0
[  245.167876]  ? __do_page_fault+0x40c/0x840
[  245.169051]  ? up_read+0x67/0xd0
[  245.169829]  ? __fget_light+0x81/0x90
[  245.170637]  ? security_file_ioctl+0xe/0x50
[  245.171570]  ksys_ioctl+0x58/0x80
[  245.172336]  sys_ioctl+0x16/0x20
[  245.173139]  do_int80_syscall_32+0x94/0x1c0
[  245.174104]  entry_INT80_32+0xf3/0xf3
[  245.175017] EIP: 0x6ff64648
[  245.175657] Code: c0 74 1a 8d 83 ce e8 fe ff 89 44 24 04 89 3c 24 e8 21 9d ff ff 85 c0 0f 85 93 00 00 00 8b 83 68 44 00 00 85 c0 74 53 48 89 83 <68> 44 00 00 8b 93 5c 44 00 00 8b 04 82 89 04 24 e8 53 95 fd ff eb
[  245.180346] EAX: ffffffda EBX: 00000000 ECX: 00005401 EDX: 77a6c704
[  245.181929] ESI: 77a6c704 EDI: 77a6c73c EBP: 77a6c9a8 ESP: 77a6c6e4
[  245.183279] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000246
[  245.184814] INFO: task dropbear:667 blocked for more than 120 seconds.
[  245.186388]       Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.187992] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.189851] dropbear        D 6772   667      1 0x00000000
[  245.191265] Call Trace:
[  245.191865]  __schedule+0x4b1/0xe80
[  245.192643]  schedule+0x25/0x60
[  245.193355]  ? __mutex_unlock_slowpath+0xbe/0x3b0
[  245.194554]  schedule_timeout+0x275/0x4e0
[  245.195574]  ? __ldsem_down_read_nested+0x137/0x2c0
[  245.196694]  __ldsem_down_read_nested+0x14b/0x2c0
[  245.197744]  ? ldsem_down_read+0x2a/0x30
[  245.198686]  ? uart_write+0x220/0x220
[  245.199516]  ldsem_down_read+0x2a/0x30
[  245.200321]  tty_ldisc_ref_wait+0x1e/0x40
[  245.201219]  tty_ioctl+0xe2/0x970
[  245.202012]  ? do_raw_spin_unlock+0xb2/0x130
[  245.202937]  ? _raw_spin_unlock+0x22/0x30
[  245.203891]  ? handle_mm_fault+0x16d1/0x1e80
[  245.204884]  ? send_break+0x110/0x110
[  245.205834]  do_vfs_ioctl+0x84/0x9f0
[  245.206729]  ? __do_page_fault+0x40c/0x840
[  245.207752]  ? up_read+0x67/0xd0
[  245.208526]  ? __fget_light+0x81/0x90
[  245.209440]  ? security_file_ioctl+0xe/0x50
[  245.210531]  ksys_ioctl+0x58/0x80
[  245.211285]  sys_ioctl+0x16/0x20
[  245.212182]  do_int80_syscall_32+0x94/0x1c0
[  245.213163]  entry_INT80_32+0xf3/0xf3
[  245.214146] EIP: 0x6ff5f648
[  245.214894] Code: 39 89 3e 4a 83 c1 04 83 c6 04 eb ef 85 d2 74 09 4a 8b 34 91 89 34 90 eb f3 5e 5f c3 56 8b 44 24 08 8b 4c 24 0c 8b 54 24 10 85 <d2> 74 0d 8b 31 89 30 4a 83 c1 04 83 c0 04 eb ef 5e c3 56 8b 44 24
[  245.219039] EAX: ffffffda EBX: 00000000 ECX: 00005401 EDX: 77b3c984
[  245.220389] ESI: 77b3c984 EDI: 77b3c9bc EBP: 77b3cc28 ESP: 77b3c964
[  245.222023] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000246
[  245.223596] INFO: lockdep is turned off.
[  245.224554] NMI backtrace for cpu 0
[  245.225318] CPU: 0 PID: 18 Comm: khungtaskd Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.227454] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  245.229272] Call Trace:
[  245.229879]  ? dump_stack+0x76/0xb6
[  245.230725]  ? nmi_cpu_backtrace+0x9e/0xa0
[  245.231630]  ? nmi_trigger_cpumask_backtrace+0xaa/0xf0
[  245.232783]  ? debug_show_all_locks+0x112/0x120
[  245.233863]  ? watchdog+0x308/0x530
[  245.234744]  ? lapic_can_unplug_cpu+0xa0/0xa0
[  245.235811]  ? arch_trigger_cpumask_backtrace+0x15/0x20
[  245.237103]  ? watchdog+0x349/0x530
[  245.237891]  ? kthread+0x10f/0x140
[  245.238634]  ? reset_hung_task_detector+0x20/0x20
[  245.239777]  ? kthread_stop+0x210/0x210
[  245.240642]  ? ret_from_fork+0x2e/0x38
[  245.241586] Kernel panic - not syncing: hung_task: blocked tasks
[  245.242902] CPU: 0 PID: 18 Comm: khungtaskd Tainted: G        W       T 4.19.0-rc3-00014-gf26eb68 #1
[  245.244941] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  245.246929] Call Trace:
[  245.247486]  ? dump_stack+0x76/0xb6
[  245.248246]  ? panic+0x97/0x1e0
[  245.248991]  ? watchdog+0x355/0x530
[  245.249798]  ? kthread+0x10f/0x140
[  245.250598]  ? reset_hung_task_detector+0x20/0x20
[  245.251716]  ? kthread_stop+0x210/0x210
[  245.252617]  ? ret_from_fork+0x2e/0x38
[  245.253582] Kernel Offset: disabled
[  245.254385] Rebooting in 3 seconds..

Elapsed time: 240

#!/bin/bash

# To reproduce,
# 1) save job-script and this script (both are attached in 0day report email)
# 2) run this script with your compiled kernel and optional env $INSTALL_MOD_PATH

kernel=$1

initrds=(
	/osimage/openwrt/openwrt-i386-2016-03-16.cgz
	/lkp/lkp/lkp-i386.cgz
)

HTTP_PREFIX=https://download.01.org/0day-ci/lkp-qemu
wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

{
	cat "${initrds[@]//*\//}"
	[[ $INSTALL_MOD_PATH ]] && (
		cd "$INSTALL_MOD_PATH"
		find lib | cpio -o -H newc --quiet | gzip
	)
	echo  job-script | cpio -o -H newc --quiet | gzip
} > initrd.img

qemu-img create -f qcow2 disk-vm-lkp-hsw-4ep1-openwrt-i386-14-0 256G
qemu-img create -f qcow2 disk-vm-lkp-hsw-4ep1-openwrt-i386-14-1 256G

kvm=(
	qemu-system-i386
	-enable-kvm
	-kernel $kernel
	-initrd initrd.img
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-drive file=disk-vm-lkp-hsw-4ep1-openwrt-i386-14-0,media=disk,if=virtio
	-drive file=disk-vm-lkp-hsw-4ep1-openwrt-i386-14-1,media=disk,if=virtio
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-lkp-hsw-4ep1-openwrt-i386-14::dhcp
	root=/dev/ram0
	user=lkp
	job=/job-script
	ARCH=i386
	kconfig=i386-randconfig-sb0-09131136
	branch=linux-devel/devel-spot-201809131102
	commit=f26eb68a52bb7302d220133440c1438143f2c7e1
	BOOT_IMAGE=/pkg/linux/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/vmlinuz-4.19.0-rc3-00014-gf26eb68
	max_uptime=1500
	RESULT_ROOT=/result/locktorture/300s-cpuhotplug/vm-lkp-hsw-4ep1-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/3
	result_service=tmpfs
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email




Thanks,
Rong, Chen

--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-rc3-00014-gf26eb68"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=40904
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
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
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=64
CONFIG_NR_CPUS_DEFAULT=32
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_2G_OPT=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x78000000
CONFIG_HIGHMEM=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
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
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
CONFIG_X86_POWERNOW_K6=y
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=y
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEBUG=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
# CONFIG_YENTA_RICOH is not set
# CONFIG_YENTA_TI is not set
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
CONFIG_GOOGLE_COREBOOT_TABLE_OF=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
CONFIG_GOOGLE_VPD=m

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
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
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
CONFIG_GCC_PLUGIN_CYC_COMPLEXITY=y
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
CONFIG_ZBUD=m
CONFIG_Z3FOLD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
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
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
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
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_CS5535_MFGPT is not set
CONFIG_HP_ILO=y
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

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
# CONFIG_ECHO is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
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
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_I40E is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_USB_NET_DRIVERS=m
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

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
# CONFIG_KEYBOARD_ADP5520 is not set
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
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_FOCALTECH is not set
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
# CONFIG_JOYSTICK_ZHENHUA is not set
CONFIG_JOYSTICK_AS5011=m
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PSXPAD_SPI=m
# CONFIG_JOYSTICK_PSXPAD_SPI_FF is not set
CONFIG_JOYSTICK_PXRC=m
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
# CONFIG_TOUCHSCREEN_USB_ITM is not set
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
# CONFIG_TOUCHSCREEN_USB_ELO is not set
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
# CONFIG_TOUCHSCREEN_USB_NEXIO is not set
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
# CONFIG_TOUCHSCREEN_TSC2005 is not set
CONFIG_TOUCHSCREEN_TSC2007=m
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
# CONFIG_TOUCHSCREEN_PCAP is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=m
# CONFIG_INPUT_TWL4030_VIBRA is not set
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=m
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=m
# CONFIG_INPUT_PCAP is not set
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
CONFIG_CYZ_INTR=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=y
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
CONFIG_DEVMEM=y
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
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_ASPEED_VUART=m
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
# CONFIG_CARDMAN_4000 is not set
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_PCI=y
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_SCx200_ACB=m
CONFIG_I2C_FSI=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_DLN2=m
CONFIG_SPI_GPIO=m
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=m
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_PALMAS=m
CONFIG_PINCTRL_RK805=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_CS5535=m
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP873X=m
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=m
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_WM831X is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=m
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
CONFIG_GPIO_SODAVILLE=y

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
CONFIG_W1=m

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=m
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_DA9052=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
# CONFIG_BATTERY_TWL4030_MADC is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_CHARGER_TPS65090 is not set
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_RT5033=m
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
# CONFIG_RAVE_SP_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
# CONFIG_KEMPLD_WDT is not set
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=y
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=m
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=m
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=m
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=m
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_RAVE_SP_CORE=m
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_AS3722=m
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=m
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_CEC_CORE=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_VMALLOC=m

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_USB_VIDEO_CLASS is not set
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set

#
# USB HDMI CEC adapters
#
CONFIG_USB_PULSE8_CEC=m
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
# CONFIG_VIDEO_SH_VEU is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#

#
# Video encoders
#
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MC44S803=m

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=m
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DP_CEC=y

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#

#
# Frame buffer Devices
#
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y
# CONFIG_FB_LE80578 is not set
CONFIG_FB_INTEL=m
CONFIG_FB_INTEL_DEBUG=y
# CONFIG_FB_INTEL_I2C is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_GEODE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_RAVE_SP is not set
CONFIG_VGASTATE=m
# CONFIG_LOGO is not set
CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_COUGAR=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=m
# CONFIG_HID_HOLTEK is not set
CONFIG_HID_GOOGLE_HAMMER=m
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=m
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WACOM=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=m

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
# CONFIG_USB_PCI is not set
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_OF_SIMPLE is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_OF=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
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
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_DUMMY_HCD=m
# CONFIG_USB_CONFIGFS is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_FUSB302=m
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=m
CONFIG_UWB=y
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_SDRICOH_CS is not set
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
CONFIG_MMC_TOSHIBA_PCI=m
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_APU=y
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_NET48XX=m
CONFIG_LEDS_WRAP=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_IS31FL319X=m
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXCPLD is not set
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_AMD76X=y
CONFIG_EDAC_E7XXX=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82875P=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=m
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=y
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=m
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_AS3722=m
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8997=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=m
# CONFIG_RTC_DRV_PALMAS is not set
# CONFIG_RTC_DRV_RC5T583 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=m
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=y
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=m
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_PCAP is not set
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=m
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=m
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
CONFIG_PCH_DMA=m
CONFIG_TIMB_DMA=m
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=m
CONFIG_HT16K33=m
CONFIG_CHARLCD=y
# CONFIG_UIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=m
CONFIG_VIRTIO=m
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=y
# CONFIG_COMEDI_PARPORT is not set
CONFIG_COMEDI_SSV_DNP=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
# CONFIG_COMEDI_PCL724 is not set
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=y
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=m
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=m
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=m
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=y
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=m
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
CONFIG_COMEDI_ADDI_APCI_1564=m
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
# CONFIG_COMEDI_ADL_PCI9111 is not set
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
# CONFIG_COMEDI_DAS08_PCI is not set
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
# CONFIG_COMEDI_DAQBOARD2000 is not set
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
# CONFIG_COMEDI_ME_DAQ is not set
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
# CONFIG_COMEDI_NI_LABPC_CS is not set
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
# CONFIG_COMEDI_USBDUXSIGMA is not set
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7780 is not set
CONFIG_AD7816=m
# CONFIG_AD7192 is not set
CONFIG_AD7280=m

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7152=m
CONFIG_AD7746=m

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Active energy metering IC
#
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=m

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1210=m
CONFIG_FB_SM750=m
CONFIG_FB_XGI=m

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_DC30=m
CONFIG_VIDEO_ZORAN_ZR36060=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_ZORAN_AVS6EYES=m

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ION is not set
# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
CONFIG_DGNC=m
CONFIG_GS_FPGABOOT=y
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
CONFIG_PI433=m
CONFIG_MTK_MMC=m
CONFIG_MTK_AEE_KDUMP=y
# CONFIG_MTK_MMC_CD_POLL is not set

#
# Gasket devices
#
CONFIG_XIL_AXIS_FIFO=m
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=m
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
CONFIG_MAILBOX_TEST=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
# CONFIG_SOUNDWIRE is not set

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
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
CONFIG_BMA180=m
CONFIG_BMA220=m
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=m
CONFIG_DMARD06=m
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
# CONFIG_AD7266 is not set
CONFIG_AD7291=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7766=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2497=m
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=m
# CONFIG_MAX1118 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
CONFIG_MCP3422=m
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
# CONFIG_QCOM_SPMI_IADC is not set
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_SD_ADC_MODULATOR=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8688=m
CONFIG_TI_AM335X_ADC=m
# CONFIG_TI_TLC4541 is not set
CONFIG_TWL4030_MADC=m
# CONFIG_TWL6030_GPADC is not set
# CONFIG_VF610_ADC is not set

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set

#
# Amplifiers
#
CONFIG_AD8366=m

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=m
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
# CONFIG_AD5446 is not set
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
# CONFIG_LTC2632 is not set
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=m
CONFIG_AD5758=m
CONFIG_AD5761=m
CONFIG_AD5764=m
CONFIG_AD5791=m
# CONFIG_AD7303 is not set
CONFIG_CIO_DAC=m
# CONFIG_AD8801 is not set
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=m
# CONFIG_VF610_DAC is not set

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
CONFIG_MAX30102=m

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM3605=m
CONFIG_CM36651=m
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=m

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=m
CONFIG_MCP4131=m
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set

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
CONFIG_BMP280_SPI=m
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Resolver to digital converters
#
# CONFIG_AD2S1200 is not set

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_NTB=m
CONFIG_NTB_IDT=m
CONFIG_NTB_SWITCHTEC=m
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_CA91CX42 is not set
CONFIG_VME_TSI148=y
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=m
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=m
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=m
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_RAVE_SP_EEPROM=m

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
CONFIG_SIOX=m
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_CRAMFS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=m
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
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
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
# CONFIG_INTEGRITY_ASYMMETRIC_KEYS is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
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
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_AEGIS128L=m
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=y
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_586=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=m
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_STACKDEPOT=y
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_PAGE_OWNER=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
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
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
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
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_PREEMPTIRQ_EVENTS=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
# CONFIG_KPROBE_EVENTS is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_BPF_KPROBE_OVERRIDE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=m
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_BITFIELD=m
CONFIG_TEST_UUID=m
CONFIG_TEST_OVERFLOW=y
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
CONFIG_TEST_IDA=y
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y

--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='locktorture'
	export testcase='locktorture'
	export category='functional'
	export need_modules=true
	export runtime=300
	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-hsw-4ep1-openwrt-i386/locktorture.yaml'
	export testbox='vm-lkp-hsw-4ep1-openwrt-i386-14'
	export tbox_group='vm-lkp-hsw-4ep1-openwrt-i386'
	export model='qemu-system-i386 -enable-kvm'
	export nr_vm=16
	export nr_cpu=1
	export memory='256M'
	export rootfs='openwrt-i386-2016-03-16.cgz'
	export hdd_partitions='/dev/vda'
	export swap_partitions='/dev/vdb'
	export kconfig='i386-randconfig-sb0-09131136'
	export compiler='gcc-4.9'
	export queue='validate'
	export branch='linux-devel/devel-spot-201809131102'
	export commit='f26eb68a52bb7302d220133440c1438143f2c7e1'
	export repeat_to=4
	export submit_id='5b9b21870b9a9354a54a479a'
	export job_file='/lkp/jobs/scheduled/vm-lkp-hsw-4ep1-openwrt-i386-14/locktorture-300s-cpuhotplug-openwrt-i386-2016-03-16.cgz-f26eb68a52bb7302d220133440c1438143f2c7e1-20180914-87205-1hut0rw-3.yaml'
	export id='e24cb3124a6817bc72172c5e0dccc811d44039a4'
	export need_kconfig='CONFIG_LOCK_TORTURE_TEST=m
CONFIG_KVM_GUEST=y'
	export enqueue_time='2018-09-14 10:48:39 +0800'
	export _id='5b9b21870b9a9354a54a479b'
	export _rt='/result/locktorture/300s-cpuhotplug/vm-lkp-hsw-4ep1-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1'
	export user='lkp'
	export result_root='/result/locktorture/300s-cpuhotplug/vm-lkp-hsw-4ep1-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/3'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/openwrt/openwrt-i386-2016-03-16.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-lkp-hsw-4ep1-openwrt-i386-14/locktorture-300s-cpuhotplug-openwrt-i386-2016-03-16.cgz-f26eb68a52bb7302d220133440c1438143f2c7e1-20180914-87205-1hut0rw-3.yaml
ARCH=i386
kconfig=i386-randconfig-sb0-09131136
branch=linux-devel/devel-spot-201809131102
commit=f26eb68a52bb7302d220133440c1438143f2c7e1
BOOT_IMAGE=/pkg/linux/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/vmlinuz-4.19.0-rc3-00014-gf26eb68
max_uptime=1500
RESULT_ROOT=/result/locktorture/300s-cpuhotplug/vm-lkp-hsw-4ep1-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/3
LKP_SERVER=inn
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
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/modules.cgz'
	export lkp_initrd='/lkp/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export kernel='/pkg/linux/i386-randconfig-sb0-09131136/gcc-4.9/f26eb68a52bb7302d220133440c1438143f2c7e1/vmlinuz-4.19.0-rc3-00014-gf26eb68'
	export dequeue_time='2018-09-14 10:50:02 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-lkp-hsw-4ep1-openwrt-i386-14/locktorture-300s-cpuhotplug-openwrt-i386-2016-03-16.cgz-f26eb68a52bb7302d220133440c1438143f2c7e1-20180914-87205-1hut0rw-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='cpuhotplug' $LKP_SRC/tests/wrapper locktorture
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time locktorture.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--dDnEQgWzhgf+8aPe
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AAAABFla

--dDnEQgWzhgf+8aPe--
