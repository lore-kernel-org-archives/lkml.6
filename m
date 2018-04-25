Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49QXPlWeKk11sI4HUHCHiR3teU+BmUCMVNH+0D0Vcd9KSR4orPwz+mcsU1PIfxY5WyQMHyy
ARC-Seal: i=1; a=rsa-sha256; t=1524652872; cv=none;
        d=google.com; s=arc-20160816;
        b=f6S4UvVHGmZGbkzFKpk27sB+FX+X7rOwKs0cDnqh7I0bhcG+p1rBbn7CPmlkNKJwhF
         y3Adb1AvA02I0GoK1KjOHQBpW8XHmBBy4Mgdg4t4RexU1OWr0ortlOQMm4V4UnPVSELi
         pahE6gp27V9eL8AHfjnJnulPtNOJWUTqIRurgwd0ar+on0+yYeCbAJhPaQJR+oGvskeQ
         lkd0F8lS/TuFIJwcxdSnPCxFoiOC9CaEs7cIcsveqZaPvhlN68/msnpLp/0o3xNDweYP
         stiG0a+VfZaMXzHC1WN6DfDDep+LTsr8kp2rdOJLHqynnigim3O+JDmQqRZUwI3QlMNX
         4Lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TGb4m7NSxGvQgDZ/GuDfMzo+8Bas+bPtvke/tpAIfHM=;
        b=l/Cy5tQ+Jpb1ZTahygWc85T4Hp/PICm1IofsDzgzOjLpEE1wM6nhC5vBt0Gy5l679W
         hng0FuiTV7+p1MmPzg7EznQyQBGfs3Ga37Xap8cCxN17ga4WK/oikgg9RFJyTxc6TuJb
         F9EgAl6BFAUcrlwUC1TeSrCTAGFf0UlDw3xzBRq2Qb3Og7BhS8Pq7EtM8T8xNLWlPAfW
         PpIQqDHEWrYPc2p5TlH99w/dcdtpToBVMsnf3GzTIBoOEYzNphLRayUMsVdLJ2Q0qgn6
         O8XKlfZ7B4Kv0DnUu0SdhhoIOdWBTJkS0o07K6cVillIbb1yTv3fE5XuUc/UmLOlJxnc
         +2PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Majd Dibbiny <majd@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 099/183] RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure
Date: Wed, 25 Apr 2018 12:35:19 +0200
Message-Id: <20180425103246.447254626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714410183552080?=
X-GMAIL-MSGID: =?utf-8?q?1598714410183552080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>


[ Upstream commit b081808a66345ba725b77ecd8d759bee874cd937 ]

Failure in XRCD FW deallocation command leaves memory leaked and
returns error to the user which he can't do anything about it.

This patch changes behavior to always free memory and always return
success to the user.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/qp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4636,13 +4636,10 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd
 	int err;
 
 	err = mlx5_core_xrcd_dealloc(dev->mdev, xrcdn);
-	if (err) {
+	if (err)
 		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-		return err;
-	}
 
 	kfree(xrcd);
-
 	return 0;
 }
 
