Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELuL2eGRwgeP3ByzCDxGRgGe9JKlyV8f0l6u+qym3wUHhcHoZwcYj2Np/sl9yRrOjJaqTZMX
ARC-Seal: i=1; a=rsa-sha256; t=1520691319; cv=none;
        d=google.com; s=arc-20160816;
        b=YcpKEXhvy8JkPTsaxROrR+qalP/dOPXVfvNhSYh8LooeOWczsnwyoeHi8chKr+CP+O
         fGZVf7RcDPiy68tjZbURmYHsyz3hOzyH0zFMpZhYWOZP+cONMGXgi+JQ0HgkLVSIXhSO
         4Ax2hKFo03MEcxcRzbmWE3GDP2/QUCuQm2GBxqDLhydIEK8Dw1WYu7iqCPtA/tbdqiVT
         vGpjC9uMaJwdZ8+PpIgfu0KknFRJlCn3g+scNzVQH9O1qSk3JuGcgd+0f9O+whnJ/lW9
         kXvsi2t0j7aPIdKdYGGJrwoCUSYnsoYiiZ2b1rfpZlx/HNUhbKjRGgjKFHvpNOCgTMGE
         Jevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=aSzo8T8WZ9W82G05e4M0oUTG8jW9VU3Yd8SkZblE3OY=;
        b=WUc73TyAIFpKgowlI/tGkDqkPUAvbA6lIP6aZoPWkNexoQk2nuqfjSakYCAfAhOzb7
         zfWzeaobziLQu2rP7jDhiXgh5RufLVzkjMq8GhofFhDmA/MERPDl2pIk191TKpFPu7AY
         Fg6DggaxEFDO+1YH6joK59r86GXlzj1iiZGwKfm2mgZIy3rrU+j8N9ULUKFIO3EpuwA0
         TDsd6lHJFT0Gcb1J3/SbJPRvsKKAKVD4zmvONdsMhHiUWYICzUjCAQadp41cpmR/lmyO
         9HQShVh9uNPhZA/Vz/6TUibr29xQZ8TNJt92WBrdNDM9b+FSp9zq0OKaHJTf8MOoPUPy
         lPKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5B021787
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
Subject: [PATCH v3 05/20] firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
Date: Sat, 10 Mar 2018 06:14:46 -0800
Message-Id: <20180310141501.2214-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560421519500389?=
X-GMAIL-MSGID: =?utf-8?q?1594560421519500389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All CONFIG_FW_LOADER_USER_HELPER_FALLBACK really is, is just a bool,
initailized at build time. Define it as such. This simplifies the
logic even further, removing now all explicit #ifdefs around the code.

Acked-by: Kees Cook <keescook@chromium.org>
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
