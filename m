Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Dt0JP2AvcT1+h1e170VBTep+Ql2QY24IExOW4ifhDk9c6ocokBrX0VgKhrIPUP4YtEXrI
ARC-Seal: i=1; a=rsa-sha256; t=1523399193; cv=none;
        d=google.com; s=arc-20160816;
        b=wY6qUcH7kwNZsHleITn0LtlNbS1z5hv+s0bYMtgjgvnVIhpROuDYW5attdyBY9Vd4x
         USB2UdW62cMJNjd5uj4Osoih8NooENVgpgjzUSusQxTc3HdttIwUOf1zXQm5zKJOiblt
         JJ1I72ww8kdIorRzJ1ihdhaw83zMJTGISsuMJMnNwA3jEYO8VeLlbafDvs8GD24nEF19
         19o/7IVCc/Xjo2w8UnT2LjfMKOktxofb2ldVgOHdsFI3gH9SyJu6D6HerHLnWcitEGZH
         dmy9bDxKR7SMiOzZ1P7VIgdg9Fj5sqV42Rf0oBoVWoTXiJGvpdXLUIra+9usRl8fjPAB
         NF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hwDpd3wUw41AoBP+B6Zdj7AP24XCG5uyRExZruCdoJQ=;
        b=E1A290olXyGtFRrW4pyI6OdT9LzU/JDX/YtXU4OrzGYuODsHWArwq80h3T2DyOo785
         flWrRBs14yx1tIg3J85z7cQo2VA0g6OS/BG8VMIlrCu7KBkWZS9mxAXnj55QiU3BN6Xz
         K7jkO+kagkcJJhgvgEMkxZxnJNvFNVfkPZuMCwwqa4vc7pzzov4nMe07NFEVhbHAWbrR
         YhkSIirXMMIeyzOMHZJkKa0Zhx7L6Ir6tOvfYIHA7PV5HAAXGKZANtj4IHSrVbUkN3Xb
         TSp8J+XE3oLX23apSxSLnwAHO2ColSdkZiCDwEDRK5tfBVhfIOhWPFyB1FevLxsTgVEU
         Oj8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maor Gottlieb <maorg@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 020/168] IB/mlx5: Report inner RSS capability
Date: Wed, 11 Apr 2018 00:22:42 +0200
Message-Id: <20180410212801.064957313@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399833356313407?=
X-GMAIL-MSGID: =?utf-8?q?1597399833356313407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maor Gottlieb <maorg@mellanox.com>


[ Upstream commit 4e2b53a5cb5a8243284dd7ec4980d2dc556e79f0 ]

Add missing inner RSS support capability as part of
the RSS supported fields.

In addition change MLX5_RX_HASH_INNER to 1UL << 31 in
order to define it as unsigned.

Fixes: 309fa3470fca ("IB/mlx5: Add support for RSS on the inner packet")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    3 ++-
 include/uapi/rdma/mlx5-abi.h      |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -682,7 +682,8 @@ static int mlx5_ib_query_device(struct i
 						MLX5_RX_HASH_SRC_PORT_TCP |
 						MLX5_RX_HASH_DST_PORT_TCP |
 						MLX5_RX_HASH_SRC_PORT_UDP |
-						MLX5_RX_HASH_DST_PORT_UDP;
+						MLX5_RX_HASH_DST_PORT_UDP |
+						MLX5_RX_HASH_INNER;
 			resp.response_length += sizeof(resp.rss_caps);
 		}
 	} else {
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -307,7 +307,7 @@ enum mlx5_rx_hash_fields {
 	MLX5_RX_HASH_SRC_PORT_UDP	= 1 << 6,
 	MLX5_RX_HASH_DST_PORT_UDP	= 1 << 7,
 	/* Save bits for future fields */
-	MLX5_RX_HASH_INNER		= 1 << 31
+	MLX5_RX_HASH_INNER		= (1UL << 31),
 };
 
 struct mlx5_ib_create_qp_rss {
