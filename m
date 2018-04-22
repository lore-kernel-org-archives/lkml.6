Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/eywxLHQjs386Z6+lYyxFkGcU2M7LNJiYu2GN+9i05Bgck44XxohCU/Pao4ehKbkkW0WJp
ARC-Seal: i=1; a=rsa-sha256; t=1524406851; cv=none;
        d=google.com; s=arc-20160816;
        b=cDQyKIIkxY9YTmeWnWIP0ymjSFpqA+ptr3YNmIPYALBM9R9AKsJxKFN3vr6RJ5XEXj
         YndUTjvFm/2zpbZQBvjSaR20lzRa6eDSbufRXpdfM28Iht281vOxcZMYKG4sxbMFrL9y
         uiGXtvUEUAHZ9h1osdxfU5werHKtqerlIBkBz1TPf4vw77t8QvL4vHir9XONzovYGTHp
         OArcs07lV7JX6sRt/aIbKMOgegN5Pe883DytLIu3gdeyusWwqjvEeJ3vHpgzVyfeonV1
         kZW2iV7w0d1/KLNfOGYmer/lXszHLPGM5fV/6lKBtMPno8tKHH+fQXueYeHReLLjjTEX
         XI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yrGaBNdCqMvhhnQY11f2fuOM85E56wZkGXrW/v1/pno=;
        b=P0tlYTWyUQgDmqlSWgc+LUIz749KaodZ5+y2/uxDaVD/cjWzopchM3MvWiZsBsob3i
         heUN3oRxuBSDDucJlVo6LIfmdgjz9GHyvoMWtkcB+MldxUajfzlqcdiB8BuHKS3VytSO
         U8Avv8mcposhXPluYSxz6Eqp81zFkK6+6d8dQd3H/oMoWRAMDeD4oGVtEZbP66P4nH3b
         wnD6gLYiW7HPLvciiv1HG60vtL657iFgD7zsLFNVVRouRa1Liyx/uX6SoKxokEgewQUV
         ix3ZDcaMbb1DYCKXRFB6Qck2dw5/2JYCRMeB46IEzHW8or2B8hnWJuU0y7dSdci/8WQu
         HgYw==
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
Subject: [PATCH 3.18 20/52] powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
Date: Sun, 22 Apr 2018 15:53:53 +0200
Message-Id: <20180422135316.202528017@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454950836257463?=
X-GMAIL-MSGID: =?utf-8?q?1598456437798073868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -39,7 +39,8 @@
 
 #ifdef CONFIG_SMP
 
-#ifdef __SUBARCH_HAS_LWSYNC
+/* The sub-arch has lwsync */
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
 #    define SMPWMB      LWSYNC
 #else
 #    define SMPWMB      eieio
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -5,10 +5,6 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 
-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
-#define __SUBARCH_HAS_LWSYNC
-#endif
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
