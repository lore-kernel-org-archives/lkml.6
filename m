Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoAEGIyZznyCCA6H/zyNGfrPxCFMXhokMQFoQpZXzRZLoJAkRiCmumLVyua63kp1m+/0MD6
ARC-Seal: i=1; a=rsa-sha256; t=1526281122; cv=none;
        d=google.com; s=arc-20160816;
        b=RPONqWRKsO+1pw86kze9mFQ+Z+PrPuKN8HFAN0zImbIGY/uzDWttD+9zjIv7MJSbb/
         SCN2mY7Rx2SFuIoLCFXwT5ZwU8P4vkNt0m16aduRijmqp7Z/6fu3LP+o/RlYTOKSnWhL
         8i0Tkgx9ZsJXHwtuMw51MqHoZPHpR0d8k1DBn9x4tkIxXpkaTWTwea8enyozWU2cih9p
         QBjzlgw3IFVXjgGVGa/SzA0Hr+vUmFrd4KDX/3Ja3SrfDlUtfgKDiU8mc45NWjquDEwx
         4U117zU5oMJlcctvSEUJmBlxJhoAwXwscbe1ZRQ5AoC5cqqnSNmKGCSU76UTG1caL9sT
         WhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FWc+EZ7Xi5otCUxVcJY+AtymwYsF6ZqUggI+GxquMy8=;
        b=qvsH0K4b+Lvd24uArK/Fu9ricFYi3dYlkLRSzg3zfTKN+c+iPLnvdBGZ74GnlVx3gl
         VMUI/5yX+3K3QJ+deZH2Esaq/RJptJjllNhNrXkauhRGxi7aivB6UvDONuDdt1baM51V
         89ZGU3XPPd2ZtCV8M1k0JXA3G9mqbHPO6cjSMN2B0XuH56mMshg15gjJO+uiUSJCxI7W
         T4rcDS/hgQmOMQ+2jebMnU+eWLU9FNWRzd5bq7LrpE4wcPBs5KLPvx6OgZnk8lyNbMjq
         3fzjDcYUJA1MaO8xb3aDzOdQUE/qzGb9uauAL0flH81lzNdE0ev4pKpqXUrECcUzPta+
         VklA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JYTQlKyi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JYTQlKyi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.16 25/72] gpio: fix aspeed_gpio unmask irq
Date: Mon, 14 May 2018 08:48:42 +0200
Message-Id: <20180514064824.100845158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421515804350416?=
X-GMAIL-MSGID: =?utf-8?q?1600421754592060713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -384,7 +384,7 @@ static void aspeed_gpio_irq_set_mask(str
 	if (set)
 		reg |= bit;
 	else
-		reg &= bit;
+		reg &= ~bit;
 	iowrite32(reg, addr);
 
 	spin_unlock_irqrestore(&gpio->lock, flags);
