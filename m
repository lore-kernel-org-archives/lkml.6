Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224WbeoGdsbXegfypRfFDW03xrEFM7inJSJd8D3pdD1ss7a3lcCd8TwORWFTtWA3zC/SzK3f
ARC-Seal: i=1; a=rsa-sha256; t=1517855203; cv=none;
        d=google.com; s=arc-20160816;
        b=S2FIm03vjdJC/KsijyqJwTV9Vjjdczltl832PiMMQux1NQiHoaLee32pDJxV44/p7f
         m3l0d6CTFRIcu6A2XzxCh313hMC2cTRrbN6a00gNqGNXD53+NejynnKiOu1sRwtjUXL5
         fnIZ7zf1PIAWACg5gzEF1VmzkZfvCKLhdnZAqmkvIyN4a5u8YlEfft7v0v/UWahjLIdf
         Q9Rzk/+CvPr50W2W17ZnMbJi7/wsfscNWkaBDHq8jg+8UQGzceNtJ6/nnQv0qWH4uXR+
         vHE8OthpDbBcP+dbA6EPfL+tklCcePtgGlk18uhXRSJi+J1T19Xl4ItP5UP5OcCwyA+i
         1AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9xyyhXtQ4zufEcmZXK4vuDXVJySqg4HXIrr0fTPFz24=;
        b=kJTRD8OAhTE+Psnkg4N+lMiUBNlJ4mcLL7vMoi2uweRLWXhIpQR1z6vshkv1oUMIFT
         +HNmXjwBVT8NszMesaMeukq16l6+StYF3DNI5IafxIu+DHlu6BmA+H1PEiH3Iddva6G2
         rXldYXtawOQCt48sgkvzEQFarNcG8qIim2D1YsX1NF04fXn4DYAprjC7LoPtpQe8x4g4
         2YK+56LQTZBlTO0gx+jVEkS1jA748kDp/2a1dGYPOrgaD1JLktvrKyOny/tpmJb3qW9j
         o4Y2wku8LC5zElBCqATTz2FRA1vZf84w5+JWZxAMJQcviLx6SbWqR+KGll5Yb2ubu08E
         1nsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Greg Hackmann <ghackmann@google.com>,
	Bernie Innocenti <codewiz@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: [PATCH 3.18 03/36] um: Stop abusing __KERNEL__
Date: Mon,  5 Feb 2018 10:23:31 -0800
Message-Id: <20180205182351.919749957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586538120266889?=
X-GMAIL-MSGID: =?utf-8?q?1591586538120266889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 298e20ba8c197e8d429a6c8671550c41c7919033 upstream.

Currently UML is abusing __KERNEL__ to distinguish between
kernel and host code (os-Linux). It is better to use a custom
define such that existing users of __KERNEL__ don't get confused.

Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Bernie Innocenti <codewiz@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/Makefile                |    7 ++++---
 arch/um/drivers/mconsole.h      |    2 +-
 arch/um/include/shared/init.h   |    4 ++--
 arch/um/include/shared/user.h   |    2 +-
 arch/x86/um/shared/sysdep/tls.h |    6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -68,9 +68,10 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
-	$(patsubst -I%,,$(KBUILD_CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
-	$(filter -I%,$(CFLAGS)) -D_FILE_OFFSET_BITS=64 -idirafter include
+USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-D_FILE_OFFSET_BITS=64 -idirafter include \
+		-D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
--- a/arch/um/drivers/mconsole.h
+++ b/arch/um/drivers/mconsole.h
@@ -7,7 +7,7 @@
 #ifndef __MCONSOLE_H__
 #define __MCONSOLE_H__
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 #include <stdint.h>
 #define u32 uint32_t
 #endif
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -40,7 +40,7 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 #ifndef __section
 # define __section(S) __attribute__ ((__section__(#S)))
 #endif
@@ -131,7 +131,7 @@ extern struct uml_param __uml_setup_star
 #define __uml_postsetup_call	__used __section(.uml.postsetup.init)
 #define __uml_exit_call		__used __section(.uml.exitcall.exit)
 
-#ifndef __KERNEL__
+#ifdef __UM_HOST__
 
 #define __define_initcall(level,fn) \
 	static initcall_t __initcall_##fn __used \
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -17,7 +17,7 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* This is to get size_t */
-#ifdef __KERNEL__
+#ifndef __UM_HOST__
 #include <linux/types.h>
 #else
 #include <stddef.h>
--- a/arch/x86/um/shared/sysdep/tls.h
+++ b/arch/x86/um/shared/sysdep/tls.h
@@ -1,7 +1,7 @@
 #ifndef _SYSDEP_TLS_H
 #define _SYSDEP_TLS_H
 
-# ifndef __KERNEL__
+#ifdef __UM_HOST__
 
 /* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
  * may be named user_desc (but in 2.4 and in header matching its API was named
@@ -22,11 +22,11 @@ typedef struct um_dup_user_desc {
 #endif
 } user_desc_t;
 
-# else /* __KERNEL__ */
+#else /* __UM_HOST__ */
 
 typedef struct user_desc user_desc_t;
 
-# endif /* __KERNEL__ */
+#endif /* __UM_HOST__ */
 
 extern int os_set_thread_area(user_desc_t *info, int pid);
 extern int os_get_thread_area(user_desc_t *info, int pid);
