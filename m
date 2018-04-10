Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48DaQadDVc9BXfjSSaUqbFmHlvA5HWsQWnsniSOyI5QDIkMQXl2Xn9ibRJetCyBucZf7ykS
ARC-Seal: i=1; a=rsa-sha256; t=1523399710; cv=none;
        d=google.com; s=arc-20160816;
        b=U8sRREJ7Uxq4BFr+KQVYD9ndh/qck3Em3VELaudRimxov50ShzxaBrT1NCxIgFTdi2
         PdhD2TOOUWPv8gbx5FlLvT+XIvUMslRTLSRc7IpK9+OVbJ9tfaRm1Sz/GwUuDg8bvJQi
         wi9A++Q/le+poD/zXr6ow3g9xs5xIw83+WRhwR93mA0h9Eb4HHTG3KtmZFNUOQaxx2PP
         CQb/rJQgV9d8YK09DE/N88rd3mBZNd22PrmiIRN++PNgJqyBHij1CtOQnAGF5QxHb62s
         NnS2nf1wZZKlBL+NXzJ5gAIIlMhXKEI4nAO+Zo0R22oxHxIZiT04q6nMkhTsaU5yAeOi
         ABMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w70aNLO0eX6w2qOuk9jaeU3pADNEdWjFZZi/pk1289A=;
        b=e02Z1piJeuHPzehQ+OahL3iPGVO9MBuxF/Hh7QZXOd9JXEtKZO+YJSGtP31sBTsJFK
         w4R5OLhjaQ+9XJPwUnblQbSogNuABfg8lDoOIRvdNR3ys/awCtwMDdw1sFULoIRHq3Y2
         O5gL++DrnWUXRY8mOMoRvLJ4iHIaSQZOFi9TpJ7OmSOfvwcV4erySr5E/Ne51rT5VKtZ
         Gy7JQK+iQwcHrTsyhFips72E8Ewdg+Za342tK/LJoJmgkFKHBs8FZPTf+U6vHVANP7lo
         6oVSYQ0o5rpHUNa3K1MoP/nu9eQTUFMMXKdq5n2/K87dZn0l7jhjraYvKPAQdV3o5m2C
         AyXA==
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
Subject: [PATCH 4.14 036/138] gpio: label descriptors using the device name
Date: Wed, 11 Apr 2018 00:23:46 +0200
Message-Id: <20180410212906.311484348@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399917328489384?=
X-GMAIL-MSGID: =?utf-8?q?1597400374820311817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3340,7 +3340,8 @@ struct gpio_desc *__must_check gpiod_get
 		return desc;
 	}
 
-	status = gpiod_request(desc, con_id);
+	/* If a connection label was passed use that, else use the device name as label */
+	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
 
