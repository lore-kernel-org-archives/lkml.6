Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqmInXEuArZ3hiD7dpBo/bNejdR05ca/ZQk1JM9O8tutvg69fIiKiVBe/iqZIWIgLcbL6A4
ARC-Seal: i=1; a=rsa-sha256; t=1526631437; cv=none;
        d=google.com; s=arc-20160816;
        b=Yijj5DIf8eyb6MhvIWd1WqEzMQRh3YBceOZ+HapLyK85JVLo30+aawLXF19Lds0gin
         /HKcT/+gjr4K+MJJy1zlzkj1CeNPjCpzBpqNTtRoV8emz5nYaVtEPf3t9jUsWM4pgj44
         BMpE9bliyaI1jYh44iD5LdC+cxcXMGJwWfKq5TKzElcZpvg/uMH4h/pJdtDPMrrbuJrv
         nEiTC2yxDNZvQd6e+Fkk4Si/8Cfz6HB17kj1V3akXG9aBPCrMo8DvD/LbQTg8niRu54J
         lpCMMjgHaHjmrqGMAK1PYhQMAWM4ZuNF7cOB7gkOa4tXGXpDVVMpklpYKxoeMNvUl9+J
         OPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jLSF3A4oAu2r1fhdp2Ohn0NTuJHZ+9ydwc+TOSBAgiI=;
        b=bxBG2ga3k+4gkCHL9GpofBkQoVR6LKuKCZ16plwrUurPxuZaJVHTHRVsDRp0XRVHJ/
         Dj/fi9beqrbVPXV9Ar4TxFCYfaoFQb/6OpprPrOJfCdgOtvRbgWuz0XNRV7umc6PxW6c
         VDujARsgwvSKnRtqNbDUq9Fql0mVtB8nVHxNy+ilcy3W5SaBn7m3TTsAiGcJvPuz7Lu8
         i5xNw/fgDPXoYw18CpHbZpaN6aK16l6Q/QBlnB5Nlmix4If4GRIl/hHL3SUiR/UTIrqZ
         GmUuY2Z98Tsc2s3E3uSSO1dC+ifpWsN2+XgE6CD40BDSsYQ66f7XlA9aQao1EjMrOz9W
         txqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=un67oEHM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=un67oEHM;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 09/55] net/mlx4_en: Fix an error handling path in mlx4_en_init_netdev()
Date: Fri, 18 May 2018 10:15:05 +0200
Message-Id: <20180518081457.833887891@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789086302168394?=
X-GMAIL-MSGID: =?utf-8?q?1600789086302168394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a577d868b768a3baf16cdd4841ab8cfb165521d6 ]

If an error occurs, 'mlx4_en_destroy_netdev()' is called.
It then calls 'mlx4_en_free_resources()' which does the needed resources
cleanup.

So, doing some explicit kfree in the error handling path would lead to
some double kfree.

Simplify code to avoid such a case.

Fixes: 67f8b1dcb9ee ("net/mlx4_en: Refactor the XDP forwarding rings scheme")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3320,12 +3320,11 @@ int mlx4_en_init_netdev(struct mlx4_en_d
 					   MAX_TX_RINGS, GFP_KERNEL);
 		if (!priv->tx_ring[t]) {
 			err = -ENOMEM;
-			goto err_free_tx;
+			goto out;
 		}
 		priv->tx_cq[t] = kzalloc(sizeof(struct mlx4_en_cq *) *
 					 MAX_TX_RINGS, GFP_KERNEL);
 		if (!priv->tx_cq[t]) {
-			kfree(priv->tx_ring[t]);
 			err = -ENOMEM;
 			goto out;
 		}
@@ -3578,11 +3577,6 @@ int mlx4_en_init_netdev(struct mlx4_en_d
 
 	return 0;
 
-err_free_tx:
-	while (t--) {
-		kfree(priv->tx_ring[t]);
-		kfree(priv->tx_cq[t]);
-	}
 out:
 	mlx4_en_destroy_netdev(dev);
 	return err;
