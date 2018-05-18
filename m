Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/hbIxfBbRTH8Vv81XB8Y7ivH207P4y/r/8Ri9ZO8aGjnGzCCHjUSBGdVoSyaGNd+4W+bc
ARC-Seal: i=1; a=rsa-sha256; t=1526631416; cv=none;
        d=google.com; s=arc-20160816;
        b=PjbO2BS5/2uIdDq/jws+99i4ayrReu0mlyjXhgi/jHysYF+uMZMftMFulJYAUVwrjk
         nX4XEE9zKh3wElm77SxyN08Cn6tZGht9NgpoUYBxJsyffS1Gp1MlxnGK5D2Vzl/HfUxb
         E46oCRWEYDh28wLJLhGFoBH+5G+7IiziQZ4gRHbz3/N7DSi10hCKTU/nsKTEzixoQtXz
         JgG0N9TzCWifeNQYygqV90FVRLgbigipEkBPxt7NRpKdlHaWWirv3c/Ok8OdHurgCTVe
         tUU+vz7Xlc18IiZ+C/qJxT3chY33AK+fLfc3bLRZaxlg/cHkmYquYfVEQ0+G1fTPJlG9
         jXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OVx7DIZ/BRL9dPuBWuHdj5XGkGjyVN0XS4jQibWmsyw=;
        b=i3JbKMVtKPCmIgPc7RzJgjNDDoiZredLromC4s7yCRz5BIkSrdFm/rPGLpzfPB0a3Q
         8LRtGR3/2dXnL+9PDxDaiGqMv5F4kKrD1D7/PZf6GPNrXKaGOYoijd4KZ+y86i2vOTS8
         ZhCXpqvPk05XNXGyBp3jPzx2v5iatVQb0fMVT8lKaEFiA76CgpKq8PNJmi21xEvYYfyv
         EfTgd3naQR24Rb/TKou6LIV/Jgu63fyOf8wE1C4af7zvG5u2VmoomaW5xclt+56B9b7j
         r9OUivNd/B0UPcHivb3LBsUAOfovBctAbV+o+dkvIePusJMn26fuP2VvWl9o7qF0XgxM
         lZmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hHYhVUZX;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hHYhVUZX;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adi Nissim <adin@mellanox.com>,
	Ariel Almog <ariela@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 12/55] net/mlx5: E-Switch, Include VF RDMA stats in vport statistics
Date: Fri, 18 May 2018 10:15:08 +0200
Message-Id: <20180518081458.035189005@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789064433224320?=
X-GMAIL-MSGID: =?utf-8?q?1600789064433224320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adi Nissim <adin@mellanox.com>

[ Upstream commit 88d725bbb43cd63a40c8ef70dd373f1d38ead2e3 ]

The host side reporting of VF vport statistics didn't include the VF
RDMA traffic.

Fixes: 3b751a2a418a ("net/mlx5: E-Switch, Introduce get vf statistics")
Signed-off-by: Adi Nissim <adin@mellanox.com>
Reported-by: Ariel Almog <ariela@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2143,26 +2143,35 @@ int mlx5_eswitch_get_vport_stats(struct
 	memset(vf_stats, 0, sizeof(*vf_stats));
 	vf_stats->rx_packets =
 		MLX5_GET_CTR(out, received_eth_unicast.packets) +
+		MLX5_GET_CTR(out, received_ib_unicast.packets) +
 		MLX5_GET_CTR(out, received_eth_multicast.packets) +
+		MLX5_GET_CTR(out, received_ib_multicast.packets) +
 		MLX5_GET_CTR(out, received_eth_broadcast.packets);
 
 	vf_stats->rx_bytes =
 		MLX5_GET_CTR(out, received_eth_unicast.octets) +
+		MLX5_GET_CTR(out, received_ib_unicast.octets) +
 		MLX5_GET_CTR(out, received_eth_multicast.octets) +
+		MLX5_GET_CTR(out, received_ib_multicast.octets) +
 		MLX5_GET_CTR(out, received_eth_broadcast.octets);
 
 	vf_stats->tx_packets =
 		MLX5_GET_CTR(out, transmitted_eth_unicast.packets) +
+		MLX5_GET_CTR(out, transmitted_ib_unicast.packets) +
 		MLX5_GET_CTR(out, transmitted_eth_multicast.packets) +
+		MLX5_GET_CTR(out, transmitted_ib_multicast.packets) +
 		MLX5_GET_CTR(out, transmitted_eth_broadcast.packets);
 
 	vf_stats->tx_bytes =
 		MLX5_GET_CTR(out, transmitted_eth_unicast.octets) +
+		MLX5_GET_CTR(out, transmitted_ib_unicast.octets) +
 		MLX5_GET_CTR(out, transmitted_eth_multicast.octets) +
+		MLX5_GET_CTR(out, transmitted_ib_multicast.octets) +
 		MLX5_GET_CTR(out, transmitted_eth_broadcast.octets);
 
 	vf_stats->multicast =
-		MLX5_GET_CTR(out, received_eth_multicast.packets);
+		MLX5_GET_CTR(out, received_eth_multicast.packets) +
+		MLX5_GET_CTR(out, received_ib_multicast.packets);
 
 	vf_stats->broadcast =
 		MLX5_GET_CTR(out, received_eth_broadcast.packets);
