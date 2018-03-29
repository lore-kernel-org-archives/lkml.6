Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49n9Rqn+Cb1J7Hdaxn37aFsJ15JUbIivMZBHMRFyuSBOyGpk41VfeBuvWgpGP0NY547nzgQ
ARC-Seal: i=1; a=rsa-sha256; t=1522346575; cv=none;
        d=google.com; s=arc-20160816;
        b=a452sndVPo3YakjwHDAdKsShhmbiA1MJTn6rmUgGvI6WrTPyPghB+gRBe2oCCWCM5y
         6owW0xW1GaLbt/yl4I8BiCbsfpVuAfKs6SnOCQBfNppBEcBZKrUorXiGVX4VyNR7sG9R
         JET13n20mjjw/zhAubRZjl3gzMf8Cyv1xbP/7E0SukPopKzEgzD/9XB8poN0lAlXCrt7
         ugNg1sxZHptJMUKAeRsQJrsnyJ1LppI5gS2N17n/2LLKS5SzCUDU4ymtBxZXKLM1Hl8E
         8fcJ6rjmsNXYwg3w+aT//cAafhUBIZNSp+4OV2k5MR92nxHAa7V6WxUEhPXz9vqY5Kc2
         cFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/9AtqQM4gNcOAF+jnX7iX5Y+5G3CJoJ6QDm9j9Gb4sA=;
        b=GXQaDcGuLJSv+RUxA+ng3IScoexDtvJ5avWbTFHkyA7mMnbgpWITKc9nol4psutTBP
         omrW8XNLfRMJLsHRR1K7LaQqU3boWI0hR8JGYU2rDtAognb9wGY9DQE0ovE9Qzo/nppt
         SxW4/mJEgBqu36bHaWTCA1gl/jgRzvj7TrodjsF9/14VfE6r5/H37EipxRWrEDkmdO0E
         rq5GFjsyIhs0JCkajPkyIS2yDHS7cRKGhMm8PATSwaBnyDylhN4Z7ulBRIMrsdGpTLQE
         gJy+780K4ibKSUA/lkvy6rwhsN28RzDrsGkQzHCx922i2LQcfD0zj3x6z+riwRa63sw1
         3ydg==
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
Subject: [PATCH 4.15 33/47] dpaa_eth: increment the RX dropped counter when needed
Date: Thu, 29 Mar 2018 20:00:14 +0200
Message-Id: <20180329175731.939328400@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296083643005828?=
X-GMAIL-MSGID: =?utf-8?q?1596296083643005828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2310,8 +2310,10 @@ static enum qman_cb_dqrr_result rx_defau
 
 	skb_len = skb->len;
 
-	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP))
+	if (unlikely(netif_receive_skb(skb) == NET_RX_DROP)) {
+		percpu_stats->rx_dropped++;
 		return qman_cb_dqrr_consume;
+	}
 
 	percpu_stats->rx_packets++;
 	percpu_stats->rx_bytes += skb_len;
