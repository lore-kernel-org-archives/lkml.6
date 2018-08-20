Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5420C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeHTEVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:21:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:48093 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeHTEVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:21:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2018 17:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,263,1531810800"; 
   d="gz'50?scan'50,208,50";a="78251805"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.4])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2018 17:51:31 -0700
Date:   Mon, 20 Aug 2018 08:52:04 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     David Windsor <dave@nullcore.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
Subject: [LKP] ab9ee8e38b [ 22.890412] WARNING: CPU: 0 PID: 632 at
 mm/usercopy.c:81 usercopy_warn
Message-ID: <20180820005204.GB31827@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012
Author:     David Windsor <dave@nullcore.net>
AuthorDate: Thu Aug 24 16:57:57 2017 -0700
Commit:     Kees Cook <keescook@chromium.org>
CommitDate: Mon Jan 15 12:08:00 2018 -0800

    sctp: Define usercopy region in SCTP proto slab cache
    
    The SCTP socket event notification subscription information need to be
    copied to/from userspace. In support of usercopy hardening, this patch
    defines a region in the struct proto slab cache in which userspace copy
    operations are allowed. Additionally moves the usercopy fields to be
    adjacent for the region to cover both.
    
    example usage trace:
    
        net/sctp/socket.c:
            sctp_getsockopt_events(...):
                ...
                copy_to_user(..., &sctp_sk(sk)->subscribe, len)
    
            sctp_setsockopt_events(...):
                ...
                copy_from_user(&sctp_sk(sk)->subscribe, ..., optlen)
    
            sctp_getsockopt_initmsg(...):
                ...
                copy_to_user(..., &sctp_sk(sk)->initmsg, len)
    
    This region is known as the slab cache's usercopy region. Slab caches
    can now check that each dynamically sized copy operation involving
    cache-managed memory falls entirely within the slab's usercopy region.
    
    This patch is modified from Brad Spengler/PaX Team's PAX_USERCOPY
    whitelisting code in the last public patch of grsecurity/PaX based on my
    understanding of the code. Changes or omissions from the original code are
    mine and don't reflect the original grsecurity/PaX code.
    
    Signed-off-by: David Windsor <dave@nullcore.net>
    [kees: split from network patch, move struct members adjacent]
    [kees: add SCTPv6 struct whitelist, provide usage trace]
    Cc: Vlad Yasevich <vyasevich@gmail.com>
    Cc: Neil Horman <nhorman@tuxdriver.com>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: linux-sctp@vger.kernel.org
    Cc: netdev@vger.kernel.org
    Signed-off-by: Kees Cook <keescook@chromium.org>

93070d339d  caif: Define usercopy region in caif proto slab cache
ab9ee8e38b  sctp: Define usercopy region in SCTP proto slab cache
1f7a4c73a7  Merge tag '9p-for-4.19-2' of git://github.com/martinetd/linux
d7857ae43d  Add linux-next specific files for 20180817
+-----------------------------------------+------------+------------+------------+---------------+
|                                         | 93070d339d | ab9ee8e38b | 1f7a4c73a7 | next-20180817 |
+-----------------------------------------+------------+------------+------------+---------------+
| boot_successes                          | 262        | 81         | 239        | 52            |
| boot_failures                           | 1          | 5          | 24         | 4             |
| Mem-Info                                | 1          |            |            |               |
| WARNING:at_mm/usercopy.c:#usercopy_warn | 0          | 5          | 24         | 4             |
| RIP:usercopy_warn                       | 0          | 5          | 24         | 4             |
+-----------------------------------------+------------+------------+------------+---------------+

