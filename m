Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtmZplnmJNNIngKZBPRzewGGr7CrAKKdIrHFWZLu39qSN6F2dTOYvMalrSPLzOY1QKA7b8I
ARC-Seal: i=1; a=rsa-sha256; t=1519410958; cv=none;
        d=google.com; s=arc-20160816;
        b=TbwdLEuLxEWa/q/CDznsfYSYOnG4jCr7emjF2LsbjrrXqn21JPzsdNREpapFZS1sxi
         zABSWo9R5sIHDItl0LcaozyPL6j/dkwy9JzsB/sSdinxr+2UeIxY++z8dWL54bj9AIGy
         Jf0sWYgQGzVaMhQutAuMtzmbxBUqwtXV8Uy/CCkC5J1AdSWgDBAWbigzRafc7xLiUMaC
         fubJ9L8jDSnHvZ6vsk+TBDo+ku91/NMWddEKl2McT1DIGwsSWvlLi+JAKGnvv3QsgsaQ
         78wGSPaGJxsycVIhWXtBLQ5S2TOZr0SFd/A0Vk7Bs9dcR/LDzUwrFmtLLJLeLjzIgSj/
         ijtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=An5A++usW0/IAlJZwZBQmxh5UOWxltkCgnJjDLP1ZxU=;
        b=CDw74ml3DL2BiS4jKXvXoFOmKotmMUQVLd0asSgTDxbmnk3zKohAz9FoqGQAe0H34p
         3JaontHRbJ+IEGjc/S5RsitX2ZED9AeUiCF4jnpUWv4w04Dv26td9zXYlUWq7/HGZwqq
         lYkHk7trHZ3q/WGYWHNgGYPr29xt9LfhdPiOa/UyNORKTPJZIu9KcWvrdGc00LwZGXIy
         oLeFPzInXNaPRkszz+HEQaVcnqsqONbbyhV7AyS9lZqDDxsYt4nZB0KwVivLFPESi+/V
         McsmYoLwcUeRpyReNfSJrPms8mrHTY6yfUkeRyul3N2gWOq31zE5ozn1O02toiEoo6uv
         ipMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.4 070/193] arm64: define BUG() instruction without CONFIG_BUG
Date: Fri, 23 Feb 2018 19:25:03 +0100
Message-Id: <20180223170336.924929508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217866108388873?=
X-GMAIL-MSGID: =?utf-8?q?1593217866108388873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f13d52cb3fad03c237572be2ee691e1fe2d1d7bb upstream.

This mirrors commit e9c38ceba8d9 ("ARM: 8455/1: define __BUG as
asm(BUG_INSTR) without CONFIG_BUG") to make the behavior of
arm64 consistent with arm and x86, and avoids lots of warnings in
randconfig builds, such as:

kernel/seccomp.c: In function '__seccomp_filter':
kernel/seccomp.c:666:1: error: no return statement in function returning non-void [-Werror=return-type]

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/bug.h |   35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -20,9 +20,6 @@
 
 #include <asm/debug-monitors.h>
 
-#ifdef CONFIG_GENERIC_BUG
-#define HAVE_ARCH_BUG
-
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
 #define __BUGVERBOSE_LOCATION(file, line)				\
@@ -36,28 +33,36 @@
 #define _BUGVERBOSE_LOCATION(file, line)
 #endif
 
-#define _BUG_FLAGS(flags) __BUG_FLAGS(flags)
+#ifdef CONFIG_GENERIC_BUG
 
-#define __BUG_FLAGS(flags) asm volatile (		\
+#define __BUG_ENTRY(flags) 				\
 		".pushsection __bug_table,\"a\"\n\t"	\
 		".align 2\n\t"				\
 	"0:	.long 1f - 0b\n\t"			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		".short " #flags "\n\t"			\
 		".popsection\n"				\
-							\
-	"1:	brk %[imm]"				\
-		:: [imm] "i" (BUG_BRK_IMM)		\
-)
-
-#define BUG() do {				\
-	_BUG_FLAGS(0);				\
-	unreachable();				\
+	"1:	"
+#else
+#define __BUG_ENTRY(flags) ""
+#endif
+
+#define __BUG_FLAGS(flags)				\
+	asm volatile (					\
+		__BUG_ENTRY(flags)			\
+		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
+	);
+
+
+#define BUG() do {					\
+	__BUG_FLAGS(0);					\
+	unreachable();					\
 } while (0)
 
-#define __WARN_TAINT(taint) _BUG_FLAGS(BUGFLAG_TAINT(taint))
+#define __WARN_TAINT(taint) 				\
+	__BUG_FLAGS(BUGFLAG_TAINT(taint))
 
-#endif /* ! CONFIG_GENERIC_BUG */
+#define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
 
