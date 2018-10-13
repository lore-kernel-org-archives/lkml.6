Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A4BC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004E820868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 00:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004E820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJMHn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 03:43:29 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59419 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJMHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 03:43:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gB7Tw-00077J-J1; Fri, 12 Oct 2018 18:08:36 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gB7Tu-0000cn-H6; Fri, 12 Oct 2018 18:08:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20181012085450.GK13396@shao2-debian>
Date:   Fri, 12 Oct 2018 19:08:22 -0500
In-Reply-To: <20181012085450.GK13396@shao2-debian> (kernel test robot's
        message of "Fri, 12 Oct 2018 16:54:50 +0800")
Message-ID: <871s8ur9mx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gB7Tu-0000cn-H6;;;mid=<871s8ur9mx.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18cov5cPIjOn6C/1IKYXf1UkLoZ+k0rxcg=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [LKP] 601d5abfea [ 13.686356] BUG: unable to handle kernel paging request at 34ca027e
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> writes:

> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-next
>

This is an odd one.  This is the first time I recall the lkp test robot
emailing me and telling me that I have fixed an issue.  I don't mind I
am just a little surprised.

Recently it was discovered that on my branch passing a large negative signal
number to rt_sigqueueinfo could cause an oops.  The underlying issues
were fixed by:

b2a2ab527d6d ("signal: Guard against negative signal numbers in copy_siginfo_from_user")
a36700589b85 ("signal: Guard against negative signal numbers in copy_siginfo_from_user32")

It appears that this issue was found in linux-next before these fixes
were applied.  And then the top of my siginfo-next branch where these
fixes exist was tested.

I have not problem with that sequence of events it is just a little
surprising.

If I have not read this test report correctly please let me know.

Eric

