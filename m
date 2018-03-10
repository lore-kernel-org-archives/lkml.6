Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELtmosq5wz1dSdggMllxFPlhqTzWXRm4AVYFOrkeYcybAoAaHeacM14BplzESR27qvfma8bJ
ARC-Seal: i=1; a=rsa-sha256; t=1520691335; cv=none;
        d=google.com; s=arc-20160816;
        b=ojDiVTaPEf7+X0p7umxI4IhWdbXU6rLTw1P0MEyPHpJOtXyAZZMYP8cz4jTw+lusg9
         P9KzdY6azuIucX9KqO2090+y6tQI/zNwlkqE3N/ea8LsSItT4Dk0EVrn0Dp8spmHFytD
         RFCg/J8KPEQyIzxrTVbHM318JWPkbtHjuf7jS7g8vurbQXz+3AK3xcVgRJEglcW/WBcA
         2Wsn5NE3wGZPZICNxj2kEYvDWxt/Y5PJm5e0Auj/ZQlKwIneaWxiw9dP1fNC7Xq/sBl8
         26pm10g4K5bUOalXSXiUjXOJQ1yt1aLEVcGwNZiwwcjNXmDYFwshqUjtevVh+GENeg4w
         EdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=0QqgFL4HY3sGKxEUBzRn7+iGL9dot9QlO4G0WWyxSN8=;
        b=E8fRAuPEpuKn7LwtTOnkAenjvhyhyh5w3Cgxh3aTJkLDbOckV7uH6vVVvY0UJAELFt
         WgiEefkfYPiD4Uevj6YWEttp6owD656q4Yzuyb9WmrvOcFdweDtJB+6K9/P0Vs52SgDx
         NlpO0mWPuJ8S8ep+ZuG1d+oxgNgAs/5YXlXgRvtyJ1hCRcjMPNeSCjofFTaZssuioHXs
         EZWpfCpkEO2VPZH0W7MSfg3ntZJ2euDzGOtmeuNsC3oLCe2V0hvBOuwnyWSmpkKHejhX
         BDzr6uxCa7+zRDvbOfVDQfCmMofo34AKHlYfCKTmsyO7pX6nvN3YN6+i15WzavQ1pzRs
         AhWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3FB217D2
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
Subject: [PATCH v3 18/20] firmware: ensure the firmware cache is not used on incompatible calls
Date: Sat, 10 Mar 2018 06:14:59 -0800
Message-Id: <20180310141501.2214-19-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560437718016361?=
X-GMAIL-MSGID: =?utf-8?q?1594560437718016361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

request_firmware_into_buf() explicitly disables the firmware cache,
meanwhile the firmware cache cannot be used when request_firmware_nowait()
is used without the uevent. Enforce a sanity check for this to avoid future
issues undocumented behaviours should misuses of the firmware cache
happen later.

One of the reasons we want to enforce this is the firmware cache is
used for helping with suspend/resume, and if incompatible calls use it
they can stall suspend.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b569d8a09392..2913bb0e5e7b 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
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
@@ -769,6 +777,12 @@ request_firmware_nowait(
 	fw_work->opt_flags = FW_OPT_NOWAIT |
 		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
 
+	if (!uevent && fw_cache_is_setup(device, name)) {
+		kfree_const(fw_work->name);
+		kfree(fw_work);
+		return -EOPNOTSUPP;
+	}
+
 	if (!try_module_get(module)) {
 		kfree_const(fw_work->name);
 		kfree(fw_work);
-- 
2.16.2
