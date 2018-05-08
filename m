Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZqP3x4iW78WDvcjlRgc06bhA+BlwZ4/H1hWlV76gXDcA4Wx48hjTMg8utmE+oLeeh55qjUy
ARC-Seal: i=1; a=rsa-sha256; t=1525803185; cv=none;
        d=google.com; s=arc-20160816;
        b=pjASq4NJiFBMM1lhsoPIGw1UIjyteXD8MfB9v8AhTZWm4gYFSgTTB177k2xcZNeEuM
         kBW3NBjjsMCAKKS49DWyzVvsW4E4SvkAcGU0fVAeuD1RsQwFrsyW+zjdiyYocdmQbQ8E
         hsULZ+APw62D73CbU2xE271iTJDWTg8AVG+rZU4C+leU3bQgKRH//M4he4xE33A8585j
         6KO1d/DaE6JrJ4jVxo0jV0prpFKhKIHQyZpOhA8+HhP/Kg8UelAk6e2GZHa1QEU3Qh5u
         8NP8kPZMm8bG94uPqtxwj5mx2MHgq4iYNvG2Kt644pWerxkzK7HIw9Qa1w2pB/T7K7V7
         PP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Z4nZ/FxDVVhdMQk6Ki828GPuoltPXONROiJ1sNWsH6E=;
        b=DrEPoGAQiYxLCsCSAbMNsEWtyLZx/PYLhOjljRflaEPpFN/FZkk75z2zSiBZnqaP+B
         6WuJatcJg8SLAk4PHFf49Uoh4MOQKmJX5+ctbcNJUKBQR1b4OSJn1LiSA/1NmHAWb5/i
         s5ZCQbF7LW2qf17QCYpXf7AeDst2OXzLQ55mKmcau5f1gRzm7IFre2utDJRrxKMldWIt
         H0QwFr4EyecYHau6sTHhAiHFEIfOl0y6Y/p5cWvIbs/yXb1JK9tZkjTSn/44f0p05lYM
         twgbt7oSR8/hKwvJQs/sNwbFsYMvuc0vTgFfqz8j9e5pTHySS1ZqF8BD+0wHUkHpOX9d
         EehA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K/V+Stfx;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K/V+Stfx;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 09/13] ath10k: use firmware_request_nowarn() to load firmware
Date: Tue,  8 May 2018 11:12:43 -0700
Message-Id: <20180508181247.19431-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920601342633676?=
X-GMAIL-MSGID: =?utf-8?q?1599920601342633676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

This reduces the unnecessary spew when trying to load optional firmware:
"Direct firmware load for ... failed with error -2"

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 4cf54a7ef09a..ad4f6e3c0737 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -694,7 +694,7 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
 		dir = ".";
 
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
-	ret = request_firmware(&fw, filename, ar->dev);
+	ret = firmware_request_nowarn(&fw, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.17.0
