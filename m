Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrtXm/Urbq3CJsr8SdB9gWlRDTlAHyNxgEnVhNh67n7AXrajs7AAt7SDzBZaB8iAPlgXO57
ARC-Seal: i=1; a=rsa-sha256; t=1525767421; cv=none;
        d=google.com; s=arc-20160816;
        b=omXx1gkx4hmUif/N7rW+VBqkAbc8ujI/C4EhJjgSHy/p1sOqt8+vf2vVgnhQs0yukl
         oAPOlTERskKG4wxlfiT77qsEEJYvP26xt289ODdDYcRwxFTGvP3IGFrSTgUewdgBk5/G
         /22w0MH1UBRU7Hxmg8WPO3ujFKGEnYs2zL4G7B5SDbpRRq1w1SEasflq7n08+DbmztQO
         8KikLVlZ/9s8RmXTuAsGh8PNY3Lo89PgstX5ytSViGWyiJ7G62rmgYqO8lrudocc8M+A
         BaJ4MVdGkQn+Umixny5NmCcsNc4lrDob706CiTaF7GROor8ex/qpqIxk2w6ci+GdcYdm
         MmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9+CqxS8SJGDArHkC4+XHR5RtDT9NRb4aYrPWCZm4Z8w=;
        b=0vmXPTkloCJatAGACgy1id9svsYTZXd+teyVLXD/SWY2+0z+tNop7Aas1mAmG/A5R/
         Z1UaZ26pyR7uHFmqmy89YFuWTFs2nH9SCdVe7RF1A4/bcbjKZxfWQDguPPK7gZQdTvhz
         tt4aPjDcZ9Yl8gJwY9s+umT43/O1zXDHtc87gCrMvvH8bP+/3sIaq1/cLiEOHvUIU+Ho
         kjCVLdeajc0Uoo8H4VQ195r1C2o+4sZI6Vbq4qB9EqmN1mF4VQT2xWzGXRADIRjew4Lg
         8f4xSH0iX7PENI2tPuv9lwzRaVnEmNaqcbz1XcbSc3g1NSJLTRXrsFJ0WYFnwAfG3NWO
         Cs1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NIQ0e1Kx;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NIQ0e1Kx;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Majd Dibbiny <majd@mellanox.com>,
	Danit Goldberg <danitg@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 20/32] IB/mlx5: Use unlimited rate when static rate is not supported
Date: Tue,  8 May 2018 10:11:00 +0200
Message-Id: <20180508074012.188056532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882860729523531?=
X-GMAIL-MSGID: =?utf-8?q?1599883099703795120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danit Goldberg <danitg@mellanox.com>

commit 4f32ac2e452c2180cd2df581cbadac183e27ecd0 upstream.

Before the change, if the user passed a static rate value different
than zero and the FW doesn't support static rate,
it would end up configuring rate of 2.5 GBps.

Fix this by using rate 0; unlimited, in cases where FW
doesn't support static rate configuration.

Cc: <stable@vger.kernel.org> # 3.10
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2168,18 +2168,18 @@ enum {
 
 static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
 {
-	if (rate == IB_RATE_PORT_CURRENT) {
+	if (rate == IB_RATE_PORT_CURRENT)
 		return 0;
-	} else if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS) {
+
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS)
 		return -EINVAL;
-	} else {
-		while (rate != IB_RATE_2_5_GBPS &&
-		       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
-			 MLX5_CAP_GEN(dev->mdev, stat_rate_support)))
-			--rate;
-	}
 
-	return rate + MLX5_STAT_RATE_OFFSET;
+	while (rate != IB_RATE_PORT_CURRENT &&
+	       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
+		 MLX5_CAP_GEN(dev->mdev, stat_rate_support)))
+		--rate;
+
+	return rate ? rate + MLX5_STAT_RATE_OFFSET : rate;
 }
 
 static int modify_raw_packet_eth_prio(struct mlx5_core_dev *dev,
