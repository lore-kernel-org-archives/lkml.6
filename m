Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+/QLXD8GGBb/dLpbuEcBNou8jzy5jX9tza0NDRdkPPlnMdY+DzKPS7lJRqXvx7pZo1emM
ARC-Seal: i=1; a=rsa-sha256; t=1526631706; cv=none;
        d=google.com; s=arc-20160816;
        b=AM/xRfaaccbRNp9NqFUkHLUsfhxH3PDnEJHEKw/ctH4OksPrbXCoBXyAl4LD+LXZ9q
         nxtRy7dnH3sHzjZcQxTAESPOeXIKvQhkEHl8bDPDFRmhdxKhidRBsrnocbzxWYi5rTwt
         R7bbgzuh5b3DyaHq/VXpB3ZY0t49nFHZpwaopBOWLD3AJU713M8mKraWfbMSVJnNmOMN
         jt+LmJohA6ZeDJ0bxFFOUuKjVieg7IqQQfZNH8eUAf9Ltz1lPv1oKKCNPguXy8Jnp+Mf
         Jf4Y5rE5S+uAhXnpqlan3ZgOnlyJ+RBbVozVbH5/L8cyA9SMPKHuI/QivK1WJzf/CY6Z
         UnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=s7qt20fj+4Y9zjyp/2pznL0lMISrdHWfYlR+9u/spWQ=;
        b=B8xF062Zk9arbui3cbi3B+E15Smz8syGrcl2GwYV3FVKBs8TbR9MiDmEEHJOOEVKey
         f45XTCLvmw8DLaYWRugfDviDEfZ2Oa75z3eqv16KOD4gyVUsrlErqwWTBxmVvD/3Mlsx
         QWr08SIrIsEh9VykjexUP7ud39NUHGEevsaKjV+3rYUf5Dghb8sC+APqZlMY28zo+ZOr
         Zbwx6NiRWRxPOdU/B6ZFCHRrVmHtXWQX5t6aTUxvGLPCxD4jbnoZKSJzeUCtJwGhbQfn
         WoJkv1ubNGWwnw2TJ0UpzCEBwkZBtSJ4aXQxtOoiBKEQhx9txWGPUPlwKni5Qa+uH4Yf
         nhtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=x8kgdkyO;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=x8kgdkyO;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zumeng Chen <zumeng.chen@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 19/33] tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().
Date: Fri, 18 May 2018 10:15:58 +0200
Message-Id: <20180518081535.871300724@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789113551716291?=
X-GMAIL-MSGID: =?utf-8?q?1600789368826032868?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit d89a2adb8bfe6f8949ff389acdb9fa298b6e8e12 ]

tg3_free_consistent() calls dma_free_coherent() to free tp->hw_stats
under spinlock and can trigger BUG_ON() in vunmap() because vunmap()
may sleep.  Fix it by removing the spinlock and relying on the
TG3_FLAG_INIT_COMPLETE flag to prevent race conditions between
tg3_get_stats64() and tg3_free_consistent().  TG3_FLAG_INIT_COMPLETE
is always cleared under tp->lock before tg3_free_consistent()
and therefore tg3_get_stats64() can safely access tp->hw_stats
under tp->lock if TG3_FLAG_INIT_COMPLETE is set.

Fixes: f5992b72ebe0 ("tg3: Fix race condition in tg3_get_stats64().")
Reported-by: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -8720,14 +8720,15 @@ static void tg3_free_consistent(struct t
 	tg3_mem_rx_release(tp);
 	tg3_mem_tx_release(tp);
 
-	/* Protect tg3_get_stats64() from reading freed tp->hw_stats. */
-	tg3_full_lock(tp, 0);
+	/* tp->hw_stats can be referenced safely:
+	 *     1. under rtnl_lock
+	 *     2. or under tp->lock if TG3_FLAG_INIT_COMPLETE is set.
+	 */
 	if (tp->hw_stats) {
 		dma_free_coherent(&tp->pdev->dev, sizeof(struct tg3_hw_stats),
 				  tp->hw_stats, tp->stats_mapping);
 		tp->hw_stats = NULL;
 	}
-	tg3_full_unlock(tp);
 }
 
 /*
@@ -14161,7 +14162,7 @@ static struct rtnl_link_stats64 *tg3_get
 	struct tg3 *tp = netdev_priv(dev);
 
 	spin_lock_bh(&tp->lock);
-	if (!tp->hw_stats) {
+	if (!tp->hw_stats || !tg3_flag(tp, INIT_COMPLETE)) {
 		*stats = tp->net_stats_prev;
 		spin_unlock_bh(&tp->lock);
 		return stats;
