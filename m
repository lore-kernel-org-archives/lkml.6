Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524514346; cv=none;
        d=google.com; s=arc-20160816;
        b=pT6HV8b4uwdHPBymmJQFgjNhZtnWu76m7VTezCRZXoKyzkoBXIf4DLvnaHmJYM8iAH
         4xo89NqZOr8xig3FHZ30kqBc8YzBcHzIfCZiZP0AmDWbgIIvkB/+slcMZjROXSkbf//3
         iBjmvhLTI7uWCGXcPct53wrwp/WDkquU2EpNrU6tbeTBVBpMCb5awqjMn/Avsl9QWVeN
         //D/HlRalGBgfoNv2wtSHTMh8EcixI27RW0CJ/bDhve9fdRW5wrEZ6b8vWyex1+sMyhY
         BQV7cS1qh70C9LxLHTuaMlwfav5s/BL/QYMOApVlG+nTuwVzcr0gq6aZ/7mwblWkIDgZ
         g/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=jKkPtOxxsOO/OOaOXa1om3vVQfSWXWBuAWW8jjohDgs=;
        b=KA3aW/4tthKTIrOsMImTWEbjXUnWwYL9oH4vnXTP8duGkcaiNKIBT8sWlxRknoc+aC
         /rnr6cN63VdTIaX+6USBmdNwEF2mFYCwduO9VpmTwc/Scb/kuyAi1Aj4G6LAeIoL1mu4
         eYC49lQJhYBkOab44i1A93afGH5e8xv+F42qNgJfO/l+yDBPKMbhlz0ewl/txxxkXnb0
         skyxHuRggUbgAhOoIqaliFpDclCfotruP9Evv/lCKEPFUVAqKv9Us8NexJ2cxLmt+vL6
         QCHmpHH0rU5Y4ITCeMZbbm6TS0s0RT9gmXNVwyXy1rAUxrTLo7sgFL01qMnrr1SnDxI3
         yi/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZQ2qhiaV;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZQ2qhiaV;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/XgsWHPjDVHMR93bFF2M7zVdmhhu6D7Rcoy7Mpv5TWULb81up5d0CT6RSQyRxEJB6U/SBSFw==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	christian.koenig@amd.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	hdegoede@redhat.com
Subject: [PATCH 9/9] ath10k: re-enable the firmware fallback mechanism for testmode
Date: Mon, 23 Apr 2018 16:12:05 -0400
Message-Id: <20180423201205.20533-10-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423201205.20533-1-andresx7@gmail.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569155393692911?=
X-GMAIL-MSGID: =?utf-8?q?1598569155393692911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ath10k testmode uses request_firmware_direct() in order to avoid
producing firmware load warnings. Disabling the fallback mechanism was a
side effect of disabling warnings.

We now have a new API that allows us to avoid warnings while keeping the
fallback mechanism enabled. So use that instead.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/net/wireless/ath/ath10k/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 568810b41657..0beb91be1b1c 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -157,7 +157,7 @@ static int ath10k_tm_fetch_utf_firmware_api_1(struct ath10k *ar,
 		 ar->hw_params.fw.dir, ATH10K_FW_UTF_FILE);
 
 	/* load utf firmware image */
-	ret = request_firmware_direct(&fw_file->firmware, filename, ar->dev);
+	ret = request_firmware_nowarn(&fw_file->firmware, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "testmode fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.14.1
