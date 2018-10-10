Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A419214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 02:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A419214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJJJ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 05:27:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:6952 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeJJJ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 05:27:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 19:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,362,1534834800"; 
   d="gz'50?scan'50,208,50";a="96132475"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2018 19:06:19 -0700
Date:   Wed, 10 Oct 2018 10:06:41 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] 4ce5f9c9e7 [ 1.323881] WARNING: CPU: 0 PID: 1 at
 mm/slab_common.c:1031 kmalloc_slab
Message-ID: <20181010020641.GE13396@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

commit 4ce5f9c9e7546915c559ffae594e6d73f918db00
Author:     Eric W. Biederman <ebiederm@xmission.com>
AuthorDate: Tue Sep 25 12:59:31 2018 +0200
Commit:     Eric W. Biederman <ebiederm@xmission.com>
CommitDate: Wed Oct 3 16:50:39 2018 +0200

    signal: Use a smaller struct siginfo in the kernel
    
    We reserve 128 bytes for struct siginfo but only use about 48 bytes on
    64bit and 32 bytes on 32bit.  Someday we might use more but it is unlikely
    to be anytime soon.
    
    Userspace seems content with just enough bytes of siginfo to implement
    sigqueue.  Or in the case of checkpoint/restart reinjecting signals
    the kernel has sent.
    
    Reducing the stack footprint and the work to copy siginfo around from
    2 cachelines to 1 cachelines seems worth doing even if I don't have
    benchmarks to show a performance difference.
    
    Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

ae7795bc61  signal: Distinguish between kernel_siginfo and siginfo
4ce5f9c9e7  signal: Use a smaller struct siginfo in the kernel
570b7bdeaf  Add linux-next specific files for 20181009
+-------------------------------------------+------------+------------+---------------+
|                                           | ae7795bc61 | 4ce5f9c9e7 | next-20181009 |
+-------------------------------------------+------------+------------+---------------+
| boot_successes                            | 0          | 0          | 28            |
| boot_failures                             | 1144       | 280        | 8             |
| WARNING:at_mm/slab_common.c:#kmalloc_slab | 1144       | 280        |               |
| RIP:kmalloc_slab                          | 1144       | 280        |               |
| Mem-Info                                  | 1144       | 280        | 8             |
| BUG:unable_to_handle_kernel               | 0          | 5          | 7             |
| Oops:#[##]                                | 0          | 7          | 8             |
| RIP:copy_siginfo_from_user                | 0          | 7          |               |
| Kernel_panic-not_syncing:Fatal_exception  | 0          | 7          | 8             |
| RIP:post_copy_siginfo_from_user           | 0          | 0          | 8             |
+-------------------------------------------+------------+------------+---------------+

[    1.320405] test_overflow: ok: (s8)(0 << 7) == 0
[    1.321071] test_overflow: ok: (s16)(0 << 15) == 0
[    1.321756] test_overflow: ok: (int)(0 << 31) == 0
[    1.322442] test_overflow: ok: (s32)(0 << 31) == 0
[    1.323121] test_overflow: ok: (s64)(0 << 63) == 0
[    1.323881] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:1031 kmalloc_slab+0x17/0x70
[    1.324113] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-rc1-00077-g4ce5f9c #1
[    1.324113] RIP: 0010:kmalloc_slab+0x17/0x70
[    1.324113] Code: 00 00 00 83 3d 11 78 14 03 02 55 48 89 e5 5d 0f 97 c0 c3 55 48 81 ff 00 00 40 00 48 89 e5 76 0e 31 c0 81 e6 00 02 00 00 75 4b <0f> 0b eb 47 48 81 ff c0 00 00 00 77 19 48 85 ff b8 10 00 00 00 74
[    1.324113] RSP: 0000:ffff88000fc7fd50 EFLAGS: 00010246
[    1.324113] RAX: 0000000000000000 RBX: 00000000006000c0 RCX: ffff88001fb68d47
[    1.324113] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffffffffffff
[    1.324113] RBP: ffff88000fc7fd50 R08: 00000000b128ac78 R09: 0000000000000001
[    1.324113] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88001d814800
[    1.324113] R13: 0000000000000000 R14: ffffffff836e16f4 R15: 0000000000000001
[    1.324113] FS:  0000000000000000(0000) GS:ffff88001f000000(0000) knlGS:0000000000000000
[    1.324113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.324113] CR2: 0000000000000000 CR3: 0000000003012001 CR4: 00000000001606b0
[    1.324113] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.324113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.324113] Call Trace:
[    1.324113]  __kmalloc+0x10/0x130
[    1.324113]  ? test_overflow_calculation+0x152b/0x152b
[    1.324113]  test_module_init+0x1262/0x1dfa
[    1.324113]  ? vprintk_emit+0x29e/0x2b0
[    1.324113]  ? _kstrtoull+0x2c/0x70
[    1.324113]  ? kstrtoll+0x4b/0x70
[    1.324113]  ? kstrtos8+0x15/0x40
[    1.324113]  ? test_overflow_calculation+0x152b/0x152b
[    1.324113]  ? do_early_param+0x92/0x92
[    1.324113]  do_one_initcall+0x65/0x130
[    1.324113]  ? do_early_param+0x92/0x92
[    1.324113]  kernel_init_freeable+0x1b5/0x250
[    1.324113]  ? rest_init+0xf0/0xf0
[    1.324113]  kernel_init+0x9/0xf0
[    1.324113]  ret_from_fork+0x35/0x40
[    1.324113] _warn_unseeded_randomness: 1 callbacks suppressed
[    1.324113] random: get_random_bytes called from print_oops_end_marker+0x21/0x50 with crng_init=0
[    1.324113] ---[ end trace 8ef06e4cef93b260 ]---
[    1.351969] test_overflow: kmalloc detected saturation

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0 0238df646e6224016a45505d2c111a24669ebe21 --
git bisect good 073ceed8e5a6c9835a915549d248569067e11268  # 04:27  G    213     0  213 289  Merge remote-tracking branch 'opp/opp/linux-next'
git bisect good fc708c9582d94983c6c908271390c9720ca3ec4c  # 04:42  G    216     0  216 293  Merge remote-tracking branch 'mailbox/mailbox-for-next'
git bisect good 8c55f3646e42de506c5832d4ac8bf116ff3cb246  # 04:59  G    211     0  211 288  Merge remote-tracking branch 'char-misc/char-misc-next'
git bisect  bad 616b28683e7f382c5dc8fa8ab7837fbd64ed261f  # 04:59  B      0     7   93  72  Merge remote-tracking branch 'userns/for-next'
git bisect good 756752870e5af5586fecb5973a50db7f6ab96f91  # 05:23  G    212     0  212 289  Merge remote-tracking branch 'cgroup/for-next'
git bisect good 50473600212c8bbd945d24a5f1fcb60e3e70c607  # 05:54  G    213     0  213 288  Merge remote-tracking branch 'rpmsg/for-next'
git bisect good d112058d6e522116e9ba88c6962c7ce02d2c3d8f  # 06:17  G    209     0  209 286  Merge remote-tracking branch 'gpio/for-next'
git bisect good 5ebcede43c9e797b6b3cb412f83fcbff65818ba9  # 06:33  G    215     0  215 294  Merge remote-tracking branch 'pinctrl/for-next'
git bisect good cd60ab7abb3df301c4ff2cf7d619cf7e30cca289  # 06:46  G    210     0  210 289  signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
git bisect good c852680959d0964198e829da80f012b3df43060c  # 06:57  G    208     0  208 285  signal/arm64: Use send_sig_fault where appropriate
git bisect good 5ee527d7cefddebd72970d290e5cc06c9ae32890  # 07:20  G    209     0  209 286  signal/unicore32: Use send_sig_fault where appropriate
git bisect good f28380185193610c716a90ec9b9e696638a495ce  # 07:39  G    208     0  208 283  signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 07:54  G    216     0  216 291  signal: Distinguish between kernel_siginfo and siginfo
git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 07:54  B      0     5   89  70  signal: In sigqueueinfo prefer sig not si_signo
git bisect  bad 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 07:54  B      0     5  294 275  signal: Use a smaller struct siginfo in the kernel
# first bad commit: [4ce5f9c9e7546915c559ffae594e6d73f918db00] signal: Use a smaller struct siginfo in the kernel
git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 08:59  G    853     0  853 1144  signal: Distinguish between kernel_siginfo and siginfo
# extra tests with debug options
git bisect  bad 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 09:21  B    156     1  156 158  signal: Use a smaller struct siginfo in the kernel
# extra tests on HEAD of linux-next/master
git bisect  bad 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0  # 09:26  B     21     7    0   1  Add linux-next specific files for 20181009
# extra tests on tree/branch linux-next/master
git bisect  bad 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0  # 09:27  B     21     7    0   1  Add linux-next specific files for 20181009

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--5xSkJheCpeK0RUEJ
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-lkp-hsw01-15:20181010034251:x86_64-randconfig-ws0-10092027:4.19.0-rc1-00077-g4ce5f9c:1.gz"
Content-Transfer-Encoding: base64

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

--5xSkJheCpeK0RUEJ
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-vm-ivb41-2G-8:20181010032441:x86_64-randconfig-ws0-10092027:4.19.0-rc1-00076-gae7795b:1.gz"
Content-Transfer-Encoding: base64