Kernel tests: Boot OK!
01 00 00 00 60 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00 00 00 00 00 00 00 fb 42 4d 0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0
[   22.708080] can: request_module (can-proto-1) failed.
[   22.853944] ------------[ cut here ]------------
[   22.855033] Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected to SLUB object 'SCTP' (offset 1332, size 4)!
[   22.890412] WARNING: CPU: 0 PID: 632 at mm/usercopy.c:81 usercopy_warn+0x116/0x150
[   22.892304] Modules linked in:
[   22.892907] CPU: 0 PID: 632 Comm: trinity-main Not tainted 4.15.0-rc2-00026-gab9ee8e #2
[   22.907533] task: 00000000b41fece2 task.stack: 00000000f1b1aaa1
[   22.908706] RIP: 0010:usercopy_warn+0x116/0x150
[   22.909730] RSP: 0018:ffffc9000090bd48 EFLAGS: 00010292
[   22.910894] RAX: 0000000000000078 RBX: ffffffff8238882c RCX: 0000000000000000
[   22.912259] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000246
[   22.913628] RBP: ffffc9000090bd88 R08: 0000000001faf8bd R09: 000000000000b3d0
[   22.914918] R10: ffffffff8238a127 R11: 0000000000000002 R12: 0000000000000000
[   22.916308] R13: ffff88001c7eab30 R14: 0000000000000534 R15: 0000000000000534
[   22.917944] FS:  00000000017cc880(0000) GS:ffff88001f600000(0000) knlGS:0000000000000000
[   22.919809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.921076] CR2: 0000000001047de0 CR3: 000000001ba56004 CR4: 00000000001606b0
[   22.922382] Call Trace:
[   22.922854]  __check_heap_object+0x13d/0x260
[   22.923681]  __check_object_size+0x1dd/0x320
[   22.924596]  sctp_setsockopt+0x107c/0x2e70
[   22.925379]  ? __fdget+0x13/0x20
[   22.926061]  ? sockfd_lookup_light+0xae/0x140
[   22.926906]  sock_common_setsockopt+0x14/0x20
[   22.927774]  SyS_setsockopt+0x127/0x130
[   22.928560]  do_syscall_64+0x14c/0x870
[   22.929279]  ? trace_hardirqs_off_thunk+0x1a/0x34
[   22.930315]  entry_SYSCALL64_slow_path+0x25/0x25
[   22.931270] RIP: 0033:0x45878a
[   22.931909] RSP: 002b:00007ffca1de1378 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
[   22.933543] RAX: ffffffffffffffda RBX: 000000000000005c RCX: 000000000045878a
[   22.935167] RDX: 0000000000000004 RSI: 0000000000000084 RDI: 0000000000000143
[   22.936781] RBP: 0000000000000143 R08: 0000000000000004 R09: 0000000001045560
[   22.938396] R10: 0000000001b806f0 R11: 0000000000000202 R12: 000000000183af50
[   22.940003] R13: 00007ffca1de1390 R14: 000000000183af60 R15: 0000000000000002
[   22.941627] Code: 44 d0 41 50 48 c7 c0 3a a6 37 82 41 56 48 c7 c6 33 a1 38 82 41 52 48 0f 44 f0 49 89 f8 31 c0 48 c7 c7 80 a1 38 82 e8 ca 44 d9 ff <0f> ff b9 01 00 00 00 31 d2 be 01 00 00 00 48 c7 c7 38 f6 77 82 
[   22.945952] ---[ end trace 4ba3dd769a294acf ]---
[   61.066734] Writes:  Total: 2  Max/Min: 0/0   Fail: 0 

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.16 v4.15 --
git bisect  bad 1388c80438e69fc01d83fbe98da3cac24c3c8731  # 15:25  B     23     2    3   3  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4bf772b14675411a69b3c807f73006de0fe4b649  # 15:55  G     77     0    4   4  Merge tag 'drm-for-v4.16' of git://people.freedesktop.org/~airlied/linux
git bisect  bad 7e6127c1240ed569cdda2a67c8f03836f9f28c05  # 16:28  B     18     4    1   1  Merge tag 'linux-watchdog-4.16-rc1' of git://www.linux-watchdog.org/linux-watchdog
git bisect  bad 567af7fc9d87df3228ef59864f77fe100ec0cee3  # 16:45  B     33     2    2   2  pinctrl: files should directly include apis they use
git bisect good 1726aa70e7e2f8967d60b4f836723b61f97db73e  # 17:10  G     90     0   10  10  Merge branch 'fixes-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect  bad 4141cf676b9e345d3ddeb1710dd3156a09c50244  # 17:34  B      4     1    1   1  Merge branch 'i2c/for-4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 0771ad44a20bc512d1123bac728d3a89ea6febe6  # 18:01  G     91     0    2   2  Merge tag 'pstore-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect  bad 617aebe6a97efa539cc4b8a52adccd89596e6be0  # 18:35  B     38     5    0   0  Merge tag 'usercopy-v4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good df5f3cfc52fec828af92444bf02ad8fd4e4c59e3  # 18:57  G     91     0    6   6  ufs: Define usercopy region in ufs_inode_cache slab cache
git bisect  bad 07dcd7fe89938934ddad65f738bc5aac89b8e54d  # 19:11  B      6     1    0   0  fork: Define usercopy region in mm_struct slab caches
git bisect good 8c2bc895a9347846b33c47124a75db624aa83677  # 19:39  G     91     0    7   7  ip: Define usercopy region in IP proto slab cache
git bisect  bad ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012  # 19:56  B     21     2    6   6  sctp: Define usercopy region in SCTP proto slab cache
git bisect good 93070d339d7bc6f6b07b64faf5134fd144e8ec48  # 20:17  G     88     0    7   7  caif: Define usercopy region in caif proto slab cache
# first bad commit: [ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012] sctp: Define usercopy region in SCTP proto slab cache
git bisect good 93070d339d7bc6f6b07b64faf5134fd144e8ec48  # 20:27  G    271     0   14  21  caif: Define usercopy region in caif proto slab cache
# extra tests with debug options
git bisect  bad ab9ee8e38b292f9a6698a4fedbb6ff8d08ce2012  # 20:47  B     46     2    2   2  sctp: Define usercopy region in SCTP proto slab cache
# extra tests on HEAD of linux-devel/devel-spot-201808181134
git bisect  bad d29be758fc9872a10f0e1e408674f20804bc9bac  # 20:53  B    320    29    0   7  0day head guard for 'devel-spot-201808181134'
# extra tests on tree/branch linus/master
git bisect  bad 1f7a4c73a739a63b3f108d8eda6f947fdc70dd65  # 21:18  B     27     1    0   0  Merge tag '9p-for-4.19-2' of git://github.com/martinetd/linux
# extra tests with first bad commit reverted
git bisect  bad 6aabc53d346b0c9d4abd1430164566b1c3103434  # 21:45  B      0     2   17   0  Revert "sctp: Define usercopy region in SCTP proto slab cache"
# extra tests on tree/branch linux-next/master
git bisect  bad d7857ae43dcc4b23e61672d365c8094239d7bae4  # 22:03  B     33     2    1   1  Add linux-next specific files for 20180817

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--Bn2rw/3z4jIqBvZU
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-144:20180818195607:x86_64-randconfig-g0-08181208:4.15.0-rc2-00026-gab9ee8e:2.gz"
Content-Transfer-Encoding: base64

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
qNlkuQAA

