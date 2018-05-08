Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrodQIEc1QBLK2MpqLTD8gjuLzpyoeUYXlN3PldA+C1s61ncoovevmLOn8UlslBDeGiN6HC
ARC-Seal: i=1; a=rsa-sha256; t=1525767308; cv=none;
        d=google.com; s=arc-20160816;
        b=iWHecWX4SYpSOuiEsQjA87F13qYUgcNHSnM+L7ckvLjAs5BYFlJlTeQoqzs36CD6Jv
         MEazpg0GQxCIOjVjN5xGSuR6CPqMNMEeYdeIDUwGE4/ffKz30Zq76POCTcCR4FklPKnJ
         5PyfbVfam0UfYlzyTVzX3kxDbMThl0VrJlExNa0rRhxmRw0AwCJQvOseew25HcTLTZao
         knrPB7j+u5N8RpX6zGFMUY4IFLJP162dYh7F+FgXXTwJXjD/hgqKxoA0hVpVuaK4UvaH
         OadEM1YpiznbjKBqhM7rVwyoVkiKK7idmtzA8K1KUIZ6M+ZTxUnKUZQE+6L1dAm7a/OF
         5VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jQMJ9spNUotX7Ai5gzl4+kzp3YB5qIqz/Af/s4jryeo=;
        b=q+HjjZmqdCX3zbVqrCBkXs/bqnZYzM7S+9dXSJAyPrLiBlc6N1YFj4KlSWmRYyJC8P
         XB263C5yYV5H4OH3gMQ+UaXjm5nrjfXgfB5cY56Ox48E37bR6DO8+pQi/+SfEums+OU4
         pyQbyo6XiDNnN2e7t0+ioHoTPwv1vQBDWfBKzOpMqlhrs+3/M3N7XdeuURHzl3ryEUrx
         PGQEqcACUefRo/U1PX9H5wJYtr2H9ze7r1C8PybYH+EG5BO4ElbM47QI0Grj75ruqYqn
         Sx6twBWiSseJgRCgc4vx0hQjfnt/g3NlidLuFs5b4DasZy8E6ZlFAlniLG9sF3uPGKm1
         vi+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=avaJini3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=avaJini3;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Majd Dibbiny <majd@mellanox.com>,
	Danit Goldberg <danitg@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 25/43] IB/mlx5: Use unlimited rate when static rate is not supported
Date: Tue,  8 May 2018 10:10:44 +0200
Message-Id: <20180508074008.006615301@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882860729523531?=
X-GMAIL-MSGID: =?utf-8?q?1599882980728084168?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2199,18 +2199,18 @@ enum {
 
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
