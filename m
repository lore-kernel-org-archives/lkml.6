Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528CBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5CA2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5CA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJLQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:25:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:33275 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbeJLQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:25:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 01:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="gz'50?scan'50,208,50";a="94607252"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2018 01:54:29 -0700
Date:   Fri, 12 Oct 2018 16:54:50 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: [LKP] 601d5abfea [ 13.686356] BUG: unable to handle kernel paging
 request at 34ca027e
Message-ID: <20181012085450.GK13396@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-next

commit 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0
Author:     Eric W. Biederman <ebiederm@xmission.com>
AuthorDate: Fri Oct 5 09:02:48 2018 +0200
Commit:     Eric W. Biederman <ebiederm@xmission.com>
CommitDate: Mon Oct 8 09:35:26 2018 +0200

    signal: In sigqueueinfo prefer sig not si_signo
    
    Andrei Vagin <avagin@gmail.com> reported:
    
    > Accoding to the man page, the user should not set si_signo, it has to be set
    > by kernel.
    >
    > $ man 2 rt_sigqueueinfo
    >
    >     The uinfo argument specifies the data to accompany  the  signal.   This
    >        argument  is  a  pointer to a structure of type siginfo_t, described in
    >        sigaction(2) (and defined  by  including  <sigaction.h>).   The  caller
    >        should set the following fields in this structure:
    >
    >        si_code
    >               This  must  be  one of the SI_* codes in the Linux kernel source
    >               file include/asm-generic/siginfo.h, with  the  restriction  that
    >               the  code  must  be  negative (i.e., cannot be SI_USER, which is
    >               used by the kernel to indicate a signal  sent  by  kill(2))  and
    >               cannot  (since  Linux  2.6.39) be SI_TKILL (which is used by the
    >               kernel to indicate a signal sent using tgkill(2)).
    >
    >        si_pid This should be set to a process ID, typically the process ID  of
    >               the sender.
    >
    >        si_uid This  should  be set to a user ID, typically the real user ID of
    >               the sender.
    >
    >        si_value
    >               This field contains the user data to accompany the signal.   For
    >               more information, see the description of the last (union sigval)
    >               argument of sigqueue(3).
    >
    >        Internally, the kernel sets the si_signo field to the  value  specified
    >        in  sig,  so that the receiver of the signal can also obtain the signal
    >        number via that field.
    >
    > On Tue, Sep 25, 2018 at 07:19:02PM +0200, Eric W. Biederman wrote:
    >>
    >> If there is some application that calls sigqueueinfo directly that has
    >> a problem with this added sanity check we can revisit this when we see
    >> what kind of crazy that application is doing.
    >
    >
    > I already know two "applications" ;)
    >
    > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/ptrace/peeksiginfo.c
    > https://github.com/checkpoint-restore/criu/blob/master/test/zdtm/static/sigpending.c
    >
    > Disclaimer: I'm the author of both of them.
    
    Looking at the kernel code the historical behavior has alwasy been to prefer
    the signal number passed in by the kernel.
    
    So sigh.  Implmenet __copy_siginfo_from_user and __copy_siginfo_from_user32 to
    take that signal number and prefer it.  The user of ptrace will still
    use copy_siginfo_from_user and copy_siginfo_from_user32 as they do not and
    never have had a signal number there.
    
    Luckily this change has never made it farther than linux-next.
    
    Fixes: e75dc036c445 ("signal: Fail sigqueueinfo if si_signo != sig")
    Reported-by: Andrei Vagin <avagin@gmail.com>
    Tested-by: Andrei Vagin <avagin@gmail.com>
    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

4ce5f9c9e7  signal: Use a smaller struct siginfo in the kernel
601d5abfea  signal: In sigqueueinfo prefer sig not si_signo
a36700589b  signal: Guard against negative signal numbers in copy_siginfo_from_user32
771b65e89c  Add linux-next specific files for 20181011
+------------------------------------------+------------+------------+------------+---------------+
|                                          | 4ce5f9c9e7 | 601d5abfea | a36700589b | next-20181011 |
+------------------------------------------+------------+------------+------------+---------------+
| boot_successes                           | 56         | 16         | 27         | 8             |
| boot_failures                            | 5          | 3          | 1          | 6             |
| EIP:__copy_user_ll                       | 1          |            |            |               |
| Mem-Info                                 | 1          | 1          | 1          | 1             |
| BUG:unable_to_handle_kernel              | 3          | 2          | 0          | 2             |
| Oops:#[##]                               | 4          | 2          | 0          | 5             |
| EIP:copy_siginfo_from_user               | 4          |            |            |               |
| Kernel_panic-not_syncing:Fatal_exception | 4          | 2          | 0          | 5             |
| EIP:known_siginfo_layout                 | 0          | 2          | 0          | 5             |
+------------------------------------------+------------+------------+------------+---------------+

