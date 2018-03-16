Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWA75JVyJCjhZVzCtzvTqIXfx8KJgqFnjJySkiIV9JsPwlJkA4MAvpIXgWZGMZJq6csBLa
ARC-Seal: i=1; a=rsa-sha256; t=1521214891; cv=none;
        d=google.com; s=arc-20160816;
        b=sXn3vgCTf/lkdfEgBBXogTzztPXQsUm1fOx2Hwz0fDHga6iE7YeTo5p3T9VyYBCj/K
         Z6PGcJ3tNhdFPhFtpyRgh5yR+f6WFlEGtRAAJilSc+olwd3WvM+/2nr9NDXPDbZvMCeV
         CnDXY9kMCS6o5c9vtJhNtAV0fB6Neg9qrgzZzbxArPUTr7KRGEjU3xE17lJLvHT74Rf0
         d5XF6zL3A5rrpOR3go/lfhFd5y//zyM/39HCS/PnZogB07pafmgZzoZ/yM+yjrcvdCb/
         pkbvHA3Q2T/t1yR62CtW4H3odGLfRaq7GCAbjjSNOjbRGC+9fJINwAp8UkJnqKnN7PIT
         1fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nN+0Tp2Fn/aK7OWasrac07mO9jPhsJBCgOJhvuEomkQ=;
        b=TScydZeDAD+lEuKfBU/F8qXyn0PZ4L4yzTwv+Lm8ruDQ4KdwDW5P5INRwmI3bxJfRG
         YLGG+y1YSM8GsAG/OqO35MrJ3jDjeHk95e9hxDJsomIaUW9my+Q1pLV92vItfB7oMdAB
         JRPI6Rj0+b1/JIBjf48PDaJb1kUm7MFxx95wa6P/IU2hL70+SIMj1CnohVOMj3m5vNTq
         Evs+V6pGP1ZPCT1VXueVWF95gMwOluEZ1ZJnHya4alMnAZ7hfnbs6VIUrKTov1tSDWvb
         Ci+VZ+mUkShP0ADi6AkXfek/jw4eZzpzKV1EQpayYiPxugnnhn/t9cvo5Iboen/URQQz
         e7rg==
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
Subject: [PATCH 4.15 055/128] rtc: brcmstb-waketimer: fix error handling in brcmstb_waketmr_probe()
Date: Fri, 16 Mar 2018 16:23:16 +0100
Message-Id: <20180316152339.581555300@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109068875020438?=
X-GMAIL-MSGID: =?utf-8?q?1595109426585117633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
