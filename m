Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x226fGv1Aa+cOyVAfThIm9idpQJahRC0DG2sRmsPDMk65hNkyRGNIlT2sz31VLncUHnCVA6Dj
ARC-Seal: i=1; a=rsa-sha256; t=1519773672; cv=none;
        d=google.com; s=arc-20160816;
        b=Lt5zgYTBewwrPAUodCU9fLMGXKYrWqhW4l99m7sutwS5ZtbSLG4569afGeoj4yEnlC
         R1Sdhv9atKw+euF/9m+j5aivwJAOz/+Qmgsnci8TYeFtSeSAwpFWpqFTP0IuSgyPNUeK
         WL+GyHNm5HsW9AO52ZKghm5X3bvTYCyY6pMjeLxTCKS89slU/8UaebGFoNPAzFuXMkiv
         TT+nX6bf6wnxWG9ey9k52NWeAF96JZlCbcVw/X3qX96FV42PM5xs5b1+VtkBudv7Sswx
         tLCwF9WNyGlSp776oMliov2IQEU5WNjWYMKa1a19Rm3hl9dvxX0zW5+EtdkP+8N+rDZo
         saKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=S6DJHp8zA4IDCNUIcAFDb5myARkomZCSGQmzAKg/WgQ=;
        b=kLBM2AOB3UFwVMIhZeCmji6CfRiLwwtxZ0sqwOZHaqI8BfniaBrRA8GFATfSBrFCGq
         0I2xN7aDxcplc7JOLLW3jspeu6GcCiJ9yN1GDedyDfcAkr21sKJOvkiOFrQ2ivgLrqSO
         kp2+I5gNU+I/L2H7nLW8I3Qx8hk8JoiqrXtS3y5DXFRoRxzmQU3jR+rBMdw0cfLwHHLL
         lMkt2tNDRl/VaW5yGy/pz/Y0RNiLrBPMMCk9IWjiTWfveH0PbgP+OCUqjFYo0fPjRzy4
         kXzpywN48ldal3GqEBhzX6SbSwREu8UbINCAj/9JrA3q37+LyJ9Scl6VUWRF9KiOBGb+
         PLPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959CB217BB
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
Subject: [RFT 5/7] firmware: ensure the firmware cache is not used on incompatible calls
Date: Tue, 27 Feb 2018 15:20:59 -0800
Message-Id: <20180227232101.20786-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598198795346798?=
X-GMAIL-MSGID: =?utf-8?q?1593598198795346798?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

request_firmware_into_buf() explicitly disables the firmware cache,
meanwhile the firmware cache cannot be used when request_firmware_nowait()
is used without the uevent. Enforce a sanity check for this to avoid future
issues undocumented behaviours should misuses of the firmware cache
happen later.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 5f3d44d0bfe0..99c540164074 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -431,6 +431,11 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 	return 0;
 }
 #else
+static bool fw_cache_is_setup(struct device *dev, const char *name)
+{
+	return false;
+}
+
 static int fw_add_devm_name(struct device *dev, const char *name)
 {
 	return 0;
@@ -672,6 +677,9 @@ request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
 {
 	int ret;
 
+	if (fw_cache_is_setup(device, name))
+		return -EOPNOTSUPP;
+
 	__module_get(THIS_MODULE);
 	ret = _request_firmware(firmware_p, name, device, buf, size,
 				FW_OPT_UEVENT | FW_OPT_NOCACHE);
@@ -769,6 +777,9 @@ request_firmware_nowait(
 	fw_work->opt_flags = FW_OPT_NOWAIT |
 		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
 
+	if (!uevent && fw_cache_is_setup(device, name))
+		return -EOPNOTSUPP;
+
 	if (!try_module_get(module)) {
 		kfree_const(fw_work->name);
 		kfree(fw_work);
-- 
2.16.2
