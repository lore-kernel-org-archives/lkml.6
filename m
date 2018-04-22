Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cXhMjNtg04XBRRdBLdbRtTeZ0myRd8EvWEQLxjkjehdnUBQxdPfwcjzjuqU6lk/B8+4WV
ARC-Seal: i=1; a=rsa-sha256; t=1524405608; cv=none;
        d=google.com; s=arc-20160816;
        b=KakJ3SPVhvt5C8SuGOxwiPy2W7kkxS47H+IxKLwOIlTjChkifq5j1xcgb2lZkgwYEN
         AacoLXHuhPKg5LCHVWQcCYb+e3b1pRaMJS1ke9+/P2BJtJ39fGv1e8jx8ZTIXwNaGscc
         WOwSVk+k25Y2kQDIIgB7HMR0YwIGc0ztDHBdNnTwvz9ts25gs8jARwW1XsV95vMLWR1u
         PrLUViyjiXGK7EIPDwptCiIY/YqzxxCB8HpnkNGYQZeC0J/mh1J43Qtj1PQaVs//OvBk
         e2tbLI61c1JMPrvLayyOJOZ7/Oje46+fK0TmrWAMXBwwnxN+OYRibYSFJYBo2zNf3lPw
         rAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TnLoXj/tsrE5h642WOtyN5qpMxNqAPQKetz8GO2jfvI=;
        b=BvKBn/g/33k4/qm89r3Zydjcmme5Xk4MJx/yNuwLGfpqrGiq2o67QjnUwu0F/PH/eS
         9iRhFX74Kpw1C+WnnHNfhLE5jCGvlNdqpYMLEzZSMF7Lm1SD/p6V65HjCBaFoESjw29C
         ThiG5KgOraCsJR+KE89bJT5jcN+nZF+h+7kusPMCD7aIiUKZd2QxnPHMbJDyf/8M/kVi
         pB2dboLpUtfAyXyF3CgRpvgHvnm64IBRgMkXy921e78C2kbvF6N2/58vngfgBJZJpvBR
         yCtgEnJwGP8E5yhS99ZxFoRYG8EYkTT1ef/9/OW7rL8Faj6/3QUftW55TCdey4WZwAQd
         Wovw==
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
Subject: [PATCH 4.16 129/196] um: Use POSIX ucontext_t instead of struct ucontext
Date: Sun, 22 Apr 2018 15:52:29 +0200
Message-Id: <20180422135110.936358467@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455135109265878?=
X-GMAIL-MSGID: =?utf-8?q?1598455135109265878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