H4sICG5VvVsAA2RtZXNnLXZtLWl2YjQxLTJHLTg6MjAxODEwMTAwMzI0NDE6eDg2XzY0LXJh
bmRjb25maWctd3MwLTEwMDkyMDI3OjQuMTkuMC1yYzEtMDAwNzYtZ2FlNzc5NWI6MQDsW+tv
2zqy/7z3r+BFPzS5iG2SehvwYvNwGyOP5sRpT3eLwpAlytGJLGn1cONi//g7Q1k2Jdtxcno/
XRwDiS2a8+NwODOcGdLCzaIl8ZI4TyJBwpjkoihTaPDFf30j8KJdKl/fyXUYl89kIbI8TGKi
d5nTpZ3MYx341jI7M1dYlmNMydHTtAwj/x/RU9r5kc87IuXH5GjmeWtaq6t1KTm6ENPQXT11
2PExecfI+OaO3N0Phzd3D+R34ZNPXkEYJZT3da1vMHI+fiCcMrvN3Hkyn7uxT6IwFn0SpoM+
vBbzTriY6qzDP3bsft9/9FKSJUkx6Pli0cvcOSVlLrIBcEr+SKaDHnzowYe8l3uPwi8j4fca
GL0pUHdYx5ecd55tc2LqHeSnQ/UO1bre7GdnJQfPZLblMkN4BvMCbtju1BWmYbomNwLHsamk
Y5TRjq7Zht1h7nwRL2iHdpfuPCKn9+eXg2oE8gQLFISz1WMng5lWLSBgEB2lDqfcIlP4wnsc
RLhQnVg8F725mxcig+Wcz8Ni8FrOyNmnTw+T0c3px+Gglz7NehKx9/LoPVjhjtV77RggWET9
2dmvSHP3eVKmRTgXA5NScj8cf75+mNwDb4NeJvIyKuR69Ji6SL2X1ub/eAqUXF/dTcbD+y/D
+0EYxwTGLmfETUNvUH3Ml3n274kb/XCX+UTE7hRUimRemfpuIbrwYeKl5SQv3Cia4ESTshgA
NyQWRTcMYncu8gElaRbGxVMXlPZpns8GYEGpG8MYHUbyJCiixHsq00nVxkg8Dyc/3MJ79JPZ
QDaSJEnz1ccocf0JqL4f5k8DDtDJPC3WDZT42dTvzsM4ySZeUsbFwMZJFGLud6NkNonEQkQD
kWUknEEfMYFG2Vb7kEFRLCkR6FYqtrFhTE8YMzhMTOm1aVzM3AGAzd2IZD+keEQWdPPHsvCT
H/GAto39anh/O7wmeZmmSVaAREGIeb/di5BzERdumdXvl24Z5VuO4+5zHxxT7MOEQ5+8/yji
EnzIKC5E9J6U8VMMLJyAnwjjGZmJWGQgxDAOi+5OpH8mMF4lMNDfJZkKwID1hYXfIgBl7AVp
2SfjaiI4wtfx6ZchCYRblJkg9JlS1ifvn22LBLByskuagFhJJmYh2nb+/s/BcoAdj4e/jKMD
zumXr6/BeQY5FGKSBAFsMt/49z4hhmWe1O15+FPkVTM3zL0ow5UVVVQ1LzkwY52gehXg9whi
kTAntsbJdFmIvF7B90AV+27mvycBatz2Mp6NPo07YBaL0IdR0sdlHnqgmPenN7Cg6ZaWye7C
5rRPvs1h0VEmzVen0eQE0yD4DtzgLN4E5gTeNliAYDB9kS2E/ya4YJu34M/DsfZUrSDwteDP
TBUp9S2wP81bIAIUnAqHTX8arkJrwB3kTm4G/cplohaunSYYAtrVlhLefiVHw2fhlaDhF6EU
4DH66kJ4BURQfeLC+2JLqJdL8JyLME8yGBL7Cr9Prr7ctPs9wYbp4bbRJ5+lWczzLCf61DB1
nzKCgdTqoel7WYMUvC6hJ0hLNJuDI2cnuFXN3Wwpv5PdXqCvLFKGWqRyCvBGdEMzDNOAKMRb
epFoOmzze4Wag5v1INBT0CDUgf/0OWi9ZBhRQeHXzPN1LnQ/CKYn8qvQj8Qkhu9smxkONRym
2xqJG+My5zspcq9PLlZSJdx0tK5BbXJz+RMXxhM5SH1Dw0wH5FxpULXbtxWpViDFRshg8Pcd
OsQsqtdYmZgnCxXL3WCtlLBtb8xiQB5BJDhJg5gM0FOiicnZu5n3uG7Wa95UYs4r53t3+tCH
MBuDpjJzUQvJN9qxwF3/fkbI7w+EfD7vwB/Zem6gwQqOPYj6wfvKYB9Sjj2CAe/xXSU1XiRV
vGPlFVVSXIv9pEFbhBtSm+HSBxAI+ZLu5q4j93LiFiqA6Wo1AHyENYCdIgUtwV5HE3ilRbZw
I/x03EDnOsYp8xRUCyh12gnMqeWpPTQbvJGbCwKjJWBYBYRqaYJpzm504jjARrUBch32VxXM
QrD7K1i4Z6p7Hk78hKw+S925+/hwenY9VGlsrtL4dEPj0700RoOGKTRsDw3XtAYNV2j4Xhqz
QaMpNNo+GrMhA7nT1DT6ThqmMwfmAwHAxWh8td4QrOnUYJXigDl5TcVhOvjD7+T0/G4EEYvM
sSu9AWcH3qucYy4cBhBZSEPyKxfvq/QWr+nvxxd3zb37gwkqTaRn0snRgmLGdn45JscNAEcB
eFA32A8fhswc6hJAowjAVgDk7OvdedW9ejHZsn5qDGDb9QAf4K09gMFtSWbpWwNU3Q8P4Jj1
ABfbM4DQE0XA9KG9NcDF62agMabMYLw1AK1krNMGjVXTnN6NzrfEyqqhnG2xVt0PM8W1eoDL
u+H2up1WZNr2rKvuhwfQ1gNcJxjaSsZc34edB8PoQAhJ1CBx1j5N9i4SstlhDRkRkSOyetUA
m0E5Nw0Q278S8FqQe8+Ekq3Bd6aBXvDi5rSi3xFHrwxt0xC0PDWiOCsUiPl3oFQR6s4QVUWx
NES5rbJRQgRkx8vG9zCPm2QhjfknzgcSiqyQG4twvUcSq5Uz7A9cVQ5g5cCxw0oIaj90s6T6
Epp2JhNbQqCOaLNv6wdg9gfqKox0eKtAhEzLApJYd+GGEU67T8A0Seq2JuCANxhBXowDVkVE
yQV9xUx2sWBREMinuAYpksKN5Jh9YnCd6Wajr1krEC4J9DAr/rC858u1AR5Afxs0dpOGsxXN
VgAGnRltdtYcx666n5Dr0YdPZIoFlz5VaGxON/pYUVmM8YOM2Vxr0xkcbHDXeKa2IdQtbe0u
7246D+FcZGT0idxB6o6Br0lttbNO3+YEkGTt76+x9+T2ZkSOXC8NIYb+hoE3JDpBJP8gPimg
iX0/VgFssIXRJ6T9RiFuxDoZ1lxg/60rwwxyeJUJmWrB9x/HI0I7vDFdZ+3GRrcPk/H9+eTT
l3tyNC2BFHQ2n4TZv+HTLEqmEBzhA6/5a3DlWKi4IKMCsidkBsIrfCuycIbvEhDeR/e/yXcp
qdEFWX+8Ba/LFUSb0ldwZqicGeQxnD0SmRQeN6D4DubYijmtxZyxhzmjgWi8gjlHZc7Zy5z9
BuacPcw5KuJmQ36BOdZYVHjawx7T3sCeu4c9t4FovoY91mCP7WXPeQN70z3sTVVEvpHe/W+0
8jHTJYGEMctCXylAYl/9DVrP9ozOGohvsSNtD6Jq4bZG34Co70HUG4hckZDxsoQ04w2jm3tG
NxuIb5GQtQfRUhH1t0jI3oNoNxBVCTkvS0jXlb7sgMLpltqZHei8yzb2zcvbMy9PRTR2OdJ9
iP4eRL+B+Bb9EHsQRQPxLfoR7EEMVEQTPEJV4UPRk6Ob04uH43UVxGtUc8K4qojD5waE3khH
Qh+DCXD9pgtRCcQhuZBVN+G34wXbAuXM5yme0UGyFEXJD2REx4MSCGPAbSdFGpUz+dyg09fJ
RhUttNONqUw36uhAdaoOBZ+/Cjhtuo74seA7lcn9OoqVQrg7HxFfLEJPDWUBBMsXwLU8bXEz
dxFmRelG4U/g6ElksYgIyEutqyKR06pNZiIIY+F3/giDIMS4tV2hbFUm6+ZWWZI5jDqm4+hU
c7AUoZYmYVj0ADLcnqQi8/CA5PZ+AhId92GD4STO8IQRR55MwyLv66sWwF89YIAtnxRnblno
KGvA4XwqfDwMAbusgtAelnf/0a49kZw5BjMhLc8o8TUKewwpOXUsZvAGNoQNKSB0XNAJr/8S
GZFdBux/dsCgp1JhIKbEbAP+M/mfy/8aUWlQtWDdVgmKmy9jj9x9kLogq9lqX3tVKM8L4UZ4
ONuoeFu2YNTQmxRYjirDqAAOMHKPwrwATZ8n0zAKiyWZZUmZolIlcZeQB0xpSJ3TMMi5LBUM
a5ZXlbJ5f11u+Otyw1+XG/6fXW7YGLvNOOw4Upz96o1UUiUrqSqxEWxO4BguRFzgKZsLpkwe
3fxxVV7GZrnXcJMzXSdHSeaLrE8g+ao9qjwOV/ZMh3MZbME20NmPxzRGLb7Gg1CSUQxYzDae
Do4c3OCNLHbh7uVolnnVg9FNw9avlA34iHNDM6/qHRWvnJ0Q3dHYFQgKVAgyMsvQgSRLqicN
DOhK3r2A2TCOX01z8K/McmDUq3XhBmKLK+LN3U7doHLn6EbtV3uf4WvpgKvZ5iSE5XOrA9aV
5DeUNrNgXrB+fXKXCawLhjiLx1BkeIhWXRI4/0zCeRqJOd44QaCuCoA7igT4G3YE7kC4nowy
MAQiAahrvXsP5O4Ncc9mux7oTTCugoE6JhnuMeA0coTsb5oYmG7kLokB2jjPmyC6ClKZNbhW
EeN2/9tYrv+yJ57V6y5IBoGqpABWiTRw8sPNYhg2JytLxy0W+UeDP9rpC46bkKCEf3uAOCWX
UtxSfMyX6xmf+n+UcpJkJpK5QEvAHRxHCdwYoMGS3WDAIClTxadgcYxvQNQQSY/7RNcMLrtC
wg66bnE8xxYyrHDxsLdqZutcjpmcY/5cX5v8Jg3+e1tnoJtpgs5cgwsD2aYo1dhbEoiXQtDo
JMPz1HQJwf1jQY68YzBRapJ7GPDSBRUfxV4X/88ScpNEsZttcDUTCyXdbpfcnH6dXH86v7oY
gq/+fHZ+fToeD2FKxN701hme4aq9J9D94bJP1i9d7W6iibTBr4b/HK8JYC3YhsBgtlYRyOEv
T8eXk/HoX0MVH8xfIZDhZXuE4e3D/Wi4GkTjlqnwZHI8umxTnF+ejm5rrkwDvIlCIfN3yRT2
2sVUawxLQwWry/R1ehq1Fg+zJFAR22Lk6WxDbFNM3jBkBl+SP0HQmJVeUYMFsJPLDQMds21X
PlMhduz1Wd057DvgGhahrIfiDk8hjtr0dWw8vmkkGo+pKH4hu2DcpLpuWkpiwSzw7qDQiFyN
BbugculM0XELtfy7zD/7ZPwjhK0ZzT5fztEwYU8e9T5BBOyLKube0HFN3mpYhQ3D5wKzV5gy
uJR3m/lammHBOg5vT8+uR7cfISHsVKnu/W8Kt7q8WoI7A3SY7Oqg47GdDF4gR4AYHP7HSYEW
HMsLHUpXB/cvpUw9BhlA4C79TbXtHkFURTp/B6mKAN8xH2dgpL7oU3Iqb+bAhwvw7/3NyRuz
DIfbh5F5hazRGpkeRjYdzTmMrLV51g4jWzLBPISst5H1w8i2gwncIWSjjWxUyOwFZMeRhZQD
yGYb2TzIs00d4xVyttrI1mFk5piv0Dq7jWwfRuavQnbayM5BOduaY79CzoxumQo9jG1Q9hor
3DZDdhgb3N0rNI/xLWx+WNoWdV7D95YpssO2aNtM01+BvWWM7LA12g4zXmHnbMscmXEQ26HM
ajlfZu7xvuB7sUTT6Gvt68s4Fuoafe29fS2sDDb6Ovv6cs7sZl++b7dwuMV4qy/b11fjvMUD
53v7Wls8aPv6QvhqYqjzMLoZ3uNldg9iy4HcQpCeDSQAg4QYHzlm1vCM7xsMg5l0dcfxxs2e
cNUfxufru+vELwVu69CWY+My9h6zJMaKqIJhO+AdzyG6nWbVVfUq74ggQydH+VOIJV28xiow
N4AouBQQnhmabXXxvkoyS25Gd2NyFKV/DPB+pUFtRYtMB+OFNPQnEMD0ATpwywjiHgwtCeT0
4byc9yFHVCZlS0O/wUz/hdRWAtSJrXZShYWttBawZIFXYskL+L8ICKE+x4PnazcvqrNBEj5c
nykgV2dYauQ38k3HN4XWwXNhhdY/RAtZ8scGBJgaDD9OQVkg4PzCCSx8WISzVfr7oYScrv65
QyaK6srhhpwbGCw3yOuHBSe9+uF+fAZro8CGUYSKge0Q662v68u4UUGX80OMEvPxhSDjAuPi
s2Xq5jDBL2UEnKnXXDnVDLwQsLppXcZ4gIAjyaBwdSJQx8C2BuH66mRAaWrcKALfomGOh1bg
C9eXNy4LeamileZBT3movj7qgAiW9on6QxJS/f8qYM5DDbaW52cU09FosSRnWejPxDE5Ctx5
GC3lVY0TGTFH+FlzTyDDFnIy+OxsVIiBmwCjvROZPLiJPUGGGKaDgOKE3N1AQp+B7LITWUiD
BB10VH4Poo+W3Q2OBt5/lVpfquWM8Qv1DM50A0+wJRVm3nnq/ogns3TyVDxC8uwfHffJdQiL
j7+iyMIE3QevahxrE+Wcyrs7eJOkrur15YQaTZhWwfyAh2i5dVcSnKqD2TCIv4/CjGe47GUK
+Qaol4+X0WV1BVLBNYmmy/Di2Tb764OerQOxvtLdMKt8u7u6WvUODApRV9nku43T0TUd463W
NXmmXJPX4WHD29ZF+RoB87mtxGgjOd3ScOd54TBjq++Ow4wVXxbs0ephBgeNxtsT5B0/MDGu
TMz+hYmtx+EW1dGQX5jYVt8dE+P1xHhzYjaXPyIg77QDE9OUiXm/MLH1ONzRDTTXFya21XfH
xLR6YnpzYpDz6BsrSEqsKcEYTCrsyerUVentYBlh7bJu3Gf8UYq0+tT1nqpDKX3T39RtQO+0
Xsr3tg4S+I80W9jnirwEw+8r38tD1TZ9E8PSuLzHh79xKAQZYTmEJE+E/EfpYznymifWZYDX
3X0c1PaXx7I1A+b/MUn8EzxjhFYu+fbcXOQEdxnh/7cKatuY7OwC3TeC09gUqtM+/H3L5uci
efUzHlljPOLM0O0uNdeB0NrRa7Dfo7taXYXEHS2EICvHSrcOqqLVtx0xqp3nGzIIDYHndOZj
NBYWlBxp5nFV2ZqBi8b5YvW2KnAVj32CJxarSAUCi6DYQGk6Hm76YlHM0wBUo2ZCCQA1CjFB
+wc6v374vSpPcQt3bKVGpVFTVhCCEkKI3WcWmyisw/AARG9HYRr+BAN/XIi1WLcsErz+AHoV
LVc/TpqiiOo7+3NsCcr/Ze1am9vWkezn+RfY2Q/r3Bs5eIPU3MysYye5rrUdr5XcSVXqlkoP
ytFalhzRymN+/XYDJAE+QCnrTaUSW8I5ABpgoxvoBtc2BQvwk6/fnfonAV+KQXEPeAa3AXM0
z3AXEdNHUHPk2WphZ1kxwSoYoxq1UgXDTfOqcN4ubRc8sAjAxMKDk21WG5Dqm3w3dcdbHupC
Wa9evx+Sm2ozz2aWbWabFXE2SLDVLTAgHQf1YYeDUiZt3WLUzhrU1moyBwH70poKaFrZj9sM
T9/w57GbVChbDHxFK+Budv8wnm02dzBYY2z+r/Q7Uy/A5EkI2IOfyWy7vrVf+AxgqCBl1V4p
xsPYUBmM42jvTQpmEg1POXxb5rnVI14slln1i3Es8DTic1nBQb2iw/b77jZD89pXQPgxDNDl
8pU7PMJcG3tiMPBHBrQeIC2Uc7Bm2x8Pj/Ohm/wPu/GXVbYOTkp8Pw23/dxOlnOwUWD4+XcG
34BFfvSMYAQ0J5evXnh+cL1w4jXLw8TG8kKrenkJDw/OuLA8r/gZBdO3Xh6MrK7yBb/h2tTL
gw/ULC89P0+a/MpY965ZvuBPNO4z1MonEiO6ivJuUk5Wt3jg9fm+xMdrS8LarF3naqoqek62
99+alr5UqZJpo9YcKhMgjC0YCPBQ/PDNqGAarM0qcvTEhtKM343Ojy43GIZBzmwE0rOguE67
il+X60YHIvVhvQECr9kYj06v0SbJ1niikAcgJn0IdWc1J7ewTNziSVW7RtZdo70kZHCWrVaD
P5bzbBMguNQmirjI1puvm8HVH4Pfzy7PBye7+TLESqGqmGrmYtlOLi/KY9t8Zx/cxQ4V92T2
ZbfEh9RGzGwm82D8tIGhr8IQwSfbwlP72HbpoGDKKtkcFRcN5GREyUgFzQIrouqSUzBFwBqq
lCXyb3cP1T5agEvxzD3QS583sChMrScIug8U5rfiOBi5/0aWC7LOsIuwimAme0b++jBbvlxv
Ztv8r7aj2wxbSCagE309hjJVTaQyb56Tt9evra0wtWdbFJMrCH3jUYbSSsWiZr0BA6ZwU8kn
+ABG4ghU+gRPUXBN/uTiEgfgPT8LWGwYPKYHkOura3pCxZCCWwxjfjok70akEuqnUXaL/mX+
ZwC22q8TDGvUEvtxdPJ6fPXu/fjNuw9XZ8/+VviFNtRxdH3pqRKDgZotKmTBjsP6RS4vT99d
vTl/G4ZAPoe1av0fj8Wa4A/FUSD1VQQc3xne8jDHs7/Py7wYx+OgCSkaz4gMxxkqd4KD5njN
Lw3Yyri6z5bj4Ouhje2ygG3mjCvyCZzqIrEGk2lmC1PMnUCQqd3m+QmyebUt0iJLqMGn8BCy
rvTkaYTULhSHk9bCOqeLblI89jiM1M/dAJ2i2QDoCknpMSZTYdjrkHGM43YhuhSs3YnNVQEL
Lli/ZSJszlyNg3kOeMRoJwcLOTCWpsXBPAfr4mB4ZFxxpDLBZNw2Byh2KG0vOHAjP2MzlCn8
F4giNQnrbMIK1oXZD3J+9pqgur0rCZknpGxhR54tTEhYDvehhNITioUOmBKbmv4TTEnQNOOa
ZsKmOY/tJwhnQdOMbxo6Khg13WAS1cAxXFvag58EE0hRJnR7AgFH0YSyYu0eL41Z50C1vHdh
C9fn5x+l1eEBo/Ui9zIax2hoF+Po8pUnFDahvEbI7RyHR0QOGUMvpdVNQWvdVHahbXME06nY
vJ37535e+JCwei8Csad2HzPKlXguUByBDqHhxq/Cw7DObjkaQUOazNNkHU3i0F3T4BKBKqE0
6xARr4mI87Sboy2ibDrz7ZnX9rMVl+0nL6Txz1lxW8oMnjcPh9nYetxETCqJb8W0QyoiEaqp
VaSbOJOFRKl0TRxWkwo6GE2pyIZUyu5I1x0TNEGKfriszRXm5wqrCVUVrniEhodSCZYte7nF
gmg5XT42ZKOk3eGqMaqflI3S7c6piGwSJ5tp2IS0H16XDfey4TXZaLBjmqOsorKRXjYmJhtD
bVB+jVH/pGxMx9OkI7JxCyINO2WU2+CJweuyEV42tfxmBeZJSzY6KpvEy2Yak02iba5ojdH8
pGySpC0b0y0b5lQEC1VEyvrhddlILxtZkw2swy3ZmKhsZl42i4hsNOU29bjGmPycbDSV7c4l
Edk4fcNM2ATTD6/LRnnZqFA26LK3ZJPEZMO8vmExfYNpAElzWUh/UjactpeWNCIbp29YoG80
79DFaVQ22stG12QjqD2ij9E0ZOP1DYvpGy2kvXSoxjjxqzdXk2mHbJLQjtNCtWUzia3eC+M7
Bz8GTZGSJ12OHPifVx8uT4qzAV9cKSFDH/682oy4WK7vyKeLq/86ATceoySJIr8wSpgP2dFS
s/oWQAf8VR889ftdEfiphwP6lxocHM19tZ/1wYOcxQh8VMJ/SQMguBSd9uPX28lkOx2Wt7WR
SY5h9o/kj7cnRfpgyJF2Go8lh8fg1gPezzbPMPUhf7nc/AoT4fnm27r62Z6kvFxv1mEFbYuj
VkGxu4ChFdvNijxs8nwZBEpoRTWat2Xx+g6ZVnjZy59kdDo698cHXac9UNIeIa6W08njpLrA
QeDOuOM89kW5lLq1af9hFO6pB4Ut7y6fuoONYNt9nX1zu2oL3HFxwQ1YcJF7tNB45nUw+vNu
GmCt3x/DFqPmq/VAaVCBgaO0nAyLe5LtL74+GB967OO4AWJ3uPCSSRj8ryXK/k5mkwd7v2aI
xiMHj1YaH++Hh3zsmmrR19cjjMPGsTgmrFO2ygVRVbhRGRhiMepYHGsyCLISwLhTA/jHkJvN
fLNabMjbJWZcPC7Jb7fFT/9pE+iOl49/9/UYe6x2Mv+KUSnzonMje43aCUaX4C162MMzJ8xz
P7+CWWMSTE8Jdkntvi9urWLkYWNTVSu3wtriqCZtfNYYw3bszaLlKYuW9eh7reChT/31ejZj
yN72Od0tFtC2A66Y03ieoPdzBDdbVjdaVhya2kj32umpi6cHAULDgy98rEKAdnpn/QA6b33t
RIWPrS/B7H1aUIIUa8c1Jl/j5vE1RulZhJvjz8n5WW53S6eYvePumvR6UnOb8FEysYOYBBUd
TMJtlBRM/CCmBetkSjHCv2TCvZb5/YTwQL6g2FitxAF1mc7+K465JSWTPIhJdjJpFrZJHcSk
KOtgMjRk0k9ggkksGzNpWFyBaJrZ8pg0g3KvzVp7JdDDffPMv/PEv3Hez2micF+Ty+CkXxtF
i4W5sZ1b7uLKA/bCgcXeSBBnUQdsgmsDU623Lfondr+1wXSTPjbzE9ve2iQKo5z3ne5zD0gl
2gKPs4cx5qpn6zEeyeAFTGMbUNEZVYGDU8ZVyOckpXirVT2uAtOh0G94f3pNMhtBvMxRjXVH
aYjEE6rnZappk5FTJR3jFLp9AFVSUtEWlzAY/QNcQ/J7xZNX5zp4uhQ22/Haau2PAZPU9oqN
s+v9ssKupaioW81RCuMMgGRwASvjU5jAPJQHhHd4gBG4xt5cn9YAmJs9Jx+uzj+SHJO/HvHa
0XVujxjv7aG1X6YxLcG0KXbzh16QTQFsgmAi9oEwgr4bdPVm9FUe43Uks7vZ58kaE4rjRCle
p9Z1OIN73KI4KkWD4xpcOow+vslW2STPAoJSlTROiGzAq418X27BxEFr5AW6ILYtYAl4nZYy
zZsb37YNJy4kzB4mj07snXPQoVvybbO9m2xRDQckYFh3eiz27L20WG0wTf55AroCxHXz7rJ+
e21wnXV9y1inQtMyfub0YkRoeZd6EXwPxpQvK202xoc1hg+Wgdfbyf0irwJv+TGXguJp7N4o
bfShgwtWq4/qF60CIXghGAdi42o297fbsQ2vOmJM7Ql0w9tDm4FuyMdtN07++MgJRkC8Hg2u
0JBy+ZwYQEHQXMZMjPKGbd87JSk66Tl0aYwL4uARZh+ok+FgMCAje0/kpggA+2RF8OeQrL9t
l3ht/hhqyPL8ZULWGD0dfEKx6Y9j6wx8naxeaorW+nSTZy8ZDCtYmLB4Vt8KKL17hF9eKlK+
QWGcZzPk2aw3i4UvWn7webOaw/9llBV2BMPtujpCTlGcOGLFJ+OiATbr1eMNxRPvDnwXzF2h
WbopBZwfWL3rbLN6Zq/F6cHjx+OSxA1Bm0P3dyGoutUFjQbfE5uAHJ3TKQptN4NJdAue1gym
WPdkOLwZkqKP9bRmSKq7J8XhzVCpFE9thrJBtU9qhkmfLNDUmt1P6olh9hz6yRzdT8nBXTGc
8z26Zn8zuL0+/EnNkAn9GWmgTs4brZAJe+IMNUpHNFek8g4Gg49JWRIX1vEUjKU12kwLF7K4
ne3sijv0FZHtbr32b6IoiEQ30TtMhXKfu9VsgpFnmKPwbx5umLY3rfxwu33TFSy/6GS09qWg
cMJSIQ8NG85+jG2c7a/0O+fmhX1tQSRgGKmFTQJE6wmvJ8GbErChILb7B3sl2kvNrQ9qbeuX
LCXTHVq8xe8BkZRo6v9rupvXd03xO2V3TfMvOzDdMTzevyUNvH7M13tB2QvBnpHrz5gB90Au
MEOjDJxGBsMwGBPsWG/b2nXuc0aW8zH6gyvcKbsr5OmBCUMXrpJzWLhL0mB583rxIrylo3DK
7Zsv1o/YpWLfkx+zY8HJpzeryS18evPin3/6OQNGIMZXwjAhAizNNyNy+f6MHJ3ay01M/XIT
D1MpZgj/99VHSRZL8MTcrjM95sciaFcA0PbQ6sv6ux4iTIcwsKJB6p0wYxKbMZBnzuI8KrZL
i7fScfPMl020guHe2Ju6F/nY2msLF6g+LCeknXXu1hy31zFc2wubh3ToiVK7q1wROQLnklR1
7x7Q2JvcNyYWZn7gpt3o7Tn5CLK09Z2cXuQ2H2lnb/eZPIKLON0Vdrm9wCcMZkUSSTEa7ur8
AijKGnmzKg4OZTgzJv4Kj/bUEKByMfT1ldUdq8kPmBn2zKBMGT2a5rfPyjlT1kmPZVErObqf
/A/Y11zqZ54zsYnXyw0pb6jbgqG9eeisH6axaJSt0jS7yoPvyBrlZ4sv4R7/UeHVBA1Krb1Q
A91/GfTVA/5Nq567H9POh1EIZo/ZaoWntUaVRZUyAl9cMXq0WgFzQ1xqiA19zua1kgkGjuHX
6EFA8fHnbPUAQwBPpFPyLq0k8MsUPIDo9ljQ5+z7fIdpZJgXBcpFdmShAARmCz6Dzd+dm4MI
my2zXM9Ryx49c3PXafUBPK34+MAX1d3nyMA4OzR5pCS2/h6sBJLDQpCZ6DoAHo29fvf/RK7E
PnIQOrTc4vBqQgQHFw0VfxiVWknc2Xxu95E4JWgJ2Cji3HMlFN/X47n+lW03LULggrmZVlya
dXEZau9Nslz2BUCRdjFwNVTFBWtgF5dKcdffci2W2wiZlKBiJbVcQAbudCeXsdtmvo8TJ/Dh
X/7CpNCGqeLlT8+JEfCgd3IkEjdim7/3z7/8YbIF5d+YeCYVLNk7fNAfLpR2XcP7pnRXsxJu
bwDZN3ypEDJ1wyfwXQeqmytFN3zP8AGbSBK+r11KcrZ3+JjGvHe6j0vbtbFr+Dg4nLwavM5J
mSQ2TdDqGmjJPZ4/DoOTWdz++OFLp8aGW2NpzK9ZrDbfhmSXkCHe9jGxiTbZI6w4VklVsBSs
PtWC5RaW9sAYRQOmWRsDM4OZPpiudG5Q214Yt4tSszbB98FS3Apv1rYXBpO3DdtpuQcmOdXt
2hDGWR8sYe1x24CNdLRLnh0x8ttvhD4jL18S96MHKqn2AaUHSg/U9r1TvUDjgcYDDU17aqTf
3/g6y188OGE0Bma6t6Mp1e251kCyAMoqLMZAWeesH6sCrPJYRnl7QD0Wumj7mJQddr8FeMMj
PYaHuKfHYCEIExkhj4Qm+FZrjxVUt5+VBlYE1YqgXlhDIlh4anpbLIVpPzMNZKzFisbmo8fG
WqyMjI3ROl/ervFWyqawPzTarmV0Wrc5eEjCAxbD09hT1WZBF7diEcyzJPFHrMaC0+3Nmw+B
WGufeMKU4gUJnYTNIW3KBVyqWI8qaEwcYLCLyFTy4JgUGEtpX6MP7TwTNG0vN45Hy0bnLy7q
3WeS4S5VP1jW0TKAK3ubaD9cixq8fE0RwqHxMeEj3HXYdtphQS5eELXPPaeRqkfxU6/4g24k
PIk82E4JBgo0QKVMxjpfn8bBNPBwTlnvpI2h7B5AXGSBxAMUS2JNzUuh6CZGCBXDeKHIJkoq
EZmNgSxoE6V4r3aMoZIoysuCN1EYE7rHMnCrXfmthxoWW3aChVbHwEl0vDt0J4+wJJrvVXVR
cCporP3+cZXdYEFpdN2sW1Qd0DRmxeVNA6UNZvaAZM9azyJgkFes5qaGboNFErNt8qZ2a4Mx
d7dnmin3/ETAykSVGAoM3EWt+/DaviU4Oks4x2M8Bo73hz4WMDtiLLUZeyBdIkTfYpGCYQZm
nTRUpIqLRClaqPcYYcpjzwLOSKN6sUkSm812Shp88XMcL8E1jNjcbmKBIwCDmPSTMCEic8RN
7YNIeNSasrNU6gTtZSMUS43GSypVr1QlT03PWuGkGlEwUuiYQVSXagzvwjIPlGqMBEztiILv
kGqUJJGxlvRKNcan7Tsm424l3vJTGWptuBHRQU68lxZDJzaEosfJsyk8H3op7Pvu4taAt01j
DKmKTfbC3i1eykrLxz5CpGhcjzTch0MZwYqNdc6b4s7e7KPhLgk/avscSmP6zZqKpmEFx/iE
Vj1qcsD6sFJENzT2Y1MTU5E4ZQaqD6y07NvT6AeDFuobCLyGug+dRh2q2vzaQ2NMbH/DTqpB
/xMP+kfHZvkhcDCaIp2wk2hgH41egsT02Yp7CTSskPt8jkHE5tOMy5iVux9rM//6/ZYBi7Xa
3WXb7wrG0YJ3bP02vJ9BzNIFo0QdtM+zh0bal6r1O1MDHuuCkjFze3cAWrOYh+FdsoGIok3U
Dz8A7e5z6p00EcdOJ4zFKi6haQxqYhtI+b5aUxmdqXtqNXu2fGmfJ2rAbNkPjvhyGE3ZZ+L1
18xpr9XdXzPYWH27bbTP9TXCJTf0gyO+nIFxiggs2NSI1SxNbKgCcKxmWID7DOL+mnX0NCLf
32dtTN+2Iu3bKzBGRldvD47oL+Ou4dyzrROrOTHpXgUUrTmNapA8tneYUBrVtvG9wwQe375j
k+7NPxAMjymM+JYh3n/V5yB2bxkmuJP3J/nnyc3V+dVbe4/5kAhyfX6Gl+5NHsn9/Yt8NZmO
8Y2Lm/XxbMioYOTu3objjfErvMITQ/JMwAqPIQxPnewUGIYk/4Zved2+oOT9BM9/50PyljT+
vCfxdyj+O2vWcnN+PSQUbPLhga3Cd1dg9r77C/6hmJOMkcTgWzOoIJQTpYhMSJKSTBE1J3RB
UkNmlMxE+RUji0XBIN2/ZXmjCc1gfLA8FMu0LcaLwuBYyyn5jS7+TuiUZFMijeebUd8uY/DU
Gr9S+NU0waR3/61siWFkxUDpsMycoIvZbDpXlLx+c3HydmS/xZwi3YKefHTQ8A+5eVX7VNu0
EXJzCp/6dA2R6qkwLcKzNiGDFp53VXN2Pgze9Ov+tAhfXftaq37d0KQiZHQymUq9mMGnabua
FiFewtBuIWNdLWTcVw7Wy5TPughFJ1T6ziVCZ0wvJHyq2pU3CTEqtEV4hP88IzCY1RCkMvzm
br2CL/f1/tRxw4Q6c9MC5kj5w+lNIBmoQIHmEy2CG+4LVdc7n96EMhCUcUcow96CYaEn7RZh
4Nn7Lea9N78i43HxYOMzTeGZZqKFJ/+oa77xbLJyL5LYrO0dw3z6wv3XQlqci82sriTmGmPL
2Hwx6ajoq3sP6Di7t4V5mkFZPu1q0/guf9w+bnarFRacdeojKOZK2UJy2l8oT8ork+X/pxD+
QeabsX3J6Rjffn0PxVMUQcpbRaHgZu1EhQF0UFKr6KAczOreCOpCzhfbLMNwVmzzFLm56uLG
l2mWI7bAebFolwposfLuQtsM69zcjxeb7R0UE93iHQwGn0i2nmNm3ywjMz1JmU4zmiyoFHpO
/qzugufHmJrdsS9QTOQqj+x/mbsW5rZxJP1XsFtTFTtnyXw/VJXbchw745r4UZbndVMuFUXR
NteSqBUlx07dj7/+GgRBSbRE+iazm91JRLK7AQLoRjcI9CfyaFHkFK1wBjVfW9XcxklftrI7
bs0uqMdvDQoGIPVrnA0Klt/pygm+J54mBUx3kSMb+4GRg5UPN5jYXE8OJEUpvhEiV7bpqrOG
E4aXepZTzt7nU0BRXl+cfNk/4KQ32Hf9YW9KWrWvS/c5Rad2L+LZMk8WHw6Bx5jz6YGvyUjv
3+S8Ym/wUX5t5aPgUBtWMWvMm3oksPF2wCcVoUrYdhq4G0SAWi2PQESjVX0rqf4hNxUP+Gj+
gOESlB8UblIPBk+VQTXgzeowU0YAlbN2MtzhOMCAN9HOoTXRitZUKlVnYd0gXLOwJcNjtRRs
xfVWTGJJ11LsbsNdId1muNffrLm5rXDuMox6eOw0t2+R2tTcVmRvMbd1YjfMbUm0w9z6ZmAg
kjlPJp0zIK9WHtgW53VG9opBNM2mPUBjrF0znjMpgbxeZ1bcODxS5VbXilteb3AvpzhfzQf1
ex7dsnHqe/FCnHzEC2fR6beCUKsRwMHUPOEkq0zim44r7y6n1ftkD70NbpydJnNkiPyBzFpP
Ig7ITAZ0AdCJuK5Q9HDPQaphn38PZvGs57nydzyJKiyWxXt9LiTuyErTPn5cb2y6s9J8VYry
TrXJqMHIKwRZ0c57ELQvOdUtcMpb6nXpZ9HM9KvS0HRVNET1/mAxmRUlq25ARcfj1Rb+B80l
+rUdHy2Fk/fcWCZyPqIG6bTnOPQDc6Hr0Y+H9P6h5wX61f+0xilfAsDDgP7CDUbOmy5QodDi
JplSl490BRmpV7ZRoX08l0jmyuigSzU+6Gc5Cgx+N7Is5ZUeFArsGO3j86octQI196BId/TH
LTn2NJG7nv5LcwQ2PiVSi9pW0aaeEdB/Rau6ThAU7erb/JNbNrSC79G25cB7tYFp2gOYTbWJ
Q2Jhplcb2STr3qydLW+1pX3vtaYGoIpf39T8P01oGdioSi1Mrst7DNK9n/eF8R7tZ7w3UYD5
3raK+9Z7T5GY700rKH9bPKwlq8uvS88NSxMDRAcX5/vCfg+gw+LigygGoa6R7QHxhPu8J9yi
Tucn+8J7H5S/fVk3eWG5jqojibRMR1fTLqvJJat6MldR0z1c2Lq68llZYTwM3LU60yi0V2vt
evgWUpi8h+V9wjgugwXgmz5U76C/Vm7ky/ls9Ub6Lfkgy9fyPQ+pR2i6CIG7sGC8rftEgklW
IGNA6vNuQUODO8EXFUxaIWJEkn75hJNF5D3GNTBwInBMbjp+4bSGoKlasyLP/a04pfeQkqlB
VsZewOcFJHAVE6w/50R9ruWYjkKguj46189D3jms6v8jaTRN44fn2RO043I6fqmQ+jgA6jiB
pyQVY708b+Y7hhlsfipT/uHWaMShXg7+bdGIg62YbaIRx/JxGvo7RyOObSKZcl00UjzaHo0o
ou3RiKJqFo0o6sbRyCsMO6IRXam6sMHz7fWwQTHsikYUXUuxDaIRTbo1Gll7sxbRiObcGTeU
w2N3NPIGqY2jES17WzRSI3YzGlFEu6IR1wprPuytjIqthsi1+ZzYn2qIglVD9L+DAS7+5+T6
cotNIlkIv5rbJNf1sLXjO9skHAH2621S8Wi7TVJE222SompmkxR1Y5v0CsMOm6QrVWc8fHe0
bjwUwy6bpOhaim1gkzTpVpu09mYtbJLm3Gk9yuGx2ya9QWpjm6Rlb7NJNWI3bZIi2mWTPJnT
d8MmNVjk9TzX9f8TzBGwC8w25sgLXN/77uYIiQJfMUfFo+3mSBFtN0eKqpk5UtSNzdErDDvM
ka5Und0IHH/dbiiGXeZI0bUU28AcrVW5hZ3RnDstQtnvu+3MG6Q2tjNa9jY7UyN2084ool12
xg/smm02ys7s9n2Q9Mz8twVhAYXhbhsLE5gG9jN9ZwsTWAZ2yNdZmOLRdgujiLZbGEXV2GYo
hqfyW7uDoeVuUtTbh9Dc+PKiGFqSN9D7taq00HvNuVNDy97YrfdvkNpY77XsbXpfI3ZT7xXR
Lr0PQq9mA2eTZZfQsP9096K5xuN7fNBG40PLwqGJ76zxoW05Tr3GF4+2a7wi2q7xiqqxxiuG
tdnbvltVe0X2itrfOet6rBhakjdQ+7WqtFB7zblTQcsu2a32b5DaWO217G1qXyN2U+0V0Q61
DwwjrNlC2nSlIwDitfEfEFoEhm0abVZficFzv/vqK7kjnMKhxgyoR1vNQEm01QyUVE3NQMlQ
eHWbE39JUW8BothbU+mSoSX5bguwXpXmFqDCuUtXdW/stABvkdrUAlRkb7EAdWI3LEBJtMsC
mJZVc5ivwboCcYbun737603Kb5JQu43ym07ofXcfIDDdEBvt65S/eLRd+RXRduVXVI2VXzFU
Q7pNH6Akq7cAw8hcV2nF0JK8gQVYq0oLC6A5d+pq2SW7LcAbpDa2AFr2NgtQI3bTAiiiXRbA
sr2a41dNI/7Acmxncw/pKHmaDBrsfQ3o5Z3NzauSvYERsly/JnUXVA631tOZBpbnuYW123jk
G746nSQzR/YkHbb5p9PZciHSXLwzOpbh+D3TCg4t13snLn86EDfphAycb2rdtwKdZUAJ40Sr
rlWfaDWwQn38brlMRwV9UE9tmxZsbzyPse3i+Pp48OVk8PHspi8+ABEHNz6eCHWjwsZZUwo2
5JddEX8ADJk4wU9BYVLoFChq2JWAxPwGsocmsRZHf5S4eKMaFTIG9FVkrYrFHh7bXC3WCxyc
2mN5OKU0TJGNObB9e1O2YgoNizP6y0o057IDhM/P3wajJOZEsWVS59XEyqHh2DjzuULJOeUT
ESmIFtYlzlD6bvJIF1VqEQvLcYXxjtG8eM+S6D5/kymvgQyXLrq6MJdPskeLbJLGnlMUJ+vO
0HnPgdfxHDEj60iXE1no8W+BFI6Lfv9Ei8NZ11txP86GPUDnoT06qz1k8ERefV/fxWav+XCB
nSUgLmH66Klp2Mg0LDr/XeiQ2MNOv2n8AmyUKRoC3Zsn88V/yc0r+6RALgBWOamoFuRY2B5T
CrLqBPGWmNGmPJ2kVMtzXb8qz16Rl045Hzy2+5MtyaMxSaHxZ29I8Wyk3SqlOFoK9dRdsogf
BKdf5S7fr/CF+DKs/kyzaUfWndOcrhfiO8gcqf4owo0mchwTCQWi5f0kgcfyWp+Q0iCZdrs+
QdLZcL1E13VM+42dAq9xQ2BoWjhrrTBrBNdfch7OkwkZdk3qWUiYgrJN27U3Ojj0uTVWReU0
S8cPksbuGmZoIwUCZLghxcqFDLFneTRiaOJdjhcKb4vILYPz0N/P0mzwNZ0Osyl1Q/yQzsTZ
JxyYtBLMDPoQG1hMnhRXWQAnFE1Ftpwzd4WYj1G8Kt+pkU/hvdFYvm3IrUmAmaSptLcK3coU
vBfpl7Mj8XkezR7SOGc83Xs524pjEgdkzTvycpIC7dLqOhoxthxnEOZ42BE2zcTZJTaoAd4o
QQ7z2WycKgsCOgmw2BwCdjS+G1a4Q3gtjbnzSR4v7541v+chmVA6m6QUJuR5dA9ItuloXMlk
b4ddSzP4FhLgMUNhz8tCKkQs9ezq/Ez0JVDB2VpNKq0On0NKHORpT/zMGf3ZgmAXXzR92ZCx
Vx2WZMz8W+ma9MQVxThz8XG5WFDFo1wcFhiOh18ufuv/3r857xkGfl/9ev3xAr+ZT/5tlDIB
ReCXqMpVkX8Q4+mtIjSBYeLdbsFtLuAJMH6B46p8I7tr0WCzgldZjzZZy+rZlmHY/qusH7ew
OtiZ9Xqpx1sq7JFyYMn4x09fjgUjAozSPE5n/HMSPbNSfMCO0wpHiOW3i0EtzwZoBTjIpyFl
mNshUi4DP4Q0Tl4q+NwfrqlHMS7JiHZNQ/ygmWmuIF3oJ3NSRvJpyKc+ND3XNYohd0ATFCDy
KNLGq+UPEeMLrCBI2MgQYsKpLDBKF4uXvsGtcXgpEB8GYi+d/4s8O+dADKM8GQyj5Qjba8mp
xUFUslGR4GKPSpEhbPStAiuFSFOLtLRIu4VIm+HXzi9/O+KeHI/TTEEeriFReF3jscLH+9mZ
rz+J5mTYDs+moyVNkq/xW12j62oB2Lh6q1GM0YQX2bcM9qBETdGtGWLL7K0Yz0pQlQIUY7iE
W6AwViXmaoUrQHLOI9hKclIL1p744QwRQdyND56o920DQCsUFNqHlkUNBKBb1xejr5Ovljh5
nlXGRuj5cFWINetRdVkBhlk0HxUl6yEY+px1T1KekhNJcwmwCZlavGRLMVkCYQ92/AVLK9n8
hf1JdCEHwAkg7ioCAxPflC7Iy3nCQQ/yHxWbamh6lQq5D197NmOk7CVN/p18BrsJ2eNxMuYx
XLBqrtBm0DEKsdJej//hePhAnFxfX16TeSQvIB2RvD6enX1SnD6fTb4Vk6/k69HYnCFKIRHy
x9lAo1V/RAN8ihZRT5zM5xn1Rv8ckDI0OnnKfSLPmC03DZnFA92dkOuTThNdkmkixi1K4n9G
o16PfxRIMYXgU3ay2d0viy86YEQV0BIt4/8hsSImhFEczScDLH7dSI9RfLo+F7yAhIMR99RP
exIYsSDcP6jCfAzyBItrz45xN3Qdy5NQvyUgwIfADCX00mxOYfIHCpx18Q6n81LFp/eLQR5R
LV/Ic4wfRUdkj3+rEAd4ZRBJAByJA1z901m7ZQFk1+Wz/OQFakku785/VZK1KcmDJJw54IE5
0qI8x9tWKW9TVKRFrdZKpuB+VVS0KSp5rVaBCUSnV0UlG6KQ86u2qQKG7NKS+DBDT2C2O5DQ
mzj6wEz8izntoGsHPruUMWBuKzE/CcgehYNstyHxHwjLDnDopgIhcZiXQkKXkW6Pr49uCqhc
KJy2mEzjmey7pvPFkvz9Cm3M4bcMiI+vfq5wBGjpq2jOOGkVDh7WJgdtlUr4HgZeBZRylo2z
e3LOfu+f9hV4ryYPHORyuSmoeuJoNELxLFVThZxd5pSUMpdhUmVWUSUoagfxBCnK490I//X0
HESccjmiQspq8gcpFXBwRgkZJblMyKvs5MUvKnN/V/O5tlnyRZPR/WzZiA9QIobiq9br6b5E
6bKQFwL40eiJp6KjCh+aqjdB2F2ccmKRtuuWVenTdAPXRTwNxxF5ayWsGweYqBK5RYhALThF
XSTf3q/UjmIRR4kq/KhcSZzNkzjNk03J/1om85eKEC+A51/zio+TXL9iYLims/UVzVIk0M8B
6RvNUZXBLFYY8/MEN+AlvNRgu2t+MqNWyQ9M4+NOvnihIUzeFTlrfnDA07JPfvtx/+pq76Db
7e7fan7LRS7Y8cyA6UArKlGcp0i6xx2eaqeV5iSVhq4xW0yqmo2rQC5M4XIKsskindnW87P4
pXClaKLv6tcPyMgSFT7j1K2nSRIXO7PGj6PFhB2XeA7A7FlG1csrLvRBMSRp5p0DbU8UEG5a
kMkm+oqCuwU5VOTyL5+LoXBQenpToxt20WbAi7v8STNbjt8mRqVh9Twgai3AZb++sYCndAbU
X5rwtQjpwf08TXkp73w5XqSdK7Wyd9I5+3RSdYqYJfQwvNJR0olHSrTbNbSOkfmBus9HUdxT
41SFv2vAZExuWlg9fZgN8q+N6C3e6ptMmkm3AuRcjsbLqBG5HWAUMhLdeTJKI3H8IP0U1Yhk
B1yh6clJpAYc8Ie05TRnJLUCF2xKoT++/uFbD04Sy3UKXrKoFEi+otUQVWz6RG7wIF8O85e8
/GrnBPITUj22GBXhGg7jWl1jamNk8ewrhfFjmRsS3lOexItsnstCaIaht4LDAMdOXQWBFheY
gAQbDQfzLGMkwylmzmyWUPR4mCziw0U0p/fQDKEBn6jfP/10zCrdyabk5Z+OoXQ3wDWXH9ok
CmDJZpoMOvjFcYzPv4k7pi7QvnvFinG5ngHYdUdGFPN0dJ8cqFqRJaG5ZZloqZaFFHVqlQUR
Ida7Ks99WK/V50HluW3hoOHq87j63MeZx9Xno8pzx0JjrDx3I7PynNGqVp57foXftbG5pFx9
nz28IDDpcPsAuF23DJ9Nx5JjtpyTLHqmINsD7dP6MtvSrS7A49yU/Y/Hnc+/Pct2J6/gsoeP
iUEHf4fi/OScrkexFDIq1w9ZgM/oKPmYoja5cJhM2Xqux3EgJl1GJ98txoOYlOX05ot4YPBy
7Y1p4sDlXKdksGXc9SnNHy+nWECsiXiZgbwxasw/pqRReUozLNSUxw+GIWsYMOST55n8CIg4
SGTLBT7I8brtAR+G5TXS/s3Rzcng+uTo0+/47LmcT9GSuqjAx3f/v6Ko0PDMv6ooi6G0/pKi
HBs7Lf6SojzT+6veKpAAuBEW0Qul5jF6IM6j6ZKmZ2AgzwX2iRjPIb6vysV5XNqhlhNa+Iwm
5dxk+UM6jMTF0cUnQd7aefpRmAfBLyLoDNPS7nqINn3FQ2SC6A5E/8sx+TXk8CQCx8vpiSd+
wgOcmi5ukRU8EJeXH0sKLROfmW4La1w8lZI1iWUjoFgVJ7+6VmhCbK1FERG1ua7JGpnNoKJy
flqpriYhr7EoLSenbzLEipblWabjaBrXQENImhncdBbYUxBAkoYBJYfLnCbS0YJMXqCfAezn
FpiP8hD9SnUqxXgBVg8VWaUBQk3ju05FlG7jihi5tKWbWM7sRIpPZmSfg9UGkDhWXFrxRUS2
4opMcjOssiHXyOySzDR4o0A242AZQ9DRLURxFtLK9jGzshuhRvNcDCMKKnDoSHed4/EuhTKy
NRnGeYa1URaOyOXv9QP47z0tJTDgva0uKKj1hWIWE71CEKkytuxQfcpihPH3UpYLvIWGUw0S
kYf1Nvb48uL07POA3mZwdXR9c3Zzdnlx8mlwftS/ObmWy5jDpFzxp2mYzEiWJyp2IMux1JMl
UoejYxK5SMJrznvX++Lq+vIQt8RFsgDwuIovOxWsabtrmZ3HoHNxpIM3pAPH3FDIO85mL/P0
/mEh9uJ9YYZh2LEMw5Pl0FOEZex6FS8eUpjrMRA5C5AJQPF/m8LQZPFAIveujs96tn3+47ee
baG39oVr9VwHZKbVs51ekbWFhfk2Ut29Kuz19z3OplMarGo7DgsL2JyxsKRRW1ELdb3Oo5aA
1SAtoWwd1TjEQrG2u7V5whDHntP7YaUGn9P7iFpCnCwesKqxeL3X3K7TNSo1Inly4XG43lkA
O6fOoqh/S21M08Np8vT5flhtEdMoq4Ql+ZNnDjq21cpcrRW5eH4ptnYQmdsGkUUBncdLCNNk
3JP/lFGsDlKzaXVlIPvAawv7FSnkvxkt4tuHr1FnHmt2nAltwZ6aZG06o7tlpwyyISXg9fXk
IU4HDzFNpD/3P+LjjXh3MqXIME5G78SPGSk9jdjFPMNhSLF38uPx2X7RzlpSyEs9kNSZxWlP
gIo7qHTmR6sctnT0JEdBU7AplPRXWREnkCVfqbbZNcW7S4rTaqp8WVdl22LAoqys8uXOKts2
g96vVvmyUZUd2wJsdba4t0xD1vr08uYzXTRsYdu1MAH/Kk3136qiRP6QLccjCnu/Ri85LLT6
YpZQXRKxLBqK18RUqx3IbzB3i2oZPkPnNh5VX4myEw+jOy0h4CimsYR4FA+ieKL5wyCgcVTc
lj17NMyRRrRsI3GejbTOYYoGFRZbJzm/4ln/0wX5AdEM4Vgp2jFN7H5rVbWvI101h9yuNvxE
uJhojaUIIGij8MuoUnU7RFzfpuhOTr4CuU1ahmvYbSzGcpJ3onG0HEVaBLm2rV6BRMQvbJ+1
DJ8XuFrJQIhyF2mzRabMavkqA9LP5dBTO4ZZSmgg/GtVE3yuiTM9Jsj39to26j+Xkxkp7EIL
gSvRUshjNJ/ojnEto93QJAkZzeXZstjcxUJso5XyQwg5wONF8qhlOEarzUWQkZPDboRahGs4
bxHhuloExVZtm4OIo0qX+IbZZvV5ksbzjBriN0+LCNgfaywiGi0Xy+cKe+i20bVoNiOXPM1p
AnrRQsIQOyGbm7wXOHl6eFNoZbZRkXQ0yZa5tjmAHG/TjGlGkcg8zfSM5FkM1dBcQg5nbnCX
zickqlITm9ENG8sZj6p+EkK1Np0xTu4zmH/sA9NC3MBso1/UDq6hzZVHHl8r9aTyk1wPaUCQ
tJxDBslDniwGq2ICP2hlNfP/a+5Zm9vGkfxs/QrszNyOvSdKBN9UlbbO8SPxTmzrLCWXulxK
RVGUzLEkMiQlx9md/37dDZCEZNmWJv6wrhnHJNCNBxtAv5G7hjIK3/EJHN+K470n2GR2QtYo
5VSnF7k0swFhsvfLMFoUbBCFtwu088ZQ+qHfB0ykWKoacYHJ53UjV9eDs45wMCG/qDyNwhgz
Cy4zIbyKJkGapYgn9C7OC+AjKlsSogR+1ahRprDakzCZ5ewwmrZQ4zEKFtMjukCl7BJMEeKs
nHBCGk6N0ZQWMoHxYkKeQr+jiH0fLArScQs5kXrGKNgHTW+wwBD3LEVH3wKE/Bql5Xh7cih5
tMqjaY3BptyuuxP6ShkQNA6zHgOZGh3Wu+rBr37bUDnbz/BWN3Wz89ub0yb+PeFm5/L6wxdh
fXX0JvyyyADLm9yoUfukdcuBxU46ogUGKIRf02PQCg6zI5sbcMcfPj0FVzVowjmG0TG0m5FX
FY2EHkvVkLjlhQgVA07gBIgUcBdZzWg1WqJSRXxG1LUSqIyKAblw3fe0YKWbaXtEr6ST6VGN
F7axfbjrb2lNHabtcpQ4pdvr8aCyTgF0P0Jn9LvoQbhMqW6wpUTTpulr01yuOcHyugWPk8Ru
hAReenhsyEJQjdxCn58dzg6f7yJGFQXoKLTWJXWyfB117mkcf7OG+RyVn5WWhrdMdEZ7A+82
pS8iC1fXmzC7wm2UVdsXphPdy/UapkIbx8ksWGhLI6zROA5eq4SlUknQKeUVVjykEaZjxk1q
Urp9E5BL6agUIG2Gh90OoJ5O4RM7d/smGSXF+fL7d4YCNesLGxu5/55DtSa77l+c19gNZ6+z
FUdQxIsHVRVhejZx46f19s+1+xiE11NYXUCPC6nfKXfeVg3pGJh5554PJ/qYzMOHFRHAQjTc
vbjJfHQ3GtfgeKvLfuBrHBAgcDHg6H9BFluwy3/0zt6WXonrHrM6+uDwGsy30KVT+Fys4nGE
h8E4CkWLc7TdF5EwKXfIal9B2nhv0RfcnaBSR8HvtlyHaey2KNJOu31/f98SdVpJNlWgfbTE
iBL5D7ms4B8yWkpeISt43lUyK5rylXiTg4CEsVLBKiJFSFAUFNBSt2FR4tzNNuSE/Kq09Su7
DdCvIMQYt8lyNntgwbJINGhgEk+X+BXWqrfqNvbcKMeF73FlEoGD2IffW8SOrXMF3ON7slrj
mvW30ZN5PxYLwSdBzaXZaA7YHwXwzrVQCUKUji7oi6Q0mbSUIou8aGHrHIoGNpado3voaCAq
0AG6WYEbKJkoGDa6iC+ROFKQU4EbQiQKMIUkEnCOpo3H6IWZbmf0eW1ZR2iT7Jo7Qyth9QLc
24t6otwYBulw/ZSENUJGmmkGJ94yf4SlZMDwBMhrINvQnZeBkiRFnx0FjFi3F8BS5FaGwo29
BnUs3OBeAM2C+xoCsxi8CDEdpbdKKyI8aDoa0vsngdI4qWE8E+19L8HE9bkMICKg7AWQZZDV
S81BH6IdYOqzDpULGPIafItzbRJPko04B7KI1v4kwm6PTpbJssAYDx2ZEwp03XhbN2Aa2MDx
5SnZkE4utDOKJiB2CjAj0b4hX6LywOUtFZqW18XpYCdQQwW1HFx3tflqX3g4sNFDLZkUKL6z
/15Gy0jrBXEmWEFi3EnIuhq8qb0QrRoBnLdIKAv0Tnt71e9vMc3Q/M6D34HHsHyvBoWjz0f7
cJbQvQhS8Ly6vCAP14xV/p31RujpNqqrr84GHXZTt1AyKWV4DK9HCCwy6lB3comL05UzhI5H
i2G2GMdjTHyAOR5GT/nDIX4QekwMaaKgVvSLIws11b/orZy6okkxBDmGPGBBE39bpD+/7L3v
i1mmV8USOPQZWcXXtyjPMtFZzk+BOUMLHUjNM6rn9+g6O+kwXNd3SKe109iB0a+8AA3DpcwL
zw3b9ZGj/i16EFzweJHjfRDJbP3b1/V92oRarRY77l2ckE8K/ZR2eHZYixI2JnlzlNofz276
F9dXHYbeyHhPn1KT0s3qP/jzmvjWdgbf8DDATviSYNDxZU+EthGLjx6ddk3dvmmhKraufHGt
0fh/1qs5BRDDUkDwHoIvZQg1aW0urmnSWtt/FEgHgzplbWhis9zW0cKI76rGoZZyA6NS1Ua1
pWwBv2qHXAljIDCBHdNEqAB4NfsGwCmQPBDPAxsAPXWYWtl+VPn9oM+qn7XKGDTzuNd0dyYH
KZNzpaqNBhoFL2CaB98AbgyCEPkLlCI1fCe3BvQocnsdsAcfNZ6ns0jEtq/1yXMk7Sv1y3mX
W2qHqT3z6cK4zUEY26bed3F7W8cdZKO4EGZ0ddrRh8so8SIRqgMVd9EoVV2MnL+4pk7qSgHX
0acZxPwFHovjOCfflCaL8Ihp0k05TfbxUNePMIjz5hD/7dPvkiSa7FQUXyprHk1dqL8nxLxZ
+bw8QmzwR4hRNYmkRoj5Y8Q+alAJsfEMYvNxj19AjCE9ErH5qlMBx2Q5x9arIgaiNyVi+1UR
O5RiixA7r4rYJRcZQuz+AFVYjxDDieRJxN6r9hioraQKX+3xLFpFs917bGwi5jq5fBDi4DV7
zLlnlOQ2elXEBplxCHH4Ax/Pe4TYprxohHj8qj12/GqOo1dF7Pq8pIrJayI2uG05AjF/1f3Y
MGxLUgXnr4rYtE25CaFn8CsituySjvmr7sdoI5d7BX/V/dgAYV5SBX/V/dhwrXIT4q+6Hxue
b8qVx93XRGwCY4FJC4AtQSNevCjDc/KOUsdFNRjU0TEljt4x6iJOWSShiIsirhRZyJ1CkSmK
TKWIItagyBJFVl1k6I6AskWRrRSZeDxDkSOKHKXI1UU3XFHk1kUm5YGBIk8UeXWRZaBcB0W+
KPKVIkcXPeRyzLVsC4Uk32FhOWpl2Lbhy0JDFirTZTummG0uJ4UrsyK4cyyU08KVeXFMXxbK
ieHKzDgu+sU8IXqs/bBxsohaNaRroWB//PFTpWQA+WcazofRImyjJj5aTPHqQwXEIwev47M+
OxnckD8aGz14pD2dx98Dyb/XqUMQCN2hKCXbQ1ok82k2TLNkFLFDWOJHIkx8SsHYmD8C012y
cZSi/z63bEeX2d5m0aSoEXpkodqC0HoJobEdIUjKqCeoL9/osMsgu0PxTtwZyg6BlHTHwuBY
2DUwCMyBc8s70v4OJZ5voQyEbJiGATc+kL9ZrzObWyi8fMf8oWV+pTKyNklmbPY9aX8fLesZ
s01yQHhTZJNc1m/K7HRd8Y+GihpY1piBLSu6yaJJqptpFhcPGmVIiDJ6m0UTDb5uPHno1q7Y
DgYKuFtn0H9+BoH93jqDDsZWK7qJUTwd3sHDY7WEAwvWUdUYRbbMKTPZtqoenuA7KVNSJePE
EA0pQwrxwZyW1vP6JPiQDuYrkj736NnOrkACowRAcc4+pKR5ZJejNGfngJmdLkHo/NZk5+hK
Ie2qHXbzqcKIUi+Kcr2V02HHp6c3GHRweHU2OD37OPzQO+pI//mZbALdVJVYacTAKex1O4aT
d8dXb8/WsYzQaS/KN9AA+4pnR1/ccMpO3530oMbXJeXvazWrcGas6lHg40VPOyHbU4e9hV4R
RLDI0YhP88z1lt4yWsBFzB+qQBQYgnyv7Ew+SP7eGsKTBKX1QpF5fTheuMxjJ2zjXRxTE33B
AXf3UWgC0HlKJVV70BHM+wvrslX+D/DT+7JGvQP76EQoG7tN8qK7mmvxamRxzXiroUCSzIN4
0W2yRZxr8uFwAXtmvZR92G5tiWKUJAXdUFl1BiYle+plGhS33TU8rsSzCObipstML2Hqg8G3
DfTzOX7fPy69MmawTJQZtB10uWIYVUkmnnAzfw/VAkqgqFjyR1gu5EEvYtplVOlE/qDrgqVT
mE79ytOtOsoUEbqUFvJ/KBcl6oJRpyG1YTI1RB0pPKb8OCa6z9zVGGDT9XbtkuE86pLhqoGv
fos0Tf7OCCd2tIlwsolQ+FjdLBesTUiCXCCTKUmripzTFaw5JWQbf+ZfYDMYnDDFhgu8FV3n
hFr2JjkyPogQrBlGJk4YGpYXy0Jk8xR4SCPfqttwbFfZC2VbOM5YyTqxFOU09+ywjMejx6Ma
led7+o+hqnDh9cTe63TLNEmskpPLDMdmhxLfEZrYo3mK50TAetf9i0/SYAEV8BRg97eYQUrG
dlGF4eDi8uymX26veVQoLfloC5TINaIYbYopHr0Xjj/P23b8uZZOcTwlwmlaaMGyAISu/gJC
13RUhJWCtV9gCByQyHs4/uGwpBV1SdkwclQZVxUvYaFTxZveCevFcKCe40yI5IBrNSuUN9Ec
gdhNQkkhK/QKYL4d8h/JMlsEM8wmh1vR9koysy08F3HITsWmdSUziJLX1PYBnFISoRd7v0S3
K9ljifySrujOttfHCWz3g1XEbgQR9oFDeAb1STIbp5RdZVY28MRs9LKoJNar83613EUs1dYh
nqhVXh7qMWVTk2P9GGQxuVduR33+oX9WRY+8TAIBJrcpHY4qc32uWCM8zKSMzo4pML/ceIGO
gaF8no7PZ8v8tiIg2OV6KHNAD4EQ+yKO41ly+lhmiTunpMdItqekSU/QWPDEKGFJjDC9BJro
4DhAL8mn6fZDOsaGPgwugeMZoclZZth8A+uk3b9dFph4YztsGZqH2b4BbBHeZslCCkQIATTH
fhXbQ1jMKPp8mVf7xZJa1pbFPG3JLv5K/mHjqAjiWb6VrPtvOuKJ5iIvkpSN5qF2HxTh7TiZ
PrEYEOrsWxTCWSPPanhgmvD1RETwZbIIWRvZu+14KE1IFrboUCO+DoY6imcgfmwHQCe7N/1T
WHwhHIisfxvB6hJczxOLK8rmcNR+gDoAlOfknbN9TL/1BC9WZEH61B4wha1H2bWQxi2dnB1R
UVGO5DNqGTqsdzx4120v86xNb9s5EFFHea4e6wL6QzzSr9ldSv/nWYgvtvRJEhd0bUqPz5Em
fTY6CSRvFc8xXJwkGvqCCAbz0GHvrvuDq+PLM7bB214enzyO822W6J6+s4I3ybUYPnKZ0wk3
8DYlAP2RLbFeOVBNLoc5LBmM/kbKh9cro20i14RieOsJ4KQAyZZwpBH6kQArFdDtCFCh+s68
xV2dRPBn0vx4T6f5KRH4O4qiOdH4ME5X1pBSeEXpbQTMCt3maaE06j0hjVJLJqlLdvOegB18
GGEavQlec2HhFZ7j53BbFBy+zyiKMB0W+TCZTMpcRf4zDfjADpLbGpxKrcUkZ4e2/gJPhaFu
mzwVofItrnCp6PsnuG/UYolaNowIeH7v2Q9rPvNhCQG5k+00JaiKGUazyRBWdJA9wISMxxHd
K+I6m3MitIKW0+KWZ6LiTywjzL/bwUSHbL4MbxkdGkjvcfbVLCEMw6AkhLtDmLqQJ/eAcEDa
97+UzAUl9O/QSceuf/uLWgtt++WzbVoON/dpx+E2ueTvAeHbtrcXhOuiD8I+EB55Ee4DAQI7
Re3uCuG2dFht6DO+I4StwzhcB5XSsfAyQkkWZCQU5FmC91GM07sp02KmaQAZRuQjPI4m1TOs
qGgBsn87SQvYpUftaXB/N+T/YQawv7es/xxP8qnGh8F87FgtKFfb9cqvjM+eQZka+tFMSvUp
xgkkyxy4UVxjMxHMkMKawmMIm2mpwKiQqJ99jmLd4Q0IeyTzBkWA+ZzJ1Yg7XHfkPRbIfYxr
lo7B9oOudNCmnBBg249UtJgMuXr2DUrMggeQyGANjMxygV3Ehl6aClYeFiUqT0XtkG/IB8KG
qBEZiLEdFdfROgrHQK18/ewbaCvpy0yZy3QXHD7dk1E+ezr3MC3oJmvRzpYLDZ7Velb1AYwW
Rh3gero56394PxjeXF8Pum1xj0Eb2aY2byu8AtJNHCy0b54zdCxMFOFpuqXpZiucfm/Lt7hB
iqNdu891jeNNgbrhtqdhqLltyTqEDvfcgNtRaPNwYtgefPUIdpPAMeyJ73t6W1/roqd22bFw
qL8noy4NFf7I26SeB/l33F7jbWgQGtee67i2a58Ijutc16ADtqfxYL5arHRNbz0E85naP8tQ
+yty+FTHHqz07IFxocIpP6msp3wajM7G5Ef4BWGI7N9xrNRHt+yzS2lTXaHsyr52kIu9+cpA
pgD+Zkq3fKD0U1e2TVQTblS+KVPGNhpnsyBF5qCga5IcvdH4+S9E1bBF3MIDG6A8AjzleBlG
TXiGRZKjMA/TpOVhFqdC/qHQR/l8OErgKEbf2jIwAxUP+jh4kClUWTQHseoIsIFYC5O/Bk3n
+ANdlAFiDeXik1wypZagOAFgh6PFiv1ycdUfHL9/P7y8xmRCg3eNhqja/YU3GsgGZOO8e9g4
aCc5cexydT27yKB2ucLhf1lHFtRo0vz5lYokFadikQ4fNbA7HujCj4BnOVCDhvrvSb6J56jR
eDcY9Ia9m7Pzi09djNrJO+02CtnIaMEBinE7bfxuWhjTZHyN5svGPfBocOZVKXlxQ/3pl3/K
6f78X1/aP7d/UTD/8VOj8c/GQRgUG9Xaf/u/dhtKDz5/fvwp2Zcv7K9/ZfDxDsIxAG6WA9gB
pa6cxSP2LxamccI0+O8desSDRK19XcbQz3+x6fc4bRwcNQ6i8DZhKt2+CPUH+zsT/W3Fc1gs
OHwN/pLZq5k2YV/D5N5An4A7bW2n0HRm2M7bvUD4/iDG/iDm/iDW/iC2AGncrea4AAlUKDQk
pTYONGGo1qAKPITpkl2sHoTfPjzLNf+L+BdeiA+hfo8DbS7ymh9o+TxliFKaaMiU2AThDJ67
8I8OReKJ7i5oxmN620Qr1OR+3AUhq9Mx0CdB6xgGVCYFDN031YXdFIATTWhl4O9Sw8Nix9T1
KB8p77RAuJaSShveZ0VIl2d0K+sDdhJd3Inp6m4jnCbF3lFRM550MWF1nLwIxv8cmPHnwMw/
B2b9OTD7KTCpGsmLscAiclNgdD3Oc6nPwNAp3O3w9tDFGMkxTrsd+FlrpdMZ34awU+Bm2SUl
SxbMgXCQYLrI3x0QO1TvH42D45uTd92SnO/EZt99nkdrHIygJLztzjDuEojyW9GeB2h3hx0y
mc9Bct2Vf2gcvAFecnhxefz2rNsG2aRNOF+ZSVzNEet37UkVVeMAUyAv0QMl6jo6dOvfkdM9
EP0YSvVut5ink7xxINdpkMZhV/5NvNJQ5Lkalr40B1kolMQt+GMIe9WQJKIyOKrLcdywpbTi
CZmTu/Aork4F6QZT0U/R/eMgDRbQkMahlWRSoG5tmQ7FS3i3mMfDciPp0tvGQZKkefk3qT+A
KHEZdA1sABikonoDTY6z0bhF+eyHIfLCXY/Gg0ru1iyZDskftxtlQGzxFGpFQ3hLL5H6SL/Y
LYoHwERXp4oRdEnZ2BT3/qzVU96upkEXEM4DwJTdi/mKskkrl2p76B2sQDj/YbeHs/+Pn5gm
liPyBOKvz3+D143/Bzz2kFMPOwEA

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-lkp-hsw01-15:20181010034251:x86_64-randconfig-ws0-10092027:4.19.0-rc1-00077-g4ce5f9c:1"

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

