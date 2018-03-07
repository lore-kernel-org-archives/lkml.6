Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuCciDu9T/sbFuYpEfvtPBuvlvh+rP2QgrXEP3E3XBjqCAqjsuBXZ0hMAYUqDVNQJXzgmQp
ARC-Seal: i=1; a=rsa-sha256; t=1520452071; cv=none;
        d=google.com; s=arc-20160816;
        b=mC/MsTDB8uXlFFIXkwrek/GF8h95Xw5PNtOsUKUEMJUgb6hAkG1GJ3MD4UzeNrr0YV
         6TbpVuW2ePRovcOP/R5y4UmFqkK8YDLiDlAzPZb6ir0Wn2VsY9bZyyDQdhRBkO6ogmuP
         AEn2ZeIKjFFs8esJdmyG+cbrZ8gZQ0wQzCw3XdjAfKJqFiSBsIp/lj3wBdEIpZmAFZE3
         YqhLUM17I3KPr6P9aNp1Y9iAH1gB8TDXMMK3cjnu91V7WsqCRFK1xbCwwHSYe9d86/1d
         ooUZm1EeJflxEr10tMNG8X9SpkwgEnhMUY7yjslyzbeBcnrDSwOoaOaUgTJJDLItC4a+
         RXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q9MVxcgB+1RozX1B7p9q2rIc1jTDfYiGx3bVbxbE3qU=;
        b=g9Qx1QyBG3D7VPpHG3KpGxz6e1LdN8mtTIoWISCz5O/L07kfqTx9hz6oxB2c8RgYqL
         k/MIx0LLpxxVHpEDXhFnackXdBNBxJ1+dHmZtLIxGNteV7WD4WYrlw5OKb9jG7dyswnP
         YNtME9MWT9M+X7L1YCURlzXPaooHn/1ZKijEEr1TtKDLBnHsMD4E79rHiw14zg+RxMMK
         nung+xQhJ1miIH6BZjBrd0T6Cgh7UaFyKi9XBmWiprrZ7ssndD9uGojgJ1bhKhCy/YB7
         3MnuzCU/2pUEdByP7Q/gOgKIa6iVkjW9+EJqjET8r8ooQ3xYiT33owAje9Z/LZxO+1r2
         UX8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>,
	linux-arch@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 090/110] nospec: Allow index argument to have const-qualified type
Date: Wed,  7 Mar 2018 11:39:13 -0800
Message-Id: <20180307191051.371755939@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309283261938914?=
X-GMAIL-MSGID: =?utf-8?q?1594309551361374965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8 upstream.

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/nospec.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -72,7 +72,6 @@ static inline unsigned long array_index_
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
