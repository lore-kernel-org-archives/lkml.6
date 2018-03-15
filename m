Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELtJuLqQmXRU9IFvPSUR0PYY7eQ4heCAlddiRIUfv0nsb1kj01aVmntGXvLyR2G6AEEEc6vd
ARC-Seal: i=1; a=rsa-sha256; t=1521141383; cv=none;
        d=google.com; s=arc-20160816;
        b=YCj4vbgfZ4xkaS1DqoiP19wJolnxpI7zmMA39hBbdzLycjxsSouTiVzz65DOyBbTku
         XTiaRjj7Bkfd1fVQZnbRl/Nrlz3NmwsZkjRvoEgBv611+MQj/669JQa5kumw7xGP58K/
         RaqMpnKo96hllcHa2M3SBR5i0Mgr8VogNZ3PLn5/QCJYJeAilODDuekdZr2yDKGz1OHj
         6CbyKZCJeXGgQ1bAqJ9Ru7A0p7xdL43ifalwoV9dmsiarjYehrrRrPDEknpTyuxV8YLL
         WjOcZSxr6aTuFZpyYSc1smyc3UVKdP//LeabAmEhOtKo9v8yk8FxcpFog3xBku//Ec+D
         v/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UsJ1hngeGJikBHwtvXvxwvouxQC72P+GIqrngCaUNC8=;
        b=tMmVwGKBB2oxKRAqrBbniJavyuAtuY0BvUk4VT66ld9cfyUQ/VC2rLZLdBdEpneKqU
         XJJxk+rrcw8IBNreUut4Qd4T65DzFssMM4fCS6RmdCtF6LyJLVjydydlaSYIe9YHHZon
         vYr6zsRp2bWqB1SZbNNVpFySnNZFd2fIqtJvUBiEq1SReFCjLhfnq0RyOLw9pUgREPqK
         9LX04CLJeC0f03iwTZt8rnNrsa7q4YadkjRpJqPJfBpyDUqc+fZgefXWOuKzbLPAolOE
         gfVbTFEjm+oEaosV+hCuDDSIOa+188sUwuOV97PryQ8Ln3IE4IorCaNT3TfQRW6u9wpo
         IJQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 2/9] powerpc: Use barrier_nospec in copy_from_user
Date: Thu, 15 Mar 2018 20:15:51 +0100
Message-Id: <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347068746375?=
X-GMAIL-MSGID: =?utf-8?q?1595032347068746375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is based on x86 patch doing the same.

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
