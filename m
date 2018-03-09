Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520604731; cv=none;
        d=google.com; s=arc-20160816;
        b=sgEm6y0JoIjgV0pvUV4E8kqd+pEQ/rTuIepZU+xjIB4NgEKn2aKuwioWfwmn5JeJiv
         qmUhqnYdC/Yr7GilOekUdEEt+aM9cD1+k/CHhddxc5wI4ttQeej5q/FOSCkKtAew4eNu
         KgLrDpNv7q7xyCvjEj9AyCnErYE9Om1WYPNY+FTnXzBB5DhCXVwVv2dOO1aWEskp3it6
         E5kvuf2gpvvkuGXmHPXIkJvreX4d809zvNEFLwrcbCCIsH2gykk0SnJNy29SvqpKOaeb
         1b/ZKnCnbvtlKSy6ydGvh2Phe3CvkNyOi4qUyAkUt7ZOARBafzkZ9O3BRqho0VN35jHk
         neoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=rPGElMYpufYBkv9jLJugk+7y9zWU0jBjKWrRl+DRg0c=;
        b=Y8eKA88IHT1eUoijyteJEmuEfFbVDMfvNUAru676Vieh7iO2Sowp9ZkLpZI2HlmqgP
         e6eGgcJY3rF6NSXaRoAvSD6dFrl0xG5kyTISBZi0NRdiDEwOcFjgMTWifmYEEkHq8wm2
         9FCZ0Nx0wqie8/D6/LRIIStf0wIVwkQzNAR7Cy6BfZUJy5/j7cFvAivobRCn246mprPu
         vcq2LTpVwr2ipKppumuZQo5lvmUDzEJAnJy4QRj0WQsc+oHcLqbCFYicqG6FI7AW9ywe
         /2pNv8CLDMIzNOySP1XqyvFdQdK0FlK7DIfQpeYvsHJlmojS7+DJ0t/leYEvJse4K5L6
         YcFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kxcRnsM4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kxcRnsM4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtaRNi6X4u1jj1G1TY2rUcDFeLyPcYEYGXIaJ9JsMMB0e6tn/5Yb99F1QrSZ28Sn2f1fKAqlA==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] slimbus: core: use put_device() instead of kfree()
Date: Fri,  9 Mar 2018 14:09:59 +0000
Message-Id: <20180309140959.30237-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594469626628037260?=
X-GMAIL-MSGID: =?utf-8?q?1594469626628037260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg, 
Can you pick this single slimbus patch for 4.17 merge cycle.

Thanks,
srini

 drivers/slimbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 4988a8f4d905..7ddfc675b131 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -141,7 +141,7 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
 	sbdev->e_addr = *eaddr;
 	ret = slim_add_device(ctrl, sbdev, node);
 	if (ret) {
-		kfree(sbdev);
+		put_device(&sbdev->dev);
 		return NULL;
 	}
 
-- 
2.15.1
