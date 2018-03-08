Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsj3j4viwoSw8wUSbM9GId2u5OR9BIhhWMEMWkvBnX5UlQXpNHupz1qul4ZXc23mXs5Q9Am
ARC-Seal: i=1; a=rsa-sha256; t=1520516938; cv=none;
        d=google.com; s=arc-20160816;
        b=lmW3yqSlXExi7ENl0mgvSc95giGv0kIzaR306BOEKGTqUVzgm0OpEeqH5Afu58RgUI
         HOKWdrsxgOXyNXo5z+Sh9QzqqIhhEb6JKe9BPEIl7LGlZWDjr0lWFjU/MCem2DIS0T+6
         H8+TxPMjWdmXiNllAPe1AlUMdThIAy8Nan1cBgmNZ4z9wyxP3ZPUmrCVmFpkpCZXK00E
         QDK8VGwFD5GpJcshBGy2OXijgZgLx+WAXRxApQayQksvFyPqIyy4siEuwiZEG/7RqQAP
         0oGpT4IgMajt/+5HsGMAiazjUs/G28JyE8AKwzNNMn8hn1bNTBWGjogvfrWtKdKKGPsa
         8WuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=VJZpGxZw1Nxh0fRcy6KZ5rzPZB3ZVj0de6X1hKMmfyo=;
        b=o+qbE34NGqqXT7rXgkbQrew3lnsbwqyCYuIE8hClsiN08l1iaQMDhgxqm7m6EZwg7Z
         vQFnzSFGsw/UfEjU0vdzPp7Sk/RVh6A8mqNI1rqZhfolZBWcoimd9iTdUT3wLhAy+miy
         JnJ4nFgym6xjPZEq765+GFvdp38+bJ23ioo+vuIiFMoljmZR++HINwmE0zZvbjFmFmZH
         P0IdXZ8rZZVIBUnrNiARZMip2twTsi1mk+KxRsEleeJawdFYORsCS8/A+qRTd9YquHWr
         kWcpUCbeMBpMKcl61O2xJorL8b0lyypgvhKBV6qN+KprYVYpNy7IoxN2rDBOQ2b2/yPm
         MMTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=b5wRXkwj;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=b5wRXkwj;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755904AbeCHNs5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 08:48:57 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40457 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbeCHNs5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 08:48:57 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: pintu.ping@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/android/ion: fix heap_type may be uninitialized
Date: Thu,  8 Mar 2018 14:48:45 +0100
Message-Id: <20180308134845.32409-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594377569744869523?=
X-GMAIL-MSGID: =?utf-8?q?1594377569744869523?=
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
 .../testing/selftests/android/ion/ionapp_export.c  | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
index a944e72621a9..b42f803e9d2a 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -31,16 +31,24 @@
 
 void print_usage(int argc, char *argv[])
 {
-	printf("Usage: %s [-h <help>] [-i <heap id>] [-s <size in bytes>]\n",
+	printf("Usage: %s [-h <help>] -i <heap id> -s <size in bytes>\n",
 		argv[0]);
 }
 
+void heap_type_error_text(void)
+{
+	printf("heap_type must be specified\n");
+	printf("  need to specify -i <heap_type>\n");
+	printf("  supported heap types 0 or 1\n");
+}
+
 int main(int argc, char *argv[])
 {
 	int opt, ret, status, heapid;
 	int sockfd, client_fd, shared_fd;
 	unsigned char *map_buf;
-	unsigned long map_len, heap_type, heap_size, flags;
+	unsigned long map_len, heap_size, flags;
+	long heap_type;
 	struct ion_buffer_info info;
 	struct socket_info skinfo;
 
@@ -50,6 +58,7 @@ int main(int argc, char *argv[])
 	}
 
 	heap_size = 0;
+	heap_type = -1;
 	flags = 0;
 
 	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
@@ -68,7 +77,8 @@ int main(int argc, char *argv[])
 				heap_type = ION_HEAP_TYPE_SYSTEM_CONTIG;
 				break;
 			default:
-				printf("ERROR: heap type not supported\n");
+				heap_type_error_text();
+				print_usage(argc, argv);
 				exit(1);
 			}
 			break;
@@ -82,8 +92,15 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (heap_type < 0) {
+		heap_type_error_text();
+		print_usage(argc, argv);
+		exit(1);
+	}
+
 	if (heap_size <= 0) {
 		printf("heap_size cannot be 0\n");
+		printf("  need to specify -s <heap_size>\n");
 		print_usage(argc, argv);
 		exit(1);
 	}
-- 
2.11.0