--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-rc1-00077-g4ce5f9c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.19.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CONSTRUCTORS=y
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
CONFIG_SWAP=y
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
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
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
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
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
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_PROFILING=y
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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
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
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
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
# CONFIG_CPU_SUP_AMD is not set
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
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
CONFIG_ACPI_VIDEO=y
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
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

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
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
CONFIG_PCI_CNB20LE_QUIRK=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

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
CONFIG_PCI_SW_SWITCHTEC=y
# CONFIG_ISA_BUS is not set
# CONFIG_ISA_DMA_API is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
# CONFIG_DCDBAS is not set
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set

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
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_PADATA=y
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
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
# CONFIG_SPARSEMEM_VMEMMAP is not set
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
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
CONFIG_DNS_RESOLVER=y
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
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
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
CONFIG_NET_9P_VIRTIO=y
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
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
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
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_SBC_GXX=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_GPIO_ADDR=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
CONFIG_MTD_LATCH_ADDR=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=y
# CONFIG_MTD_NAND_ECC_BCH is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_NAND_DOCG4=y
CONFIG_MTD_NAND_CAFE=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_PLATFORM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_MT81xx_NOR is not set
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_SERIAL=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
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
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SKD=y
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

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
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
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
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
CONFIG_BLK_DEV_ATIIXP=y
CONFIG_BLK_DEV_CMD64X=y
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
CONFIG_BLK_DEV_NS87415=y
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_TC86C001=y
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=y
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
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
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
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
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
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
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
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
# CONFIG_KS8842 is not set
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
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
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
CONFIG_USB_NET_DRIVERS=y
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
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=y
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
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
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
CONFIG_NOZOMI=y
CONFIG_ISI=y
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_EXAR is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_MOXA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
# CONFIG_RANDOM_TRUST_CPU is not set

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
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SX150X=y
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
CONFIG_PINCTRL_CS47L90=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_AXP288_CHARGER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_TPS40422=y
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_RAVE_SP_CORE=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8400=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FLASH_LED_CLASS=y

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_CYPRESS_FIRMWARE=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#

