Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aWW/C1WZkRQYtQ3G2To0vqwx3u9CapVLzrvf7iGS3TefMeqGJQiw5WkfpVH2ereSBEH3e
ARC-Seal: i=1; a=rsa-sha256; t=1524405941; cv=none;
        d=google.com; s=arc-20160816;
        b=BLnBbqJB4394I5w48bimm2qN0PC7OWwiFIZEwRSBAMg8u1vEwktTV5xk2YMsiRPBSH
         o60DHj8LZMD6pZO4cGA3iR2qRfL44nXSpquKl0Nl4ig4DnhrNRgaUkwlc0UJiRvN4PnG
         vk0PxNXeFN2bTZ3bFusZSL42cJMtI6TpXoJa/bAoy1ayiMojxuJ/p4ou+jhSV2YjoDGO
         bv6gNWpCb4KCcp715wZr02Ke1n4mdxXTMhoI47XvmK3Q+7qEW8YqRpu0m/PbY5EayEpY
         K+VS9gTerXe1fQbKF5Ys+XOzilQSnjfFLvQwWZL8USzUhXPJIR2DUgAyGt4MBco9GFae
         Gj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PvL1OFgzPq4xKRKop872SNy8uFRMivrFiVK1RNmL7Lg=;
        b=oo8RUnwBq93SRJGOt/vPgjsJ9fvdCRgSReVHiorUK3jaiPSsleyVYGjmw/oQB/EWw2
         Iw+R8p5RwN6kdNUJxSnrpSLBXZm5/krTTJkmX7zZt2DUTmfg4Yzj8kky/thxRlUZrBUB
         QM3owUh93wjbb7EMmlenwyyaIKGgtgUN8BYne7cNnsa2lgEJw6FX+LYTVCb4oWatsS4U
         8zPrhmzBhVaG+d4P4e3pUpERADdvTBf7gFUdmcklhimwUYNfYA+12csBHM8QigEWxBDy
         UvGF6qcZXxOhWc6C3iNVWyyljZtpEeZHIsFx6lQPNE0jF4ghyolWUyYR4LvgsI2H/RMX
         /eLw==
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
Subject: [PATCH 4.14 054/164] powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
Date: Sun, 22 Apr 2018 15:52:01 +0200
Message-Id: <20180422135137.633344973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454950836257463?=
X-GMAIL-MSGID: =?utf-8?q?1598455484357725024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
