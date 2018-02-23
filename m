Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227jTV8rdFo5+p1HZI968VE6EqHQxiDx4iE9uYmFs2DCsIji3ktiEEgOZ15G+TMOUWOq5yry
ARC-Seal: i=1; a=rsa-sha256; t=1519410918; cv=none;
        d=google.com; s=arc-20160816;
        b=BPitHX4nJFFIeS2D1wFR54z5RLXDk9xxUEfkT6KGiAzhT5ZevyRTD+hYRWFywyuA5S
         ai9kIWLIpsHkaOOUIpqSyry6tMRDI2dgiUyM1VX4DdhPIsD4WSEma5Njm8b5ffjk4S/9
         /2O//po7jram3GPYayfUYa8fipgqytBk4L1hkBT7gVUWqSlqwQScVhjLiaP9PD7YTaVi
         nNDo9FoQ4z243U+omW2P7NYKT7xk5i2vbD6dr0+EbKcv9WI0lgD3Jm60iUOAHfXl8Sx2
         3rDfXJfugTBdasFiMB9CjSu5zinaH4Z9i+VROIX8xbvdCOJz8jXZqoB/GBBvwEeKn3/0
         5c3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aHigSq6gE1xl+LHVShOTqsK+GI+oor2HDSnbePRQhAE=;
        b=F4rOcQR6PSDz9MYwAAXP7KJsc9cqFKVfz+CHa4533Hk+18+J1YvtWp9qNKvztKox9l
         ormvYru2nd4yxHLQ7DG3k+dvsG9vGHWhJsatZyWi/C6jt/fDtIDaHPrU+fquXMj0L5vl
         HmtMv+MoBU09QSNFizye0jfQ1i1ju89wg37h/YctjYZE2bHPGGd77bvmoCgrnMsB2Bkw
         AyR7N/4Ym6YqPg3a5lzxuFThsUntVcQeHxVlziwojmYuprZbAYMaIJxJcaKkA9kbnLci
         xodm/+bZ26VimskNx2HdomxW6qTxeuGn2RZk5zDv3uazPdp9gcMVeP74zwylhIg0X7OE
         QyWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tobias Jordan <Tobias.Jordan@elektrobit.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 057/193] dmaengine: jz4740: disable/unprepare clk if probe fails
Date: Fri, 23 Feb 2018 19:24:50 +0100
Message-Id: <20180223170334.928949847@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217621401354157?=
X-GMAIL-MSGID: =?utf-8?q?1593217822667263148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>


[ Upstream commit eb9436966fdc84cebdf222952a99898ab46d9bb0 ]

in error path of jz4740_dma_probe(), call clk_disable_unprepare() to clean
up.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 25ce6c35fea0 MIPS: jz4740: Remove custom DMA API
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/dma-jz4740.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -557,7 +557,7 @@ static int jz4740_dma_probe(struct platf
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
@@ -570,6 +570,8 @@ static int jz4740_dma_probe(struct platf
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
 	return ret;
 }
 
