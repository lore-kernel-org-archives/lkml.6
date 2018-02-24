Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x227rmDTBjAIZf9f2YclzzoV51FKPaNbfkiyLYsLcY/RNVXVB+qexkCnQuiyaJEibQbSgEgNH
ARC-Seal: i=1; a=rsa-sha256; t=1519440380; cv=none;
        d=google.com; s=arc-20160816;
        b=mS8iKRAn0iCuKgGpb2cSmYpzeHlengw9F4jYo6Cny0mthzPLeR1E8OU2JHfktmJbMu
         sCvxxWiVV4JmoOq2RIWbGyS+fwjHkAMfuPoPe8wiN3zQbt868vL7DsOufOd52sfWNb6t
         kLNVU6DQsNGYpgja49YQAyTgNE87Yid99tZKQWcrmZy7ZXEonirhedM8GFevuOLHXqmr
         eo5IFshrRTdGNKICBJRyqo9SRlocBpYY/k26zUckgQ25oK0/JijivlEKuF5dfY0V1zfs
         aSrTaRenLy6US22akPigMjH9sjW9FjH7SpfBfw3Sq/D0jueiAqXNZnc4eD1/dgwBLW9N
         0QCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=RNhLbiS7ZLjmJmLH9CTIoXCMxpvpQALZUwZbmjVOTkQ=;
        b=F297ZzCOvLQSA/3ktFE0VrW/8/oo8wYqb4n/tqG9nT/rd/r8F/Cyf6swzCRk8Ct5E5
         T5B5/msji0BWlmSdf2T7xj1576EO6NqpPeujQSnUxeZpqD7QGfb+AFgDIVhJXGk5Kia5
         ZVpKBFV2TohKrxiNSPD3TKEupsxjDkzxRx/kMnf3VrOEdEJh7CMnIrnpZBwS3Ds5hyQ5
         z0+bcIDzGc4Hln0zMozfNNER+e6xG4Au9PpwZtLBjeGu/+MlxqnikCxvOQFHTglmp8Ei
         ekRVcd/IakVRA2ay7zVL5prFKmS1+zXKrL0R82Kh006DPZqvWdF8hE6LQrnI9Of4czVY
         PzBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6A2217C0
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
Subject: [PATCH v2 04/11] firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
Date: Fri, 23 Feb 2018 18:46:06 -0800
Message-Id: <20180224024613.24078-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248716837062122?=
X-GMAIL-MSGID: =?utf-8?q?1593248716837062122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All CONFIG_FW_LOADER_USER_HELPER_FALLBACK really is, is just a bool,
initailized at build time. Define it as such. This simplifies the
logic even further, removing now all explicit #ifdefs around the code.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 7dd36ace6152..59dba794ce1a 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -266,6 +266,22 @@ static inline bool fw_state_is_aborted(struct fw_priv *fw_priv)
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 
+/**
+ * struct firmware_fallback_config - firmware fallback configuratioon settings
+ *
+ * Helps describe and fine tune the fallback mechanism.
+ *
+ * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
+ * 	as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
+ */
+struct firmware_fallback_config {
+	bool force_sysfs_fallback;
+};
+
+static const struct firmware_fallback_config fw_fallback_config = {
+	.force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
+};
+
 static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
 {
 	return __fw_state_check(fw_priv, FW_STATUS_DONE);
@@ -1151,19 +1167,14 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	return ret;
 }
 
-#ifdef CONFIG_FW_LOADER_USER_HELPER_FALLBACK
-static bool fw_force_sysfs_fallback(unsigned int opt_flags)
-{
-	return true;
-}
-#else
 static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 {
+	if (fw_fallback_config.force_sysfs_fallback)
+		return true;
 	if (!(opt_flags & FW_OPT_USERHELPER))
 		return false;
 	return true;
 }
-#endif
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
-- 
2.16.2
