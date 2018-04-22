Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/S4PihLuDd97LlHXXXh3O0OSlKRJLK+w1SqeF533tE9mjVkcY6Kbo05NVPoa8tBxrjnhkn
ARC-Seal: i=1; a=rsa-sha256; t=1524406713; cv=none;
        d=google.com; s=arc-20160816;
        b=lkhO0YhZyYoq8UflT4yYLqzArqxA7nCo8EM/PORxTmV4ncRIdsijNA9MzD1jbmHMKw
         atfMUYrW3XfSVHCwo3JD0uzN131znfJA6QIkQI/7YgtFHp1tVa6C5IW0HXkZeqMuTlyy
         +o/kFPbw58aULT+HBcT6wMbCDJsbpLT9T7VAs24XpALT1Ntv1Zbn9i4kYkYxZMuAP9Uw
         KsGAdLzalFW9ml1QdAWezeFldi2T4redwBbqnEK3rkfkg2xGTEpdq4o1wzXxlxzw8wVR
         F4Srxa4lGVNWFDJ0yHSsGIUX+E4ocmdxPr6vfcAbnbLmOFsiKmU9cf9OBYKqf13oX8Zm
         8Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J9XwCNV0nUgeO4et8QU0JGO0kiD+z107b/OlwIxorbA=;
        b=tZM8kdecC2l8ma3Z3mdYxSjkVguR3BY6h7wNLQYNstd9B3vK/qRknK5Ti4cJKah4EY
         lqG8rk4pVMANAc+7dqocM2BHGem1DnmbeFKn/StIvokvNT36FefxDAPpTr7wII3B5dTl
         w5xGNtqHH52WdjWxRYXw4xDjI4GYCWIuAAygUrisfqCDMHRmhC56je5YdlMZm72XlIKJ
         SosATKBdaa3drNUqed1BrRruWj8NYT0YlM7ZMcLQwZZtpkJatXlVXRhFXhbLD5o6ESgZ
         iGF+BDEAMRxqhEhv87EO7z7gKfohQ/1FVRipyZ76usldZWWAKV5MDSY5nM48SHP90eJY
         fbCA==
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
Subject: [PATCH 4.4 41/97] powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
Date: Sun, 22 Apr 2018 15:53:19 +0200
Message-Id: <20180422135307.618429646@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454950836257463?=
X-GMAIL-MSGID: =?utf-8?q?1598456294347566296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -36,7 +36,8 @@
 
 #define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); mb(); } while (0)
 
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
