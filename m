Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49PZpzqUpBVYvcfMkSWra6RoF8nWqnhq+mtNUiH+oOe/yzS9plnphC3hr7gbP6+8NpIR+0X
ARC-Seal: i=1; a=rsa-sha256; t=1524405432; cv=none;
        d=google.com; s=arc-20160816;
        b=HDkWU9sh4QyZm2/z8S8nLPEBCPkEBKs8Uop4/rFsYAnaccbRvOeGTrj1fJLLbSkqzr
         la4AaS2fjWlgw0j1zpvyoyskK8Th6WRm5031QCeKfFomiorccrAtWgx4uqw4XQf40QYe
         rrO7x85yRx/euelaaWkLpAqRpzyLnCc6TZbq2pZeJi2orIbZZG47UkAGIqT1MdjiSd17
         Gi5vbuwVLn8rFFE5pU9UyDT3Gl7MPC/j1lDmb1Rhy3HwHLRfBPcO1g/bDu1Ou4B4fMvJ
         iGLXhdMblD0HXJZ3P/ZWv2hQX5FNdexqYBoSL54IGysoBKnhbsJhSyeTnI56T8tKhHls
         zY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QwyF3ewVRaa+jeW1fDfAXPRRvGtRpQF9o8IBzszL85c=;
        b=BHzOXbMmWUxNdGqmv4lV3GNAmoKd+msGJcYXzuat/ZzRxFm38DI0MVMe1/SDUioUrF
         aZeJPk7bVzPsjsKj8flAHMS7arxojjr5cABvT5/bj+pQUCsDQ1z5pF3eG3c/Tjz4vUMb
         GAarEGLEocyzYLK7ImI9maYt2HfOvk/MSiAgdoaRWw2QMxeIKHqLKD34ePP8nJsgva3z
         JreEGlh5yzUs0YK0LL8ccmkGICshrGme2HjgA38wVGoi/gF05u/rP9a5aYsgpMTWOBwi
         Kz7LMBq8MmhIwxVvjvKTuIFX8kYaRPjA9aiyZSmdT4lK9ZjF1Zl3TbOgY7Ici9SXhYYR
         gxbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 064/196] powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
Date: Sun, 22 Apr 2018 15:51:24 +0200
Message-Id: <20180422135107.564389226@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454950836257463?=
X-GMAIL-MSGID: =?utf-8?q?1598454950836257463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 0bfdf598900fd62869659f360d3387ed80eb71cf upstream.

asm/barrier.h is not always included after asm/synch.h, which meant
it was missing __SUBARCH_HAS_LWSYNC, so in some files smp_wmb() would
be eieio when it should be lwsync. kernel/time/hrtimer.c is one case.

__SUBARCH_HAS_LWSYNC is only used in one place, so just fold it in
to where it's used. Previously with my small simulator config, 377
instances of eieio in the tree. After this patch there are 55.

Fixes: 46d075be585e ("powerpc: Optimise smp_wmb")
Cc: stable@vger.kernel.org # v2.6.29+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/barrier.h |    3 ++-
 arch/powerpc/include/asm/synch.h   |    4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -35,7 +35,8 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#ifdef __SUBARCH_HAS_LWSYNC
+/* The sub-arch has lwsync */
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
 #    define SMPWMB      LWSYNC
 #else
 #    define SMPWMB      eieio
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -6,10 +6,6 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 
-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
-#define __SUBARCH_HAS_LWSYNC
-#endif
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
