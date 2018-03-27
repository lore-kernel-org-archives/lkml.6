Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OBCL1hQf3s7VTiKtXiIvtiXga+wZJY9BWmggdbW3LbTlBPVNhl76KvxuPTeE+KkxuPZed
ARC-Seal: i=1; a=rsa-sha256; t=1522168638; cv=none;
        d=google.com; s=arc-20160816;
        b=utUmc+MYnFEojSjk0SIxI3voaZ9bCarNmAOV2UYwE5miZaMshiDGO8fyD+m21XD9fA
         12ISF30ys2DJPa5DtOlkHAT2Pu32JjtkM/TOCT0hhoc5LFKLrOyJ6UrglEr2aix0kcJt
         Bai2oUQF7hgSADWNho2xp7hY0850qEE+gA96u5RS0Ij+hggUNeB4umo6glEO0xmG1gt1
         c9kggmGgnsC/StqIRLoae/6PHCyQvKl2YA8bTo7cuFvrn/0WV4YrmFS4zglZKUqOixla
         G4rREUXwp5cs2rmbzTEA6b8AGJ8DvAd6emm1MTvrbR377AhX6xQzLVIM+D7pUaT6zoOz
         ZVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tkz6yq3C99ruSh8RN814PLCOZhdUnedZVo7uieiN9UA=;
        b=L28XEINAHUW9La2m7GVXuMOOojfNbD/bz5IAhJzII9N3W2ZxbnqICH3lZqH3zSwZiO
         zfEZxzr/Pm4YpcROx1FMBboWtGz/C3lv5ZeHbEyfOy7GNWwMScVRB5n3QvDB1+3Josai
         Hc9UZ/GqWoSX5boVk5ThRd+66PMqtG7lyqmK1bcgzydsc9I8uP3FyQ/yZyEqWVv7dwgE
         Fo137EYaawmuQSJ/gXj4da2a7HOh/Vu9MeGHxyuEyKlXe6OGu/IQTEKC34+tHP9nV3dE
         mGn8JqoCInOifRHph7eyi/ORrjBZKKSSyf7oMC8RL5nmeZrH/3dlYxnZyqrP6nO8SwXs
         R+nw==
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
Subject: [PATCH 4.14 079/101] selftests/x86/ptrace_syscall: Fix for yet more glibc interference
Date: Tue, 27 Mar 2018 18:27:51 +0200
Message-Id: <20180327162754.925376966@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109202615623395?=
X-GMAIL-MSGID: =?utf-8?q?1596109502779613372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
