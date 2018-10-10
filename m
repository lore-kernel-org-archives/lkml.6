Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752652087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752652087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJKCzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:55:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:56936 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeJKCyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:54:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 12:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="gz'50?scan'50,208,50";a="87343333"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2018 12:30:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gAKBb-000CXI-U5; Thu, 11 Oct 2018 03:30:23 +0800
Date:   Thu, 11 Oct 2018 03:30:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: 1be3f247c2 ("x86/mm: Avoid VLA in pgd_alloc()"):  WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page
Message-ID: <5bbe533d.ZiUDOU5r/w4zTD+X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit 1be3f247c2882a82279cbcf43717581ea943b692
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri Oct 5 18:13:16 2018 +0200
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Fri Oct 5 18:16:55 2018 +0200

    x86/mm: Avoid VLA in pgd_alloc()
    
    Turning on -Wvla found a new VLA usage:
    
      arch/x86/mm/pgtable.c: In function 'pgd_alloc':
      include/linux/build_bug.h:29:45: error: ISO C90 forbids variable length array 'u_pmds' [-Werror=vla]
      arch/x86/mm/pgtable.c:190:34: note: in expansion of macro 'static_cpu_has'
       #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
                                        ^~~~~~~~~~~~~~
      arch/x86/mm/pgtable.c:431:16: note: in expansion of macro 'PREALLOCATED_USER_PMDS'
        pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
                    ^~~~~~~~~~~~~~~~~~~~~~
    
    Use the actual size of the array that is used for X86_FEATURE_PTI
    instead of the variable size.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Andy Lutomirski <luto@kernel.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Joerg Roedel <jroedel@suse.de>
    Cc: Kees Cook <keescook@chromium.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Toshi Kani <toshi.kani@hpe.com>
    Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
    Fixes: f59dbe9ca670 ("x86/pgtable/pae: Use separate kernel PMDs for user page-table")
    Link: http://lkml.kernel.org/r/20181005161333.765973-1-arnd@arndb.de
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

02e425668f  x86/vdso: Fix vDSO syscall fallback asm constraint regression
1be3f247c2  x86/mm: Avoid VLA in pgd_alloc()
7f3049305d  Add linux-next specific files for 20181010
+---------------------------------------------------------------------------------+------------+------------+---------------+
|                                                                                 | 02e425668f | 1be3f247c2 | next-20181010 |
+---------------------------------------------------------------------------------+------------+------------+---------------+
| boot_successes                                                                  | 2          | 0          | 0             |
| boot_failures                                                                   | 37         | 13         | 13            |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page                             | 37         | 11         | 13            |
| EIP:note_page                                                                   | 37         | 11         | 13            |
| Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:pgd_alloc | 0          | 13         | 13            |
+---------------------------------------------------------------------------------+------------+------------+---------------+

[    4.542866] Write protecting the kernel text: 8064k
[    4.543445] Write protecting the kernel read-only data: 2512k
[    4.544085] NX-protecting the kernel data: 6272k
[    4.544782] ------------[ cut here ]------------
[    4.545294] x86/mm: Found insecure W+X mapping at address (ptrval)/0x400a0000
[    4.546083] WARNING: CPU: 0 PID: 1 at arch/x86/mm/dump_pagetables.c:283 note_page+0x775/0x9a0
[    4.547210] Modules linked in:
[    4.547554] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-rc6-00008-g1be3f24 #3
[    4.548537] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    4.549509] EIP: note_page+0x775/0x9a0
[    4.549960] Code: c6 05 0d 02 10 50 01 c7 04 24 01 00 00 00 e8 32 d4 0e 00 8b 43 14 c7 04 24 38 61 fa 4f 89 44 24 08 89 44 24 04 e8 bb bf 00 00 <0f> 0b 31 c9 ba 01 00 00 00 b8 48 10 12 50 c7 04 24 01 00 00 00 e8
[    4.551980] EAX: 00000041 EBX: 55d19f28 ECX: 00000000 EDX: 00000000
[    4.552658] ESI: 00000002 EDI: 00000000 EBP: 55d19ed0 ESP: 55d19e90
[    4.553349] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210202
[    4.554095] CR0: 80050033 CR2: 00000000 CR3: 1029a000 CR4: 000006f0
[    4.554787] Call Trace:
[    4.555069]  ? ptdump_walk_pgd_level_core+0x2ca/0x430
[    4.555621]  ? ptdump_walk_pgd_level_checkwx+0x20/0x30
[    4.556195]  ? mark_rodata_ro+0x135/0x160
[    4.556638]  ? rest_init+0xc0/0xc0
[    4.557026]  ? kernel_init+0x36/0x110
[    4.557431]  ? schedule_tail_wrapper+0x9/0xc
[    4.557909]  ? ret_from_fork+0x19/0x24
[    4.558327] ---[ end trace 60fc883517612381 ]---
[    4.559168] x86/mm: Checked W+X mappings: FAILED, 96 W+X pages found.

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 7f3049305d22fc543f836d00aeea41ecef911199 0238df646e6224016a45505d2c111a24669ebe21 --
git bisect good 2cca37b51d8e170e155d7f48e2ed70eb173d6683  # 22:26  G     11     0   11  11  Merge remote-tracking branch 'pm/linux-next'
git bisect good e98a5fe7876fd5973cef61a456871f309b33e16d  # 22:39  G     11     0   11  11  Merge remote-tracking branch 'mailbox/mailbox-for-next'
git bisect  bad 8667f75a95698773efa55d7fbdef4bad664f7060  # 22:54  B      0    11   26   0  Merge remote-tracking branch 'staging/staging-next'
git bisect  bad 1aa53b331a38c3dd9043cc83dfea942ecb4d420f  # 23:09  B      0     8   23   0  Merge remote-tracking branch 'xen-tip/linux-next'
git bisect  bad 141a3469aafcf6b6e63a307ad8766a9a2ed63416  # 23:27  B      0    11   26   0  Merge remote-tracking branch 'rcu/rcu/next'
git bisect  bad 6a2e03f7dd9fec432789e77c34743c8773155461  # 23:40  B      0     3   18   0  Merge remote-tracking branch 'tip/auto-latest'
git bisect good 6818e8c338148c99696d3958f5661075c23a39bc  # 00:02  G     11     0   11  11  Merge remote-tracking branch 'spi/for-next'
git bisect good fac07d2ba7b2764e3002ff9bc7861742a84a2ef6  # 00:17  G     11     0   11  13  Merge branch 'perf/core'
git bisect good 245e5707dd7df01428459d97a9121f14a57dac6b  # 00:29  G     11     0   11  11  Merge branch 'x86/build'
git bisect  bad d74865bd3996c7a6f3e8ce6e626c1fe474e39494  # 00:45  B      0    11   28   2  Merge branch 'x86/mm'
git bisect  bad ff5a98047da9c79f295e976cb8f227802a0aba00  # 01:00  B      0    11   27   1  Merge branch 'x86/early-printk'
git bisect good 4044240365e85ef7ae43a6dc454669b57853124c  # 01:17  G     11     0   11  11  x86/xen: Add Hygon Dhyana support to Xen
git bisect  bad edbdd2c8bd30da45629e6466714c86eec915364a  # 01:35  B      0    11   26   0  x86/intel_rdt: CBM overlap should also check for overlap with CDP peer
git bisect good 2cc81c6992248ea37d0241bc325977bab310bc3b  # 01:47  G     11     0   11  11  x86/intel_rdt: Show missing resctrl mount options
git bisect  bad e8bd1803aec89dfce5758d88022963fe3248bc4c  # 02:00  B      0    11   26   0  x86/intel_rdt: Fix out-of-bounds memory access in CBM tests
git bisect  bad 1be3f247c2882a82279cbcf43717581ea943b692  # 02:09  B      0    11   26   0  x86/mm: Avoid VLA in pgd_alloc()
# first bad commit: [1be3f247c2882a82279cbcf43717581ea943b692] x86/mm: Avoid VLA in pgd_alloc()
git bisect good 02e425668f5c9deb42787d10001a3b605993ad15  # 02:33  G     33     0   33  33  x86/vdso: Fix vDSO syscall fallback asm constraint regression
# extra tests with debug options
git bisect  bad 1be3f247c2882a82279cbcf43717581ea943b692  # 02:44  B      0     4   19   0  x86/mm: Avoid VLA in pgd_alloc()
# extra tests on HEAD of linux-next/master
git bisect  bad 7f3049305d22fc543f836d00aeea41ecef911199  # 02:49  B      0    13   31   0  Add linux-next specific files for 20181010
# extra tests on tree/branch linux-next/master
git bisect  bad 7f3049305d22fc543f836d00aeea41ecef911199  # 02:50  B      0    13   31   0  Add linux-next specific files for 20181010
# extra tests with first bad commit reverted
git bisect good 8fbba563cf92c53cfaa19dfde35227f3be3a079e  # 03:28  G     11     0   11  11  Revert "x86/mm: Avoid VLA in pgd_alloc()"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-ivb41-64:20181011020847:i386-randconfig-b0-10101847:4.19.0-rc6-00008-g1be3f24:3.gz"

