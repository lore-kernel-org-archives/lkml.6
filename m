Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtt6XbbO1TAiWfm+WrQdnPQjYO4RNxr8/ugkSYatrVznjh8Eq2oxsyBZw0knKiEJS0GW2js
ARC-Seal: i=1; a=rsa-sha256; t=1519981296; cv=none;
        d=google.com; s=arc-20160816;
        b=MngOtlNchzCN/1oT4B/qr5U5ZqAKvRTP3lcswve4wfWkcRJKyUcPQO9lG3L1j5H0v+
         AkpymOTc4QH3rCfWE1B4PB+OINoMrrOWknxeldZBDsy4jWli63Ck/jwmKr4XNNkwICXj
         sF+IcAFb4W8XGN0PIU+V9bK4HQXpRIOmBlOv9yzIX7bsdCnCoImmhY/NA1sy8ntrCITj
         ALUtYKoJ5aakh/r2fPId4rD96kGcdAfL3vw8bNg13h8z9yuym189qsM5i3tbZ8nU6eoo
         5lY2YdlyGywEUra5LN784QiG8QE4dG8eBqV+YlyUVbdYSWVl+nx2WLltZhWKxnLnRNi4
         at0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kJoRTtF16mxzHk0EOd9x3fEcGO2HZHsO6Xffknprmpo=;
        b=w7aVC3s7QH8XL7ZqS/h5NVLgIDpGLd4IwgdeQm2xM3D3OiJjLA7WsUZRY4AXgP9vgm
         TeCpLHq95U19yDZnf5BnRikUGULtBefv0QSRnKGeJxL5d9rcKAGyfKSuD98ZXilvk8HS
         WRuJTyj8DZqA+0TcA5f0zFPjPBxtlew7d8nweshjQ/M0+v1Yt+VgEnTPwd4pc1bPO/vd
         1Bz3/OF+JO+H7um+zrUqZFjnJIth58/5g1dB87v0gZ4bd0ZjeCYOEuxgVj47j4ctAGhq
         O8DfLWpDSHfo/vybnzZV04UlYubMpTntgv48ijKJ02MLTjoWf+gPF/i43Sh3QI+DYj2r
         92Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	live-patching@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 023/115] x86/stacktrace: Make zombie stack traces reliable
Date: Fri,  2 Mar 2018 09:50:26 +0100
Message-Id: <20180302084504.810028961@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815907610974479?=
X-GMAIL-MSGID: =?utf-8?q?1593815907610974479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>


[ Upstream commit 6454b3bdd138dfc640deb5e7b9a0668fca2d55dd ]

Commit:

  1959a60182f4 ("x86/dumpstack: Pin the target stack when dumping it")

changed the behavior of stack traces for zombies.  Before that commit,
/proc/<pid>/stack reported the last execution path of the zombie before
it died:

  [<ffffffff8105b877>] do_exit+0x6f7/0xa80
  [<ffffffff8105bc79>] do_group_exit+0x39/0xa0
  [<ffffffff8105bcf0>] __wake_up_parent+0x0/0x30
  [<ffffffff8152dd09>] system_call_fastpath+0x16/0x1b
  [<00007fd128f9c4f9>] 0x7fd128f9c4f9
  [<ffffffffffffffff>] 0xffffffffffffffff

After the commit, it just reports an empty stack trace.

The new behavior is actually probably more correct.  If the stack
refcount has gone down to zero, then the task has already gone through
do_exit() and isn't going to run anymore.  The stack could be freed at
any time and is basically gone, so reporting an empty stack makes sense.

However, save_stack_trace_tsk_reliable() treats such a missing stack
condition as an error.  That can cause livepatch transition stalls if
there are any unreaped zombies.  Instead, just treat it as a reliable,
empty stack.

Reported-and-tested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: live-patching@vger.kernel.org
Fixes: af085d9084b4 ("stacktrace/x86: add function for detecting reliable stack traces")
Link: http://lkml.kernel.org/r/e4b09e630e99d0c1080528f0821fc9d9dbaeea82.1513631620.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/stacktrace.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -160,8 +160,12 @@ int save_stack_trace_tsk_reliable(struct
 {
 	int ret;
 
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * "reliably" empty.
+	 */
 	if (!try_get_task_stack(tsk))
-		return -EINVAL;
+		return 0;
 
 	ret = __save_stack_trace_reliable(trace, tsk);
 
