Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+sCdgrRqnvywF5scIIhgf1YzO/F5Y52aAVo0A03qoaQfFBAFhsL64lRiPrBLrjD27gtMls
ARC-Seal: i=1; a=rsa-sha256; t=1523399459; cv=none;
        d=google.com; s=arc-20160816;
        b=McKXaUPizfeUbE65VkxCRHSTfdGc7eYTb5l2Z7upfJLO+KTMShS7hXCtzzFUZ9cCqB
         OtVTfJxN8zOuYLQ+730yJFvkg9Jn9qzHC+i+uZNnMQm09WCwNCWn3tMOZSuDv8qMBvpu
         if8hSce1RutRTZpW/FvVm+INgOFMDMC9ozQXu1BH86xvY0cR09ArZIcuvax0sqH4PMtw
         xuJ7DOM5aLS4wHr36eQL/MnDtWiDh05kDbQP3RlwXP4tDJrXHYFyHW0d7WbiHoef8tRw
         su24sqrFDUOeZYzXyNEyeMe38WKbeZmZ6Fu/tGXRLkXzLp5DSvJqlMnuCQdeIBQGsi+d
         IWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NB+c7DK11uGq7Gj0M+nEzPhIiiBoYfXXwgkch9cdDJA=;
        b=swHJ8g7g9WYKxLhlkO6vgnCjeqRun7w1OM6CwvuS25/53Fxtruoisj6XlX8hnzAuPX
         mC/lPDd8U2uwmPM8e2kvemLMWxWq/uDkKm/5G4cjLo0S+b2mh1JxaNw4rT2JYgnttK4x
         7ouUBhYJRtJRGXFdjp/ISLB3f7IAtenvlir7ZXBNpHRJ8OkOPohFzR8ziiVgy6HrJiLU
         +fnoVpe5zaxIzvMWwzAku5fWWmW6ppJK4DXfPAQxsYOAeUjFpDk/PNa8euz2/eSQyV8F
         2JQ7n1qk/31fwa4XP6v2GOvUmm1eKNwIVuhgTzPZpC6RigoCTcGMbFaelWkOOwawY30G
         oGEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	David Daney <david.daney@cavium.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 097/168] gpio: thunderx: fix error return code in thunderx_gpio_probe()
Date: Wed, 11 Apr 2018 00:23:59 +0200
Message-Id: <20180410212804.379928685@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400111413958853?=
X-GMAIL-MSGID: =?utf-8?q?1597400111413958853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>


[ Upstream commit 76e28f5ffed82b1e81a86c4eb8d0420515765620 ]

Fix to return error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 5a2a30024d8c ("gpio: Add gpio driver support for ThunderX and OCTEON-TX")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-thunderx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -553,8 +553,10 @@ static int thunderx_gpio_probe(struct pc
 	txgpio->irqd = irq_domain_create_hierarchy(irq_get_irq_data(txgpio->msix_entries[0].vector)->domain,
 						   0, 0, of_node_to_fwnode(dev->of_node),
 						   &thunderx_gpio_irqd_ops, txgpio);
-	if (!txgpio->irqd)
+	if (!txgpio->irqd) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	/* Push on irq_data and the domain for each line. */
 	for (i = 0; i < ngpio; i++) {
