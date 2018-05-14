Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpF0WchSim7oXO73IlnOthqMeObG/NRL14N+BOyRQJBRVftzECGA1S8lg+263mh/lo6DknA
ARC-Seal: i=1; a=rsa-sha256; t=1526280895; cv=none;
        d=google.com; s=arc-20160816;
        b=tWRurwMVHz/7lBERfJMzbIhamfGJ1x/Vli6ITWahkemn39UWabRhPnt3upNUOFxyWs
         eYIyaef3it+7VC4ZYU2eOSh4FcNzH+Uf2RhbPplKRVMTVUG0eGG8RuQhlV+molaqm+0a
         +fXWloXOkt3A+k+hUHtmmvbvgV2x4lmxzlcHgbiqVb4oi+NUN6N1pYnk65XkpcEKjEGy
         JC+LphUCdwo8fVE+sjRaJKmLI4vMuE2T+i9auOhkI92yqGIOtjZBOkADIvdw3rc9wW5V
         2mDFXA8zsJLN1Igq3E8l8cGz5N0B8xDmBrFPjNnDEaiA2tXfVQ98pCJ84DMgRmMlaW6u
         owxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QhBYp13AGo3V2AxK+0ahlloDr7mt+v26ePoT7pkyIJA=;
        b=RQqZgSUIfoljPohjkQWxIj/uTEO36GROXTamPT/nXyHGxzEK+e1U/1x4ArX/+BwMrc
         ZMGPupoaGC5uS9z2zWKjDj0usqqgkRwkwxTtc+W7hqK0sQOg7ifYJEV9jZeJC1OAhueQ
         KWjc0zQJSzIPG84uJbGJohYNDsiVy28LFfQVmw3gOiv+BW/qllK0B99EkSbMaZmqKkNb
         GwEwp330JVYWoQCW+lWLcgCEjLDOlFWuq1AWJDDl+9hQboMCN4NVtNn5h+n9lXtgJdeQ
         gYxfoJvzBPhJP5Qp1P3d4gvL7l108Rip9bkOMjZrhwAWyOznZbP8gdfB27RsdbMM57R7
         8mMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qf51Iz0k;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Qf51Iz0k;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 18/36] gpio: fix aspeed_gpio unmask irq
Date: Mon, 14 May 2018 08:48:52 +0200
Message-Id: <20180514064805.680588266@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421515804350416?=
X-GMAIL-MSGID: =?utf-8?q?1600421515804350416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -256,7 +256,7 @@ static void aspeed_gpio_irq_set_mask(str
 	if (set)
 		reg |= bit;
 	else
-		reg &= bit;
+		reg &= ~bit;
 	iowrite32(reg, addr);
 
 	spin_unlock_irqrestore(&gpio->lock, flags);