[child3:558] migrate_pages (294) returned ENOSYS, marking as inactive.
[child3:558] mq_open (277) returned ENOSYS, marking as inactive.
[child3:558] pkey_free (382) returned ENOSYS, marking as inactive.
[child2:557] uselib (86) returned ENOSYS, marking as inactive.
[child0:555] mq_timedreceive (280) returned ENOSYS, marking as inactive.
[   13.686356] BUG: unable to handle kernel paging request at 34ca027e
[   13.688081] *pdpt = 000000000c7ab001 *pde = 0000000000000000 
[   13.697660] Oops: 0000 [#1]
[   13.698554] CPU: 0 PID: 555 Comm: trinity-c0 Tainted: G                T 4.19.0-rc1-00078-g601d5abf #1
[   13.700926] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   13.707252] EIP: known_siginfo_layout+0x35/0x70
[   13.708468] Code: 80 00 00 00 74 37 85 d2 7e 3b 83 f8 1f 7e 0e 83 fa 06 0f 9e c0 5b 5d c3 90 8d 74 26 00 8d 48 ff bb d8 04 01 50 0f a3 cb 73 e5 <0f> b6 84 00 c0 ab c0 c1 5b 5d 39 c2 0f 9e c0 c3 8d 76 00 b8 01 00
[   13.713020] EAX: b984ab5f EBX: 500104d8 ECX: b984ab5e EDX: 000010e0
[   13.714608] ESI: b984ab5f EDI: b70b2000 EBP: cc7b3f38 ESP: cc7b3f34
[   13.716177] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010283
[   13.717871] CR0: 80050033 CR2: 34ca027e CR3: 0c665560 CR4: 000406f0
[   13.719461] DR0: b72b2000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   13.721066] DR6: ffff0ff0 DR7: 00000600
[   13.722200] Call Trace:
[   13.723069]  __copy_siginfo_from_user+0x2f/0x60
[   13.724361]  sys_rt_tgsigqueueinfo+0x36/0x90
[   13.729191]  do_int80_syscall_32+0x4f/0xe0
[   13.730392]  entry_INT80_32+0xda/0xda
[   13.731494] EIP: 0x809af42
[   13.732413] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 ec bd a7 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 14 be a7 08 85
[   13.737100] EAX: ffffffda EBX: 7552a122 ECX: 00000000 EDX: b984ab5f
[   13.738788] ESI: b70b2000 EDI: 000000ae EBP: fffffffe ESP: bfd60988
[   13.740579] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[   13.742438] CR2: 0000000034ca027e
[   13.743642] ---[ end trace e1fbccf706ef9461 ]---
[   13.745144] EIP: known_siginfo_layout+0x35/0x70

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 771b65e89c8a51d611b8049718693a4202e4f732 0238df646e6224016a45505d2c111a24669ebe21 --
git bisect good bee1c1784c6492d93950701744f1066c567ec398  # 20:39  G     18     0    8   8  Merge remote-tracking branch 'i2c/i2c/for-next'
git bisect good b85fc5b27d65d27b5d67cdeadbf1ddbc740fb3e7  # 20:53  G     18     0   10  10  Merge remote-tracking branch 'iommu/next'
git bisect good 375ee3d4cd804cb24791a10c9a223b13a068e460  # 21:02  G     18     0    7   7  Merge remote-tracking branch 'tty/tty-next'
git bisect  bad 23662bdad2b2f3ff6e1abc891ed70bad0a455d98  # 21:13  B      1     1    0   0  Merge remote-tracking branch 'userns/for-next'
git bisect good 3b63b156e75d1d9010f77d512a7a3bb2f6add86a  # 21:26  G     18     0   10  10  Merge remote-tracking branch 'slave-dma/next'
git bisect good a22163785338b3dab233107c340558f2a132c15c  # 21:35  G     18     0    6   6  Merge remote-tracking branch 'rpmsg/for-next'
git bisect good 6d8099c167641e51d4b561b13c0ae350ffcda0ef  # 21:45  G     18     0   11  11  Merge remote-tracking branch 'gpio/for-next'
git bisect good 973d55984be3c3c65384b7df464d6215aae52ea9  # 21:58  G     17     0    5   5  Merge remote-tracking branch 'pinctrl/for-next'
git bisect good cd60ab7abb3df301c4ff2cf7d619cf7e30cca289  # 22:08  G     18     0    8   8  signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
git bisect good c852680959d0964198e829da80f012b3df43060c  # 22:17  G     18     0    7   7  signal/arm64: Use send_sig_fault where appropriate
git bisect good 5ee527d7cefddebd72970d290e5cc06c9ae32890  # 22:27  G     18     0    8   8  signal/unicore32: Use send_sig_fault where appropriate
git bisect good f28380185193610c716a90ec9b9e696638a495ce  # 22:41  G     18     0   11  11  signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 22:55  G     18     0    6   6  signal: Distinguish between kernel_siginfo and siginfo
git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 23:05  B      2     1    2   2  signal: In sigqueueinfo prefer sig not si_signo
git bisect good 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 00:07  G     27     0   11  11  signal: Use a smaller struct siginfo in the kernel
# first bad commit: [601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0] signal: In sigqueueinfo prefer sig not si_signo
git bisect good 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 00:16  G     83     0   30  41  signal: Use a smaller struct siginfo in the kernel
# extra tests with debug options
git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 00:36  B      6     2    5   5  signal: In sigqueueinfo prefer sig not si_signo
# extra tests on HEAD of linux-next/master
git bisect  bad 771b65e89c8a51d611b8049718693a4202e4f732  # 00:36  B      3     5    0   4  Add linux-next specific files for 20181011
# extra tests on tree/branch userns/siginfo-next
git bisect good a36700589b85443e28170be59fa11c8a104130a5  # 00:50  G     29     0   10  10  signal: Guard against negative signal numbers in copy_siginfo_from_user32
# extra tests with first bad commit reverted
git bisect good c9c9ead64294d0df96006708ba47007624c7b069  # 01:10  G     29     0    9   9  Revert "signal: In sigqueueinfo prefer sig not si_signo"
# extra tests on tree/branch linux-next/master
git bisect  bad 771b65e89c8a51d611b8049718693a4202e4f732  # 01:10  B      3     5    0   4  Add linux-next specific files for 20181011

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--+QwZB9vYiNIzNXIj
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-kbuild-37:20181011230548:i386-randconfig-x0-10111937:4.19.0-rc1-00078-g601d5abf:1.gz"
Content-Transfer-Encoding: base64

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
pKALSVsKQDEIK1oLKMwFAML8Bcs/RAEA

