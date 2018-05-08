Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo33eVJBLuYpUa+CAHNggMPuAKleJxOhSBefBIWlBeroXJ6JzM14oH6jyBJgEtDUGGWe7Lh
ARC-Seal: i=1; a=rsa-sha256; t=1525767193; cv=none;
        d=google.com; s=arc-20160816;
        b=P0+wcaKvEgGWKWDqjcXmSCtV3LHgpLtpRYi+rQIAjPcY8yN4TPenrd8jv3xe8jnQ/Y
         Y3LBV5DxqJy2bIy3aZa0/bT4oCMVEQxsFctzF7e/o0GaKAMufs/wkUuR235PvHrYwM1q
         yBTrYddQyLPoZyqz56AHtwz+fLEM5/J02xf/jpH9qgflFvhhaxZ+ZTNT6fwTW5Qok+hH
         jp5KujrjlwTKHscMJAtIEYBRYTBdxE2q54o31Cb8jiEsYqeN6zrjgaIcqeal+0xDbu9f
         JyTAifxhtzWc6FqwqdbdqePTKkX7wFys9feCAOenrKCrCQvpFUULEoOi7Z6HI/6fVvsp
         V8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6ojBDM26i6w3yKIACeTDnUMIXTURbVhLpMgoof4p0tw=;
        b=0Z0BzZxKbRFdayLVwrm67OQROxr/sTNAI6z/oAo9FeAN8xq3PVXyMjHsaeYCXKTsx2
         Uwfq+GOBTNBKzSfqcH0nUW49KdcogVc1KjB4wPl8uU4wKSWN1CGa/eVmquvT6rYC+P0g
         1TP7K1G/5NcQ0BkRe65UMIKf+BwXdI1IXLsRMBRZ0H4WYGGNF10brCZO4H++I46URXjw
         es43skFmSiRFEc+DfAZYMZoeObhMQAIIjShCCVvQ5eZYjWonB2aKTKyUksg5im6bCAJI
         QyOkmswg/BdnBD5JoOg8r6L6S1fDrQYunzjDxuTnq4hLbwruL6mm6RFYQF+sbR0sWeoi
         9f9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RmiUh1v5;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RmiUh1v5;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Majd Dibbiny <majd@mellanox.com>,
	Danit Goldberg <danitg@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 24/52] IB/mlx5: Use unlimited rate when static rate is not supported
Date: Tue,  8 May 2018 10:10:22 +0200
Message-Id: <20180508073931.286685025@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882860729523531?=
X-GMAIL-MSGID: =?utf-8?q?1599882860729523531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2424,18 +2424,18 @@ enum {
 
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
