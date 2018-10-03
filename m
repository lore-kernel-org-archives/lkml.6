Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81542089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81542089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJCVbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:31:04 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46470 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:31:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 7C07741386;
        Wed,  3 Oct 2018 14:42:21 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nw57Rp_344vz; Wed,  3 Oct 2018 14:42:21 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2357F41379;
        Wed,  3 Oct 2018 14:42:13 +0000 (UTC)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, Shuah Khan <shuah@kernel.org>
From:   Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kselftest fixes update for Linux-4.19-rc7
Message-ID: <ec2d8d2b-c5ac-5ac2-57fd-74efaa7ed0b6@kernel.org>
Date:   Wed, 3 Oct 2018 08:42:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------704CDE80DF4921ABBADA730A"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------704CDE80DF4921ABBADA730A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Greg,

Please pull the following kselftest for 4.19-rc7.

linux-kselftest-4.19-rc7

This fixes update for 4.19-rc7 consists one fix to rseq test to prevent
it from seg-faulting when compiled with -fpie.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.19-rc7

for you to fetch changes up to ce01a1575f45bf319e374592656441021a7f5823:

  rseq/selftests: fix parametrized test with -fpie (2018-09-27 12:59:19 -0600)

----------------------------------------------------------------
linux-kselftest-4.19-rc7

This fixes update for 4.19-rc7 consists one fix to rseq test to prevent
it from seg-faulting when compiled with -fpie.

----------------------------------------------------------------
Mathieu Desnoyers (1):
      rseq/selftests: fix parametrized test with -fpie

 tools/testing/selftests/rseq/param_test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

----------------------------------------------------------------

--------------704CDE80DF4921ABBADA730A
Content-Type: text/x-patch;
 name="linux-kselftest-4.19-rc7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.19-rc7.diff"

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 642d4e12abea..eec2663261f2 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -56,15 +56,13 @@ unsigned int yield_mod_cnt, nr_abort;
 			printf(fmt, ## __VA_ARGS__);	\
 	} while (0)
 
-#if defined(__x86_64__) || defined(__i386__)
+#ifdef __i386__
 
 #define INJECT_ASM_REG	"eax"
 
 #define RSEQ_INJECT_CLOBBER \
 	, INJECT_ASM_REG
 
-#ifdef __i386__
-
 #define RSEQ_INJECT_ASM(n) \
 	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
@@ -76,9 +74,16 @@ unsigned int yield_mod_cnt, nr_abort;
 
 #elif defined(__x86_64__)
 
+#define INJECT_ASM_REG_P	"rax"
+#define INJECT_ASM_REG		"eax"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG_P \
+	, INJECT_ASM_REG
+
 #define RSEQ_INJECT_ASM(n) \
-	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
-	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
+	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG_P "\n\t" \
+	"mov (%%" INJECT_ASM_REG_P "), %%" INJECT_ASM_REG "\n\t" \
 	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
 	"jz 333f\n\t" \
 	"222:\n\t" \
@@ -86,10 +91,6 @@ unsigned int yield_mod_cnt, nr_abort;
 	"jnz 222b\n\t" \
 	"333:\n\t"
 
-#else
-#error "Unsupported architecture"
-#endif
-
 #elif defined(__s390__)
 
 #define RSEQ_INJECT_INPUT \

--------------704CDE80DF4921ABBADA730A--
