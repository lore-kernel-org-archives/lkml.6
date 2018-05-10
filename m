Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZon0MogxqYzAsURm93v/1+ICxNXRc25mZD/ERfcmS0D7td01wEcHYfeRDTCe/qRg6D9m8Bm
ARC-Seal: i=1; a=rsa-sha256; t=1525982949; cv=none;
        d=google.com; s=arc-20160816;
        b=QnCHB8pRp/f6TTHi2dNihEn+tH015D8fkgqDh68ZBQv7WI39K82BeRQe+Rq7TDwx+e
         WOpOtKZTbKwF1Hvwd5Dbbwkv7J/b77/lnpbE7C87IAkcoZfoUNqLYFeMpCf4dSyT4d2d
         PnqWMaIkjKV3xK2lzC/eTihMSL2Y+Kdek5eoHKb8Fe0H9PKhIxADYiLmYM+lt2DI1A8b
         +oMCp285KNohkIFIZfIBIwe3H4CZeh9HrvSpWcJgHszkDU+nHe1d4SWo5CruooI9nhtA
         5eMKDbUsl5wPi2+9XIiDLfoZXKg9nJMUtVJikBC9SxSONXn2wcWw2glX/+wA8lQ2Ze0Z
         wggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kp5YwzrxErjiNrZ4uqsiVN47Rxb+BufMHyIiyxMpDDE=;
        b=hOVQ6wkdnabbBP2Z83HFz4DAEXEY8T3mXd/PX7qcts3cEgatvwn+MpKqkFP5L48edg
         BZ/vzm/MVBTEYRhmPxUyfLlehgxOxZAkMtR2khGIcsI5V156qXDeEduaugjkKHZmNQEK
         Yr7hibJZb9wXwlPXe1kf8HOCvg+9qbxN/nc5bv2icWRBSFYx4qCBs5YmW1rVIMtz94zn
         JoQTUoOKPz0ELI/Gc53NLkRPP3ZzX0qCbmxYDcYKGHFdw4zlI/V3t+NJZtqT8c9gvTHf
         5fWtyA/65pshpXGE8o5g76M78w4JgZhjxNPV7f5o+U0mE1Tzmz1n7c2djZ6jhJY6xkGq
         f2lw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=h+XWqnE5;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=h+XWqnE5;
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
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R . Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 10/14] ath10k: use firmware_request_nowarn() to load firmware
Date: Thu, 10 May 2018 13:08:46 -0700
Message-Id: <20180510200850.5958-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109096794438529?=
X-GMAIL-MSGID: =?utf-8?q?1600109096794438529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

This reduces the unnecessary spew when trying to load optional firmware:
"Direct firmware load for ... failed with error -2"

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
