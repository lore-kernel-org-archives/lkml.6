Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp3R1Pubt64t57L1hVtHlUeqc+2l+mj4d+wANLvuqTOAU1KoYFuDYhjsiJm7ZjoJhmXMbYY
ARC-Seal: i=1; a=rsa-sha256; t=1526937314; cv=none;
        d=google.com; s=arc-20160816;
        b=jKVIHAHhxHS4T7u9zVbmebrF4y4NstE9SMEa34zO1/v3z7buTa4BDnKEow1kFQszhx
         R6pKmWsqcpygx7mnLJpeTdkdh3UOCY00KXyLgm9Nj/x/gxu9wLumPLI/xDEhDLWZkyfr
         Z/rQx8CyQeGvBDHEbNB3X+5sVjSSq4s/XlldLVvJ9USIXs7CeTFOte6DOe2YF4iPsdBl
         V4RKuE2Dmhe2Uyi0XNk8NXqK5PeaybscMcFr2HchBE7ufBs60IAy5NqV0Otf8MLMp0ZH
         V0WGztL9D+PbHAbYcbF9cyXDYu+oDkpLerrCg/BHPjq6pTBAxTSvqLfYgm9VPIJYmtYL
         WqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cRK0DeOp9yxeK2XVQFz1htUjrMSSqaLs7niG5+PwTDI=;
        b=dOJssfD2Y9k18fWnX2ySi7IHttboZhXx3Ui3n2MK+6o52dEMk9vTLICzaqEnYJw92C
         yz/IfeNOyWNRTAAjd1VfCQw+3Dhbtk3g/ZGGuY9ItgvoUTL1aPXmdi0Nv5v1NBd/6aP7
         GBKYF04OQolcFeqKvbpzgjX8XlQStzJkR1zY2mZnpyMULcwOdgj75Khk79Os7Ivb+558
         q7WnjsCyWAbRQaqAZ5un35tpS8aVLRsZzjezT6tK1qdfPqvbIwgT2hnpaAqMMhD55upv
         aRIEyOJiTzUaJr90RpjH2fbgHmyYG2jbrI14QKN+YjyJlFP/rXBWbfMvw3eW979wlKxb
         SABA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nne0bVKY;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nne0bVKY;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 36/87] x86/nospec: Simplify alternative_msr_write()
Date: Mon, 21 May 2018 23:11:12 +0200
Message-Id: <20180521210423.893374107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109821557476654?=
X-GMAIL-MSGID: =?utf-8?q?1601109821557476654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
