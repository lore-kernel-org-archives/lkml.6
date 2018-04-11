Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3tJJlw+AqxbLgDDdjONZLeW6jk1c9b1AEKjONIEnMRjJYoNAVnjduenLRsZBTraUeWUni
ARC-Seal: i=1; a=rsa-sha256; t=1523473179; cv=none;
        d=google.com; s=arc-20160816;
        b=SxY7mtQhcr835Xg2W48gtYn76D7Xw7VMO/zz8dv+sTFU93kKbpItI4haGKB1oiY3p+
         bzbdCeJ6TUFbAwfuk/PddUZqHFSXA4prPEiyFn2/GqUlJJGmxgfATNKkkdQi0vgsubPN
         MmZCL6pYN6t7hVthej3yh70b3Y3do6CG1xOKEirjLLxzX4w0q6fo8Xp2iK5mhB8kWoQJ
         hrRyEB7d8CQBi+cy7Z3+L7LGqm+uWsxz/0AOikUBHLDekplPUQ6Qwsg1OW0sZ/Kup66t
         9JBw15bcQlFt1PScRJ8/C/jemshNMhYgLEoH8yEfbP1F7TykbePE7C5iwg7MncF4U2cH
         1lBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3ym0PX6N3LRhnjtYBX6v0tYmiJfJsGQM+ZfBDDwtppA=;
        b=jZfGnR7tfdynCes8sOiVlf5+09a9cFC/nzp3YasRwqzEyZFuEOCqBpAYYJLYnTtmKG
         mzFdSpleTaABHxrx+2nvINVCmz/XOw+04aj98JWu9iOArHGX3D56vA3ANbi6kb/ukymB
         UW8ex9O9hgHPwT4XujOr6GlANnH6PYWNnjSv4yf/srd/2NXEijV6uIpIQ35aiAaPLEOu
         Aj94K2HBOQNNYIXHblQXWNjwlhE1G6se94mXie9wvKshf/C5yYNBwjeqeBnx0i+rliqN
         VhV3bIPSLG1bAxY7x05fgDrlcTgJHzH9wpyIlIUOw3ghZT3anFud6+W4gbMSHbgDATAV
         c5wA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 156/310] arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage
Date: Wed, 11 Apr 2018 20:34:55 +0200
Message-Id: <20180411183629.121866732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476291331705240?=
X-GMAIL-MSGID: =?utf-8?q?1597477412570956591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit 5f16a046f8e144c294ef98cd29d9458b5f8273e5 ]

FUTEX_OP_OPARG_SHIFT instructs the futex code to treat the 12-bit oparg
field as a shift value, potentially leading to a left shift value that
is negative or with an absolute value that is significantly larger then
the size of the type. UBSAN chokes with:

================================================================================
UBSAN: Undefined behaviour in ./arch/arm64/include/asm/futex.h:60:13
shift exponent -1 is negative
CPU: 1 PID: 1449 Comm: syz-executor0 Not tainted 4.11.0-rc4-00005-g977eb52-dirty #11
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffff200008094778>] dump_backtrace+0x0/0x538 arch/arm64/kernel/traps.c:73
[<ffff200008094cd0>] show_stack+0x20/0x30 arch/arm64/kernel/traps.c:228
[<ffff200008c194a8>] __dump_stack lib/dump_stack.c:16 [inline]
[<ffff200008c194a8>] dump_stack+0x120/0x188 lib/dump_stack.c:52
[<ffff200008cc24b8>] ubsan_epilogue+0x18/0x98 lib/ubsan.c:164
[<ffff200008cc3098>] __ubsan_handle_shift_out_of_bounds+0x250/0x294 lib/ubsan.c:421
[<ffff20000832002c>] futex_atomic_op_inuser arch/arm64/include/asm/futex.h:60 [inline]
[<ffff20000832002c>] futex_wake_op kernel/futex.c:1489 [inline]
[<ffff20000832002c>] do_futex+0x137c/0x1740 kernel/futex.c:3231
[<ffff200008320504>] SYSC_futex kernel/futex.c:3281 [inline]
[<ffff200008320504>] SyS_futex+0x114/0x268 kernel/futex.c:3249
[<ffff200008084770>] el0_svc_naked+0x24/0x28
================================================================================
syz-executor1 uses obsolete (PF_INET,SOCK_PACKET)
sock: process `syz-executor0' is using obsolete setsockopt SO_BSDCOMPAT

This patch attempts to fix some of this by:

  * Making encoded_op an unsigned type, so we can shift it left even if
    the top bit is set.

  * Casting to signed prior to shifting right when extracting oparg
    and cmparg

  * Consider only the bottom 5 bits of oparg when using it as a left-shift
    value.

Whilst I think this catches all of the issues, I'd much prefer to remove
this stuff, as I think it's unused and the bugs are copy-pasted between
a bunch of architectures.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/futex.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -51,16 +51,16 @@
 	: "memory")
 
 static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 {
 	int op = (encoded_op >> 28) & 7;
 	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
+	int oparg = (int)(encoded_op << 8) >> 20;
+	int cmparg = (int)(encoded_op << 20) >> 20;
 	int oldval = 0, ret, tmp;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
+		oparg = 1U << (oparg & 0x1f);
 
 	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
 		return -EFAULT;