H4sICB1TvlsAA2RtZXNnLXF1YW50YWwtaXZiNDEtNjQ6MjAxODEwMTEwMjA4NDc6aTM4Ni1y
YW5kY29uZmlnLWIwLTEwMTAxODQ3OjQuMTkuMC1yYzYtMDAwMDgtZzFiZTNmMjQ6MwC0XG1v
27iy/nzurxhgv6R3I1uk3g344OR1G7Rusk26XdwiMGS9ODqRJVeS87Loj78zpGRLtmS53a6C
xrLEefhwOEPOkGwCN4tfwUuTPI0DiBLIg2K1xAd+8D9fAC91oIrrHt5HyeoFnoIsj9IE9AFz
BqqSeaZCr21lzmaBFnIdjh5nqyj2/xM/LpXnfKEES/YGjuaeV5N1BljuPJhFbvlN4W/ewC8a
3E5u4ObjxcXk5g7uHlZw7RXAGKh8pJojXYOz2zvgKrO3yb3Y5jBcrkZ4Y8HlzSd4juIYVnkA
l3/envxxsV3+9Or6Vllm6VPkBz4sH17zyHNj+HgygYW7HLUWD2yujuDLIliA+qJuXUrjkRPO
wvAe63dn8Y4i94I5obcLFhJYFuRB9hT43wUX7nILfxyObTeVWaHPwh9pKknyHbAf5hYGISmu
DkePfhhOojXgwj44P5it5iOI5kmaRckc4nQeB09BTD5V4IPBtsCHP+Ho4iXwVkUA55FQ4BtA
oywCr0A/GYGLn087Sr2dEHHgAxsLI5ek2EE+n1yN4PeLySe4LdzEdzMfbs7gKNJ19fJP+BVu
rq7+PAbmOOabY6EGYAOmDriCrqYPVTZEH9O3Qd++LrHdUZ5m2FTiGPgjePfHZLvc49NC8eLU
exzBp5wUscizHPSZYeq+ygD5VF/UhihriHrLFajHJAtM5a6D74+xvdHCzV7FS1FuD8BK1J17
D+jgaRhiJ+AHcJ1xblk2B+/Vi4O8AWDfS9Q8XWVeMKqjLdwcf6sv4daFL16mEopeM8/XeaD7
YTg7Fq8iPw6mCb6zbWY4quEw3dYgadTLzHsocm8E56VagZuONjBUGyZv/yKL8IIc1b6RMWyb
34M03dXSd9GAtiy4styac8J4/O8W4zVsx6mwsmCRPtWx3A1Waf3bjo4t0u4hdvNiugwTGJMS
yLdF693Me9g8lszqoqZxD5O7jx/RoEJ3FRdQoI2N4DmLikCZufX+xcJOWTiMXlBHmZvMgxyC
hPj4o3pJS7+ne8HducSrA9GyqNyJKHcqyq0Sz/UetltoMyp3Jspd1vBKX20UrVr05GaR0Poe
nrYjeMLMxYkKza/sO2FscHm5/t7OyuEkzcCXQ4ffeGfQO97+TrRaa38nGOkt70xVFfUZ7e9E
fWb7O1Gf1fpO0+TcfXNyN4KzNAmj+SpzafSDL6pi3Y/g8ynA5zuAT2cK/oOd73U0nUZHD2OK
EMcoCiUwoOnwCw1tuS5qOftEa7OynI1rooztFa3NwGFTlHGN1BamKxwRSW5yoxTCZNyiDmC6
RgWAt+iCGKEs0QGo1NGyyJ7c+E0DlcYTgMUSRxSUMFUlNGeWVy+hY1dGSVREGPNgRSkOqRJ0
ZybEihlju8wNmj/JbEvxInMXyzSOkqDJC5wZWXAe/RUAMzVbr4HoFtI4/fgOuxoHB90jez+G
8l4MNje/3Z2cvr+oyRikspqMU5OZdckwtSHj1WS8Thm9IePXZPwuGbJmDCHPr27frRXJTMue
lYq0Qm9bkYaOnXVydoPz9YWIxaUF4KyF09BqQTFzFGJsKlxix4MYN2msk/Ifb89vmtHfpWnr
qhgHGcbbT9gPp9dnb2/hTR3ArgPcNUK0ywtmclsAaCoBsBIATv+8OZPFy7LiyfpbowIai2QF
l/ixXYFuSTFL36lAFu+twKIBRlZwvtsCVRUqYLp2tlPB+WEtsJhZa8HtTgWq1LGu1mW4Vsmc
3FydbbfasKSMvatWWbyflMarCt7eXOz0m3EpK9DsnQpk8f4KdKeq4H1KyZEg5vo+hhA5RUJB
IITqIoaxHp1E6SKF6grLmBqO1k9KgEalFqrtQwofPk1OKC2tzQdinGwUxV65dB8pynMhwYy1
OW42rracpY5F0/aH6/OL6fnJ3cmR+gbcGOM+l2Kxyo9RrEQSt9sINBurk1N4e/Xb28nFBNwn
N4rJWweNUliPZmtY7v315z3F7HsRP8Xpcxk+iZjqGB6i+UNeuFlRf1yTtEWmnj5Xw3KQ+Dmp
5Yn6DYwy6WoIoMLfImolIdD7ZOQEIzsaOWKMs8DoFxRgbaVtKt1bjMztA/biiML+dRtHgGE/
tkLeO2FdwhABya3MrkQST1YwRV7gZpn7SuYn7EIVUzMi5KOGvAwTof7MVDtY0PC/5rGjdvNv
UjENSUUnD6F5EISviJAZmHhaL26hSv8vTargsgElg9Vz9B9xtTgEU7fWBMKd+d22BaEPabZA
z99FYQe5le2ohELmNUF5CBbL4rXxHntgkj6JKe8vao/QuFBRgBGvUFmjPBqenCZLaxU6lUpo
lBNhrHiJj1oXbXaUoDrBFn1HRrx7YLoXRBowyPoKoy2SlutrpSn002rHw9ZdJxVIkRZuvHTJ
DAAzFbPmVDpnRmUMpN4R2heIorQ05gs9IwW00oaM05SpRHZSRyzLebOs5ji2LH4M768urzG1
KbyHUZ2TxtSaaUkxh/fz0ijP3JbTMUBpqU9jG0FTkJQrEWJS8rMIo6oq5awVFK4jZ7ybiXIX
LbDU1TXcpFlBub2p2o3C5ndOj6btrAOV91R6+mFyBUeut4ymkf+F1hbuwQ9j8Q8j6YJCz/va
7Gg6GnbN1TXJflExN3KXkYeiNFRVa6vMOm6QEMtY+P632ytQFa7V0fR15Hf14W56+/Fsev3H
RziarXLKSVf5NMq+4t08TmduLL7wil+DlW6TfaOOKHsnMpgI0EeRRXP6FID4efXxd/EpNHV1
DuvbDxiP8DqiwQ9gZtSZGWJqBLHg1iBHIckOOVaS07bIGR3kjAaifQA5p07O6SJnsu8g53SQ
cxqIxgHkWKNT8VsXvbaO7aLndtBz64gWO4Qea9BjXfQo9TmY3qyD3qyBuOnaj7+rcjCavUKK
3pVFfj1GM8Wi0MFWzzpqZw3ENlPtQtQ6EBsebn+PZ+odiHod0WE1DRn7NeS09U9X7WZH7WYD
0foORKsD0dogWirFywcj2h2IdgNRq2nI2achLGvWyrK9BmeJ5elNYba/MOPf0S6vo11eA/F7
rNPvQPQbiN9jnUEHYlBH5N/T6rADMWwgmuvYAVUPR5OT87s365W+ZoYaJSEFJ3Rfh9DURqIe
+RRMYFZkuhzzb1r7FRsLgb8VL6AkKihfLGdpik06wYz0mYhwOLv5hPEODttpsYxXc/G9LkcT
e5mdyWiB0g8K8cVa3FEVFbypy1jIskp17XV0T5toclltnaiKxt+cXWEA9RR5QaNiyt5Pka1I
gtzMfYqyYuXG0V/I5DHIkiAG1FN9zwiFbHVr2yULwigJfOW/URhGFNZub75sbbpUj7d2XJjD
GDdRGSa3DJFIJXWyjOFQhqmDn2JSOg+Kqbyfzl4LjEMxoospEs3SRZkGSv6/qi+uMcRg0Gfw
HBUP4GXJfEprqeN61zGyGxHrT5dB5tHO9IePU+yn25HGIcmm+IhaNZ1FRb55hOTzkfgi0kf6
xuqotGFR4V0sZoFPu9fckhHwkHbF/lOtvEJuM8vWIVPBx3ROtWHFmGo4vI5H88MSxRSx3DHq
lJHLIWNu/a+uOmYdgZY96ggYl1Jig79ZLWO1OMfRA/u9zH/c/DXx4OZS2JLY6auXpZUt2nrL
i8CNCwzDm7uBpuZ4jt6UwLj4dBXFBdZKmUEc5QV6yCKdRXFUvMI8S1dLMso0GQDcUcYEVcpk
8YbTcVobv0njyHstkwyZcTSKYDe8k+bspZimJD7F62S5aPvjITrGMHMX6J8rtI2CunnpJpE3
ZnKPWMTtY3mbv+bZ16kbP7uv+bTcI4LMk5t6A7wRZoEWGMdTUkW6KsaMTDkoBlGYuIsgH6u0
L5oUjwOs+HGRz8foY7JChUGehgU5F1liSSJZRNNnypP8dD4WDyFNl3l5G6euj76w8KP8ccxp
9xGz9vUDtIxs5g8WUZKixaarpBjb1IgiWPiDOJ1PRZg2xhlJboQH0/U2eHnKZFwUryqm95jF
S9r04FY9ZszgtO6xKbV5+DR3x4lM/LJn0vXjeOgFy4cwH8rTJsNslShfV8EqGH5duQmqS4me
ZjobRpptKuTZcqhWZqrCMMlmtm4NYzrRoiTBSzFCXyyCbFSeYbE8tH7u2pxbjjfzQl1D1zNs
FriOrs1Mh49mUR54hSIR7OHgaUG3fymHAih0iAVpMJXj+GcrfNSgrZg6zJC19zDekBxKknB6
fX03vZqc/HYxHi4f57IZexs69zxFHzjDQ9kNq+Z0n/JpsQKy2iALB/nDqvDT56QxIGqULgtj
H8kPkDZf7YvWgxebgszzIClop9/1HgJ4cPOHcmeEHotJwTQMzYSjNPOx4wDDR25ypqPeaPyu
T22OKqJGHFCVbjSNW6a9RsM8kGlMtXgLmqbL1ZyI5jUaU3BU/6XeVBHHb9aPNUx6eEmLTiDQ
uDPF7qxLOOoWZrVkRuNjuc5zVK0JjaqbDS2dib3kiVgUw8boFiZv74aaw01dfVebu49s1cQH
j9Xg5WNYRVs079CvcMTBHI7rKIkDmfzmMP5O7BRiMYwr3sEsx3FV1x0d76sFIQxF3oG3cJXG
A0raMJ6okeTiiEYZE1QcyoW82H3FoW20XZiuMHqhdVSQU73rUNAOSjXv0xeAI2EMj6c7tQFN
HVNpSxKAC92VAGbASgDdcToAAJaPgoAEKNd1SgDZEwTAVd3uAnhaCHsQAIZtibVvCRD4YVAB
mCaHSTsAhn4UmwkAvex+AVAtzxMA7Sx0AQAMqBslA5XReZoSQOW2XwFgd3c1AQHIJCSD0PdD
9OgSAAMtwxYAGkUP3QAFmn0JYG6asEYDaZ7bALReeEb7oeQYUQjFQ5RvDsVgEJxg3Jjj4wA+
3wAGVIDTTSIOM67WJ5YWaOqDweD6cVCHpg3blhBwhQFZPQCcTh9R+1Mxeky9LEC//pX6geJA
bERnHKijZ7UHmds1SOjyZR583dQy87AWZuytxbGxHbfvP51iivEZh5B5MmYck9VrGs3GqqId
wyRKrmf/xTkLw4VjkTCM+bHY6cjHmxBT11RVr2Kb4Sf0ZjFcycEyB9Rk7MqjaeWwvZHUGQVO
OAeM4CYLaKU/ogHnIQoyOgUkj1eefYJosYyDBTqkABo0AMwS4F9UkDqxoHMFnuj3lpkCRegY
wkYExx8czr2iHJVzqdsy8B6jymkXZh1oj3kTSqtDyegM7TVIKMb+/VZMFa/D4CUqmmI4uQgJ
rANEnAbPbpYgBTRJGbBR0EtVU9x21BrSvWlA0h7Uv+4wbMyFxtrabVZkT/z/rnLR4HmQLgIa
5mjOoFpCFx2jwIDMDccM58d6y9dYhqbSeibqCHPi2xFwjdaBsGiUfcVp0TDp0F2wmc3kY2bW
AHTqN2q9Kt4WLmZyxzjJZv54k4xgFLr+VslybjKam6vjx19EzHe/bVtYzKLEXum4NuUsjTYR
v9GC/GO53A846xb5KiqCUa2cWNnswvuRa4PtaIZZDXh7rm+QY0IC354pNodvmfxYrHCIxHfP
OQ723yATH2tsDfNrsQfyD/DWOGNWB+8T5QT9wfXFScgQQ4nA/1Z+AKSP2Jjmw+bHpgrN1FhL
FSfKKf78nCoMphn3bfBn+PNzqjBNY1tRJ6IC8funVIFZuHrf1oJz/Pk5rUAPMO+3W3COv39a
FTrjqtZaxdlPq4JbvMNo/XRF088qkcd3JWgTu/XhThW6WFzYvaIqXMc5Loj90T7CPa0wLIP9
Q26tW0yzt+lngYcBU/QU4J3rK6WGatdGNfWHO7xtQ29qvwUYfuE/hO04+tYwupCnfglYnr5t
4b3u2X3YNEbwNmwJ26WTw7C5JU+V1NgS1pB+Sd5wcnp68oPYptRJKzh9bcM+SN8GBjJk5nVF
/DTehiGPx/wD9m3Yml4N+BRxKBSBKGkCv1IsouRuGCgnQ8bbB5kNjKNrlblRqPKDMKZqcLuX
DWd9MMzkTi+bfhhu1ab0fCMK439jXC4xD2iUVp7g2gvTz0Z31PqkJvRTAol2HcjGcJz6rCL0
8wMwlmrbvWz6G2Uzu59NP4yDw8Z9C5FVIm5P4ReGbdJ6YCxVs8oAq0nkO2EwEWO9bLQ+FVvo
+Fovm34Yzaxmgm42nPU2SreqyLCbzQEwhs31XjZaX4dbpsP62fTD2Krq9LHRep3Bcpjay6Yf
xlZ55eF72PQ6g82408+mH4Zi3P1s+AHOgPOLo+5ncxCMbthWL5teZ7AN0+5n0w9jWhbvY9Pv
DLZlm3ofmwNgbMfo1U2/M+D0YvSz6YdhYlFpP5t+Z3A413tGv4NgNE3r8XB+gDM4mMZYvWz6
YQyDr+fwKsABESJGSXkC8QBncEyTrYP7KsD5ARg0YtbLptcZHNtmei+bfhjHYb266XUGjQ4A
G31sDoDhTO3VTa8zaKrGHN7Lph9G57bRx6bXGTTV0OxeuzkAxtTt3p7qdQZNtQzT6WXTD2Ob
5q5uRG5XptOlM+wIOoa+aykHCDLsjv4aNb4ryLQW2zxEkLOW/t8SJKPeEcTO2rW/gwQdnffW
iIa7I6jbfNfGDhE0LNXqq5GMc0cQUxrWV2OrIMa0Zm+NvIWqrW2WMDtrbBN0uEyTf34mr3HV
lNjf4DP9T6/hsxsVcvW+xoDTf5rtZFArZuvb68Dien6mwzdAvrjKaN+/sQa43V6OE+fu4h9i
eGlCe5k5rZdEyXzU4dsYgmrb65NhlET5A+1ObHDaaeygGWwHDcSAI/7IQpQv6ExPf6NMztt2
KC7OL07O379DS0r8mBq1j9ThH5t6bdVqLv/TDohYI0ywl8ul2mC9kloTLNcC/56BaaqqqW02
sXV9m8m9GKC9NPhWdtGGDg6DcnXmb9LhnLXthqyvyjZaV6s3MNiuvTB0YUu2YLZ1rOnrbKnr
mtUX67tgDN1uXS0vr6rH+2BMg2boH1JwQ8eWSXkOM3WgbVj68x8mF2OK5+ZBDrLeY3BzCF6W
4k9vDOq6tU067PO3KOiYUNj3cH1+cfrptxHkQRxS/bB0/5+2a21uG0e2fwV358M4s5ZC8E1N
+VY5dh6qWI7GSrK5lUqpKIlytNFrRCmO59ffPg2SAB96eLOTD7FldR+ATaDRAPqRpvqKk8Tv
6eCgq9UGJ+jfZxzRA08xK5SWpiW1H1RcZr+uk+3P+8kGhoes4/oujveBrNpSF/Kb5H4GNzSz
84HkyKl+96ojBg8z0kK47k4fF7iQno1F9/k7dsBQ3p+aT2mEl7juLaKzFhx8KV7N421bZK7X
khHwtdG9yMJpeO4y+fLHFs7bJK+SO5bjkR1MI/Ll7eWLm+7ta9F911Ke3nd/pAaRj9QR7CDT
fTdsILDZ9ZYdNxEPN1vS/8vVFpN0yePGIA1xQGlEaQ1IgBsaf3gS5Yh0ZrWkaP0vvZJkip9w
R5eihye3xCUn/aFfrmmcdHRINs0tG7PiGLKtkB0rR7aOI3s8T44hO9U+O8eRAyuMjiO7VWT3
OHLoBidIw6siewpZHkCOQjjQH0P2q8j+0T77kv2gjyEHVeTgODJN4OA4clhFDo8jOyqO5why
VEWOjsrZp+1ceMJMsWpTxTqO7YewGY5i16ehPI5NO4QTJCLtGrZ9XNqRH54wQmRtKsrjczGQ
VnTCGJG1ySiPz8ZAJVk5il2bjtI7ju1wnLipfKW/R/sGrsf3OiZtsI/Ws/2KUpfhXtoIXlkl
2mgfLS6XyrT2vtUiCFzeUpu0ch8tmQEVOdj2XtogqOI6+2gjHz4C7fb7bu/lXUd8p69Xmwte
QsAvLxhAXtj80UZUAX3GzwKDVvJa9rRtOm6xm//J2dNsf0LrehLablSxUVzXCiKPY1JKRkpI
447avYrnsxGisGiwTZJ5/EjbotVanKXfZoiCeqYS5SGlxXyXtNuCNE/QRvKT1f2q1+0PxNl8
/e8LZF3zrFD7VTshbeAQ4DKbDKk7nTxmHHH0kU9bruVssVt0hGMZkvA4n1sPTvEH/M2lhVSZ
mbu5da4Ay87mZH5K182g1qvZT+NFZJ+TabLAy2Fvxd16vUKyDyjUq5diFC+/adFGrsSzL3eL
eBhPJkPOuYcwnMwhXb1V+vCgo3eIKYIvy01MJq6K+pi9v3mhu+m+fYHe2T3+4eKH5vU4o4fB
OznGey7k6xKEzzcSA9jyZEN/tEWn+LCYbWf3mfdq5nuu5sNijV2A8q/dJFuVxep3+tJg0S70
/1NqLFCN7eAW+z0Rgy1M9xePsO474uNuvkw2Zto2rKV4pa82SYKxihjCeE7W9JL508wbviNs
923O41rSwymEMoXnOtfAlhMU0LBINpvdepu2qxxjY1YYHO22ppQ01Xjut8WcdQXNnm0sLoRv
004uipoIi9wIOS1ZeWTzHiSl6Yf0fqtvDVREp5D2t0kkC553tk9T0nb9ptaIqHhiemOqyY4g
ROIJmxkwDVhp0dY0gXtrityLdjtChsjem7+aJEVsX1c0RhFMWuGlttporJG1iOSkRmn2dOnF
zWmvt1iokEjDpf1sGi9m0JukMc95RzTnBBTISJOs13w4Y/3QS6Tr2x7GfT/ZcATqcpyIl9it
0SDcLbNpTj28Tbaj3Ya6jsdmWIGFlF7ThywrxjmfBz7ENIp5u5fSjmr+qB8F+jbKXI/fmK7d
gwO+3Z5Fexfkdep1RR531uHOlv6EyEbqO7HPH2upzjxHWRgkxI54gfyqGNW7NW0paUWbICko
e3wbg9uXyijGw8onuib7kva/Aecm7BQRrbWI344md6XMRkeWL+aXzM0+85j6Ra8QMuJEhbUY
Ik1hK4pKNlRpZkO16ZN+9Fo+1BwCKrq2O641VNPxskHH69Xep3cBb7ED8Zw12oZ4TlnEc44C
I57Td5RTffamV7v7r1u8aNWn8yz82aAO4QNRTK5e/AOZd3lQrul9qyhPW9N7fGpe0KtgUBwN
6QmYqsy77PB+Ji0y0tqWUxgLepC41LiLxL/ft4v1lJrRTqETTeT7GPwl0+hvjGz23VDiAafs
St5oKuioOUSGeLIa5ea7kY1d+zoPXEmh3kY4lcdgwxmWaDjE8j0rwva2YEO8Q0Gc1qglH/KR
NqPlGbFom6QkwOKbdDdSAaaa1Q5xXrFJ7rHwrjatyW6xIHVJqgxR54uElkQtENI9yBRy+/J9
R9wVp1ecaHk1Xs2FUrZGTIPv+T4ygdAghcjzVML3SLSwpAE+p6mSbDR14AVFqjwsCpx8ABHy
9bMy3yOjjgwk+rbDJJx8mdRtjOVj88DZkX+0abFPxHo8u1iuRrNViqinx9WONOVyK2ZbcftJ
KzkvcrBjLAPqw8M22XZq+xVvMaAmHnKRIF0vuqqjiHzfsngJAY4yNcrJDfihJE9wTlcbjzFX
NHvogP3N7j6B0aafnLpAw6A3e6EiiZAIlENKWjqmJMv9pLHI9IT5snlcbycdNSXWu+Gf82Rp
hNLoriPbhc62yDHxw3eD7hltLHc08K85T8Ezg9w4azXI+8X6W+OQlk4NZXA4bUsMB1d96Ndk
CYGnJpMXhQebuby/JzlhANdbVDemNWZOwt+6Tubz1sfZJFmZHLwT2sNxkyxX31et24+tN9e9
butyN5kZvKHrhMUIlirTxWXvJg/7Snf8rqe7OU2TePznbob3ylHvq3hiDO7ICr0i2QXsmw29
aIQsVyJ64P2mU5+cFfuQgSUGjhh4zwzCSCffVMMyy2iBgVjYvvlJg+ZTzofGaFYm22Y2oUH4
MCMF9ZCFhwH7d8ww2hbTU5KGO+fCAf9Q82+8Sf/Bz7pJ0EkR07wx2nHtQCdwzc6ibfG6/zJF
AKK6SrKQpE1Yr3KuQPquzr2FSXtHSxGsGnTuM/2BhHhGKjTGOTPU+2eVuKQ1nep8YIEMJA7o
kT9M9G/71qXldCxasum1X3UEaYFCrp8HyT3MsvSLwRzAe6GRObsXEWeXL4e3794PX737cHv9
7PfMJuPdxKDf01D00p0GKKDgwUlbil7v6t3tq+5rM0fKOZnry1+3mSbRsXYQSFn3pLSQI5aD
tK6K/lTvsa27EEWIEAOn+Z6pcSU4DpouqG3Lgdcuvd+h8bXK3sAMtHXghVp8nq1ElqAPSfnG
0yAbO1qQtuSQoyeATVRmFaz2dTDOQXcKWFOK9lEzqO1Z4VNAS/lfRtNmUMc59bH12DW4I177
x7OC07LayLCIvDgdUuc0sFUOH4ssp5iT2Vm+mR8H7sVYJUoYUmOo1E4NGNLEoKlo1zCkxpBN
GMiqoDFQUKD6LIxBuh1nWuiRevNjm2VKPwxRuGRthE3sc1oaxo+ie/1SQON+ywGlBrTklN+8
nAYGYMDJuZ8A6GpAZ+obSKHlOU9CCo2uBaprgdk1Gt3BkwDHRtcCo2u0Fwy8GpJTvDiJZJH1
lx+aA8izfbfeG8LIupA37Kvp5TtTWPEx7V847RZqaLiswzWi456EGCjEwGpCHPReaECXUyGW
AG0e40ji3pGcw6j2mE5pnlD3w+o8YQxjOKl5rxIcq3k/yfYjtIAbg5UmnV0Vu4kVaixSHIYO
KaVLDi2yVQ7AOJYJk2iYpN6l0PK92nB3DFViWUmDiGxTRKFs6I/TLKJkNNb9mZTS5oa2xVFE
e2H0PMtK1Yxpvml2L3Ds6uhx9kkl1L0YNUiFLNzaE7lq4MRTF1JpGjiyJBVYlNXp71akkj+O
qx4nMLqAo6KqNNyKNPRYkXqslPLdRlLZtftgbFMqxrLFFR6mwneRD6Ikmwg5DqqI3tNkEzlk
61bl6+2RTahkMzK6QDvlmvry9srG1rKxS7IJQs+ritjbKxtXyybYJ5swDLzqGPSfIhtaga2G
F+/vkc1YyaZ4KKlqL1Rfj79XNo6WjTM1YdwgcA7AVGQTatmMGmVDiD4sjgpi8ETZBKqwRB2j
LhupVIR0jC4EkRtWRRvslY2rZeOaspGWL2smS7BXNmMtm+ke2UjbtYKqtMOnyUY6tLhUF7tw
j2yUvpGB0QU3kjXRhntl42nZeCXZhGH9DYX7ZCO1vpHN+ka2keDLr+rR6GmysWXAp6h1jAbZ
KH0jR0YXmkQb7ZWNr2Xjm7JBSJ99oBcV2Wh9I5v1jUTQjl1b8+KnycYhfWNX31i8RzZK30jj
oRzZ8FDxXtkEWjaBKRvHOwxTkY3WN3KfvnHIWq2ZEyNt2dhePGqQTRiasgmkU9OCo32WzTTU
D0e/Gl1BnvWmLSTtzblSh7otyMnpxbu2b55vdIuDmpvZ8pv4fHP79vKLOIOPnfDEb9ISMr/N
AjuZ+s4R9hcH2H0jVe4e9ivNTty/ldhDW1es2cN+fYA94pTjB9kHOftvkWYk6zGqDmM2ir/f
x/Fm1MnLCMJbFVcX4uPryywHq8aQbk1NlDA0D45lUO9pkow5CdRs9U8aCOerh2XxO99YXCxX
S6MB23Oqa2CpgezkBc7Lm9VcrFdpOisuwAHguADIyc0DRHzrOjiaHSKD0nC3xL1DMsnSYi0T
3KnL0OPEWSjllvIJF1LdlyBcvP2/K6sXWvB9nN79nVm90ErIZ84ntLJMHobpPB4RrD2aEm6S
HMB1LAfH0q/6NBIW8TK+TzYEEy+Sh9Xmm6aSllO+DeBDYRy6wmurdNzK5D6iZJkcSkI9OPwo
hlz5Kzu197M0iJrPDnESlxcf5OyBXIR1tJtOqWNHK7ABwwmRdOEYhlFwtCg0qjF8C1dEpTs6
5chMQqaOG1/oW9mcm8xVjgj4l0r71aHBv5tP2LkkvwYR8ZI+8mWHSuuJU3X6nGqMyMFV4sdX
gw5qgX4Tf+6IIRUT/Bz6bTJdC1p6DJR/VLT4/jS/oEa3IMBJB7bbq0HrCjCoZ2FOSrIcJI7S
1ss1KbRlX40EjCqDgosiEIXIFoY+0lLj1LwPZyzmUGrnXHSvUz4mHiEbmqpwavSFxr3USPIk
JBrSDUhkMNkayT4JaSqbkHwe3DkSDpkmi1jYXzRFwMVJDIoT2goanz8Mzed3T0Jym5BIKLiV
zJG8k5A8SzYgSU7ImiP5P4HkcRhyaSR1sgKIQTmfOFEHLmeWK01KLpayXlQvzhuvzSuX5mSH
ezjQpfmwNBrxoiBqOsfOj6/do5cAQPGjbCO+B8U7evoPlCCyD6L4Jx/7A41sa/cQWnDyeT+h
0WqEQPRjl+i2ZlBVJrfj9RDZuJPlEHdRKE0zZD3VpKxszzd9GP1qOl/AOh5iRt5f9UWSgn2W
Qkc3obGuy+Hsc1V+sobn+iiVALwRPfJxIPdchBL1iqpA1DWfgTriTQGSFjdZuE8ze6w0MZrE
bwaOquHy4bp/VEQSuXtJY9S6Evi2gmjdIHHTf4xDwnFOcJzIGTjFDwnzrn9VYkCW8on4cNv9
JFLEEXFWz2XK16kLvqNvFxC0L8dxbhViN1kfZArR0SoTjb1DTNLHnG1iun01+O62UZth/G38
ldbuZH4IyA6C+oULFsFu95PT0fFNfdqiwUv0LpkncZpoANrvNN6G3czggQqf5tkmGW9hXz3H
loL7Mi18XADhBlH95oEgLpUjE1+cDy65Uhc90L2AtRdvoHkNEC+qHSeycc+uBvm+gS3L9GtM
6oHEdfeuVy67aNRNn5SMLPjJWLmnytXNQGRT6Lwo/uy7mjb0YHN8WMKFi/O/kr1BVuo0LRz8
7LZvKxeL3JuWaSaGD23o2W8LYscK3WqlCa66/fc4p6NFz0IoWI+sKtTF5Zqu1Ml/s3993VcM
HD4Xizuw/wnCA9sfhYDD11M2J6v14zBzecPWYRzR1oGspn17B4BHgX/azucJexLCdaXtnbZn
+w86TZsMi/cmN70PN39c/9G6hfWabje7MZwLUnhfsbGeF7XX48t1udQDolaHnNiB3tuWVHmn
1WqJAZcqXGWucJ85YfCXjlhysrxNOqQWqJMXZG0gst74i8Wm/5CdV77H8wvfQvW20SpNLiRN
LNq10LgqvnWIerelDxeeyDPr015yDJzVcjWdatL8D19X8wn9NGUQSKze9QcRV9iRYvJkfxlm
HRAoW6H5Q9s+lV/1tsofwIRu4G9qVhVcMQY1/BG9w83jz8McTL2Cchc8pL043AWj57UuYNPl
/GwXbEs2Y+xjrXfDYT3/c91wOIfZT3XDDcOf7obHB+0/1Q0CaX6nzd3gLXelF4EnmyFO70Xk
Inb+GIRuvIbgS74hyD3C0ySrqEIL/S7dcu2kR7i866XFty24yGAVx98R/A3HagJerLmm0IWU
vEixiXchAzHawfLKPvsFUORw4s+/RrtJ+TQO3wV8sD6FNxzHRp8hoXZeaTJo28GznDaQ0oMv
wtvkUR1Jxzr6u+oFC2qbQ+8uNRE9IXx3kXH+1x+0bv7ayOaEsCDu17PVkDYoo9WSOk2L6xo1
vMgKsRN40WLt1iwuu9eUWaDt46UgI4C5NTHtdeUBfLcB35fwozsRnwxFGmxf7+PpiHYJry9p
bdtMmhefQIYcGpgR05o3SrDa8Oe2lfvo8bKXbDZkULRsWzNHvHeerRczsofSFK63nNiD5Ju/
QCdqawbbsrlkXL/XFQM1+PjgegrPOxUborsGnzdXoQ/TWYfMNN5coMgYNjTx8rGGcZbqsWLb
KhCV2xp0X9Va0pSOjfvO2XK9oxHeJ4tzI16QlkZAViqeZycGz29uPw3+b/C+RxYrfu//6+7F
LX5nPvW/pTFd37hdMCE/E+OrLzlh6EgfSm6QbGhSdkRoe9ZzCW+TIlbGFexfqerJkUm8Uba6
GbliwxeD3ZmzUxjOcY/BhJQG1g9nGoozpN+5wM4SntXDUbyboLQ3lz56hhEXC273soCMULL8
S34cA0ipIW0N6TwB0mO3sWvOm/0+nn8ji0m0eGwaldftdsQYtLFP5uP5t6F2wb2ACU30y9Zi
vB7NUcpYfH1oa76ITXp21UfCIXbXh+DuSZhLzvWQIErn4rZgIfsex8M3ZGC//iSmc+xjUdeO
T1mzCZAPOuU8hT2OuoJg79Is4JVWgl2iUR2LL7Pm8Ra+qFytm1BbjN+2TGR2ztInJkYJaH1k
YpVPk9GAGyE84c2g+5yGN6mAeJNvnsoaNqJdOE4zuAhNFhF2dvdM9O/ePee6NLfJFipeXKuS
xS1D+TptW7a+ha3by9wBDXiBhbxHGd4VGcubGcJnzsbPhIyiqEWvzi8izzY0es1ILacNT14Y
evtvzfJ8GxhtHC6vWRHocvjuxjp0d6MggtMqsjx1HwDwwPZP2xk9YfPiIrWnE+UyLzluiWT7
ld7CGTa8jtN781fHsVu0Nj8Tnt3xXJBJu+O4Hc/XYJ6PJEV7wfYPkSsV113UngRY4GBbNQvJ
8u3gVJb+Gzy3QYrLOawFn7Pz887bF9fn2Ql4p/fuwxcVLuJb5/SfK7gO77m0C+jICjjqinTj
qqNaEAQhlIt8jVXzSY7cKfFdfvi0j69o0LX8INIrweV78R5nIHO+UkGqARsWxGiF5dRcGfJJ
/pybes7tltaFomsoVwD9NLPHzJ4flZWWJCYLMYyIrEX2CvrdmmOOdUQ8iddsJML+oQmwTsaz
6Swf3mD1QuUkQy/Gx/nQFX75UVr/z7PjJf4jbVMTbSgCIXCcEwsKPXGCuLiA5hVgvFokk1mn
UDVWO2gHKPX0dbtdd54/f3h4aCua9mpzr7mlAxeTxSrdDnUs19kzTWDzebQiIAE3EHAQq4Fg
RBHRnOQQMY7XXiFIVABEMzt88x3/mKWt6Wy6yqu8K4WrHlrHhnGyu7z4DhZGC1Vh2civ/FU3
ELrwXT56GKo5XI9N4iz2QtxlyTC4K93+d18T+hxul85oEOGLc/zv8gVLr38z4AK/6k/bHc4i
2cooj0o3ZKMmWi+xFeguuboQ6KI+VwfLQkE0feTCAZE3IrQS0tPwMUbxvUf7Aq7EM2n6lsNd
VYR3VkE3i3K1sn/izNLv1be5LE9B/fHl3aD77rYjyEIgk0C6mtKRWA6tn/yn8Vzfi/6beGTs
+/9NvMCHR+FytxjRGybjvtdXpiSbG1gxvbYmJoM0NInzVFa/WMVEwcG+a7BEFvDx7viI5mtC
TPwS2s3/DM4w4jw0Imui8n1gORhvHO9cXHL/AqOj9pC0UIQZKagFitjB5JoViQy4IrLBIH3E
VJUYrmnU03h/FO9JuXaEQWw7GMgl4pv3A1H8KxE7lh3Wey3RPApsS2mQspOHgSs4EpH41GE8
VKO+ZQ80I837sMrYp5daBMf/f23X/ts2joR/tv8KYm9/yF4tW6TexvlyfSS5YLePa3rXAMVC
kGXZFRxLrmwn6S7uf7/5hpJF59XW8AVFLZEzw4fIITkcfoTXjZEnj9GEdumbeq918FCYOfP4
6vm7hVAPVb3PuGa7spNqDFO6BsIwiQM+Lc+U7ONhFJQ3j4YtachAsPVJPNuMCJAgju5CoTZL
oZ7I4BTU4zshe+I/R7QIwaLp/RF+L/j/pkn0xCsd/drUIaHNUCgsWPa2s9B7gpW6J7g5DM6C
1T3B2PysBasnBDv3c7wjWN4TrM3OLNg5aFWQQvVrwe5BBUcRX9gAwd4hBUeS56Es2D+oYBUw
djIEBwcV7LYfLzyoYI99KVhwZDY3Brwx2rH8wXYcBY5qqiI5aI5DjbIOweMDCsbIv23H6VNd
+htVcbfnebb0tjmeHDTHKtrmODuoYJfnzix4elDBXtD0PHlIfezZGKRrwfKggrECrgWrQwqm
ybzT5PiQ+pjm+K7T1PEh9bEnYVqoBR9SH3uSVkt1B5GH1Mee9PxmlJaH1MceTc4wh8S0ZF0y
ml1tBlwNDRo+kkU0GjByqNqokAcgitJ4j0NpRIU4CkNRGlJx6LRRNLzoRDUi4tA1ovjiQYrS
gIZDbxulcB0yR2mA0KFvRPFVRhSlET6HQRulj3JSlIboHIZGlOfrtDTG5jBqo2hJHely1WVu
l58U6dUiZVPqttjKsW2dlRqmctjaWjyl77xBZF0psq0V5bJnMCLramkXcBTJZ7cQWVeMNGoG
OFDb2eiTf2JCS/y+wcn+pTX+w7tz8aa0Lj7TejbdsDtO1lL6PlxjV3DcjWvspNcJb5KJlXaB
OqKxHU5/vk9NVIMxScf5xfr7EY5ie2HoK4qwpEP1To0jaFuhihx8CbjHanwUjRxnUXO8JM0V
iTSr1vk0B6rJasvlhCqKjJ2xrGBgE77Ab3eHC8RRBAPu53Rdrr4yelezs1Ius0JQiRtL8hE9
Gz0E92QbwHKbYrPifUPGucsX2P9p/GJwp7vBx+asj3zDH4wZWbpdK9bcGqE+pMY7b9kcF/l8
io3vEwB6mMC94fA4k8oQ4NrY0n9zaT3MrXnoU+zwBOGde4A/CTSBz1SH4vf7+Nvgoa/mMo7X
YLEYilP2NYVdLd0Qz8dnl40mgfUR3omAomjQwAZ82Xpirqk812dV9PH5+zfnb84YzI2WUeId
bCC8CQNItIFObzDZLJYxwG20M2A/HaqQYTgzDn1m3waBR6lEiZEAzbdsoD7CDLgSV3kBBK+8
GBoUHm462k0ZQHJDsbqh0mTVwBYfklwvNc/Enb8PJENGfduqUt9C2UJrJseZM1Wu+Evb0d3Q
w4D5z6SaMB4cvPiG4l8nr/8N1xdAQQGqQxzl9ClPL8Uz3oHpYZvBJ/XNMEQ4athXlhS2O7Dl
QBm2HpxshwX55Pzd8FsVEjH26ksGBk99YXvCnghb4eiNZwtbijSgFARln57Zbo5/WSgcJSYU
yAekwrFwHUDZbomdUPhSTBPhTkUYCVdLCI1nF0LGYzGe1jL/Zk9JqY1JbYg0EuNkJ8FxKNwQ
mSKVSvl6JFPbYtEgAgyMk+eXzcrdleLkBb153kRGUxWKk5eX7apenLy6vL/G90jlQTeeXJxv
IxWRnpuML97VQrMJvV1s3yJDjMNGulcX4AvGRFU/nPLDJBRn/JDZ4oIffMre6W/PdSi1WBqK
WmGuDevRy/c29AaMfI5Db4aJgt4cPpwQJfrNreP8qZEn2BMY3PUK5v60tUB4nmfz5TvHYrnm
TnaTXM3j5WwS80KK7cds9k7Qhx1Dpufz4uBRRjjp3dyCFweBTE5f8r10x6QxqnlclVBR9EOk
tL7FcR7fJGZMXSLGnfRsaX+Gg84D/NdSBTYvKI5rrdfQOT7ESZOQT00RIY9spBjidZJfxTcV
d3digXk/NegjO6qTX8fYEIinZTVHVnkfoO2GXsigA6xKYe1do56Fb0/TkCZNMvAlrqNm5dry
RHwasNGpL1FlpKIMZUoj1+nz899OXvVE5HMEI3zpneR2XPdthY+xI4hHL7iBaNAfBg3T2rNl
k9K5y3YvfY0218Mm8+PpK4kZ3vtNIQbs4JKstKNLvXFiEPJ1Qr/qsWmZFHla740D+JC3oxlc
shnMymrYEHM4dtypSWI3VetygRbHCGj0TXw5wZkzZd9Nr313GWOGNb78fo3/8cc0vg+V9P/T
+HBzCh/uzrBT6u7CfZLrDGMB+sHYN8givpvvWH8CNPsAPcWYAPqBvg/lWMRaDPXoeYwdfTT+
DI3fqOYgcGot8vTnoCmc/C66KNT9ebFo+jJpBe5xBlXkR1FD1QhzJVF5LRFphjCsyzEp4+w2
S6+zeErzTagmH/omNGQG0uaV1zH2BPHdYq1RQMxVFJq0gatzuRXMqnJX3QWKAf2gQjYFF8bY
TnQinhq1xA7P5r6h7gInUOED6s6b3FF3ATUw+wfUXUCKSn2Xugu8CG6cdd98O52y65x9m/l6
WOK9U3yNepg6qjJGKWRA4aSYYe8Bc0L+syjrYTABXskv3e7JVbLEnFsDnFJpul+yxcbKF7RS
4GOfwpqKL2l5o7AwnltfNkmxTq6s/HrsSst3LRuHMs5+lEvuxaX24nL24nL34vL24vI1V3d+
vRgddTvMrX0pLRouYt/tdixtabSIhF4AREtPHFEvPX7WvxRQHygYlCteQQ3q5JpfC7MMK3dC
v5/O/iD6Bc0pIWi1WApFv/VSjb05ekW2pvcR/dgUpd94pOvlkyaUz3VrF80iBVVpVRkC6XkL
k5z7tHjPVmMjzEr0Pg07oVM41olw/BoxXDhaJHKDLWMBFTJ6pAH2sKufcGwvn46uc1rOlt/D
KffmVHtzOntzuntzentz+o9xrti9kKYJEy0oXy1xqJJP3VOLKqkJlpUoNldXXVIy0H/FBE0b
QHsjOKoMqmRBbefzppjF8C6OeWwcyW6nbg3AdR/Vz9QXqi806NwkX1dxg8rZqdLNkmazWZ8e
GGqV3QcaT4gREPM61EL7+RRDC1BjO8uKJhvzPqU/X6xmo7KgIE7XooQBqQ3by2bZZqZY5HHT
XEcc2u2U5XLVPMNRI6aioIJGCgmUi+V6G0JJTqrxpL/Ii7Ki6f2mWI9CLg/17Un/qpzpCfwo
q6puJ58RVRZTKAd2O2lZrEr6OOv1V5LEt1LoEozYH7OnPSN36IzQ61kyKgBbSZKqm25Hn+Ee
XTG0apHdrgeLBIacbufF27cf4vPXz89ORoPlfDZgkgFUhAVHHX0Y0BrjVhugCLrBYJamltuP
BvV8LEhp3FdJqFQQpeN06jo0XHuhzJLIdcZ+pAbXCwj9w3p0SvdwTeEbZ9W035whoRql9vTT
z3+S9vv0j9//+5OwdOMSFKafPv2Vgrv/A6VlAHYjtgAA

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-ivb41-101:20181011023248:i386-randconfig-b0-10101847:4.19.0-rc6-00007-g02e4256:2.gz"

