Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9MVHHtHjF71HlIK4Q/Wo7ee039HKfFYyNmaEt+2z5L+1i73FRT6XMlJn+5EPqTWDpLBPA
ARC-Seal: i=1; a=rsa-sha256; t=1522346730; cv=none;
        d=google.com; s=arc-20160816;
        b=A/8BdQFa79mDGg+OG+ibhBcrDtsio/DH9CENv7KQ2NQZr5YiN4xXhdJu90eCMaPbkw
         gbMJwy8iqh/qfUB4k/VbNXZkVvabzNYJqlIsdFpbC/+i1w3dXokz0l4xpecA2I4/d6V4
         JOBHlOCJ0l1tmej7ymzf0WNl76fCp9a4N6OKskMpvezs6M+sSAz39U6UieLRlJni86w5
         v+WEgsHZCaS2vYsFyyzvFTv2Byw9mwasAzHpBLpdjK433j2JFbIEYyHYNXNkVSOepxz1
         xp4IYKRRm9/reodpRELfLrfeHVrKAzRIgzREX5XYbtEdlLiLtULOwiGcW80gxPa4nz9g
         6Kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IRJF/GVwIWH+TtQAM+twk8W0/8gLLVYECTlnl2L+lZg=;
        b=SGwvMuNjKYf9f8ry9dRr8w/PNUT8+VDP1bnx1BNOMyCJTVeXuyD0Q0FJrIHjJW7gpN
         HKZn/Hl9zaHMD6mNGjQaw54kaTNCwjVTy4KtjBWe748/dnDWsDtIi5tiW6YwUmfg6JY4
         rckC4WlfreCBkpqa6JXij7RGR1G1bCDrYEVwH0839Z6XeT8XNpYU5ofSHixTM9HH3mau
         LvZ0zj3c5K+QiCFFAlGTA90ASOBnh0UAk485j9D7GZBnuxXcTzWv4HsStcIHT1CX4KPO
         D4ZHVbP4aP386UZFR6fNswbcfCQyGHOdc485Uf2GMoChRW0LJSRFsp0xmd7Yfou5r+qH
         MhaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Camelia Groza <camelia.groza@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/43] dpaa_eth: increment the RX dropped counter when needed
Date: Thu, 29 Mar 2018 20:00:33 +0200
Message-Id: <20180329175734.297716299@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296083643005828?=
X-GMAIL-MSGID: =?utf-8?q?1596296245328966730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camelia Groza <camelia.groza@nxp.com>


[ Upstream commit e4d1b37c17d000a3da9368a3e260fb9ea4927c25 ]

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2324,8 +2324,10 @@ static enum qman_cb_dqrr_result rx_defau
 
 	skb_len = skb->len;
 
-	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
+	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
+		percpu_stats->rx_dropped++;
 		return qman_cb_dqrr_consume;
+	}
 
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += skb_len;
