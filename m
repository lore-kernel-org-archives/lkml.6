Return-Path: <himanshujha199640@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520447922; cv=none;
        d=google.com; s=arc-20160816;
        b=iXNwscPb5eBCyYgs0G6MIttLMcNIegoaVB/kcxtLrMizTtRNOumSdBdWAlKtdaWcsv
         XU0ucoPgk8IrdxOVKYCaOsN7bKCw8XBCXhgRs1cCvH99z2BVlGwtY11PajLfKKWtkBGq
         tIKEjSOZHafjaFIWhmHc5Drg/jyOXFklNevXtb9XW7aZ1zl+6OShE+oWSxP+h5wJJfDY
         eaV1IW/++Qt9w1bjve4Y0PHRXG1s5zsGe5Ob20CSMZcIzsYfH2iLtD+4uoMQbht8rGvO
         YOdrtenzUvUoQ/SSyaIekyS/oyjghDR4lPHIj7XN3oFtTya99oP/+PsGxtmlHjU8xEYc
         ovlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7/DYriwH9Fomuwzj6RQGHf/zPw97HdoLlz4TLYjDRog=;
        b=i1Gt/o0e5O8HgyTO5UFiuSpAbMjYUdNmvnxaggIsMpOxvAwoG0oMWVCTfGEbYX+FMs
         0NPcpa71p111Ep2NSJdK3hi8HqrHtOSkgLJ49WGJqzE6qfv/F1j9uRbGvprL5Cxx1AMl
         cKXLXQ45FOyoZHWFjOlxisEs/VN2BKHsxx2uUNBYRcCifAh7waapz/FESf4YysgwOPku
         t5PBY+6XAoH1ENh+2ICFjmEv4pThFTyd7BOYthUYF521Ngu9moE5Uiw4KpLy60EIZ3cK
         NCG47nSDSupy7Jbo9e5WBJdPQ7Xc5foIn/2IFZKvw70/XOhhQi4kxubYn4C5R5AfvBLf
         NM+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e0dN2EqU;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=e0dN2EqU;
       spf=pass (google.com: domain of himanshujha199640@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=himanshujha199640@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvhQQz+9B7szh/yhNdWrfEhmIqtimoSv3umBoq+GN5lU/quqtn81LKgKMEnnYnqh5ilkD92LQ==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: gregkh@linuxfoundation.org
Cc: keescook@chromium.org,
	johan@kernel.org,
	felipe.balbi@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2] usb: isp1760: Use kasprintf
Date: Thu,  8 Mar 2018 00:08:24 +0530
Message-Id: <1520447904-15160-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594303290138728501?=
X-GMAIL-MSGID: =?utf-8?q?1594305200755879112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use kasprintf instead of combination of kmalloc and sprintf and
therefore avoid unnecessary computation of string length.
Also, remove the useless local variable.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/isp1760/isp1760-udc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

v2:
   -removed the useless local variable devname.

diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index bac4ef5..1714b22 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1441,7 +1441,6 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
 			 unsigned long irqflags)
 {
 	struct isp1760_udc *udc = &isp->udc;
-	const char *devname;
 	int ret;
 
 	udc->irq = -1;
@@ -1455,13 +1454,10 @@ int isp1760_udc_register(struct isp1760_device *isp, int irq,
 	if (ret < 0)
 		return ret;
 
-	devname = dev_name(isp->dev);
-	udc->irqname = kmalloc(strlen(devname) + 7, GFP_KERNEL);
+	udc->irqname = kasprintf(GFP_KERNEL, "%s (udc)", dev_name(isp->dev));
 	if (!udc->irqname)
 		return -ENOMEM;
 
-	sprintf(udc->irqname, "%s (udc)", devname);
-
 	ret = request_irq(irq, isp1760_udc_irq, IRQF_SHARED | irqflags,
 			  udc->irqname, udc);
 	if (ret < 0)
-- 
2.7.4
