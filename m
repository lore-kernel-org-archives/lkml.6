Return-Path: <wangxidong_97@163.com>
X-Google-Smtp-Source: AIpwx48GQMh6utK+iwOIIBLZp/7flHHI19cZznxPRENuuLJ19lpLj0bnR7jGOADvmMcvYnfAXX/O
ARC-Seal: i=1; a=rsa-sha256; t=1522762439; cv=none;
        d=google.com; s=arc-20160816;
        b=sSk8IWs2fPJjTOpeYW32l9JoAQ3PUhG0JqQMxM27arDipLv+76AAz/FRbcuOdkTz5U
         ZE+ZgWQgq2VeiH99p1S4WKyw4CzjDW5kXDlsSrrB8ErJwKcPr7LC1qxfbnMRGHoVNe3L
         /AHjn3CMWXECC6I1q/dczoFrRGqgwoEounzgVgAy1lhW7EiLyU4XiBH4fWSAsi3NS5J8
         AfW3EoUvtSXJm1oXvv1oH2SV4XRNHSLW6SxgCec5nLwzLFwCTnekglC/I5zh+J32tkpN
         wdl3msLMtPXW6iq0vg9MSoCo4t09UbaV4KvLV527tqZj6qz57Le1MCjFfRdO2uIJ4e8c
         3Vnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=O27ZuhaigASmotBJ5KHZUSPzeDWZr2nRX6nGK3G+VN4=;
        b=Af0DN3jnMb1BXqGQz9+uZ2tMB7bPMB08ejpMTeF9BHrSDVUwyooxld0z9kEQBntsTt
         pQY8IP3pbtGFAjnXQ4gUQV+QCxaEcZOWJpR2JnaV1317ZSv4s1h6Uu6SKLxbywwNUr26
         tkDsNBqEB+WST2fqijtGrxicFwMYOJNocw0sswND0hs83/WYSuwSOM1sKWXyRO1lMxbq
         EvK2mv3A+0T8uGdN2NqGxLGLMBIdCBZlIEbjGPsUx6LpOG+z/4gi3z0p96/XiSdE9rEj
         vgADxZymR04KH9V0ixTrCQ+faPGSVR1UmLDgKwvLLBlb5mTqI4c7i8w9KN+WSB/p7m/7
         IPiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@163.com header.s=s110527 header.b=QUYscxP1;
       spf=pass (google.com: domain of wangxidong_97@163.com designates 220.181.12.11 as permitted sender) smtp.mailfrom=wangxidong_97@163.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@163.com header.s=s110527 header.b=QUYscxP1;
       spf=pass (google.com: domain of wangxidong_97@163.com designates 220.181.12.11 as permitted sender) smtp.mailfrom=wangxidong_97@163.com
From: Xidong Wang <wangxidong_97@163.com>
To: Xidong Wang <wangxidong_97@163.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Xidong Wang <2711406067@qq.com>
Subject: [PATCH 1/1] taging: fbtft: fix memory leak
Date: Tue,  3 Apr 2018 21:33:06 +0800
Message-Id: <1522762386-13990-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowAAXypWZgsNa6BnxNA--.1119S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UJr18Zr48Aw1UJFWkWFg_yoWkCrX_Wa
	92v347ArW8CryIyr1xCFZxZFyIgr4fAr4v9Fy3tFZxJ3y5Wa1rJay8Xwnxtw42q3y7ua4r
	Cr4ktr4avw40gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5t3kJUUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbiyAId81p62GyJSAAAsx
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596731155733578693?=
X-GMAIL-MSGID: =?utf-8?q?1596732147740837075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xidong Wang <2711406067@qq.com>

In function fbtft_framebuffer_alloc(), the memory allocated by
framebuffer_alloc() is not released on the error path that txbuflen > 0
and txbuf, which holds the return value of devm_kzalloc(), is NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <2711406067@qq.com>
---
 drivers/staging/fbtft/fbtft-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 0e36b66..e92771e 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -836,7 +836,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto alloc_fail;
+			goto err_info;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -872,6 +872,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+err_info:
+	framebuffer_release(info);
+
 alloc_fail:
 	vfree(vmem);
 
-- 
2.7.4
