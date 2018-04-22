Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ozLlSe8a+IZWaSpfEw1zDekOEU5S4C2bhJQ0zD9uycjeD2Zfq9Siqrr1dPbpdJ4XJdJKQ
ARC-Seal: i=1; a=rsa-sha256; t=1524406069; cv=none;
        d=google.com; s=arc-20160816;
        b=sdrbGnJIBE626NbGB7+R3LMzPwfD7CD0EIb35nsS5AbohorfPrWLGrWOurJ5MrAZph
         2t89bhLVWq8bfLS649crBS2VhuMYOM5Fvf6kkDPKeVwRGX/SSpP5NvRRdzPOSJtPsnbk
         jKj9oibe6ZodEgFBCwlM1qsZEkQoOE3NoqctxOZ44F8/IGbMY0m1E1+mc9lcdP5RV6E8
         vmr3piGVZ5qPyh17Rg8Wm7NP5S65t25pBli2CIA/HwegFBWY49iDYRsmLwBvDBLwow7J
         Snp+Y4fASBhB28qUY5D0HLj41h5ojEMdgOUpINnfQ7p6flOOg/CdoH2thtBar+6GY7yj
         wAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CzoHMawXHTqoumTFxJtsSXAwOr8AaTEa4ncUfT+16kM=;
        b=TTjz3ZFt6aw/R5vB7sPFu8fLPH7OD5jwKSGNptaEfZk1M3NVkCUqgr3Gp3JfzSEyAx
         OkqQO9pKWNrAiP0kG0lwoo1dZnJQffKBCRD3pvNmCUePCjh41BJtqpdCH0NLcReid+n0
         sjYeRhcVPwE9GOMTLnF5SZwL6auCn4UNFbmF/d3Wr+WMIZcKj0UngzbA2nP6a0qTj4tK
         OrWSelWSHccKXbg3AilqTWuFi5tHbwY07CflWeXJ33+4YMjrIZ7aXO34PWCMH49rszqS
         4370A6wkSIFIWSKPGAmGG20CDy0PLv6Tlio9453SgxMW7JBPZkxx41xBGHI3Z61RO5Yd
         9AVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 100/164] um: Compile with modern headers
Date: Sun, 22 Apr 2018 15:52:47 +0200
Message-Id: <20180422135139.496854368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455132138531431?=
X-GMAIL-MSGID: =?utf-8?q?1598455618996928994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 530ba6c7cb3c22435a4d26de47037bb6f86a5329 upstream.

Recent libcs have gotten a bit more strict, so we actually need to
include the right headers and use the right types. This enables UML to
compile again.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/os-Linux/file.c   |    1 +
 arch/um/os-Linux/signal.c |    1 +
 arch/x86/um/stub_segv.c   |    1 +
 3 files changed, 3 insertions(+)

--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -12,6 +12,7 @@
 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/un.h>
 #include <sys/types.h>
 #include <os.h>
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,6 +16,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
+#include <sys/ucontext.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -6,6 +6,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
