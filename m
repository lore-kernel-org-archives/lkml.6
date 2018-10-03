Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF38EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A0206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2A0206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJDEsK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:48:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJDEsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:48:10 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8D53B140FF641;
        Wed,  3 Oct 2018 14:57:57 -0700 (PDT)
Date:   Wed, 03 Oct 2018 14:57:56 -0700 (PDT)
Message-Id: <20181003.145756.2159165162231604122.davem@davemloft.net>
To:     gregkh@linux-foundation.org
CC:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Oct 2018 14:57:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, a bunch of stuff got queued up while I was moving last week, so
this is larger than I would like this late in the game.

Nothing super dangerous or scary though, just lots of simpler fixes:

1) Prefix length validation in xfrm layer, from Steffen Klassert.

2) TX status reporting fix in mac80211, from Andrei Otcheretianski.

3) Fix hangs due to TX_DROP in mac80211, from Bob Copeland.

4) Fix DMA error regression in b43, from Larry Finger.

5) Add input validation to xenvif_set_hash_mapping(), from Jan Beulich.

6) SMMU unmapping fix in hns driver, from Yunsheng Lin.

7) Bluetooh crash in unpairing on SMP, from Matias Karhumaa.

8) WoL handling fixes in the phy layer, from Heiner Kallweit.

9) Fix deadlock in bonding, from Mahesh Bandewar.

10) Fill ttl inherit infor in vxlan driver, from Hangbin Liu.

11) Fix TX timeouts during netpoll, from Michael Chan.

12) RXRPC layer fixes from David Howells.

13) Another batch of ndo_poll_controller() removals to deal with
    excessive resource consumption during load.  From Eric Dumazet.

14) Fix a specific TIPC failure secnario, from LUU Duc Canh.

15) Really disable clocks in r8169 during suspend so that low
    power states can actually be reached.

16) Fix SYN backlog lockdep issue in tcp and dccp, from Eric Dumazet.

17) Fix RCU locking in netpoll SKB send, which shows up in bonding,
    from Dave Jones.

18) Fix TX stalls in r8169, from Heiner Kallweit.

19) Fix locksup in nfp due to control message storms, from Jakub
    Kicinski.

20) Various rmnet bug fixes from Subash Abhinov Kasiviswanathan and
    Sean Tranchetti.

21) Fix use after free in ip_cmsg_recv_dstaddr(), from Eric Dumazet.

Please pull, thanks a lot!

The following changes since commit 846e8dd47c264e0b359afed28ea88e0acdee6818:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-09-25 18:14:14 +0200)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 4233cfe6ec4683497d7318f55ce7617e97f2e610:

  ixgbe: check return value of napi_complete_done() (2018-10-03 14:40:32 -0700)

----------------------------------------------------------------
Alaa Hleihel (1):
      net/mlx5e: Avoid unbounded peer devices when unpairing TC hairpin rules

Alex Xu (Hello71) (1):
      r8169: always autoneg on resume

Andrei Otcheretianski (3):
      mac80211: Always report TX status
      mac80211: Don't wake up from PS for offchannel TX
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Andrew Lunn (1):
      net: phy: sfp: Fix unregistering of HWMON SFP device

Bob Copeland (1):
      mac80211: fix pending queue hang due to TX_DROP

Colin Ian King (2):
      qed: fix spelling mistake "toogle" -> "toggle"
      wimax/i2400m: fix spelling mistake "not unitialized" -> "uninitialized"

Dan Carpenter (1):
      net: sched: act_ipt: check for underflow in __tcf_ipt_init()

Dave Jones (1):
      bond: take rcu lock in netpoll_send_skb_on_dev

David Ahern (3):
      netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev
      net/ipv6: Remove extra call to ip6_convert_metrics for multipath case
      rtnetlink: Fail dump if target netnsid is invalid