H4sICOtSvlsAA2RtZXNnLXF1YW50YWwtaXZiNDEtMTAxOjIwMTgxMDExMDIzMjQ4OmkzODYt
cmFuZGNvbmZpZy1iMC0xMDEwMTg0Nzo0LjE5LjAtcmM2LTAwMDA3LWcwMmU0MjU2OjIAtFxt
b9u4sv587q8YYL8kd2NbpN4N+ODkdRukbrJJul3cIjBkiXJ0IkuuJOdl0R9/ZyjJpvwmN9tV
0FiWOA8fDmfIGZKp8LL4Dfw0ydNYQJRALor5DB8E4n++Al5aV5PXA3yMkvkrPIssj9IEjC5z
u1on860OvbY7E40Lg5sWHDyN51Ec/Cd+mnVe8mlHzNghHEx8X5F1uwYcnIlx5FXfOvzwEH7h
cDe8gZvb8/PhzT3cP87h2i+AMdB4nzt9TYfTu3vgGnNWyb06Vi+czft4Y8PFzWd4ieIY5rmA
iz/vjv84Xy1/cnl915ll6XMUiABmj2955Hsx3B4PYerN+huLC4drffg6FVPQXrWVq9N45Ibj
MHzA+r1xvKbInWBu6K+DhQSWiVxkzyL4IbhwnVv4fji22lRmhwEL39NUkuRrYO/mFoqQFKfC
0aN3w5VoDbiwDS4Q4/mkD9EkSbMomUCcTmLxLGLyqQIfdFcFPv0JB+evwp8XAs4iqcBDQKMs
hF+gn/TBw8/nNaXeDYk48K6DhZFLUqwhnw0v+/D7+fAz3BVeEnhZADencBAZhnbxJ/wKN5eX
fx4Bc13r8EiqAViXaV3eQVczehrroY8Zq6Af3mbY7ihPM2wqcRRBH67+GK6We3qedvw49Z/6
8DknRUzzLAdjbFpGoDFAPvUXrSHKG6L+bA7aEcmC5XtjNI8jbG409bI3+U4W2yE/l1Xn/iP6
dxqG2Af4ATqzueO6tg3+mx+LXAVg1kOJmqfzzBd9FW3q5fhbew1XLnzxOiqh6DXzAwOHwSAM
x0fyVRTEYpTgO8dhpquZLjMcHZJGvdx5gCL3+3BWaRW45epdU3Ng+OEvMghf5Kj1pYxt6eYD
lJY7nwUe2s+KAdeGq/gmDAb/3mC7tmXpNVYmpumziuUtsSrjX/Vz27LdB4i9vBjNwgQGpARy
bdl6L/Mfl49LZoqobWArhve3t2hPoTePCyjQxPrwkkWF6Iw9tX+xsFsVDqNX1FHmJRORg0iI
T9BXS5oIi/eSu3uB1xZE06Vyx7LciSw3T3zPf1xpoU0KAjiV5S4UvMpVG0WdiuSzl0VS6zt4
2obkCWMP5ylNc6q+k8YGFxeL75tZ2TZJMwjKkUPtUtth9I5vfie1o29+JzVibHzncnpnbn4n
Ma3N7ySmvemdw91y6r45vu/DaZqE0WSeeTT4wVetYz/04csJwJd7gM+nHfwHa99VNB0d+M7H
kCLEIYoiCYxntviFjrasijrOLlFlUi4nY0XU1e1dosoEHDZFmWGS2sJ0jgMiyQ1vOoU0Ga9Q
ASzPrAHwFl0QA5QZOgCVOpgV2bMXH6qoFpNmNZ3hiIISltYJrbHtqyV0VHuUREWEIQ9WlOKQ
WoKuTYRUsT1eY26ZNH2S2VbiReZNZ2kcJaLJC9wxWXAe/SWAWbpjKCCOnINvr7CrXzVL2KSq
I6ju5WBz89v98cnHc1XGaMhIF6lkHL5VxmjI6IqMvlXGbcgYioyxTcZGr8MI8uzy7mqhSGbZ
zrhUJI6L/qoiHQet5/j0BqfrcxmKlxaAsxZOQ/MphcxRiKGpdIk1D2KmRmNdKX97d3bTDP4u
LOQtx0GG4fYz9sPJ9emHOzhUASxLAbhvRGgX58zijgTQNQJgFQCc/HlzWhavysoni2+NChxe
V3CBH6sVGHYpZhtrFZTF2ytwnbqCs/UWaJpUATP007UKzvZrAWNMacHdWgVaqWNDU2X4Qub4
5vJ0tdWmXco462oti7eT0vW6gg8352v9Zl6UFejOWgVl8fYKzIVlfkwpN5LEvCDAECKnSEgI
KaSKWOZidJKlixTqK6xCajhYPKkAGpXS5PQphU+fh8eUlSrzgRwnG0XRQy+8J4ryPEgwYW2O
m41rU8qiYHEZjV+fnY/Oju+PD7RD8GKM+zyKxWo/RrEKSd6uIpCNaMMT+HD524fh+RC8Zy+K
yVu7jVI4EumOjuU+Xn/ZUcx5kPFTnL5U4ZOMqY7gMZo85oWXFepjVZKjs31MX+phWSRBTmp5
pn4Ds8q5GgLo/h8QtZaQ6G0yckavOho5YowzxegXOsA2lDZk3NBazNWp5wMM/3CgXbSxDxj2
YyvKezdsSMgA6K5MrmQOT1YwQl7gZZn3RuYn7UKTUzMi5H1FXqdOp/Cr8czZwoKG/wWPVbXr
jP89KqyMWIGmGaBJDaSvyJAZmHyqFtfRjP4vTergsgGlOwR1hv4jrw0OwbSVJYFwdX43dUMS
+pRmU/T8dRS2l1vppgxDybyGKA9iOiveGu+xB4fps5zy/qL2SI1LFQmMeKXK1PIW4pXTZGWt
UqelEhrlJHv5Eh9tXLNZU4LmilX6ltsCs309RIWhMP8Soy2SLpfXKlNop7UZD2ldJzVIkRZe
PPPIDMB1mKU4FWaRrDYGUm8f7QtkUVoZC6SekQJaaUPGbcrUImupI5Y1jGZZ3XWdsvgRfLy8
uMbUpvAf+wonW7O4YlqlmMtbedkyUFmVMzBA2VCfzpaCrm1iheVChJyUgizCqKpOORcFuWYa
i1DoZti5j6ZY6vIabtKsoNze0hy18DLw2m96RBF7EQl9pNKjT8NLOPD8WTSKgq+0tvAAQRjL
fxhJF/iIPRwqABYN1pfXJPtVw9zIm0U+itJQVS+tMvuoQUKuYuH73+4uQetwXUVbRhCXn+5H
d7eno+s/buFgPM8pJ53noyj7hneTOB17sfzCa34NVhSSXyaoI8reiQwmAvRRZNGEPiUgfl7e
/i4/paYuz2Bx+wnjEd5ANPdgZqrMTDk1glxva5JzN5BjFTl9hZy5hZypIpr7qM1VybnbyJnO
D5Bzt5BzVUSL70GONToVv22hZ9k/QM/bQs9TEW22Dz3WoMe20bPNH6A33kJvrCI62oLe7e9a
ORiN3yBF78qiQInRqOym2rdZPdtSO1MR3R/xI30LYsPDXeMHEI0tiEYD0VE0ZO7UkE0LsnvX
bm2p3WogbjLIbYj2FkRbRaSwfW9EZwui00A0FQ25uzXEXKUs221wNudqYdZS+Ec05W9pl68i
6j+iqWALYtBAtH4AUWxBFCqi8SMcwy2IYQPRWsQOqHo4GB6f3R8uVvqaGWqUhBSc0L0KYfJG
oh4FFEw4mmN5HPNvWvuVGwsiWI0XbIo/8+lsnKbYpGPMSF+ICIfTm88Y7+CwnRazeD6R31U5
21mk4WW0QOkHhfhyLe6gjgrUwdShzY861XUW0T3toY3lctciUZWNvzm9xADqOfKFWrHDaXEO
2cokyMu85ygr5l4c/YVMnkSWiBhQT+qWEQqRYTW2XTIRRokIOv+NwjCisHZ182Vl06V+vLLj
wlzGuKUZhsVtUyZSSYOsjWQxdQhSTEonohiV96PxW4FxKEZ0MUWiWTqt0sCS/6/aq2f2MBgM
OLxExSP4WTIZ0VrqQO06x8VGyVh/NBOZTxvTn25H2E93fZ1Dko3wEbVqNI6KfPkIyed9+UWm
j/RNnSFcivxrvPPpWAS0ec3tMgLu0a7Yf+qVV8gdZjsGZBoE3EFzgzljmumqcZZL688zFOvI
5Y7+VplyOWTA7f81NFcZkSlbaSJgXEqJDf5moJYzMGjCfq/yHy9/S3y4uZC2JDf61LJmtZGX
F8KLCwzDG5uBzNJd3zUaErRBczKP4gJrpcwgjvICPWSajqM4Kt5gkqXzGRllmnQB7iljgjpl
srnWxMKR8yaNI/+tSjLKjEMtQgndVWnOfoppShJQvE6Wi7Y/6KFj9DJviv45R9soqJtnXhL5
A1ZuEcu4fVDe5m959m3kxS/eWz6q9ogg88tNvS7eSLNAC4zjEakinRcDRqYsim4UJt5U5AON
9kWT4qmLFT9N88kAfayssMMgT8OCnIsssSKRTKPRC+VJQToZyIeQprO8uo1TL0BfmAZR/jTg
tPuIWfviAVpGNg660yhJ0WLTeVIMHGpEIaZBN04nIxmmDXBGKvfBxWixC14dMhkUxZuG6T1m
8SVtenCnHTG5DKeWWj58nniDpEz8shfS9dOg54vZY5j3ysMmvWyedL7NxVz0vs29BNXViZ7H
ButFumN1yLPLoboz1joMk2zmGHYvpgMtnUS8Fn30xUJk/eoIi+WEpu9iBxncduyArJx5+thC
V3B1L2Bmfxzlwi86JYLT6z5P6favzr4AHTrDgjSYxnWmOR3u9Bu8iSSMkbf/OFjS7JU04eT6
+n50OTz+7XzQmz1NyobsbOrE9ztG1+3ty69XN2j7MZ8NdkB2K7Kwmz/OiyB9SdQhkXFKmKW5
98sPKK2+3hlVwhcm1xXORFLQXr/nPwp49PLHam+EHstpwTJN3YKDNAuw6wADSG5xZhggR/BD
Fc6RcQEOqZ3taDq3LWeBhpkgw56x+Roa9Vy5nhPRzEajCo7rvyhNxRECSyxXkHXXZryiRWcQ
aOQZYXeqEsxawawXzWiErFZ6DupVoX59s6RFG0mos6FcFsPGGLbrOFc93eWYnl8ps/eBg2nn
VT0b0zkvbCm33Cv0LBxzMIvjhmvht7T85jJ+JfcKsZitGVcwznFkxUnVxOf1khAGI1fgT71O
4wGlbRhRNEjSPmsVFdQcqqW82HvDwa2/WpiuMHqllVQoJ3vPtWky79QzP30BOJDG8HSyVhvQ
5DEqbakE4FJ3FYAlWAVguO4WAIDZkyRQAlQrOxVA2RMEwFFiG8DzVNqDBDDR5fgCQAShqAEw
fYfhZgAM/ig6kwBG1f0SoF6gJwDaW9gGANClbiwBrLE3rgEMy3dqJVJ3b2sCApBJVAC2QOew
KoCxq5uGBNBxPNkBUKDZVwBKExZoUJrnKgAlnae0I0qOEYVQPEb58lgMhsEJRo45Phbw5QYw
pAKccBJ5mnG+OLI0RVPvdrvXT10F2qUVtQ1B4BxDMjUEHI2eUPsjOXqM/EygX/9K/UCRIDZi
aySIrkRbPnvUUEJXL3PxbVnL2MdamLmzFhlE3338fIJJxhccQibJgHFMV69pNBtoHf0IhlFy
Pf4vzloYMBzJlGHAj+ReRz5gKhSN02V00/uM3iyHq3KwzAE1GXvl2bRq2F5ImprcZ8c5oA83
maC1/ogGnMdIZHQOqDxfefoZouksFlN0SAnUbQA4FcC/qCB1YkEnC3zZ7xtmChShgwhLERx/
cDj3i2pUzkvdVqH3AFVO+zCLUHvAm1BchSrjM7RXkVCU/fudnCreeuI1Kppi2GopgXWAjNTg
xcsSpIAmWYZsFPZS1RS5HWwM6g6bkGiV/7rHwDGXGtvY7lpVx8F/57ls8ESkU0HDHM0ZVEvo
oWMUGJJ54YDh/Ki2fIllObRQgzrCrPiuD1ynlSAsGmXfcFo0LTp2J5azWfmYLbMA09boiA+1
XpNvCw9zuSOcZLNgsExHMA5dfKtlOdc57enU54+/yqjvYdW2sJhLh+Q6W65lOcOiJYDvtCT/
VC34A866RT6PCtFfljN1svJteO+5ltiWpS0GvB3Xd8gxJYHvLxSdw/es/JjOcYjEdy85Dvbf
IZMfS2xM0+XuzD/B25XLJxuv484x+oMXyLOQIYYSIvhefQCkT9iY5sPmx6IKnRnl0bw1+BP8
+TlV6Mxc1X4Jf4o/P6cKQy4drFWB8PT7p1RhmbraF8sWnOHPz2mFLVcTVlpwhr9/XhWuZRob
qzj9WVUYjDmbLAqvIJ3T9DNPygO8JWgTe+PDtSq4YW+sIqrDdZzjRBz0dxFuaQVmbs4/5NaG
qbE1t86EjwFT9Czwzgs6lYaUa6ka9eEab8swrQb2BmD4hb8L23bKY7fLa1qe+yXg8vztBt6L
nt2J7WrM3IRdwm7TyV7YJh0Ee2iyJawe/Sp5w/HJyfF7scvBbSM4fd2EvZe+TVae1lAV8dN4
c7f00n/Avk2MhepxjCKODkUgnTSBXykW6eReKDrHPcY3DzJLGEtj9VhFocq7YdyF1W5nw1kb
jI25aCubdhhXnpiprnwpCoN/Y1xeYrY3ytKM8szGTphWNhbjDY+W+qmAZLv2ZEMHKRQYqZ/3
wMiD2y1s2hulO5rZyqYdhtZrHjYQmSfy9gR+YdgmvQ3GdIyqUU0iPwhjOa7ZykZvVbGz6Kkd
bNphXMZ5GxvO2hplazo32tjsAcN03W1lo7d1uI2DudvKph1Gt7jdxkZvdQbbMOzWntoDxjRs
1sqm1Rlsy6wjrh1s2mFsy27xKb6HM9iO7bToZi8Y12V6K5tWZ6BNA72VTTtMueK8m027MzjY
C6262QPG0HlrT7U7g2Ma3Gpl0w5jmWYrm3ZncNCMW9nsAePY7Vbc7gyO6/KW8WYfGJdpy3yr
DnBAhohRUp1B3MMZXM6NRZZeBzjvgNENjbeyaXUG1zBNvZVNO4xpLzOtbWzancG1nGW0tY3N
HjDOMqDdzqbVGXDUssxWNm0wuoaTb6tuWp1BxybZrbrZAwajv1a7aXUGXdPtPdi0wxiuvt5T
Mrer0unKGdYETccy1urfR9Cy3fYadb4uiA1e95R9BHFQXe//FUEy6jVB9Cq3rcZNgkxbBFg7
akTDXRNkxjIx2FrjJkGuW61aJeNcE9S5u+5j+wga8i+FWmrkG6iazGi1nI2Clmbr/0wmrzPb
LBX/Hb7Q33r1XryoKFfvVQZOtcDbAuY087LF9fJCx2+AfHGe0b5/Yw1wrb2Yh7trMIjhpwnt
Zea0XhIlk/4W36YTUqvL0WGURPkj7U4scTbTWEPj3LbX2MTVXsc0yqd0qqe1UVw3+CbdnJ+d
H599vEJLSoKYGrWL1P4fy3pN3WkuRdIOiFwjTLCXq6VasVhJXQpaOnu/1S1hMM3Za2dmXO7F
AO2lwfeqixQ6jum+fxdmCePaOt9Fp7aNjavVCxgcW+3WVmFLVmBWdaxzbaNRKNdYXazfBoND
xC42dY+3wWBG8Dc26JY4ply6YpYBtA2bhnRGSI4pvpeLHMp6j8DLQbzO5H++0VV1a+m0ZPW3
KBiaQX+Dcn12fvL5tz7kIg6pfph5eb7c4tQNjKwXZ+tP04xW0J8j+Tc9dOJIw8RvWZYOIa0c
mn2cieLvn5T9f9qutbltHNn+FdydD+PMWjLBB0hqyrfKsZ3EFdvRWEl2bqVSKkqiHG30GlGK
4/31t0+DIsCHLHmy8Qe/1H0INoBGo9HdCK0YWeqDyHM+M7J+lj6QX6X3E4Sh2Y33A4TmI9S4
I3oPE9JCOO7OHmc4kJ4MxdXJOw7A0PGfhi/wYIhd4ri3yM+acfqleDVN1m2RB19LRsDHVvMU
adfirFhcfl8jfJvkVQrHQiQU5sfl7dnL66vb1+LqXUvHet/9YWFFgcprIhBBv4Eg1nlrCN1E
RtxkTt/nizUm6ZzHjUUaIrPKytPqkQBXNP7wJjoQ6chpSdH6X+qSdIyfCEiX4gZv7ogzrvpD
v1zQOOmYpGwvkM4hyK5G9pwtsrMfmUwofz+yV22ztx/ZUzBu9iH7VWR/P3Lgcv7UHuSgihxo
ZPkEsoqcA+Ssqshqf5sjznndhxxWkcP9yMiF3I8cVZGjvcjKYbtsH3JcRY73ylnJyD1kpji1
qeLsx6Y57RyAXZ+Gcj+2z/WX9mK7NWx3v7SD0DtgVMvaVJT756JS0SE9KWuTUe6fjSpy4wPG
n6xNRxnsx445zMtWvlLt0L6hTtAs0Ya7aCWvICXaaCdtHFZx4120bsgHHxatu2u1CEmPyQqt
3EWLFblC6+6iDSQfd9i03i5aJTEu2u33VzeXdx3xjT5erE55CQG/PGUAeeryny7yCuhv/DQY
IRe3KNkk62zY4kD/g+unuWpE62cauX5csVF83wnjgLNSSkZKGLs4yz9PppMB8rBosI3SafJI
26LFUhxlXyfIg3qhK+WhqMV0k7bbgrYiYRvlTxb3i5urbk8cTZf/PkXdtcCJTFy1F6E+2md6
21GfmtPZZo0jkz5WtOWaT2abWUd4JpOT9jgRSt7cICj+iXhz6bh+EW7uHGvAcrA59TZb0wy1
XEx+GC92HCQmzdA5HK24WS4XKPcBhXp+KQbJ/GtmUUeo+TXfzJJ+Mhr1ueoeEnHygHTdq/TH
g8nf8WIZwSl2nZCJq/M+Ju+vX5pm+m9fonXuDf/w8cPwujH60uId7eM9FvJ1CcKLcQLagy1P
NvRHV3SKP2aT9eQ+j17NY8/1fJgtsQvQ8bWrdK3rWP1OH1osJoT+f+yHYe4Cf4Ow2G+p6K1h
ur98hHXfER8303m6sgu3ebFS0DmvVmmKsYoswmRK1vSc+bM8Gr4jXP+t4SH9F2/zEKem2sCa
SxTQsEhXq81ynbWrHENrVlgc7XZBSaNEYkjQv8SUdQXNnnUiToVy/ciXsomwqI6wpSWjhgyb
J0lp+qHA3+JrAxXRaaTdzySSGc87l9YwFbom57ZMVLwx9Zh+ZEfEcRz6QdjMgGnASou2pinC
WzNUX3TbgRty+cUmSRHblwWNUaSTVnjpWW08rJG1yOWkh9LsuaKOm9JebzbTSZFWSPvROJlN
oDdJYx7zjmjKJShQkyZdLtk543w3S6QfxJxf001XnIM6H6biErs1GoSbeT7NqYW36XqwWVHT
8doMK7CQUjd9yOtiHLM/8CGhUczbvYx2VNNH8yrQt9sw7zd2aHfvidjuwHECjEcUvNhmnnW4
saV/IbeR2k7s08dasbMAp0YOC7EjXqLAKkb1ZklbSlrRRigLyhHf1uBWTuy5eWiyfGZoMs1S
LjD0PVKdIqe1lvPbMeS0N1N6dOQVY37Jw+zziKlfzAohkfXakENkKFxNUSmHKq1yqC79Yd68
VhB1iwANXdsc155TU/GyQcWbxV5RV0DLPpHQWaNtSOiURULnILQSOpXn0Ga76OjF5v7LGv2s
23Sc5z8bauJ3rbl1k3xH5V0ek0vqbp3m6Rr6mJ3mBb3OBoVnyMy/TFfe5Xj3I4nao23HK2wF
M0Z86QFrlH5bz5ZjeoyJCR0ZIl/FVW/NT0xtxuYkJPGNOZK80VIwSXNIDCFDsWInKD/kMgbL
bd5KBu02gFMegw0uLNHgw1J+zFVxCjakOxTEWZU6cNjHR8qMVmekoq3SkgCLT7LNQGeYGlYZ
Qu6r9B7r7mLVGm1mM9KWpMmQdj5LaUU0AgnIpiOB3F6+74i7wnnFhZYXw8VUaF1rpTSoQCm4
Q2iQQuTbWsL3qLQwpwE+pamSrgx1JL2ichDWBK4+gBT5uqtMKaRkfsanHSbh4sukbROsHqsH
ro78vU1rfSqWw8npfDGYLDIkPT0uNqQo52sxWYvbP42OUygPVgU0vsM2mXZ695WsMaBGAYqR
oF4vmmqSiJRy+RSccbSlUa5uwC8leYJzvdpkiLlSsIe+g0ikN5v7FDabeXNqAg2Dm8lLnUiE
SqCcUdIyKSV58SeDhURUEv/qcbkedfSUWG76f03TuZVJY5pOew9V+E7POCm+/653dUT7yg0N
/AsuVGBGdxjxoUyNvFssv3WOUIYNHF7bEf3eeRf6NZ1D4NYkCrWieeIxZ/f3JCcM4NoT0USv
gZmL8Lcu0um09XEyShc2B1fh3cFxnc4X3xat24+tNxc3V62zzWhieEPHUU5RmUfqUhdnN9fb
rK9sw3093kxpmiTDvzYT9CunvS+SkRncSARSpsIP7FLqaGQsVxJ6Qkn2QCHQo2Ib0nNEzxO9
4IVFGJv6oXpY5iUtMBAL03fraDB8MoQ7whrN2mJbTUY0CB8mpKAe8uwwYP+OGUa7YnpL0nDH
fHHAP/T8G66yf/C7rlI0UiQ0b6znBK4ZGZe5K9oVr7uXGfIP9UmSgyptwnlVcAUulxnIa43R
pL2jpQhGDRr3if5BE/qIVGgCNzPU+ydduaQ1HpuCYITCQaMoICa6t13nzPE6Di3Z1O3nHUFa
oJDrp156D6ss+2yYPR/LciNzfiwijs4u+7fv3vdfvftwe/Hi99wk481Er3tjoHw+D6tBAQUv
TtpS3Nycv7t9dfXaLpJyTNb6/Nd1rklMqh0EUtY9GS3kSOUgrauTP3U/tk0TYH9xd5f6mR6u
Bcc50xZ1EHHli0nf+liXb2AG2jnwQi0+TRYir9CHqnzDcZiPHUuQoQdBPgNspEurYLWvgUX8
HoeANdVoH+wAjbE+HQ5aKgCjiz/XQWPXOfC1zdi1uKO8BwpOx2mjxCIK43SkC3+ULuLjkOWU
cDU7R9kFckIlAxh+JQxpMEKuTdKAIW0Mjyu1VDCkwZBNGCiqYDAil/fadQzS7XBpoUW654cu
y5R+WKKIIhWrJvYpLQ3DR3F1cSmgcb9uAaUBdOSYe16OQwsw5mK0zwD0DaA3VgYppiXdfxZS
ZDUt1E0LrabF0veq3f404NBqWmiaFqFgtFND8oqOkwgYqHd+ZA2gyNGZXXWMvAnbBys9vZQ3
hhWf0P6F627hDg2fdbhB9IKwsVUVxDAvrO40IfZuXhaAEoUzKoAuj3GaIn5Hcmnq2mt69jyJ
ZMhFfusY1nDS815XONbzfpTvR2gBN4M18mSoqiPCxooMFikOS4eU6iXTfHFldcpYMJ5jw6QG
Jm1okpJuWH09z1IljpM2iMgtiUjFvIrXMeoiSgdD055RqW5ulPuid8KYeZZfVTOk+Vawx/Lp
VpSlEplWDOpSISRVa4qvB04y9iGVpoEjbanEtK551c72K1LZvo6vXye0muCjEU+w+6WxIs1Y
KRW8jSNf1YacBePaUrGWLb7iYSyUj3IQlmxohXCk51XlHDxHNpKvQPCrrQp2yCbSshlYTXCx
eD3BXpaNa2TjGtlI5O67NQ0W7JSNb2QT7pIN7aRUFVE9UzaYBlWlpXbIZqhlY79U7Pu1BVHt
lI1nZOPZspFwF1aXQbVTNpGRzWCHbKTvqrD6XuHzZCMD362tW2GzbKRWEdKzmqAaFGe4Uza+
kY1vy8Z1kF27G6Yim6GRzXiHbFDIIa7KJnqebFyPjLGqbKIdstH6RoZWE/wG9RntlE1gZBOU
ZBP5bk07RLtkI42+kbv0DaLWZVVXxM+TjScDrghQx2iQjdY30tI3HupsVKd1vFM2yshG2bLx
At/3quMm3ikbo2/kLn3jhSSd6oBOnimbyFNu9eWSHbLR+kbaLxX7HOS3k70sm9DIJrRl47sN
wy/ZKRujb+QufUP7c+VUpT0wlo0bJIMG2USRJRs/QIW5Jowmy2YcmZejX62mYKPkN+z2aG/O
V3Xo04KCPPIs9w425VeFo+Z6Mv8qPl3fvj37LI4QYicC8Zt0hNweZoE94GqzT7K/fII9DJx9
7OeGnbh/K7FHXGzmSfaLJ9hp3SH2PmoA9TdzuM7TUV7YaZ7iVFhGAZd+wnVkGTtpUK596x0z
EIdUjVosH/v5scU/aZANwxP6jlpczcWiGDyInT2v18tf72+0aJ4+9LNpMkBrBmNqTZo+0ZhY
H96I32IjwFj5NdOVNwff7pNkNehsr1NE0C6OcMTH12d5MVqDEXo1/0IJw/DAPYWLr0bpkGth
TRb/pAlxvHiYF7/zyc3pfDG3HtBg3JYekHugEMO9WkzFcpFlkyIOQOJE1EW9qS257UjFp5Lj
BH9WZTI8wfcQ3PuqS4KYJfPkPl0RYDJLHxarr4aK6PySG5V9w/C9Inar5HVlcr57j8mhK3Sr
EE3R5xvAcue9yoshGj4V+4G5hJBrCPJdrIPNeEwN23sTGzDCODgAw7p3tLhvtMCQjh9Vg5h0
ODOJmxpufWDOZgvuMFZYAf6li391qO830xGHmGxPQ0Qypz/5zEMX94Rznf42kohQlO6z+Piq
18GVoF/FXxtiyMQIP/uqTRasRRvDitO0+Pyw6KDG4CDAyRgpM696rXPA4F6L0piMXE6vXc6X
pDfmXT0SMKoMhefguJ0oRL4+dFGeGs7zLkKymEPPumNxdZGxt3iAmmj6olOrLV6McOstkjwI
yXO8BiR9LdsWyT0IaSybkALFjt4cCb6m0SwRrhk+keLsWIvigGeFje8fSl5vcyT/ICS/ESly
PUuSwUFIpH8akGKX96w5kvr7SLHkO3FKI6mTX4QYluuKy7ZyI66pUpqUfGnKclY9P288Pa+c
nbvUR/Dr0nyYm4d4TtDsxd96sf29ZwFAkUHYZCYVKMHeQwCguEHulN6Bog72/gPN47Py3Wjh
wW5/oAVs2e07S3cNQ+jAPbceLvuoyp3O+ziSwhU1fdZTTcqKbxE3kYyqWtQXsJEDH8P7865I
M7BPMujoJjTWdVs491hfQ1nH49sogTegV94P5B8LUpiuUwOiVUgDdcSbAiQrDrRwrGa3WGti
PBK/GRzf8bDV+nDR3SsiiQq+bhRVm+JLPr4giNY1yjf9fRyuKrM3fqJgiGkNphl71z0vMaBa
+Uh8uL36U2TIJuLanvOMT1VnfFTfNhDa0VGF2IyWu5mwNcMKVmWisfckUxg2PAlMt6963/w2
7mgYfh1+obU7nT4FJPVKUzuPglvf65gspy7t1BArepdO0yRLDYAb1TwPfCh2PUEcKiKbJ6t0
uIZ9dQLLndsyLkJdAOFFte00t+FMxzPx+XnvjG/sohe6F7D2khU0rwVCZnnUZNtyxMHWbGbL
MvuSkHogcd29uylfv2hdnz4qGVmho3xvGwFzft0T+RQ6Li6BVr6hDT04OD/MEcnFVWDJ3iAr
dZwVYX5eWyp98+Q2ppZpRlYkbRS4bw2xctHf1UD1nxWijidGnFp5Q1YV7sflu12pkf/mKPt6
yBg44gie9yf2kGH0xBZSI8Ci/glbSAKPPOk0X57xA7tB4PohXLY/qdGKS812z69vPlz/cfFH
6xbWa7ZebYaIMcgQhMXG+vZuezO+YtwV/plzV/tc3oH6bU2qvNNqtUSPryxc5BFxn7hs8OeO
mHPJvFXWpydQI0/J2kB+vfUfh03/PsewfEump8rBLW6DRZaeSppYtGuhcVV86hH1Zk1/nAZi
W1+/n6VD4Czmi/HYkG7/8WUxHdFPSwax5yFIq/4i4hw7R0ye/D/9vAEC11cY/kj6jYJo4Net
rfDHLi7UaeBveqy+eMUMatq2ed6ex+Pf/S2Y7oJSE4CBmP2nmmC1vN4ENw6b3+AZTfC5+kID
xi7WejMCL2iGeEYz9M2UP9QMhAj8aDOiWDZjHN6MOHaa+7S5GbzlrrQi5nK4P9IK6lTpm6ju
LM3vRaFlepOt+QakR4StZ4YjcJWz/6GmufVnKhcuYqziQEYKOOKriWy25LuFTqXkRYpNvFMZ
isEGllf+tyqA/JBLwvxnsBmVnVEeCvApbEbHCIrjDOkjlNXe3jgZtt3wxZYW2e44B3qbPmrP
dGJywKvBsKCWbOWdGSKSEUJ4UXf+1++BE//ayIbSN5/F/XKy6NMGZbCYU6NpcV3iLi+yQtwU
wbRYuy2WEDFqZRZo+2QuyAhgbkPsB7JGbOH7DfgBh6AeiB+yGvxyn4wHtEt4fUZr22rUvPh4
fuQiNT0npjVvkGK14b/bzjZUj5e9dLUig6LluoY5juFOmixnE7KHsgwRuFzeg+S77UAvbhuG
QErY+lfdmyvR08OX/cNjBODpDBHTtMAN4REAej+bdMhM480FLhvDhiaZP9YwjjIzVgISs9w+
q3f1qvYkQ0n7gRDp+csNjfAuWZwr8ZK0NNKyMnGSewxOrm//7P1f7/0NWaz4vfuvu5e3+J35
9HfHYMZcyDH3g9uQn4jx1ectYeAovoitl65oWndE5AbOCdmbgVNkzPiCwyz1vXJkEq+0rW7n
rxCOpxz40HMvDFe6x2BCYQPnuzeOxBGK8JxiZ4kA6/4g2YxwxTdfgfQCIy4R/NyzAjLy2E7M
3TGAlAbSNZDewZDKoV4hnXTB1bPfJ9OvZDGJFo9N6wZ2ECo+ZVmn0+H0a99E4p7ChCb6eWs2
XA6muNJYfHkoBo1CYSbkTCBiH2WHOGofgrsnYc654kOKXJ3TW8Pielgwr8nAfv2nGE+xj8X9
duxlzSfAdtDpGCrscbQHnoNM87RXWgk2qUHNfYzTZI2QVL61m1BbjN92bGSO0TIeE+sqaOMy
ccreZDwAgZefxZve1QkNb1IByWq7eSprWEWbEuz8+CqaPC/s6O6F6N69O+HbaW7TNVS8uNBX
F7cs5YtFoPU1at2ebePQgBfxJWo53jkZy6sJsmiOhi8EGWFxi7pfFflnKxq9dr6W3w4Cei/t
999xeLatuoHRxknzBSu2V8GTe5cofmLvwghcu+knbAP8dkgGrDrszpdn7F2CNukSz9l2YSl8
S6TrL9QJR9jvet7Nm/90PLdFS/MLEbidwAeZdDue3wlUAeb7MYoX7ATbPULOdXJ3cQUlwHQ5
1Unk+PB+33bpW+/EBSmOprAUfMrd5523Ly+Ocwd45+bdh886aUQ5x/TNF3wd77F0C+iARA2r
iVTjoqOfIAhC6ED5GqvhU1zxrMR39uHPXXzFA/1Yeb5bLARn78V7uECmfKKCegMuDIjBAqup
vTBs5/gJP+qEn1taFqR5QuSEP+fslcElCrhM3CG3beuGKy13gT4bjJisRbYQhNKaYv52RDJK
lmyAwraiybVMh5PxZDt3wOpymdnlMAppvcEBL375XrItjnPXFf+TtsCpMSkJAfVPQ1zJMktH
k06haZx22A5x39OX9XrZOTl5eHhoa5r2YnVvuGOuiThbZOu+yeg6elEQ+J6HcrqagGRQJyDl
E5cQrFwimpOcKMZJ2wtkigqAFMyh78JUTb5PstZ4Ml5sL3vX+lZ3jMkQ44p32xt4sC46uByW
bfzKf80DIs652OsLNRxxGKGgR56BIe7yihjclKvuN2UIowChGtmE+hkfHOO7z+crN93rHt/z
q/+13sAVyUZGaeAobG5J+vFyjp3A1ZyvGAJd3OUrwvKEEEMvHUwn3lXQQkhvw14M83nMR34p
NaHhUxkG8BMi4zW/SDdPdXXyL3HkvDDUkYvVsKD+eHnXu3p32xEOLAJH+oYydqBKnR/8KvBc
h7M0/3t4kstc//fwXM5Vmm9mA+phsu1vutqSZGsDh7dB2xB7fOeGId7Ws/rFKSYK/Pq+xeJL
7H3Qd+yh+ZISE3dCu/nLcAaOLrEk8kfUPg88L096Ls64f4HNUX9JMnJyUlAL3GQHi2tSVDPg
i5EthpBHQYnhgkY9jfdH8Z70X0fYxHwbfIn4+n1PFF8lYjKao3qrJR4v6alSWqQx9ImFKzgf
kfi0Lx6q0Ryyh4aRVL3z/8w9a3PcNpLf/St4dR/iVKgR8Qam9jYnWVLOt2s7ZzkXV6Vcunla
s3rWjBRb//66AZLAeECAyjBbm0ocWUQ3GkCjX2g0vgX8GRa1vSGPOSeeJvBoify2fTPvtQwe
FwFlWG6U7A6CRqYeuF/uDGKynmIk3VXDCBsrzmvCXYpHMFB7djT2TTWRbdEwMIqDD66+Lhjo
KFAbT6gsFpgSU9qHIcvif1+CD4I+0/uX+P9z+2fDEmVx4j6/CWUIM8YWdUXEpGyN0B3ElO4g
bq6EW8T0W8T4jlCDmCYQs12KtxCTHcSa2zI8iJgNORVgS9hSvIiYD4kYfHJbCBIRi0ERU8Ga
qZCDInaxHYtYDYpYuKJ/iFgPihj2ZDMVJmQ3W/Um4GPyTD4WeHW6RjwZlGK8VVYjng6JWFa2
qodFPEtt6cxU7Ow8EBZVs3jzQSkWnDQULwZFLHXLFctBEWvKa1lBBpXH+NqRqhGTIRErZ5ha
xHRQxNRVkEfEg8pjxYyoF48MKo+VYLbgNSIeVB6DaWMaxIPKY0MIhrct4kHlsaEMFw/Nkoc7
W9KujgJuxkEbG3SDNq5q5Jj6T4ziGQd8ckUfxyT4JOtPrq7imPlP3OpD+OTKIo558EngcSp8
clUNxyL4ZJ+Xgk+uSuhY+k/CXhiHT67M51gFnxTOHHxydTrH2n9yN8bgkyu0OTbBJ1t2BcdV
j9m7n/DRngDgx2bUwbCVTbXGj7T+GEyX0vggKH6sJ4UEs6JtKXL8WE9L4MAZrSq3TnW5xzEJ
ZsbUxQbz/xRzcPFHAaQ1xusqED+/Lt7eHZxfgj87e7TZOIumJdaz4OkcfE4TMUiHoSMB2z3j
HgaCMIBxcXd3v7lYzX/AUP5h9bXzuWaBtSkIRgQ2mFV8UZd3ejOxJ3jFxuVnvRRo6oIzYkD6
uXpRSunvD/76UqBBqZSQsGUPCIO5RCn8vUeO2YOfbO6uq+HiitsdwGb5OBKVKWaL9cNqucLK
KxsPxSsej4ruDvdq8XRha7fAWInBx6kZS41W2OD9nxJQU5TYaqntcePi1haNsW8jbh8bYmNu
nyK/nD3cbZ5sYbTmuOrufnFbAB814fmX8LOXO4piRTefX/R4+7ixx7m2hODqBg/VmmQjQ5pU
I4TTAo3/X+3jiRgiWsxaD7yGdsX/dSX1lQcztk5+Csw+1YCF2Qp8kh3T+Aj1CDANG/p9+/Eg
Du1gwCUPOmXuklpYwvy3AjfWJcxh8Wm3tDnCUIK89lXLwxtY2jObwIsBxdkjwPz6w8dGPmNM
F1M+scxHU2jt0L5jPwk9VcWYrbn269H7t6/f/mTr5GE9mp8xsmRPtrDa3KHr73D+eHN/gYWD
XIblaDYGxx5jmgv7W+Ag2CbQi5kEHYgKRaUrDLQprle3WB1tdTsOWth6rNs9Y42+cbH5AqNZ
rA+r4sNk5Rz4n4pv/vlQ8BExo+pgPZMHODZ18LmiC455lv9OfS+qwl7+a7Ke21J7mBo5Lv7n
9M0vmE+EZbawDErxcgXO+NnH4gd7rFXi2Y0EpWhLPJERqUb0gBQVP6zIIQ0iaLAnOKI/ff3z
ODchxqZyvbI112eyqEQxm2MF2mlVcPgrKWYKeigox5/taQT+u9DAPsUcfraXz/S04AyrBLeN
l7NCkcJMEIk2BXcYdPAzRyQAOF3WOP9SLUFVTEHcFTNTTCdbHU41QoOcmVJE2UFUOyxOFZYN
Oj362MRDOClOj+FvQsyJWVJdnL766GMlxenJx93ICdbbxWDI6fnr9iOFpq9DwOOfa6QLmI7T
8/ZvJkDDDebDnpwjnJpCq/qHM/vDXBc/2R8WVXFuf5BA3tnfj9xvKalo5VmHywpF3qv3FcoN
DJ0yBn+j46JNWHz1ngGgnBlMwoS/8ZpeuQxoAt3CbN3cazxEmfm4DnxyjvqPxf2D3WRfJtdX
F/ef5xfWPbVReSufJ7iHWYATZoulADHz8ctXhMX7SSGkcS+b/AgSY311sb5DEQX/QxXDkGeJ
DBu7R1l+xBPZB6sSfsBL5If4R9sKdzqxrZzUa9oxiehI0LB+Q/pHp5FBMFw8TFbXF1/WdrsD
iEHMQXubHmu7f7hAzXWxvFtfWW2ICstvQ0Ft1UsrSjGG/oDzXDCtSaXm1XLBhZlNlBWuHoZz
1MSNTH2FUwYiKhCmoLnOjl7//fSkLIy0H2z1NHc8P/KI3DnKFiKrvTC3xhVUsgXZnPT0YOAi
iVz/rpJfiSf33f0rm5vw/vG2OLRZQ5ONyx6qNXzbUFWSBFmf2AZ1c1gJ8NF9tGqveNnUK7R/
bbW0NrDJjcfzsEYMT2lUPIYJTWYd5LfeYPll2CfPp0qOKoJ5Jp/qUZ35jAJ7Uw/2yVNxENTV
ur77bMua4gW7f9xNPRa0JRosHxY3eGK/fmqmEpfzy61L/xmDVYwF2y6LJfRVAB4XvwXrpMUG
Vokwe9OEYTc2FE1gJSpMC9mPJiLA7TLD0QQOp9ybJgm+CBmMJi2Mo8megL++Of1qD/N/Wtwu
MH/u9Ov9NYjnNdYMxyKNmUNwEh6Cs6YTCiao2XsxqAIneLCBA/8Ld/S/F03gmXI5FE34kKDc
myZWcftk/EA0kSE2t/Ur9WA0gTWGzoXDdn/9BBL14fIA+i5sicMG60ui5ffgEq1vVrc2pcPd
MXmYPDxumuwRaZ9Kqqq9RwhuNB+MO8E7t5HQPWkCHx8PdR5hy85/I4Z+GruzeWzbJGIQJXx7
MCWGWyXNqd+vf3gMWthqHAPRBMqT7C2JmAF3aH9V1SyL+RTmBi6+grsLtHx3uJmubg9v7uY2
R/e7b39RHEx/t/dWx22a6nf53igoxT/c2/1sNf4dDX+sF2Jru2FhxY39FTk64xv3O9hO01kl
N+AtrKqqF1F7TEFLFGZ11gQQ0kEUew5RasiZwivCHUQRIIqAEu1DFKkGJYoQ1r18uu9MgSwe
gIOPfznvxcGEDrsuVde6SLsuPaeA/VOnYJD9AuN1w4V/v50CjEzUrNmbC4aQLIMTJf4ViRpC
sgxNFB1CsgxO1L7bCq9jIDVjV0ha9NpedAgJM9hUtFTtwTXOvZsCCcZSco/UuEKoi6ok5ZXi
5Xpyc71Zfuk1Qf9S8qe2ysATq6TY17ZTGOYbzHtSlTSZm9cSY+KdR4cOxZ904CWxHj5nZujr
C4iXVsMTXXMf20OmW6GAsuBVddZLFrB9bZtndbavK/CszvbQ18/ujO+7ZmAf4RlaL0GAx6vB
nYslPk5iQ8V4/t9StK9qaZ4m6DX8ASzk7PCbdR1iYKTvwOQ/k4nIkJY/FUfHHZa/fobzw/cx
5uoQ6vh+trm/WvfpTuxjpjXd2cu+vQY3hIzoy0tij+W1neF5Ny5sv972MfLadat/OLClDl1l
wF6d7ysPnjfUIRTmUSX7dTaEROjd2TBCvF9nZg+OaTtTVdWvsyFGdty3sz2EStuZqEivzvQQ
MoX1lCl6CIuK953GfQXYc6bR7LHPvDtIUAES5w4eHXPi3EFeElISDm4hKRUtFSvBP1SiVLJU
qlSmVEelOi7Vq1KdlOq0VGelrkr9qtSnpT4rzXFpXpXmpDSnpTkrj1h5xMsjUR7J8uhVeXRS
HqvyWJfHpjwx5SlFz5OX19gxLXt6oGYPkfbN6CmOXgbOMC2vwA6AKYA5IBT+Y/Af+Mf4TZa6
7O8nmyGchzOSYXVr9iqsC0/EnmdGiAWU00AnmgrrmEi6Z7oCYgEXeKBzKYXplxQTOxI+OSOp
itoOhRz4VjdpkTNiizEN5JN7vJg4268cGqZFXtyvZlcXNzeT+4vrydPdI+Y6gXWMyU400YkW
WrRH2Mj6m8ly8c2xLKvk98XVyvY3fSo+nL5/U2xWn28n1w6NHlWM6mrPs0PEwu2rNUPwjcbX
UTTd8yQcsWhB1GA0YbiqHSFKnYNlzbcHn9eT+8vVbPPt5HPefSZOlcfMUFPvO1rF5VDRNI1P
uQjMj2g4eD7PZGO1VanDJCo9whd4Dd93bKQyRAx04g/YKOXVnrkfiIVpPZCkBGwcRMaeEVXE
oshQSVSATUim9tRyiEXZGrQD0YSXy/efJwkMMJDmBWygocz+NClOq+F4HObcJ+W1eTub+7oC
05aYEiSXuqNHlMImbAd562rW4DC+wSUTIu/F35qbExt83R6fZi/e/e3fXnxw+Z7F72TEQf0X
xcnk90Xx33dgIRR/mcPP//jP9WJ+OXnAsiV/bShiilrG2idrFBt+8jd4njaomp26vps+bh5s
4WsYFaHfY0IePkq6aG/FjV6cAIm25p29KLH+/Ghfah29aBAishrpBuHrK7KjpuOTlinaVphE
vbAlcJpuUG/DuG/so71Yhfbu3lY9DamHVlni54v2ZfSWgObZWyaqloRRTRb8mvhfvjg5evvT
6ftx8f6Xt3jDozg6L96/e/dh9OKX22tcenzkGu9DrB9vb10p32JS/L5aPzxOrmFUtoBu6Z6A
da8rzCaY5mhzGYE50Bq/XtxsHF8DuVgzBeu5IK5Xb96dvwA236xuVteTdfEFlO1ljeb+7gEm
HVb7+gm6uVq4LuoOgRfwnRF7WQhZEcvCTGDXrG/s3Q18a+Jh9OIFvlV+MCtu774AQDsa4BFE
eoW//gLc1w5xfgdEuXRpQsD0wTvhAxuRiJcbRfvVu6orQ9pxthe8NN7vIqarAzEyhjPT76mS
Z5rWRI4q6qqgDzsrEg0TjVcINvbuXSN3/q/e/Acojb7D6nju3fe76ebuevFgny9BCNg6xfm7
i+Pzk1fv3vx89MFhVaMKr2j2K1z2DGoBr5KE0T9lihG5tg7AsESjFcFFT6KfiRfI/VNcOUQu
iPApkA8PT3xHy4mMlrNYwGEy3VjsK9clyg3Uxs37ORZQKzk4Azk97tUuECR2hpXLu7VYhH3d
vQtL97C04hUPAOlO97pP91ow3Y2ls3uKjy7SAJDtdG/y3VMihdbdWBLda0JCQLlj7dA+3Rsq
eTeWSPdOObvb0ver+QWWLfoP+8pE8622pL6gUeJuNOKDbjbj+PF+VPwKHn8Bbj7WW1teTz5D
q0t7B3MBNgnaPk+F1Xw1tnNXmxjQPcwu53efG9pKvEWJ0lQY8eI3pBrNDaD94dKaU1iFFMs6
jZqP562YfUkKOi/MZIEvEhYLsAqBviU+EvMbGYsx+RQHmbUgLYQufqNjNsbCBFEYswtioJMK
YKTq6GayC0OqJGV+LLqFIEgZGUfpogYID9FTSxMZVx0k8baDedUCMQCSOHjRAeUHP1UtFMeR
kM45nkcGL3AoMJjohEEvxHdEPJSs55mb7Dwv/aBSLABd0RZG+ql2K0rjs1cFMKQBocQNKQoB
3fBwdSitR4KVznKcadqZpiwxFBnjTCrSbKAiICrBZrLwUzyXLYhO97KI9GJyrOY3c7ssrEpw
mizIbjcstw1YBIYlegG6Bawkm7etRc0qcV7eWsn5tIWSiT6q6EhUmr9YyF9M9ydKsRbKrUlH
H+GSzEQDw1NirCoie5+nxJgs/IIsTQuSW8VppJvUXtE6mOJ5OwGcp8TSltBseZ8ndxjIyQhp
yqkY3aFhItuFZ3YYaJMdGPCxnSZTukvKItMsaAtAGqlEaG+tJGjNNLyrkwo5sxXHIi2RKnz5
bHcosu6E9J8yYeU+7cEAHkRn1JJnTrZsgUyGOf22mU4aIJmSZKRY7tImSb2atEsCgNIK2zcq
BqN8cZ6hkV5YWgREGECm1H+Fqn5HV8qc+o+wgJR/gG+kykg07Re0FWlSJxgHZF9kPKZem6pD
qEV4TVUZtomAkARhsJ4RYatoRqL5CZCzFog1coBGN/UWT/uueIK6cAqW7S5QwqmCTo5G0TFp
p1nJlq4O+RSdAp1QnKHkYK12Vknzb2vnzNpZ01WSbUjEZtQkMX4w9yNso2lSs8MyRrrhPTWu
7yVjNsoIiMwYdBERrVVKCsbHn17NiLbVmcWknjDjPbq0dxZsG9IygKkltO5vnpv+ho3x/aQs
my3TjrVa12QWlAb2Q7s9jUxJz5BxVGuqGZ1g6SrwHlruNBn96adgvvDOc2qzbW9Q44FS261R
oHri27deGu0Qn8E+IB4sY0VGeJRUou5KdMx1TFmTKuWqddi4pMr5Bn6NZh7I9LWmp61nREiV
3KsksiGIjVt0iYS41UYwbJGOJvghGenBeFIwxC0KgqGLpJzzo5I+BkFS/l5UNhKSXicZGCKi
tV0wgaebJQhGKdrFnXogkpEOOkIfbQx/khUPAVBKFcX1N8nFMKJbg7bq6Fljer7PQGjSaYhr
MUJzFkbEnyM2/IEznrd+5j6UxdJWI42Rx2jKMNmKHvjtzljaE46uExPpoCaPwbR2oO4QYbHo
KUsZG+FuCjrSaeIo6AsTTIDJSFavLpTffDyjymKckIyhNI590JwmuS3OoulgSBja8aovHQwh
UYHK0759GEEJOqqj9B0T7f1n7dU/b8L0naH9GNuIzPJ4GEU9UG0KxqO78SGJ9CLFzEciWHpv
+36UVxGC13Zq1LkL5TYNgHIGZEyFiUzUKn40YNJj8h35cAqRGbUX6Uc20S7awXck4koRydzk
0U4XNLZfZdrUiIahCUZJEg5lzAcnGCVJmkJTEAxLbwzaAImdhPgsbMU8g250Muobi/mQJkiC
1Vd62wuZKElccjVBj67JjsIklVfHEV4y5FGFoWw/DS7mAaKhM16qtmR3G/Tg0SjuFmWBVlEp
SyaMxsyDrlK+G1KG+o54gZoOk3SYS5kARodhplNnMltCQXj6MnGPGGPnAh9eCAsvfNrQR95c
CnpKLVCowVQwoJQ9Et9AJmUpEDwfjMAkoxLR0ylieGLPVWiQRGByOiVKXCbOFIqEpXf2TC60
b5l77hfVmFYydrmHAQO19gKtGiO9/3kQrdICK7AxyMQDsYxgiJ262jhDtxHsV2kajEhmjE2M
0k79YXClMv5ahC7SnFV1RZyDY2d/HE5aFU46MgJi59vJEEOFRaV3lBd1IYaOOYgvah1e6Obu
2HE9Sen8uOqiJKfz3Qmcb9/o/HigcvtUZOHBTNofiJFGM4ccEcFIbTAiEd6MiG1KU/6qtXoi
MO3+6VBEfhbozEOlVX5Ed1Faa3xCulR+RDhSmj7vipqMNBm/iBsxNB2/qDMLpOeDTOhiWy62
UHXsgnWe4EaOFGgmdBEbTS5yEbHOaTpwEepib8dRlmaEiHFOWc0ILJssEXSTYQMvRHzIhyZD
HVVUKLIm7Y1F1ep2EHXmhT1LRu9DqUDaaCjluUC8p3DiFR5vwvG6K2VoEe0sc1wSxAqmHiht
mhA89d6dRK6eHwqkXCf3UyjzjecLnsnV8dtp6kclMqdafnMY44Gef0hJc7GMmONPRcrGj6YS
UZGyOuMCQjQnLYR1BaE9nwdgqQB+1PSmQiVFUTBvwsNkIiZevyy8GeQiJp0TFzUaZJViVRka
7CqASh8UgOyPyT1JM/5RbJ1kKrQFjlCwAQNbVeay8fxu9xrNppb0ceMD6uoULiK6dPpWNi6V
6XXtkCcqfYAWVWYqZd3W2txLBPWMMzDqOU6JjDaPsYFKTXOHkaZ0u1s7hFbER6QqtSG6Jlsn
d0TjIU69CNYkE/6Id5M7rMT0Uum1nubNDKgOtRc7V6E67ejFZk2n/LztPDbPCTodCYySZpL2
cDyWTE2VVilRGJIUjDGGM7k4YAyGJ9Vq5FSBmsYnEPkoBvezbWQueBYTCUal5W/MHjSpJLho
Qhs1Jm16B4cRrXXGqiodgN42PH2Cc5VZp/AkeeKhePLMeksVzagHk+nc6whTsHQUZEsrEw/U
xMjjPunOyR4j7fSJjvOImL/MSMrHjqefE5qUDoFeNR6GZZLVIulAzIUz2FhFB7QTIGckE26K
xVkYSed4BuFxf/mA1ItjOuSw5++p5+9MBGRbwfrrATYIYhk1L/SXQW80OSy8gxI0bo6yWDdf
h3NGc4dYfssJv3doJqIVEViMqrSYi8cYmL2G0uv+gr9agA9SOklsujZQJEjFWC5jxtO39FdF
WDryGAkeMcaaJP7oUfL2VakALL1WoXrRfq1yd0xico61Flo8MT2q/xhPWbbbEQDfFc9Mut+A
Mz/nPJ2mFD+lYjzpWG5ZkN5WY1ykd0hwMjHzQCmzOAzwzBYepnE/eJQrOmxPlg01eCCfDs94
2r0MPEUvxP3dk65dFdhrviuRNKnjpi4TjXvZqdQj1ylYJnXCx098XjwTqQPFJlLqhbjIXg3z
kzDzcjkZauiwDJlIbd3QOtYBfc3WpZ1unBdJwl8TS2ZoVLHLK0w2/CCiBzXOytsCSHJC/K6f
zJ24eEnE/KaVJjlzXj0rL75UY3bxDhfG6wzpuVul3ZEoc7tcBjSPO064YvkmLJ3NIEPx6m89
MJXJxdsKabA2MUF2MI8Xx9ILBtXcyOny/WJyy0YBEqf/ATMEozHPGY1uDekg0IAzghAAV1dX
mhfTycZdfl/dLu9chQXXpJhNZpcLrJDUXk+3T+1NbEkZWzlpvtjM1qv7h7v1pmlyNJ8vnBuN
LfBx341Dio/xbTci+OjxTjO8Ov9NO1NRudNu8+Te0aTVyGheYbnARJlETDvpLJNYo+hZC+SZ
tTVq5HrogiAWL76mPDjRs8vV9Rz4zMhP/1/blfW4bQPhZ+tXqEGAtsFKJilSEg0IaIMGQR6C
ADmQhyAwZEn2CqsrOvZI0f/eGcpaew/ryu6TZUrzDUUOZ4b07jd6E4d6cO5nuyj8Tf/qw0iS
M8XzwyhnBNIKtxMgK0Xipa716FoRD5naaz9OblmukjwvTP0N3ENuoCrPVvqXd/90+GBlHX/C
d/2bQLCvHZ/CHq/jW9A++hnY+4Fx6VMT4JtFWN5eVxRiTam+tEPFTGIzx+mvbiF7DKQFcMcR
lMxgE2KuCfeIID0ELBz8wQBbhoKBeGtPZWBRgja1n7gOxlGvXCHHUdfMJPRUSqTNxhFJJbkf
rqNku97AWJY3+BKhpYojR+IkPoMhukPmcp9LBmbIGZ4hxsBZWVPJZFAQdtG9ZDKgf4hNpoWR
XExlk1GC0rlDEXSfzoUTOsTngjCc2HQan0snaNE7LDz32WxA/4gVAjBS9MA8rt9CQSmp3TP/
thwafkSxqUXl1OlXgrAz6FnZoH7I+hQKtzif6h+UIFJH9lifLYe4hBSKQ9zJxqcEJe69Thuf
M+gdEcXBulJTbU8JUkv2MSk5ZIgEUqGADyFzTM/hrrB6wxdjp+PXHuEZcoUO3HHpOPCZ7l0p
cSWxnsm9cyzVa3Fkyu4b4x6u7T2C83iO0LJmHvdxDUPc3qvjNCpVwgdd9E8MAIcBkLAHcHoc
gEOsARtUKC7+TcxEBwCCFgG//Sz0cwqcs5HcdjMtSCkRNh9H2DjDghDfEW6/jxri0FMo7hH1
7FgfhYKMuIT1xCeHDIVnhUKPCsmPjU8oCHMoZE+AcAgfod6iwu1BOa2eU4f2e+ghpj+Fwtw7
ydEoDy1w2NhRSb9HF+dQdEYU2M85k/kTUZBzQXqSKlA/lJsoFFijzlTTU4JYj7vX9IaSA4UC
lj85M0ZBYfE7nvGB6Q0mhgqFWxabanpK0MZ/wZsbOfYIT15IQeG6Y4smTvTZCA4bxpGcnTN9
NipxcEX2LWs6lHgpFAEZ3NRlbQtTUFe4YJJfy7jGAwX9c177yUoXxCZgq5auv/evl+/jbKXD
m+jt2QNc6x2AK4XEmDPTNvYI4lniLoBLQogcZ3gz51ApoWIkw/O0uLtnc/+9DMwkB5jf1UER
Hmc2dRWHyGUdQVMRBdgY5CGyeeZX5m3HGGHs12p3KBRq2U9TNQDROJWHEFAGDxhbeV9BEgRw
ieX0HSQ5uEvvh4BE2+3b6cNuaBACK5r0RQQ6+CLSFnbfjtOhYhBC2rTvyMChvfVdbNskhBN5
m46dXwVgaRdGhQz796FOhziHHOBsZNW6X1igKRT3rLEp43D3AJkNRS8AZkK6Uv5CxZEGepJB
n5Zlky3xJVd6lte6agVvpL9qWXHx8BccFPa2Uy2IVMvoS1ZGu7iCnurFpV6d+yVoTaMUrFut
maBoDv0FIQeT5TFCt6MnKLHwCKoq4mytJgKWTt2U0QpwquA8Cpuk5fKvoxTAmjrMYe2FUa1c
wAGGEsd6FOZTnRdFu9jB0+2b10ikH5VH4g5a1f5ux+b7iAQWN1CVDMImQsdyr2MHQCbor/TH
ongy9IT9sSTjTwrI1QHB7BcUArPyJ+yPFBZ5ANhhwePbbRKNBbNciz80h1uwuqnH90xCZqF+
Z4iw8MJK/9gutX2NC5A4PEgt1z482FVs6Nam9ibxC/xpD48XVuiBtB9R2hhxuuvim7HVfwT5
FcMQd2H8aPwMchsjvtxwalBCDSRMsN9OFqPzxNg8MWueGJ8nJuaJ2a2YdnGZen9oCyXeTqdx
7dprm2sLoy1uYsAj8AW9HlypGxctV/nL9hMa0KmXob7Mqzj1d9Fyr6/7NIK8jIwYrMMMdj/h
+VS3XASq0kJn8BlGl3EAiRFkbuQsi2r47sEHgVvtN72povIsDrtWtDBIVsKo9LIAn8qN1uzg
+pbzPLYtQqJqc9RmYMWUHP3vptlBe1kH6vdmT2VraJjYmzKGWIr5kHfKDs/SKIx9dfss3npY
FSXOR4nS+aJsvqg1X5TPFxXzRe1Tolhexk8g2QhbpBgrIN1AEpDh1KU5WCLE6KxJEu1PTfOL
AnZSaOElGIeHP/kvSz8FEzpvIGuv/epiXfhZHEDuvtgbhQ9bCm9/DUui/LH2kyv/plrvi/0A
VtAUIawyEy7WsDDAo8KOQR2bQu7kgRVrCzBUM96qvw/w4GtRxll9YYL+i7TaeXkGTUqvAYqr
fFtj6GiKQ2eyNF53VuupVm2R50XVXat9CbwKDpDHUEGeFvVtC6gMy01oQoaWl+sAUybPVe8D
SzyEzclunUSXUeLBLkBbtIUFIA7uVKO2CPIM66x4kKACUuSXyU37BtjyCet7CoZvefTcUevl
zvcAMIWcdVFeaYsN5HnBuQdbluYaFvR1vUx9zK+0xesPHz6v373/++0bb1lc7JbqkSV6CgNz
Q4DfxjtjQ9AmCJbOWO6CwOCmXBIWcXBhtrsVgYTZ4sxxnRAdCPWtjU0E5Pt+SMXyMkXQnyBE
pUmMMrANeIg4xm4P8fhI4RxH5dbswiGMKNjTi5f/ghP89tf3/17oRmtcOrS1V99eQbP2PxkP
jNXGQQEA

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-ivb41-64:20181011020847:i386-randconfig-b0-10101847:4.19.0-rc6-00008-g1be3f24:3"

