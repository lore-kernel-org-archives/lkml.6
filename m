Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DMy/YYH1UuN0b5v6z9hXOpq5qWmlKR72LQ19ZBLI+ptFZ8/4Wru+QBBj5hU+0PsaZtBjc
ARC-Seal: i=1; a=rsa-sha256; t=1519217955; cv=none;
        d=google.com; s=arc-20160816;
        b=AYxlmqnWc+tGWlJS+fLRKdREBA2BGCShhNdrzFrvOP01/z+C8U8Zcc4dCJa0nvACTU
         wngyCY/pP1VBeP62dpWOMDwEEsJdwz7J4lDJwB5lPY6zFGjOJu9IwKUiv4wFL3qWstw2
         vMFZ/z4Bnj5A4J62R3wXIlhNvrTJbiRUzeQJC3XAKYtpCNm8YkzJyTuIkwfCNUIIpYwe
         zdDef5F9/5uW9T//Mz7FTmL2VBYQv7KFyazPtEVgLdMFtJeJF++6VXnkcGB+Gc8OU8q4
         JpQgZtfJNtH0Q8aLyZY4aa/Iei6a2TjzHiE7lKBFGgG+ElRCM+J7x9QkAcaJlXITGAG2
         aF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RAhOT26S4EMpLdL01maOm9PpLOk207eoLmvg8ewiMlM=;
        b=1Gg4MOq4+01Tr8xV2x2TRDDN010J7g+YzQ0e8lYQlJHajN7fIPe3bmt1psDPVfVT51
         fqMB9ABlui9Dw6K9K+9AFoJf3kzzSPRGQZDGVz9j5Qc8rhUokYWrxY4la+M5o+hWElfq
         tdlgEXX6L5f9WTsjLyxsm0oLZdg/8PJiR9UdxIqO5smUQIF7bFtEfjgDsM6pcs7O0S09
         QNdWQSNRwDa57YrGbEjlPeJplC7SnbFuOQ6kQJtWkLjR3uoR+IxSZx9tIbPjZ9nzQ4yd
         XyCUVRffsvtO8u0skCze5vI8Dpuy7abjwb3LWx5RXsk8RTnWU3BHWsDGvEj1ECJyTKtn
         Jl0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 009/167] selftests: seccomp: fix compile error seccomp_bpf
Date: Wed, 21 Feb 2018 13:47:00 +0100
Message-Id: <20180221124525.113392115@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015487390350295?=
X-GMAIL-MSGID: =?utf-8?q?1593015487390350295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anders Roxell <anders.roxell@linaro.org>

commit 912ec316686df352028afb6efec59e47a958a24d upstream.

aarch64-linux-gnu-gcc -Wl,-no-as-needed -Wall
    -lpthread seccomp_bpf.c -o seccomp_bpf
seccomp_bpf.c: In function 'tracer_ptrace':
seccomp_bpf.c:1720:12: error: '__NR_open' undeclared
    (first use in this function)
  if (nr == __NR_open)
            ^~~~~~~~~
seccomp_bpf.c:1720:12: note: each undeclared identifier is reported
    only once for each function it appears in
In file included from seccomp_bpf.c:48:0:
seccomp_bpf.c: In function 'TRACE_syscall_ptrace_syscall_dropped':
seccomp_bpf.c:1795:39: error: '__NR_open' undeclared
    (first use in this function)
  EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_open));
                                       ^
open(2) is a legacy syscall, replaced with openat(2) since 2.6.16.
Thus new architectures in the kernel, such as arm64, don't implement
these legacy syscalls.

Fixes: a33b2d0359a0 ("selftests/seccomp: Add tests for basic ptrace actions")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1717,7 +1717,7 @@ void tracer_ptrace(struct __test_metadat
 
 	if (nr == __NR_getpid)
 		change_syscall(_metadata, tracee, __NR_getppid);
-	if (nr == __NR_open)
+	if (nr == __NR_openat)
 		change_syscall(_metadata, tracee, -1);
 }
 
@@ -1792,7 +1792,7 @@ TEST_F(TRACE_syscall, ptrace_syscall_dro
 					   true);
 
 	/* Tracer should skip the open syscall, resulting in EPERM. */
-	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_open));
+	EXPECT_SYSCALL_RETURN(EPERM, syscall(__NR_openat));
 }
 
 TEST_F(TRACE_syscall, syscall_allowed)
