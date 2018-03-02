Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7X4YiGFyy0Aw8ebgGvEH+beXdqoF6ZkSR9F2bDVo0aoo//uCFg0asPKqOQaXybR/8+r0n
ARC-Seal: i=1; a=rsa-sha256; t=1519981037; cv=none;
        d=google.com; s=arc-20160816;
        b=xZ/p1SE1u+VxUCM/xS8gVqxKmpXnEjuh22ZFiiZaWcslXbdZc4Wu+gDQ34EAWUUpjG
         /qLcwVbD+4RxBeuiJH4A3jBfc7LA9GWxGkt6wrs3NqUPOhN33YGlv9NbyspQ3yFuA29R
         2mu0QKcKX4v0YE+tMayPEvyYqvlHpm64Yy+1Z0BcdWGXcZcQLUcw8Hz1mqkGBCOUpiZF
         usZm19TtAU9LOnbak6D1wVbPw1dmaQOqb758/30Vky2lU6BaoWWaHHO7KC8xs2WdI34z
         tXDcR3riWgnMTPeR4Nj5RUnz1rdaWx6akWnB+kmxzvkSGJF+147LqT+65/9zWZvt4zXo
         eaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fhevZFI3ux3ozyOMVtpWP417Vr/guplhoofjSvJknV0=;
        b=hRaBv1LgYh1vl4qFurUOPfyjQxhPaSD8JW1x6QkZNQuuEsU/NDXlcaBzb/2QmqQ0js
         tIkmWJI0fpHWiZPsnYTmONVG7+TVCSIPx8lF0SdkwVy8dm6cST2EiUmgsQTPwKmaAxV5
         TJOMbsvpLr4Ct0aFePZqWxBFMOlaO5XabHk6JUejJnQp0VOCnhp03MNFBZ6RgWqoBS1q
         ZcUHA+kIcXiqnbI/LiKXvzzdIKtIBUOJUBVkoKRDivR3T0FwmNRK/uYwZaMPDAlzVW/A
         lpE3FFeDmM1XMZXuQpUS9rRht8anImKhYYXbIJE7goq5nU/vaaqwHKCa9Gb48fysPLAk
         s+CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Gurtovoy <maxg@mellanox.com>,
	Nitzan Carmi <nitzanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 31/56] IB/mlx5: Fix mlx5_ib_alloc_mr error flow
Date: Fri,  2 Mar 2018 09:51:17 +0100
Message-Id: <20180302084451.153286363@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815636035615151?=
X-GMAIL-MSGID: =?utf-8?q?1593815636035615151?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitzan Carmi <nitzanc@mellanox.com>


[ Upstream commit 45e6ae7ef21b907dacb18da62d5787d74a31d860 ]

ibmr.device is being set only after ib_alloc_mr() is
(successfully) complete. Therefore, in case mlx5_core_create_mkey()
return with error, the error flow calls mlx5_free_priv_descs()
which uses ibmr.device (which doesn't exist yet), causing
a NULL dereference oops.

To fix this, the IB device should be set in the mr struct earlier
stage (e.g. prior to calling mlx5_core_create_mkey()).

Fixes: 8a187ee52b04 ("IB/mlx5: Support the new memory registration API")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/mr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1648,6 +1648,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib
 	MLX5_SET(mkc, mkc, access_mode, mr->access_mode);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 
+	mr->ibmr.device = pd->device;
 	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
 		goto err_destroy_psv;
