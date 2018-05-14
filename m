Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxSKYXse2O+7KDtv8pRGbFNZxMstVvL6FwkyzdkluhCWB4Gmb3T47TEHYOhrNw7jq6P1aP
ARC-Seal: i=1; a=rsa-sha256; t=1526280897; cv=none;
        d=google.com; s=arc-20160816;
        b=DPErODyYxJycjyZ/6OWifuqmidfr6hM8OqY7md2stWTYeoNWcCuZnguW2d9zjg5ddv
         Hd/NwDp3PnS34raLE6i4hGvWTKf8rqLyQz96dt8tGe2+E9VIRi+Q/LmgUREOi4IO16Af
         t7jEV9vy+5KOSZJjrHx0zpz0KWzhe/9p5vWkMCuG6ol5929R46V3t8LSd0RCT4LNLRwp
         PWLUGsHdOBfn+GlHvAWUN1KGC0lQf4g7BimMF+Vl+jdRzU97OZ1Mh7HYlynMS2jHxCu7
         81SI+SaG6S6TVBaEDxBStaPm9SORPs1eJYrYSMvnvo+mbOlZFopFkBMZIM0WclhLcmDD
         G1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=JKYwmmsCWT8wl24N04HGFQUHdhw8DPo6c1SZKiaBXZg=;
        b=DTwXvu8FoVmLfPQBQ+dYeyf5BHVC1ixnx/0b1M7JqxfPEiXiIO3jwXNDOlvzW0lDF8
         /fdAlRnP4qzBuOXZf/Gb+plx89VuDltxAVFRFAyMr2VqXa1cMFMLvQfB7Cojgui8zr6p
         GJQuwqW2H3+md4ywzcpj7jjuEblnCBrBaUGzqrr6U2FY50soV9+f/5cezlvij985Qq/W
         kM+dXNAODevw+7apaLztvGxTDm+7+QupKqwb9Iuq7xBx4JXLe5HF+rPP1IWvxGN6mwsQ
         l58QBayMa1Qtz2HrcJC3KuE+poS4pJ/DjosE+IVYlm3tyYQF1U6IFuiXtOeWBflzndLA
         SDPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gE+qP8vc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gE+qP8vc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 19/36] gpio: fix error path in lineevent_create
Date: Mon, 14 May 2018 08:48:53 +0200
Message-Id: <20180514064805.746008850@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421518802204133?=
X-GMAIL-MSGID: =?utf-8?q?1600421518802204133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit f001cc351ad3309ec8736c374e90e5a4bc472d41 upstream.

If gpiod_request() fails the cleanup must not call gpiod_free().

Cc: stable@vger.kernel.org
Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -795,7 +795,7 @@ static int lineevent_create(struct gpio_
 	desc = &gdev->descs[offset];
 	ret = gpiod_request(desc, le->label);
 	if (ret)
-		goto out_free_desc;
+		goto out_free_label;
 	le->desc = desc;
 	le->eflags = eflags;
 
