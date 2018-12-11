Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33693C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED64021104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543217;
	bh=ctt07fazWbsezFKtq4tR765ojqhyeIjaJUu1KSa68Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZ1DM0M9Vw1Y5ZG0Ai0HpMcwHGhK8h0KBr4szWWBMicb2Jk6gexbcwW7MgK2FiRJF
	 77Lz8vwkvIpamWI9DOFiZTMPlmLJzpT+eSBsuxvDU6Zi0m74Jka73RE02Wq6jIokEl
	 ZEUuTyOzgjHr7dDydhJWakcf8HJWtVkPED16SykA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED64021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLKPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeLKPqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C05320989;
        Tue, 11 Dec 2018 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543212;
        bh=ctt07fazWbsezFKtq4tR765ojqhyeIjaJUu1KSa68Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCRovK+LmUcM0mBHWfhoylVCa5Hj7WRkPcJTSJc61pnhpAQ3QuDnGQ65fBlhaObh2
         YxXuWwEsU5LzeKS3hyb1IITguLFemFnptvijikRN5hIS3/ug4o3aTQUuaX+P8WfNtm
         wplIMoqou/jkloxPkFwNp1ruu+Tl19iJQd7PXiX8=
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
Subject: [PATCH 4.4 22/91] exec: avoid gcc-8 warning for get_task_comm
Date:   Tue, 11 Dec 2018 16:40:41 +0100
Message-Id: <20181211151607.573612833@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 include/linux/sched.h |    7 ++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1077,15 +1077,14 @@ killed:
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
@@ -2668,7 +2668,12 @@ static inline void set_task_comm(struct
 {
 	__set_task_comm(tsk, from, false);
 }
-extern char *get_task_comm(char *to, struct task_struct *tsk);
+
+extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
+#define get_task_comm(buf, tsk) ({			\
+	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
+	__get_task_comm(buf, sizeof(buf), tsk);		\
+})
 
 #ifdef CONFIG_SMP
 void scheduler_ipi(void);


