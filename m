Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DCC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0062089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0062089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbeG0Lc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:32:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbeG0Lc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:32:29 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7389CCB5;
        Fri, 27 Jul 2018 10:11:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <james.l.morris@oracle.com>,
        Aleksa Sarai <asarai@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 33/33] exec: avoid gcc-8 warning for get_task_comm
Date:   Fri, 27 Jul 2018 12:09:14 +0200
Message-Id: <20180727100828.887569287@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3756f6401c302617c5e091081ca4d26ab604bec5 upstream.

gcc-8 warns about using strncpy() with the source size as the limit:

  fs/exec.c:1223:32: error: argument to 'sizeof' in 'strncpy' call is the same expression as the source; did you mean to use the size of the destination? [-Werror=sizeof-pointer-memaccess]

This is indeed slightly suspicious, as it protects us from source
arguments without NUL-termination, but does not guarantee that the
destination is terminated.

This keeps the strncpy() to ensure we have properly padded target
buffer, but ensures that we use the correct length, by passing the
actual length of the destination buffer as well as adding a build-time
check to ensure it is exactly TASK_COMM_LEN.

There are only 23 callsites which I all reviewed to ensure this is
currently the case.  We could get away with doing only the check or
passing the right length, but it doesn't hurt to do both.

Link: http://lkml.kernel.org/r/20171205151724.1764896-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Aleksa Sarai <asarai@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exec.c             |    7 +++----
 include/linux/sched.h |    6 +++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1228,15 +1228,14 @@ killed:
 	return -EAGAIN;
 }
 
-char *get_task_comm(char *buf, struct task_struct *tsk)
+char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 {
-	/* buf must be at least sizeof(tsk->comm) in size */
 	task_lock(tsk);
-	strncpy(buf, tsk->comm, sizeof(tsk->comm));
+	strncpy(buf, tsk->comm, buf_size);
 	task_unlock(tsk);
 	return buf;
 }
-EXPORT_SYMBOL_GPL(get_task_comm);
+EXPORT_SYMBOL_GPL(__get_task_comm);
 
 /*
  * These functions flushes out all traces of the currently running executable
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2999,7 +2999,11 @@ static inline void set_task_comm(struct
 {
 	__set_task_comm(tsk, from, false);
 }
-extern char *get_task_comm(char *to, struct task_struct *tsk);
+extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
+#define get_task_comm(buf, tsk) ({			\
+	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
+	__get_task_comm(buf, sizeof(buf), tsk);		\
+})
 
 #ifdef CONFIG_SMP
 void scheduler_ipi(void);


