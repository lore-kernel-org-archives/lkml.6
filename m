Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqssYT99yorXwZfPDAUZabjCEnN69RgSBkVTPPQX5ywSn0MImCkzGVyoILCYUXHfmZDQ7OG
ARC-Seal: i=1; a=rsa-sha256; t=1526280952; cv=none;
        d=google.com; s=arc-20160816;
        b=BGDmpL8lcamoQdRLWh9Jg9uU33C+czJPTVaTCZcPx0lHA9P4JCPjH7znx/2MsOUmWk
         ht2Exn7/pJmZZjCKGhlbRkCONz+xuwdxJUc3yU2YRuKsr4dCoRyIflKUjH3zEuEZWXaI
         HG6DV5zDSy7Pl3/FJ8Ldom6qQtg6RBxw5cWVoE5DlnnbHHpHUSofDlIBvcBYXdDyubbm
         lDx9sjPVGh222unK0eOvXPrqRacX/eUPmI02GkpYctWMDYdCsyS5v8xVZcJLF4gNCp7r
         P/GTQXltosOgM7v1J9hOIE75NAA10XG6wSJg9JL5HJeOA29b4V+W6yBC0Pt/Ft/xRUnl
         TNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=v7HY/k3LCJ5e2cmBh1LNO1WqSd+eRuyn0ualTAYJrmk=;
        b=mrkZThWVw4nQTf6330WetNWscGkZJAW9LvDgHJqXtSe6Ad5f46a+fuBO1Urp82fd4X
         lAdgWxv4Izs8EaFO3i5h/YVmEWP3YHLor14fGahxLklweNXGrMLkGIJJpjyhNWkO0QbM
         0hIRO83PozAiS7XIFjb8EBFxLr7bQjMZ0rrDRve28HjJPnDE2UN3BfQmYnh5uIpuzKH9
         lO9et4LOoU3pHpC8KDYLl3G7+YAP2q4/Suud9R00qup4/j+oloWXXByMbJqAVIi0jQma
         RXjBHnAAAnJ06RnhEqbIG/4qS7/p82SNtH2qjLHScsGB78/LF+QqGdVDup4NZNH4gEkC
         WErg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=k6IENpQo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=k6IENpQo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 24/62] gpio: fix aspeed_gpio unmask irq
Date: Mon, 14 May 2018 08:48:40 +0200
Message-Id: <20180514064817.727921591@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421515804350416?=
X-GMAIL-MSGID: =?utf-8?q?1600421576131972891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>

commit f241632fd087d3d9fbd5450f4d8c8604badd8348 upstream.

The unmask function disables all interrupts in a bank when unmasking an
interrupt. Only disable the given interrupt.

Cc: stable@vger.kernel.org
Signed-off-by: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-aspeed.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -375,7 +375,7 @@ static void aspeed_gpio_irq_set_mask(str
 	if (set)
 		reg |= bit;
 	else
-		reg &= bit;
+		reg &= ~bit;
 	iowrite32(reg, addr);
 
 	spin_unlock_irqrestore(&gpio->lock, flags);
