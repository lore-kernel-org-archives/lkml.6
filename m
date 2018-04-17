Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979203; cv=none;
        d=google.com; s=arc-20160816;
        b=rgfxCGwS7Xi0rVhBRzV6KTGfwbXRewV6sRTj1NUtf+u7RG4xw3gBzFaQf4ItFfO4++
         G8A6W9LEPoFHZ2Yk36n3/a/0KuYcSqEoBkJgUkiTozpkao6UN6IKDAj/mtaVugHrXdLG
         VKxMtUNnifa09u8s+fIN7qCMa4KDgCMTzv/xi70i/5jC/qGm5ppi8O5zgfdZa04q5pOB
         ynlrMGqIU0MrRmBtJmBTab42EjVmMd6jxPaV56NkI5ypW+6Xpa/cFjchqwhHRjxrvfH/
         giOkWkBK69UyJhAF3ii4UStTIwh8yJJaM3rNORnYg78gv+5ueiglcywBPr6hfuk9XsWE
         4Nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5tnmS4A0EkeinAzDvDrUlGtQwgojMNe4S8UGgYfzhE4=;
        b=jdsyEm7MHlSAHciKedtGDViTUnjes71DzLXeoNjA+61/ECs2XH4BX7qjvjrrLXCShK
         dbzwjndZygpH2DLVuk7GdkvymYhSYogABfEOcpvlU0C1IkMp7yyiZxor4Y0iW+UPNW71
         BV2EylssJMDzstMVD808lgSu0CVqYckGztxDoZ+PwmgQPndlbpJaewtprhVbsKWcApSD
         W6TOUSYbN8/yXpZOm9Lixpxr/ANkIHzVH2hZSK/5S4cCH9D2zs0xVYie+pJ5iB10h3ST
         O1AwLLErqw6haCtehuc/06cdc1eDrUG0Sa7K2itdtFFHFa2Y9/e7BtnFNOjGHdCzC8we
         u1NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YhtQ6A9a;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YhtQ6A9a;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+XFM9JhB2+j7dmPUQu6dTim4SeABFOv1I9eZgaGanMc/8GooEL1ayXQp11rfXOsGEdLBmKdA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 6/9] firmware: print firmware name on fallback path
Date: Tue, 17 Apr 2018 11:33:04 -0400
Message-Id: <20180417153307.3693-7-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180417153307.3693-1-andresx7@gmail.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008016450515406?=
X-GMAIL-MSGID: =?utf-8?q?1598008016450515406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Previously, one could assume the firmware name from the preceding
message: "Direct firmware load for {name} failed with error %d".

However, with the new firmware_request_nowarn() entrypoint, the message
outlined above will not always be printed.

Therefore, we add the firmware name to the fallback path spew in order
to associate it with the appropriate request.

Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index e75928458489..1a47ddc70c31 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -669,6 +669,6 @@ int fw_sysfs_fallback(struct firmware *fw, const char *name,
 	if (!fw_run_sysfs_fallback(opt_flags))
 		return ret;
 
-	dev_warn(device, "Falling back to user helper\n");
+	dev_warn(device, "Falling back to user helper for %s\n", name);
 	return fw_load_from_user_helper(fw, name, device, opt_flags);
 }
-- 
2.14.1
