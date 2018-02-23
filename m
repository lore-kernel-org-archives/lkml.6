Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvliFkCkE6iuy2mMxFaN12x0pmIX8YsWSd0dzk8ZBI6oCTh7fde8scnF+0+vSOOuZE3JNNV
ARC-Seal: i=1; a=rsa-sha256; t=1519412081; cv=none;
        d=google.com; s=arc-20160816;
        b=Z8f7sBudjo3m6PQ0A+wjsYniR2pMBt7abWsW39Em3gaTdnTcjbnMZiSUMANUyMNyfm
         SS9puqACi5saetMghejBGmuPHeGRD6b/JoOzbQmN4FzqB+FwXpWbSUqSwqSlS8W8D23d
         lEgYEWMIZ7D3vJzRrM6Um2IEaQmM0tP9Gx3mLZ+5oZvHTr+QUwzL0hSq6NFDPOo80CRd
         OAtN/Rxl5k7IAAScj6YDavdbdIM+HPQ7YWk+GDczs/Y53gf2dQIMKRndZivzjjjmWY1d
         xuvxalQUBllmt9EMF3tV6I+ujBExnDgZoTD8LCz5K/NVZnS1i3KA7EQYvAUj2tUtOjlG
         fy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BwJ8LjGrxVFYYFEwTqDBDKi5tmSRXD2L5s2N4sw7Neg=;
        b=j5DEl7vFyW+f/J8tFjBzkKkuBkYX4MUVTq2Nb+Zj42Ycl2BBL4a2kpY8nqptmBxtQB
         0dc8/5wzV8AJqmm+5CdqCJd67lRkg6sYr8odLImJtRRW1yzl39z6f5CBAtheytwKCitx
         IG6YpXOEa0YS37TmenZsS2XBWS2G5lIqwC+omv9VdeIBBsx5CBUqE/jr56PJNhDc9mC6
         fDBi74kBBEoz/2QSWnfjQRCL5F1zUI+w9DJ7TSTj0FIW1cbGodlryu2SJ6QUmxbXnOhs
         yiKh2PdxYjHAnD3AQ8x5jGKouJ6wVjr6fnaytKIJbzkxsmsz7Tv5YzXszVMgoM9Y1Tkh
         BYzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yan Markman <ymarkman@marvell.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 081/159] net: mvpp2: allocate zeroed tx descriptors
Date: Fri, 23 Feb 2018 19:26:29 +0100
Message-Id: <20180223170753.395913447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219043130251047?=
X-GMAIL-MSGID: =?utf-8?q?1593219043130251047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Markman <ymarkman@marvell.com>


[ Upstream commit a154f8e399a063137fc42b961f437248d55ece29 ]

Reserved and unused fields in the Tx descriptors should be 0. The PPv2
driver doesn't clear them at run-time (for performance reasons) but
these descriptors aren't zeroed when allocated, which can lead to
unpredictable behaviors. This patch fixes this by using
dma_zalloc_coherent instead of dma_alloc_coherent.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -5399,7 +5399,7 @@ static int mvpp2_aggr_txq_init(struct pl
 	u32 txq_dma;
 
 	/* Allocate memory for TX descriptors */
-	aggr_txq->descs = dma_alloc_coherent(&pdev->dev,
+	aggr_txq->descs = dma_zalloc_coherent(&pdev->dev,
 				MVPP2_AGGR_TXQ_SIZE * MVPP2_DESC_ALIGNED_SIZE,
 				&aggr_txq->descs_dma, GFP_KERNEL);
 	if (!aggr_txq->descs)
