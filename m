Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YyRjv+UhGozbYkgCjxeSqwx7ogpMADkqRzy5Ar21eT1VjA2qCHdBZUC8M+f5YkWf0KkeC
ARC-Seal: i=1; a=rsa-sha256; t=1523399274; cv=none;
        d=google.com; s=arc-20160816;
        b=Rmb4xh1jWQQi2wJz+s9u8sUdr9Wmr+wT9+qoeqic9N9DHckOiwVsoqsAVCAVS6VKSl
         WoZIO4nX79hJ938uS6N8RAc/xEgtUQxpVBIiCY6x4VpFskk/hH01EXCrN6SG19oP8sjr
         20yg0JH1MOEB1IGsgYRa9UClVo6TRht1gLhpY0WtLFtUwMGqmKnUNYTR0FpuNt+ACLOl
         6Lhm0Ixol4U5xWyRZ07fpG0OjaUAlzjYpt1FuLpabXxrJ4+cKb3jOJOvVnsVxOuyX2Bt
         ZvRIgAKSIm8unuyiJaCb3Ei/5ggPBupKzmJlyW7QjutaWl0Slz77ts0QU5McbCkqv9Dq
         Xh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QO21qBVR0J4Iire2m02EcKffWAQ8FhVsxszoXfXf3ew=;
        b=LJ0YtBJ0gySw6MVhOjqGtAP0VZvdHoFWfQJiRx9hI7DeDPHgjMuFW6vBROzdZ9gRng
         8JjDQ81T0glhO8w9YD8+WxUh1Ux5pjDacL91/Hx1u8rLfnMoc+RNBvDifnTQD4hvYKzI
         WhJqxPT2F+lShjvwb1g6Zn8jeAgMxl46pe6KSMSttJT3NveGAziulsn6Ko3wZouALTsS
         04KYg/5QAFuNaK6yq+cVK2Y4pkUO+tyNRN8iKw7rpxl779sS4NQPVFOl9Ht4QWcqOsHY
         Dr5QW5koxCOBEuCLRkjYWxs7JSTvGvu9tLzKDYRpMOLIDsrD/P5zXmEPrROfQVoa1Gwj
         mR+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Reported-by: Jason Kridner" <jkridner@beagleboard.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 048/168] gpio: label descriptors using the device name
Date: Wed, 11 Apr 2018 00:23:10 +0200
Message-Id: <20180410212802.246691765@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399917328489384?=
X-GMAIL-MSGID: =?utf-8?q?1597399917328489384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>


[ Upstream commit 24e78079bf2250874e33da2e7cfbb6db72d3caf4 ]

Some GPIO lines appear named "?" in the lsgpio dump due to their
requesting drivers not passing a reasonable label.

Most typically this happens if a device tree node just defines
gpios = <...> and not foo-gpios = <...>, the former gets named
"foo" and the latter gets named "?".

However the struct device passed in is always valid so let's
just label the GPIO with dev_name() on the device if no proper
label was passed.

Cc: Reported-by: Jason Kridner <jkridner@beagleboard.org>
Reported-by: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3647,7 +3647,8 @@ struct gpio_desc *__must_check gpiod_get
 		return desc;
 	}
 
-	status = gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as label */
+	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
 
