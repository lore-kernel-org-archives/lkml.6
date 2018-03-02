Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuR3M2wlHUQHYHzdzuNkkVm7bjCZnuZf7d2CDHV3cZRqsAHLhb2qLu0kIkLV4P0ChmO4Ibo
ARC-Seal: i=1; a=rsa-sha256; t=1519980934; cv=none;
        d=google.com; s=arc-20160816;
        b=gNu6jyq/+v7kxnRRDYU2PCfkpOkHEcWr8Ya3PLx/3Nh5zqeKI35VXFoPo34P7Uq9Ci
         i7R7aPXzv5HX7QNx9/2m+sCbwDVIJoEonP69wg648UA/JkrEqm1I/TO+HxA/SjByvbuu
         D+KT8RcuOjZrH0/IPbaEGOzbmpb+Aaihv1eUuROcrJw8EgsRGNos0dJALN8ZmouF6e2n
         AW+5A9IENO2rMJXG6k2E19aqqtmJ3RJOEyyixBRl+rBVwCbecbc7m2E1IYsS5ATl+US4
         YyqGjg7L2I15M5mG5AundyR0Haai89FPGkUL17K+3ML3BMkw7Y4IUw79eScL0wHOeH4b
         VbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mI45qsHPvekLbOcampYwefzmGtxV2kZwC0svZ3zB8UY=;
        b=nB55frkIXa7IL1xpxBGv0uRu0BNSQ1bprsfhR2TURO667PiMi6hrDVlUCvjYChC6il
         a57C/IBx8i9wEuEbLwWKlFYdTfpKCpdbLfwcTBF8xgaQDkqILYsZ5dYLFaGQc0xIuyfo
         yDwkB74Li2Fvr7HP4ZuHtgrpZIU9xwXjL90/dXXQTAK8kD9H06/bCoD8+U4iAXfXVZzi
         6/kf8XZpuQfoeqm3xFFqiPXMT7yaHmHBXUd2XfT15iVdCgZ+IuqJSKiCcQgrzMbAjVUF
         tZTPUr12NqJycZekR9erhFDOkflUt30zvakwaWpP/3o0VNtteLc5UYaou67FrzLuC4Co
         lOog==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 08/34] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
Date: Fri,  2 Mar 2018 09:51:04 +0100
Message-Id: <20180302084436.531804809@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815423105817995?=
X-GMAIL-MSGID: =?utf-8?q?1593815528394945274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-atmel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1669,12 +1669,12 @@ static int atmel_spi_remove(struct platf
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* reset the hardware and block queue progress */
-	spin_lock_irq(&as->lock);
 	if (as->use_dma) {
 		atmel_spi_stop_dma(as);
 		atmel_spi_release_dma(as);
 	}
 
+	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	spi_readl(as, SR);
