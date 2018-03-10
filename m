Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELsiZ/RJPZ6gHImVYUqpezlweDWOHY9hDmq2/TsH3Mbf/1v8GtOu9No8Rd9bvDDXe+woK+VZ
ARC-Seal: i=1; a=rsa-sha256; t=1520691325; cv=none;
        d=google.com; s=arc-20160816;
        b=AdXoHkPOn1KR7qKyZXUlzyNPLAxiq5A5QihWydjX804RtRjABpKsrODjQSUbn/Mx8j
         CW62UtKYvtiVWKB83zB+J2ynn0rgwm+EEcbSZtbQm/YI7Lr1TtmlM+PFLtolJW4ntrGy
         D5BA8hiIox7RLxUoESiwNnorgWmtU2xMaCN3svFZcOddUTz9RP/+ZLpOwfly2OefsQf3
         GrLHUozGX4yvL/hIiABpjjgxXf+W/fkJU8PwQnDqqmm/FzJsUAnyfC4b3EMJ77tMckaX
         Mmx82QruvMy/kKIIwG/37hXCkTK/kGerirqbKnBdTjh7GvvNOzQKLi/4pbDCm0PXVC3L
         ebMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=hqYKOKg+3y1T20u2oZiPjmMCpggwQKCz8TBhoRR/ItE=;
        b=rsctOK33GTRVF1loy97r00+CGsg1UkVcoyv/ioy3J6WPUchorwrktmdXkmzseNaRjU
         TaUik9uNUpDUo3srgUBil0yoq8I4qLBttxpGGhm75Wp2cJjkcdpVzR8w0TrnC5Z+bVXB
         1q6UomRIDlNIdnGvuPIhPB2vAzfwm05N5w/hMvD/yRnawC4VXzhJbCbmUybrVlmT8MUx
         RlzSyaTHCsXV6ZTRuZ5zs0FcwvxWFZxXeO8AcK8KojQ2twqcYXYfPzXZ+UMM5b3q+Swe
         ma4NJnE0kkfIXFbi+psOlkkd/H4k/YKWhZ2We1oxy1HhaLxrwnXP2VZWfJxqOZ7zq8y3
         zTsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BA4217C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
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
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 10/20] firmware: enable run time change of forcing fallback loader
Date: Sat, 10 Mar 2018 06:14:51 -0800
Message-Id: <20180310141501.2214-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560428261925704?=
X-GMAIL-MSGID: =?utf-8?q?1594560428261925704?=
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

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c       |  1 +
 drivers/base/firmware_loader/fallback.h       |  4 +++-
 drivers/base/firmware_loader/fallback_table.c | 17 +++++++++++++++++
 kernel/sysctl.c                               | 11 +++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 9b65837256d6..45cc40933a47 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -7,6 +7,7 @@
 #include <linux/security.h>
 #include <linux/highmem.h>
 #include <linux/umh.h>
+#include <linux/sysctl.h>
 
 #include "fallback.h"
 #include "firmware.h"
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 550498c7fa4c..ca7e69a8417b 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -12,12 +12,14 @@
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
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 981419044c7e..92365e053e30 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -19,6 +19,9 @@
 /* Module or buit-in */
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 
+static unsigned int zero;
+static unsigned int one = 1;
+
 struct firmware_fallback_config fw_fallback_config = {
 	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
 	.loading_timeout = 60,
@@ -26,4 +29,18 @@ struct firmware_fallback_config fw_fallback_config = {
 };
 EXPORT_SYMBOL_GPL(fw_fallback_config);
 
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
 #endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6c68e771e11d..7a8aa6866764 100644
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
2.16.2
