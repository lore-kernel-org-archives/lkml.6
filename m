Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuOBxSOQeTy/phvaWuHZzNQ7rGKwgtuh3mr1h42J/itPt/F5pe90jc+4c1Rq83PwweLqBhl
ARC-Seal: i=1; a=rsa-sha256; t=1521800406; cv=none;
        d=google.com; s=arc-20160816;
        b=bSCme+gIxIJpY4ou91RmzdMLJop6rCq4j35WUiFeAghN+b4om+YTyeTv+W8JPPXW4m
         zOjEkLZn90SvTlTqQ+oArPMxBfAXN38Oh6XXa2whck3mzCwuLxF6W97HBTIn6X+aDhrN
         MKfihojBy6AeURJkcTT0PIA/DgbqgplTFsG2T/e6UmjcwFpQZJDOOOdkllgqG1p6tl2j
         zWN0xz0zoK75r8BcYboJ8igZEoY97Rbeoy7TXbuYCUwAJjq1qL5nejAPxWy5mCAOz1EK
         uaqM44WK1A/QrVCTp+y4CFX21AQ10Z0lhJmDi41XE+174IPOCSjbcojFDOknEisUzUVz
         d+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4zI+hP4dH9UBzJWh6V4JQVKDKAqkoiMrWtzyIO8OENk=;
        b=zpuWbcQ3sXbO2KsbRxwdMbj39PH2WXCABPe22iUahGryV5TR6EQqnLlo+X91bCztTx
         ydmYJOnHvoEa3zpEkrJ/0gMPvq9Xn+TancKwgWZrnDMJf5FuCFKTB4oBkcrVFwNXuNTu
         TT2JjrTqOVBPfu3pFFC/50OGu2Ddzp4xKUGVD6vHFqT/ujGWAhxvuOhsTFDFSOGH6SsW
         oJhOfhst5hplyDFpYrTtCwFxUYZ0vxidADUnsShOVNVtloWqODyNtibvpX5pzAoAjeW3
         y011IdwlLNFiUejvsvoFmTMJduaKZpyNSUM46plopg65szKNK4kufyKz10JDJjRmmqYK
         NEeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Daniel Jurgens <danielj@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 42/47] RDMA/cma: Use correct size when writing netlink stats
Date: Fri, 23 Mar 2018 10:55:33 +0100
Message-Id: <20180323094249.908669495@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722010857190263?=
X-GMAIL-MSGID: =?utf-8?q?1595723382634831946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 7baaa49af3716fb31877c61f59b74d029ce15b75 ]

The code was using the src size when formatting the dst. They are almost
certainly the same value but it reads wrong.

Fixes: ce117ffac2e9 ("RDMA/cma: Export AF_IB statistics")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3632,7 +3632,7 @@ static int cma_get_id_stats(struct sk_bu
 					  RDMA_NL_RDMA_CM_ATTR_SRC_ADDR))
 				goto out;
 			if (ibnl_put_attr(skb, nlh,
-					  rdma_addr_size(cma_src_addr(id_priv)),
+					  rdma_addr_size(cma_dst_addr(id_priv)),
 					  cma_dst_addr(id_priv),
 					  RDMA_NL_RDMA_CM_ATTR_DST_ADDR))
 				goto out;
