Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rkvVMT4Hs8xmQ3vA5P6h7VO4kQo5lS5DBHmFdQgv/bk1cf1iKgdLRPUDbYSGohTYRSeeK
ARC-Seal: i=1; a=rsa-sha256; t=1523472110; cv=none;
        d=google.com; s=arc-20160816;
        b=VvZZEFFMkXszUmRpaHhb6zZn619GjZe2PHtjtbll+8uMkVxYVxV7zc5bgZWSaFMLZ2
         lCfkuyCo0hEnEg3PVo+YaC5smEztH9xuO9K6jB2r/b7Srb1h34cYFlyTTyMCOHtTfZO+
         3mDDpctox/E2d3GcKouuNfbJcjgoEzC8HlXe1xUJ11muSq2NI17A5q11RhF30i7riJHD
         x5ygHBpQ7b+OefjBPg1zXX8MmIS7k08ldXZiORMtoZIy0QmpjacOh8IGJoox1KtTDvHq
         WsDjsthCcirJcPyZj83kSMHJlPBBCUxdP7BK0M0LhcFUbp9hrPJE5KLwaBIJkSszWHE4
         NaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FE/R+eg5yabRz7kqWhxGdKr8pbG7uWh4lWONRMHLRfs=;
        b=comqQfQC5+f6tN6ts7Kecw77Eac3FWrDsqyU0SFupdbvR9FZuNONyXgqiPiwkVHifN
         EF5K95XaxgQeqMKmAvhlNkqD9F0Of0rxboNufNnEz7kvjMZENpD1O3FKtNWS6LA8PBF2
         84BCJ8ZrH8U0/AVenHfgig6fYqRCpZousmbZPA8pFPXNuNzj7uneSwFdrOefyf3hzmLd
         fabZOtO2X3NXjlgutfmWWZ1ub7AkSq83lQmB90po7JrIOg3bYspjF8a+/m/HMPQGsa05
         8qdrV+2RcP0mmyd98XlOYO1h9Mlo4+Rp/j4CC26w5wN6XlL0NVZkKu7waJ0FknWMfcCx
         Lx+A==
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
Subject: [PATCH 3.18 056/121] arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage
Date: Wed, 11 Apr 2018 20:35:59 +0200
Message-Id: <20180411183459.718191036@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476291331705240?=
X-GMAIL-MSGID: =?utf-8?q?1597476291331705240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -44,16 +44,16 @@
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
