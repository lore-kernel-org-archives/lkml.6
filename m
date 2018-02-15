Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Rs5Z4wv9KzJDR1VeY4B6ZtcGXbZ5Ni4ghCfGOhOVveliwqKCcZcxqfg2x+8WIghCoqide
ARC-Seal: i=1; a=rsa-sha256; t=1518708520; cv=none;
        d=google.com; s=arc-20160816;
        b=rTsxbvJC9FraXJho5U2bWnfVr2as8XzeJHffxwU8iJdFdPsMUPSTK/myT0q4qYgiBj
         PyEMYZrUzQRNR6Murf25VA4V4gYSyGris4ZMEneJV1O909cbDlW7FVC3nmMpIHOUivVN
         IN1uyjzXdIU+8Ou6jAFtuAAYs/2scljSJawyOyNao3u+IFJS4EvJe+iBmBoqtZOcc11N
         6lJ1oAZGF8kzHgNCz1MOPSUEMAVwvMGAwWhMw4YPzK30exliGBC7zlOMnB8Ydw6zCG84
         3s7Xx6rlOmqjSn+p1KJcpZxYMzo3IiPtQ1i1+3MacXBXeZHT0diBVVDE4Mb5W5a03lAN
         ZVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZdHEMg9XkGSkTr4bHjEHHt2GHgGAThJOj1i+6TzhA9k=;
        b=RZYn8Qa+aDRz1PJJ6hRWgMEtJnN7R/PUqeXmGdbvT4wIHBWhfjNkTx7xvH76xKOIpE
         XvWcOahpBqxVZnDusgrm65UvdVEJhagdrcjF6J1eBQT2sCxX71BGQ9lOwL9aVdNV08Tg
         D0pLuI4owNOiaJ03f0RnhXHvnavbssnXc53/w0HU/ikzh4O/hcfX91MYvKf/McpGDw1Z
         0xGDTmwfrAWNjgKuhajDlzKhd0IuWXuwe7IyXFaiCVbzd0BVsmjniLNSVoT8U6gG+Z6x
         4CR1qOw5WuJhEN2JuoTslcvzLmWX6/M2A+qyENnnyv7yfVeRJ8PMLJq0IB529dcXHE+H
         ChkA==
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
Subject: [PATCH 4.9 72/88] alpha: fix crash if pthread_create races with signal delivery
Date: Thu, 15 Feb 2018 16:17:39 +0100
Message-Id: <20180215151232.467437894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480761220325346?=
X-GMAIL-MSGID: =?utf-8?q?1592481306598725354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -265,12 +265,13 @@ copy_thread(unsigned long clone_flags, u
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
