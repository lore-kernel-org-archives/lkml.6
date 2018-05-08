Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZpfHThjwSiy5wqI/mlAmYmk5bkNLXqhyQTxotD+BuAjXi/N30q8aV8ZONWmMXNWzbHJDUO2
ARC-Seal: i=1; a=rsa-sha256; t=1525803182; cv=none;
        d=google.com; s=arc-20160816;
        b=ZvXlqV2AtrFLnHNA8iKkzZlr/t0ruI2KJ7muhpWNN+1+gkgcakUxHQcqN0bCD3z6t2
         E4+RgYBHPJcZGlAq/zDw4Ni/hGUmeaVEmgk/VyfzBiWkpxCxlOgaT8BiO1p5BuKn3wuP
         anprdq76+5vOrUv/XSRXkdq+4NREH9latcP+thhPSGSABCPZkXIztxxkJvMRqyoz9ZxV
         I5rsFw13hwMVUo9Yyky6hhgUSoRzuxtX2fulM/Ue8nMM1Ydsp21RSXnVBCysk+TVLQrJ
         dYgyA+Y9wbUypvnI2C4j8YPeklLY8WjTy5oSgUleBeMAE9anS4M6TZxCjKy0Coe8M3qE
         24yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=jxaJ7758wCi+kYLW4m8Eh6UCMfLy4AXDD8cdWFcqkgM=;
        b=Y6uEzNGFNC/A4fQWbyzmzfAnjR7Ec4q4+jOLNJ9mCr4IbLmk+jzp6jbp5hEzafGjOB
         6EgOmgkTT4m3U8OMk6JLaS8hwWap0KRzeJH0DbPhUUWt1uE2nrANV8VeLL61SW8dkbWB
         BRx0KfmPaA1vtUmp0TdZfyemFPBsGPvPruHikHAACgbGP3zO1I44K6Kmm1tJJe+qkQXz
         Z+8fal+DB4ZZ2yRvxGCzpbKiczdq0Zri0YQKXZ4BKDv1ZLsKlSIvLAYMdExyYgNhKyTt
         SUHLoyc71jR5dxMiO6V+PWNEnhPXq9teZWYnSjH+i8Agebj4FVIpo36ONKMxt8jovU4C
         NkJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FqE7smw2;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FqE7smw2;
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
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 07/13] firmware_loader: make firmware_fallback_sysfs() print more useful
Date: Tue,  8 May 2018 11:12:41 -0700
Message-Id: <20180508181247.19431-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920597507290453?=
X-GMAIL-MSGID: =?utf-8?q?1599920597507290453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If we resort to using the sysfs fallback mechanism we don't print
the filename. This can be deceiving given we could have a series of
callers intertwined and it'd be unclear exactly for what firmware
this was meant for.

Additionally, although we don't currently use FW_OPT_NO_WARN when
dealing with the fallback mechanism, we will soon, so just respect
its use consistently.

And even if you *don't* want to print always on failure, you may
want to print when debugging so enable dynamic debug print when
FW_OPT_NO_WARN is used.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 9169e7b9800c..b676a99c469c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -690,6 +690,11 @@ int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
 
-	dev_warn(device, "Falling back to user helper\n");
+	if (!(opt_flags & FW_OPT_NO_WARN))
+		dev_warn(device, "Falling back to syfs fallback for: %s\n",
+				 name);
+	else
+		dev_dbg(device, "Falling back to sysfs fallback for: %s\n",
+				name);
 	return fw_load_from_user_helper(fw, name, device, opt_flags);
 }
-- 
2.17.0
