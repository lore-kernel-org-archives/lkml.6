Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518843333; cv=none;
        d=google.com; s=arc-20160816;
        b=wyWoFoG85/LlI7znhm6TZZgAVmgILN/PWdat8XxenWLlgZg9fC9/dLFe8UsDf+4t6K
         X2X+ZXMl/GHSXNSeXWRk/kfChH59aRfevlCSyo6iZjU1w9Sr5Vmb73CvzoQ/u5fsycOd
         uqgUn1id0XZ1YFeoM3Ac4Ax5JsFJKK6PDr2BmHZ8n6yzU6nFDkLtK73M6nvWMh6M94/u
         YMd217DHGpLiK++Rq3RPADDGg9DV92mQ5IfKnHS/zq8SIxxO2iNlzNSmGznsOipRXSoV
         t8XL57AUkpXR/wcovhuKEkB1o7dF8PGHwUxt9ARVtzpm3P7BooOwSEnfxrzB8trdgKx8
         4Nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=FaxL6bgENUVAHlWHgfGWCimlX7iU/BMkb9tns2Wb0uY=;
        b=LSm7t5rYJYth4QUX8LkHzl2iBSKKOk8u3j74qkgSvBRAuzGxWL1BzgDMJC0BL+vBrW
         /w2MHBj+txFdl6202sofaNwqr9ElWT6/yEKRy5toOD6d1id7faMIINzMy2C9h6KIl/b2
         aJvRHm8omZq/WZMiubJ//UyLI8ArdG5Fva50kSKWufUkRZYceP1GVHL+CL8hUywgDyuH
         ORn8v63Oa7tV2/0LcDWovYyv+VLIrv7vbf1DFUZv7BSiECsaN0tJ+X2yNQyU0/hbnrKv
         f7vjnR0uQ0zJkH3zgLM+z11NQPFiJ9gkYcSKvQG0n3H2CO8ajsA84qH6eynLI+1Z0fP3
         hLrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DW6S5WW1;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DW6S5WW1;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225q6CzicPhQwWifsbDcmXWujA5XTE3B2WS0ZbNP79llc65XeSdg8sIvQJYK3xxK2EdmM0Qz0w==
Date: Fri, 16 Feb 2018 20:55:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Packard <keithp@keithp.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] USB: chaoskey: Use kasprintf() over strcpy()/strcat()
Message-ID: <20180217045530.GA24226@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592622666371182567?=
X-GMAIL-MSGID: =?utf-8?q?1592622666371182567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of kmalloc() with manually calculated values followed by
multiple strcpy()/strcat() calls, just fold it all into a single
kasprintf() call.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Keith Packard <keithp@keithp.com>
---
 drivers/usb/misc/chaoskey.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 716cb515523e..cf5828ce927a 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -168,14 +168,10 @@ static int chaoskey_probe(struct usb_interface *interface,
 	 */
 
 	if (udev->product && udev->serial) {
-		dev->name = kmalloc(strlen(udev->product) + 1 +
-				    strlen(udev->serial) + 1, GFP_KERNEL);
+		dev->name = kasprintf(GFP_KERNEL, "%s-%s", udev->product,
+				      udev->serial);
 		if (dev->name == NULL)
 			goto out;
-
-		strcpy(dev->name, udev->product);
-		strcat(dev->name, "-");
-		strcat(dev->name, udev->serial);
 	}
 
 	dev->interface = interface;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
