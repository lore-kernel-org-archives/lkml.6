Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuT2g4BZqB/CW/2xjlh//BMgD3hymmfy2mWTzOkrNXP1tD9ngG2YTmGe99u9x57k3obbu+A
ARC-Seal: i=1; a=rsa-sha256; t=1520955048; cv=none;
        d=google.com; s=arc-20160816;
        b=K9I0Tw027VSLEKmtNBj8MewHqNwbXjp7ozeFl3ohBV6W/CE6VtcDMwubqtBVu+nxif
         rSgOkiSm+l+vx+gUx46CBSPy5U8E149nHHjfSs0LX0kWRgpPGAQZWuXIEAR2NNwP9wHf
         kVKAHL74sq1fa7W2s7mWi/fbV3Yw6wAUae2f8YHgaSxyyiYaXSssAY8Q3tqM12JREXjm
         ALmIXbGUTEjORAB/TZwK3uFbJANsifp6trwgXj2WsfAfLKmZFgzbymrFn5jQ7QO9CRFr
         g8DxtwNe1cKyWUWgBKTvDgKxgg5KSvbujNyms1sysljpiuLs+SIi8IIklj5BRUzKOfKz
         mz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k+Y5/q6WzdN/jVxsqcDaUFI/dRuOCEqy4nZEswiizeI=;
        b=byGKOVWMorCKBLWNInF/S3yvLCml2hUA3zLg6rtXOP9l5vXcHEagSVqCUsdG/FhS4t
         bGZOJgPPKLwHB+2BU/lCwUaH7NaBJY1oIFZ7b5d0RpjrNFL+XxYxbMSiNRvm/coGKgXF
         es2K9sGUpZWA3Cd2k1AmLRkesTO62CB0EBfA4SHN9SEDSDUjKHqebNakl82j+iePQ4/s
         pwXs7k40QZoM26WXkwWiJD9gekalnJ4dl39GohM9MeyZW8zwnj33lvsgqUNoc7DV4DJE
         MA9j+7ubKcp+38w4gqQm4cWejzPlZwc5LC0Rc0oH7WLRYL1uoSlUrNnHb0o2LJmOqhDW
         pabg==
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
Subject: [PATCH 4.15 047/146] lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()
Date: Tue, 13 Mar 2018 16:23:34 +0100
Message-Id: <20180313152324.265311551@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836960411207865?=
X-GMAIL-MSGID: =?utf-8?q?1594836960411207865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