#
# Video encoders
#
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y

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
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
CONFIG_DRM_RADEON=y
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=y
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
CONFIG_DRM_AMDGPU_USERPTR=y
CONFIG_DRM_AMDGPU_GART_DEBUGFS=y

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN1_0=y
CONFIG_DEBUG_KERNEL_DC=y

#
# AMD Library routines
#
CONFIG_CHASH=y
CONFIG_CHASH_STATS=y
CONFIG_CHASH_SELFTEST=y
CONFIG_DRM_NOUVEAU=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_I915=y
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
CONFIG_DRM_I915_GVT=y

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
# CONFIG_DRM_I915_DEBUG_GUC is not set
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_GMA600 is not set
# CONFIG_DRM_GMA3600 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_QXL=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_HSA_AMD=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_BACKLIGHT_RAVE_SP=y
CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_PCM=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_DRIVERS is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
CONFIG_I2C_HID=y

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
CONFIG_USB_WUSB_CBAF_DEBUG=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_SSB is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
CONFIG_TYPEC_RT1711H=y
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_ROLE_SWITCH=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=y
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_MTD=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_AUXDISPLAY is not set
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
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
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=y
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
# CONFIG_COMEDI_ADDI_APCI_1516 is not set
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
CONFIG_COMEDI_ADDI_APCI_16XX=y
CONFIG_COMEDI_ADDI_APCI_2032=y
CONFIG_COMEDI_ADDI_APCI_2200=y
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
CONFIG_COMEDI_ADL_PCI7X3X=y
CONFIG_COMEDI_ADL_PCI8164=y
# CONFIG_COMEDI_ADL_PCI9111 is not set
CONFIG_COMEDI_ADL_PCI9118=y
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
CONFIG_COMEDI_ADV_PCI1760=y
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
CONFIG_COMEDI_AMPLC_PC236_PCI=y
CONFIG_COMEDI_AMPLC_PC263_PCI=y
# CONFIG_COMEDI_AMPLC_PCI224 is not set
CONFIG_COMEDI_AMPLC_PCI230=y
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
CONFIG_COMEDI_DAQBOARD2000=y
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
CONFIG_COMEDI_CB_PCIDDA=y
CONFIG_COMEDI_CB_PCIMDAS=y
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_TIO=y
# CONFIG_R8712U is not set
CONFIG_RTS5208=y
CONFIG_FB_SM750=y
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_ZORAN=y
CONFIG_VIDEO_ZORAN_DC30=y
CONFIG_VIDEO_ZORAN_ZR36060=y
CONFIG_VIDEO_ZORAN_BUZ=y
CONFIG_VIDEO_ZORAN_DC10=y
# CONFIG_VIDEO_ZORAN_LML33 is not set
CONFIG_VIDEO_ZORAN_LML33R10=y
CONFIG_VIDEO_ZORAN_AVS6EYES=y

