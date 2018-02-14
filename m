Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x2261gG9aYR/sbXLBETW6ZL0uj/YjeRUJh62ly6cyDXb+AkS6TrsTtIpLgjyYF1TuKGS+CaFa
ARC-Seal: i=1; a=rsa-sha256; t=1518568918; cv=none;
        d=google.com; s=arc-20160816;
        b=R5mrhVIspF39PytF0i+f1/dWx2qnJAkMf4kpIjeJgFER9NFVY8NrWlFI7w3qKyIeT9
         cHlPYZM9mLVI++akxhGsmlkE8Y7fYxSnzGnTtlIppCV4TtRZ2Xn7T8CbWNR4E16nETj8
         9fUBFJh8o++sdUc3k2nymqGKznYWTgMdZbpzo+QAfSwp9xrXS6UxqegBwEp/DFDmlloa
         sZAU989OvKfUi/HWjm5yN6lE1dA3gf3xCRZvWsRle2jBsiXs4fJFt5kRqQcKTc0eolDu
         AZ1Wv/f/iQduK1IC3DFgBjlkMER1Cbeov/a2Affl52Oag/wBJtPgymO6NWAnL0ntDGOE
         c9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=N9x9RXwvlefvp4Uj0/uJEoAP35CPwOgMvZQs+G/lRWQ=;
        b=ntMdw+jZThC+DGmViV5WC5xANvthYq0rJSpUJXZ9Lpsg7kWoVy8yb3HNcyhJQpfrLi
         zwFkTq+S+cPeEP3j57M6RsRcvdZPs7Ky85/tg7SkNfSEcmE0qqAC2VQsd9ujx8hxrmmO
         swJ6XblVljG28i8R/1oiFAU2Um55fqtDtwyJsa/4krbWxk/07VmSaleRAJtRdynk160g
         z7lLXMS2FkklGJAAw/m++LkuugbBgd+iMW5Y4RK6ozIB6bTI9OvoPuKFQC7zFtbUq/nU
         zN7OLLWgycdhZjBbXH5dicVG6sAHBe/Ce+NayLVzLTGkuRX9iDlpQaYiRFcbBN0bZIvh
         Rwww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778AD217C3
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
Subject: [PATCH v2 02/11] test_firmware: replace syfs fallback check with kconfig_has helper
Date: Tue, 13 Feb 2018 16:41:39 -0800
Message-Id: <20180214004148.14452-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334922657519346?=
X-GMAIL-MSGID: =?utf-8?q?1592334922657519346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have a kconfig checker just use that instead of relying
on testing a sysfs directory being present, since our requirements
are spelled out.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/fw_fallback.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index a42e437363d9..40b6c1d3e832 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -49,10 +49,7 @@ kconfig_has()
 
 DIR=/sys/devices/virtual/misc/test_firmware
 
-# CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
-# These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
-# as an indicator for CONFIG_FW_LOADER_USER_HELPER.
-HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
+HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
 HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
 
 if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
-- 
2.16.1
