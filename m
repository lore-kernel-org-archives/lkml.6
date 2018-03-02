Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbMFeD28W3kXI09kr47P/pNeLaLmhXutUie+dMmXfbKhZXs0+jIqmP9vmC0DWhe26sJfVw
ARC-Seal: i=1; a=rsa-sha256; t=1519981033; cv=none;
        d=google.com; s=arc-20160816;
        b=ikB9TyBEWshgvOVRaQdKciAmeUEj1JszyKemp2XrEl9jP7mN6mduDL09MQC5E6fWb2
         u0CVe0W9sRKvoKF03FS0hl4tGMnjgMq4plW012X7M8A+SfmtB+eOiJTlbJjpEt28hOAi
         0PjgHyb1k28elXXY4q4T48om0IT8c3nsP/ydToIwJiAJE7z343eqB7cX00gU7LJMrXaa
         Whi+xcM9xcUD43Q1QgBRw8JjaNb9zR6JxSW9OXreIljXGEADZDmJXuhLVtBoNkQ6VtOA
         FSw8gCdQ1NJaZprCcyE5JoqIm/VYBoxFH+5kZwsc9C/QBIxhFBY+O0JDK/nskeEpXzPw
         u+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ca3nDPpFKITKOwb/YdlsXfFMzFcwls7SqKcs3ozZ39E=;
        b=l7mde6VwfKKCYIAJPLtkmt8qnHzWgCfrl0kiL146Q/zSKh+IdwRq9XROUGdimGoL84
         fLnW0Wnduc65SkW/vVr63o8fIS5L+M6ufw2dYu0+qUV97mQJxBAVmqcTynHHZnJJNE2M
         ivsPy50DgoketMRMYrLkMMmrlzBBhz763GXIHtGV2/xAQwARQuJb47Eii/UmJSP/yHfp
         3CWEgPNb7OcaWy0amoT/6b152JlrFaabqHzxOLr/M2Do0ze3gvsPYVoBOAwRQwNtZGLr
         g8qpo6gg/HMrn2SytBUbu0C3PEfrlnFDh6wCr8g+nDaTb0dkYNf7Y5aCYRXZMxWvVwpR
         QBHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 4.9 30/56] led: core: Fix brightness setting when setting delay_off=0
Date: Fri,  2 Mar 2018 09:51:16 +0100
Message-Id: <20180302084451.103940993@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815285215753423?=
X-GMAIL-MSGID: =?utf-8?q?1593815632481568768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu CASTET <matthieu.castet@parrot.com>


[ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	led_stop_software_blink(led_cdev);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