--Bn2rw/3z4jIqBvZU
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-ivb41-10:20180818201651:x86_64-randconfig-g0-08181208:4.15.0-rc2-00025-g93070d3:2.gz"
Content-Transfer-Encoding: base64

H4sICC8neFsAA2RtZXNnLXlvY3RvLWl2YjQxLTEwOjIwMTgwODE4MjAxNjUxOng4Nl82NC1y
YW5kY29uZmlnLWcwLTA4MTgxMjA4OjQuMTUuMC1yYzItMDAwMjUtZzkzMDcwZDM6MgDsXGtz
2kiz/nzyK7re/bDOOQZrdEPiFG+9+JKEShx7g7O7dVIpSkgjrLWQWF182cqPP90zAoSEMHLI
flpSMUiafqanp7uney7iThI+gRtHaRxyCCJIeZYv8IbHX/HqM/6YJY6bTe54EvHwVRAt8mzi
OZnTB+VRWX5U27NVwygehzzaeKrY5tRU7FdxnuHjjUdMfhWPapSqxhTLtV7J2idZnDnhJA3+
4pulmOITyKtz7sbzRcLTNIhm8CGI8sdutwvXTiJuXHx4Q5deHPHuq9M4zuhmdstBwndffQH8
KF2J+lUCwD1H6jgCvcuMrtJJXLVDdRqdma0pPcXT4Ohumgeh95/wbtG5TR8V9TUczVy3RGl3
dTg659PAKa466uvX8JMK48trGDsZDPMZMAtUpa9Yfc2Gs/ENXjCrytJZPJ87kQdhEKEMEmzD
4MTj9yeJM1fgNo9mk8xJ7yYLJwrcAQOPTxHYWeCF/Jk+pcmfEyd8cJ7SCY+cacg9SNx8gV3K
u/hj4i7ySYpiRmkHc479MsA+gohn3cCPnDlPBwoskiDK7rpY8d08nQ2wibLCDoM09rMwdu/y
xYqJaB5MHpzMvfXi2UDchDhepMXPMHa8CbLvBendQEVo7MFsdUMBL5l63XkQxcnEjfMoG1jU
iIzPvW4Yz1Bj7nk44EkCwQzL8AneFPeWSjzIsicFhF5LtunGWDlmzFCxYaVS65v3M2eAYHMn
hOSBZH03OHH54tZPT2RXnyR51Pkz5zk/eYrdLO4E91OdnTxa5sTUOwn2EOL6wawzUzqKxSym
KtZJSOrU8Yi5vvjbSRdx1qFuFmWYpvcLldJsrzd1Td+cKr2pqfuOb+BT32O6zi3u6lZ/GqTc
zToSU7dOuvdz+v1XZ1+EVb34rWpqp2f1S03pMAWm2A73dlBi+6SBbTi9urqZjC6Hby8GJ4u7
mWzqM+JAC+mgLZzsy/DJsoXNhrhFV0i3eeJ309s88+KHaKBUTQq5PPEXeR/G+WIRJ8Ip/D4e
/noBPneyPOHC1bA+/Pxo9cBHfRVFFjEqEyR8FqAyJunPL4NVEXY8vvhuHB1xhr/+vg/OI1p3
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

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-ivb41-144:20180818195607:x86_64-randconfig-g0-08181208:4.15.0-rc2-00026-gab9ee8e:2"

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

