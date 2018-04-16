Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeDPI4i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:56:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:42337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754220AbeDPI4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:56:36 -0400
From: Philipp Klocke <Phil_K97@gmx.de>
Cc: lukas.bulwahn@gmail.com, kernelnewbies@kernelnewbies.org,
        llvmlinux@lists.linuxfoundation.org, sil2review@lists.osadl.org,
        der.herr@hofr.at, Philipp Klocke <Phil_K97@gmx.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG case
Date: Mon, 16 Apr 2018 10:54:26 +0200
Message-Id: <20180416085426.24157-1-Phil_K97@gmx.de>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:oqRPR7XW5sUpNEF0rDxY7wCQ06TqGEsFBmC87ZQj66IPSM+vz5h
 Tdufziqn7fBBdhR+0OxKb3uXuQp8gvm1P13Yqye+rpG21jDIackxj81A/V8yECeOPisk1fy
 +m1AJXUS+LyWCgVVaZzFhzykp5TfvQWTRFovQoQ0BCXGzc7rn1vWaYyiwaBInNrN8ULapr4
 uhuXQ+I/5PdKLYRkPDk0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:52G+uO7SZdw=:WO0Y14+W2glrH7zzIzTOVN
 8SFvar4bSme9gKIh7uEm9voRitrIP3pEL8fXOUtD9kKQC1mrSewqNga0OngFwNUb/p/SQaXLj
 uLZYWbByLvWG7UFX4xQKkgg38h/LcNxt9XwF5JYwbVQHXV9/JWsDPJ2vJRqryDh1faNSYTi8Q
 uF1J0MBLcljJWp7gveZiN0TaMyejUFyi8iwyPPojzv9W2FGoK6Zkj0o/Twp9lVMxcWrfvc1Vw
 29S4f8+cklpy3v6cOHuGFezX8171y3CewbsFXuF2tFHL+9l5L9WN/BIes3fgxg17bowmqhjWf
 0pJ+D9Gbl0/ASwTPjzCz4DxCg1MtVrcCXyTDRkcUH0ncXfY8eSzgqw9Mn/cJJspqxMH/bum62
 C/Y6HDbwSjjbphUY40USrkTsVtnTHRJWhMiuT+fEhebazuiTRoIqd0bLFWNANUv3z6z5AVRnd
 yuYWqdVdy2XNp6bTVc6Cp7Drj7sEB3E1WsLRLhhefBIqVHame8C0/VxJf5qQdZXzyU7Qamg1s
 7OrYclz/HGtVJBA3GUpqqKN+80hSk/rKQi2X2qXeuJFRaJt/uoDoAQobQfRtJK/AcMeANTFqW
 VDa1/9O4xyB9dh91uG486NzXl4gc/8uiAlnDbSzpB12iJ1Zb+kfaoxZa7kd34EaUUNI/QJPvg
 J5ONzoGYfouqMpyKkaRKL7yVu0bD+7VDzlSSfLlXG9oGXrhuXpwc2/Aq0B7mBWqRAq1k0/1yu
 lAbftKnW26M28D8HMXaH/m1HY3Vs/ZSIKDtXhVo03xbhOANX98sKirpagU/Hl+fM2vviH6Qhd
 ZH/saf/8pxIxTTqn7myEY7ALl+iOQ==
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sched_feat(x) return 1 or 0 instead of 2**x or 0 when
sysctl_sched_features is constant, by changing the left shift of the
mask-bit to a right shift of the bitmap. The behaviour of the code
remains unchanged.
We prove this by showing that the compiler can evaluate this shift
during compile time, which results in generating the same
machine code as before.

This patch is motivated by the clang warning Wconstant-logical-operand,
issued when logically comparing a variable to a constant integer that is
neither 1 nor 0.  It happens for sched_feat(x) when sysctl_sched_features
is constant, i.e., CONFIG_SCHED_DEBUG is not set.

kernel/sched/fair.c:3927:14: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
        if (initial && sched_feat(START_DEBIT))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~
kernel/sched/fair.c:3927:14: note: use '&' for a bitwise operation
        if (initial && sched_feat(START_DEBIT))
                    ^~
                    &
kernel/sched/fair.c:3927:14: note: remove constant to silence this warning
        if (initial && sched_feat(START_DEBIT))
                   ~^~~~~~~~~~~~~~~~~~~~~~~~~~

This resolves the warning, leaves the code base largely as is.

Tested with gcc 7.3.1 and clang 6.0.0 on x86_64, comparing resulting
binaries with diff.
Applicable to all modern compilers and architectures

Signed-off-by: Philipp Klocke <Phil_K97@gmx.de>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/sched/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fb5fc458547f..d2aedee6ab0f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1305,7 +1305,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 	0;
 #undef SCHED_FEAT
 
+#ifdef CONFIG_SCHED_DEBUG
 #define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+#else
+#define sched_feat(x) ((sysctl_sched_features >> __SCHED_FEAT_##x) & 1UL)
+#endif
 
 #endif /* SCHED_DEBUG && HAVE_JUMP_LABEL */
 
-- 
2.17.0
