Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x225U+PN8I483eUPmuwF0EIb5L7UHlZ9gR8zP9NStM7LseNh6Em67I8WAdGQViVOC2zLheQaB
ARC-Seal: i=1; a=rsa-sha256; t=1519440378; cv=none;
        d=google.com; s=arc-20160816;
        b=fN6Kgiu2y/sO3OKStk3vAVS5fIydwWR/wb/J7K40lDtAuRw1+sRO1FQbMIxHmSssJR
         Jl4SgI5Giuu5bD28F+xljkw6ph2/QauCTm8KseZn9ZjbfUY7JAejjvZ1Bn4PGteqINUK
         pRqEpWH33X8qix1+rH9rViTm+RlCpQsao/IogG+V+LrJJbDH0U7gQWCmIH52fsypIrCC
         y0MXvEdj29Y54l861D+0Z8KRdGhM10V53vLofxVavXe7MJkpFJl4edyYjoPRXwmURu78
         0lgMBc7qMCcfAHtjE+3/pGJS4uzX5OqcDz7jMaPQi+PFVR2CLZGc62XS+M1iRyUWIHVV
         W8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=A8xeqACFuBD4wdCipn59StcUHx5aI1qZmDwYTnPJNW8=;
        b=A9mpssH5oolpN35fgElv6n/bXP6kmYESzek0KD5FfS3tyyWj7NqYzeIU7rF2+q0wf0
         qfna2CjNDLY1iWU7WeI3P2WFNZMS8v/w9EgbWPoB1qee9V36q8N2ICgLmcP+J0giV7N9
         idZ5cnWdk9JjsRW4xuahu0kCxtpJ1Pq49zY8wxcfSPBRFO96+l8sa5GwTyEIYNcAdvrl
         sTytSamHA4CYW2a1w7g0x5O98a/lDuTMV6FOI/9QHctx+mpGxANlJCGBXhcxWZPzHy2z
         2YW0Ki6q0oKElDqqeDPqMkXgnZlM69bOWsgnbPlZUJjxA/lAUbJkMtjxMBEzf3b0OEG1
         OocQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A38217B6
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
Date: Fri, 23 Feb 2018 18:46:04 -0800
Message-Id: <20180224024613.24078-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248714473643725?=
X-GMAIL-MSGID: =?utf-8?q?1593248714473643725?=
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
2.16.2
