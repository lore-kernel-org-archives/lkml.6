Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224U1Eh/v/g7FsaaEcMlB7D5YxbOvG6rBIcDMGSjfbxzNson9WGS4KBQO20IDrmfbt0Q53qu
ARC-Seal: i=1; a=rsa-sha256; t=1519412142; cv=none;
        d=google.com; s=arc-20160816;
        b=RpzREHeX7ZRo2lriO+CCsjw/vRHWgKs1C84GBP7cRJv2OJS+9xwPbY9nMAPkTqKUOc
         QBh4oc8+D3EuwWzQM0XEaIkGH6vhbKJ/lgoviogD4TGHOQw1r3REYpVGKpT1M9/GenO2
         cNM9XmbcoIJ0eGB5VwXnDgKLS9pVlEXiF7jkmWIHnB7TneOdjlm6gwVFYG3WC8z6hJ72
         x5GxmM327q1LVyWCgqaPp5j3AHiNlXAfkbs+NeHU4JKehWAvfb8MkdaQ50Yn8FUdln81
         Xhf14gf83xRdvAcGzDOKsU/qlwhIqqWhI6+gR7XvJRBnJo3G0vPp3/CMXKE1a8Lw5WK9
         g6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N6USBEfU6ihafmYfFqSu/Yls1/gfhExU4u7YSua1J+I=;
        b=tjf0X6oR3UW4VSp63AO7xOCI0VoUcCw/S+wNR6VMF3ZhEwSR31K+mbUNtMSByQ73Qq
         XCaXR2Gtl22fIEBaeKH375O1pExvZta8rAbkvCpcGRDU9qxN1t2caRs25WhPjf+8PY/V
         LJ+zkLjX6PFqwjWe2nocdKFsHY2JOnbXOtW4W2IBXk33I1WIvEW/XEyEQsZbN0WQpUEg
         rvy/ZoSFeq5EF6IvDdysB4MYnlc0t2oXqkdFAEYPPCrPvKuqRy3gP6Jh6HvExnqyruCw
         e1Qsuhv9ABDMBwrxWxzBedq66fR5O8fvFaXkQiokzwRNTfQDoCrdZ5iMnyF+5/TcY2IV
         icOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guy Levi <guyle@mellanox.com>,
	Yishai Hadas <yishaih@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 139/159] IB/mlx4: Fix RSS hash fields restrictions
Date: Fri, 23 Feb 2018 19:27:27 +0100
Message-Id: <20180223170759.875021999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219106719089053?=
X-GMAIL-MSGID: =?utf-8?q?1593219106719089053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guy Levi <guyle@mellanox.com>


[ Upstream commit 4d02ebd9bbbdde1d524e62b540b0402cee7bbcdf ]

Mistakenly the driver didn't allow RSS hash fields combinations which
involve both IPv4 and IPv6 protocols. This bug caused to failures for
user's use cases for RSS.

Consequently, this patch fixes this bug and allows any combination that
the HW can support.

Additionally, the patch fixes the driver to return an error in case the
user provides an unsupported mask for RSS hash fields.

Fixes: 3078f5f1bd8b ("IB/mlx4: Add support for RSS QP")
Signed-off-by: Guy Levi <guyle@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/qp.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -666,6 +666,19 @@ static int set_qp_rss(struct mlx4_ib_dev
 		return (-EOPNOTSUPP);
 	}
 
+	if (ucmd->rx_hash_fields_mask & ~(MLX4_IB_RX_HASH_SRC_IPV4	|
+					  MLX4_IB_RX_HASH_DST_IPV4	|
+					  MLX4_IB_RX_HASH_SRC_IPV6	|
+					  MLX4_IB_RX_HASH_DST_IPV6	|
+					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
+					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
+					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
+					  MLX4_IB_RX_HASH_DST_PORT_UDP)) {
+		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
+			 ucmd->rx_hash_fields_mask);
+		return (-EOPNOTSUPP);
+	}
+
 	if ((ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_SRC_IPV4) &&
 	    (ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_DST_IPV4)) {
 		rss_ctx->flags = MLX4_RSS_IPV4;
@@ -691,11 +704,11 @@ static int set_qp_rss(struct mlx4_ib_dev
 			return (-EOPNOTSUPP);
 		}
 
-		if (rss_ctx->flags & MLX4_RSS_IPV4) {
+		if (rss_ctx->flags & MLX4_RSS_IPV4)
 			rss_ctx->flags |= MLX4_RSS_UDP_IPV4;
-		} else if (rss_ctx->flags & MLX4_RSS_IPV6) {
+		if (rss_ctx->flags & MLX4_RSS_IPV6)
 			rss_ctx->flags |= MLX4_RSS_UDP_IPV6;
-		} else {
+		if (!(rss_ctx->flags & (MLX4_RSS_IPV6 | MLX4_RSS_IPV4))) {
 			pr_debug("RX Hash fields_mask is not supported - UDP must be set with IPv4 or IPv6\n");
 			return (-EOPNOTSUPP);
 		}
@@ -707,15 +720,14 @@ static int set_qp_rss(struct mlx4_ib_dev
 
 	if ((ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_SRC_PORT_TCP) &&
 	    (ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_DST_PORT_TCP)) {
-		if (rss_ctx->flags & MLX4_RSS_IPV4) {
+		if (rss_ctx->flags & MLX4_RSS_IPV4)
 			rss_ctx->flags |= MLX4_RSS_TCP_IPV4;
-		} else if (rss_ctx->flags & MLX4_RSS_IPV6) {
+		if (rss_ctx->flags & MLX4_RSS_IPV6)
 			rss_ctx->flags |= MLX4_RSS_TCP_IPV6;
-		} else {
+		if (!(rss_ctx->flags & (MLX4_RSS_IPV6 | MLX4_RSS_IPV4))) {
 			pr_debug("RX Hash fields_mask is not supported - TCP must be set with IPv4 or IPv6\n");
 			return (-EOPNOTSUPP);
 		}
-
 	} else if ((ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_SRC_PORT_TCP) ||
 		   (ucmd->rx_hash_fields_mask & MLX4_IB_RX_HASH_DST_PORT_TCP)) {
 		pr_debug("RX Hash fields_mask is not supported - both TCP SRC and DST must be set\n");
