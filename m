Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZonS2vf8ws2hYLdt3J2uK07mRXbQurLCEC2fW3bKxfkdCwfQ5MgePL8YNbN4xJQ7xlLtHHp
ARC-Seal: i=1; a=rsa-sha256; t=1525803188; cv=none;
        d=google.com; s=arc-20160816;
        b=OteGHS6PvszKERkKM+Nh+WGZwuHNgtc3C0JXHvMegM8+Jb2XxcRUs32uT4z90grk5/
         bCOFovy+xbVBa21ePBEZE4ThCzu5tVuMfUP+BTqceU5UH2At40/I9/ANtHzGCL4EXEgG
         6q45NRklSHQ2lOx3PQtU1ewmBgfzbrGwE4UM4yMcMYj3jLdHwJDnjTLdkfpt5eCZpQUH
         I18AxYgcVylS/L/14qhPmYnXFWj02AQwtdqVVY8T2afiZc5BcYQioFMJv7vE0joDj/3O
         jj24oAw91OBrgDZG9ztQm6V4Qq+G8eB/sJgQgOre64+7Ei0hFpsMBdgZRxaIvtkYEi+Y
         Plkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=thDGmiSEgsfD0HT/FueSeMjWTK6am/vAIi3Nm/wWb3E=;
        b=QnvHCaod0eyWwfX9e4v2cH+NoGT5sDqYCKmElPtuUDSZgJ09EkTkFWCNxk4Twem13L
         zaN4l+V+tV3OTjdTew3XR68doXySDUsGXbt1omUPgVbg+tIJX2DiN6fSj1ZSQLQJOni2
         YkqfjwnJGg5IpzxaL6RdkvmionIXQh5/FQQdBdFZLx6HI4iGEzs0AZscMqc6MF7dJaAk
         Nc/GZKpR+DgrG9fUcxiIoWgPXHBbRq4csj+gYSKijYiYnrHrAqOyEoF0inPMFLGqjr7s
         2GOnVb9FEBsx/OBwl/6c5URZjeZpRguafjCb/11KOJiaVfrI+U2cR1s5c2foS+eVYYYO
         mAZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rGuPLQ8d;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rGuPLQ8d;
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
Subject: [PATCH v6 10/13] ath10k: re-enable the firmware fallback mechanism for testmode
Date: Tue,  8 May 2018 11:12:44 -0700
Message-Id: <20180508181247.19431-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920604331366809?=
X-GMAIL-MSGID: =?utf-8?q?1599920604331366809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andres Rodriguez <andresx7@gmail.com>

The ath10k testmode uses request_firmware_direct() in order to avoid
producing firmware load warnings. Disabling the fallback mechanism was a
side effect of disabling warnings.

We now have a new API that allows us to avoid warnings while keeping the
fallback mechanism enabled. So use that instead.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/net/wireless/ath/ath10k/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 568810b41657..c24ee616833c 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -157,7 +157,7 @@ static int ath10k_tm_fetch_utf_firmware_api_1(struct ath10k *ar,
 		 ar->hw_params.fw.dir, ATH10K_FW_UTF_FILE);
 
 	/* load utf firmware image */
-	ret = request_firmware_direct(&fw_file->firmware, filename, ar->dev);
+	ret = firmware_request_nowarn(&fw_file->firmware, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "testmode fw request '%s': %d\n",
 		   filename, ret);
 
-- 
2.17.0