David Howells (8):
      rxrpc: Remove dup code from rxrpc_find_connection_rcu()
      rxrpc: Fix checks as to whether we should set up a new call
      rxrpc: Fix RTT gathering
      rxrpc: Emit BUSY packets when supposed to rather than ABORTs
      rxrpc: Improve up-front incoming packet checking
      rxrpc: Make service call handling more robust
      rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
      rxrpc: Fix error distribution

David S. Miller (16):
      Merge branch 'xen-netback-hash'
      Revert "net: phy: fix WoL handling when suspending the PHY"
      Merge branch 'net-phy-fix-WoL-handling-when-suspending-the-PHY'
      Merge branch 's390-qeth-fixes'
      Merge tag 'mac80211-for-davem-2018-09-27' of git://git.kernel.org/.../jberg/mac80211
      Merge branch 'netpoll-second-round-of-fixes'
      Merge tag 'rxrpc-fixes-20180928' of git://git.kernel.org/.../dhowells/linux-fs
      Merge branch 'ieee802154-for-davem-2018-09-28' of git://git.kernel.org/.../sschmidt/wpan
      Merge branch 'net-usb-Check-for-Wake-on-LAN-modes'
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge branch 'for-upstream' of git://git.kernel.org/.../bluetooth/bluetooth
      Merge branch 'tun-races'
      Merge tag 'wireless-drivers-for-davem-2018-10-01' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'rmnet-fixes'
      Merge tag 'mlx5-fixes-2018-10-01' of git://git.kernel.org/.../saeed/linux

Eran Ben Elisha (1):
      net/mlx5: E-Switch, Fix out of bound access when setting vport rate

Eric Dumazet (18):
      netpoll: do not test NAPI_STATE_SCHED in poll_one_napi()
      hinic: remove ndo_poll_controller
      ehea: remove ndo_poll_controller
      net: hns: remove ndo_poll_controller
      virtio_net: remove ndo_poll_controller
      qlcnic: remove ndo_poll_controller
      qlogic: netxen: remove ndo_poll_controller
      net: ena: remove ndo_poll_controller
      sfc: remove ndo_poll_controller
      sfc-falcon: remove ndo_poll_controller
      ibmvnic: remove ndo_poll_controller
      tcp/dccp: fix lockdep issue when SYN is backlogged
      tun: remove unused parameters
      tun: initialize napi_mutex unconditionally
      tun: napi flags belong to tfile
      inet: make sure to grab rcu_read_lock before using ireq->ireq_opt
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()

Felix Fietkau (1):
      mac80211: allocate TXQs for active monitor interfaces

Flavio Leitner (2):
      netfilter: xt_socket: check sk before checking for netns.
      Revert "openvswitch: Fix template leak in error cases."

Florian Fainelli (8):
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      lan78xx: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes
      net: systemport: Fix wake-up interrupt race during resume

Florian Westphal (1):
      netfilter: avoid erronous array bounds warning

Gustavo A. R. Silva (1):
      sctp: fix fall-through annotation

Hangbin Liu (1):
      vxlan: fill ttl inherit info

Hans de Goede (1):
      r8169: Disable clk during suspend / resume

Heiner Kallweit (4):
      net: phy: fix WoL handling when suspending the PHY
      net: core: add member wol_enabled to struct net_device
      net: phy: fix WoL handling when suspending the PHY
      r8169: fix network stalls due to missing bit TXCFG_AUTO_FIFO

Jakub Kicinski (1):
      nfp: avoid soft lockups under control message storm

Jan Beulich (3):
      xen-netback: fix input validation in xenvif_set_hash_mapping()
      xen-netback: validate queue numbers in xenvif_set_hash_mapping()
      xen-netback: handle page straddling in xenvif_set_hash_mapping()

Jean Delvare (1):
      s390: qeth: Fix potential array overrun in cmd/rc lookup

Jianbo Liu (1):
      net/mlx5e: Set vlan masks for all offloaded TC rules

