Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48LczivS3E3DHw+tBtrHdzARg4JjzMGyx1um50PZ919wQT0E1F18mi6wD6xxngmWZX89XFT
ARC-Seal: i=1; a=rsa-sha256; t=1523473155; cv=none;
        d=google.com; s=arc-20160816;
        b=BrVc4BOnr863DCgkBs6u9Is/WyiIK9CFwMVWITXQlULBHuH+o8QVxVI7fxssLVwgjT
         TRLt1wrdhIgR5YoabAwom7iAa9hxmLFlcrarl1s7ILsTqUkVzcGG3lhjr678JX9copP5
         uBXJKbcd55RJ3sQ1ZyUs3+HC3olbqfRsCju+e11yDli7/smYnUzCPtnhhNbUUashsDr2
         sY0uvPnhgIFWAotyhl/LY8d3OxYsCosbxlay63McF+gD+ZeoeMwRAZdi2YUSke/KuuQ4
         1A9ncZXWUs8eNFVZ7oxPxDDDo8dehvxgVfWBC2lETqtCrOBOpzlHcO/TvkKjStsjWLXB
         d6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MpoUnfB9lgdorNjtuWU5877LrI6nmRf5h3uftAbrwTk=;
        b=xIGNvle+4hLgHQ4PCVYxjtfuPm38YXc6fBxdfZ9S+hafDSHxo1S/BOBtlXArYTNV1x
         HHzZzKxqLLyGg1xLktcAG3t3ntmAsQtnghtR5p3poXjxdYA9iVm6+0KeHD5TRnUM6VIp
         nkNmyG8vFMHJKgMLHqfpZXMmYvsE/6B1wEFksmJfhFUyALJPO2h/OpUsm2w0/MQt3HLY
         bWv/MLkW644rusUCpTZhVFvNiMTj7CnfEzi8n9y45rgYfGBCW58Jh1nnTH8ZYkUbCx4W
         J0om0unfINtc9auasrM1iuB2SZkxKUyWClOkTqyzkcGRTFw9zoaIQyOB9V8+5rt1X8/Q
         Qwfg==
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
Subject: [PATCH 4.9 140/310] gpio: label descriptors using the device name
Date: Wed, 11 Apr 2018 20:34:39 +0200
Message-Id: <20180411183628.475928545@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476652233473235?=
X-GMAIL-MSGID: =?utf-8?q?1597477387247489751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3231,7 +3231,8 @@ struct gpio_desc *__must_check gpiod_get
 		return desc;
 	}
 
-	status = gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as label */
+	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
 
