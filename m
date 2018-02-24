Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227N9Nm5lNdIHFPYIqtvpWmhmCGd6hGvdvHZ91rRMz9icAk8WGQLstFQ9yCJ/cuX4pXKisUn
ARC-Seal: i=1; a=rsa-sha256; t=1519440385; cv=none;
        d=google.com; s=arc-20160816;
        b=Yy2kR2qpmPTKazWTnnHVhhSLITgpSbiHx+YnGQMdx2LZ3JKGyrpXmyVCJscI8J8sbT
         RclVO3mOnWIEmwiYr27EAuz7us+Ub2fr/xMJXjL5zZp9LuCnw6A+yE4f/LZeHEoAF2ce
         QI4HUy6tlJCxv82Y1DVFiyT4tezEn9os7YWu5EI76sJj6OpClZpfZrIgigdWapRnmojh
         NTUH2OpBhUgggFI0XVzHzPnmy489KS2tN8c74jl+LeCmyN9Ewx7l6b1afjlUQaX1L0RY
         w04nZ7cbhO56Fl0WI0svg+j2Ar5fB3k6kBT0EXiMQ9K5uLtk6PqA7iyMes7Y4KSBTfoL
         s+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=opLAfdpEb4BRbHJAzD2WlsRQiaR4rlOjL1aAui3sQE0=;
        b=JEQokqZa4Joyo8IilDFjAL70nqBje5PqvY5Xl+zmLoJvSYz/R+F2ZiUENPDN3JSuo7
         ewpn1eAXZV2MUA4ZMdCQs70CHQRD2SjhQN7gBKWFac0gyGxgBzZgKfcSpzqhhUnep8Dw
         zYpHtALDQuM7OPgC74HmIa4Ow1d5jZkPSyl8Z7MQhpTBGW494R+btmzycQtrwTVFGgak
         LrQDQhob1U3HR61uG5cXAz9nryqjjcGlkdfQE4/ZEuZToU1gebNtLZqPUCSRePFVylKz
         LGiVAi0EgfZCEa1KLSWx5IY5G8UjIjCO9dA5MH14SrMfJOx7lEHdShQiesq2eRK5zWNM
         /7Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE34821837
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
Subject: [PATCH v2 09/11] firmware: enable to force disable the fallback mechanism at run time
Date: Fri, 23 Feb 2018 18:46:11 -0800
Message-Id: <20180224024613.24078-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248722155111296?=
X-GMAIL-MSGID: =?utf-8?q?1593248722155111296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

You currently need four different kernel builds to test the firmware
API fully. By adding a proc knob to force disable the fallback mechanism
completely we are able to reduce the amount of kernels you need built
to test the firmware API down to two.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_fallback.c       | 5 +++++
 drivers/base/firmware_fallback.h       | 4 ++++
 drivers/base/firmware_fallback_table.c | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
index cbce9a950cd8..13fa5ff2b46c 100644
--- a/drivers/base/firmware_fallback.c
+++ b/drivers/base/firmware_fallback.c
@@ -643,6 +643,11 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
+	if (fw_fallback_config.ignore_sysfs_fallback) {
+		pr_info_once("Ignoring firmware sysfs fallback due to debugfs knob\n");
+		return false;
+	}
+
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
diff --git a/drivers/base/firmware_fallback.h b/drivers/base/firmware_fallback.h
index ca7e69a8417b..dfebc644ed35 100644
--- a/drivers/base/firmware_fallback.h
+++ b/drivers/base/firmware_fallback.h
@@ -14,12 +14,16 @@
  * 	as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
  * 	Useful to help debug a CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
  * 	functionality on a kernel where that config entry has been disabled.
+ * @ignore_sysfs_fallback: force to disable the sysfs fallback mechanism.
+ * 	This emulates the behaviour as if we had set the kernel
+ * 	config CONFIG_FW_LOADER_USER_HELPER=n.
  * @old_timeout: for internal use
  * @loading_timeout: the timeout to wait for the fallback mechanism before
  * 	giving up, in seconds.
  */
 struct firmware_fallback_config {
 	unsigned int force_sysfs_fallback;
+	unsigned int ignore_sysfs_fallback;
 	int old_timeout;
 	int loading_timeout;
 };
diff --git a/drivers/base/firmware_fallback_table.c b/drivers/base/firmware_fallback_table.c
index 77300d5e9c52..5e990b0330c7 100644
--- a/drivers/base/firmware_fallback_table.c
+++ b/drivers/base/firmware_fallback_table.c
@@ -39,6 +39,15 @@ struct ctl_table firmware_config_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+	{
+		.procname	= "ignore_sysfs_fallback",
+		.data		= &fw_fallback_config.ignore_sysfs_fallback,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 	{ }
 };
 EXPORT_SYMBOL_GPL(firmware_config_table);
-- 
2.16.2
