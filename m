Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226KIhidQNB7QvgFgatadSA0rsjFsng/hcnhVWMUss8n1FMGdtHLgzAECl3tF1aIZWccLjPU
ARC-Seal: i=1; a=rsa-sha256; t=1519304031; cv=none;
        d=google.com; s=arc-20160816;
        b=VadX4JQjMM1kNpZP9i2jVgVp9ZhDUnrtYmhnztKYQglTbzCGs3Svp4v7Q/D4/2K1x6
         jViQPanidECTS0eGZ3p+CacLWtDEPvbO6VnEJGMQE7gbND24cSbi6ysJaTTiWD2ruOb+
         QQJ9WW/Tot+mOtw5AwkO2rMIaXw7Pg9uz+zAkHHeyq6w6vc29eBaotgG8EYM2sF8Ls+8
         QhSA8Zu+ePq3ziZTg1ECRgyrJFqVB9rk8SWIVWFcg9cCBEj3TdZQ2mrZonliOwBfAN09
         OV8IAeHWtw5wKHieqsOgyalxLrXC4bnHT6zrp0Da8L29SDE6ouBBrIrtxvIrg1pIz5G6
         FLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=2kozv+qUwCiH77WtFuZSU6/5uiZy6pAZHAkEiMAZfBA=;
        b=lr2sVZyvFnn5fhJisjqT1k/BIWNjeHKR+N0WSR8RWR8SISrM3tresJKXlGWzmJxTlD
         15SXQHhIz1n6kBBJIEaW9oNbRfxl8wfHy5E85IlYDTsUl5v4HfkdPds48Jm2uc5IpyPm
         qRzWYCbqtkoiRGUgY6eU93eNLTqNkbL2E/Ywm8nKP8VQaTUMCBCi/hawjtbMAkW/1UZX
         dsgItGH+MoLLI5pRgfLs+Fe1mBhchQ92f0rz9+JhrqVEWlXPHvTZgyI4LEaYrWyVGKQj
         qHbQvfMZEaTls3fWkIz9Y79lQuJ0rE10tjSsZmFmB5bRtgDGeB2oD2aUrKaVXPfpzq8H
         a78g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=CTSxkM2V;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=CTSxkM2V;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeBVMxu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 07:53:50 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44882 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbeBVMxu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 07:53:50 -0500
From: Zong Li <zongbox@gmail.com>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: zong@andestech.com, greentime@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH] selftest: support running subset of selftests for run_kselftest.sh
Date: Thu, 22 Feb 2018 20:53:00 +0800
Message-Id: <20180222125300.15681-1-zongbox@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593105744237110038?=
X-GMAIL-MSGID: =?utf-8?q?1593105744237110038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Simply use the first argument to specify the subset of selftests.
Use comma notation to separate multiple tests.
(e.g. ./run_kselftest.sh size,timers,...)
Default behaviour is running all selftests.

Each selftest be defined as function that we can run one of selftests.
The function name has underline as prefix to avoid confilct with
built-in command of shell.
(e.g. The exec is built-in command of shell)
The hyhpen of function name be replace to the underline because
not all shells can use hyphen in function name, like sh, ash and so on.

Signed-off-by: Zong Li <zong@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..08e2a855f187 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -128,13 +128,22 @@ ifdef INSTALL_PATH
 
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		echo "_$${TARGET//-/_}()" >> $(ALL_SCRIPT); \
+		echo "{" >> $(ALL_SCRIPT); \
 		echo "echo ; echo Running tests in $$TARGET" >> $(ALL_SCRIPT); \
 		echo "echo ========================================" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
+		echo "}" >> $(ALL_SCRIPT); \
+		echo "" >> $(ALL_SCRIPT); \
 	done;
 
+	echo "TARGETS=\$${1:-\`ls -d */ | sed 's#/##' \`}" >> $(ALL_SCRIPT);
+	echo "for TARGET in \$${TARGETS//,/ }; do" >> $(ALL_SCRIPT);
+	echo "    _\$${TARGET//-/_}" >> $(ALL_SCRIPT);
+	echo "done" >> $(ALL_SCRIPT);
+
 	chmod u+x $(ALL_SCRIPT)
 else
 	$(error Error: set INSTALL_PATH to use install)
-- 
2.16.1

