Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsQQHajopmHhSqApQm21XcqaeuppwTsSL0xX9TCj+kgHU1fVfIgDJy5rEiKZJoZdZXA3unH
ARC-Seal: i=1; a=rsa-sha256; t=1521798307; cv=none;
        d=google.com; s=arc-20160816;
        b=mAMF2KDMfLgsm/gwn7ij4K2Yo+mcDMrqV7+RsYJMP2mlZP0g24mP9NICJEgcfg8qvB
         +F4ZpwbJfOEOS1BzCT3e4kAQpuB0BTWUJxAiOF8ImR2hC5Zx3Z5m65+0MxdipFhoNX1z
         tJTHrmQZPnJOJSAdY+HXBDQa131yoPQoIJHxf15vcsJp4mb5XeJQDMkDHZjZAuyHtW0t
         ppKpfUNnCAhfoCN/7sf/uEnZ3VycXEPaISffbzuCVztHePXOuT1p6VPDDoTrHlc35KIP
         w+Ijpdoz/JqNMdUp55/2aaQTI8AabynpFxtkVuR9oqNuDOFN0fEP+D/ldL9wIXtWNEWr
         37AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Xqx03BhfhzYTIJw9/qPCKlVHuhGqdcRBpvF2rA9m9Uc=;
        b=wBnffNFIIIkwCV3gh/CfYV/Vf2/MPPd0zY7p90rWZ7lr3tyCil+LEzm0HeQ/umpStt
         w253tELU7VEQC0KK6Gt0T744AGh5QBeTKX5fBebXgFZ5TxsJxMvSFvgyo4MdLsyl573A
         4DnRnNaiyVtncNd/3JPBbwGooEL/S+PkXU9LdsYg05H2FlcQwoCZLAVe/isJaA11X1kH
         f+/Ax8Z7iosIhwAMJNzuV6NyrzGAtObdOYZ0XxAdNxyxcFem0HwcD1Hy9OeZH60kd0+U
         +QPHdsKGYA4pTNSy0czrEYZrp0ERppgEs+h+EdRWwIY4MiGkFpWkh46wJj3SQ56mPmFG
         j2kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeCWJom (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Mar 2018 05:44:42 -0400
Received: from ozlabs.org ([103.22.144.67]:34789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbeCWJok (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Mar 2018 05:44:40 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: shuahkh@osg.samsung.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: Print the test we're running to /dev/kmsg
Date: Fri, 23 Mar 2018 20:44:27 +1100
Message-Id: <20180323094427.21938-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595721182279802309?=
X-GMAIL-MSGID: =?utf-8?q?1595721182279802309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some tests cause the kernel to print things to the kernel log
buffer (ie. printk), in particular oops and warnings etc. However when
running all the tests in succession it's not always obvious which
test(s) caused the kernel to print something.

We can narrow it down by printing which test directory we're running
in to /dev/kmsg, if it's writable.

Example output:

  [  170.149149] kselftest: Running tests in powerpc
  [  305.300132] kworker/dying (71) used greatest stack depth: 7776 bytes left
  [  808.915456] kselftest: Running tests in pstore

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..0fbe778efd5f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,6 +130,7 @@ ifdef INSTALL_PATH
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
 		echo "echo ========================================" >> $(ALL_SCRIPT); \
+		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
-- 
2.14.1

