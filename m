Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x2276JlDt2gHgqNVWm/pVMPBWqDDefV3ljgBOlBpdc+AhX3nqY4pWTzfEmE9rSqJdpjJUREKt
ARC-Seal: i=1; a=rsa-sha256; t=1519440384; cv=none;
        d=google.com; s=arc-20160816;
        b=zGQCwJMdJo9bpK/LWj/qbAhl7jP/A7A3orlul1FFlR5xw12TNd01kF+QbG2B4CQ8cm
         8sJ9Q8MvGEISt/roLPVX1MtQyv+5AqdYzB28ZAVS6HhWaWQS1yHpEN7qfBdLx6cpYJmA
         r/Ltc5o0cj9ZqqLa09uxEa/RWhcJKjNcUJ9VAVlfPwmv5mCaQOTw8u6Or9YC/sVE7VSf
         dF2h0jdN54SJj+N7UMHKM1QNOaxwVxe1SO3BlNeHxUisjrsVxIs1Plby0ZxvjC/FN57b
         zzqHxG5cdNW34o3hHnpmtixgKVhc3d/H6GhC1o1H2qVvK5alG54CYEVIRYXuX8vpWY4x
         aQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=nzzUmv62CRtz+iK/kH5lqFVq2klV81YSBT4JVd8Xnjo=;
        b=wRPYI5ghIs4d6k2uP1eCIciGMcOCO9rrf6qrP+iWMBFtMlF9YR3aEDz5YDJQQ4FAi+
         /ZWyheMhCelKanV+g9Btn83XI7SQoAc+9DGab0GIr31gPlY0BZy/iRGI/ya5Hff1DzDC
         t4Ejy5PMQTdxLliWCTDupIFmPtOl81iXU8iik8pnINeet4pYvM+C1vm5NLELITGlVTlW
         5WV299C6mbZnGnhkra8Ou5IvGqwAT7uAmWTRWGERgsoJoAU4PcC+/8ZV9v1aYjF6zn1D
         P12UFC+bxNhQvOfoWkOXxDY4qxk8vYskmlEDwapYmJMlEMGmpL6pB2LEAIXQ7+d4QoFf
         TMRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA155217DF
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
Date: Fri, 23 Feb 2018 18:46:10 -0800
Message-Id: <20180224024613.24078-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720825062588?=
X-GMAIL-MSGID: =?utf-8?q?1593248720825062588?=
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
 drivers/base/firmware_fallback.c       |  1 +
 drivers/base/firmware_fallback.h       |  4 +++-
 drivers/base/firmware_fallback_table.c | 17 +++++++++++++++++
 kernel/sysctl.c                        | 11 +++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
index 47690207e0ee..cbce9a950cd8 100644
--- a/drivers/base/firmware_fallback.c
+++ b/drivers/base/firmware_fallback.c
@@ -7,6 +7,7 @@
 #include <linux/security.h>
 #include <linux/highmem.h>
 #include <linux/umh.h>
+#include <linux/sysctl.h>
 
 #include "firmware_fallback.h"
 #include "firmware_loader.h"
diff --git a/drivers/base/firmware_fallback.h b/drivers/base/firmware_fallback.h
index 550498c7fa4c..ca7e69a8417b 100644
--- a/drivers/base/firmware_fallback.h
+++ b/drivers/base/firmware_fallback.h
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
diff --git a/drivers/base/firmware_fallback_table.c b/drivers/base/firmware_fallback_table.c
index 53cc4e492520..77300d5e9c52 100644
--- a/drivers/base/firmware_fallback_table.c
+++ b/drivers/base/firmware_fallback_table.c
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
index acdf4e85c0a1..aa8355953fcf 100644
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
