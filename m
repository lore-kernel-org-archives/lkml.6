Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3010CECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C014D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeJ0HvX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:51:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJ0HvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:51:23 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 00853148CA300;
        Fri, 26 Oct 2018 16:12:25 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:12:25 -0700 (PDT)
Message-Id: <20181026.161225.824107169390673304.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Oct 2018 16:12:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


What better way to start off a weekend than with some networking
bug fixes:

1) net namespace leak in dump filtering code of ipv4 and ipv6, fixed
   by David Ahern and Bjørn Mork.

2) Handle bad checksums from hardware when using CHECKSUM_COMPLETE
   properly in UDP, from Sean Tranchetti.

3) Remove TCA_OPTIONS from policy validation, it turns out we don't
   consistently use nested attributes for this across all packet
   schedulers.  From David Ahern.

4) Fix SKB corruption in cadence driver, from Tristram Ha.

5) Fix broken WoL handling in r8169 driver, from Heiner Kallweit.

6) Fix OOPS in pneigh_dump_table(), from Eric Dumazet.

Please pull, thanks!

The following changes since commit 01aa9d518eae8a4d75cd3049defc6ed0b6d0a658:

  Merge tag 'docs-4.20' of git://git.lwn.net/linux (2018-10-24 18:01:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to aab456dfa404f3a16d6f1780e62a6a8533c4d008:

  net/neigh: fix NULL deref in pneigh_dump_table() (2018-10-26 16:03:51 -0700)

----------------------------------------------------------------
Andrew Lunn (1):
      net: phy: genphy_10g_driver: Avoid NULL pointer dereference

Anirudh Venkataramanan (7):
      ice: Make ice_msix_clean_rings static
      ice: Change device ID define names to align with branding string
      ice: Update expected FW version
      ice: Use capability count returned by the firmware
      ice: Introduce ice_dev_onetime_setup
      ice: Allocate VF interrupts and set queue map
      ice: Poll for link status change

Bjørn Mork (1):
      net/{ipv4,ipv6}: Do not put target net if input nsid is invalid

Bryan Whitehead (1):
      lan743x: Remove SPI dependency from Microchip group.

Dan Carpenter (1):
      octeontx2-af: Copy the right amount of memory

David Ahern (6):
      net/ipv4: Put target net when address dump fails due to bad attributes
      net/ipv6: Put target net when address dump fails due to bad attributes
      net: Don't return invalid table id error when dumping all families
      net: rtnl_dump_all needs to propagate error from dumpit function
      net: sched: Remove TCA_OPTIONS from policy
      net/ipv6: Allow onlink routes to have a device mismatch if it is the default route

David S. Miller (2):
      Merge branch 'route-dump-filter-fixes'
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/net-queue

Eric Dumazet (2):
      drivers: net: remove <net/busy_poll.h> inclusion when not needed
      net/neigh: fix NULL deref in pneigh_dump_table()

Hangbin Liu (1):
      bridge: do not add port to router list when receives query with source 0.0.0.0

Heiner Kallweit (1):
      r8169: fix broken Wake-on-LAN from S5 (poweroff)

Karsten Graul (1):
      net/smc: fix smc_buf_unuse to use the lgr pointer

Mike Manning (1):
      net: allow traceroute with a specified interface in a vrf

Sean Tranchetti (1):
      net: udp: fix handling of CHECKSUM_COMPLETE packets

Shiju Jose (1):
      net: hns3: Fix for warning uninitialized symbol hw_err_lst3

Stefano Brivio (1):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers are called

Tristram Ha (1):
      net: ethernet: cadence: fix socket buffer corruption problem

Wei Yongjun (1):
      octeontx2-af: Use GFP_ATOMIC under spin lock

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c               |   1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c        |   1 -
 drivers/net/ethernet/cadence/macb_main.c               |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  10 +++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c            |   1 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c            |   1 -
 drivers/net/ethernet/intel/ice/ice_common.c            |  52 +++++++++++++++++++--------------------------
 drivers/net/ethernet/intel/ice/ice_common.h            |   9 +++-----
 drivers/net/ethernet/intel/ice/ice_controlq.h          |   5 ++---
 drivers/net/ethernet/intel/ice/ice_devids.h            |   6 +++---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h        |   8 +++++++
 drivers/net/ethernet/intel/ice/ice_lib.c               |   3 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h               |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c              | 116 ++++++++++++++++++++++++-----------------------------------------------------------------------------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c       |  15 +++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe.h               |   1 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c         |   1 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c             |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c        |   1 -
 drivers/net/ethernet/microchip/Kconfig                 |   1 -
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c       |   1 -
 drivers/net/ethernet/realtek/r8169.c                   |   9 ++++++--
 drivers/net/phy/phy-c45.c                              |   2 +-
 include/net/ip_fib.h                                   |   1 +
 net/bridge/br_multicast.c                              |  10 ++++++++-
 net/core/datagram.c                                    |   5 +++--
 net/core/neighbour.c                                   |   4 ++--
 net/core/rtnetlink.c                                   |   6 ++++--
 net/ipv4/devinet.c                                     |  14 ++++++++-----
 net/ipv4/fib_frontend.c                                |   4 ++++
 net/ipv4/ipmr.c                                        |   3 +++
 net/ipv4/udp.c                                         |  24 +++++++++++++++++----
 net/ipv6/addrconf.c                                    |  15 +++++++------
 net/ipv6/ip6_checksum.c                                |  20 ++++++++++++++++--
 net/ipv6/ip6_fib.c                                     |   3 +++
 net/ipv6/ip6mr.c                                       |   3 +++
 net/ipv6/ndisc.c                                       |   3 +--
 net/ipv6/route.c                                       |   2 ++
 net/ipv6/udp.c                                         |   2 +-
 net/sched/sch_api.c                                    |   1 -
 net/smc/smc_core.c                                     |  25 +++++++++++-----------
 tools/testing/selftests/net/fib-onlink-tests.sh        |  14 ++++++-------
 43 files changed, 205 insertions(+), 206 deletions(-)
