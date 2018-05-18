Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrltXO02PMAzM8J51swceeNqlRbv8JJbX1zAABUTMZpsfvTsB/StFhCSrzbE5ZfWEfeKU/j
ARC-Seal: i=1; a=rsa-sha256; t=1526631463; cv=none;
        d=google.com; s=arc-20160816;
        b=i47txzldM1pmSDVzXVmZlLtWk8xyr9gMj9VaiD3Z/wqh8vkN0bQQrSgH12XrDuQe0C
         coGCfYoq/6bYWB6qrKCB9MwiUpUzclabcYvqhzRsal3L/Jm7vGbrmn+eWpPL58tnXUkg
         YVhyQt6aU64eCqhGYs6YP+adLL5bwDT5GcOU4hDjGbCkTH9UAX1V93FfxpenWXZBdndE
         5cIy6d9/S6PMwx1/6ghpBX6Pql49QSU38lykCBHo0dKkzS/8Va5DuUU6rqRPCm3EZlIr
         5KUfiOKlKubVwfaifVWGrWZA/P6WVEfsegI6pNqovRXTNNxr7wQA2dLkbkQMSQkpxMvM
         gUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QRzEVSyVCNd1DHsU58OQLHTYZw7pUB0gJ9aM5Ncz0U0=;
        b=jjTUrZUNSFfDRh5N2pi0ZTkr9ztW3ozHqJNr7H2yrB7XWGZrk5oXWOtOTXbVLv8sLz
         44rrE/WOwTX6UundoxDl3xVMXcFxXuX0o7cDvJjLfEZ+iicKQM0m+k57XHKgaTy1vdhB
         U2lQwd1oyCAx88IsdXBJZa1Fsqc0e7FQfphERELixT80oyaRH1YneBKeR8tMnUIaWj8Y
         3bMsQDDTnwh8bx5CFuLILtPYdT9sdT4ggb5oE8iCo0lN9YxKRFitl0cay2vQyCmNvSX1
         tYGxYu+ELxkwhqyah8GYPxSX1RlOqzO8toSERGNJxGfJnrDpeD2aT7Y9E+DJ+PwYCCts
         D5AA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dk8gO9/E;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dk8gO9/E;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zumeng Chen <zumeng.chen@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 30/55] tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().
Date: Fri, 18 May 2018 10:15:26 +0200
Message-Id: <20180518081458.916839224@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789113551716291?=
X-GMAIL-MSGID: =?utf-8?q?1600789113551716291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8733,14 +8733,15 @@ static void tg3_free_consistent(struct t
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
@@ -14178,7 +14179,7 @@ static void tg3_get_stats64(struct net_d
 	struct tg3 *tp = netdev_priv(dev);
 
 	spin_lock_bh(&tp->lock);
-	if (!tp->hw_stats) {
+	if (!tp->hw_stats || !tg3_flag(tp, INIT_COMPLETE)) {
 		*stats = tp->net_stats_prev;
 		spin_unlock_bh(&tp->lock);
 		return;