--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.15.0-rc2-00026-gab9ee8e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.15.0-rc2 Kernel Configuration
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
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
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
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
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
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ_FULL_ALL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
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
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
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
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
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
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_TRIM_UNUSED_KSYMS=y
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
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
# CONFIG_INTEL_RDT is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=m
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
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
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=64
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# CONFIG_VM86 is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=m
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_DEVICE_PUBLIC=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_UMIP is not set
CONFIG_X86_INTEL_MPX=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_LEGACY_VSYSCALL_NATIVE is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_IPMI=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_DPTF_POWER=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_TPS68470_PMIC_OPREGION is not set
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
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y

#
# PCI host controller drivers
#
# CONFIG_VMD is not set

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=m

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=m
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
CONFIG_IPV6_ILA=m
# CONFIG_INET6_XFRM_TUNNEL is not set
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=y
CONFIG_IPV6_VTI=y
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=y
# CONFIG_IPV6_FOU_TUNNEL is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
# CONFIG_NF_CT_PROTO_DCCP is not set
# CONFIG_NF_CT_PROTO_SCTP is not set
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
# CONFIG_NF_CONNTRACK_FTP is not set
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
# CONFIG_NF_CONNTRACK_PPTP is not set
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=y
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
# CONFIG_NF_NAT_AMANDA is not set
# CONFIG_NF_NAT_FTP is not set
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
# CONFIG_NF_NAT_TFTP is not set
CONFIG_NF_NAT_REDIRECT=m
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_EXTHDR is not set
# CONFIG_NFT_META is not set
# CONFIG_NFT_RT is not set
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
# CONFIG_NFT_SET_RBTREE is not set
# CONFIG_NFT_SET_HASH is not set
# CONFIG_NFT_SET_BITMAP is not set
# CONFIG_NFT_COUNTER is not set
# CONFIG_NFT_LOG is not set
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
CONFIG_NFT_OBJREF=m
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=y
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=y
# CONFIG_NETFILTER_XT_SET is not set

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
# CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=y
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=y
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
# CONFIG_NETFILTER_XT_TARGET_TRACE is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=y
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_CPU=y
# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
# CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ECN=y
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=y
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=y
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=y
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=y
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
CONFIG_NETFILTER_XT_MATCH_TIME=y
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
# CONFIG_IP_SET_HASH_IPPORT is not set
CONFIG_IP_SET_HASH_IPPORTIP=y
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
CONFIG_IP_SET_HASH_MAC=y
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=y
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
CONFIG_IP_VS_PROTO_UDP=y
# CONFIG_IP_VS_PROTO_AH_ESP is not set
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=y
# CONFIG_IP_VS_WRR is not set
CONFIG_IP_VS_LC=y
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
CONFIG_IP_VS_OVF=y
CONFIG_IP_VS_LBLC=m
# CONFIG_IP_VS_LBLCR is not set
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=y
CONFIG_IP_VS_NQ=y

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
# CONFIG_NF_CONNTRACK_IPV4 is not set
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_CHAIN_ROUTE_IPV4=m
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
# CONFIG_NFT_FIB_IPV4 is not set
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
# CONFIG_IP_NF_SECURITY is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_CONNTRACK_IPV6=y
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_TABLES_IPV6=y
# CONFIG_NFT_CHAIN_ROUTE_IPV6 is not set
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=y
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=y
CONFIG_NF_NAT_IPV6=m
# CONFIG_NFT_CHAIN_NAT_IPV6 is not set
CONFIG_NF_NAT_MASQUERADE_IPV6=m
CONFIG_NFT_MASQ_IPV6=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_AH=y
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=y
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
CONFIG_IP6_NF_MANGLE=y
# CONFIG_IP6_NF_RAW is not set
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
CONFIG_NF_TABLES_BRIDGE=y
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
# CONFIG_BRIDGE_EBT_T_NAT is not set
CONFIG_BRIDGE_EBT_802_3=m
# CONFIG_BRIDGE_EBT_AMONG is not set
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
# CONFIG_BRIDGE_EBT_LIMIT is not set
# CONFIG_BRIDGE_EBT_MARK is not set
# CONFIG_BRIDGE_EBT_PKTTYPE is not set
CONFIG_BRIDGE_EBT_STP=m
# CONFIG_BRIDGE_EBT_VLAN is not set
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_BRIDGE_EBT_REDIRECT is not set
# CONFIG_BRIDGE_EBT_SNAT is not set
CONFIG_BRIDGE_EBT_LOG=m
# CONFIG_BRIDGE_EBT_NFLOG is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
# CONFIG_NET_SCTPPROBE is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
# CONFIG_TIPC_MEDIA_UDP is not set
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
# CONFIG_IPDDP is not set
CONFIG_X25=m
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_6LOWPAN=m
CONFIG_6LOWPAN_DEBUGFS=y
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=y
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=m
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=m
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_FLOW=m
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
# CONFIG_BAYCOM_PAR is not set
# CONFIG_YAM is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
# CONFIG_BT_RFCOMM_TTY is not set
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
CONFIG_BT_LEDS=y
CONFIG_BT_SELFTEST=y
CONFIG_BT_SELFTEST_ECDH=y
CONFIG_BT_SELFTEST_SMP=y
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
CONFIG_CFG80211_REG_RELAX_NO_IR=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_CRDA_SUPPORT is not set
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_DEBUG=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
# CONFIG_MAC80211_RC_MINSTREL_HT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
# CONFIG_MAC80211_VERBOSE_DEBUG is not set
# CONFIG_MAC80211_MLME_DEBUG is not set
# CONFIG_MAC80211_STA_DEBUG is not set
# CONFIG_MAC80211_HT_DEBUG is not set
CONFIG_MAC80211_OCB_DEBUG=y
# CONFIG_MAC80211_IBSS_DEBUG is not set
# CONFIG_MAC80211_PS_DEBUG is not set
# CONFIG_MAC80211_TDLS_DEBUG is not set
# CONFIG_MAC80211_DEBUG_COUNTERS is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
# CONFIG_CAIF_USB is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_FDP=m
# CONFIG_NFC_FDP_I2C is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_MICROREAD=m
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_DEVLINK=m
CONFIG_MAY_USE_DEVLINK=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_HWSPINLOCK=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
CONFIG_MTD_MAP_BANK_WIDTH_8=y
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
CONFIG_MTD_MAP_BANK_WIDTH_32=y
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
CONFIG_MTD_PCI=m
CONFIG_MTD_GPIO_ADDR=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
CONFIG_MTD_LATCH_ADDR=m

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
CONFIG_MTD_NAND_RICOH=m
# CONFIG_MTD_NAND_DISKONCHIP is not set
CONFIG_MTD_NAND_DOCG4=m
CONFIG_MTD_NAND_CAFE=m
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

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
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=m
# CONFIG_VMWARE_BALLOON is not set
CONFIG_USB_SWITCH_FSA9480=m
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=m

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=m

