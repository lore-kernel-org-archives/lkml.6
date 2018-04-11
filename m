Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx482AGkzyDu9U6ElMfEGk38sTvu1NBgXVuwInh63qI3eeLEbj4RwFZ5do/BHPzgWO3pgvw0R
ARC-Seal: i=1; a=rsa-sha256; t=1523473549; cv=none;
        d=google.com; s=arc-20160816;
        b=rww2nWLLcwIUby9eclLU9w43YfuJOnMdoJZOn79W7Q9VxluKxPmseEIVz1kIyWokto
         Iv7xQ6K11vky6P959nYgcQPdomqHZRuHoszqerdNH7avi5xwVIw+5UNjmDlea3VQ95KJ
         xNKv16FjS3gwB3n88R6M7sQ6dq4iUB39KW89ZawRTLN6M2s6bebinp6Noi00B+ToBvc+
         dAGGBnRwd0b8SJnqVLk4H6xbojJfgV5ELNX5WNgp9lC89XCkm8dbQvib0JHXd/pg+b6/
         vZx0vyjzQfxTRuhe1uCko1jDvAi0ApQn4Z6nWsHYlENy37Zsnw1sxWNcKRDO6En2k9KS
         dhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eRTOdOlhZ/fJ+Je2jeM+urjrA1FKtvvm3S7PAIXfPUw=;
        b=uB/7ldLF3xnvkPwLmWXgCKiJOwW2NTKciomYacI1PG4Y+cnxsnP6SUCJrDYVtjCR51
         ZxexSWzOUn+YYoaZjV5ZrwAdFsjCKGrYNSzvTE4GJadBWgutg4hl+wTT4XkqC4V3DrQQ
         zX0TNnoDx7PnCsh3DxWoYkn5JBeUVN0LO7+er7FC2RMnGLgVtLkPJ1cfqnql98Y4oEmu
         9VSAsdEOEQ69+DUqJynwio4d9H0e/yq1LPVcgG2w4Ei1Yq2m/t+YW6phwLMIy095Ybr7
         B5aYLaIREe2GO/lSif1cXJ16jEU9oz6POXNNer4lhnxt+RL2K3/K8PZL4vEu4drkdVjq
         YgCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Lutomirski <luto@amacapital.net>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Will Drewry <wad@chromium.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 255/310] selftests: kselftest_harness: Fix compile warning
Date: Wed, 11 Apr 2018 20:36:34 +0200
Message-Id: <20180411183633.401787508@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477800958890908?=
X-GMAIL-MSGID: =?utf-8?q?1597477800958890908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Micka�l Sala�n" <mic@digikod.net>


[ Upstream commit 34a048cc06802556e5f96f325dc32cc2f6a11225 ]

Do not confuse the compiler with a semicolon preceding a block. Replace
the semicolon with an empty block to avoid a warning:

  gcc -Wl,-no-as-needed -Wall -lpthread seccomp_bpf.c -o /.../linux/tools/testing/selftests/seccomp/seccomp_bpf
  In file included from seccomp_bpf.c:40:0:
  seccomp_bpf.c: In function ‘change_syscall’:
  ../kselftest_harness.h:558:2: warning: this ‘for’ clause does not guard... [-Wmisleading-indentation]
    for (; _metadata->trigger;  _metadata->trigger = __bail(_assert))
    ^
  ../kselftest_harness.h:574:14: note: in expansion of macro ‘OPTIONAL_HANDLER’
   } while (0); OPTIONAL_HANDLER(_assert)
                ^~~~~~~~~~~~~~~~
  ../kselftest_harness.h:440:2: note: in expansion of macro ‘__EXPECT’
    __EXPECT(expected, seen, ==, 0)
    ^~~~~~~~
  seccomp_bpf.c:1313:2: note: in expansion of macro ‘EXPECT_EQ’
    EXPECT_EQ(0, ret);
    ^~~~~~~~~
  seccomp_bpf.c:1317:2: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the ‘for’
    {
    ^

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Will Drewry <wad@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1318,7 +1318,7 @@ void change_syscall(struct __test_metada
 	iov.iov_len = sizeof(regs);
 	ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
 #endif
-	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, ret) {}
 
 #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
     defined(__s390__) || defined(__hppa__)
