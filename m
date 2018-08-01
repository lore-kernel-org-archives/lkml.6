Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2148BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FEB20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FEB20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbeHAUYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:24:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbeHATDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:32 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEAEBFAA;
        Wed,  1 Aug 2018 16:58:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 083/336] selftests: kvm: return Kselftest Skip code for skipped tests
Date:   Wed,  1 Aug 2018 18:46:58 +0200
Message-Id: <20180801165032.362957411@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit ab0e9c4b91ca902b1cae593b3dec9c4c7a724f9f ]

When kvm test is skipped because of unmet dependencies and/or unsupported
configuration, it exits with error which is treated as a fail by the
Kselftest framework. This leads to false negative result even when the test
could not be run.

Change it to return kselftest skip code when a test gets skipped to clearly
report that the test could not be run.

Change it to use ksft_exit_skip() when the test is skipped. In addition,
refine test_assert() message to include strerror() string and add explicit
check for EACCES to cleary identify when test doesn't run when access is
denied to resources required e.g: open /dev/kvm failed, rc: -1 errno: 13

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kvm/lib/assert.c          |    9 +++++++--
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -13,6 +13,8 @@
 #include <execinfo.h>
 #include <sys/syscall.h>
 
+#include "../../kselftest.h"
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
@@ -70,8 +72,9 @@ test_assert(bool exp, const char *exp_st
 
 		fprintf(stderr, "==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
-			"  pid=%d tid=%d\n",
-			file, line, exp_str, getpid(), gettid());
+			"  pid=%d tid=%d - %s\n",
+			file, line, exp_str, getpid(), gettid(),
+			strerror(errno));
 		test_dump_stack();
 		if (fmt) {
 			fputs("  ", stderr);
@@ -80,6 +83,8 @@ test_assert(bool exp, const char *exp_st
 		}
 		va_end(ap);
 
+		if (errno == EACCES)
+			ksft_exit_skip("Access denied - Exiting.\n");
 		exit(254);
 	}
 
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -28,6 +28,8 @@
 #include <string.h>
 #include <sys/ioctl.h>
 
+#include "../kselftest.h"
+
 #ifndef MSR_IA32_TSC_ADJUST
 #define MSR_IA32_TSC_ADJUST 0x3b
 #endif