#!/bin/bash

kernel=$1
initrd=quantal-core-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 384
	-smp 2
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

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.19.0-rc6-00008-g1be3f24"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.0-rc6 Kernel Configuration
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
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
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
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
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_CPU_PARTIAL is not set
CONFIG_PROFILING=y
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_RETPOLINE is not set
# CONFIG_INTEL_RDT is not set
CONFIG_X86_BIGSMP=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
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
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
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
# CONFIG_SCHED_SMT is not set
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=m
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_X86_16BIT is not set
CONFIG_TOSHIBA=m
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=3
CONFIG_ARCH_HAVE_MEMORY_PRESENT=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_X86_INTEL_UMIP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_NUMA is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
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
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=y
CONFIG_X86_POWERNOW_K7_ACPI=y
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
# CONFIG_X86_P4_CLOCKMOD is not set
CONFIG_X86_CPUFREQ_NFORCE2=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
# CONFIG_X86_E_POWERSAVER is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
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
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#

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
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=m
# CONFIG_SCx200HR_TIMER is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PCMCIA_PROBE=y
# CONFIG_RAPIDIO is not set
CONFIG_X86_SYSFB=y

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

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
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_UPROBES=y
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
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
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
CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
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
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_DISCONTIGMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
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
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
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
CONFIG_NET_9P=y
# CONFIG_NET_9P_DEBUG is not set
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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=m
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_GNSS=m
CONFIG_MTD=y
CONFIG_MTD_TESTS=m
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set

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
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_MT81xx_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_SPI_INTEL_SPI=m
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=m
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# NVME Support
#

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
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
# CONFIG_MISC_RTSX_PCI is not set
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
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
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
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
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
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_NI65 is not set
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
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
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
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
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
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
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
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
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
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
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
# CONFIG_SMC9194 is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
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
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
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
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

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
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
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
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
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
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_NVRAM=m
CONFIG_DTLK=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=m
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=m
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

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
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

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
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=m
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set
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
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

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
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_WM831X=m
# CONFIG_GPIO_WM8350 is not set
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_AXP288_CHARGER is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=m
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
# CONFIG_SENSORS_MAX34440 is not set
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
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
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS80031=m
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=m
CONFIG_CEC_PIN=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_PIN_ERROR_INJ=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_FWNODE=m
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
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
# CONFIG_USB_STV06XX is not set
# CONFIG_USB_GL860 is not set
CONFIG_USB_GSPCA_BENQ=m
# CONFIG_USB_GSPCA_CONEX is not set
# CONFIG_USB_GSPCA_CPIA1 is not set
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
# CONFIG_USB_GSPCA_MR97310A is not set
# CONFIG_USB_GSPCA_NW80X is not set
# CONFIG_USB_GSPCA_OV519 is not set
# CONFIG_USB_GSPCA_OV534 is not set
# CONFIG_USB_GSPCA_OV534_9 is not set
CONFIG_USB_GSPCA_PAC207=m
# CONFIG_USB_GSPCA_PAC7302 is not set
# CONFIG_USB_GSPCA_PAC7311 is not set
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
# CONFIG_USB_GSPCA_SN9C20X is not set
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
# CONFIG_USB_GSPCA_SPCA501 is not set
# CONFIG_USB_GSPCA_SPCA505 is not set
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
# CONFIG_USB_GSPCA_SPCA561 is not set
# CONFIG_USB_GSPCA_SPCA1528 is not set
# CONFIG_USB_GSPCA_SQ905 is not set
# CONFIG_USB_GSPCA_SQ905C is not set
# CONFIG_USB_GSPCA_SQ930X is not set
# CONFIG_USB_GSPCA_STK014 is not set
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
# CONFIG_USB_GSPCA_T613 is not set
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
# CONFIG_USB_GSPCA_TV8532 is not set
# CONFIG_USB_GSPCA_VC032X is not set
# CONFIG_USB_GSPCA_VICAM is not set
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
# CONFIG_USB_PWC is not set
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_USB_S2255 is not set
CONFIG_VIDEO_USBTV=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
# CONFIG_VIDEO_EM28XX_ALSA is not set