#
# Intel MIC Host Driver
#
CONFIG_INTEL_MIC_HOST=m

#
# Intel MIC Card Driver
#
# CONFIG_INTEL_MIC_CARD is not set

#
# SCIF Driver
#
CONFIG_SCIF=m

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
CONFIG_MIC_COSM=m

#
# VOP Driver
#
# CONFIG_VOP is not set
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
# CONFIG_MACVTAP is not set
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
CONFIG_GTP=y
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN=y
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=y
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
# CONFIG_ARCNET_COM20020_PCI is not set

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
CONFIG_CAIF_SPI_SLAVE=m
# CONFIG_CAIF_SPI_SYNC is not set
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_B53 is not set
# CONFIG_NET_DSA_LOOP is not set
# CONFIG_NET_DSA_MT7530 is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_MICROCHIP_KSZ is not set
CONFIG_NET_DSA_MV88E6XXX=m
# CONFIG_NET_DSA_MV88E6XXX_GLOBAL2 is not set
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
# CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_NET_VENDOR_AGERE is not set
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=y
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=m
CONFIG_THUNDER_NIC_VF=y
CONFIG_THUNDER_NIC_BGX=y
CONFIG_THUNDER_NIC_RGX=y
CONFIG_LIQUIDIO=m
# CONFIG_LIQUIDIO_VF is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
CONFIG_CX_ECAT=y
CONFIG_DNET=m
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=y
CONFIG_VXGE=m
CONFIG_VXGE_DEBUG_TRACE_ALL=y
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=m
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_CORE=m
# CONFIG_MLX4_DEBUG is not set
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
# CONFIG_MLX5_FPGA is not set
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_MPFS=y
# CONFIG_MLX5_ESWITCH is not set
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLXSW_CORE=m
# CONFIG_MLXSW_CORE_HWMON is not set
CONFIG_MLXSW_CORE_THERMAL=y
# CONFIG_MLXSW_PCI is not set
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
CONFIG_FEALNX=m
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
CONFIG_NET_PACKET_ENGINE=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=y
# CONFIG_QLCNIC_SRIOV is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
CONFIG_8139_OLD_RX_RESET=y
CONFIG_R8169=m
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
CONFIG_SFC_FALCON=y
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
CONFIG_SMSC911X=m
# CONFIG_SMSC911X_ARCH_HOOKS is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=m
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_THUNDER=y
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=y
CONFIG_DP83848_PHY=m
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=y
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROSEMI_PHY=m
# CONFIG_NATIONAL_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_MPPE is not set
CONFIG_PPP_MULTILINK=y
# CONFIG_PPPOE is not set
CONFIG_PPTP=m
# CONFIG_PPPOL2TP is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=m

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WIRELESS_WDS=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS is not set
# CONFIG_ATH5K is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
# CONFIG_ATH9K_DEBUGFS is not set
CONFIG_ATH9K_DFS_CERTIFIED=y
CONFIG_ATH9K_DYNACK=y
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_CHANNEL_CONTEXT=y
CONFIG_ATH9K_PCOEM=y
# CONFIG_ATH9K_HWRNG is not set
CONFIG_ATH6KL=m
# CONFIG_ATH6KL_SDIO is not set
# CONFIG_ATH6KL_DEBUG is not set
# CONFIG_ATH6KL_TRACING is not set
# CONFIG_ATH6KL_REGDOMAIN is not set
# CONFIG_WIL6210 is not set
CONFIG_ATH10K=m
# CONFIG_ATH10K_PCI is not set
CONFIG_ATH10K_SDIO=m
CONFIG_ATH10K_DEBUG=y
# CONFIG_ATH10K_DEBUGFS is not set
# CONFIG_ATH10K_TRACING is not set
# CONFIG_ATH10K_DFS_CERTIFIED is not set
# CONFIG_WCN36XX is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_WLAN_VENDOR_INTEL is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_PRISM54=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_SDIO=m
CONFIG_LIBERTAS_DEBUG=y
# CONFIG_LIBERTAS_MESH is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
CONFIG_RSI_DEBUGFS=y
CONFIG_RSI_SDIO=m
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SDIO=m
# CONFIG_WL12XX is not set
CONFIG_WL18XX=m
CONFIG_WLCORE=m
# CONFIG_WLCORE_SDIO is not set
# CONFIG_WILINK_PLATFORM_DATA is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
CONFIG_WAN=y
CONFIG_LANMEDIA=m
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
# CONFIG_HDLC_PPP is not set
# CONFIG_HDLC_X25 is not set
CONFIG_PCI200SYN=m
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
CONFIG_LAPBETHER=m
# CONFIG_X25_ASY is not set
# CONFIG_SBNI is not set
CONFIG_VMXNET3=y
# CONFIG_FUJITSU_ES is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
CONFIG_JOYSTICK_COBRA=m
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
# CONFIG_JOYSTICK_GUILLEMOT is not set
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=m
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=m
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=y
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
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

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
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=m
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=m
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_CROS_EC_TUNNEL is not set
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_AXP209 is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_UCB1400=m
# CONFIG_GPIO_WHISKEY_COVE is not set
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_RDC321X=y
CONFIG_W1=m

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS2760=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=m
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
# CONFIG_SENSORS_SCH56XX_COMMON is not set
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_BXT_PMIC_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SILENT=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=m
CONFIG_MFD_CROS_EC_I2C=m
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_BXTWC=m
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS68470=y
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9063 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=m
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_ALPHA_SUPPORT=y
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
# CONFIG_DRM_HISI_HIBMC is not set
CONFIG_DRM_TINYDRM=m
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
CONFIG_FB_N411=m
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP5520=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_VGASTATE=m
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_VIRMIDI=m
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
CONFIG_SND_BEBOB=m
# CONFIG_SND_FIREWIRE_DIGI00X is not set
CONFIG_SND_FIREWIRE_TASCAM=m
# CONFIG_SND_FIREWIRE_MOTU is not set
CONFIG_SND_FIREFACE=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_I2S_HI6210_I2S=m
# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_ZX_TDM=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DIO2125=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5514_SPI_BUILTIN is not set
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5645=m
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_WM8510 is not set
CONFIG_SND_SOC_WM8523=m
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=m
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_X86 is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=m
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_TYPEC_UCSI is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=m
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA903X=y
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_ACCESSIBILITY=y
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
CONFIG_INFINIBAND_USER_ACCESS=m
# CONFIG_INFINIBAND_EXP_USER_ACCESS is not set
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
# CONFIG_INFINIBAND_NES is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
# CONFIG_INFINIBAND_OPA_VNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IOATDMA=y
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780=m
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=y
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=m

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=y
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DELL_SMBIOS=y
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_WMI_DESCRIPTOR=y
# CONFIG_DELL_WMI_AIO is not set
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_SMO8800=y
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=y
CONFIG_PANASONIC_LAPTOP=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_MSI_WMI is not set
CONFIG_PEAQ_WMI=y
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_CHT_INT33FE is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=y
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=y
CONFIG_MXM_WMI=m
CONFIG_SAMSUNG_Q10=y
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
CONFIG_INTEL_PMC_IPC=y
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_TELEMETRY is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_MLX_CPLD_PLATFORM is not set
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_CLK_TWL6040=m
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=m
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_VIRTIO=m

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
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ARIZONA is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_AMD=m
CONFIG_NTB_IDT=m
# CONFIG_NTB_INTEL is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
# CONFIG_SERIAL_IPOCTAL is not set
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=m
CONFIG_FMC_FAKEDEV=m
# CONFIG_FMC_TRIVIAL is not set
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

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
# CONFIG_DAX is not set
# CONFIG_NVMEM is not set
CONFIG_STM=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=m
# CONFIG_INTEL_TH is not set
# CONFIG_FPGA is not set

#
# FSI support
#
# CONFIG_FSI is not set
CONFIG_PM_OPP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_INDEX=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
# CONFIG_NFSD_V4 is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_SUNRPC_XPRT_RDMA=m
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_WEAK_PW_HASH=y
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
# CONFIG_CIFS_POSIX is not set
# CONFIG_CIFS_ACL is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
CONFIG_CIFS_FSCACHE=y
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEBUG is not set

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
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_STACK_VALIDATION is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
# CONFIG_PAGE_POISONING_ZERO is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
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
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_KPROBE_EVENTS is not set
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_PROBE_EVENTS is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
CONFIG_MMIOTRACE_TEST=m
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set

#
# Runtime Testing
#
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIND_BIT is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_MEMTEST=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
# CONFIG_SECURITY_WRITABLE_HOOKS is not set
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_SMACK=y
CONFIG_SECURITY_SMACK_BRINGUP=y
CONFIG_SECURITY_SMACK_NETFILTER=y
# CONFIG_SECURITY_SMACK_APPEND_SIGNALS is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
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
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
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
CONFIG_CRC16=m
CONFIG_CRC_T10DIF=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=m
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
CONFIG_DMA_VIRT_OPS=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

--Bn2rw/3z4jIqBvZU--
