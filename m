Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLXOhky8/EP0VtOHc5Dpz0Tdl74VWD5O1O3yDSHZ8o1v6eBr4zuXAru9zLVDI+7BKeFrvk
ARC-Seal: i=1; a=rsa-sha256; t=1520955013; cv=none;
        d=google.com; s=arc-20160816;
        b=EDi+xeMJcNCXp/FGQ1yKtNj1ObTo9PN2EMwnGfgBAjum0QRNv2ZK5vAdl0FoX2jBvz
         h0iN7Og7FsmdL3qjnsWs9Lqr5i5mORFuvb4RR+jmeED9kGQBa/IXat0UuhS7cRUhLGef
         VEACZdzZFhinFRQxNVuvxlTwQ7uOVio0hE5rzczktxV74FT8Il4ZIcCtS7qEekTOcMtJ
         AJ7WdiP5YDxoNy32wrflTU9180B+IOlXV24yIRMMOeAgWIABvUUFRtygOZVneivYExeH
         3hfIZ5ywMiFmYiJLuG1fRaIlQrxeoX0YSpd4+2MJrql3SOhlYbqRATM+6LT6YAJFpokB
         VknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1JVlvTpT6CPwp2bEkVHbgAEq2CfWbfJb4n+KA8Ju0IQ=;
        b=EsjOMwL18gEKdv/+ZC2gZ6+oHVBmJcdMRjvjzMirxMwqH99i94VDclNgJvRay3FxFs
         auh7bNp2Ufhl5rDmipcZGlWlF3DK2v0qGPgx6sFhUMaVP82p7KDoD/UidDWem2j0T2aD
         K3SL+hcpvzhCuyjd9JeNpAcMypeQmIDkY65FtzPNEcRJFrUsxsK4spMdZoB0c/GQJclm
         iTQigiEidkQQdfCw+N3mT5ygJwpRLmeQM7TNochHC3TG2pDiFkdYj1LWRrwx70H6h5ef
         3LjARbGm/gmuKh9J2i+krMSan4uYVFQ/dDNDC8vpCcPZqh7H4WwWFC14UqHmrMYuqR6Q
         pHGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sergey Gorenko <sergeygo@mellanox.com>,
	Laurence Oberman <loberman@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 059/146] IB/mlx5: Fix incorrect size of klms in the memory region
Date: Tue, 13 Mar 2018 16:23:46 +0100
Message-Id: <20180313152325.231930232@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836924185487286?=
X-GMAIL-MSGID: =?utf-8?q?1594836924185487286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Gorenko <sergeygo@mellanox.com>

commit da343b6d90e11132f1e917d865d88ee35d6e6d00 upstream.

The value of mr->ndescs greater than mr->max_descs is set in the
function mlx5_ib_sg_to_klms() if sg_nents is greater than
mr->max_descs. This is an invalid value and it causes the
following error when registering mr:

mlx5_0:dump_cqe:276:(pid 193): dump error cqe
00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000030: 00 00 00 00 0f 00 78 06 25 00 00 8b 08 1e 8f d3

Cc: <stable@vger.kernel.org> # 4.5
Fixes: b005d3164713 ("mlx5: Add arbitrary sg list support")
Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1813,7 +1813,6 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr
 
 	mr->ibmr.iova = sg_dma_address(sg) + sg_offset;
 	mr->ibmr.length = 0;
-	mr->ndescs = sg_nents;
 
 	for_each_sg(sgl, sg, sg_nents, i) {
 		if (unlikely(i >= mr->max_descs))
@@ -1825,6 +1824,7 @@ mlx5_ib_sg_to_klms(struct mlx5_ib_mr *mr
 
 		sg_offset = 0;
 	}
+	mr->ndescs = i;
 
 	if (sg_offset_p)
 		*sg_offset_p = sg_offset;
