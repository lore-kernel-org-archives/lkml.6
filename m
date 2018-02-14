Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x225xTGaCOjmab9pg2Dpq0CwC5H9OvvxyypuA8E5FVY14VH1+jCHBLdtlTnKVHB2KVPSLQ+TP
ARC-Seal: i=1; a=rsa-sha256; t=1518568920; cv=none;
        d=google.com; s=arc-20160816;
        b=SremRr8Cj6WZo0COFRHcKZRyhRqGVHaJkRaJIkS2vC0Pb7QZucnbvVDuIi+TXuLBM5
         v5EF0kcv2rr6a9niLqKGMePBF2THRBu+3N41PjLhT+cWn8DZGQpGt/9H8qi+f5PFdUFd
         gIwDIjqh2/JcoF3fPrU4CeUTzdKZKXD82LoTspzVh/KIUm+u9WtY9On/8sFXrtTOH5kg
         UPHIqom5LaMJNw2++8KhhwrMDtMeCMoIBOoKuCinqmFe6+sSDquWvux0UTdXQyjzbJMe
         Qjb/fGRgSK7V9vsxn8xtTrCLsBwkDMrp9PV6p3XkVzeOz5wRCHZjC3Kc8Pq4VFe34i0S
         3Wjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=zioWp/u/I7BHpOYbRnpUVBuZGBDICm+06k7DkTRrUyQ=;
        b=PbHwg7xUpLGtCTpT0jauFfw2Wwkc7hOwqySM/npBQds+d7bn3WBsizqCA6uop5DtrP
         LTtch+RBn6vq0QT3c0R0MlgMJcu06SmtTSoMJboXNv8Na67JA202WFkwWlWfm2ofxRjC
         yIOW2SmpWNFcG68UDwrAqd1eACkkWraul4VAZH8URsS7qpiDG9JYdqiJBG9xefg5gw3r
         EdBBRux913TqoMYJ5oKEJqkIVOCmg2i1ybgNqRcLssHYkluVcu40T8y3SlUx3lpkIC3o
         nFqORSS22zcnc9ByjwC8Nt1//rGliWm1UMIJekmvf/ysmaj5+ipF0XsF3U/GjR4g7jBf
         JNAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CEC217D3
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
Date: Tue, 13 Feb 2018 16:41:41 -0800
Message-Id: <20180214004148.14452-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334924218946526?=
X-GMAIL-MSGID: =?utf-8?q?1592334924218946526?=
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
2.16.1