Johannes Berg (2):
      mac80211: TDLS: fix skb queue/priority assignment
      netlink: fix typo in nla_parse_nested() comment

Jouni Malinen (1):
      cfg80211: Address some corner cases in scan result channel updating

LUU Duc Canh (2):
      tipc: fix failover problem
      tipc: ignore STATE_MSG on wrong link session

Larry Finger (1):
      b43: fix DMA error related regression with proprietary firmware

Maciej W. Rozycki (1):
      declance: Fix continuation with the adapter identification message

Maciej ¯enczykowski (1):
      net-tcp: /proc/sys/net/ipv4/tcp_probe_interval is a u32 not int

Mahesh Bandewar (3):
      bonding: pass link-local packets to bonding master also.
      bonding: avoid possible dead-lock
      bonding: fix warning message

Martin Willi (3):
      mac80211_hwsim: fix locking when iterating radios during ns exit
      mac80211_hwsim: fix race in radio destruction from netlink notifier
      mac80211_hwsim: do not omit multicast announce of first added radio

Masashi Honma (2):
      nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
      nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds

Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

Michael Chan (1):
      bnxt_en: Fix TX timeout during netpoll.

Michal Simek (1):
      net: macb: Clean 64b dma addresses if they are not detected

Nathan Chancellor (5):
      qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
      qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
      qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
      qed: Avoid constant logical operation warning in qed_vf_pf_acquire
      qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt

Parthasarathy Bhuvaragan (3):
      tipc: fix flow control accounting for implicit connect
      tipc: reset bearer if device carrier not ok
      tipc: lock wakeup & inputq at tipc_link_reset()

Pavel Machek (1):
      iwlwifi: 1000: set the TFD queue size

Randy Dunlap (1):
      cfg80211: fix reg_query_regdb_wmm kernel-doc

Rickard x Andersson (1):
      net: fec: fix rare tx timeout

Sean Tranchetti (2):
      xfrm: validate template mode
      net: qualcomm: rmnet: Skip processing loopback packets

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Song Liu (1):
      ixgbe: check return value of napi_complete_done()

Sowmini Varadhan (2):
      xfrm: reset transport header back to network header after all input transforms ahave been applied
      xfrm: reset crypto_done when iterating over multiple input xfrms

Stanislaw Gruszka (1):
      mt76x0: fix remove_interface

Stefan Agner (1):
      netfilter: nft_osf: use enum nft_data_types for nft_validate_register_store

Steffen Klassert (2):
      xfrm: Validate address prefix lengths in the xfrm selector.
      xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.

Stephen Hemminger (1):
      MAINTAINERS: change bridge maintainers

Subash Abhinov Kasiviswanathan (2):
      net: qualcomm: rmnet: Fix incorrect allocation flag in transmit
      net: qualcomm: rmnet: Fix incorrect allocation flag in receive path

Sudarsana Reddy Kalluru (2):
      Update maintainers for bnx2/bnx2x/qlge/qlcnic drivers.
      qed: Fix shmem structure inconsistency between driver and the mfw.

Taehee Yoo (1):
      netfilter: nft_set_rbtree: add missing rb_erase() in GC routine

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig

Xue Liu (1):
      ieee802154: mcr20a: Replace magic number with constants

Yuan-Chi Pang (1):
      mac80211: fix TX status reporting for ieee80211s

YueHaibing (1):
      ieee802154: Use kmemdup instead of duplicating it in ca8210_test_int_driver_write

Yunsheng Lin (1):
      net: hns: fix for unmapping problem when SMMU is on

