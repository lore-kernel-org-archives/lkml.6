Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oFy1lTOFnNUOuvwyPeHIpEIl32EF0zLDLScAZ2HG8yiRwmZpOCHpVomvirV55vFYF3BX1
ARC-Seal: i=1; a=rsa-sha256; t=1523399861; cv=none;
        d=google.com; s=arc-20160816;
        b=u+PjHCKfU6mDk05/Ux2o/XGtOgVCVKtI1IeaKp4zVfHNgxrD1WORi5LI/6EzF6c3TF
         +dMx/a8/TBTviTjNEV6Pl72A+79/1FboKcjFH5l08PwiRrnwXvBMF4+vRrmUCU/NeN0p
         CIqMem1SC7uOaY1i3oh6pEJM11GXgCgBA5pmdDuKpa/TWLGhTCdF7z5tmToUUSEJob/l
         tZ4vJeeE3V2PJ46bAN3d+9lTENtV1Wo0dkAgSFLVXVgaX/bCXqZXfyjUO3JczePbc1+K
         GARZYttS0lIWfieU/92a4VQc67fOgszox6IDgh/T8lrVZB9ZeypkPmGedAzhePrnOdoU
         /pHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N0tQuKo91dcgWfYaxIhv19xqX+rhvYfnHwIS2QngHV8=;
        b=njEjzNJ2/Da1VsOAMsCSj+4EFa3/yrlzZeTfndw0Cym+3pfkShrBI4qIYX0QHlm5sJ
         yDQ4U1dxjgBnVbMPG16CgWhUqSqqfb2jaiDPwITCZi/AvK4MM5iKFr1NY8R0gZEJQzqi
         Hp57TOFl28ggOEmjTtfDPi+dqRC2zpsvF7co9t3U3eLwfDg+GLNpUB+yxYMfcYFbWc95
         YsoYfjnGfEk4oJEs0T5q4lQAV9zUUQHLONjwCd4X/VD2+iHCetA9FBJZSJTg/rP3teTL
         KC+EdMesndBNAmDP29jrLNgothJ8xHSkBySNh+aPfWbqTpnzQ6veKnGaodP3hisMHjJz
         OyWQ==
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
Subject: [PATCH 4.14 073/138] gpio: thunderx: fix error return code in thunderx_gpio_probe()
Date: Wed, 11 Apr 2018 00:24:23 +0200
Message-Id: <20180410212910.603064670@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400111413958853?=
X-GMAIL-MSGID: =?utf-8?q?1597400532521504554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -566,8 +566,10 @@ static int thunderx_gpio_probe(struct pc
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
