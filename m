Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeE2KhG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:37:06 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53573 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbeE2Kg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:36:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: disable KCOV for trusted foundations code
Date: Tue, 29 May 2018 12:36:26 +0200
Message-Id: <20180529103636.1535457-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:iEnb1OoICK5/hTgLy6V+oDRrdtczKmm2HEW89arqfBpUflfiY4H
 pAz9pN+2L8HGn6doL9H3ouJtYAqwsne4X7ZiWyL0YGOsQYi13uG9d2pCdXMb+AhcyOGtrWl
 LG+crrWeuR6ixKFbmlEviy92TGC7GtKAtaLLlVdputcv8Nh/xRDpJTo1toqnxcbMZe7hdRf
 Du3FBTiBE8TdE7VKNxoCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQ5VGwqfdMM=:+NV7vtgKSYv1ccVEpnpWBk
 XRZrH8hsQBDcC18mUTxwa/yzjZDDlgrMN/fTH+YDPTQfXkhJ+CpEELkw8i70vLars1h1pjuYW
 dr5UaSp7Nq2RiVjSEIIGuJn+zaSmTf6zjQCa6eu8sjThVSlG1vLs6HEumsc0TE5SfTcUi1x5m
 1YTAgn99zRPywkPgaeRFLvYGJlv/XcxfeqYiaCkm80NVwa2iz1zQQQVDwxvNhSia8+SFX2oaG
 tVCA/SMsQjoJ/6JshTa55WS8x8BTgRslvfKxkyx0FhBiHqF5iYdSCL1XNMwprvbEZujZg5PF0
 otqttKkGeoGL3624jPGbZIBk0bv2V50MkujFe8WrojXEoTf11J2lC5Fpx2JQWjJD36ygiYNQ+
 mIG1gjmlOBytAKWMcCtvj1kjYsBEpN99yWCzvNXGwjAjhNwFzoxAhA6aBTzkl6I4g3VbnDPYa
 7EgqnMr45/Mxis67T6Rz6OYUT56H8fj/lESIGLaonTaGlwmGRPXka/PbglWTr0qzCIK1L55Ih
 nbMLdXslHnLFshLLj1sQQMtEWJmw3E4sOyYkjZVSw8YJ6+UEs/E2Gq7eeP9Xw47YP7nCoV3yL
 lgcj0hz12XgG4vKc0Y8+Yvgedf6j/hnNfUZc6xwJV5Y2MpNFFmw3AXmjbpywRXSDOUW1MTqUl
 RGrk3RQrN9jEuH9ivXvcKTRTJaxDxLKBEQEZo9zfuxQsMAoGSMlbmEOHD/r9hAUqhZgc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM trusted foundations code is currently broken in linux-next
when CONFIG_KCOV_INSTRUMENT_ALL is set:

/tmp/ccHdQsCI.s: Assembler messages:
/tmp/ccHdQsCI.s:37: Error: .err encountered
/tmp/ccHdQsCI.s:38: Error: .err encountered
/tmp/ccHdQsCI.s:39: Error: .err encountered
scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed

I could not find a function attribute that lets me disable
-fsanitize-coverage=trace-pc for just one function, so this
turns it off for the entire file instead.

Fixes: mmotm ("arm: port KCOV to arm")
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/firmware/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/firmware/Makefile b/arch/arm/firmware/Makefile
index a71f16536b6c..6e41336b0bc4 100644
--- a/arch/arm/firmware/Makefile
+++ b/arch/arm/firmware/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_TRUSTED_FOUNDATIONS)	+= trusted_foundations.o
+
+# tf_generic_smc() fails to build with -fsanitize-coverage=trace-pc
+KCOV_INSTRUMENT                := n
-- 
2.9.0