#
# USB HDMI CEC adapters
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
CONFIG_SOC_CAMERA=m
CONFIG_SOC_CAMERA_PLATFORM=m
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=m

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
# CONFIG_I2C_SI470X is not set
CONFIG_RADIO_SI4713=m
CONFIG_USB_SI4713=m
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=m
CONFIG_RADIO_SI476X=m
CONFIG_USB_MR800=m
CONFIG_USB_DSBR=m
# CONFIG_RADIO_MAXIRADIO is not set
CONFIG_RADIO_SHARK=m
# CONFIG_RADIO_SHARK2 is not set
CONFIG_USB_KEENE=m
CONFIG_USB_RAREMONO=m
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_V4L_RADIO_ISA_DRIVERS=y
CONFIG_RADIO_ISA=m
# CONFIG_RADIO_CADET is not set
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_SF16FMI=m
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_ZOLTRIX=m
CONFIG_VIDEO_TVEEPROM=m
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=m
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV772X=m
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_RJ54N1=m

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=m
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m

#
# Sensors used on soc_camera driver
#

#
# soc_camera sensor drivers
#
# CONFIG_SOC_CAMERA_MT9M001 is not set
CONFIG_SOC_CAMERA_MT9M111=m
# CONFIG_SOC_CAMERA_MT9T112 is not set
CONFIG_SOC_CAMERA_MT9V022=m
CONFIG_SOC_CAMERA_OV5642=m
CONFIG_SOC_CAMERA_OV772X=m
CONFIG_SOC_CAMERA_OV9640=m
# CONFIG_SOC_CAMERA_OV9740 is not set
CONFIG_SOC_CAMERA_RJ54N1=m
CONFIG_SOC_CAMERA_TW9910=m

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
# CONFIG_MEDIA_TUNER_MT2063 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_QT1010=m
# CONFIG_MEDIA_TUNER_XC2028 is not set
CONFIG_MEDIA_TUNER_XC5000=m
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_MXL5005S=m
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=m
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
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
CONFIG_FB_N411=m
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=m
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
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
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL4_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_OPL4_LIB_SEQ=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
CONFIG_SND_ALOOP=m
# CONFIG_SND_VIRMIDI is not set
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_WSS_LIB=m
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB8_DSP=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=m
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT1605 is not set
CONFIG_SND_AZT2316=m
# CONFIG_SND_AZT2320 is not set
CONFIG_SND_CMI8328=m
CONFIG_SND_CMI8330=m
CONFIG_SND_CS4231=m
CONFIG_SND_CS4236=m
CONFIG_SND_ES1688=m
CONFIG_SND_ES18XX=m
# CONFIG_SND_SC6000 is not set
# CONFIG_SND_GUSCLASSIC is not set
CONFIG_SND_GUSEXTREME=m
CONFIG_SND_GUSMAX=m
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
CONFIG_SND_JAZZ16=m
CONFIG_SND_OPL3SA2=m
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
CONFIG_SND_OPTI93X=m
CONFIG_SND_MIRO=m
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SB16_CSP is not set
CONFIG_SND_SSCAPE=m
CONFIG_SND_WAVEFRONT=m
CONFIG_SND_MSND_PINNACLE=m
CONFIG_SND_MSND_CLASSIC=m
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XTFPGA_I2S=m
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=m
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU7002=m
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_BD28623=m
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8328_I2C is not set
CONFIG_SND_SOC_GTM601=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_I2C=m
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS5086=m
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC31XX=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=m
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_X86 is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
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
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

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
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
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

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y
# CONFIG_USB_DWC3_GADGET is not set
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=m
CONFIG_USB_RIO500=m
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
CONFIG_USB_BDC_PCI=m
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
CONFIG_USB_CONFIGFS_F_UAC2=y
# CONFIG_USB_CONFIGFS_F_MIDI is not set
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_TYPEC=m
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_ACPI is not set
CONFIG_TYPEC_TPS6598X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_UWB is not set
CONFIG_MMC=m
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

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
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_APU=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3642=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=m
# CONFIG_LEDS_WRAP is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=m
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS80031=y
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV8803=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=m
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_WM8350 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD=m
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=m
# CONFIG_COMEDI_USBDUXFAST is not set
# CONFIG_COMEDI_USBDUXSIGMA is not set
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
CONFIG_I2C_BCM2048=m
CONFIG_SOC_CAMERA_IMX074=m
CONFIG_SOC_CAMERA_MT9T031=m
# CONFIG_VIDEO_ZORAN is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
# CONFIG_ION_SYSTEM_HEAP is not set
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=m
CONFIG_MOST_VIDEO=m
CONFIG_MOST_I2C=m
# CONFIG_MOST_USB is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
CONFIG_XIL_AXIS_FIFO=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_MLX_PLATFORM=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_DEBUGFS=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
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
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
CONFIG_DAX=y
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=m
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
# CONFIG_INTEL_TH is not set
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_FPGA_DFL is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m

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
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
# CONFIG_OVERLAY_FS is not set

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
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
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
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
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
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128L=m
CONFIG_CRYPTO_AEGIS256=y
# CONFIG_CRYPTO_MORUS640 is not set
CONFIG_CRYPTO_MORUS1280=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
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
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
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
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
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
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
# CONFIG_LIBCRC32C is not set
CONFIG_CRC8=y
CONFIG_XXHASH=m
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_ARCH_HAS_SG_CHAIN=y
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
CONFIG_DYNAMIC_DEBUG=y

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
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_SHIRQ is not set

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
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=m
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
# CONFIG_LATENCYTOP is not set
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
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_STACK_TRACER is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=m
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
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
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set

--=_5bbe533d.+KUlNCdvOGziuldx048ZP7LO4Nljlei8gKw7I7QGOW9xyw+b--
