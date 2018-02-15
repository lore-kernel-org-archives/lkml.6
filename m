Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719538-2-18443384187913288110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719537; b=VMRjDqW8kPRX8dRg18Oyie8niywjg83bSNdQ4jm5fOcYUrs
    YqS/+ehBwNdJ1D3Sf65TL695dEBWtddSbPVlpwiqf5ZUalyAw8XgGmQEJ45X5Qnq
    ubI4Xv9rr7yhcRrKsnB2VjHA5LpLzTZw5N8gn23FnjnjbHPUIBkqTZ5WoJvNcc/2
    szU+RtSIX4eNaPDdfW/Sp3NKsks5w0QMtGMhhYOdJg7n087FZaBZCn0P4zRDTIgW
    K1wrODXO9Ez/ih+Y6b8hbj/nQngOYF7Iu12kcjytwgYG7K9tKLjnmKIoYCU+0+2T
    SImTlk/iEAzKcD/UIVSqs5kGAfwmU299pOLzXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719537; bh=PlJ0uL8JGIJOQORrmeurnRvVN1
    O0gtxua9RVckWxrvM=; b=RQqMzYssgHtvFHezvGpVSQ65k1Rg9ihvazoLyRn0Gn
    LNX7LAVApkh/DU3Skw2KqPU0pYrO7o6BXgQslFwenUWwvIww3M61orS6XSmceDj0
    Roese2MqlH8Uw7FDA7wRp0J7gG1ZXQUAhw+yiEXgf/cHufSyB9pryiwHurHVffyC
    ifAO/X0IgJ6l7QVz3gxIRr/6u5VI5GUf6UvaxZokiggN+bn49PEd+K1zweAousA5
    ugw8V8f9x4NWt9nPPcXeeNIWicngAIW+qL7ZwooK7AHfLmRX6HY1SfK2RQbYzZAa
    1oVyep7nboluk98qiEoqD4Ag4xfxBSNdodesRJrRllWQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033952AbeBOPYv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033898AbeBOPYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.4 098/108] alpha: fix crash if pthread_create races with signal delivery
Date: Thu, 15 Feb 2018 16:17:35 +0100
Message-Id: <20180215151235.985833721@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -273,12 +273,13 @@ copy_thread(unsigned long clone_flags, u
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