--+QwZB9vYiNIzNXIj
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-yocto-kbuild-10:20181012000937:i386-randconfig-x0-10111937:4.19.0-rc1-00077-g4ce5f9c:1.gz"
Content-Transfer-Encoding: base64

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
wc69mQpjklgoFzYzoSZKXbDLzZnqQpVd9Qm3iRN+GQHZw7IkTN4u2qiwOSkjgUO4EWXVtKt3
3CxVeIXzxKvaSCvxxIJEd9U6JxHFBYInpTWlUnNJJOFKzW4RZhHuEjdYwgNmY1HK8IkgQYKt
gB/pLc9pM0r8y5XqsTS1dDRF3JJ229IbryzB6ueBQI9FhJWSWJSKWRk6KIYgd8ZI3Y9SmGZm
ysLsnOIqIarQVluXXSv+CgkKAlSIsMT8AlO1wtqkIepHL1nren+FZbcOabUf6hpqo8IPBaMW
B0TY1WquapPBFGEVOiTxSewRV5hr6O9SKluLc7UOrd4EWukZ+VWrhap9X5c4HM3xrSniOXLt
sXEHUlGUlY2Wd4ksU5s3VW5shLo7dTddpLEtd9qq3OrynudSEbd3QeuVOyES8sIifZmuvEMf
3120MTR28ZalfXAsY6LicREme/7q8R1UMmZKozrkdld0+VEbX4vIMxY6sBaDuYqzUOHNAuW9
6FiXmUVHTaJzzFLnmKXOMO8Md9ba65HlJtGxbUd2xdQ7OX7/9vTdH+tbslxoyTFGuERnbjpL
dLZZdMzcMEl81l731jB1hiVlv3lnTtvsRPC+5FiYcarMuCY754y710JvWEq34t1dq/P4/MX6
Rhjtul0LeXCuUzPgyZ6lJu5FAJ22eEMMdG39ux178vb06fOTPCxYCN92SnHMeFrhdp5phMLb
KQso1+blIxGfPpFrdQ/mYXaEh9TwmE88lxeEgkudDHQ2BomOUbxA3cK7F3N0bBF2vBmayi0A
U9t/FRuoSYi7SVZSCbA/Zf38MDvbjDrviI1TzyA+yzB1Dd3Zly+P72mDmXU9mVkOMKMLBEBn
cvkiO2tQeBCdQWfM+FAYp86cx2HDKtegxyHRmePdflNnWTDJDKoAQGbSW+PfG3UGJxmiM2h7
JTqDgof4DK46DJNndnPK8re15ibXd1s3/jk1htwGNLybbXiD1yh1wvQG7z7vtRvn3d6+9rAQ
nUF1ZpZ3Ep1Bw7cD3hmmzuAG1A5G1jDv9raz3DOrAjyjgiLRGe6sOf9tF501TJ1Bf0vh29ve
NtyA5dg5uf/6Jt+c2ap2w91bfu/m7Z6334R7zNWbDbUrc1a/Npd7RPWbbtBr3ohwS1qV2k2L
JpX9mpW/hjWqQVv9FSzwDe+OmCbP8GCYs9bf1R7kd0Ud9826xL556ky6db5ZF9s369btgDrT
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
p/3yuL9+f/eyfVjBgnJNKibVbybeROfcxObcxOfcJObcJOfcpOqbrt7/8HjzxdVn7uaacvD6
o1G3Slx9dr3e4au6hkvgw/LpBRa1w4f1w8OX/3h4XD/hz8UT/KXO9FU/q/+FL3A5hVXu7f7g
CF3eOtn1z3NIer2F+f5mef9XuPwRHwX+PTw+VRT+XWE6cl2t0Wn4crc+wucb+IfAn+pPyJr4
/OV2df72bg/uQo2A75Z41f76eY1fwu8fFsflu9X+vtoqTsj6cOd9d42Z0P2uWq3vXu7h++cj
mIfFYX3jAn/US3ya5+0Pawf+38TV8MvH9Wq7cH/8cru5+WH7DI2OuJHOvZHNvZHPvVHMvVHO
vVEN3Qhvfrt4qA7HVd3O9vD0sPgEHuEOX9bjHpRr/1zhroirn19dIVyyW6GCP4M63LwF5Xn7
vHgEpXn3sru/PYKfcus8oRtQvJMaLJ7g4+l3mBHP34P/8WEB62E9HVbQ1vLlaQVT7A38cgvz
Ap0tWP5QYcBrugG9vfoMVPPNdoPO3+EGPj6B2h/fvwH57x8P9zf7HXzl5F6D4MN+c8Tk+ctT
+zC7x+3tWU9v3LdXn+3BBTn//rBfrMDdecQBumEoYP/4dGy+AZGr57vVm8ftbv8MnsTL7nhj
XH9ghq/ePOzvbx/WP6wfbtbPz1efbe93mG2Eb92XV58t9zukI705Hj9BS+vF88Onugf4zX+Q
LymVDHvpXed9+8P94mbnctswVh+uPrsDt2z57uZhu3v5CFP44/EtOIjHNQj+l+++++Ptb//w
z7/55ubt0/v7t+6St2gbruGeFTS/2d5ff4TJAishteBS3S+X1/Ltye+2a40lr6hcSmk3m8Ua
fI21Wmm+sdSs7gh5+8MjNvnX60HXPT5O+IbXz5s3h3cvx9X+ww7GE7Tp85/9N9jCP//TX/7n
8+q6Vq0Kvqt/+/Mv4Our/wUGWG35dJ8CAA==

