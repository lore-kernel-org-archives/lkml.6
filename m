Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuP7Y3YeRgYxj7X/2e5VYJCKTXLA1ByFCUSBecRXqtaL56oUSnK6Z3oHLDZfUSbKXzwqMIq
ARC-Seal: i=1; a=rsa-sha256; t=1520955567; cv=none;
        d=google.com; s=arc-20160816;
        b=TEooJL6YRJ2JggKHVI8up9M7A6GzTaFmh1Jf25pixh2aYBLS4PNMqsy9bwWQjtc84z
         kihOxc0kFHenJ8wHtpdJdqWp++AJBQM5cj8CHDKVNjBuzLXK+Z+JF7f/6ELoEtlRGKoG
         5ntAZ181yzxk3NUolntDK2/Fn4A3hIdroSM8jtdNl1bRS1hOBKXUNf0LVpaPcTn7watU
         h4pBQSFQZrLWXNo+hBAxiKXS9kMk/IJ7ES23N/ul+PpJPW3u2KI17eKktZkpU18YSHxP
         RHTpD6qATzvvReidt81oWT7SySaRGM6WgngFsuIAOffraldbTc0JBqWSkrklUhVBr1VB
         1xRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yS82jN29y5PYxT0Q8sQIuKCBbSxAewLnLPli8ck7CU4=;
        b=uDrhswiZelGU2xmQuw6zvyTI3l29u/d6VRPyvq+E00eNkj/pxeiBBEos8gxML6wi4o
         aDyU4ilx8jDbFPZdqx6lA2Wk29vB6i2VgNCgYe38e3bEUw7vLgi2lgldyDzcbBHQwEoQ
         +bIcFvWLW924DaIXSKfkfEHxWX6D5a5VEYnmPILKQhV1gdRhE5Nq2NAYyqurdeyaoBJD
         qcbWlxRUxASwoSn+9f7kmjHIbwv4hj27h3tMMJkUtXpXS9yYlofDK75edsPUqKvuebTB
         OzxvhMxs7+3+B9f9ldGE1sRFkKUumrRkG+OrgrIb44zCudJBr9HOdDa0cn3sClnZVjjs
         0Smw==
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
Subject: [PATCH 4.14 094/140] IB/mlx5: Fix incorrect size of klms in the memory region
Date: Tue, 13 Mar 2018 16:24:57 +0100
Message-Id: <20180313152504.485294946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836924185487286?=
X-GMAIL-MSGID: =?utf-8?q?1594837504759502564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
