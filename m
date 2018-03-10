Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELtQkwsApxDZhl1ELpanVOLIuTReDMvVqL7dZiN62CStknLDA7tUujEIyLpX/LNoaNXqxSrA
ARC-Seal: i=1; a=rsa-sha256; t=1520691317; cv=none;
        d=google.com; s=arc-20160816;
        b=rzq7C48dl4jon3n+EHyHqmqg1qO/CJMTIgcelyO5vbnxE/c+JfOeG9Tj1Hid92dfte
         Z3ADs0/hKC685HkZpXc7tox6U+U51aVHSUHhnqRtqoDKfpCKtyAK0D7TD3PqQPSUpyjy
         t51ru8WDtDG1cNjCwrOgdd6PnNqYgXRTUJ9PXK1Kbzz6bNoW4X0MUXta0BJf/5Zk3wIf
         0QDXGa9GagB8VO5khtmEB/KjtikMFpv/UH4jZD73YylmvbumMPWeK9IFO5MuR0uNciWy
         jCX7hIA7m3i8VifO85jC6+U7zqkbKeUyZrf05oE/b1bzc800GkLsSRon1qpQQ/+F1/WB
         sfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=oOp7CzoREa59Ut9xWTKfQkuKta3EGJuZ/qS1oBar9xc=;
        b=rTUwNVCjMHkXS+dyMgqaI8FGvD4F6y3+LrJ50k4isW4HLBfGEiNUhHXRBMNz5acw9W
         FgPzgySHgR+IX+kzC6+QZC4QJWAHk/hLix0O5PdGMDCGPEsNQNvcyfwreItq0vCiraV3
         0iUbrDiSQZ9OtEUsAYRnNmMPq2cxwH9XVoXBhWkKptnLbHoXa8xgw8xkuoL9tf3JOdeO
         nftc/il+e7BhNdd9KUcvCyQSSw8xb0oB18OTyWEZOXXhno5Aq9sz1V6BKHD/r5Qdw8Cc
         Av6AH9hnkkhewRkgJnBbI7vd9HydvYnAuOQjFq+OIKfJKe8Zc53agm90FxxaOpArtXwq
         kKNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1F1217A0
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
Subject: [PATCH v3 03/20] test_firmware: replace syfs fallback check with kconfig_has helper
Date: Sat, 10 Mar 2018 06:14:44 -0800
Message-Id: <20180310141501.2214-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560418691377473?=
X-GMAIL-MSGID: =?utf-8?q?1594560418691377473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have a kconfig checker just use that instead of relying
on testing a sysfs directory being present, since our requirements
are spelled out.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/fw_fallback.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_fallback.sh b/tools/testing/selftests/firmware/fw_fallback.sh
index bf850050e5e9..323c921a2469 100755
--- a/tools/testing/selftests/firmware/fw_fallback.sh
+++ b/tools/testing/selftests/firmware/fw_fallback.sh
@@ -11,10 +11,7 @@ source $TEST_DIR/fw_lib.sh
 
 check_mods
 
-# CONFIG_FW_LOADER_USER_HELPER has a sysfs class under /sys/class/firmware/
-# These days no one enables CONFIG_FW_LOADER_USER_HELPER so check for that
-# as an indicator for CONFIG_FW_LOADER_USER_HELPER.
-HAS_FW_LOADER_USER_HELPER=$(if [ -d /sys/class/firmware/ ]; then echo yes; else echo no; fi)
+HAS_FW_LOADER_USER_HELPER=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)
 HAS_FW_LOADER_USER_HELPER_FALLBACK=$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)
 
 if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
-- 
2.16.2
