Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BC720989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfA2UzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:55:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2UzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:55:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B70A514F18682;
        Tue, 29 Jan 2019 12:55:02 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:55:00 -0800 (PST)
Message-Id: <20190129.125500.154282464274712566.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Jan 2019 12:55:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Need to save away the IV across tls async operations, from Dave
   Watson.

2) Upon successful packet processing, we should liberate the SKB with
   dev_consume_skb{_irq}().  From Yang Wei.

3) Only apply RX hang workaround on effected macb chips, from Harini
   Katakam.

4) Dummy netdev need a proper namespace assigned to them, from Josh
   Elsasser.

5) Some paths of nft_compat run lockless now, and thus we need to use
   a proper refcnt_t.  From Florian Westphal.

6) Avoid deadlock in mlx5 by doing IRQ locking, from Moni Shoua.

7) netrom does not refcount sockets properly wrt. timers, fix that
   by using the sock timer API.  From Cong Wang.

8) Fix locking of inexact inserts of xfrm policies, from Florian
   Westphal.

9) Missing xfrm hash generation bump, also from Florian.

10) Missing of_node_put() in hns driver, from Yonglong Liu.

11) Fix DN_IFREQ_SIZE, from Johannes Berg.

12) ip6mr notifier is invoked during traversal of wrong table,
    from Nir Dotan.

13) TX promisc settings not performed correctly in qed, from Manish
    Chopra.

14) Fix OOB access in vhost, from Jason Wang.

Please pull, thanks a lot!

The following changes since commit 1fc7f56db7a7c467e46a5d2e2a009d2f337e0338:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2019-01-27 09:21:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to d07e1e0febe10b65eecd3205ad3bd1e999754887:

  MAINTAINERS: Add entry for XDP (eXpress Data Path) (2019-01-29 11:40:51 -0800)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Anders Roxell (1):
      netfilter: ipt_CLUSTERIP: fix warning unused variable cn

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix serdes irq setup going recursive

Aya Levin (1):
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Benedict Wong (1):
      xfrm: Make set-mark default behavior backward compatible

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Bodong Wang (1):
      Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager"

Cong Wang (1):
      netrom: switch to sock timer API

Dave Watson (2):
      net: tls: Save iv in tls_rec for async crypto requests
      net: tls: Fix deadlock in free_resources tx

David S. Miller (5):
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge tag 'mlx5-fixes-2019-01-25' of git://git.kernel.org/.../saeed/linux
      Merge branch 'hns-fixes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'qed-Bug-fixes'

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink_osf: add missing fmatch check

Florian Westphal (12):
      selftests: xfrm: add block rules with adjacent/overlapping subnets
      xfrm: policy: use hlist rcu variants on inexact insert, part 2
      xfrm: policy: increment xfrm_hash_generation on hash rebuild
      xfrm: policy: delete inexact policies from inexact list on hash rebuild
      xfrm: policy: fix reinsertion on node merge
      selftests: xfrm: alter htresh to trigger move of policies to hash table
      xfrm: policy: fix infinite loop when merging src-nodes
      xfrm: refine validation of template and selector families
      netfilter: nft_compat: use refcnt_t type for nft_xt reference count
      netfilter: nft_compat: make lists per netns
      netfilter: nft_compat: destroy function must not have side effects
      netfilter: ebtables: compat: un-break 32bit setsockopt when no rules are present

Harini Katakam (1):
      net: macb: Apply RXUBR workaround only to versions with errata

Jason Wang (1):
      vhost: fix OOB in get_rx_bufs()

Jesper Dangaard Brouer (1):
      MAINTAINERS: Add entry for XDP (eXpress Data Path)

Johannes Berg (1):
      decnet: fix DN_IFREQ_SIZE

Josh Elsasser (1):
      net: set default network namespace in init_dummy_netdev()

Manish Chopra (5):
      qed: Fix bug in tx promiscuous mode settings
      qed: Fix LACP pdu drops for VFs
      qed: Fix VF probe failure while FLR
      qed: Fix system crash in ll2 xmit
      qed: Fix stack out of bounds bug

Moni Shoua (1):
      net/mlx5: Take lock with IRQs disabled to avoid deadlock

