Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZojoBtZnJ4wGE795r8grLeKX1QVU5I3OmU87re2GI3V4/bZKUApFmSOhbFic3IQ3SsIhJcD
ARC-Seal: i=1; a=rsa-sha256; t=1526631611; cv=none;
        d=google.com; s=arc-20160816;
        b=iZijpNF+ymhDO1dVY0SnOHPWtLTptse62AKAJVULCiL5miKrA4y07Hd2e+Xb78llBz
         IxMxCepy4RS5N6hU5bvHktpPnk4DVbfyEPpbZ720qJKUguBKrtKBEOrVBrYjFqP9AAwi
         FB/0aJqFZheWBG73zCJeZj2xF9oIX/x+G+JTwaO3EkSjwZlxA9CKyh56hQUWJ0/Wn78Y
         Gv93JskjTacqPr+KRJsZk6LsoGSbRlkU91T5cUcJKk3CFkNcUKi6hEcF+9Hv1TDBtXhp
         jHHR38mfaDmTr4BmMG3qxt31y03Wuelc7fG3MzNQBvGQhNsZLTkT3KFHVIM0X+3iZo9Y
         0ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=j/gKn8hUsVs2xVM/ZdrAOycyLWGjGw/d/hm5mktXe/g=;
        b=Mgo4+Q0Igb6XF3FXyyylis6dhmhUjBnRMzOX83ySUZ0R4NrWluts32Uy0ndC6b4Qph
         j56Q+HulsLtaIcZpASSvUGu1Ij6Vox8xq5wKy+s1NsK/t45oqJCYOfyIEEv+6Z1sGojV
         oOBliecBBPbbkJ2nMLVCqx+dzaYjS4wBx9xGL8t3MnPyP0WkC7/kvF5ty5c0Mrdemywc
         7Af/bEvjUL8M6mX1u6iWE/3SKi5W5w61nXCj9EXfpu+a7Loq0lDtzAtj+IumI4Vxk4vh
         VsUvHHeZ6pHs/ywLNNWxmI/BeMVSwK0Vq1PA7k9599Fqua7MQ8bTOsPugjwg91tlYHmr
         KGng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0JDKyeLD;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0JDKyeLD;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zumeng Chen <zumeng.chen@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 29/45] tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().
Date: Fri, 18 May 2018 10:15:46 +0200
Message-Id: <20180518081531.820428601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789113551716291?=
X-GMAIL-MSGID: =?utf-8?q?1600789268565259219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8723,14 +8723,15 @@ static void tg3_free_consistent(struct t
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
@@ -14167,7 +14168,7 @@ static void tg3_get_stats64(struct net_d
 	struct tg3 *tp = netdev_priv(dev);
 
 	spin_lock_bh(&tp->lock);
-	if (!tp->hw_stats) {
+	if (!tp->hw_stats || !tg3_flag(tp, INIT_COMPLETE)) {
 		*stats = tp->net_stats_prev;
 		spin_unlock_bh(&tp->lock);
 		return;
