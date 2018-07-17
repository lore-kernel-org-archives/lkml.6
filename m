Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ABECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B621476
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxSnJT/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5B621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGQMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeGQMjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:05 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CEB20C10;
        Tue, 17 Jul 2018 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829204;
        bh=yOijbTG+PrUJ8MkectQYAr861pUk5eKHEuXj2ecb8vc=;
        h=From:To:Cc:Subject:Date:From;
        b=UxSnJT/8/Edg0ZJOAZpZDNAwYwJL8NNpHLX93/KUW5F5Ym6SJmIzHxLNSJVYBSxGz
         IBXFPTU9L0GP8rj7l4i5MgEYHzBT68q3ynYWyZjJ8afBG9wW3/NKYAUkCxGGh3NdvB
         1Z7WOqgURH7wRhHcA8ZdkLiEk7ilSTgHUWvH8dxo=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
Date:   Tue, 17 Jul 2018 05:06:34 -0700
Message-Id: <20180717120651.15748-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Nikita Leshenko reported that neighbor entries in one namespace can
evict neighbor entries in another. The problem is that the neighbor
tables have entries across all namespaces without separate accounting
and with global limits on when to scan for entries to evict.

Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
namespace and making the accounting and threshold limits per namespace.

David Ahern (17):
  net/ipv4: rename ipv4_neigh_lookup to ipv4_dst_neigh_lookup
  net/neigh: export neigh_find_table
  net/ipv4: wrappers for arp table references
  net/ipv4: Remove open coded use of arp table
  net/ipv6: wrappers for neighbor table references
  net/ipv6: Remove open coded use of neighbor table
  drivers/net: remove open coding of neighbor tables
  net: Remove nd_tbl from ipv6 stub
  net: Remove arp_tbl and nd_tbl from headers
  net: Add key_len to neighbor constructor
  net: Change neigh_table_init and neigh_table_clear signature
  net/neigh: Change neigh_xmit to take an address family
  net/neighbor: Convert internal functions away from neigh_tables
  net/ipv4: Convert arp table to per namespace
  net/ipv6: Convert neighbor table to per-namespace
  net/decnet: Move neighbor table to per-namespace
  net/neighbor: Remove neigh_tables and NEIGH enum

 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  35 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  11 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  27 ++--
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   8 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 drivers/net/ethernet/rocker/rocker_main.c          |   4 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |   2 +-
 drivers/net/vrf.c                                  |   4 +-
 drivers/net/vxlan.c                                |  10 +-
 include/net/addrconf.h                             |   1 -
 include/net/arp.h                                  |  25 +++-
 include/net/ndisc.h                                |  75 +++++++++-
 include/net/neighbour.h                            |  17 +--
 include/net/net_namespace.h                        |   3 +
 include/net/netns/ipv4.h                           |   1 +
 include/net/netns/ipv6.h                           |   1 +
 net/atm/clip.c                                     |  14 +-
 net/bridge/br_arp_nd_proxy.c                       |   4 +-
 net/core/filter.c                                  |   3 +-
 net/core/neighbour.c                               | 115 +++++++++-----
 net/decnet/dn_neigh.c                              |   8 +-
 net/ieee802154/6lowpan/tx.c                        |   2 +-
 net/ipv4/arp.c                                     | 130 +++++++++-------
 net/ipv4/devinet.c                                 |   8 +-
 net/ipv4/fib_semantics.c                           |   2 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/route.c                                   |  12 +-
 net/ipv6/addrconf.c                                |  16 +-
 net/ipv6/af_inet6.c                                |   1 -
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/ndisc.c                                   | 165 +++++++++++----------
 net/ipv6/route.c                                   |  12 +-
 net/mpls/af_mpls.c                                 |  33 ++---
 net/mpls/mpls_iptunnel.c                           |   6 +-
 net/netfilter/nf_flow_table_ip.c                   |   4 +-
 net/netfilter/nft_fwd_netdev.c                     |   6 +-
 37 files changed, 467 insertions(+), 320 deletions(-)

-- 
2.11.0

