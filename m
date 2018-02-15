Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225019MIIsxNUKcAqNtXqwZMbREXxaQh77gY2VhlAb4j21kWyHf0kAFKxdxrDEaXBohGvxnE
ARC-Seal: i=1; a=rsa-sha256; t=1518708741; cv=none;
        d=google.com; s=arc-20160816;
        b=OM+bGXTqzXCOi9BpX3rl1RQBzaQLaCp0v/AoBfP2DuGLbENpv/rO3h3EuPpS+Lowx9
         B/giBYIhOSN+aDiV56mqXkaBGUbOzk9qiCVY8s8Nc7oxypGja/wUXoz9GbOG6/pgKmmZ
         Xv5CrrCOYdGSxgRGPvIZkDKAWQXRIZr2UJ/Tdtp25syKhNa/wu8Jnfb1DA8LLjTC3u/J
         uephDJqEN4W3Pn/4v1QvBLDze975wjLdQdi4f4xccHe2pS9r9Gzs4Z2Deq5hmnUYQiCT
         RcI1Ixzyla6C1BTUAjtZ1vCa43e5sW4UbzbhZMCXrSsMhhVs1uBgOQxVUWNicf6BWSMm
         e+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vlQXjh5/BegbQ8vLxI9If0sFN/u4TIIrm2RInEEKDsk=;
        b=TJhfAV+Sf6amuNhaj0dCDcMPzrj//Oei18xyJdem+bpmOCoVguXP3XD1oLMQMSsFjf
         d2vr8wM2sasR42ZvlKixzaiPQE9lp+61RVSF+w0+HeYit3du4j+UJw/n8UQ6ZmTlO/4N
         nRX/PUmIof9Ec+07hG9jN/lwzXO8P2KQrs1oifwLRJXjVeggIOkjtpQSTtNJvpJ6HOff
         PoKoiB8KaEyoiGhddT3Elmak4GAxtpZWxPKf1YiluYBusu+HJgXZlZqxCMMGfaV4GuVr
         2t7gAuBVB0XTuMdk0qsD6LLFcWLaOI+BCcn+5oYc1UFUt6u4ac9/o5zWAuqiWkPrqsiO
         Zidg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 064/195] [Variant 1/Spectre-v1] arm64: futex: Mask __user pointers prior to dereference
Date: Thu, 15 Feb 2018 16:15:55 +0100
Message-Id: <20180215151708.910132436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481537914190837?=
X-GMAIL-MSGID: =?utf-8?q?1592481537914190837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 91b2d3442f6a upstream.

The arm64 futex code has some explicit dereferencing of user pointers
where performing atomic operations in response to a futex command. This
patch uses masking to limit any speculative futex operations to within
the user address space.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/futex.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -48,9 +48,10 @@ do {									\
 } while (0)
 
 static inline int
-arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
 	int oldval = 0, ret, tmp;
+	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();
 
@@ -88,15 +89,17 @@ arch_futex_atomic_op_inuser(int op, int
 }
 
 static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *_uaddr,
 			      u32 oldval, u32 newval)
 {
 	int ret = 0;
 	u32 val, tmp;
+	u32 __user *uaddr;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+	if (!access_ok(VERIFY_WRITE, _uaddr, sizeof(u32)))
 		return -EFAULT;
 
+	uaddr = __uaccess_mask_ptr(_uaddr);
 	uaccess_enable();
 	asm volatile("// futex_atomic_cmpxchg_inatomic\n"
 "	prfm	pstl1strm, %2\n"
