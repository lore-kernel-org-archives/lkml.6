Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELsOyMuyvCuBSqdaNx/V4UiKVOKdZLytG2vq0XGpEpuTlZvvk7OzpOm/HH8Q+J+ZKHJC56Br
ARC-Seal: i=1; a=rsa-sha256; t=1520966031; cv=none;
        d=google.com; s=arc-20160816;
        b=r9jPlpbcjExlS9k6G+UFAuMx8Ow4ntQgpR6nAx4HYFdG08cDWSLbrQkylC4DFdlPPo
         OrCtnDYHszb9pka8LG/ap39ajYzOaGLBzjpVhliAATCGd97Mkm2aU7vF/wccEhQ+yVql
         4xs0OsSzgw82mRO+LmeQ3DGZWuCp8eA9Wjl7kVyILfbKrylHILR2Xtw+dUldCLOaEl42
         TkTPs3GhAzXCqWKs/p3qWp8lAxmjEG2e6lW+ajqaAgzIPIbEdR2Qj+3GOSYnX8wPGcFA
         piogsMHPellru1bEsdVQ/CssqyIkSCBE/CKoBF9edJ26m8zUrLl2OkylRG62vqn7Accz
         JuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I1iwZRYO/7oxhn6bBsoUeq+he1aMtCW74SpoSt/3hio=;
        b=oBinCp7+BFAKsK5H3gRoxNM6lMbHB0MgAvS8wd3Mz/QE4YnJbCD7VMPxf5fSFrNvJY
         Opp3fyG4Yb/llCxoEjnr6GYmyqQUQxcquiahwTqDUv3F7HAO0aGfGqc/zfN3aiIIOoWC
         Sgn+l8DpZu4TGccx3sKHuwiPjC3D8U6VdXPUk9cFwzkZuxh+5FvWZ4PdbntdZ4/bGX7t
         1qU0Ll1hHVtG8W0JxZ5i3AG6ySLi/JuqLn/vcVaniavPYYrSNn7k2Uu/W9QbUTkhHPbM
         +ZKBl31fIDXnpVara6Ojcq+Xkr+BYKneeLhGXpqf6NWab1WP8igvtQ23UQHuIgiChepE
         skPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/8] powerpc: Use barrier_nospec in copy_from_user
Date: Tue, 13 Mar 2018 19:33:00 +0100
Message-Id: <38f5e330801b677df65c774b214b79b799975be4.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848478122386297?=
X-GMAIL-MSGID: =?utf-8?q?1594848478122386297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Coopypasta from x86.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/uaccess.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 51bfeb8777f0..af9b0e731f46 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -248,6 +248,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -258,8 +259,10 @@ do {								\
 	long __gu_err = -EFAULT;					\
 	unsigned long  __gu_val = 0;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	int can_access = access_ok(VERIFY_READ, __gu_addr, (size));	\
 	might_fault();							\
-	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
+	barrier_nospec();						\
+	if (can_access)							\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
@@ -271,6 +274,7 @@ do {								\
 	unsigned long __gu_val;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -298,15 +302,19 @@ static inline unsigned long raw_copy_from_user(void *to,
 
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
+			barrier_nospec();
 			__get_user_size(*(u64 *)to, from, 8, ret);
 			break;
 		}
@@ -314,6 +322,7 @@ static inline unsigned long raw_copy_from_user(void *to,
 			return 0;
 	}
 
+	barrier_nospec();
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
-- 
2.13.6
