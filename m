Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E7246E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829E7246E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934184AbeFVRvS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:51:18 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:35682 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933414AbeFVRvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:51:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 48A5EC11D2;
        Fri, 22 Jun 2018 17:51:15 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F0zb28cf34pV; Fri, 22 Jun 2018 17:51:15 +0000 (UTC)
Received: from shuah-XPS-13-9350.sisa.samsung.com (unknown [50.236.218.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 098CDC072B;
        Fri, 22 Jun 2018 17:51:09 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, ghackmann@google.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vDSO - fix to return KSFT_SKIP when test couldn't be run
Date:   Fri, 22 Jun 2018 11:51:08 -0600
Message-Id: <20180622175108.24292-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return KSFT_SKIP when test couldn't be run because AT_SYSINFO_EHDR
isn't found and gettimeofday isn't defined.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/vDSO/vdso_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test.c b/tools/testing/selftests/vDSO/vdso_test.c
index 2df26bd0099c..eda53f833d8e 100644
--- a/tools/testing/selftests/vDSO/vdso_test.c
+++ b/tools/testing/selftests/vDSO/vdso_test.c
@@ -15,6 +15,8 @@
 #include <sys/auxv.h>
 #include <sys/time.h>
 
+#include "../kselftest.h"
+
 extern void *vdso_sym(const char *version, const char *name);
 extern void vdso_init_from_sysinfo_ehdr(uintptr_t base);
 extern void vdso_init_from_auxv(void *auxv);
@@ -37,7 +39,7 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 	if (!sysinfo_ehdr) {
 		printf("AT_SYSINFO_EHDR is not present!\n");
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
@@ -48,7 +50,7 @@ int main(int argc, char **argv)
 
 	if (!gtod) {
 		printf("Could not find %s\n", name);
-		return 1;
+		return KSFT_SKIP;
 	}
 
 	struct timeval tv;
@@ -59,6 +61,7 @@ int main(int argc, char **argv)
 		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
 		printf("%s failed\n", name);
+		return KSFT_FAIL;
 	}
 
 	return 0;
-- 
2.17.1

