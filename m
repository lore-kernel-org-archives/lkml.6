Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZore8okluuHglJQs4xeJKaRM7KBCePuRxeFK32zcFiOg5v9+SohnXdjKlvbufKPsAnL0M00
ARC-Seal: i=1; a=rsa-sha256; t=1526280955; cv=none;
        d=google.com; s=arc-20160816;
        b=MHlZkgTJYdIUYKRXJ1c3YZAHGWvN6bqpVKOKSDVmDYjIH68WLhZ1VUPVT+lcyJ080S
         z7g4vTLpvVge2GnNUQZlUAMZUvL4p7S5my9VtgqH+duSpoTcJ/tTOVCInm9j1wPAgST9
         PttkF711kg0S5jfe7ch92+VGnRpeTuNIagAbw0AmMyG83gNao44Ur9PWXVEf4vUyCWb7
         AuquBY2oGeJSh2uMt6HIwKq2o8mvvJOSo8jUBzBcvXgYxCANPbxWR7G/lZDm7g9vk8nk
         pb45PW+3gkXovG40jwNTV6/5QdY7dwDl2zt3Jc0FV7hx6Vd3Z3jW0sydWi8jcojLsztL
         waRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=YyYN11VaXC5heB72Rib2MzmW19KbYB19bEZ7NgkJvn8=;
        b=LYHR0NUEb8RbMsypI8ZlYsU90ZCNZnbHgdq/V01KtGTqYo5GsKI3q2fS0rIoJKA4s+
         ItZsv1RefAaC+aQuy99V2sfWt0XZMrL1EAAcHjRorFMMIB71T78S0+ngV7NtfKuur9lZ
         x6GP/WCADymgJrQi5MU6Od33OT8InZnwXrr+zo6OK0LwGSLjtUeQn33+YBueDSKLQCUG
         ZCoINrgsdb+T3OJq3K8zLEibci/D5QkxU3G1JhGfNx/kRQzs6vqBzhVyZogVNNkxBqF8
         ZTO3M7aT9FOk1LQxGA15vgbTnLbdfR4NRsS649gBUj/f+vcbGjMZDYeMuKx7C5R13rjK
         CwcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WtO19zFA;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WtO19zFA;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 25/62] gpio: fix error path in lineevent_create
Date: Mon, 14 May 2018 08:48:41 +0200
Message-Id: <20180514064817.787715004@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421518802204133?=
X-GMAIL-MSGID: =?utf-8?q?1600421578731176721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -813,7 +813,7 @@ static int lineevent_create(struct gpio_
 	desc = &gdev->descs[offset];
 	ret = gpiod_request(desc, le->label);
 	if (ret)
-		goto out_free_desc;
+		goto out_free_label;
 	le->desc = desc;
 	le->eflags = eflags;
 
