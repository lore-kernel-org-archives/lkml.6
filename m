Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x224ShbIeTOCHDG/co7w1qy6Ikn1R0AYmdo+qgKuusDaCnPB8DXmOk/VyKLhbjljUkvwvUgKc
ARC-Seal: i=1; a=rsa-sha256; t=1519773669; cv=none;
        d=google.com; s=arc-20160816;
        b=Hce3GYqW9R/p0lcrHHYmTdQLl84pXImWSABKr8mFTE5c5LGuXpVjOThgThNxKC8uum
         iXyb0HCTZ/9iUsVF4rY2OWsevhIwDAUDL6R0OFNJw4M4Aj98F+vhHz1gN0bSiWLrHfK/
         VvjikfIQkmOHZj4lQ+oK+++l0hGiaPjDD52yNfa8qi68ncnHq3T777NGLwBsGtZqDnvg
         389a7G04xVaBtK+dZVMZyV8kWXpXHA3xWP1vlXGwVVeBz9B8eZ4YTH7iJC3XMHy8FVb9
         mg5IozLthJZixz8fMgPUdxUhX88sHd5o5+ebcTVrjSTAxD5ZQDtHolVCXfLKKEZ41Rib
         HX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=E8KELWP5irWohYAvjSZAy+bLEx3tTsmWyrtCg+LAyHw=;
        b=XdJImv4F6X0nXrW/w4B2DkXbgoJHu/fS7Z/8r/C6Cqn6tvg3M9FdVfETt1My3LkIUy
         h7Kw46LrrY9BfE1C/Dja/DfMGMSnX/L8mjz6DTuNFdz+cMj2Yv2eT6WX7f4w9GAK+xUb
         3ZyRUKfAfwozKyh+c/7Orz3bqBs+qzyZsK5IOoR/qBDB3IphplIht+w37U0y3ACjcbrd
         N7XtYl6zm4d2mFW+M0VQt1ifroqcJe3Y9/h/8PjbLC43uDRnKFQlkz+ev/bHvp+VhbfM
         7hlLBsY4er5JFTt/6PppMtri/L5GfRBlReBvIc9z5VLuSQT9Slz+Hcf9snMuiGn8FZun
         LWEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3107D217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile.desu@gmail.com
Cc: kubakici@wp.pl,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
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
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT 2/7] firmware: fix checking for return values for fw_add_devm_name()
Date: Tue, 27 Feb 2018 15:20:56 -0800
Message-Id: <20180227232101.20786-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598195211276133?=
X-GMAIL-MSGID: =?utf-8?q?1593598195211276133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fw_add_devm_name() adds device's name onto the devres for the
device so that prior to suspend we cache the firmware onto memory,
so that on resume the firmware is reliably available. We never
were checking for success for this call though, meaning in some
really rare cases we my have never setup the firmware cache for
a device, which could in turn make resume fail.

This is all theoretical, no known issues have been reported.
This small issue has been present way since the addition of the
devres firmware cache names on v3.7.

Fixes: f531f05ae9437 ("firmware loader: store firmware name into devres list")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 21dd31ef08ae..48932581c70c 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -431,6 +431,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 	      unsigned int opt_flags)
 {
 	struct fw_priv *fw_priv = fw->priv;
+	int ret;
 
 	mutex_lock(&fw_lock);
 	if (!fw_priv->size || fw_state_is_aborted(fw_priv)) {
@@ -447,8 +448,13 @@ int assign_fw(struct firmware *fw, struct device *device,
 	 */
 	/* don't cache firmware handled without uevent */
 	if (device && (opt_flags & FW_OPT_UEVENT) &&
-	    !(opt_flags & FW_OPT_NOCACHE))
-		fw_add_devm_name(device, fw_priv->fw_name);
+	    !(opt_flags & FW_OPT_NOCACHE)) {
+		ret = fw_add_devm_name(device, fw_priv->fw_name);
+		if (ret && ret != 1) {
+			mutex_unlock(&fw_lock);
+			return ret;
+		}
+	}
 
 	/*
 	 * After caching firmware image is started, let it piggyback
-- 
2.16.2
