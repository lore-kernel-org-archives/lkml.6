Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D824CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984702086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984702086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754445AbeFLXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:23:56 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43250 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeFLXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:23:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 9583741EB2;
        Tue, 12 Jun 2018 23:23:54 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jtxVPI2IfMil; Tue, 12 Jun 2018 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 0BC9A41D41;
        Tue, 12 Jun 2018 23:23:49 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, tom.hromatka@oracle.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: sparc64: Fix to do nothing on non-sparc64
Date:   Tue, 12 Jun 2018 17:23:48 -0600
Message-Id: <20180612232348.27979-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 test fails with the following errors on non-sparc64 systems. Fix
the Makefile to do nothing on non-sparc64 systems to suppress the errors:

make run_tests
adi-test.c: Assembler messages:
adi-test.c:302: Error: no such instruction: `rd %tick,%r13'
adi-test.c:304: Error: no such instruction: `rd %tick,%rbp'
adi-test.c:190: Error: no such instruction: `rd %tick,%rbp'
adi-test.c:192: Error: no such instruction: `rd %tick,%rdx'
adi-test.c:273: Error: no such instruction: `rd %tick,%rbx'
adi-test.c:276: Error: no such instruction: `rd %tick,%rdx'
adi-test.c:217: Error: no such instruction: `rd %tick,%rbp'
adi-test.c:220: Error: no such instruction: `rd %tick,%rdx'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:246: Error: no such instruction: `rd %tick,%rbp'
adi-test.c:248: Error: no such instruction: `rd %tick,%rdx'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
adi-test.c:79: Error: no such instruction: `rd %tick,%rax'
<builtin>: recipe for target 'adi-test' failed
make[1]: *** [adi-test] Error 1
adi: [FAIL]
./drivers_test.sh: 24: ./drivers_test.sh: ./adi-test: not found
../lib.mk:73: recipe for target 'run_tests' failed
make: *** [run_tests] Error 1

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/sparc64/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/sparc64/Makefile b/tools/testing/selftests/sparc64/Makefile
index 2082eeffd779..442f0ca45441 100644
--- a/tools/testing/selftests/sparc64/Makefile
+++ b/tools/testing/selftests/sparc64/Makefile
@@ -1,7 +1,17 @@
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/x86_64/x86/)
+
+ifneq ($(ARCH),sparc64)
+nothing:
+.PHONY: all clean run_tests install
+.SILENT:
+else
+
 SUBDIRS := drivers
 
 TEST_PROGS := run.sh
 
+
 .PHONY: all clean
 
 include ../lib.mk
@@ -44,3 +54,4 @@ override define CLEAN
 		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 	done
 endef
+endif
-- 
2.17.0

