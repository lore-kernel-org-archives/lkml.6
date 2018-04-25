Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/IuuyYocU4GqhkJ7PxgKANJ+5orB7p6hnRIibZqxA9dBPB99STyWYVwNbLmYUQxTfgD1Lq
ARC-Seal: i=1; a=rsa-sha256; t=1524652961; cv=none;
        d=google.com; s=arc-20160816;
        b=CeJ4f7tbhEa2uMI0DCxpmP7wMHSQ5slXAT/DOJH60al6qasfCkMg73QU7LGH1kJCb4
         0/Xc/d72B6EpgSHp6FtMdTCavRWd72iaW69Hklsz+WHhtFKDES4xwkVCa7PhKrZiDDGk
         WfOPyuPb+svuVOBUncorLCmIXwNJNcQV8dywF0e2z3243Z2iXYN47rgBkGDEdS+rxXR0
         QdWk8+iPkcAW/V3mXNcwoEYIUc2hiC/sEdEcyAZjWGwm6tgcnjgituvOBmF+sL+Amp86
         Zc7adLU3N+U7rwUwQru4agPV0e9VQJbz+PdA8sOcXXL50AXDP5pBih9useqEv0jSHmGL
         tnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ibzB5wfMMwBxitw5ummJ3nYjLLEP7ITZJ+isp6nmmbI=;
        b=R4rBW4VobPBATZbP/sS51ACZ5BWgEVHTgkYucGhUbOnUwmSqOkd7UNulYJmxb0DJFS
         mJ9zaQHeI65EkEX9+Dn7Ie7HsnSTyZGFpK7f88WV/7cCpBBV8EMyqxSpZHddvIxfeoer
         FoDf659hT5XpEIydvapGS3orIVbdOT3c8uvcpy/rL8i+ATHoIGsNlbfFvT/ItnOcZLJF
         AoDEs/QIqqcep2kO6j8jr6I+TUYTPQAelywldfsg4L/h9vnvY6P3pbsMABilCf7QUB1m
         1ZzXM7MR1fabNmNbMW+8jxKWbJ1o2XOdAdoFJ3kk8pV6xf0dRojGq7NIpvdzjYDW87Jm
         EHfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 133/183] bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Date: Wed, 25 Apr 2018 12:35:53 +0200
Message-Id: <20180425103247.768018244@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714503890614997?=
X-GMAIL-MSGID: =?utf-8?q?1598714503890614997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>


[ Upstream commit 09584b406742413ac4c8d7e030374d4daa045b69 ]

With CONFIG_BPF_JIT_ALWAYS_ON is defined in the config file,
tools/testing/selftests/bpf/test_kmod.sh failed like below:
  [root@localhost bpf]# ./test_kmod.sh
  sysctl: setting key "net.core.bpf_jit_enable": Invalid argument
  [ JIT enabled:0 hardened:0 ]
  [  132.175681] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to prog_create err=-524 len=4096
  [  132.458834] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:0 ]
  [  133.456025] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to prog_create err=-524 len=4096
  [  133.730935] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:1 ]
  [  134.769730] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to prog_create err=-524 len=4096
  [  135.050864] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [ JIT enabled:1 hardened:2 ]
  [  136.442882] test_bpf: #297 BPF_MAXINSNS: Jump, gap, jump, ... FAIL to prog_create err=-524 len=4096
  [  136.821810] test_bpf: Summary: 348 PASSED, 1 FAILED, [340/340 JIT'ed]
  [root@localhost bpf]#

The test_kmod.sh load/remove test_bpf.ko multiple times with different
settings for sysctl net.core.bpf_jit_{enable,harden}. The failed test #297
of test_bpf.ko is designed such that JIT always fails.

Commit 290af86629b2 (bpf: introduce BPF_JIT_ALWAYS_ON config)
introduced the following tightening logic:
    ...
        if (!bpf_prog_is_dev_bound(fp->aux)) {
                fp = bpf_int_jit_compile(fp);
    #ifdef CONFIG_BPF_JIT_ALWAYS_ON
                if (!fp->jited) {
                        *err = -ENOTSUPP;
                        return fp;
                }
    #endif
    ...
With this logic, Test #297 always gets return value -ENOTSUPP
when CONFIG_BPF_JIT_ALWAYS_ON is defined, causing the test failure.

This patch fixed the failure by marking Test #297 as expected failure
when CONFIG_BPF_JIT_ALWAYS_ON is defined.

Fixes: 290af86629b2 (bpf: introduce BPF_JIT_ALWAYS_ON config)
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_bpf.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -83,6 +83,7 @@ struct bpf_test {
 		__u32 result;
 	} test[MAX_SUBTESTS];
 	int (*fill_helper)(struct bpf_test *self);
+	int expected_errcode; /* used when FLAG_EXPECTED_FAIL is set in the aux */
 	__u8 frag_data[MAX_DATA];
 	int stack_depth; /* for eBPF only, since tests don't call verifier */
 };
@@ -1987,7 +1988,9 @@ static struct bpf_test tests[] = {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"check: div_k_0",
@@ -1997,7 +2000,9 @@ static struct bpf_test tests[] = {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"check: unknown insn",
@@ -2008,7 +2013,9 @@ static struct bpf_test tests[] = {
 		},
 		CLASSIC | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"check: out of range spill/fill",
@@ -2018,7 +2025,9 @@ static struct bpf_test tests[] = {
 		},
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
-		{ }
+		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"JUMPS + HOLES",
@@ -2110,6 +2119,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -2120,6 +2131,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2294,6 +2307,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -5356,6 +5371,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ },
 		.fill_helper = bpf_fill_maxinsns4,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -5411,10 +5427,15 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: Jump, gap, jump, ...",
 		{ },
+#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
+#else
 		CLASSIC | FLAG_NO_DATA,
+#endif
 		{ },
 		{ { 0, 0xababcbac } },
 		.fill_helper = bpf_fill_maxinsns11,
+		.expected_errcode = -ENOTSUPP,
 	},
 	{
 		"BPF_MAXINSNS: ld_abs+get_processor_id",
@@ -6193,7 +6214,7 @@ static struct bpf_prog *generate_filter(
 
 		*err = bpf_prog_create(&fp, &fprog);
 		if (tests[which].aux & FLAG_EXPECTED_FAIL) {
-			if (*err == -EINVAL) {
+			if (*err == tests[which].expected_errcode) {
 				pr_cont("PASS\n");
 				/* Verifier rejected filter as expected. */
 				*err = 0;