zhong jiang (4):
      netfilter: conntrack: get rid of double sizeof
      ieee802154: remove unecessary condition check before debugfs_remove_recursive
      ieee802154: ca8210: remove redundant condition check before debugfs_remove
      s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its function

 Documentation/networking/ip-sysctl.txt               |  2 +-
 MAINTAINERS                                          |  8 ++++----
 drivers/net/bonding/bond_main.c                      | 65 +++++++++++++++++++++++++++++++++++++----------------------------
 drivers/net/ethernet/amazon/ena/ena_netdev.c         | 22 ----------------------
 drivers/net/ethernet/amd/declance.c                  | 10 ++++++----
 drivers/net/ethernet/broadcom/bcmsysport.c           | 28 +++++++++++-----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            | 13 ++++++++++---
 drivers/net/ethernet/cadence/macb_main.c             |  1 +
 drivers/net/ethernet/freescale/fec_main.c            |  8 ++++----
 drivers/net/ethernet/hisilicon/hns/hnae.c            |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        | 48 +++++++++++++++++++-----------------------------
 drivers/net/ethernet/huawei/hinic/hinic_main.c       | 20 --------------------
 drivers/net/ethernet/ibm/ehea/ehea_main.c            | 14 --------------
 drivers/net/ethernet/ibm/ibmvnic.c                   | 16 ----------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        | 12 +++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en.h         |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h      |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c      | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c    |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c   |  5 ++++-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c  | 17 ++++++++++++-----
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 23 -----------------------
 drivers/net/ethernet/qlogic/qed/qed_hsi.h            |  1 +
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c          |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.c           |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_roce.c           | 15 ++++-----------
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c    |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c             |  5 ++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h          |  8 +++++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c  |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h  |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h       |  3 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c       | 12 ++++++------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c     | 45 ---------------------------------------------
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c |  7 +++++--
 drivers/net/ethernet/realtek/r8169.c                 | 32 ++++++++++++++++----------------
 drivers/net/ethernet/sfc/efx.c                       | 26 --------------------------
 drivers/net/ethernet/sfc/falcon/efx.c                | 26 --------------------------
 drivers/net/ieee802154/adf7242.c                     |  3 +--
 drivers/net/ieee802154/ca8210.c                      |  6 ++----
 drivers/net/ieee802154/mcr20a.c                      |  8 ++++----
 drivers/net/phy/phy_device.c                         | 12 +++++++++---
 drivers/net/phy/sfp.c                                |  7 +++++--
 drivers/net/tun.c                                    | 37 +++++++++++++++++++++----------------
 drivers/net/usb/asix_common.c                        |  3 +++
 drivers/net/usb/ax88179_178a.c                       |  3 +++
 drivers/net/usb/lan78xx.c                            | 17 ++++-------------
 drivers/net/usb/r8152.c                              |  3 +++
 drivers/net/usb/smsc75xx.c                           |  3 +++
 drivers/net/usb/smsc95xx.c                           |  3 +++
 drivers/net/usb/sr9800.c                             |  3 +++
 drivers/net/virtio_net.c                             | 14 --------------
 drivers/net/vxlan.c                                  |  3 +++
 drivers/net/wimax/i2400m/control.c                   |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c              |  6 ++++--
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c        |  1 +
 drivers/net/wireless/mac80211_hwsim.c                | 36 +++++++++++++++++-------------------
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     |  3 +--
 drivers/net/xen-netback/common.h                     |  3 ++-
 drivers/net/xen-netback/hash.c                       | 51 ++++++++++++++++++++++++++++++++++++---------------
 drivers/net/xen-netback/interface.c                  |  3 ++-
 drivers/s390/net/qeth_core_main.c                    |  2 +-
 drivers/s390/net/qeth_core_mpc.c                     | 33 ++++++++++++++++-----------------
 drivers/s390/net/qeth_core_mpc.h                     |  4 ++--
 include/linux/mlx5/transobj.h                        |  2 ++
 include/linux/netdevice.h                            |  3 +++
 include/linux/netfilter.h                            |  2 ++
 include/net/bonding.h                                |  7 +------
 include/net/cfg80211.h                               |  2 --
 include/net/inet_sock.h                              |  6 ------
 include/net/netlink.h                                |  2 +-
 include/trace/events/rxrpc.h                         |  4 +---
 net/bluetooth/mgmt.c                                 |  7 ++-----
 net/bluetooth/smp.c                                  | 29 +++++++++++++++++++++++++----
 net/bluetooth/smp.h                                  |  3 ++-
 net/bridge/br_netfilter_hooks.c                      |  3 ++-
 net/core/ethtool.c                                   |  9 ++++++++-
 net/core/netpoll.c                                   | 22 +++-------------------
 net/core/rtnetlink.c                                 | 12 ++++++++----
 net/dccp/input.c                                     |  4 +++-
 net/dccp/ipv4.c                                      |  4 +++-
 net/ipv4/inet_connection_sock.c                      |  5 ++++-
 net/ipv4/ip_sockglue.c                               |  3 +--
 net/ipv4/sysctl_net_ipv4.c                           |  6 ++++--
 net/ipv4/tcp_input.c                                 |  4 +++-
 net/ipv4/tcp_ipv4.c                                  |  4 +++-
 net/ipv4/xfrm4_input.c                               |  1 +
 net/ipv4/xfrm4_mode_transport.c                      |  4 +---
 net/ipv6/route.c                                     |  5 -----
 net/ipv6/xfrm6_input.c                               |  1 +
 net/ipv6/xfrm6_mode_transport.c                      |  4 +---
 net/ipv6/xfrm6_output.c                              |  2 ++
 net/mac80211/iface.c                                 |  3 ++-
 net/mac80211/mesh.h                                  |  3 ++-
 net/mac80211/mesh_hwmp.c                             |  9 +++------
 net/mac80211/status.c                                | 11 +++++------
 net/mac80211/tdls.c                                  |  8 ++++----
 net/mac80211/tx.c                                    |  6 +++++-
 net/netfilter/nf_conntrack_proto_tcp.c               |  4 ++--
 net/netfilter/nft_osf.c                              |  2 +-
 net/netfilter/nft_set_rbtree.c                       | 28 ++++++++++++++--------------
 net/netfilter/xt_socket.c                            |  4 ++--
 net/openvswitch/conntrack.c                          |  6 ++----
 net/rxrpc/ar-internal.h                              | 36 +++++++++++++++++++-----------------
 net/rxrpc/call_accept.c                              | 45 ++++++++++++++-------------------------------
 net/rxrpc/call_object.c                              |  2 +-
 net/rxrpc/conn_client.c                              |  4 ++--
 net/rxrpc/conn_object.c                              | 14 ++++++++------
 net/rxrpc/input.c                                    | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 net/rxrpc/local_object.c                             | 32 ++++++++++++++++++++++----------
 net/rxrpc/output.c                                   | 54 ++++++++++++++++++++++++++++++++++++------------------
 net/rxrpc/peer_event.c                               | 46 +++++++++++-----------------------------------
 net/rxrpc/peer_object.c                              | 52 +++++++++++-----------------------------------------
 net/rxrpc/protocol.h                                 | 15 ---------------
 net/sched/act_ipt.c                                  |  2 +-
 net/sctp/outqueue.c                                  |  2 +-
 net/tipc/bearer.c                                    | 12 +++++++-----
 net/tipc/link.c                                      | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 net/tipc/link.h                                      |  3 +++
 net/tipc/node.c                                      | 14 +++++++++++++-
 net/tipc/socket.c                                    |  4 +++-
 net/wireless/nl80211.c                               | 20 +++++++++++++++-----
 net/wireless/reg.c                                   |  1 +
 net/wireless/scan.c                                  | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_input.c                                |  1 +
 net/xfrm/xfrm_output.c                               |  4 ++++
 net/xfrm/xfrm_policy.c                               |  4 ++++
 net/xfrm/xfrm_user.c                                 | 15 +++++++++++++++
 129 files changed, 864 insertions(+), 806 deletions(-)
