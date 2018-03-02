Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuXJGZ4DCYT8fG2dpS0yYpq7Lo/ot3KlLpOJhW0zRYgIajOkU9jPzcVin5Sud7PxD5UJAEi
ARC-Seal: i=1; a=rsa-sha256; t=1519981046; cv=none;
        d=google.com; s=arc-20160816;
        b=do+F42ICQxzMPcrobdpVeitshl1apLkyW1Q111Zg7IIuZNdc1FFpZRcvRBk1bLV23W
         Eb4pvjIY3q8t08iWL2+qp+sFb24lcDQa62EP9fhbPo5QYvf4GXW8WrO5PWMJkuVQPXgU
         BTKPDyS/6/fCLZlsEUCyAByDW3xodb3O7did6NAbvyo0pxbRZFdx3KiCEwCm0oznox6f
         mE1mZIuymDX7h6xYaLB+JKTQgsRszO5rNvhXN+gjhlFpZ3TrLH/vHBBeZ7eh6jnKwkg4
         rlYSvGDoBW9qgjZ1FyONF4q56cTUO4ZyDRqPZMBbCx+WHmpRX7TqDMcTCnUje9J0DpMN
         bU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mXJdwIkqzd+S24oZ7QKv9F+vcRI0kkrtud/lnfXL8c8=;
        b=iSCNQXHXrzTcfflydu8uDZtKCpttxvHXhHkorWOt/Qg0Ep+a3U3f0F6SMU0M6KsUrL
         UxqU7JSN7t0AXjNvAK26Zk/HKRoAysUo9zGQLnZGnaUbGed89xqX1jJ6b9y+7D0VaMup
         WqY9RhVaRgRnZg6twQFgL/BF3Hv/lDtG67OeMapD9vi9jHEf1d2czCQjbFocoQiHIeh4
         p+L3hLaJdJjtDV5Y8vdfQ5YzXL1MuWa7VFW2ON1WLxe8ZLF0zjXV1PP/ULY+akj1SVPo
         ZEMV5TnISXmznzOcgEuUtuvYn+5ngq0+ugYneqXBWVhHZ02ncogAO3jefkr9flSRkda9
         hMTw==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 34/56] IB/mlx4: Fix mlx4_ib_alloc_mr error flow
Date: Fri,  2 Mar 2018 09:51:20 +0100
Message-Id: <20180302084451.306380271@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815465283752260?=
X-GMAIL-MSGID: =?utf-8?q?1593815645813088662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
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
