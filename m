Return-Path: <hamishm@alliedtelesis.co.nz>
X-Google-Smtp-Source: AB8JxZq5cikEjGGISIA/j5MKoJ8qRqohuybpAcQlX6iRDJKAW6CF8i/7UasvKfjUk3jQJyiIEwYC
ARC-Seal: i=1; a=rsa-sha256; t=1526261569; cv=none;
        d=google.com; s=arc-20160816;
        b=F1npvMQOTK0r76EslkipOHzp9DVnGEWksIMPtkWD5P9NbsFS8eAx7t3+A3laiCefuL
         AbYVHT/7RaLo5ElAsneIQUTbO0YK6i1z9QcwVj8xyjf8imE4jPlhNsXVGO5u59e5k2cL
         sW7gucn4J67bI4Gyn6J9RCWHcoGWAuSFAoC9SAMDi15WhHYTZ+drKOHPy/eXocQGMGGp
         vcxzDhKQ5EVFBzMKXrzMznOO4oyfJxz6X6rMVY1isFDqLijF69boOZxIDpaLVNH9Ohcd
         UMVtG1hb2ZWz+es1UdWHU6FwTixjztnZLN6u8m/C3kK+z6Xj92AjBobARRC1SwpF/99t
         vbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hSt+R0LDVWdqUiFEfnpHWGn3uZsGKPwAn9vjJHl+NSY=;
        b=RsA6sKdahTCPBb4Cr/11zeZFIiZ0LIR/JnCasw5cWbErRav6RuEktQvr1vMVy+0U23
         uW02deS5xCwM6se0Yk2W9NqABRw2ULqFmMvJT9eLAo3c59jUiasBUy/XJnv6Sg2qQyjZ
         8QUPF5RT4EdR1o6Xs85Vwl1p05Pu6GA0Cb5CmL0RcaMkGw7yNwd6ruSDA84hrJuFVdKw
         BXZgiv7RGlBg92L2bv/f10V9L2Deih2p67T1p3NRxIYC4r5CzH4DBmDoTLtOPRmeB4Oo
         TsqyuBgoU046m8J/D20UXGJYOQL+KE2CHA2ltXsVYbfacDHOrNuiZUUHcitlfmcUNNin
         cc6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=q8ZFBXqh;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 202.36.163.20 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
Authentication-Results: mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=q8ZFBXqh;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 202.36.163.20 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] uio: Reduce return paths from uio_write()
Date: Mon, 14 May 2018 13:32:22 +1200
Message-Id: <20180514013223.4828-2-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514013223.4828-1-hamish.martin@alliedtelesis.co.nz>
References: <20180514013223.4828-1-hamish.martin@alliedtelesis.co.nz>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600401251373170094?=
X-GMAIL-MSGID: =?utf-8?q?1600401251373170094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drive all return paths for uio_write() through a single block at the
end of the function.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

v2: no changes

 drivers/uio/uio.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fd4848392e0d..dd44df17004d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -568,20 +568,29 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 	ssize_t retval;
 	s32 irq_on;
 
-	if (!idev->info->irq)
-		return -EIO;
+	if (!idev->info->irq) {
+		retval = -EIO;
+		goto out;
+	}
 
-	if (count != sizeof(s32))
-		return -EINVAL;
+	if (count != sizeof(s32)) {
+		retval = -EINVAL;
+		goto out;
+	}
 
-	if (!idev->info->irqcontrol)
-		return -ENOSYS;
+	if (!idev->info->irqcontrol) {
+		retval = -ENOSYS;
+		goto out;
+	}
 
-	if (copy_from_user(&irq_on, buf, count))
-		return -EFAULT;
+	if (copy_from_user(&irq_on, buf, count)) {
+		retval = -EFAULT;
+		goto out;
+	}
 
 	retval = idev->info->irqcontrol(idev->info, irq_on);
 
+out:
 	return retval ? retval : sizeof(s32);
 }
 
-- 
2.16.2
