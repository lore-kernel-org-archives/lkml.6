Return-Path: <hamishm@alliedtelesis.co.nz>
X-Google-Smtp-Source: AB8JxZpe5M82JfAOG5AKiPdUlhQDZzrKv7cN2PeXLRfmwXonqFMZFHgh04b/m34LUsHHEc2mB4fJ
ARC-Seal: i=1; a=rsa-sha256; t=1526001237; cv=none;
        d=google.com; s=arc-20160816;
        b=mjwMpg2Zi1Sn5Wm0y39UILonrfjH8MQURihF9HFx4/uasVlYFl7Km1dyow/z3qGNGt
         m45ViPzpSKbUefD8X2ZrGGLY2xyP2G89j7jJfs4hcPMUFbteKe4vPkeIhnGLF/Ycn+H4
         /DYoQXHxiwyaKr4t6D3rsGo/qfjnW7LHWnvoguJ7OijV4vRb4rUv24QpekjjPHLajSg7
         GfA0jNBfTjkJoD+QCyOxV7rqYw7eubArJgfDyfgqHsXu0dB4Nf4lGBjDaEJSfOXwOZRY
         Z/1pR7FlzO0n+mR9AFFFtxg7WgLcMih/lY5kGXOs9pqtEXoa7d6eTAyxEZrUpKXz9bPi
         gPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YQTqS1dTC6hImCsKxogh+29SDHat3bb7bb5KVdD0+iQ=;
        b=gMpkT11BMPELrmrmMf4PYrA/IqGsWIUHYVwMudPgbyQ9PLsE7wrWSEXICit+zl94aU
         6tVaMSAX+X8qzQPElb2Y3IghdKH0j9nyvBYw31gRCq5M6+N4kkTcc8J/wV8inGms+3OX
         GBW2E3Pq8AYzoRcMc9ZQxqCMKKbxM20qz/0DJvsWu9i0u8WfbrcA3X/m5VGAvl6ZklTd
         ffG/usQ+F1kJWR8V0cuj4pBu3SANCqUM1NGQjbL+nz94YpIXs1x7EFgGxoT8USM2oxcq
         MEP5GpXLDODk59D9P7K1xvEdV2r7gYsbEOUl56+2ajGFe+E+O1K/6WeTdbhwETD5DAy1
         Fphw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=iNuD+2pZ;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 2001:df5:b000:5::4 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
Authentication-Results: mx.google.com;
       dkim=pass header.i=@alliedtelesis.co.nz header.s=mail header.b=iNuD+2pZ;
       spf=pass (google.com: domain of hamishm@alliedtelesis.co.nz designates 2001:df5:b000:5::4 as permitted sender) smtp.mailfrom=hamishm@alliedtelesis.co.nz;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=alliedtelesis.co.nz
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH 1/2] uio: Reduce return paths from uio_write()
Date: Fri, 11 May 2018 13:11:04 +1200
Message-Id: <20180511011105.12193-2-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511011105.12193-1-hamish.martin@alliedtelesis.co.nz>
References: <20180511011105.12193-1-hamish.martin@alliedtelesis.co.nz>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600128273256708398?=
X-GMAIL-MSGID: =?utf-8?q?1600128273256708398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drive all return paths for uio_write() through a single block at the
end of the function.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
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
