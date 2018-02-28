Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AH8x226nbcd35GRq7ef2w6OrMPkurQBNNSLelt570ej8Z+0ivzAVg4w8e3dses6TF9phhntyALbD
ARC-Seal: i=1; a=rsa-sha256; t=1519817330; cv=none;
        d=google.com; s=arc-20160816;
        b=svf3nNPvo59KZOtmSBZEpPPb/A0ZNuwaEGvb1dvqr65Z58W7+qZQKdAuO/1byEGX25
         URk/gP7UyewcIer7mI6Y3VzklZx6XrLQHp53CidGH2Qz3bRIdEtJHmYy0zKaJv63L+T8
         MmgRU6S8Ek9EylloAxPXB2r/LXM50+cVapHdRfXhuSo4rcMsnbEFb5hBxSoiIP9cPzx1
         vnMskJDhnYG8LN2uCUcJmDKaT5pCn+ABneTqYJlUj8x2yfkta8lNYS0dpaSyhqHLz/le
         J7xpY1jMZa9MksesDICKVuVwqWUi0nPNULFxK3vyew8azqb8cHiUZ8V3Z3Jovj+kdhv7
         jxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=Q4lizLPE0vRGoWqiX9qyTyIYv/i2es8P/4LppIpd5vA=;
        b=lRiad914QTWZsnOMOonrABP/AI9pLnMeDcjdARHMqTgrMOW1kPZmQsoi7esYyz8yZy
         XJ2WUKoFfii5FpM/IHsE6hzdnZMjgkoItJcfmHeiBSG9H8cwuHHwdwQhPW+5IvZMxyoR
         W1CdnecSBt4j7+FMVdja0qV6dIWtOia0vjWne0giBgKY9hjat4wXxe9LH2k7faOnho0O
         5ZxCfMNICmGornql4pxRnmwfYbCXVfdH8kO4V9zkG8LRCfPQ6U5cyj7svrfyBmkNMskG
         +DsubFh6FqC3EauevXFVIQAfcK0k3MK6noPQsL0MxMCJITAFRhXHeSehPT5wZxIrJkuU
         2jTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
Date: Wed, 28 Feb 2018 11:28:49 +0000
Message-Id: <20180228112849.16327-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593643977544589863?=
X-GMAIL-MSGID: =?utf-8?q?1593643977544589863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently the allocation of priv->oldaddr is not null checked which will
lead to subsequent errors when accessing priv->oldaddr.  Fix this with
a null pointer check and a return of -ENOMEM on allocation failure.

Detected with Coccinelle:
drivers/staging/rtl8192u/r8192U_core.c:1708:2-15: alloc with no test,
possible model on line 1723

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 3c300f7b6a62..d607c59761cf 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1706,6 +1706,8 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
+		if (!priv->oldaddr)
+			return -ENOMEM;
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
-- 
2.15.1
