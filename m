Return-Path: <contact@paulk.fr>
X-Google-Smtp-Source: AIpwx4/XkSIvK3FLMtBdqZ5qDrLZ2jbLtD3VG9MqvJ6s8pwngqv8Z19C8RlfcqChY4gsNJ5KkRLT
ARC-Seal: i=1; a=rsa-sha256; t=1522273957; cv=none;
        d=google.com; s=arc-20160816;
        b=r2KfpPFKZ5AthIKN0PISa7LLnLTRewDbxnZntO2h38/k1NkzbFVGLmMH/EKQCxdDO/
         t6MIJrmONw+I8n3fYUroI1/34/KvIByP8uyqgIQJ2/LuX05GwSdqKFwsSCLsmeLLZ/gW
         pIkbpzjoV9GOvz+lIDks1wGCtwXRFBtSWamR6RlgZ098vjT5f3gO/sdLQRfz1dzJEGAc
         KGMi9A6x9RrIZhU4rSuN8a1haTyV920ZKogi0Ln1tp+JUURaAolN33XLWJw8cVCgy1Ui
         FjWCGIopbOcgdrFrFyf8Hs0I4Of79tlm2CkUrGzfsA9ihW/p/QTk7Re5WaSjQjUc1+eH
         9w2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=nlzyShky6WpJ/xyW7H/BZ8Cgqp/lzGgXZH6et/YUnDM=;
        b=nNILmrKMeeIWMY95PpekcnSy2mX9vaM9ooQWBGcVwDWQHWt4CEzbuz95fJXsiV5yzK
         CxFSPAfASueaM/b7cY3HpRY2YudeXOdZwep7T60dHMmuZMHd9pDLBj9nSg7/FEPpP9aK
         BNxD2gIMyvIfIceOMut8vE7AAzp6PdsnRUlvOMEgPcO+QH7/W6NhIpTFH6KFnAUc1cHZ
         i6F4PllkISHGg4ExZS0iwP8uBawv3EIueyxYynj98Y2jDenSj1uLX+O71984bySVm7Zv
         V+kgzi82fPd+/m00hmGiYRevpWRF5BEVcmW+SYWMQUC887Fw08BEzdq3e1j6SLlnBwU2
         PPFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of contact@paulk.fr designates 77.128.107.220 as permitted sender) smtp.mailfrom=contact@paulk.fr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of contact@paulk.fr designates 77.128.107.220 as permitted sender) smtp.mailfrom=contact@paulk.fr
From: Paul Kocialkowski <contact@paulk.fr>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Liu <b-liu@ti.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] usb: musb: Support gadget mode when the port is set to dual role
Date: Wed, 28 Mar 2018 23:52:13 +0200
Message-Id: <20180328215213.29538-1-contact@paulk.fr>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1596219936239404188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This allows dual-role ports to be reported as having gadget mode by the
musb_has_gadget helper. This is required to enable MUSB at all with MUSB
glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE at init.

Most notably, this allows calling musb_start when needed in the virtual
MUSB root HUB, regardless of whether the current mode should be gadget
or host.

This fixes USB OTG on Allwinner devices that I could test it with,
mainly A20 devices.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/usb/musb/musb_virthub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 5165d2b07ade..8fd5c5f86e82 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -249,7 +249,8 @@ static int musb_has_gadget(struct musb *musb)
 #ifdef CONFIG_USB_MUSB_HOST
 	return 1;
 #else
-	return musb->port_mode == MUSB_PORT_MODE_HOST;
+	return musb->port_mode == MUSB_PORT_MODE_HOST ||
+	       musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE;
 #endif
 }
 
-- 
2.16.2
