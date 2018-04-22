Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9QY0Y9odYyMxQwJyaQSZLw7az58YemILD3haBpg1VIPOnhOK/QQ3oSXIREqE3JDNKtVvF
ARC-Seal: i=1; a=rsa-sha256; t=1524406661; cv=none;
        d=google.com; s=arc-20160816;
        b=Cv7MN7L+aLHU2q8NQ642eMZaD7q3ru2g9WwFUjjbjNenay+htS2wkk21YJJKg2Gu+a
         ahiYa95hrSVEv8qHDRw6jsSWL0FbNU+ptRhkTjf79SV9rYCgSVzgiYUFLi91eRAPinVr
         wDU67mOMYPbzLR8usXAnZD3gHgAxJjEmfGDVNRuNizVy+NXhAgeM4t6lH9Eti5crvZr/
         BWnWmvomaq4Hr4atJzQ32PH4Cm2nmTX98fgnSgtt7+Zn1BdmBUvQWrVlRfnoVOvRFdaU
         Uk2W714muEq7Mq2mTTAqDa1W+ENzybOqnBLgQ44Qt2EytIQGx+u2VsYHdXlclqPD+8oM
         Wd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Se38H7YnRcxvijTItk7aXysvXN7T5jtihe3n4nb/Vc0=;
        b=gZpCOZiFeA/G2NeRTIrapo+kA8WQeG+dDBOqk4rzoe+1CqF4YUHg71H8Qnfu3Bv3qU
         Dzw5VbEZxhVA0DHsMg4dl2gfNNou1dQCzeEj53EpYX/5LV/Yix5hfo+DPFvCYouYjc+B
         gydiuCaA5/Aoklla4qYiowlNXa6i2YVg/zzHBMCkgchmQ1Pepf1ezO9kuK0jLLqGQzpn
         NPyvGflfd6U7fJnXXh7PYA2cxGsohhOkHigpIsCahygReCauVHz0IZQmzONsL38zAccG
         oj1X8md25sQbOft5Mpjul/rGsUt8SZcqkupnajrGUmcF89E8cS5ishwCDbNKODf6d4/R
         e9VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 57/97] um: Use POSIX ucontext_t instead of struct ucontext
Date: Sun, 22 Apr 2018 15:53:35 +0200
Message-Id: <20180422135308.456674224@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455135109265878?=
X-GMAIL-MSGID: =?utf-8?q?1598456239910386559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Mazur <krzysiek@podlesie.net>

commit 4d1a535b8ec5e74b42dfd9dc809142653b2597f6 upstream.

glibc 2.26 removed the 'struct ucontext' to "improve" POSIX compliance
and break programs, including User Mode Linux. Fix User Mode Linux
by using POSIX ucontext_t.

This fixes:

arch/um/os-Linux/signal.c: In function 'hard_handler':
arch/um/os-Linux/signal.c:163:22: error: dereferencing pointer to incomplete type 'struct ucontext'
  mcontext_t *mc = &uc->uc_mcontext;
arch/x86/um/stub_segv.c: In function 'stub_segv_handler':
arch/x86/um/stub_segv.c:16:13: error: dereferencing pointer to incomplete type 'struct ucontext'
          &uc->uc_mcontext);

Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/os-Linux/signal.c |    2 +-
 arch/x86/um/stub_segv.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -140,7 +140,7 @@ static void (*handlers[_NSIG])(int sig,
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -10,7 +10,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
