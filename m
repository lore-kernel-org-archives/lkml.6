Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtI+J9QHBK9FIkFGsGJ1R//qyrrapbabD8oRxAtoZ5kxikAqNXigD+FsR/2P0R3IB92YirZ
ARC-Seal: i=1; a=rsa-sha256; t=1521484058; cv=none;
        d=google.com; s=arc-20160816;
        b=A+z6bLTMUzNnf2EECF39u8/jjn4ShXerzCxOMHm5nplFd3HVcKc+yowiwwWwBYQpQQ
         7vNESc+kEKGrVqOg3UC19xyYdEBIWpJIOtsiYZbzqcJdz2XgBugrEXY2cq+/2KHZV4Kc
         k+HsPKiQncYYQbYX5cm2oBjo+NNdaMKwof3KzHx/VvuLlIQEuLor7ffI1bswIIwOgOlO
         K1jzhJQzNub37doHpRa0ahRRfUKJT0HRQSqv/hHyUTwdzyVf6wAs1fIUxFHHnAya6xVG
         Rr/XLML5CGnExZiHHjrXRzJoOlsoGkfVJ9AvvQ09VgLyxtPBtLdesMBt1Bsi5I/+BcyC
         w9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O1pceMFXBUFYoEAQ+XYR9O+rvqvqj+MO2C1zawtYvZs=;
        b=NHfGj9UqkTePtL8Xzgd7d3y5EUIGOD4tO2KqEj1J/w0tH3DW0geOZMmB5/81m+ayN5
         R6ZqWbzcHPNt/ZLinHeekjWs4+iEGaHfELdp4LzjEG8BhjNZuflQjgnyeMKXoyeiOZpr
         KOMBFGEAwC+diVQMx0yEfa5GESsn+JRCIQ//1mD+Gw5v3EGXUrHfATUiPg25DPrSUkxb
         QmLIoIBzEw76WfkimGwzU28TnBdYt4KnLrsJTm8Mc32nYPR5FrYNs//2qM52/8CLCPD3
         DAY8QomvE13lV8bFRkO0li6dGK3lvwV1Kn0vBOpKvtHgTvvs6Jh6kzBhH6vsnZa6GBeF
         tDog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee.jones@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 181/241] leds: pm8058: Silence pointer to integer size warning
Date: Mon, 19 Mar 2018 19:07:26 +0100
Message-Id: <20180319180758.638613424@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391668171577601?=
X-GMAIL-MSGID: =?utf-8?q?1595391668171577601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>


[ Upstream commit 8f52df50d9366f770a894d14ef724e5e04574e98 ]

The pointer returned by of_device_get_match_data() doesn't have the same
size as u32 on 64-bit architectures, causing a compile warning when
compile-testing the driver on such platform.

Cast the return value of of_device_get_match_data() to unsigned long and
then to u32 to silence this warning.

Fixes: 7f866986e705 ("leds: add PM8058 LEDs driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-pm8058.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/leds-pm8058.c
+++ b/drivers/leds/leds-pm8058.c
@@ -106,7 +106,7 @@ static int pm8058_led_probe(struct platf
 	if (!led)
 		return -ENOMEM;
 
-	led->ledtype = (u32)of_device_get_match_data(&pdev->dev);
+	led->ledtype = (u32)(unsigned long)of_device_get_match_data(&pdev->dev);
 
 	map = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!map) {
