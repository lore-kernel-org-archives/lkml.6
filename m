Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtH8+gUEeezsRwMPxyQ5fLjHB/dy+KmCL2yiqdV2Jc/jE2l6QC8f1wLk0bKypdl/tekm9o5
ARC-Seal: i=1; a=rsa-sha256; t=1521214577; cv=none;
        d=google.com; s=arc-20160816;
        b=PRhHGEEw8eLz5SLsLE4sl34OaF4Rh/oNOIgRyrAVuZV5GYP6xKx4dbcVhfR0mr8BYw
         3rK1yeBUJUQaH9e56zaEy4Q892gjRIRFAD5HPS8Q5ngW91tLDxZeRdd+WFxVY7qMQrnF
         fN0pq5+oza2DdTUjuxJLIXwiHSzcC5pc5DVPF7T7hPWafcYoK00za/Ly5VImtd2zi9og
         r0keZS4xXCQQwaG31o0Flszfso9IWAu2o/OpjF6hA6kbAniGBp+FbYbdytzl2OBy8qnu
         dFms9LaO/+se1XDZ/wvYAS7rRl5N8CdpOJ8Fl3frVY8hSr+0nvuVwdMMmZQ91KcWujZf
         kbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8j0vHtvuUoL3s7VM8OgKgm+ln/vqLyVNy9mX/oDIVmk=;
        b=WTlD8eEZtH49wr7wIQ9ZDcKVvEZbYYaHSUhSUI69nPZvb05IUefcmbDCL7NfcqQecI
         pSjCoQk1v5KCsbTAfcuj6pwSyJEUx1Fps6cVjnC8c3EtFv+BOcXIgrDDfI3DJe/PBGiR
         FfHFoCceXCVgZgzkxgcZQ06CDC7+fhjdNqQWp3LP0RLY9tWTMjxyNsfmW6sg3PWaM5c6
         6spm/v54F++0agtb7X+MuVHlGt59Vkc/0tzPFdC90nGkH75GYGKW3oqrtsSGv3dsL25f
         7LyrT08VQehYnA5uLh67Q3I8QWLk21vZOyuNAhs0wsmpLotxT1q7AXWtS0UjHT5LkDou
         et7Q==
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
Subject: [PATCH 4.14 055/109] leds: pm8058: Silence pointer to integer size warning
Date: Fri, 16 Mar 2018 16:23:24 +0100
Message-Id: <20180316152332.946712593@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109096590928644?=
X-GMAIL-MSGID: =?utf-8?q?1595109096590928644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
