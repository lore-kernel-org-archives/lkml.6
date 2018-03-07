Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520446100; cv=none;
        d=google.com; s=arc-20160816;
        b=iluF9Coxcdla3XdF9HuACyb5AmtyzH7jq3UDC0k/QbU40uj5cZg3WtXsV5LRJxK049
         FjVEV55nPU6PLvQnZe3hW2MYj085x7Fbq1B7SXDDwDWGfcAmgJwV5nOkjgv5OjCWZz52
         zgqUElEfq87uunQv2eRNbxi/3VzeMWJArRpgLnT/34ZdH84sncRehRDay1t3LhG2OUkz
         7cbLKkZmg0qTwX69HakcalfetvtCaHlSrDg+hCXaQGisZ+F9OwlsoVv9rid4T2EafmNG
         R5GfGMSWlBR0kxX2fm+od8aWj9MBvA+ozJJK6J3J/n2FsJz974Dto8aaZYF93huVBN59
         sBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=78s3U9qEK+Dc4V9aEmbSfwsDr1dK7WgKKT67tsbfoJg=;
        b=sfqTbp04VkQLZvLy8w7NEgU/hgy2gMiBvGZcPHV8m4Vf6TXeac6+5E9xkzG3p0hngi
         8h3+EWaqsDymj9um1RXBujh4kVi2jjyhjLlw6+KEkzupokKd8MyWwj2Wmu6uoE0lj16O
         SEMUS7jIpSFv/5ZveNW6ShID9cvLuWEyDkJWdKsS7rl+vsyB5cUV+9C6KjVHt3VuoBDL
         u9Hx6b653k8P3ox3D+J0Acm7h8Y/LQsl8kv2AEW6gJXCZcZV7mRYP3haa089M6ChUxUq
         0SGkXZYGlV1H9duMpG8lmQVVn03OtKs9iALw7pwkY6MhFT56wLKtsq7Rx13D4YSS4A3H
         zLNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THx0M3A+;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THx0M3A+;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv0UrfG8jMUvKOpsno1suI53OdhjSqM4ImQT9bjjASyt0XN/2tGqmWWuFlxx8wt1/AbHcK4Ow==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: gregkh@linuxfoundation.org
Cc: felipe.balbi@linux.intel.com,
	johan@kernel.org,
	keescook@chromium.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] usb: isp1760: Use kasprintf
Date: Wed,  7 Mar 2018 23:38:02 +0530
Message-Id: <1520446082-12264-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594303290138728501?=
X-GMAIL-MSGID: =?utf-8?q?1594303290138728501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use kasprintf instead of combination of kmalloc and sprintf and
therefore avoid unnecessary computation of string length.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/usb/isp1760/isp1760-udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index bac4ef5..c35b153 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1456,12 +1456,10 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
 		return ret;
 
 	devname = dev_name(isp->dev);
-	udc->irqname = kmalloc(strlen(devname) + 7, GFP_KERNEL);
+	udc->irqname = kasprintf(GFP_KERNEL, "%s (udc)", devname);
 	if (!udc->irqname)
 		return -ENOMEM;
 
-	sprintf(udc->irqname, "%s (udc)", devname);
-
 	ret = request_irq(irq, isp1760_udc_irq, IRQF_SHARED | irqflags,
 			  udc->irqname, udc);
 	if (ret < 0)
-- 
2.7.4
