Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpQktwMSAJd/mUTUK6hlQys2v8Nrtm2OFvRbfgAwm1zjMAyS9X+lyYqYiNBWQRx/oKoOyu
ARC-Seal: i=1; a=rsa-sha256; t=1526937584; cv=none;
        d=google.com; s=arc-20160816;
        b=Ve/9t9fY4QCmEzEpOW3OkNujnodZsfdCepWo7kTsFc6jYSkNO2PAVDVvh5dYNuWbvv
         2gRQ5yW98h4z45pKIqyyLsxjj7OqA/QRzncH106Cl9yhsarr6jC+o1caIhJfLjxKW2vb
         p1TBfXcwhAKQkDWGuVq19Tx0NRGDAU2IruAfzcODB0HIeXEvlCuj79G8AGClE5jxkM7b
         bzbMOTq3bjeSLreHo/U0Gwh4w33EDySQJfCWJHuI8wFGLYPAutD+D1fKBQduCOjq8s2l
         2OqntYyDqc+IuO8v83oqkvjVHBMgcU8MzAK76yxeTio636qhvR7oazPQrAzf2eH73/bz
         tBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KUuvbGS7nvzdZ6A7meO1a3CdpJPAiy7w1TnNnBD30dU=;
        b=jVG849PVhEZi9IKfVk6JjFjrBG1W+sD94oWxa7B8GC3qzp80ua/M++t/IjtDnEusAd
         p0vzlfoMyar7SaGfP54ErrLnUhe13fvU0veOSl7jhF4nWj/zOmrcvVsEa8pUzgWzohhl
         EF1XlVga6iShLkha9YoqrizXs1Byw872pHYsw9hr8JhKBJobAUN12X/SGi6wUwnycDYF
         hLAfhzOjh/UAD/BL/c1LQzGXRz3KgH+UNUulxJ+qI+7FcIEIY+ANp+8iHA6IpNnhr/A7
         Tb+fuUNGknD8MjWOKfeVrb+/SaWBEO0XIYzVMKDoiZITfZL9SveOl7LEH86+7i8RAsho
         ssCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qkt2dM7e;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qkt2dM7e;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 48/95] x86/nospec: Simplify alternative_msr_write()
Date: Mon, 21 May 2018 23:11:38 +0200
Message-Id: <20180521210457.632714328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109821557476654?=
X-GMAIL-MSGID: =?utf-8?q?1601110103949358182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 1aa7a5735a41418d8e01fa7c9565eb2657e2ea3f upstream

The macro is not type safe and I did look for why that "g" constraint for
the asm doesn't work: it's because the asm is more fundamentally wrong.

It does

        movl %[val], %%eax

but "val" isn't a 32-bit value, so then gcc will pass it in a register,
and generate code like

        movl %rsi, %eax

and gas will complain about a nonsensical 'mov' instruction (it's moving a
64-bit register to a 32-bit one).

Passing it through memory will just hide the real bug - gcc still thinks
the memory location is 64-bit, but the "movl" will only load the first 32
bits and it all happens to work because x86 is little-endian.

Convert it to a type safe inline function with a little trick which hands
the feature into the ALTERNATIVE macro.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -241,15 +241,16 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
-#define alternative_msr_write(_msr, _val, _feature)		\
-	asm volatile(ALTERNATIVE("",				\
-				 "movl %[msr], %%ecx\n\t"	\
-				 "movl %[val], %%eax\n\t"	\
-				 "movl $0, %%edx\n\t"		\
-				 "wrmsr",			\
-				 _feature)			\
-		     : : [msr] "i" (_msr), [val] "i" (_val)	\
-		     : "eax", "ecx", "edx", "memory")
+static __always_inline
+void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
+{
+	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
+		: : "c" (msr),
+		    "a" (val),
+		    "d" (val >> 32),
+		    [feature] "i" (feature)
+		: "memory");
+}
 
 static inline void indirect_branch_prediction_barrier(void)
 {
