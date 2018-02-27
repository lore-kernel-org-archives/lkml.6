Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x22539WU0k0vK0EQ5PJmyJyD5pGGmZfLq4BrtGvxVfCAGjy2nu1K42v0iVm8e0MPHqz10kZr3
ARC-Seal: i=1; a=rsa-sha256; t=1519773671; cv=none;
        d=google.com; s=arc-20160816;
        b=yL1xSTmuDXGPLbVzN+v0tejcv1SoE4B48KX2DmJDJu3XFRwr/VHeIJOsRWpGM3vifm
         k6T3TWX8UtREeaDGrQa5KfnsdhCKJmQyx6EMUR8xYFowD4E1cbhrY/qsA6ayChMtdTix
         Skmw6BYmWjRp3QBuPHMnC1iGrBpNTW1ISxucCvEuQqXtVHYwnbtbHDh5UGJbJu2B82VD
         oWfRuen5o7jhvb/+KYveBYwqpdfL0kJyQ+B1tX2Js5f8Y52npkRuIs6tBwHx8+WyHmOB
         AblSpFZ30hD2nQUS6HhJeuRO3iZNQF9VlG/madiWnDTYFoeaMoD9i4XGo92ap5HjE52k
         6E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=c/736u6QcjLr/JL1hIwTu+CNzEDiDlVVV+zLkyc6Wrc=;
        b=NAzaNKNj54tkCNyHVz+MY4fxLbmKYJByZOLz1TdQ7eyh3D7aCrxM/iOxJ6rtg2JKlp
         uK08firLFDu77TYVefNaN2Kks0WAwfyBEf4EWP855u9etlj8t1oxnLe0k4bQyD5jl8qA
         6VFgC/gU5SlNZE2/ZaUfkUJc1w1jRSsV+1R5waxHAZiUXh/pgU7I8nLfKZBZYn7LbR6Z
         NP60Z03K4uuw/X52r+liKfbsSFKdXLhfcePVI8+5WFCAwHZHmU98YG6oxjz9wn/Y85/B
         dFhfpIoulnQA0wUpUYFq8EQL1m9rXx28i+jkDB0187FqIE+cMdlwHdUKsMEMEUbT40UQ
         8wpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70152217BA
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
Subject: [RFT 4/7] firmware: add helper to check to see if fw cache is setup
Date: Tue, 27 Feb 2018 15:20:58 -0800
Message-Id: <20180227232101.20786-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598197734581435?=
X-GMAIL-MSGID: =?utf-8?q?1593598197734581435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a helper to check if the firmware cache is already setup for a device.
This will be used later.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index a385622bf3e1..5f3d44d0bfe0 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -396,13 +396,23 @@ static struct fw_name_devm *fw_find_devm_name(struct device *dev,
 	return fwn;
 }
 
-/* add firmware name into devres list */
-static int fw_add_devm_name(struct device *dev, const char *name)
+static bool fw_cache_is_setup(struct device *dev, const char *name)
 {
 	struct fw_name_devm *fwn;
 
 	fwn = fw_find_devm_name(dev, name);
 	if (fwn)
+		return true;
+
+	return false;
+}
+
+/* add firmware name into devres list */
+static int fw_add_devm_name(struct device *dev, const char *name)
+{
+	struct fw_name_devm *fwn;
+
+	if (fw_cache_is_setup(dev, name))
 		return 0;
 
 	fwn = devres_alloc(fw_name_devm_release, sizeof(struct fw_name_devm),
-- 
2.16.2
