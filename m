Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+n7Nuecq9cJvSSazF0N9UJ65AbP94PGzdoM+bQBRggo8ZEnjAov1WlMd5kUI0U+0tspAmv
ARC-Seal: i=1; a=rsa-sha256; t=1522913965; cv=none;
        d=google.com; s=arc-20160816;
        b=WmgyehkqEQPl/suq+PtqFdhW6ZSCtFBzUPx6b29Hnzr4w/S8VALD+Q9/OIsTKVznKU
         sd+fuyNPSglTNA3giB01HgxBIJE2ZjfJWKifkmZHzgxScS/SCXMiNLaAaDY2G3K/Q1LS
         kqDqAZbJB7Bhrm2UHGx57VZ4AYO58INvuXcMjbFyGzNQdMu7+jVTfQB/cSZ3xi2ZNm8P
         jVkhbCPyfAvr1x7vvffxOt6ytbfqMJMXuVRK4EkFwklt+qEGH26VjRlnadxH7D8JdJq+
         +ZFoaQp218ZQgl9QWH1UN45bSzT471SbBq1yX7FEKGW2njByUVyzyvb/WuMckRGt8j0M
         PPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=q1WlORaGygP4jy8mju4JkaNtWjbNrGVw8tbrHVKudrk=;
        b=fT/14J6GEvlo8dxZjONVY2IK3t4RhTSBRd7NTc4Z2e0HyF+VTZ4oF7u7nWwaHgwmtu
         VC/rHTeiHI8x1uUYdIRf9XGfvMeSj4lZ2C88GxSjU+qmrJq5OuKFXQxEYwaY1lHJBVnx
         Nzq/cWW91Y3nrnlG/QrqB+GstiT+AF8R80iH4oSeWAz+hBMnGWYhvpyIMZFrUR391gie
         yeeGzkHchHom+C6hlbw4KF0Hk2KHdeOutoGDxb9++VEzIiOJkUd/4PeYNC4+jK9YPgGu
         Xxo0ZH2EIjf06rv49HMVXYdXP52aL28LrhhLr5TZIqfDIcKwN1VMc8uvginVz8BusAW3
         I9Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jrtjesCi;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jrtjesCi;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDEHjN (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 5 Apr 2018 03:39:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50676 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeDEHjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Apr 2018 03:39:12 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, pintu.ping@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] selftests/android/ion: fix heap_type may be uninitialized
Date: Thu,  5 Apr 2018 09:39:07 +0200
Message-Id: <20180405073907.30615-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180308134845.32409-1-anders.roxell@linaro.org>
References: <20180308134845.32409-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594377569744869523?=
X-GMAIL-MSGID: =?utf-8?q?1596891034393035757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc warns that 'heap_type' is not initialized if we don't come through
any of the two 'case' statesments before:

ionapp_export.c:91:2: warning: ‘heap_type’ may be used uninitialized in
this function [-Wmaybe-uninitialized]
  printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the current code, we initialize the heap_type to -1 before the 'case'
statements. We also change the print_usage function to state that
heap_type and heap_size isn't optional, they are mandatory.

Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer sharing")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/android/ion/ionapp_export.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
index a944e72621a9..67a0263a7f28 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -31,8 +31,10 @@
 
 void print_usage(int argc, char *argv[])
 {
-	printf("Usage: %s [-h <help>] [-i <heap id>] [-s <size in bytes>]\n",
+	printf("Usage: %s [-h <help>] -i <heap id> -s <size in bytes>\n",
 		argv[0]);
+	printf("    Supported heap id's 0 or 1\n");
+	printf("    Heap size > 0\n");
 }
 
 int main(int argc, char *argv[])
@@ -40,7 +42,8 @@ int main(int argc, char *argv[])
 	int opt, ret, status, heapid;
 	int sockfd, client_fd, shared_fd;
 	unsigned char *map_buf;
-	unsigned long map_len, heap_type, heap_size, flags;
+	unsigned long map_len, heap_size, flags;
+	long heap_type;
 	struct ion_buffer_info info;
 	struct socket_info skinfo;
 
@@ -50,6 +53,7 @@ int main(int argc, char *argv[])
 	}
 
 	heap_size = 0;
+	heap_type = -1;
 	flags = 0;
 
 	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
@@ -68,7 +72,7 @@ int main(int argc, char *argv[])
 				heap_type = ION_HEAP_TYPE_SYSTEM_CONTIG;
 				break;
 			default:
-				printf("ERROR: heap type not supported\n");
+				print_usage(argc, argv);
 				exit(1);
 			}
 			break;
@@ -82,8 +86,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (heap_size <= 0) {
-		printf("heap_size cannot be 0\n");
+	if (heap_size <= 0 || heap_type < 0) {
 		print_usage(argc, argv);
 		exit(1);
 	}
-- 
2.11.0

