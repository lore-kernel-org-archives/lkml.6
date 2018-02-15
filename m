Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225eKMEKj7G/6aWl3ugwd8abewpxH3VRcfcfA5AGo0l6eyXnn/PEwgBrpGIKRpvSsChMhRZP
ARC-Seal: i=1; a=rsa-sha256; t=1518709120; cv=none;
        d=google.com; s=arc-20160816;
        b=G7EkR6r8lLqDif/5uv1xMBtO2XiIDaEMs/hUSn8MLo3RI6zuuko2HAsR43mohHYetd
         1D5Tu6o62PxGkpymUw/QXdQ0JGrlgILve89651Xu7nNNW1F7isptJU3hEPwWXmk5ufW1
         FjjxDmrbsQ7bgxu6+8J4/yqB1AlKhbXKQERBzSpr2a3VpMmVsrNE9OIkaQKLxE0uO+mN
         +j1Y2jN2LPcGEzV5SmDhgOp0Zhd7b/yzY3BdKXMQtzh4EsWBwJrFY4tk2HQm0JRux3zL
         hiA3NwnrCXmsrJzP2k3CyyfIkgJQ5d1LqvcXGI7izlXZTjyufxLuZUmpRzXdrEeojVhq
         pk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3nBQeZJPeITtwgmFzuOLRpZfe25t+gYPUspvMUwcKD8=;
        b=Z4nTCucyxoDRRlg+B3+e1+F2Gyt3v9wTlwWcY1fOzLxfI3FxBoUBtJIWBE3JJkzS3C
         bmGei7ct+8t+JuheKxydgrzIHa4i+che+hXs/lxoxkG7SYNUBj3TbMzLIkDKck4mzfAc
         RtuCVwPxaVZYyTTc0HEN3geV5WynMT39O214BShy/WCG7Ohsc8f5DBGff8wXFE7hJjZ+
         XDWIV08mtKnOwReBSWk20GxegAYjWlgVP2FBfqOxMJ9htBLE1uwhCg3FIin/HqmPKamm
         8l0Gk/KgbIkZmiMoS+gTkStc9t5tDxRTLVcrqYGRDFTlITzmIRwtZXRIAktTGVu0RoDi
         XeoA==
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
Subject: [PATCH 4.14 164/195] alpha: fix crash if pthread_create races with signal delivery
Date: Thu, 15 Feb 2018 16:17:35 +0100
Message-Id: <20180215151714.169728341@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480761220325346?=
X-GMAIL-MSGID: =?utf-8?q?1592481935022299727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -269,12 +269,13 @@ copy_thread(unsigned long clone_flags, u
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
