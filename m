Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZo4k4AKL/NWwagiaPM84rZhvwYl5v/nWOS4qXwfX0sRQnH7cUP0apbd1CN1zEMZuhwXtkJj
ARC-Seal: i=1; a=rsa-sha256; t=1525982946; cv=none;
        d=google.com; s=arc-20160816;
        b=rEcxhye9aw2jWvTUKPnG1557410Kr/u/fnxcxm7B6AqC1oNyj2lSJTP289ZjV264IX
         A1iWYrIZ6MqhV88omE/F0bVaXB3Z/ZGaCL4pEmNSACUT/wZ47diplJDJ2Qg9C6XztPHe
         pqBH0jQJI5Tzbd2ZQUMSdhSrfZ5aHQZZ37X9e+y6Mo1cFxddR9+a7kRoQzFdnbWOCMKl
         AaqnL95cacRDUIGaZ1zqM20OK5uFdBt5EGPkueo1sJEGpr05Zv7TL5TykgAfqMF5VHz9
         AGsCOUn0XNGYGfKZRB4DOjNGkyIbHfhD0wMztmj/TMViWW3B3I4YhMpUlF9cPoAHsnSZ
         Ficw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=KYVRq739uC/MhFs4CSOhw2SV0jNQU5seB40MUClJ+n4=;
        b=yv8C3J6TN/E//QK/I4mk9BvdyiyYgCHKR/R2mFq2qlSVUFZk45jCML7JSs8B0q8Hne
         NkOAj8TqxR7QHHFvZH3DLJu1aZm1y5LBEFHQHXC/gjs6SqL2+M/Efg6n3RsnVlAe484p
         7sLMldZFNhNnrvuDalJUcKud0Q+3NmRZp1QqoltuGDiTj9BXdyUeN1X7UrQQOdJDXX1R
         5FMBewv13tO8A0snDERMxW/fuv26ixhoG4m6NKYCuEKMNOfheSKYwP/R/rsHh53FLrBP
         Za5IYuOtr4XOwbvOIWUW3IQxYlVGXYeFzX8Zm3bFwumW5SMwUw4x0yerwplq1PZaMdre
         wayw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qa/deNEx;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qa/deNEx;
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
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 08/14] firmware_loader: make firmware_fallback_sysfs() print more useful
Date: Thu, 10 May 2018 13:08:44 -0700
Message-Id: <20180510200850.5958-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109093699518440?=
X-GMAIL-MSGID: =?utf-8?q?1600109093699518440?=
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

Reviewed-by: Kees Cook <keescook@chromium.org>
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
