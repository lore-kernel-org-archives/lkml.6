Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979198; cv=none;
        d=google.com; s=arc-20160816;
        b=wsDTeJ7SsaPW+HqpZog8ND16C/R264jvJFFnUL3TtQ0bqX9Q6VkiqOd+lDYjTZIVoj
         yA4VE8rnup3UOJ6B+GEG6Qk8sgSy756d4mleGrrT0sCPxT+455gbtR3EPmdktAeDkQ9X
         TpBNPLnvRfRlsNShVqpERdmfypeNP9PDMHB4DzdLBPsQbtAFe/jAY7HgS9941NuleUCp
         ftj9vHSBcaVZKLY6HtfbuEinpFxiAThCNykTuLWziEDT7YRtOME5w3I1vOL2WD25r5Xg
         OPUEZYL2HE1MIekCcpKmT7VNyZqrlrSzfzqkeTUbm5zOe1LM02GyFOjSqmQ4w4c2hJlg
         JIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vfdPZChF2uLrOJXQB98PLvn66PKmIqh3dyZYkGe6C20=;
        b=sC9htrrhTjltvLVBji2AfmRF5ABhmukhL/c+B2o27fDy7BGJ+kGAPPnp3cPFenhZbK
         OIzu/8vEh1v9YcmGbpUkYy6Ch9tBXAaU8IvdjOxrTLnk26qijOpnCJN1mQPrkC+SH5u+
         BZF5VuFmIys0PuzAotF7hxRc9q3GSleFgx2mKrdleNod+gAlIpoCWYU8SEdtmLRVS33S
         bk9c1UUF5vxOz9cv84dBwrg6Gx35rF4BaBD/NIAEuiD1c5o+IcEPFCpdqwhgPDZk5GvE
         k54xyzetAKq/nGpTladAyr5loSXBPqiv0oIHJ+REjaD1VlILJ4NMzAvI1r0r2QTrfTZD
         WyOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yk9TCHEi;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yk9TCHEi;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49NEC7PaOXoOtGPfZ08drLaRLBM4SSJapgl2y8LSvtQ05XhyPlaQxfQwqYhVitOXbejThWPGg==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 2/9] firmware: wrap FW_OPT_* into an enum
Date: Tue, 17 Apr 2018 11:33:00 -0400
Message-Id: <20180417153307.3693-3-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008012071756488?=
X-GMAIL-MSGID: =?utf-8?q?1598008012071756488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This should let us associate enum kdoc to these values.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/fallback.c | 12 ++++++------
 drivers/base/firmware_loader/fallback.h |  6 ++++--
 drivers/base/firmware_loader/firmware.h | 17 +++++++++--------
 drivers/base/firmware_loader/main.c     |  6 +++---
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index da97fc26119c..ecc49a619298 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -511,7 +511,7 @@ static const struct attribute_group *fw_dev_attr_groups[] = {
 
 static struct fw_sysfs *
 fw_create_instance(struct firmware *firmware, const char *fw_name,
-		   struct device *device, unsigned int opt_flags)
+		   struct device *device, enum fw_opt opt_flags)
 {
 	struct fw_sysfs *fw_sysfs;
 	struct device *f_dev;
@@ -544,7 +544,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
  * In charge of constructing a sysfs fallback interface for firmware loading.
  **/
 static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
-				  unsigned int opt_flags, long timeout)
+				  enum fw_opt opt_flags, long timeout)
 {
 	int retval = 0;
 	struct device *f_dev = &fw_sysfs->dev;
@@ -598,7 +598,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 
 static int fw_load_from_user_helper(struct firmware *firmware,
 				    const char *name, struct device *device,
-				    unsigned int opt_flags)
+				    enum fw_opt opt_flags)
 {
 	struct fw_sysfs *fw_sysfs;
 	long timeout;
@@ -639,7 +639,7 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	return ret;
 }
 
-static bool fw_force_sysfs_fallback(unsigned int opt_flags)
+static bool fw_force_sysfs_fallback(enum fw_opt opt_flags)
 {
 	if (fw_fallback_config.force_sysfs_fallback)
 		return true;
@@ -648,7 +648,7 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 	return true;
 }
 
-static bool fw_run_sysfs_fallback(unsigned int opt_flags)
+static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 {
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
@@ -663,7 +663,7 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 
 int fw_sysfs_fallback(struct firmware *fw, const char *name,
 		      struct device *device,
-		      unsigned int opt_flags,
+		      enum fw_opt opt_flags,
 		      int ret)
 {
 	if (!fw_run_sysfs_fallback(opt_flags))
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index f8255670a663..a3b73a09db6c 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -5,6 +5,8 @@
 #include <linux/firmware.h>
 #include <linux/device.h>
 
+#include "firmware.h"
+
 /**
  * struct firmware_fallback_config - firmware fallback configuration settings
  *
@@ -31,7 +33,7 @@ struct firmware_fallback_config {
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 int fw_sysfs_fallback(struct firmware *fw, const char *name,
 		      struct device *device,
-		      unsigned int opt_flags,
+		      enum fw_opt opt_flags,
 		      int ret);
 void kill_pending_fw_fallback_reqs(bool only_kill_custom);
 
@@ -43,7 +45,7 @@ void unregister_sysfs_loader(void);
 #else /* CONFIG_FW_LOADER_USER_HELPER */
 static inline int fw_sysfs_fallback(struct firmware *fw, const char *name,
 				    struct device *device,
-				    unsigned int opt_flags,
+				    enum fw_opt opt_flags,
 				    int ret)
 {
 	/* Keep carrying over the same error */
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index d11d37db370b..957396293b92 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -10,13 +10,14 @@
 
 #include <generated/utsrelease.h>
 
-/* firmware behavior options */
-#define FW_OPT_UEVENT			(1U << 0)
-#define FW_OPT_NOWAIT			(1U << 1)
-#define FW_OPT_USERHELPER		(1U << 2)
-#define FW_OPT_NO_WARN			(1U << 3)
-#define FW_OPT_NOCACHE			(1U << 4)
-#define FW_OPT_NOFALLBACK		(1U << 5)
+enum fw_opt {
+	FW_OPT_UEVENT =         (1U << 0),
+	FW_OPT_NOWAIT =         (1U << 1),
+	FW_OPT_USERHELPER =     (1U << 2),
+	FW_OPT_NO_WARN =        (1U << 3),
+	FW_OPT_NOCACHE =        (1U << 4),
+	FW_OPT_NOFALLBACK =     (1U << 5),
+};
 
 enum fw_status {
 	FW_STATUS_UNKNOWN,
@@ -110,6 +111,6 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 }
 
 int assign_fw(struct firmware *fw, struct device *device,
-	      unsigned int opt_flags);
+	      enum fw_opt opt_flags);
 
 #endif /* __FIRMWARE_LOADER_H */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 5812148694b6..5baadad3012d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -443,7 +443,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 #endif
 
 int assign_fw(struct firmware *fw, struct device *device,
-	      unsigned int opt_flags)
+	      enum fw_opt opt_flags)
 {
 	struct fw_priv *fw_priv = fw->priv;
 	int ret;
@@ -558,7 +558,7 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _firmware_request(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  unsigned int opt_flags)
+		  enum fw_opt opt_flags)
 {
 	struct firmware *fw = NULL;
 	int ret;
@@ -734,7 +734,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
-	unsigned int opt_flags;
+	enum fw_opt opt_flags;
 };
 
 static void firmware_request_work_func(struct work_struct *work)
-- 
2.14.1
