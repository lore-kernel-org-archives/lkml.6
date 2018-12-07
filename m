Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58532C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1876520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1876520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGVST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:18:19 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:18:18 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRCFw-1gsQha2feG-00N6Nc; Fri, 07 Dec 2018 22:18:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] y2038: further system call conversion
Date:   Fri,  7 Dec 2018 22:18:03 +0100
Message-Id: <20181207211808.328719-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:WtmCK3UEOoJzxEJWcuGDMKztAdONV8QvhxHOw9a57WHFouszm8p
 6hEkjhPNCI9LokEdYw9strDVUbHirIoxha0aEvnb991EeyHnVQyJU9MfgI7LtfjyCiz9Svp
 s0tVsZKX/JxgPLKoEg1gTcutRw0w9yKuLLwLH4EwJG1GvZoHL+fgZUNJ5BVLrcuvLM2FBOi
 rzhKIc2spK6NHUNwc+FhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cMEFwcc1ViI=:n8WQtPswYgxOGCGco5Bbfn
 1cW7ofScS8QI4q2mFX8glqguPH426EFb6BF3pXPKZtQAftvs0L4NO/CVClaoAj/AqMEO644yF
 bu4h4uWCQB46fAqpwXEMAcMp795VoiCwVuXDuCu1kCraDjAeyOu4azG8Emd4Cnr/N81Q0sw7v
 TTPZaWHKtW94HiTwkWLQKWUP8dmGP2McvZuTsj6hEpGR6c7tCg0QVrG3QAX6NH9Ms7xMXDPFM
 +JHvKjLU9EzMB+hzShRetklL2DUKk+UwiCU1YQkm/AkWdqHTMPNaeJlD06wzQ+hMScaj8jUgZ
 Pu/s55MEdnZ5H8O9csCdIgHSl8zwYRAv9+x4UPkFMFHABcA/YtBTmQzmkPFlUR9ue8wPppPbE
 GDbLspkqDYgVovA1xzr8nfamDoMFqevBIYW8ZVk4zWVFQHiqewwyQffhlpRad6jrZbSR8WkYD
 TB4ugvCDu0Y5aY4lpwFOljveBqj9KlsUZSKEzvUSUD3lvnCLFyBRaEYf0t73sNscGmYaX0RGd
 VioghNLj99Czs0UuSXU3rD2x1gz0023og0XhA31zXMfYPoa23LQ0wcrYUWttlXRgPivGhG3iL
 XmCE7AudwUaRlS06+ug2pzAduCNOf1pRcSTZmjGkpuQanRZhf7KDQ/JDOdDsPXjQG3azao3nf
 EWy9t+wOvxwSk4+LEd+SZx2elmiq0Os3o8ws1VDb0B+TAfibpIixioU9XqRjvKSQNgL64+XZa
 /Ct5SaRcZJtIsD9HV/160KXPBiHfert2oTut5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another set of system call changes that were intended to get
merged much earlier. I've rebased the patches on top of the latest kernel
and Deepa's poll/select/io_pgetevents series now, and applied it to the
same y2038 branch for inclusion in 4.21.

This is just a continuation of the earlier system call changes, so I
expect no surprises here, unless I made a mistake in the rebase.

After this series, the only remaining system calls that need to be
modified are:

- setsockopt/getsockopt, they do not need a new entry in the system
  call table, only new numbers assigned for their socket options.
  Deepa is finalizing her series to passing 64-bit timestamps in cmsg
  correctly for SO_TIMESTAMP{,NS,ING}.
  Further, we need a new SO_RCVTIMEO/SO_SNDTIMEO implementation
  here, which has not been implemented yet.

- waitid/getrusage, this needs a rewrite now from earlier versions
  based on recent feedback. The plan now is to incorporate nanosecond
  timestamps in a new revision of the 'rusage' structure. Possibly also
  include BSD wait6() semantics of passing back the child resource
  usage in waitid(), and/or a method to pass a signal mask as in
  io_pgetevents().  waitid/getrusage() are not required for correct
  behavior with 64-bit time_t and can be safely emulated on top of
  the existing syscalls by the C library beyond 2038.  This needs more
  discussion.

- clock_adjtime, this is also optional and can be implemented
  by the C library if necessary. The plan is to do the same as x32
  and use the 64-bit structure natively on both 32-bit and 64-bit
  architectures. The timex structure contains a 'timeval' at the
  moment, but also supports nanoseconds passed in it. 

- getitimer/setitimer, these again can be trivially emulated
  by the C library.

	Arnd

Arnd Bergmann (5):
  y2038: futex: Move compat implementation into futex.c
  y2038: futex: Add support for __kernel_timespec
  y2038: socket: Add compat_sys_recvmmsg_time64
  y2038: signal: Add sys_rt_sigtimedwait_time32
  y2038: signal: Add compat_sys_rt_sigtimedwait_time64

 include/linux/compat.h   |   8 +-
 include/linux/futex.h    |   8 --
 include/linux/socket.h   |   9 +-
 include/linux/syscalls.h |   9 +-
 kernel/Makefile          |   3 -
 kernel/futex.c           | 207 +++++++++++++++++++++++++++++++++++++--
 kernel/futex_compat.c    | 202 --------------------------------------
 kernel/signal.c          |  65 ++++++++++++
 kernel/sys_ni.c          |   2 +
 net/compat.c             |  34 +++----
 net/socket.c             |  62 +++++++++---
 11 files changed, 345 insertions(+), 264 deletions(-)
 delete mode 100644 kernel/futex_compat.c

-- 
2.18.0

