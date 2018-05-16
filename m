Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526470753; cv=none;
        d=google.com; s=arc-20160816;
        b=UHS0xbmsZsW7BwQ5VpHhfWwx8DY79Q6i2KPDk1kWil56U2CkiUK76ZXANWaWU8NSw3
         2cw+1OnB1ELDDh13Ah0vk+aY8p/GwSyzlIwWcvPwTzyOqq8pK5KLN2NUlVWZ4uy2U+7q
         pXAAToglBMSOPlb/RBvkv57i2GZo5Ubzgz+PCEelNDrQ4OGnp83MfoDpiZo//sUdtj7N
         Vc6kGYG+LUSS3lAIejUlTnfu9AfP5jeCw/8L8whq0unolWgxxMQmayYQ0pIAe7s333I0
         TO9wozEtr+LRsI2mkVzbYpMAVKd043MiWCdsjovMjnnLgelXwOpmFTLemIfzCQa9D5SL
         SBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=W6uYmgHxTWzfDftIQnpPK6qurtIUOyuIABrSN4ITJSQ=;
        b=L46zW6v5J6Nyh8sm4XvwgeMPbC0RgwIzUw92PP4FgVF34uNWztjyafPL6b7oKajxRC
         02MXj+4cafcWWcROaPs55H90C6uu75ZXo/i0zAgd9U5a06aps555RarluvU2ZO5fcHQr
         1oSI1H6vE/KZkeOJsSHY5oaiN1nb21AIT6yquJ1tiwn01Xtm5XQet8Ny/6JDyidPYZC6
         EQZdSswtWQ5rMraDKDYcgCN46Y1UWLYCfni6XHUMZY2FcMu7IahBj/ZlLNREsiZKwLEc
         ElGVhbKva/qvAAculBhpxpHaWgRcQstFlCDoZSevI2fMSfBJPyBbpieWsa1OJ0hxJ+QC
         9D8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=I6zFDkxw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=I6zFDkxw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpRWylVmL1uQX/IQdumeFyrXXXw+L5GvmAQlo6fD5v8nwrOpUDDd1L6w1TlnAM9NdnqID390w==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
Date: Wed, 16 May 2018 12:36:40 +0100
Message-Id: <20180516113642.28136-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
References: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600620596828138704?=
X-GMAIL-MSGID: =?utf-8?q?1600620596828138704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There seems to be a multiple calls to pm_runtime_mark_last_busy(),
which looks like a typo.
Fix this by properly adding pm_runtime_put_autosuspend to put controller
in auto suspend state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 5a2ff01b394c..1c57b631031a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_put_autosuspend(ctrl->dev);
 	}
 	return ret;
 }
-- 
2.16.2
