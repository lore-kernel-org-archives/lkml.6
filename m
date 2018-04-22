Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kMctuFJWr8RZcPVxLsnE4QfxYe6PDC2KbbRiOh22W7kUMHA0HjayOX5bobhWm3nG0llhI
ARC-Seal: i=1; a=rsa-sha256; t=1524406072; cv=none;
        d=google.com; s=arc-20160816;
        b=igbuAmEA3+/GOJd0nAO1YjlrpJUgUG8zuZl6YtriYR4T61T0pwJtQDF98FRTdtEkK4
         bj6Sp2Goju9DfhVwOG7DAvaDXsVU8EkmVko2I1ESiLHWCiU6WNHsq7d9d3wCDFuKqwaf
         7uQ8GQvl3qr3byJPueWAV++kRwP3tY+IxmeIrXrM9TAB1ECDv1ojAc/9JVjQD5uK29cv
         azGlNzW0b4Orf9LRSGzN5O6UG+6OQogFkTxgRKANmWtIUZ1io7ZyVRCo02x4DfjGygUp
         s9IhbaQvJx3O2yHBYlvWZ6UY6fCzbTrp3IchNmYelMuHvejKc1t2Dhxfo9yQ4WnVtaGx
         BEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b6iE/JF0n9xxA5FknfAx5YkCnJ0zgwNZyT1LitDErbU=;
        b=eA0ND97CL0lCm00IU1aXbmExAIYkpriV8KBXpr9r/exUq7L7+keqz5/xK/mMHgg9+T
         d5/70CbTGcFbwAK5emECjVy3nJft9oRnKZGfSJ94CAQs0H6tMPILNPp5xTy38mPA0F+3
         o4rgbNwY2yAB4313ejm9byXNqSciiJZs7F+5tDaVFYS6ZyIR4DlP9/oVDCuB41GN+W/1
         Ho7CTACmbIBr2X3t82Ay3C5udWsKYgVi4M5hMZKe5YxM8t9AZ8mSiNUjtTjM67cYNZdd
         9+2cJCcF3X+g9AFRXLgW+fgt+rC/9+D8eg2+uPjwIuQganFES5N14/G982+5YPygldpy
         mYPw==
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
Subject: [PATCH 4.14 101/164] um: Use POSIX ucontext_t instead of struct ucontext
Date: Sun, 22 Apr 2018 15:52:48 +0200
Message-Id: <20180422135139.541352733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455135109265878?=
X-GMAIL-MSGID: =?utf-8?q?1598455621712350370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -160,7 +160,7 @@ static void (*handlers[_NSIG])(int sig,
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -11,7 +11,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
