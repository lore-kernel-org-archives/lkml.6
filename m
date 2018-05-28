Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163676AbeE1Ku2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163605AbeE1KuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        David Ahern <dsahern@gmail.com>, Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 176/496] mlxsw: spectrum: Treat IPv6 unregistered multicast as broadcast
Date: Mon, 28 May 2018 11:59:21 +0200
Message-Id: <20180528100327.289997278@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 9d45deb04c59b628b21fc5014aff4f9a1d38f969 ]

When multicast snooping is enabled, the Linux bridge resorts to flooding
unregistered multicast packets to all ports only in case it did not
detect a querier in the network.

The above condition is not reflected to underlying drivers, which is
especially problematic in IPv6 environments, as multicast snooping is
enabled by default and since neighbour solicitation packets might be
treated as unregistered multicast packets in case there is no
corresponding MDB entry.

Until the Linux bridge reflects its querier state to underlying drivers,
simply treat unregistered multicast packets as broadcast and allow them
to reach their destination.

Fixes: 9df552ef3e21 ("mlxsw: spectrum: Improve IPv6 unregistered multicast flooding")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -112,11 +112,11 @@ static const int mlxsw_sp_sfgc_bc_packet
 	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_NON_IP]	= 1,
 	[MLXSW_REG_SFGC_TYPE_IPV4_LINK_LOCAL]			= 1,
 	[MLXSW_REG_SFGC_TYPE_IPV6_ALL_HOST]			= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV6]	= 1,
 };
 
 static const int mlxsw_sp_sfgc_mc_packet_types[MLXSW_REG_SFGC_TYPE_MAX] = {
 	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV4]	= 1,
-	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV6]	= 1,
 };
 
 static const int *mlxsw_sp_packet_type_sfgc_types[] = {
