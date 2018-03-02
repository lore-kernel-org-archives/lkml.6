Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsRge+oFHv/hyVO5WiydjEHss5p1oi6N+b5QP7u9FThUkCboq3DFhvaHtUJJvFRI0+wROEL
ARC-Seal: i=1; a=rsa-sha256; t=1519981335; cv=none;
        d=google.com; s=arc-20160816;
        b=q7KP2l0l6RLoXRlbjmxKWD4/zhot4+z3PErySkB+dsCD7QaczI321+eV8V/muI8bEg
         x9liv7FyN3U15C3wzA3TYf6F+hsQKmnQFazX8CLxnMPBc4qHkPsJoyVaYvxM9CKuU1oW
         tg3grsAP3eFdOB294PrRSohRgXaJsAUSSFOBPKsBBXSISnmf0osRoXV5VAi9BdiX7Szk
         5PHNe2UKScrTjcwn6/rzGaSYOFqCmETs//LiJGuXQ0AQjp3FrJ3StunwQCDxAHolS4bk
         v2hlIdgVuRaHlgPZxlDLoaxpxQCtQDqOiNftTm6Nd5P3uiG5uenRj18Jz3lEu5XH5Kcb
         9S8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CPa4Ip5mhrIQEDlqPhFhEUbL49kWT1ot8jFW/tx8CnQ=;
        b=fXC0ntthjjJ6NnMCaKmiZiWAmt0tXyZlithnkfopkmhI4OeHkzP6q7V5i6u1Agwz3g
         zAgTNr//9WGpTCIcSIDssJCBEqxaIls6T1UTfDAorbbIkP/godPe/MXRT5J0myYDSgcK
         D5Pc3NeAt/EY/iMRYurE7m7MsiyVZ/K2budUIWXPJQ0Po6r+GKt3b+WTVOVDnItMJXwu
         pbRU9zKIe8Zw+PP+A6etYD5fK+pOP9Af0bPN0jR0B+1gx9npqgBy9Udw0EbR/ZngmXZd
         dhTpwxIXpHohtz668vHjq/y091839GyEP/LWWabU4dbrU5wZm8qEGqNVL9gzQvV6pOEi
         kpJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Radu Pirea <radu.pirea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 025/115] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
Date: Fri,  2 Mar 2018 09:50:28 +0100
Message-Id: <20180302084504.889444448@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815423105817995?=
X-GMAIL-MSGID: =?utf-8?q?1593815948467198448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Pirea <radu.pirea@microchip.com>


[ Upstream commit 66e900a3d225575c8b48b59ae1fe74bb6e5a65cc ]

The only part of atmel_spi_remove which needs to be atomic is hardware
reset.

atmel_spi_stop_dma calls dma_terminate_all and this needs interrupts
enabled.
atmel_spi_release_dma calls dma_release_channel and dma_release_channel
locks a mutex inside of spin_lock.

So the call of these functions can't be inside a spin_lock.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-atmel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1661,12 +1661,12 @@ static int atmel_spi_remove(struct platf
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* reset the hardware and block queue progress */
-	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
 		atmel_spi_stop_dma(master);
 		atmel_spi_release_dma(master);
 	}
 
+	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