> commit 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0
> Author:     Eric W. Biederman <ebiederm@xmission.com>
> AuthorDate: Fri Oct 5 09:02:48 2018 +0200
> Commit:     Eric W. Biederman <ebiederm@xmission.com>
> CommitDate: Mon Oct 8 09:35:26 2018 +0200
>
>     signal: In sigqueueinfo prefer sig not si_signo
>     
>     Andrei Vagin <avagin@gmail.com> reported:
>     
>     > Accoding to the man page, the user should not set si_signo, it has to be set
>     > by kernel.
>     >
>     > $ man 2 rt_sigqueueinfo
>     >
>     >     The uinfo argument specifies the data to accompany  the  signal.   This
>     >        argument  is  a  pointer to a structure of type siginfo_t, described in
>     >        sigaction(2) (and defined  by  including  <sigaction.h>).   The  caller
>     >        should set the following fields in this structure:
>     >
>     >        si_code
>     >               This  must  be  one of the SI_* codes in the Linux kernel source
>     >               file include/asm-generic/siginfo.h, with  the  restriction  that
>     >               the  code  must  be  negative (i.e., cannot be SI_USER, which is
>     >               used by the kernel to indicate a signal  sent  by  kill(2))  and
>     >               cannot  (since  Linux  2.6.39) be SI_TKILL (which is used by the
>     >               kernel to indicate a signal sent using tgkill(2)).
>     >
>     >        si_pid This should be set to a process ID, typically the process ID  of
>     >               the sender.
>     >
>     >        si_uid This  should  be set to a user ID, typically the real user ID of
>     >               the sender.
>     >
>     >        si_value
>     >               This field contains the user data to accompany the signal.   For
>     >               more information, see the description of the last (union sigval)
>     >               argument of sigqueue(3).
>     >
>     >        Internally, the kernel sets the si_signo field to the  value  specified
>     >        in  sig,  so that the receiver of the signal can also obtain the signal
>     >        number via that field.
>     >
>     > On Tue, Sep 25, 2018 at 07:19:02PM +0200, Eric W. Biederman wrote:
>     >>
>     >> If there is some application that calls sigqueueinfo directly that has
>     >> a problem with this added sanity check we can revisit this when we see
>     >> what kind of crazy that application is doing.
>     >
>     >
>     > I already know two "applications" ;)
>     >
>     > https://github.com/torvalds/linux/blob/master/tools/testing/selftests/ptrace/peeksiginfo.c
>     > https://github.com/checkpoint-restore/criu/blob/master/test/zdtm/static/sigpending.c
>     >
>     > Disclaimer: I'm the author of both of them.
>     
>     Looking at the kernel code the historical behavior has alwasy been to prefer
>     the signal number passed in by the kernel.
>     
>     So sigh.  Implmenet __copy_siginfo_from_user and __copy_siginfo_from_user32 to
>     take that signal number and prefer it.  The user of ptrace will still
>     use copy_siginfo_from_user and copy_siginfo_from_user32 as they do not and
>     never have had a signal number there.
>     
>     Luckily this change has never made it farther than linux-next.
>     
>     Fixes: e75dc036c445 ("signal: Fail sigqueueinfo if si_signo != sig")
>     Reported-by: Andrei Vagin <avagin@gmail.com>
>     Tested-by: Andrei Vagin <avagin@gmail.com>
>     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> 4ce5f9c9e7  signal: Use a smaller struct siginfo in the kernel
> 601d5abfea  signal: In sigqueueinfo prefer sig not si_signo
> a36700589b  signal: Guard against negative signal numbers in copy_siginfo_from_user32
> 771b65e89c  Add linux-next specific files for 20181011
> +------------------------------------------+------------+------------+------------+---------------+
> |                                          | 4ce5f9c9e7 | 601d5abfea | a36700589b | next-20181011 |
> +------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                           | 56         | 16         | 27         | 8             |
> | boot_failures                            | 5          | 3          | 1          | 6             |
> | EIP:__copy_user_ll                       | 1          |            |            |               |
> | Mem-Info                                 | 1          | 1          | 1          | 1             |
> | BUG:unable_to_handle_kernel              | 3          | 2          | 0          | 2             |
> | Oops:#[##]                               | 4          | 2          | 0          | 5             |
> | EIP:copy_siginfo_from_user               | 4          |            |            |               |
> | Kernel_panic-not_syncing:Fatal_exception | 4          | 2          | 0          | 5             |
> | EIP:known_siginfo_layout                 | 0          | 2          | 0          | 5             |
> +------------------------------------------+------------+------------+------------+---------------+
>
> [child3:558] migrate_pages (294) returned ENOSYS, marking as inactive.
> [child3:558] mq_open (277) returned ENOSYS, marking as inactive.
> [child3:558] pkey_free (382) returned ENOSYS, marking as inactive.
> [child2:557] uselib (86) returned ENOSYS, marking as inactive.
> [child0:555] mq_timedreceive (280) returned ENOSYS, marking as inactive.
> [   13.686356] BUG: unable to handle kernel paging request at 34ca027e
> [   13.688081] *pdpt = 000000000c7ab001 *pde = 0000000000000000 
> [   13.697660] Oops: 0000 [#1]
> [   13.698554] CPU: 0 PID: 555 Comm: trinity-c0 Tainted: G                T 4.19.0-rc1-00078-g601d5abf #1
> [   13.700926] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   13.707252] EIP: known_siginfo_layout+0x35/0x70
> [   13.708468] Code: 80 00 00 00 74 37 85 d2 7e 3b 83 f8 1f 7e 0e 83 fa 06 0f 9e c0 5b 5d c3 90 8d 74 26 00 8d 48 ff bb d8 04 01 50 0f a3 cb 73 e5 <0f> b6 84 00 c0 ab c0 c1 5b 5d 39 c2 0f 9e c0 c3 8d 76 00 b8 01 00
> [   13.713020] EAX: b984ab5f EBX: 500104d8 ECX: b984ab5e EDX: 000010e0
> [   13.714608] ESI: b984ab5f EDI: b70b2000 EBP: cc7b3f38 ESP: cc7b3f34
> [   13.716177] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010283
> [   13.717871] CR0: 80050033 CR2: 34ca027e CR3: 0c665560 CR4: 000406f0
> [   13.719461] DR0: b72b2000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   13.721066] DR6: ffff0ff0 DR7: 00000600
> [   13.722200] Call Trace:
> [   13.723069]  __copy_siginfo_from_user+0x2f/0x60
> [   13.724361]  sys_rt_tgsigqueueinfo+0x36/0x90
> [   13.729191]  do_int80_syscall_32+0x4f/0xe0
> [   13.730392]  entry_INT80_32+0xda/0xda
> [   13.731494] EIP: 0x809af42
> [   13.732413] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 ec bd a7 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 14 be a7 08 85
> [   13.737100] EAX: ffffffda EBX: 7552a122 ECX: 00000000 EDX: b984ab5f
> [   13.738788] ESI: b70b2000 EDI: 000000ae EBP: fffffffe ESP: bfd60988
> [   13.740579] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> [   13.742438] CR2: 0000000034ca027e
> [   13.743642] ---[ end trace e1fbccf706ef9461 ]---
> [   13.745144] EIP: known_siginfo_layout+0x35/0x70
>
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 771b65e89c8a51d611b8049718693a4202e4f732 0238df646e6224016a45505d2c111a24669ebe21 --
> git bisect good bee1c1784c6492d93950701744f1066c567ec398  # 20:39  G     18     0    8   8  Merge remote-tracking branch 'i2c/i2c/for-next'
> git bisect good b85fc5b27d65d27b5d67cdeadbf1ddbc740fb3e7  # 20:53  G     18     0   10  10  Merge remote-tracking branch 'iommu/next'
> git bisect good 375ee3d4cd804cb24791a10c9a223b13a068e460  # 21:02  G     18     0    7   7  Merge remote-tracking branch 'tty/tty-next'
> git bisect  bad 23662bdad2b2f3ff6e1abc891ed70bad0a455d98  # 21:13  B      1     1    0   0  Merge remote-tracking branch 'userns/for-next'
> git bisect good 3b63b156e75d1d9010f77d512a7a3bb2f6add86a  # 21:26  G     18     0   10  10  Merge remote-tracking branch 'slave-dma/next'
> git bisect good a22163785338b3dab233107c340558f2a132c15c  # 21:35  G     18     0    6   6  Merge remote-tracking branch 'rpmsg/for-next'
> git bisect good 6d8099c167641e51d4b561b13c0ae350ffcda0ef  # 21:45  G     18     0   11  11  Merge remote-tracking branch 'gpio/for-next'
> git bisect good 973d55984be3c3c65384b7df464d6215aae52ea9  # 21:58  G     17     0    5   5  Merge remote-tracking branch 'pinctrl/for-next'
> git bisect good cd60ab7abb3df301c4ff2cf7d619cf7e30cca289  # 22:08  G     18     0    8   8  signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
> git bisect good c852680959d0964198e829da80f012b3df43060c  # 22:17  G     18     0    7   7  signal/arm64: Use send_sig_fault where appropriate
> git bisect good 5ee527d7cefddebd72970d290e5cc06c9ae32890  # 22:27  G     18     0    8   8  signal/unicore32: Use send_sig_fault where appropriate
> git bisect good f28380185193610c716a90ec9b9e696638a495ce  # 22:41  G     18     0   11  11  signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
> git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 22:55  G     18     0    6   6  signal: Distinguish between kernel_siginfo and siginfo
> git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 23:05  B      2     1    2   2  signal: In sigqueueinfo prefer sig not si_signo
> git bisect good 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 00:07  G     27     0   11  11  signal: Use a smaller struct siginfo in the kernel
> # first bad commit: [601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0] signal: In sigqueueinfo prefer sig not si_signo
> git bisect good 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 00:16  G     83     0   30  41  signal: Use a smaller struct siginfo in the kernel
> # extra tests with debug options
> git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 00:36  B      6     2    5   5  signal: In sigqueueinfo prefer sig not si_signo
> # extra tests on HEAD of linux-next/master
> git bisect  bad 771b65e89c8a51d611b8049718693a4202e4f732  # 00:36  B      3     5    0   4  Add linux-next specific files for 20181011
> # extra tests on tree/branch userns/siginfo-next
> git bisect good a36700589b85443e28170be59fa11c8a104130a5  # 00:50  G     29     0   10  10  signal: Guard against negative signal numbers in copy_siginfo_from_user32
> # extra tests with first bad commit reverted
> git bisect good c9c9ead64294d0df96006708ba47007624c7b069  # 01:10  G     29     0    9   9  Revert "signal: In sigqueueinfo prefer sig not si_signo"
> # extra tests on tree/branch linux-next/master
> git bisect  bad 771b65e89c8a51d611b8049718693a4202e4f732  # 01:10  B      3     5    0   4  Add linux-next specific files for 20181011
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
