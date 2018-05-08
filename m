Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr9xmfWeryaf5SWL3IAmBOZQdbN7NErI1RegIZz9sc0TyndPz6QLerHjJR7v3nlmiHW3ovU
ARC-Seal: i=1; a=rsa-sha256; t=1525767184; cv=none;
        d=google.com; s=arc-20160816;
        b=o17S6Y5prg4xgmAJt6FYaLN0WQHlwe+0SvtDZydIILn0UfaN7XrzDOWe/ixasc7hu5
         qJhKGkrIn0I3s2tZpuxAhXBgO66algdYuo4Y7gwDAHZQDPB7r0r/NYl5m5fzroXG3zhV
         /3U0OQhw9TV8GSMDcVdObDsGOJwrRCpc+c9N8HXctqoVLBtIqQkcEE078+QE7x7che11
         pNVEzfH+QyynPaEC8iq4ORrhx1v6qAERlcpq+sSJZA3fIuZAoYczuFXal9nG9yT/V5Ea
         ZORU6gif4z3tAJH/BjSZoZas4mf0K0fLA2qcnKQBN6POcihs7kHZMc1muGvCwUcy5Fbd
         Eq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0YFOuNHOr5Qt/3j4++yEMCUc9/YgUThsdP9YON5KtuM=;
        b=LgVLxTa5s1BqvLp+/40HSJzLB9vgJY+ij9oOhhbdQ4g7gjAEKGaNOI60vwfy+SJbpw
         udJAX8cUV2lPOQ7kq70XpYlrxEnlqv9l+T3SPqJFojps2bntDGrSDuSL4lHGQ+a9HbCE
         a6+aWLgUFrL848fYP4eGGZ1GZkcDyPovJBDO8RcpqGRddVI1MG+1rnnYgXbKNywtqE/x
         tdvjCYbYH66gWt7XuXshKlM9sTfTu/Xom5N4/V0/CXQpd8Y+YaEwUidY0Aqz3ElY3LGQ
         eueLEImcEF0VQB4/faIYBJjkAFU56LZPjtLg+8NhuSvdlYtgiMnNfhAGTniYiVS5k9Kb
         lgYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LN2cfHXp;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LN2cfHXp;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 21/52] RDMA/mlx4: Add missed RSS hash inner header flag
Date: Tue,  8 May 2018 10:10:19 +0200
Message-Id: <20180508073930.887257070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882851614739618?=
X-GMAIL-MSGID: =?utf-8?q?1599882851614739618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 4f9ca2d8686ecfdd40ca4f0294a3d94f83f05cea upstream.

Despite being advertised to user space application, the RSS inner
header flag was filtered by checks at the beginning of QP creation
routine.

Cc: <stable@vger.kernel.org> # 4.15
Fixes: 4d02ebd9bbbd ("IB/mlx4: Fix RSS hash fields restrictions")
Fixes: 07d84f7b6adf ("IB/mlx4: Add support to RSS hash for inner headers")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/qp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -673,7 +673,8 @@ static int set_qp_rss(struct mlx4_ib_dev
 					  MLX4_IB_RX_HASH_SRC_PORT_TCP	|
 					  MLX4_IB_RX_HASH_DST_PORT_TCP	|
 					  MLX4_IB_RX_HASH_SRC_PORT_UDP	|
-					  MLX4_IB_RX_HASH_DST_PORT_UDP)) {
+					  MLX4_IB_RX_HASH_DST_PORT_UDP  |
+					  MLX4_IB_RX_HASH_INNER)) {
 		pr_debug("RX Hash fields_mask has unsupported mask (0x%llx)\n",
 			 ucmd->rx_hash_fields_mask);
 		return (-EOPNOTSUPP);
