Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C23C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8914620842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8914620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbeIXSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59846 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbeIXSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:47:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 326C5109A;
        Mon, 24 Sep 2018 12:45:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 211/235] selftests: vDSO - fix to return KSFT_SKIP when test couldnt be run
Date:   Mon, 24 Sep 2018 13:53:17 +0200
Message-Id: <20180924113124.856557195@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>

[ Upstream commit d2d49495b5c0dffee5c4da5ea12ac0da6679bd08 ]

Fix to return KSFT_SKIP when test couldn't be run because AT_SYSINFO_EHDR
isn't found and gettimeofday isn't defined.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/vDSO/vdso_test.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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


