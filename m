Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpRD0msLxHfCP1dmw5rkmHUEXUZxYpxSgWP9cfsYWk3BWs4pTRQJdtn7/b4bj/cl+TVsRyr
ARC-Seal: i=1; a=rsa-sha256; t=1526281125; cv=none;
        d=google.com; s=arc-20160816;
        b=ZrESkRr5fTpqooR6iZcGY8k48ANEOCBBtLGiHbB19LwfrXJ/2z/BHcZzKevKi3HdDn
         jRMOacs7ip/+K9ygZVahRByeI1Wd7bMSOGdRYbAAlWy6rVmhPyIU7DHoiLkazLE3tS9E
         51AJmvSKV/6XmnQGgzNfno4XTJ+yiFTdmY566nVN//H+Jyy0bx/s2VupE6jYJQsObC1r
         pxSboLI2Zp5Jaz6ijDmuiq3gCtBj2iF8KM/vEKGiBuNIRtvn6KoW6qoRHIMzNZ77Vxcn
         dkLHq/lgpufPjLECpCkgP7g7pHv0flzVcl1L2/CHu/U5etdX0ctkE6pgtBDJNtmKGncZ
         aFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cE8ZfJoKA+gJUW7TxKjnd9pRewO9bs/Q7km28egNrcs=;
        b=YH1rj/pUP1u+NnJq9y8my5bplbO6vn5sn3fud2Fv/iDOUXrgsDLOV2Bn8iymUn58DJ
         oXPrTeDXKZUECHUw5kMlgkj/OuEsBhp4/ceOV5oAp/TIihIuUvUpCfmU8GL0b6ZfTAGx
         N5XV8khlISB6zEbNPGqJXhRrUoYto3nYDQq9kKWaOGISRNWBgK4EqOYXL/ZGnaPDE1FS
         9LstTxCRkvyUUZb5kJzCt7Z1Cr6iXJRGZkVWzvo0i0PmudeZz5lAkjRT43bVQL6qJgOH
         vF3bUCfMh8bASkoDLKfl2DUK6bFR+0AMXpgUnCUD7viH11lX5mUPkDQQ5mluBFbd9Le0
         Kfww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J77eUERz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=J77eUERz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.16 26/72] gpio: fix error path in lineevent_create
Date: Mon, 14 May 2018 08:48:43 +0200
Message-Id: <20180514064824.144129112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421518802204133?=
X-GMAIL-MSGID: =?utf-8?q?1600421757235406553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -852,7 +852,7 @@ static int lineevent_create(struct gpio_
 	desc = &gdev->descs[offset];
 	ret = gpiod_request(desc, le->label);
 	if (ret)
-		goto out_free_desc;
+		goto out_free_label;
 	le->desc = desc;
 	le->eflags = eflags;
 