#
# Android
#
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
CONFIG_DGNC=y
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
# CONFIG_MOST_NET is not set
CONFIG_MOST_SOUND=y
CONFIG_MOST_VIDEO=y
# CONFIG_MOST_I2C is not set
# CONFIG_MOST_USB is not set
CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_GREYBUS_AUDIO=y
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_UART=y
CONFIG_GREYBUS_USB=y
CONFIG_DRM_VBOXVIDEO=y

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
CONFIG_XIL_AXIS_FIFO=y
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_MXM_WMI=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_PVPANIC is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC_I2C is not set
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
CONFIG_COMMON_CLK_WM831X=y
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
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
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
CONFIG_NTB_AMD=y
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_QCOM_USB_HS=y
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
# CONFIG_NVMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_INTEL_TH is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_ENCRYPTION=y
# CONFIG_UBIFS_FS_SECURITY is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
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
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS640_GLUE=y
CONFIG_CRYPTO_MORUS640_SSE2=y
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_MORUS1280_GLUE=y
CONFIG_CRYPTO_MORUS1280_SSE2=y
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
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
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA1_MB=y
CONFIG_CRYPTO_SHA256_MB=y
CONFIG_CRYPTO_SHA512_MB=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
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
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
CONFIG_DDR=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
CONFIG_STRING_SELFTEST=y

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
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
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
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_BITFIELD is not set
CONFIG_TEST_UUID=y
CONFIG_TEST_OVERFLOW=y
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_TEST_UDELAY=y
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
# CONFIG_DEBUG_WX is not set
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
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--5xSkJheCpeK0RUEJ--
