Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLeoRbaq0oCXgdAWk9MB3dXobaCfRCiTQCSHqYD6SNHpKSnUj2vacIkaUxSPT57umf+HPS
ARC-Seal: i=1; a=rsa-sha256; t=1520955535; cv=none;
        d=google.com; s=arc-20160816;
        b=WgLBSecZVpXqah9GHMPdSqrF20HBDLMdsxvpaPMn3E5sahphGWmgMrATv9AZkQQWxE
         TH3Nma/4jwVMLGc5GSwLVlDTs9TsoLMU47a5iOXQDC80RDRBXuoRoGKMaFIsVKt5//20
         GlC5YTJlZmiG8/2jaA3xaZavrBnXjDz3x7SWRKCmNLVXCWY2Df75aXGwqNIMdgQml/Ty
         vHpV8AzpNbz054A2pqCpgR/HMq5hVo4rS6+OHjmMsA9vXhfwt2Yt2boPY1h+GPeHYWyr
         E4NN61hslaKSfGYi7M9QzUAcF/dh2HRFE5mVB0WCptGD7DSK+6RkVpnNpPH8a3kZRWEc
         dL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o7hU0kcdHupV2xBiUrtAFhlfD27K+sD+VSoncobOq+E=;
        b=gv0YYXsf+yX0alDZK8XsVF8L+WTbxycKCF7gTj++HxNsgorztLNO1aVoiYjKhDvvC7
         Lh0Eda1mdb9Hl1gnCMe4hK9HJcGSOU1f9oI7EgwtYjTJaa6/76JBaWpk3TCVn7kFgxy8
         rjvsB6lNWvYkR/vPbtOg/Smxbi09fokzgQv9TCeBNP3B1jpY2SR4wKyRYWv3bmY2i73R
         qYHptS3BumHDXuHEJIAta0Qr62GeZ6SPentcYXGYtBeeA6JQ3uS8jUPvzbEwYULtFdsA
         1iIjss7CrhVVa2LMEP8OVTMKfwGmSRte5EjOF9Gf+jAWRztW7aPvlKLDAqCzVIpt50nq
         Lbmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 083/140] lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()
Date: Tue, 13 Mar 2018 16:24:46 +0100
Message-Id: <20180313152503.765510929@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836960411207865?=
X-GMAIL-MSGID: =?utf-8?q?1594837471480443427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 1b4cfe3c0a30dde968fb43c577a8d7e262a145ee upstream.

Commit b8347c219649 ("x86/debug: Handle warnings before the notifier
chain, to fix KGDB crash") changed the ordering of fixups, and did not
take into account the case of x86 processing non-WARN() and non-BUG()
exceptions.  This would lead to output of a false BUG line with no other
information.

In the case of a refcount exception, it would be immediately followed by
the refcount WARN(), producing very strange double-"cut here":

  lkdtm: attempting bad refcount_inc() overflow
  ------------[ cut here ]------------
  Kernel BUG at 0000000065f29de5 [verbose debug info unavailable]
  ------------[ cut here ]------------
  refcount_t overflow at lkdtm_REFCOUNT_INC_OVERFLOW+0x6b/0x90 in cat[3065], uid/euid: 0/0
  WARNING: CPU: 0 PID: 3065 at kernel/panic.c:657 refcount_error_report+0x9a/0xa4
  ...

In the prior ordering, exceptions were searched first:

   do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
   ...
                if (fixup_exception(regs, trapnr))
                        return 0;

  -               if (fixup_bug(regs, trapnr))
  -                       return 0;
  -

As a result, fixup_bugs()'s is_valid_bugaddr() didn't take into account
needing to search the exception list first, since that had already
happened.

So, instead of searching the exception list twice (once in
is_valid_bugaddr() and then again in fixup_exception()), just add a
simple sanity check to report_bug() that will immediately bail out if a
BUG() (or WARN()) entry is not found.

Link: http://lkml.kernel.org/r/20180301225934.GA34350@beast
Fixes: b8347c219649 ("x86/debug: Handle warnings before the notifier chain, to fix KGDB crash")
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Richard Weinberger <richard.weinberger@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/bug.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/lib/bug.c
+++ b/lib/bug.c
@@ -150,6 +150,8 @@ enum bug_trap_type report_bug(unsigned l
 		return BUG_TRAP_TYPE_NONE;
 
 	bug = find_bug(bugaddr);
+	if (!bug)
+		return BUG_TRAP_TYPE_NONE;
 
 	file = NULL;
 	line = 0;
