Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48oNlLcQWLsequOtq08Xwrf8aTpSr7D3PxTwc9Y8FAjK0jFRqcgT58kaiJjM5+uVSGKhWuz
ARC-Seal: i=1; a=rsa-sha256; t=1524406375; cv=none;
        d=google.com; s=arc-20160816;
        b=mr9lQ5YruITZTt2TRDLZ81wTkR1AaRe+Qo8nzrZ5C94npVDd/llytZEgWN9Vi2pZdS
         m1+yFdog9sgIZSYBLWgN/UBp62cPctRT92UIHmEVJv74LQymLp9l6CviinRIU5gA7Clb
         NzUHHhWDevKyJgkd88+hKuWImw/EP6CvAm/l0WcLKSQajX6FRZWZBWCxi/KwFgoa2L/i
         Oa56KjpUhpyy0qXRe7rekH8mJkzpXHzucBlkt7lmzgJ5V5cGlDM5zOuWB/RosAy9pwW/
         uQ8bgb+Ew31GtAFa1dGgdEtR3uW/snCGjaqaNmprJVw4Pvgcw0CbVORj2A3c62vSPiwf
         bUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RICGOdPvWtxwr4P4VTkJWlTG69q48Ey/qKFiWYZCngw=;
        b=bdSEaH6A62q4hVC4oRy9ZkSxyinWP8ZTKso7ej4J9zlR9/rJeswvd2jlkOj2qj6MTc
         6Zo7IbCdTWwo7/BwTeh0mAI8UQj16NbN1lHuUduqrAXatMFigyHcXpKUqQgpYeeeBZvY
         Py4BhKRY+U3l7UNBSTXiw9k8Sxf+KN8BjUwr6EjoT0zUwjCoWEZcEO9oPO5lxXMmVTWX
         g7CaWV6TrNL6O5fnTzjiaMzVTqtia82RuDmebqdS8nQi/viAE2Z5eFT+gWwRpQhhRpxH
         DcSvSTpYEiEbSHBqEd+JArhQpbSmFfQMnAEBv+hnKvlyhnNTrQwi7U3KJo/Bg9cMvMHV
         DB7g==
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
Subject: [PATCH 4.9 48/95] um: Use POSIX ucontext_t instead of struct ucontext
Date: Sun, 22 Apr 2018 15:53:17 +0200
Message-Id: <20180422135212.380177212@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455135109265878?=
X-GMAIL-MSGID: =?utf-8?q?1598455939712374780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
