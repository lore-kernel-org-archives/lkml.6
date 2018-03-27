Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488fGdQNI7ybOCXYv2KBhEDGi9cW2oPx7JlvplFcREWWOP9SvJrtIkwPOADgMz9UKL3mheY
ARC-Seal: i=1; a=rsa-sha256; t=1522168932; cv=none;
        d=google.com; s=arc-20160816;
        b=K88NwAbbxvBxKTbPmEb3891hrHn3V9jBQgaGSCxvRNlJ/QGghqKhv0aZPLgMab3Eue
         HiiW4GGGh6GuOgRUuxk4kwa0L9Hy6+H8Mw9+ZWFSIrbXjhvm8VR2JFKHuGeGomGFrdsy
         0oG6+tX/BjAtohF0p9d0CB6HVA0zmIBgVm1uUtFI8JcrsvOhBSey2DS7ADYXehShhWAz
         BCNTTj2fJjePmEh6+m30FoCxY1VIv8sR+yfRkZZonh3laYoLO4ANiDENGcYL3zHporqj
         ygvQpiSQRpRiAXO8KLEFFZW6Yb9NLFxkN3KNHhjCgqIpckHHywMESuo4hfcobmy7piJq
         76gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LbCAhuTDqc3p/Z8N5KzN3BMljeqxw+E0x4SXHKxLypM=;
        b=zcoV68EsFkP0uzzMmIRT9/qOaVuysT/gUBEqRyL8GrnU6O+umarEDAUE6WK6NUqskG
         kp5ZRIuzrBQvlBktxslEzQgmAfyvRJ+EHVJZ5n56GsrLjLyk5fhQLpk/th+3rRfgtYHy
         c7JtyjBuvPL2dJByMi4sWNIooJZFlHXfqNslI7k+42ZHcaDFMt26C28zh7fsKRGZSGsS
         YsBijCq9A5/MN7hWUpJlzWXBA5+RFt4SHetu8FGw9yI7NsuxEoGgBr2ONwA1eozsg9/S
         B4leQkOIV2TKbO2VaPlbx6lWAMsZXIy0ABixUNHBhAn+0V+xFqHbvtfh/k4SVKkVJ+Sc
         CJcQ==
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
Subject: [PATCH 4.15 084/105] selftests/x86/ptrace_syscall: Fix for yet more glibc interference
Date: Tue, 27 Mar 2018 18:28:04 +0200
Message-Id: <20180327162803.442514243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109202615623395?=
X-GMAIL-MSGID: =?utf-8?q?1596109810078061641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -183,8 +183,10 @@ static void test_ptrace_syscall_restart(
 		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
 			err(1, "PTRACE_TRACEME");
 
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
 		printf("\tChild will make one syscall\n");
-		raise(SIGSTOP);
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
 
 		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
 		_exit(0);
@@ -301,9 +303,11 @@ static void test_restart_under_ptrace(vo
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
