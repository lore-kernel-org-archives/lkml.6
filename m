Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELvTDyzZd6cMHr5zsfdU2XmMN9jlnm6NM8s+J3eKt1rkU1J75sJWJ740s8ij4DZFJfLG7RJd
ARC-Seal: i=1; a=rsa-sha256; t=1520691332; cv=none;
        d=google.com; s=arc-20160816;
        b=pJEVGxxVrO0edVhnbcSiEdiRo8P/F8MtXEBRD4vijlnSur/koZW2P2jX4o9SGcr5GY
         uhDf9rCsFukMY7Aznm/ye4St1jLzqTQPyqhx+b6WmjRQ15jvMaUj745PP9oG/Wdl7Ntl
         qOc/EQJZTOeUzcBbNTkQuhMMAkaWgmZc3zrjymnrH+j2dFPIP91LF6y68wUc+zutp8qx
         vAB+BCr2JXojzPjJdAH6YtW6limeIF+wSpirCDf676jjz4VyfiquIXhi40EO5toHVOll
         EkvQH9iFmB4MpjzRmVVWjd9uh4nj+n6y9kLk1lXPDMLVZu+3SxjjKv0LR+zYM2FyNjaH
         Tsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=ED3zIMfsLnCWosZDbcOeXeqcfPO9NLxc9DX36uobkZk=;
        b=lg20OjB/p3hXjdz8o7x0JU1DwRd9qHfAIpjSiByQOt2BwgyCztgiKItzh4PbpKMuzC
         u4RzNNMeWMCoOtDt/qQZPXZSG6+23PcGuA0MmjQn2E/Yy7eEk5+KJwaHx6T3aimt6FyP
         6g5lWjy/9eckquYFxf97N5OBtGkIodzCjzHLo8y+7H1UyukGiCAYOv9U8QyjSx5esJRY
         NMdjh8pFEPmlCtab+JaVQy/uhnLoh2A4XB+h1TwN8tIZsD39QGZjWoCEq0y93hhJQyLz
         ND6r/ZkNo8/2A0Y1S6OMCidbhz9/KBkhCPxOGLksLaBLvlZGMIqDBAHm3DHIVRrxplAC
         mmiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40CB217D6
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
Subject: [PATCH v3 16/20] firmware: add helper to check to see if fw cache is setup
Date: Sat, 10 Mar 2018 06:14:57 -0800
Message-Id: <20180310141501.2214-17-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560434954807436?=
X-GMAIL-MSGID: =?utf-8?q?1594560434954807436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a helper to check if the firmware cache is already setup for a device.
This will be used later.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index f5046887e362..b569d8a09392 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
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
