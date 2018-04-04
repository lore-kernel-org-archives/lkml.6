Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDDRwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:52:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:42316 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDDRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:52:33 -0400
Date: Wed, 04 Apr 2018 13:52:32 -0400 (EDT)
Message-Id: <20180404.135232.494526948590893131.davem@davemloft.net>
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


This fixes some fallout from the net-next merge the other day, plus
some non-merge-window-related bug fixes:

1) Fix sparse warnings in bcmgenet,systemport, b53, and mt7530, from
   Florian Fainelli.

2) pptp does a bogus dst_release() on a route we have a single refcount
   on, and attached to a socket, which needs that refcount.  From Eric
   Dumazet.

3) UDP connected sockets on ipv6 can race with route update handling,
   resulting in a pre-PMTU update route still stuck on the socket and
   thus continuing to get ICMPV6_PKT_TOOBIG errors.  We end up never
   seeing the updated route.  Fix from Alexey Kodanev.

4) Missing list initializer(s) in TIPC, from Jon Maloy.

5) Connect phy early to prevent crashes in lan78xx driver, from
   Alexander Graf.

6) Fix build with modular NVMEM, from Arnd Bergmann.

7) netdevsim canot mark nsim_devlink_net_ops and nsim_fib_net_ops as
   __net_initdata, as these are references from module unload
   unconditionally.  From Arnd Bergmann.

Please pull, thanks a lot!

The following changes since commit 17dec0a949153d9ac00760ba2f5b78cb583e995f:

  Merge branch 'userns-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2018-04-03 19:15:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 87248d31d1055b56e01a62d9320b4e118bc84e0e:

  netdevsim: remove incorrect __net_initdata annotations (2018-04-04 12:53:37 -0400)

----------------------------------------------------------------
Alexander Graf (1):
      lan78xx: Connect phy early

Alexey Kodanev (4):
      ipv6: add a wrapper for ip6_dst_store() with flowi6 checks
      ipv6: allow to cache dst for a connected sk in ip6_sk_dst_lookup_flow()
      ipv6: udp: convert 'connected' to bool type in udpv6_sendmsg()
      ipv6: udp: set dst cache for a connected sk if current not valid

Arnd Bergmann (2):
      nvmem: disallow modular CONFIG_NVMEM
      netdevsim: remove incorrect __net_initdata annotations

Bert Kenward (1):
      sfc: remove ctpio_dmabuf_start from stats

Cong Wang (1):
      af_unix: remove redundant lockdep class

David Howells (1):
      rxrpc: Fix undefined packet handling

David S. Miller (2):
      Merge branch 'net-Broadcom-drivers-sparse-fixes'
      Merge branch 'ipv6-udp-set-dst-cache-for-a-connected-sk-if-current-not-valid'

Dirk van der Merwe (1):
      nfp: use full 40 bits of the NSP buffer address

Eric Dumazet (2):
      pptp: remove a buggy dst release in pptp_connect()
      inet: frags: fix ip6frag_low_thresh boundary

Florian Fainelli (4):
      net: bcmgenet: Fix sparse warnings in bcmgenet_put_tx_csum()
      net: systemport: Fix sparse warnings in bcm_sysport_insert_tsb()
      net: dsa: b53: Fix sparse warnings in b53_mmap.c
      net: dsa: mt7530: Use NULL instead of plain integer

GhantaKrishnamurthy MohanKrishna (1):
      tipc: Fix namespace violation in tipc_sk_fill_sock_diag

Jakub Kicinski (1):
      nfp: add a separate counter for packets with CHECKSUM_COMPLETE

Jon Maloy (1):
      tipc: Fix missing list initializations in struct tipc_subscription

Paolo Abeni (1):
      net: avoid unneeded atomic operation in ip*_append_data()

Russell King (1):
      net: phy: marvell10g: add thermal hwmon device

Tan Xiaojun (1):
      net: hns3: fix length overflow when CONFIG_ARM64_64K_PAGES

 drivers/net/dsa/b53/b53_mmap.c                       |  33 +++++++++++++-----
 drivers/net/dsa/mt7530.c                             |   6 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c           |  11 +++---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c       |  11 +++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h      |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h         |   4 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c  |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c |  16 +++++----
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c |   9 ++---
 drivers/net/ethernet/sfc/ef10.c                      |   2 --
 drivers/net/ethernet/sfc/nic.h                       |   1 -
 drivers/net/netdevsim/devlink.c                      |   2 +-
 drivers/net/netdevsim/fib.c                          |   2 +-
 drivers/net/phy/marvell10g.c                         | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/ppp/pptp.c                               |   1 -
 drivers/net/usb/lan78xx.c                            |  34 +++++++++---------
 drivers/nvmem/Kconfig                                |   2 +-
 include/net/ip6_route.h                              |   3 ++
 include/net/ipv6.h                                   |   3 +-
 net/ieee802154/6lowpan/reassembly.c                  |   2 --
 net/ipv4/ip_fragment.c                               |   5 ++-
 net/ipv4/ip_output.c                                 |   3 +-
 net/ipv6/datagram.c                                  |   9 +----
 net/ipv6/ip6_output.c                                |  18 +++++++---
 net/ipv6/netfilter/nf_conntrack_reasm.c              |   2 --
 net/ipv6/ping.c                                      |   2 +-
 net/ipv6/reassembly.c                                |   2 --
 net/ipv6/route.c                                     |  17 +++++++++
 net/ipv6/udp.c                                       |  31 ++++-------------
 net/rxrpc/input.c                                    |   6 ++++
 net/rxrpc/protocol.h                                 |   6 ++++
 net/tipc/socket.c                                    |   3 +-
 net/tipc/subscr.c                                    |   2 ++
 net/unix/af_unix.c                                   |  10 ------
 34 files changed, 326 insertions(+), 120 deletions(-)
