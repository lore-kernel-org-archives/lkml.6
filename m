Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtELWBFE4te4Oeu/oboiRG5wodcEnlCG6UUyzd9e5Lbz79Fb91K2IB02T+rkmdIlEU1z8gI
ARC-Seal: i=1; a=rsa-sha256; t=1519981367; cv=none;
        d=google.com; s=arc-20160816;
        b=iAE+CieeWt3NBVZjwt7+Sa3xubQSFxT55QX1NUrL2T1+WAVQdYF4CdMqBD/GdeOUU3
         /GCcO/tVKTYPT7gL0SRN0fWyVcYAw5cBSCoeKxpiMqwlK7txcLPRrHbmz8RkPqgKidY2
         RbjfVVf0xAxUd76YMj3D2YuHQ1RUrkMKB3SpWt+vG3YU7gCy9oxnlAxTA3i6zzlL1d8B
         MFEiFFjKajwOpEaetNMElXo4SFX+JvSQhKQ4oKMMR7xBje76WRwQvgH0sg5qd65M9BCe
         6QOPheOJWjKkCvMXmUFirOTc531F5OaMS2krygNG6RvEG5SXhtyc1bO6pQku+nitKoZn
         V+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mwsW6W4QjTiHlepUvgSkInFy1QeLV3GjMCaKrcd/zi8=;
        b=Lj/QVnuL2F3Wpp3f0s2Q85yctOxdUa/FALD8MxeM923ZscfC/+sLuQ5D2FdP0nPuSW
         l5OqwedImU93+SLqwfmd2wOghBHgOK6ZEtYtOPonx6hWWK1B6rvxqb2nEHeHzutyck1N
         iVbDhgaHQx4sbTYVP7sRxKrbA6GEFF5tiRHyo7ke6ZcyQk3gucB7HozdjVmQXwVugst6
         jhLMG7wqZCcXJQ4XyaNASS8q4esr+LCrw/CVHP3a3qSkuPkLtxJlXXLGgSPHHrLGJdMz
         hH2j/TctizpFup81R/mwt0yz8054KP5IXlnFc2bZWnqn8uUhEo+YaafruPQERTzyzQOY
         QGDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nitzan Carmi <nitzanc@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 070/115] IB/mlx4: Fix mlx4_ib_alloc_mr error flow
Date: Fri,  2 Mar 2018 09:51:13 +0100
Message-Id: <20180302084506.696176172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815465283752260?=
X-GMAIL-MSGID: =?utf-8?q?1593815982003540979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>


[ Upstream commit 5a371cf87e145b86efd32007e46146e78c1eff6d ]

ibmr.device is being set only after ib_alloc_mr() is successfully complete.
Therefore, in case imlx4_mr_enable() returns with error, the error flow
unwinder calls to mlx4_free_priv_pages(), which uses ibmr.device.

Such usage causes to NULL dereference oops and to fix it, the IB device
should be set in the mr struct earlier stage (e.g. prior to calling
mlx4_free_priv_pages()).

Fixes: 1b2cd0fc673c ("IB/mlx4: Support the new memory registration API")
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -406,7 +406,6 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib
 		goto err_free_mr;
 
 	mr->max_pages = max_num_sg;
-
 	err = mlx4_mr_enable(dev->dev, &mr->mmr);
 	if (err)
 		goto err_free_pl;
@@ -417,6 +416,7 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib
 	return &mr->ibmr;
 
 err_free_pl:
+	mr->ibmr.device = pd->device;
 	mlx4_free_priv_pages(mr);
 err_free_mr:
 	(void) mlx4_mr_free(dev->dev, &mr->mmr);
