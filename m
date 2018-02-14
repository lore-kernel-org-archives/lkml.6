Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227Wq+xVgcfAIknLwqx+hIUk59a9uRayfJdiigrtGSmgi/rtyiMXHIh/ggHdak+xHqxwFHYG
ARC-Seal: i=1; a=rsa-sha256; t=1518568924; cv=none;
        d=google.com; s=arc-20160816;
        b=A9A699gL6yV61d6vyAEhwUXWLmLA/8Uh8FCby/B7+EfnYMESX+OMDmCnBvxUepWvUM
         XfcN+5DZc14DWS3XIJjnY14lXfqMM3El0sr7Uoo6T9ASt17oLeymnmg/4aQFRZ4zeZqh
         sK0p4UtSlhlROuYZLgqu4FL9iMx0Up+bfDOfmQ+wJaPn4L1MtOFJJSzhl0JOOctJgK/1
         vEBH4VEjZn4nXJFdtP8LGx9vZXf+jjBEdrAwXtwrlexUdHOK+IQP2xL2LnPvyOw6Pe8H
         UEf+TejOixrKX+FAH+a/uAmXZYboRCPuZB2n195oIx8xP5Nj/fagCzj8ttbKPHt/aQ3s
         JWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=C6lKKSIehmPINikMwRfwztSvEtYjSCQqalzSRbg7dmA=;
        b=rGBVJ7fRsYVVa+vSLauLHwCB9I9tdqdCpsfQstiSMss9p2A7L0fG9kzGtG+kysulTl
         XQBgwY3Qgm/br8EniTh1zDiddfbvURcHlCvO9BwSayIaE9TX4S/ZCs9CxCL4HSOb3Qqg
         WPt0RAnPkFCB0dZ9ZkuywvlrIiGajMhYtyij65wgJotVCNL5VkTgXrnkQ3ulIQ781Eda
         4tDlGmHAHt1SZ7Flp2n96RefoAdzB5ya3BgoFlrfN8MFEBRfahS8lxy9bbOh+YH9UjUJ
         4p/FueIfPj2XcEHOMOMgvEuLaEczhAeif3En35kVArcOEEEQkQ4m3VubNEtQHp4kKtDB
         n7cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08F52183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 08/11] firmware: enable run time change of forcing fallback loader
Date: Tue, 13 Feb 2018 16:41:45 -0800
Message-Id: <20180214004148.14452-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334928971576998?=
X-GMAIL-MSGID: =?utf-8?q?1592334928971576998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently one requires to test four kernel configurations to test the
firmware API completely:

0)
  CONFIG_FW_LOADER=y

1)
  o CONFIG_FW_LOADER=y
  o CONFIG_FW_LOADER_USER_HELPER=y

2)
  o CONFIG_FW_LOADER=y
  o CONFIG_FW_LOADER_USER_HELPER=y
  o CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y

3) When CONFIG_FW_LOADER=m the built-in stuff is disabled, we have
   no current tests for this.

We can reduce the requirements to three kernel configurations by making
fw_config.force_sysfs_fallback a proc knob we flip on off. For kernels that
disable CONFIG_IKCONFIG_PROC this can also enable one to inspect if
CONFIG_FW_LOADER_USER_HELPER_FALLBACK was enabled at build time by checking
the proc value at boot time.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_fallback.c | 22 +++++++++++++++++++++-
 kernel/sysctl.c                  | 11 +++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
index 757620d6a751..1a5bb3d22417 100644
--- a/drivers/base/firmware_fallback.c
+++ b/drivers/base/firmware_fallback.c
@@ -7,6 +7,7 @@
 #include <linux/security.h>
 #include <linux/highmem.h>
 #include <linux/umh.h>
+#include <linux/sysctl.h>
 
 #include "firmware_fallback.h"
 #include "firmware_loader.h"
@@ -15,6 +16,9 @@
  * firmware fallback mechanism
  */
 
+static unsigned int zero;
+static unsigned int one = 1;
+
 /**
  * struct firmware_fallback_config - firmware fallback configuratioon settings
  *
@@ -22,12 +26,14 @@
  *
  * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
  * 	as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
+ * 	Useful to help debug a CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
+ * 	functionality on a kernel where that config entry has been disabled.
  * @old_timeout: for internal use
  * @loading_timeout: the timeout to wait for the fallback mechanism before
  * 	giving up, in seconds.
  */
 struct firmware_fallback_config {
-	const bool force_sysfs_fallback;
+	unsigned int force_sysfs_fallback;
 	int old_timeout;
 	int loading_timeout;
 };
@@ -38,6 +44,20 @@ static struct firmware_fallback_config fw_fallback_config = {
 	.old_timeout = 60,
 };
 
+struct ctl_table firmware_config_table[] = {
+	{
+		.procname	= "force_sysfs_fallback",
+		.data		= &fw_fallback_config.force_sysfs_fallback,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{ }
+};
+EXPORT_SYMBOL_GPL(firmware_config_table);
+
 /* These getters are vetted to use int properly */
 static inline int __firmware_loading_timeout(void)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f98f28c12020..bdf7090b106d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -253,6 +253,10 @@ extern struct ctl_table random_table[];
 extern struct ctl_table epoll_table[];
 #endif
 
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+extern struct ctl_table firmware_config_table[];
+#endif
+
 #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 int sysctl_legacy_va_layout;
 #endif
@@ -748,6 +752,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0555,
 		.child		= usermodehelper_table,
 	},
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+	{
+		.procname	= "firmware_config",
+		.mode		= 0555,
+		.child		= firmware_config_table,
+	},
+#endif
 	{
 		.procname	= "overflowuid",
 		.data		= &overflowuid,
-- 
2.16.1
