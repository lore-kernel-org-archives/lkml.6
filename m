Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227+roOfyYIBFbiMr9RE34ddn2UYg7bDCvV/4s+WUKj0T2WRYoE/nS78JbzjMFWknBd2S7b2
ARC-Seal: i=1; a=rsa-sha256; t=1518568925; cv=none;
        d=google.com; s=arc-20160816;
        b=spuv/9RQlwLNxY46DhypkFfqA+MqYbM7jZh/OgWgF01ZCxkbE2oGsva0iYzgZPYRkH
         CxMkuMLoBo/ow0rx4KPFK69gusolI1vLIkaZCy0YrnkG6pFpk4N0bsk2u8+xPFF40BVx
         S9G3FQP7Kv1b3UsPsqj3mzIJH+WY/2M2EpA7AzDTdZk/ZAI7HqqgTfPmh8tYmnH0yKTc
         IoSNMcz67I9hCehZvIC0m+mFLeW0QpzacsXmpH2FHfCY8xIepmacY8ErwqX5k9H79CdZ
         WhitJ9hRQGD8IFY+HZIr4O15RvKj5g8FWF/OYkZIdflhsil18aFPQ4qeEq2JJYrTFAr7
         Irkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=Fdud06YY1tXDlYFt7cT6cslaRJe577qcSKX4PBPhsW8=;
        b=XlN9J2IWEQQcuyoY0f0dH3Jcwi+yCFr0PUr5FDnsSJJtSHcB5x96h//chACm0b7Hxg
         SF9BCYrkrVCB8vOqR4XeXP0fJh4R4i7lobsn6db5iawte/udNW9aQfee9uDfY1wztHlx
         wlLC9TuYkl1qm1O65fbQ/ChOrWzsgZCPjdGR6XCYgeQwJ/msNFxJS6EdcIbs39LconeL
         s0YB4hCpmjjDaig0n40RmvwL3QQUY8u2LZbBvWAW5Zj7hEnzhWucwlgTaaimMnFLEsTO
         IiH3xl24FjqX+vCgMVJNl2bqT0u9zgDCEoFLaI20DQm0ttLJnqZJzGLeUV7DydSyJdxc
         r4Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A049121842
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
Date: Tue, 13 Feb 2018 16:41:46 -0800
Message-Id: <20180214004148.14452-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334930146964957?=
X-GMAIL-MSGID: =?utf-8?q?1592334930146964957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

You currently need four different kernel builds to test the firmware
API fully. By adding a proc knob to force disable the fallback mechanism
completely we are able to reduce the amount of kernels you need built
to test the firmware API down to two.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_fallback.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
index 1a5bb3d22417..bf63034e0556 100644
--- a/drivers/base/firmware_fallback.c
+++ b/drivers/base/firmware_fallback.c
@@ -28,12 +28,16 @@ static unsigned int one = 1;
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
@@ -54,6 +58,15 @@ struct ctl_table firmware_config_table[] = {
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
@@ -683,6 +696,11 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
+	if (fw_fallback_config.ignore_sysfs_fallback) {
+		pr_info_once("Ignoring firmware sysfs fallback due to debugfs knob\n");
+		return false;
+	}
+
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
-- 
2.16.1
