Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpF9XRNWDvbSKFzvj8imSukffNmB0mQEaDAhQQAXa07WFix/C32e0zMR/Bje72CVHklvQ3P
ARC-Seal: i=1; a=rsa-sha256; t=1527155683; cv=none;
        d=google.com; s=arc-20160816;
        b=S/6cuhkKXE0eJVoBGiXIHlgTuxsC9FCQ5Wq2U6zyeFm8mKoxzAL71cYplK5IdEfW50
         gPLTdAzHzPLfcK+uH56D03VEOcWkvzyegJqskBG6G3JrBBRe8NiNYfnsl5ItN5ywuCGy
         THIYWw4WZzEPSCqqjzUch/u8yJ0Ci04WRFNNdCqXkKYBtNo1juhKG6YdzleZWrgQpzUH
         13wAy/2l8NOVCwJ2Al1XZiHUbWHXTLqEmWHjI1jULY+SGV78iCPrYc/AxpwYZWfH8OiJ
         DQJG2JPpkoo4uRIX8DPhayiwGMaxFcJme6e6JALneSQFfcWxrPTbbMyh36siHw9a1yXT
         8dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7FipA9fYZR7x0p5/vs+Lmmot13+qTBltwM0ii3V5wK4=;
        b=nws2zVDzD4keyyxSJTKdSyEm+hVJ5hSz/lUsLwnEBcdnHOMAdxrXUhUm+EkQ2z296a
         WebpBCe34SWAZSp1SKn2cukgjEeYE6kQBduNYoJ/72qij9Zs9zQOZ0ulsqJA8l/5lgkU
         Zh8OxDNX8eKcnCxbhKVKsV3y62+B2Ag1zJmCnJ6HFQkYDNornyTArxfHbxo04dlSoOWh
         sJ/Gxs2USBGoaQO0xwSN2yVwZ+2Tw5C6i8394PNTYj4OFhy7e1Z+7t67/przRP82QyM6
         YL/gULCxr0UfAtqRhO33JPlARH0wxyTVXvAgiOhx9bQ+eESAGYq2UnGg8WeAu3i6pzXF
         os3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=noWdkTiD;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=noWdkTiD;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 043/165] s390: move spectre sysfs attribute code
Date: Thu, 24 May 2018 11:37:29 +0200
Message-Id: <20180524093623.757568544@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338296169118734?=
X-GMAIL-MSGID: =?utf-8?q?1601338797679561289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 4253b0e0627ee3461e64c2495c616f1c8f6b127b ]

The nospec-branch.c file is compiled without the gcc options to
generate expoline thunks. The return branch of the sysfs show
functions cpu_show_spectre_v1 and cpu_show_spectre_v2 is an indirect
branch as well. These need to be compiled with expolines.

Move the sysfs functions for spectre reporting to a separate file
and loose an '.' for one of the messages.

Cc: stable@vger.kernel.org # 4.16
Fixes: d424986f1d ("s390: add sysfs attributes for spectre")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/Makefile        |    1 +
 arch/s390/kernel/nospec-branch.c |   18 ------------------
 arch/s390/kernel/nospec-sysfs.c  |   21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)
 create mode 100644 arch/s390/kernel/nospec-sysfs.c

--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -63,6 +63,7 @@ obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
+obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -44,24 +44,6 @@ static int __init nospec_report(void)
 }
 arch_initcall(nospec_report);
 
-#ifdef CONFIG_SYSFS
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
-}
-
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
-		return sprintf(buf, "Mitigation: execute trampolines\n");
-	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
-		return sprintf(buf, "Mitigation: limited branch prediction.\n");
-	return sprintf(buf, "Vulnerable\n");
-}
-#endif
-
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
--- /dev/null
+++ b/arch/s390/kernel/nospec-sysfs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <asm/facility.h>
+#include <asm/nospec-branch.h>
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		return sprintf(buf, "Mitigation: execute trampolines\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		return sprintf(buf, "Mitigation: limited branch prediction\n");
+	return sprintf(buf, "Vulnerable\n");
+}
