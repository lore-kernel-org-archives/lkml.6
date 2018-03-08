Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuJ+Kb5fs6Ker4qEr+JoiIK0H7ka1Bc3vFC/Dt5XQKyPJ/pa0mTI25fpAo+Vf1SXMjInLWT
ARC-Seal: i=1; a=rsa-sha256; t=1520519878; cv=none;
        d=google.com; s=arc-20160816;
        b=jW3ygXhHizRl+eAP/68RxNhUfbSg84IqK5rIMRteoTWE1OJED6DP5Y57pBrjQtTWLy
         cnLfLhPr/z1b3gDqRg2ZhvIAj+vNyY6PXVOT8+yEBmikAiCadQB3xu8gCs7pNEy0qy6R
         n1wZ/E7ShpM+OT5bmvtnLiFzitG8apUgS23oN17h7KN8DjUtYHEnuM/ekyQDb4tbjz3I
         RsIXWqQZgNSzacnwqDcwTkJd/XSo5Cizv4GY94d13LKL5wwK3b4n9xZ2JoiS/6NgE2lS
         CcS3RGecITfs1AKjy152V8np5iBmt8RMLCi0s2UXrSi9Y9Ni9xmHGLo+5FhGgfs+HNjp
         uHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=2QrKWFBB25h0fl9Ka1FOFgOiPkdTIeKeHGT8/MFGG74=;
        b=v+uLPr784zC8ffv19uSGHraX/Tsx5wy21lfvj0uNYyncXD9ADp65zxaSgVQlV4pbd5
         8tD+4j3sX44L6t26gy9pH0MRdApVL1VYHq+mRdKC6qVbHdie1v6HzGDlAxxD9sgHmLEi
         e0PF2QU1kuObM//f8pe0UWi1PChBY8s1he1I696/WxpAu+LXooKqpOp6nSHY2S/PbBNm
         k5gxvKWSnqTBTuptM+p7nJl5Q9pyHOUrIMYAZ98zckzVHJfF3rKM4eInCbmbWJAdCYDZ
         TcZ3WZEQYe6wCLzE2g6ZipuxyfaEOMShbbRP7kyY2j9N7US6hUvnjhofx1WAaiLzMVVQ
         orPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MDs43uLj;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=MDs43uLj;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeCHOh6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 09:37:58 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35608 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeCHOh5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 09:37:57 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: pintu.ping@gmail.com, labbott@redhat.com, daniel.vetter@ffwll.ch,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/android/ion: Makefile: fix build error
Date: Thu,  8 Mar 2018 15:37:41 +0100
Message-Id: <20180308143741.4415-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594380652226081333?=
X-GMAIL-MSGID: =?utf-8?q?1594380652226081333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fails to build iomap_test.c due to missing include

gcc  -I. -I../../../../../drivers/staging/android/uapi/ -Wall -O2 -g
ionmap_test.c ipcsocket.c ionutils.c   -o ionmap_test
ionmap_test.c:12:27: fatal error: linux/dma-buf.h: No such file or
directory
 #include <linux/dma-buf.h>
                           ^
compilation terminated.
<builtin>: recipe for target 'ionmap_test' failed
make[2]: *** [ionmap_test] Error 1

In the current code, we add a new -I ../../../../../usr/include/ to the
INCLUDEDIR variable. Also add ionmap_test to the .gitignore file.

Fixes: ac93f7046a53 ("selftests: ion: Add simple test with the vgem driver")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/android/ion/.gitignore | 1 +
 tools/testing/selftests/android/ion/Makefile   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/ion/.gitignore b/tools/testing/selftests/android/ion/.gitignore
index 67e6f391b2a9..95e8f4561474 100644
--- a/tools/testing/selftests/android/ion/.gitignore
+++ b/tools/testing/selftests/android/ion/.gitignore
@@ -1,2 +1,3 @@
 ionapp_export
 ionapp_import
+ionmap_test
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index d23b6d537d8b..e03695287f76 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -1,5 +1,5 @@
 
-INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
+INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/
 CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
 
 TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
-- 
2.11.0

