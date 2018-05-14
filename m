Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AB8JxZotlC2dueJ8EzWp7jlt+cuRhcWKK4Cu3+F+6I2NAdfTGeyvTylmr1gIjEwhQxGEr6FMBuCY
ARC-Seal: i=1; a=rsa-sha256; t=1526301493; cv=none;
        d=google.com; s=arc-20160816;
        b=i1YVhz8v5lfUo59uDdJ6R6Wo/ZCNoHW7xoZlRnHNUM5qydCVwGelWLlpGDFEg8U/QU
         pu4u60sgI/aSd6imyoMqyiqucNHz10Cp3Uf2x/JmfX/4B9uO3PtB3QaRBVfEG0LlIcSL
         J6q+XCu2tpNS3gg4aiFG5UbK7VRU5kV8Vp1t/qkVMQjx4xAFn7g2iEFaeCNaas7LFTKv
         DpH6/K+MeSH5i9TA85bq9UzkSahILJqGAQ3Ki20VK0SYi2XE8Oh0qZOedH0fJJ9fW+E1
         kS0roQbC5l8RxdIjAou2h+pYxiEk3Do1rC9NGQC8SYhGzt/eBZiQNAtGIr4d5lp4ESk6
         2d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=/Dxxdhyh5hZ9ZHPU8ohj28MKqGk4tfjSkJ9szsLHDTY=;
        b=VuULTzaBgEXic+fzcTZbtj6LpfDgRjjrRtHTkDNX8lsH/10nm9DvJId5HTMkY48heX
         frTrQpCi3KSCNAqJWyoU7mvtXleQp8ovgilFinOI6/nIxwJ+Yewj3IdqaUo1KmwhFhLL
         3oP9LLumvoDqJtgdLPj614KT/rfXSS8B5MBcgqPQBAt4JHfnKvLORmQ2ol2zzM87ZiAm
         S1viwPwKu98Fo/IIgPdvRrnV584jAbR3wWICb7VjpLngTyel/FhzGhkJZqBRjT7aYlrg
         BpmUKIMgDJyzFIbK1xk1wyFVEzXc/0Klvi3BmKRuQbinm7msZzJe9NlZelpSrk7Mquc0
         mEvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 14 May 2018 05:37:19 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-0afd0d9e0e7879d666c1df2fa1bea4d8716909fe@git.kernel.org>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org, mingo@kernel.org,
        rdunlap@infradead.org, hpa@zytor.com, damian.tometzki@icloud.com,
        David.Laight@ACULAB.COM, arnd@arndb.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org
Reply-To: rdunlap@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, damian.tometzki@icloud.com,
        David.Laight@ACULAB.COM, hpa@zytor.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, peterz@infradead.org, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com
In-Reply-To: <7cc156408c5781a1f62085d352ced1fe39fe2f91.1525923412.git.jpoimboe@redhat.com>
References: <7cc156408c5781a1f62085d352ced1fe39fe2f91.1525923412.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Fix "noreturn" detection for recursive
 sibling calls
Git-Commit-ID: 0afd0d9e0e7879d666c1df2fa1bea4d8716909fe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046845024948230?=
X-GMAIL-MSGID: =?utf-8?q?1600443115547442431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  0afd0d9e0e7879d666c1df2fa1bea4d8716909fe
Gitweb:     https://git.kernel.org/tip/0afd0d9e0e7879d666c1df2fa1bea4d8716909fe
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 9 May 2018 22:39:14 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 10:20:53 +0200

objtool: Fix "noreturn" detection for recursive sibling calls

Objtool has some crude logic for detecting static "noreturn" functions
(aka "dead ends").  This is necessary for being able to correctly follow
GCC code flow when such functions are called.

It's remotely possible for two functions to call each other via sibling
calls.  If they don't have RET instructions, objtool's noreturn
detection logic goes into a recursive loop:

  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
  drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)

Instead of reporting an error in this case, consider the functions to be
non-dead-ends.

Reported-and-tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: damian <damian.tometzki@icloud.com>
Link: http://lkml.kernel.org/r/7cc156408c5781a1f62085d352ced1fe39fe2f91.1525923412.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f6c48d..264522d4e4af 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -190,9 +190,13 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 					continue;
 
 				if (recursion == 5) {
-					WARN_FUNC("infinite recursion (objtool bug!)",
-						  dest->sec, dest->offset);
-					return -1;
+					/*
+					 * Infinite recursion: two functions
+					 * have sibling calls to each other.
+					 * This is a very rare case.  It means
+					 * they aren't dead ends.
+					 */
+					return 0;
 				}
 
 				return __dead_end_function(file, dest_func,
