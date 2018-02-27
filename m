Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELv+563yKs3pEAKePzKMp8H9M6IztAnsqNxewk/VCy5fGwUEi8r//bLEGxptlrE85zrOamzu
ARC-Seal: i=1; a=rsa-sha256; t=1519773670; cv=none;
        d=google.com; s=arc-20160816;
        b=SW+3dzIQOrHItU5YUHvDoc+enoeHvLgU7aPb4tLWI83839EAOiyBJfEXawg68+e5m/
         5dABHuDtI4yIZtgH2Rj83wnbKjEpj1VkLTCx+n+JiApuDqXRoBfZVM+VtC2xm8yXSDdD
         t6B4+IM5yLuwBukWQ6fOFvupkft2258hnECn2VMC4HGMlBY6vv2TmzuXAhKZB8FP/UJU
         hj9qaJukVVkj9q7j8lfCSUzYlFy24UcxQPwp2t/HKGO0qMTtrmbnBAWagln6k5HSB1+B
         K71D++6PVUGhrsc9cDylkaP5Z0240vzPKyX4PlRdvAwnSfrYB6vpzNt5/VJ1zZvMh5iG
         q4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=bXu9S94NertVCnAGTx9g7pINOpLpUL8Kc1HJCCEDG6U=;
        b=CdTSX84zNBAb/chwHOrgqEocd6ebPhp8V/VibJ5K/286nhbZhodMFQhhOhTFRkjVSZ
         OTtVgZ8AyXg5murivBHYD1b86jxmIAu+QvCMMV/VtFJvIXDGH4zYFrUP4sjYAGq1b1rs
         1Fnk6cXCE31eIeicm5msZBKnv37cQwydQyFSrlMtuWb1tsS71/C6+1vQPsriWidmP3C4
         UrRHYr3b1Jb8EKEpbOSKe9rirRN+ZSfqalnifC3VjqHr4PfJdsYRuxQYqDt5gD9yJ7qg
         i8sIXfsw19ifXR1fs1JAtIZqpHxVstPmvGijGtTm4PlWOUBE4tO/uq/RsINwFAT7SI0K
         sAyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51877217B5
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
Subject: [RFT 3/7] firmware: make fw_add_devm_name() return 0 if cache present
Date: Tue, 27 Feb 2018 15:20:57 -0800
Message-Id: <20180227232101.20786-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598196329346880?=
X-GMAIL-MSGID: =?utf-8?q?1593598196329346880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently fw_add_devm_name() returns 1 if the firmware cache
was already set. This makes it complicated for us to check for
correctness. It is actually non-fatal if the firmware cache
is already setup, so just return 0, and simplify the checkers.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 48932581c70c..a385622bf3e1 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -403,7 +403,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 
 	fwn = fw_find_devm_name(dev, name);
 	if (fwn)
-		return 1;
+		return 0;
 
 	fwn = devres_alloc(fw_name_devm_release, sizeof(struct fw_name_devm),
 			   GFP_KERNEL);
@@ -450,7 +450,7 @@ int assign_fw(struct firmware *fw, struct device *device,
 	if (device && (opt_flags & FW_OPT_UEVENT) &&
 	    !(opt_flags & FW_OPT_NOCACHE)) {
 		ret = fw_add_devm_name(device, fw_priv->fw_name);
-		if (ret && ret != 1) {
+		if (ret) {
 			mutex_unlock(&fw_lock);
 			return ret;
 		}
-- 
2.16.2