Nir Dotan (1):
      ip6mr: Fix notifiers call on mroute_clean_tables()

Or Gerlitz (2):
      net/mlx5e: Move to use common phys port names for vport representors
      net/mlx5e: Unblock setting vid 0 for VFs through the uplink rep

Shay Agroskin (1):
      net/mlx5e: Fix wrong private flag usage causing checksum disable

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Tomonori Sakita (1):
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Yang Wei (8):
      net: i825xx: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: alteon: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: amd8111e: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: apple: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: ti: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: 8139cp: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
      net: caif: call dev_consume_skb_any when skb xmit done
      net: b44: replace dev_kfree_skb_xxx by dev_consume_skb_xxx for drop profiles

Yonglong Liu (3):
      net: hns: Fix for missing of_node_put() after of_parse_phandle()
      net: hns: Restart autoneg need return failed when autoneg off
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

 MAINTAINERS                                         |  18 ++++++++++
 drivers/net/caif/caif_serial.c                      |   5 +--
 drivers/net/dsa/mv88e6xxx/serdes.c                  |   2 +-
 drivers/net/ethernet/alteon/acenic.c                |   2 +-
 drivers/net/ethernet/altera/altera_msgdma.c         |   3 +-
 drivers/net/ethernet/amd/amd8111e.c                 |   2 +-
 drivers/net/ethernet/apple/bmac.c                   |   2 +-
 drivers/net/ethernet/broadcom/b44.c                 |   4 +--
 drivers/net/ethernet/cadence/macb.h                 |   3 ++
 drivers/net/ethernet/cadence/macb_main.c            |  28 +++++++++------
 drivers/net/ethernet/hisilicon/hns/hns_enet.c       |   5 +++
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c    |  16 +++++----
 drivers/net/ethernet/hisilicon/hns_mdio.c           |   2 +-
 drivers/net/ethernet/i825xx/82596.c                 |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c    |  25 +++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c   |  22 +++++-------
 drivers/net/ethernet/mellanox/mlx5/core/lag.c       |  21 +++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h |   2 ++
 drivers/net/ethernet/mellanox/mlx5/core/qp.c        |   5 +--
 drivers/net/ethernet/qlogic/qed/qed_dev.c           |   8 ++---
 drivers/net/ethernet/qlogic/qed/qed_l2.c            |  12 ++++++-
 drivers/net/ethernet/qlogic/qed/qed_l2.h            |   3 ++
 drivers/net/ethernet/qlogic/qed/qed_ll2.c           |  20 ++++++++---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c         |  10 ++++--
 drivers/net/ethernet/qlogic/qed/qed_vf.c            |  10 ++++++
 drivers/net/ethernet/realtek/8139cp.c               |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c      |   4 ++-
 drivers/net/ethernet/ti/cpmac.c                     |   2 +-
 drivers/vhost/net.c                                 |   3 +-
 drivers/vhost/scsi.c                                |   2 +-
 drivers/vhost/vhost.c                               |   7 ++--
 drivers/vhost/vhost.h                               |   4 ++-
 drivers/vhost/vsock.c                               |   2 +-
 include/net/tls.h                                   |   2 ++
 net/bridge/netfilter/ebtables.c                     |   9 +++--
 net/core/dev.c                                      |   3 ++
 net/decnet/dn_dev.c                                 |   2 +-
 net/ipv4/ip_vti.c                                   |  50 ++++++++++++++++++++++++++
 net/ipv4/netfilter/ipt_CLUSTERIP.c                  |   2 +-
 net/ipv6/ip6mr.c                                    |   7 ++--
 net/netfilter/ipvs/ip_vs_ctl.c                      |  12 +++++++
 net/netfilter/nfnetlink_osf.c                       |   4 +++
 net/netfilter/nft_compat.c                          | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 net/netrom/nr_timer.c                               |  20 +++++------
 net/rose/rose_route.c                               |   5 +++
 net/tls/tls_sw.c                                    |   6 +++-
 net/xfrm/xfrm_policy.c                              |  63 +++++++++++++++++----------------
 net/xfrm/xfrm_user.c                                |  13 ++++---
 tools/testing/selftests/net/xfrm_policy.sh          | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 50 files changed, 605 insertions(+), 195 deletions(-)