--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-yocto-kbuild-37:20181011230548:i386-randconfig-x0-10111937:4.19.0-rc1-00078-g601d5abf:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 256
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

--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-4.19.0-rc1-00078-g601d5abf"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.19.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=50401
CONFIG_CLANG_VERSION=0
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
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
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
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
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
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
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
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
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
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
CONFIG_MWINCHIP3D=y
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
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_ANCIENT_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_HIGHPTE=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
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
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
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
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set
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
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_STRUCTLEAK=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
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
# CONFIG_NETLABEL is not set
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
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

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
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

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
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_SCx200_DOCFLASH=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SMC is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
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
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
CONFIG_IDE_GD_ATAPI=y
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y

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
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
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

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
# CONFIG_BLK_DEV_DTC2278 is not set
CONFIG_BLK_DEV_HT6560B=y
CONFIG_BLK_DEV_QD65XX=y
CONFIG_BLK_DEV_UMC8672=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=y
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_GENERIC_NCR5380=y
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_IZIP_EPP16=y
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_QLOGIC_FAS=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_DH is not set
CONFIG_SCSI_OSD_INITIATOR=y
CONFIG_SCSI_OSD_ULD=y
CONFIG_SCSI_OSD_DPRINT_SENSE=1
CONFIG_SCSI_OSD_DEBUG=y
# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_MQ_DEFAULT is not set
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=y
# CONFIG_DM_CACHE_SMQ is not set
CONFIG_DM_WRITECACHE=y
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=y
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=y
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_MACINTOSH_DRIVERS is not set
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
CONFIG_WLAN=y
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
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=y
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_CMA3000=y
# CONFIG_INPUT_CMA3000_I2C is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
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
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=y
CONFIG_DTLK=y
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
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
CONFIG_I2C_DESIGNWARE_SLAVE=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_ELEKTOR=y
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
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
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

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

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
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
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8994=y

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
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=y
# CONFIG_TEST_POWER is not set
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
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LTC3651=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=y
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
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
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
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
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_SYSCON is not set
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8998 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_VIDEO_SH_VEU=y
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIVID=y
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_V4L2_TPG=y

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TVP514X is not set
CONFIG_VIDEO_TVP5150=y
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_SR030PC30 is not set
CONFIG_VIDEO_RJ54N1=y

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_I2C=y

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_TUA9001=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=y
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
# CONFIG_DVB_S5H1420 is not set
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
# CONFIG_DVB_TUNER_CX24113 is not set
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_AF9013=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
# CONFIG_DVB_OR51132 is not set
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LG2160=y
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
CONFIG_DVB_MN88443X=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
# CONFIG_DVB_ISL6421 is not set
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=y
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
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
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
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
CONFIG_FB_HECUBA=y
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set

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
CONFIG_FB_OPENCORES=y
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
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_MDA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# CONFIG_LOGO is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_COUGAR=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
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
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_GOLDFISH is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
# CONFIG_A11Y_BRAILLE_CONSOLE is not set
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
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
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
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_CTL=y
CONFIG_CROS_EC_I2C=y
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
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_TWL6040 is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

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
CONFIG_SOC_TI=y

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
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
CONFIG_BMA180=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD7291=y
# CONFIG_AD799X is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
CONFIG_HX711=y
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=y
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=y
CONFIG_TI_ADC081C=y
CONFIG_TI_AM335X_ADC=y
# CONFIG_TWL4030_MADC is not set
# CONFIG_TWL6030_GPADC is not set

#
# Analog Front Ends
#

#
# Amplifiers
#

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
# CONFIG_VZ89X is not set
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y

#
# IIO dummy driver
#

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
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_SENSORS_HMC5843_I2C is not set

#
# Multiplexers
#

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_IIO_CROS_EC_BARO=y
# CONFIG_HID_SENSOR_PRESS is not set
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y

#
# Lightning sensors
#

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
CONFIG_SRF08=y

#
# Resolver to digital converters
#

#
# Temperature sensors
#
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=y
# CONFIG_NVMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
CONFIG_FPGA_DFL_FME_BRIDGE=y
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
# CONFIG_JFS_STATISTICS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_F2FS_IO_TRACE=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
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
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
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
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
# CONFIG_UFS_DEBUG is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
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
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENABLED=y
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
CONFIG_EVM=y
# CONFIG_EVM_ATTR_FSUUID is not set
CONFIG_EVM_ADD_XATTRS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
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
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=y
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SPECK=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
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
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

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
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
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
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_SBITMAP=y
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
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
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
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_UPROBE_EVENTS is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
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
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--+QwZB9vYiNIzNXIj--
