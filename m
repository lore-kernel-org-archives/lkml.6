Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gO8dFAQD16YKtR4bDpFBdmzGqPmfZb5ZQrU+VaePAbFThoKkxg5uEStTyJRT0V18qx+BN
ARC-Seal: i=1; a=rsa-sha256; t=1522168352; cv=none;
        d=google.com; s=arc-20160816;
        b=gmZsZY/B/s/YrJrmvonfeh5EqAJGhIap56FQcEV/b8PNktPa0MijayJXeOmsCUaLnD
         X+1etIz6U8AItecGFZvpIAVTaeuhletWvDRsHkwJQMtj/Q8CLChFaIlCqIrVtAtIce6Z
         KVxJI4ghK2FRYtKTXSrjiScmLOV4YTbZi20wiAEYzfY3eM+ECe15T4Pgd+2I6pP3hdKy
         O6bLHlfijSYt9I8t0RrDdhfWEerLxMYsN0RFmljm5ZvTU097Ad4xRlS4mK8W8tbc+kg1
         8FtTfaUq+S7O1cpHD0ooe37NGlz7G48pQN0WhRsiZ27184UurN02F1XNagRZ1A3/8esW
         DaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=anDuwdq3x/XAw/ODmKbyRqJ9d74YJRN2ZkgRS3NF11c=;
        b=L2hemcfm8Uj1fWrEmNOaAQ2UTezH7RIWqUqL6aXlP9Hr6IgNzGQ3lgbyL9r5QdhWo7
         TIbtU08Sek8/AdMZydsmrd1DCTwmSj8f19pL1AIF89971GH3wvurHZQmp+fun3HdKNe4
         iKX/ELOavkkVaB+y4tDgjmv8qHjm8oJThs1k2pAhtHR7FCFFm0/LSc50D0CGCBEFj5Ff
         WbWC1SCuGlt9yPSHc4fJeIXYW6hLuEw2C61PrYJJq8dp/lBa+87vZ/ltlfSvF7/YLyY1
         sHOOxOmbyLuka0y83L5P3Mh0NAVVKOL/vSnZMdBwHwjYYogxvUFVzHZH1Jdx+uGWl3JC
         KRow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 49/67] selftests/x86/ptrace_syscall: Fix for yet more glibc interference
Date: Tue, 27 Mar 2018 18:27:41 +0200
Message-Id: <20180327162730.053831105@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109202615623395?=
X-GMAIL-MSGID: =?utf-8?q?1596109202615623395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 4b0b37d4cc54b21a6ecad7271cbc850555869c62 upstream.

glibc keeps getting cleverer, and my version now turns raise() into
more than one syscall.  Since the test relies on ptrace seeing an
exact set of syscalls, this breaks the test.  Replace raise(SIGSTOP)
with syscall(SYS_tgkill, ...) to force glibc to get out of our way.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/bc80338b453afa187bc5f895bd8e2c8d6e264da2.1521300271.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/ptrace_syscall.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -182,8 +182,10 @@ static void test_ptrace_syscall_restart(
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will make one syscall\n");
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
 		_exit(0);
@@ -300,9 +302,11 @@ static void test_restart_under_ptrace(vo
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will take a nap until signaled\n");
 		setsigign(SIGUSR1, SA_RESTART);
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_pause, 0, 0, 0, 0, 0, 0);
 		_exit(0);
