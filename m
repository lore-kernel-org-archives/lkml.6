Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227GsakUu+/LeThevya6/3KX3KDXkh4p5XmCKMvMmPXHE7bwjcySmPfAvkmJKJLHDomfj/vk
ARC-Seal: i=1; a=rsa-sha256; t=1518347517; cv=none;
        d=google.com; s=arc-20160816;
        b=unSfKnlyhlEcyv4A2ITWguT13XswZ6ciPWfNo4zf5Q/MJDu3ELk1rzBPb8+XWNmIxG
         JEG36Pg6prnxuSwsdh86SC7yQduA5OQpXV7hx+03EsAJDeXcxZU42zqnDqQfDmgae8RK
         psyyAIp8QlfCx+ZJX5APGmaDTRm8GAd0VgcPA8sTMNqgss+BO2LzOiE/g+QQofn1WC6Y
         Fdcztw/LjFz3nIy2diZd17Hmz0n+ZzItcPkdGrgr9/y3A9cUEJFV8s1Er/SS2sDLnJyE
         R0ovVxw2udPP9s/59yQiz/YVb3l9iRdK/tqcz0FbEGqayc1hn94NbXoRs9ArSek3URs/
         pQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G+3CH0LksQsaMUKigOP/LrR9NS6VKGoG/boQrIdUOAk=;
        b=cVAcYUapqXRWUJo0jK1mEz+8VGNkyiB7hLX2SuvBKP9NAs5HS6bdx15uSDIs4e80uq
         Zsurk2ienvIc8u2H11CtvzU/YbFm0oWkoY4mCZ1S67Lo+gj5S7rQnhRxdot5dP6fZyI9
         TUb08ZpodTG6Gcf/fLn9+oDD3KuqVRX3vJJ0ySjz/A4rYRI9C2jAD1m5Wy2twRkTHUeZ
         Vk8/TG+6Ksv46V3UPLjXxlPTlRegPAyu7/XhY0FXy7+XirxthqtBLoa21qhYts+thDNE
         juzhFwROSoRlBUHK8lzOS8P4nFhiq2JbcIHDt2/ZEiqDFQ1c5SDL9eBVelF9GP9VcbTp
         y1sA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbeBKLLT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 06:11:19 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:40670 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbeBKLLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 06:11:05 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org
Cc: Andrew Lutomirski <luto@kernel.org>
Subject: [PATCH 2/5] selftests/x86: fix vDSO selftest segfault for vsyscall=none
Date: Sun, 11 Feb 2018 12:10:10 +0100
Message-Id: <20180211111013.16888-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211111013.16888-1-linux@dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102766376680865?=
X-GMAIL-MSGID: =?utf-8?q?1592102766376680865?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vDSO selftest tries to execute a vsyscall unconditionally, even if it
is not present on the test system (e.g. if booted with vsyscall=none or
with CONFIG_LEGACY_VSYSCALL_NONE=y set. Fix this by copying (and tweaking)
the vsyscall check from test_vsyscall.c

CC: Andrew Lutomirski <luto@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 tools/testing/selftests/x86/test_vdso.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 29973cde06d3..558c8207e7b9 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -28,18 +28,52 @@
 
 int nerrs = 0;
 
+typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
+
+getcpu_t vgetcpu;
+getcpu_t vdso_getcpu;
+
+static void *vsyscall_getcpu(void)
+{
 #ifdef __x86_64__
-# define VSYS(x) (x)
+	FILE *maps;
+	char line[128];
+	bool found = false;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
+		return NULL;
+
+	while (fgets(line, sizeof(line), maps)) {
+		char r, x;
+		void *start, *end;
+		char name[128];
+		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
+			   &start, &end, &r, &x, name) != 5)
+			continue;
+
+		if (strcmp(name, "[vsyscall]"))
+			continue;
+
+		/* assume entries are OK, as we test vDSO here not vsyscall */
+		found = true;
+		break;
+	}
+
+	fclose(maps);
+
+	if (!found) {
+		printf("Warning: failed to find vsyscall getcpu\n");
+		return NULL;
+	}
+	return (void *) (0xffffffffff600800);
 #else
-# define VSYS(x) 0
+	return NULL;
 #endif
+}
 
-typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
-
-const getcpu_t vgetcpu = (getcpu_t)VSYS(0xffffffffff600800);
-getcpu_t vdso_getcpu;
 
-void fill_function_pointers()
+static void fill_function_pointers()
 {
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
@@ -54,6 +88,8 @@ void fill_function_pointers()
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
 	if (!vdso_getcpu)
 		printf("Warning: failed to find getcpu in vDSO\n");
+
+	vgetcpu = (getcpu_t) vsyscall_getcpu();
 }
 
 static long sys_getcpu(unsigned * cpu, unsigned * node,
-- 
2.16.1

