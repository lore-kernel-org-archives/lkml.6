Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270jd9USSP/d32qqbfsllcLR+Fc96RVyPZmMR8aSj0vomsmZ5JqVzV6RiQw12q4JEPlaHhl
ARC-Seal: i=1; a=rsa-sha256; t=1518708001; cv=none;
        d=google.com; s=arc-20160816;
        b=PlxcUDvkbtQgx0AVl/dezsRIk4c0kktRBlabT5yxhYU0J8c2w2TH09Bc3NxGzvTzBu
         am8uVQrdrsdGCZJhBpcZUoON0JbiRccKm7ZnaDwgIeMp4vBZCnOiuhrVwQprfWuUD/Wo
         R2V/BiyrJ1zDnopoSD7tGONW6XLkAXDh3VCavK7uL+NnWm8B96aryO/UX0EhkTaQUgfz
         Mba4TMG9PSBn2qUuwE4D/04X3QX+rpHQIhbEj2cIYkJ1lFvfXeAJZ53dCupaNpBl/gF2
         vcCgL9PVHteNNEF8bUdPXGrVZMYNAIVgO0LMffne1xFRO8wlzgebygS5QgfAKY+f0nW/
         I1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z1Y+cZZZbz3WJFEZpDgVNtt7Ul1SaKmbzaw5xk5W4Uo=;
        b=pYtU6VJLzISemz+7/4//QK5MGnQ1P3wwRG/xZTDmr8hsydhaqPVTqPPx9ruzBlJEev
         TkG+2PhHRQ5nEbtQbyh3OwHnpDH0+7EcJxgS58a4C/IXdPav8lmsaFQWfPYGuQm0GdLM
         SIJAp1VXmv+eCmj1rGNpnCsrpNHpzQrFAvZZEw3ZZgKoGBhE5qYTtoHm3ev6KF9LGwhf
         be0OO55F8CPKcj3WBPQ4EZoEnuQpa2KB2pqhgCsk8w2w9piqZiGg2rwiInDDON/pazEO
         HSvehbF1J2QBgTGWcN4Ol7VzstnVYM2GOOoTGweJ1ng/CbFtwaWUNVK6rqsEIYu5rVKD
         1DtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matt Turner <mattst88@gmail.com>
Subject: [PATCH 3.18 39/45] alpha: fix crash if pthread_create races with signal delivery
Date: Thu, 15 Feb 2018 16:17:30 +0100
Message-Id: <20180215144124.185475467@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480761220325346?=
X-GMAIL-MSGID: =?utf-8?q?1592480761220325346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 21ffceda1c8b3807615c40d440d7815e0c85d366 upstream.

On alpha, a process will crash if it attempts to start a thread and a
signal is delivered at the same time. The crash can be reproduced with
this program: https://cygwin.com/ml/cygwin/2014-11/msg00473.html

The reason for the crash is this:
* we call the clone syscall
* we go to the function copy_process
* copy process calls copy_thread_tls, it is a wrapper around copy_thread
* copy_thread sets the tls pointer: childti->pcb.unique = regs->r20
* copy_thread sets regs->r20 to zero
* we go back to copy_process
* copy process checks "if (signal_pending(current))" and returns
  -ERESTARTNOINTR
* the clone syscall is restarted, but this time, regs->r20 is zero, so
  the new thread is created with zero tls pointer
* the new thread crashes in start_thread when attempting to access tls

The comment in the code says that setting the register r20 is some
compatibility with OSF/1. But OSF/1 doesn't use the CLONE_SETTLS flag, so
we don't have to zero r20 if CLONE_SETTLS is set. This patch fixes the bug
by zeroing regs->r20 only if CLONE_SETTLS is not set.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -274,12 +274,13 @@ copy_thread(unsigned long clone_flags, u
 	   application calling fork.  */
 	if (clone_flags & CLONE_SETTLS)
 		childti->pcb.unique = regs->r20;
+	else
+		regs->r20 = 0;	/* OSF/1 has some strange fork() semantics.  */
 	childti->pcb.usp = usp ?: rdusp();
 	*childregs = *regs;
 	childregs->r0 = 0;
 	childregs->r19 = 0;
 	childregs->r20 = 1;	/* OSF/1 has some strange fork() semantics.  */
-	regs->r20 = 0;
 	stack = ((struct switch_stack *) regs) - 1;
 	*childstack = *stack;
 	childstack->r26 = (unsigned long) ret_from_fork;
