Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AH8x225Pg4eDkv6OjWuAS8djBfZrzXtRABL125uHYaCiK5LMVG5t13picOKIyzj6tkUWnC6RGlni
ARC-Seal: i=1; a=rsa-sha256; t=1519321157; cv=none;
        d=google.com; s=arc-20160816;
        b=tpBEeXLlBRXRxuL56dun1SMeNXGHiuir0BQ2YwiiUnuMhMofjUiYaIT/r3DaU1H56S
         wpMh1e7cX6IX6zcwoIljD5GmJHxSgFIypbEq65egfnbmYGEHe6MDqAVl4iiNTyXViTL5
         jBmk2yyocUxI6ov2qy+QyF1VedYVPWn6fCHYPeMpWinVliheCTCaUYdyfcD9/PoB66J1
         SZYf5dPNb9NSs9D2e2ERlLXoU/NAQxNeHrKqG1BWxoUHIMgm8OJCBdJvh+dYbqOlKxF6
         d+O9tv1PNdvzInaKBtY4zV8GMmhPCIVlkwHgbifEey6ol3aQO7YM5fpj8IoMu/Z58sDZ
         uinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=3CG81BIdh8ktZ1lwYP5/xbtY/7dzA4am7fIvrmaYYyk=;
        b=NdcDns2pJUrKEqo5XrdTf2HIVPx/1KPDEUQ8IdteQYITcCqZcTFrHThNC/8hPLwdzZ
         p3FDw96GQf0yuR7Dgho6y+2nS7gzQGNg7tqo6vPw5j50qulPX216deGfLtFyDEFlk8oP
         OlZJbMi9DpFJhLJ0Oiw4HhobkXVZO5jbFg7g8kv597iQ6GIG1fdPAy4UlJhXc56zmK3/
         FzXtrebVbTm5q2GoFtXk7XDegtSLb0WCQ6p4vm1hoFW8hdoYz9QTedOoah5qb0xkYzoy
         bw2qavV3F9cZikAsHA/pxftszUxLKUbldzD5cQI/2d2/a9u9B9cwqWZdQixKAsgyVoVW
         iaVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vudc: fix null pointer dereference on udc->lock
Date: Thu, 22 Feb 2018 17:39:17 +0000
Message-Id: <20180222173917.10841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593123702701163352?=
X-GMAIL-MSGID: =?utf-8?q?1593123702701163352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently the driver attempts to spin lock on udc->lock before a NULL
pointer check is performed on udc, hence there is a potential null
pointer dereference on udc->lock.  Fix this by moving the null check
on udc before the lock occurs.

Fixes: ea6873a45a22 ("usbip: vudc: Add SysFS infrastructure for VUDC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/usbip/vudc_sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index d86f72bbbb91..6dcd3ff655c3 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -105,10 +105,14 @@ static ssize_t usbip_sockfd_store(struct device *dev, struct device_attribute *a
 	if (rv != 0)
 		return -EINVAL;
 
+	if (!udc) {
+		dev_err(dev, "no device");
+		return -ENODEV;
+	}
 	spin_lock_irqsave(&udc->lock, flags);
 	/* Don't export what we don't have */
-	if (!udc || !udc->driver || !udc->pullup) {
-		dev_err(dev, "no device or gadget not bound");
+	if (!udc->driver || !udc->pullup) {
+		dev_err(dev, "gadget not bound");
 		ret = -ENODEV;
 		goto unlock;
 	}
-- 
2.15.1
