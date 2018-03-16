Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsaLUUxaAC804/C1kW+I0cHvKqVHn3XlM0RTlMp6nzxANRVlDVAHk4qWQ9/P8jPa+WAAa5D
ARC-Seal: i=1; a=rsa-sha256; t=1521214926; cv=none;
        d=google.com; s=arc-20160816;
        b=aeqoC3JVCZwbdNgV9sBDNxUakDmbrAQ/wQLLgEIlNm48oWJbmidgzcUWss3D7xR/tz
         oi2otqhB/xRvHar3nVTHoc/qWfS4sCWq1xLxVrofw9bXnosai6hiwDbE7Wwso4voNsne
         CCMmsP+xKK79aPTLEXQU3X72g9ZUADwK4r0Jeyfc5jxjPk/XlmFwup8QBGxwYRwzlEf4
         dG8OjVujyCkPs1AJTEv8gojsxm8E2vYCroeitax2rfWl+YBUvs67+qHRZmiew5seMzpI
         BFLlnu9XW9TryuM5g12UMl/BKadOsozOGsrC51fEuSg8A2+WBpZlB8kMg1MSktj8ADMX
         NHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J06M+Ugo2PEaFhJXzCgCQP2P20OgQLFQlZVfYtSm7gg=;
        b=JyAJG/c5uK8dFOlAhXvsKq4zEnnhWzKjiec7bsvxQJMoHHE3cngw/qu4zrfTu0MRTL
         Eq5mxguN48Vfmrd/F2o9UpjfSRwwkIvR3edfpt74dIzvBf3Ii1YBe0awHbtUZQcjN3J9
         x7uBJYcHyOuCL9NdJvXa64QwsAX/++mnExjSNux/cwh4koOFQziPxbxfaY7J9wmMGGhg
         rHbxyfm0y4wwcn3cGrnV+ZNPZ1Gf76WJ0vciTCyK7RwZo+ORxLKso1yY8RVPi10KlADL
         /+53dfs4faT/5qWFExqq3+p1Z+xy6Nx2TAlIWZy1GT8U+jOMyFDnh8t1pKJI/c9h9fyG
         2g1Q==
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
Subject: [PATCH 4.15 066/128] leds: pm8058: Silence pointer to integer size warning
Date: Fri, 16 Mar 2018 16:23:27 +0100
Message-Id: <20180316152340.045907166@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109096590928644?=
X-GMAIL-MSGID: =?utf-8?q?1595109462251854259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
