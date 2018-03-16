Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt4AzpoGm0113Tdnq2MdrojJJg0WnKn/jQZ/g4A6qJnkSWYJBYXT4L+tJou/2sbmD+me7Ee
ARC-Seal: i=1; a=rsa-sha256; t=1521214550; cv=none;
        d=google.com; s=arc-20160816;
        b=VLmZDu2LGDdIoohsl7wUTJweWfnCxOEq6Fdwg065SVjcnWFCFl5JouRTUY3Ooad2ON
         euE7YTehf0tV3pJYjiyaOQ3Mgi6I9YeDro57xofUKpIyU1bcIQU07Jyjm82uS/VdRoS1
         6rhWxJ/QTy5JmRairAhYXpxzB6+sw58IcI+Zb25rDxRi7G7sT71c6mNJxZcUyxZGdn16
         EoOYEOt/ptQsXM4YJdEzalaESeoS2mPNNf91M5xzsU0pUaQMKQCZqEIatQUFFCv6GRnH
         QNssDaCXDdyfHaTt8EDjBVxtSnPyC/jpPcX5rRI+Lxlp054da/fusjRKxKpVOdVOBKGQ
         +QlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m208RTGg+/kHSgHfPGePYKesr1GQG2oS3vlsxXkMs1c=;
        b=c2zifoo0n5vE3DBAk16FS6wWk1BZAgnNiRfT3kkrqTvIAivscBi69s9q4l9t1xRW1Z
         M8JietMUm88Me1S/lHmcCI1owylMswaqGEOMSEko39yjjmhn9QrXvUXuhtTmHFFeQbML
         xyctOCjYInNeearf24IHZlCRUMTqyidp2tAvKg6hBfuH33l+J1PBNbNo1Hg6vWQbiKPk
         76PXdm2PiT8UVcBIu5vWWa6FdIPMNLrVWa+wEMdAI8Co50g+2k8XWo74uohNaaWHpC5X
         dAxzAAgsCYj6c5nawYWwwVymflQG3oKo7vtU4UaQKkkzRTHdXf9opq8nw/h/lIw2Ax44
         YJcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 046/109] rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()
Date: Fri, 16 Mar 2018 16:23:15 +0100
Message-Id: <20180316152332.473085457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109068875020438?=
X-GMAIL-MSGID: =?utf-8?q?1595109068875020438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit f2eef045de9defbc6fc6b72b17f0941cbe26c81d ]

brcmstb_waketmr_probe() does not disable timer->clk on error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-brcmstb-waketimer.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -253,7 +253,7 @@ static int brcmstb_waketmr_probe(struct
 	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
 			       "brcmstb-waketimer", timer);
 	if (ret < 0)
-		return ret;
+		goto err_clk;
 
 	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
@@ -262,12 +262,21 @@ static int brcmstb_waketmr_probe(struct
 					 &brcmstb_waketmr_ops, THIS_MODULE);
 	if (IS_ERR(timer->rtc)) {
 		dev_err(dev, "unable to register device\n");
-		unregister_reboot_notifier(&timer->reboot_notifier);
-		return PTR_ERR(timer->rtc);
+		ret = PTR_ERR(timer->rtc);
+		goto err_notifier;
 	}
 
 	dev_info(dev, "registered, with irq %d\n", timer->irq);
 
+	return 0;
+
+err_notifier:
+	unregister_reboot_notifier(&timer->reboot_notifier);
+
+err_clk:
+	if (timer->clk)
+		clk_disable_unprepare(timer->clk);
+
 	return ret;
 }
 
