Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161373AbeE1OkR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932257AbeE1KbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:31:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/329] bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y
Date: Mon, 28 May 2018 12:00:12 +0200
Message-Id: <20180528100249.714230284@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 };
 
@@ -1900,7 +1901,9 @@ static struct bpf_test tests[] = {
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
@@ -1910,7 +1913,9 @@ static struct bpf_test tests[] = {
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
@@ -1921,7 +1926,9 @@ static struct bpf_test tests[] = {
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
@@ -1931,7 +1938,9 @@ static struct bpf_test tests[] = {
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
@@ -2023,6 +2032,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{
 		"check: LDX + RET X",
@@ -2033,6 +2044,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"M[]: alt STX + LDX",
@@ -2207,6 +2220,8 @@ static struct bpf_test tests[] = {
 		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
 		{ },
 		{ },
+		.fill_helper = NULL,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Passes checker but fails during runtime. */
 		"LD [SKF_AD_OFF-1]",
@@ -4803,6 +4818,7 @@ static struct bpf_test tests[] = {
 		{ },
 		{ },
 		.fill_helper = bpf_fill_maxinsns4,
+		.expected_errcode = -EINVAL,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Very long jump",
@@ -4858,10 +4874,15 @@ static struct bpf_test tests[] = {
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
@@ -5632,7 +5653,7 @@ static struct bpf_prog *generate_filter(
 
 		*err = bpf_prog_create(&fp, &fprog);
 		if (tests[which].aux & FLAG_EXPECTED_FAIL) {
-			if (*err == -EINVAL) {
+			if (*err == tests[which].expected_errcode) {
 				pr_cont("PASS\n");
 				/* Verifier rejected filter as expected. */
 				*err = 0;
