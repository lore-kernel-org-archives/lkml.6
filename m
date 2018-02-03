Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeBCBFC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 20:05:02 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45454 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeBCBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 20:04:46 -0500
Date: Fri, 02 Feb 2018 20:04:45 -0500 (EST)
Message-Id: <20180202.200445.403241076450005293.davem@davemloft.net>
To: torvalds@linux-foundation.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) The bnx2x can hang if you give it a GSO packet with a segment size
   which is too big for the hardware, detect and drop in this case.
   From Daniel Axtens.

2) Fix some overflows and pointer leaks in xtables, from Dmitry
   Vyukov.

3) Missing RCU locking in igmp, from Eric Dumazet.

4) Fix RX checksum handling on r8152, it can only checksum UDP and
   TCP packets.  From Hayes Wang.

5) Minor pacing tweak to TCP BBR congestion control, from Neal
   Cardwell.

6) Missing RCU annotations in cls_u32, from Paolo Abeni.

Please pull, thanks a lot!
      

The following changes since commit 255442c93843f52b6891b21d0b485bf2c97f93c3:

  Merge tag 'docs-4.16' of git://git.lwn.net/linux (2018-01-31 19:25:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to edbe69ef2c90fc86998a74b08319a01c508bd497:

  Revert "defer call to mem_cgroup_sk_alloc()" (2018-02-02 19:49:31 -0500)

----------------------------------------------------------------
Alexander Monakov (1):
      net: pxa168_eth: add netconsole support

Arnd Bergmann (3):
      net: cxgb4: avoid memcpy beyond end of source buffer
      net: qed: use correct strncpy() size
      net: qlge: use memmove instead of skb_copy_to_linear_data

Christian Brauner (1):
      rtnetlink: remove check for IFLA_IF_NETNSID

Colin Ian King (4):
      be2net: remove redundant initialization of 'head' and pointer txq
      net: jme: remove unused initialization of 'rxdesc'
      lan78xx: remove redundant initialization of pointer 'phydev'
      vmxnet3: remove redundant initialization of pointer 'rq'

Daniel Axtens (2):
      net: create skb_gso_validate_mac_len()
      bnx2x: disable GSO where gso_size is too big for hardware

David S. Miller (3):
      Merge branch 'bnx2x-disable-GSO-on-too-large-packets'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'r8152-fix-rx-issues'

Desnes Augusto Nunes do Rosario (1):
      ibmvnic: fix firmware version when no firmware level has been provided by the VIOS server

Dmitry Vyukov (3):
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: x_tables: fix pointer leaks to userspace
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()

Ed Swierk (1):
      openvswitch: Remove padding from packet before L3+ conntrack processing

Edwin Peer (1):
      nfp: fix TLV offset calculation

Eric Dumazet (3):
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}
      net: igmp: add a missing rcu locking section
      soreuseport: fix mem leak in reuseport_add_sock()

Geert Uytterhoeven (2):
      net: bridge: Fix uninitialized error in br_fdb_sync_static()
      inet: Avoid unitialized variable warning in inet_unhash()

Hayes Wang (2):
      r8152: fix wrong checksum status for received IPv4 packets
      r8152: set rx mode early when linking on

Jiri Pirko (1):
      rocker: fix possible null pointer dereference in rocker_router_fib_event_work

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix wraparound in hash:*net* types

Neal Cardwell (1):
      tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Paolo Abeni (2):
      netfilter: on sockopt() acquire sock lock only in the required scope
      cls_u32: add missing RCU annotation.

Roman Gushchin (1):
      Revert "defer call to mem_cgroup_sk_alloc()"

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 18 ++++++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h    |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c       |  3 +--
 drivers/net/ethernet/ibm/ibmvnic.c                |  6 +++++-
 drivers/net/ethernet/jme.c                        |  2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c         | 12 ++++++++++++
 drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.c |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c       |  6 ++----
 drivers/net/ethernet/qlogic/qlge/qlge_main.c      |  3 +--
 drivers/net/ethernet/rocker/rocker_main.c         | 18 +++++++++---------
 drivers/net/usb/lan78xx.c                         |  2 +-
 drivers/net/usb/r8152.c                           | 13 ++++++-------
 drivers/net/vmxnet3/vmxnet3_drv.c                 |  6 ++----
 include/linux/skbuff.h                            | 16 ++++++++++++++++
 mm/memcontrol.c                                   | 14 ++++++++++++++
 net/bridge/br_fdb.c                               |  2 +-
 net/core/rtnetlink.c                              |  3 ---
 net/core/skbuff.c                                 | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 net/core/sock.c                                   |  5 +----
 net/core/sock_reuseport.c                         | 35 ++++++++++++++++++++---------------
 net/ipv4/igmp.c                                   |  4 ++++
 net/ipv4/inet_connection_sock.c                   |  1 -
 net/ipv4/inet_hashtables.c                        |  6 ++----
 net/ipv4/ip_sockglue.c                            | 14 ++++----------
 net/ipv4/netfilter/ipt_CLUSTERIP.c                | 16 +++++++++++++---
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c    |  6 +++++-
 net/ipv4/tcp_bbr.c                                |  6 +++---
 net/ipv6/ipv6_sockglue.c                          | 17 +++++------------
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c    | 18 ++++++++++++------
 net/netfilter/ipset/ip_set_hash_ipportnet.c       | 26 +++++++++++++-------------
 net/netfilter/ipset/ip_set_hash_net.c             |  9 ++++-----
 net/netfilter/ipset/ip_set_hash_netiface.c        |  9 ++++-----
 net/netfilter/ipset/ip_set_hash_netnet.c          | 28 ++++++++++++++--------------
 net/netfilter/ipset/ip_set_hash_netport.c         | 19 ++++++++++---------
 net/netfilter/ipset/ip_set_hash_netportnet.c      | 35 ++++++++++++++++++-----------------
 net/netfilter/x_tables.c                          |  9 +++++++--
 net/netfilter/xt_IDLETIMER.c                      |  1 +
 net/netfilter/xt_LED.c                            |  1 +
 net/netfilter/xt_limit.c                          |  3 +--
 net/netfilter/xt_nfacct.c                         |  1 +
 net/netfilter/xt_statistic.c                      |  1 +
 net/openvswitch/conntrack.c                       | 34 ++++++++++++++++++++++++++++++++++
 net/sched/cls_u32.c                               | 12 +++++++-----
 net/sched/sch_tbf.c                               | 10 ----------
 44 files changed, 326 insertions(+), 191 deletions(-)
