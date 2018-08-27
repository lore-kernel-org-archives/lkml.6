Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B88208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B88208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeH0Xds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeH0Xdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LrsLe-1fnKv649vS-013fan; Mon, 27 Aug 2018 21:45:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/14] y2038: Change sys_utimensat() to use __kernel_timespec
Date:   Mon, 27 Aug 2018 21:45:26 +0200
Message-Id: <20180827194531.3796559-10-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:1qFKP/S7PvEA3HGD/4Qil6EAAqGJOKrgU2K9WNFrsWxBv9b6Q0D
 yYM7i59XcgAykwlLnhg08OtGr1cj409eIHpZMBTy0E7PgCktsEx6ZrD+e1PgXyCPr77haTj
 K5GGYfJLeo+g7ahQpTBdteZmDgAwyXZqtzTiIRf8M754nT8GRk4MEZzZGeaJnUBxjnEwDEl
 vkT7XDbZHei0fnN8oCI/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HZsGQAdmNqU=:Xig2Cyx/76WH5+gacDPcEs
 1qOjGEr+CkA3fQ3xBS1Cq0cyTrNvmqvJVXcRObhCFLQjWDwuEOmTo2HbIVUOM0hnnEjzYaXsI
 eyZEJNOs4msPq9C64ypqRN30fmhcsD5EkbXt8kOOjD/ONME10+4I4XDHzO1ASUKZu0RSWx3Uq
 m/DZxWvZZXfV/LGQT2kIVTDvRB2Z/knUwRnVUXntKVylqrR83sP7u4c/8TVsDfRSiNuJEYLoM
 njp0TRTJd7UahF2if6HioBG+HVbjYuHqdE8akUmy+wf+ouET49d/WDPMUM+nWi8BDmDzaB4gO
 C01CoTW7jdNA6J1v+eRzfTfRBWAZnqBDpE3C33d77IgW5pFfPO45C7Y4BnCUR2h1pxmoONS//
 D2VCKrn71adJMT8rAr87x1IHzVwUuVoen9f/iHXVbBokdzeabsIRI+h+TJMV8pKW2EiTxgUT1
 zHRYWuXAQZMuOg8KrY/6b4igBWgg4dmV+2Fs2F5QeqapEBWQJUGfwOfSwpeahBQ6nhgtVbU0G
 8Hh7tn2WRlG09+eNd+OFUbfWhSrEdzV/X2mfbSrmIcBznVzXJ+p3JD3Fpe64BPD11Lnmxs0Vk
 LdaRv3Wa/zdlKsp9bjwyJQxj7pOg8qEu9eHotj2VRZDnY+c/y5XFRrfB/5hAc3hOF8JSuDbin
 cfMqcHIG4C8BqcOUaeLSo0oYb3Dr47zZ4VWM85fwQGR/HmKeWnriIiAH/NT7gwsbWLg4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 32-bit architectures get changed to support 64-bit time_t,
utimensat() needs to use the new __kernel_timespec structure as its
argument.

The older utime(), utimes() and futimesat() system calls don't need a
corresponding change as they are no longer used on C libraries that have
64-bit time support.

As we do for the other syscalls that have timespec arguments, we reuse
the 'compat' syscall entry points to implement the traditional four
interfaces, and only leave the new utimensat() as a native handler,
so that the same code gets used on both 32-bit and 64-bit kernels
on each syscall.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/utimes.c              | 2 +-
 include/linux/syscalls.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 79a65c163f40..d30f409ecc1a 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -166,7 +166,7 @@ long do_utimes(int dfd, const char __user *filename, struct timespec64 *times,
 }
 
 SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
-		struct timespec __user *, utimes, int, flags)
+		struct __kernel_timespec __user *, utimes, int, flags)
 {
 	struct timespec64 tstimes[2];
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b3e27e5ee322..420ac881a610 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -513,7 +513,8 @@ asmlinkage long sys_timerfd_gettime(int ufd, struct __kernel_itimerspec __user *
 
 /* fs/utimes.c */
 asmlinkage long sys_utimensat(int dfd, const char __user *filename,
-				struct timespec __user *utimes, int flags);
+				struct __kernel_timespec __user *utimes,
+				int flags);
 
 /* kernel/acct.c */
 asmlinkage long sys_acct(const char __user *name);
-- 
2.18.0

