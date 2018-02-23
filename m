Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225lXnNEmrO5UX1/mPPx3z/hNa7Kkf1zLCxuLjxCZdwAvylMfLOuQyaVVxC8sr+YM+p3l96p
ARC-Seal: i=1; a=rsa-sha256; t=1519412158; cv=none;
        d=google.com; s=arc-20160816;
        b=hYOH8wNotGhSQkVqPkR56qeT9g2t/EEArMN4d1o6y/YnOm5lH0uwLjzlklmT72QaBT
         NSYDNTFP8M3fXePun0U0llQsMQYWx6twqG4Yk3kFlyW95TalMr7W4QlaKH5mPT5YeeTJ
         2DOKU9Morqu0yfuZSVaZ59XIFWdo1TpPiaOrD3bPYmVO+MB2nDZ3kQiOCb96apXTs30y
         7RZi7sJGlEWWIb7rpLzxOZA/Wv4xpk/8UnZwyM58dBXkXTS3XZEpEiUln3BGBtFuXiQ+
         LPQvJuudk3lzxeA7U7T3+jeJViRAouFiZM+hZ4BT4jnd9yl3Z4Trg5499uK2ADU+Gsc1
         VLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJm8ZBKPjf/w78ihBGFpijG6GVGFA69zdIz75qpsV8o=;
        b=Y7Od5nUaOWR/g7Q/2qYZj8IDAgy3E/JfutGGiZgqTszse9RZxUiNRNDcc4Nlx4CjZn
         zJPYYxlSO4Th0nyWdOoRVfcTCEzRlivCNCR77bL4X6zmf0rAH43yGDlCLmXJ8cXp/ASW
         JNJh2Op8Vt59aKXA9F4yy06rahi0aulRnTGj/7mknb6Hn7ZwYAlDNDRcx3DAf06Ag+3Y
         EMv/ml5TKYSeaSM3yqy5fnffq0abV0IhDLZ/IsyR4u9ow57QuBmir4vlcxxbPmwo07MI
         K3linJ7iTeOiytKluwtmBujpWo6yu82Jz1024D+4i6hBb8XcakheKcu2ZK07UAAO/MGD
         aljQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 144/159] dmaengine: jz4740: disable/unprepare clk if probe fails
Date: Fri, 23 Feb 2018 19:27:32 +0100
Message-Id: <20180223170800.414098339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217621401354157?=
X-GMAIL-MSGID: =?utf-8?q?1593219123493236509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>


[ Upstream commit eb9436966fdc84cebdf222952a99898ab46d9bb0 ]

in error path of jz4740_dma_probe(), call clk_disable_unprepare() to clean
up.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 25ce6c35fea0 MIPS: jz4740: Remove custom DMA API
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/dma-jz4740.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -555,7 +555,7 @@ static int jz4740_dma_probe(struct platf
 
 	ret = dma_async_device_register(dd);
 	if (ret)
-		return ret;
+		goto err_clk;
 
 	irq = platform_get_irq(pdev, 0);
 	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
@@ -568,6 +568,8 @@ static int jz4740_dma_probe(struct platf
 
 err_unregister:
 	dma_async_device_unregister(dd);
+err_clk:
+	clk_disable_unprepare(dmadev->clk);
 	return ret;
 }
 
