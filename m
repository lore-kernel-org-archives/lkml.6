Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu++2HXiTU5ejhN9RNErwF5r9icV09kJje1S9C0dTiyDGAE/t24rsX/YnFutC2yD7/THTh9
ARC-Seal: i=1; a=rsa-sha256; t=1519981109; cv=none;
        d=google.com; s=arc-20160816;
        b=vytp9BzV+WjAyoY3D4EomHrmXlJPx8j/Tjzmc/GZFiqTANhIULyaSXyuoni5QwGh+F
         ERw0+8hw8LGyDQK/x1ACJipUYmmqeTx6bAfheV/vPD+/f1yStaZNOfnLjJsp4t5A14Wn
         jE2ntuYmHqXD7yFTIJHTLqNTqduCeVBU7cA4ep+aSDXw7PH9o3fIXeU8n6wVZ+B5BUsu
         3w2yyf0x7g8a0q32zmWpLGjz/9BLSikbFk4ieluCyvQKKCen5YJEtmc6h7P1CH9+xeMA
         79qwCceZmWcre2zDu1oMv6yx2o+30/X07EA6BoIZS2BDQ6pHtN9udVxK9jEr9MEgyMk+
         ZQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EL+O2ENSZ3vqzbv0YqHNBg8LvJc0vhwV2e4bss5yP4A=;
        b=BLuOA4GKUk8kaD/jLWQLzzsGSTZCIEEHbksnxJAXnmE2VuN6KvIZLaahka79R1dcKG
         B0I03sGeAnR2EqhTfqizqgFATz56vS8c7MrsfDIQeP1z2np155BzdlISw/NrmjMJ2otW
         QwT2+WoDJ+I8dIlHVLCnUX5WuB2UU1FZznAhHzlFh0p0c9QokqMJT4qO0+V9cg2LqtPQ
         1LmR6pRtxj2stHVMRzmUa7P9iA/9U2Jovjtki27L0VpNC70U1xJtK5fydy3uPWsD0083
         H77Lb4HewNRg9nclxws6xkrNj/OFRJcbfftZdTx1RXd2oo/YGToINWpAqHG3UElun8EY
         e/XA==
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
Subject: [PATCH 4.9 16/56] spi: atmel: fixed spin_lock usage inside atmel_spi_remove
Date: Fri,  2 Mar 2018 09:51:02 +0100
Message-Id: <20180302084450.450063663@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815423105817995?=
X-GMAIL-MSGID: =?utf-8?q?1593815711222487190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
