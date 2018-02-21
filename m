Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225quTZCXCDBkf+KdXZEwaXbOS5PhrZ00eGCfO6UlsRIqZsg8lCzGHEouuc1D7/4UHVURv+d
ARC-Seal: i=1; a=rsa-sha256; t=1519218393; cv=none;
        d=google.com; s=arc-20160816;
        b=BLr1QHg7zRjAKDko/N5xNwuc3ZCcMD0UWHp48mfod39VokjrMxbqLVb//4n0Zm0H99
         E9pRMcwc8E4fo/Xy1hwsvzPLcZAFYsuOli0N8VyTOBjlhB+EGhN1adjYmCSChpC9xlnf
         Ica6CM5wd5TX9U57/7s6AlHQ9+FzLUyquv+y3JQb99ETTlxEj5aZltt5TmjNHYoC48KC
         pCP5sHpKT+M3uS2/TajtiuK0SnV9HV4nIloTIkMB5LLTa4kfpptXIJhu4shyH4h3NTyv
         uSY+1epqU1ve2I/ZkAET6+2xW6jqlIrJltfhYB+4qqHdks90fJbY0poNpYKOCQ/FAmfc
         tKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cFpB9WfPpGU6qxRK3SrI6LmkrgMJYOoBcmpymQ1OGLM=;
        b=p/Ix9IjW9A21kyC6KsqIY2zV2Dh6kEKhTw1wC0KedjF3frhrX2wb2EjRHCK6lzJyJf
         s73RXQZ9z+RIQes7FWQnlzSRtXgpC3gum4p//r27frHughEEJCuKUjjq4OpJ4whVBRfm
         +NZqMCIAwUoubfOdazZ3pZ0HZNQ3qndOZ1zoDz0hXiU1NxT4v6l8N91tSsBLSWSipRm0
         dXGERTnLHJWJojINsfLTLJ7ffOosejmd5kR0T+87AF1kyzml/eb1EQ3PbhciyxgbHXIE
         OVD0YUFOLU1/LfR1kBb15H04uc2QlpTqSdxcUS94guxyZNycCx8EJx1QTqCSJymNC9rY
         tBGg==
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
Subject: [PATCH 4.15 008/163] selftests: seccomp: fix compile error seccomp_bpf
Date: Wed, 21 Feb 2018 13:47:17 +0100
Message-Id: <20180221124530.453810501@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015487390350295?=
X-GMAIL-MSGID: =?utf-8?q?1593015946403738363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
