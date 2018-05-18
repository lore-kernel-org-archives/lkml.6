Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZphEJ0hMmIXOCz9dbllz2o2Im5lWhdnNgNaGmUhfAcYNt43qbENrg4IWi3ZkpLQwAwmenMS
ARC-Seal: i=1; a=rsa-sha256; t=1526631599; cv=none;
        d=google.com; s=arc-20160816;
        b=TQLzWn5MyxHohyfSlTwzNl+bGH0nng5Kxz0HX2jLdjbHfKYC5Gf9SoS4tAHjJLwJy2
         sEQGEoHXUtEQghk/YG8mRmVIvhYouBPw+b63vOzEyO0On03/TSAVrAwkRxFcedj16dBv
         PfGbc4nVP1k0yxVu45RGYNduOLU3bz2r2kRKNlvfFYiVJXOvM/s2WXffmbXqFrrTtCQQ
         1kEHcSQNQdJpSCwICRDdYhY4kMvu2DhfpTHCPxUbEBaIyhSuzhHxrC9WqaZ5x51bGKVN
         /awvhhHH+MnmJMJHDKBCAdkNfTmK0CxA7dYVe5eHA80QY3ciFinHfQRpjD8USecYwrIb
         sAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GKEgf7OpAOt+V+HvHpNp1CjcKF2KZdeyoVZvfSfDRcU=;
        b=Rf3yLneiWMSZc3ijdAVNiINSmv6lW7GIdj2QU6yW4iids6jQnX45jc2jj7IMrXU1dR
         s1AZvZ8AHVrot40/V3+eDfp0RnumoaTH/yjMrrJVk23YJMd/LxjlRM1Am/uRMXqMn6Ya
         9aaNrxKOE5mPAeACQSEVdAF6UyBtkmn2uD9olEuzILp94zoGIQcnHOr50YCLIpXu/LtU
         VYEUrve0S/ak1hVOEP/otorg9j5AJNuST4kvBUa5tu6Lx247/MPbjDOVzF2bsXADTeEB
         8O3vJrKSFhOBwB00lWfF/ay599Tr8JFeIuo7SegcWSieFvOVv2EChQ5dcLTjICylp1Io
         K2yA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OCCaWNb0;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OCCaWNb0;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/45] net/mlx4_en: Fix an error handling path in mlx4_en_init_netdev()
Date: Fri, 18 May 2018 10:15:26 +0200
Message-Id: <20180518081530.792482439@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789086302168394?=
X-GMAIL-MSGID: =?utf-8?q?1600789256383023760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3318,12 +3318,11 @@ int mlx4_en_init_netdev(struct mlx4_en_d
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
@@ -3576,11 +3575,6 @@ int mlx4_en_init_netdev(struct mlx4_en_d
 
 	return 0;
 
-err_free_tx:
-	while (t--) {
-		kfree(priv->tx_ring[t]);
-		kfree(priv->tx_cq[t]);
-	}
 out:
 	mlx4_en_destroy_netdev(dev);
 	return err;
