Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoSaILDoPkEjtBJilllz6IIsKuXbh/YfajHu596grESmRm2MX04UXshqknjHj1YiShBsPT
ARC-Seal: i=1; a=rsa-sha256; t=1519981190; cv=none;
        d=google.com; s=arc-20160816;
        b=yaeWWRZuBBwep452eVDE9liiQux8VwbRpQ8dIHEzFN7EWCaR9HU2jfnEQucf64ZDP+
         +WHGeR+iSdnqKRVYnYyjv1jnaDYJwR6BOOmyJU/GWADLt+m2YcRMDK5DGxC0QM0rRCb8
         TZH31cRwh8zy6ztKQurAh24h3xS/TdrQb0Kq/2aGuB3eRg3AoxICsTP4+Apv/Bz4cRP6
         zQQB9BccUKzkzg+gXERQBHHBApK2npSg/L1QZCGG9f5B6RCjGVVA7U2BHw8YwT2+GbtC
         fkZvNw9OxGtjm2KD6w8UTIPxQjN9UfLSj5eJyNyGLonCZu3vgc/CkiL3A0dAY6ZoZZdK
         E8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4rEc5UQoyJQzdgd2gDaUrB8dSoFF+Xm4ufw2tvAtKR4=;
        b=MruCUwxwYj/sHKe4l/RuqWQ5iKzffc9WYaDO0Au56gPMMZiZ02yWmZngsbhKxRj8ij
         PeYkX/hTfbojFeqUrcNLtvvJ1iUfhodxq4cXSPhEAjKW6oTFB3hYjn3gOdHbzFwtRVNF
         bShVEwKtl2d02PZ4scrgfgDFO1QTRAMW3Gvu5LnSzaxIYPvNNKdzUHGQLattnsrz+6I+
         D2FFKtCJXiPpvuVaviH6xGIuDN4nng6R1s1H0WX+lGU5ja6+X68cS10IZbGcsixyjQ+e
         rggvWxI6hweaYAZcYFvzbdHWdhXFjyMm5k/pIMg75NCW5Mpbp1ZqNzax3/U75FcPSsZp
         kY/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 002/115] exec: avoid gcc-8 warning for get_task_comm
Date: Fri,  2 Mar 2018 09:50:05 +0100
Message-Id: <20180302084503.951478500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815796479050742?=
X-GMAIL-MSGID: =?utf-8?q?1593815796479050742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 3756f6401c302617c5e091081ca4d26ab604bec5 ]

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c             |    7 +++----
 include/linux/sched.h |    6 +++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1216,15 +1216,14 @@ killed:
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
@@ -1502,7 +1502,11 @@ static inline void set_task_comm(struct
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
