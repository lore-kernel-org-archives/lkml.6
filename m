Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs55N9oOG6/UUPn01Xnp7HchH3bH/ITRckHXcLwcSXt4UUHQrmKSNWzoTM5sQW6rIJ6SHGt
ARC-Seal: i=1; a=rsa-sha256; t=1519981115; cv=none;
        d=google.com; s=arc-20160816;
        b=RwXEdOeNycSgNvw5V1SSBb8vZAHDlcWVpEBPWRvEWeJyPgkG+3DQ4Pwv9bt/Dh53s+
         yZSYpQ43pTNrbPFXcH1neLLFZWscFn7jZAvw2H+LsYj+uMxcrIO0zIhFzp+WJaKQ7WvZ
         RPdex3XQiW4ScHijL9jOHaw8Fbd8uLhKH+Mah4zyQAckoGnneSpGMbc02+r4aUxhpedD
         D8w9sTBAkqGxr8yUccIhVRZIw8i+QUmhDddpEl9ms/05I5w0zRVzTCGgaMRd5ajOj/WS
         we1WotBfLqJqIRbKBNRfCN7Ls+h+F89Bf/AsCqmOPEXZIwIaJRGEI0URVI9jx28j0bs3
         v7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L1sI6DKByDYdasA4iTPMWr34fQxIFXteUzKoIxpAMWg=;
        b=sUc/eCC6Gg9tqpodAlOIFvObfUrKvA29z3BDHDFlw3vg3nOMYpZFBEFcpWvAwQbgpS
         xUm0Vvm6Hwt+d333aQ3O7ZNFzyRYq4eQCGt0lwU+xf8tLZywHrvdDhjM5Z9cr1Sk7ZaK
         BuWPrUkku7eI56fV6RmYyc4nPYYtxSC6COxQmhc9Ho8s5xOB262fUMhXngHaFHaTFrht
         l9kdV3du5FLFqWN00BinRte642+jeFmlaAewcOsOEUblRA71lY8pJp/jS4aWv3uIYF1o
         0qIujiYhu5sYjrpp1r2AWaHLribxSgrmfh9jXW4bONlZxwL81Ry7Ac6OJq0o2PQQAXhb
         9g4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/56] net: mediatek: setup proper state for disabled GMAC on the default
Date: Fri,  2 Mar 2018 09:51:04 +0100
Message-Id: <20180302084450.537773942@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815718582713784?=
X-GMAIL-MSGID: =?utf-8?q?1593815718582713784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>


[ Upstream commit 7352e252b5bf40d59342494a70354a2d436fd0cd ]

The current solution would setup fixed and force link of 1Gbps to the both
GMAC on the default. However, The GMAC should always be put to link down
state when the GMAC is disabled on certain target boards. Otherwise,
the driver possibly receives unexpected data from the floating hardware
connection through the unused GMAC. Although the driver had been added
certain protection in RX path to get rid of such kind of unexpected data
sent to the upper stack.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1842,11 +1842,12 @@ static int mtk_hw_init(struct mtk_eth *e
 	/* set GE2 TUNE */
 	regmap_write(eth->pctl, GPIO_BIAS_CTRL, 0x0);
 
-	/* GE1, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(0));
-
-	/* GE2, Force 1000M/FD, FC ON */
-	mtk_w32(eth, MAC_MCR_FIXED_LINK, MTK_MAC_MCR(1));
+	/* Set linkdown as the default for each GMAC. Its own MCR would be set
+	 * up with the more appropriate value when mtk_phy_link_adjust call is
+	 * being invoked.
+	 */
+	for (i = 0; i < MTK_MAC_COUNT; i++)
+		mtk_w32(eth, 0, MTK_MAC_MCR(i));
 
 	/* Enable RX VLan Offloading */
 	mtk_w32(eth, 1, MTK_CDMP_EG_CTRL);
