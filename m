Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A654C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62E42070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfACGMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 01:12:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfACGMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 01:12:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 627CB1469E337;
        Wed,  2 Jan 2019 22:12:15 -0800 (PST)
Date:   Wed, 02 Jan 2019 22:12:13 -0800 (PST)
Message-Id: <20190102.221213.1813991188278531637.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Jan 2019 22:12:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Several fixes here.  Basically split down the line between newly
introduced regressions and long existing problems:

1) Double free in tipc_enable_bearer(), from Cong Wang.

2) Many fixes to nf_conncount, from Florian Westphal.

3) op->get_regs_len() can throw an error, check it, from Yunsheng Lin.

4) Need to use GFP_ATOMIC in *_add_hash_mac_address() of fsl/fman
   driver, from Scott Wood.

5) Inifnite loop in fib_empty_table(), from Yue Haibing.

6) Use after free in ax25_fillin_cb(), from Cong Wang.

7) Fix socket locking in nr_find_socket(), also from Cong Wang.

8) Fix WoL wakeup enable in r8169, from Heiner Kallweit.

9) On 32-bit sock->sk_stamp is not thread-safe, from Deepa Dinamani.

10) Fix ptr_ring wrap during queue swap, from Cong Wang.

11) Missing shutdown callback in hinic driver, from Xue Chaojing.

12) Need to return NULL on error from ip6_neigh_lookup(), from Stefano
    Brivio.

13) BPF out of bounds speculation fixes from Daniel Borkmann.

Please pull, thanks a lot!

The following changes since commit b71acb0e372160167bf6d5500b88b30b52ccef6e:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2018-12-27 13:53:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net 

for you to fetch changes up to c5ee066333ebc322a24a00a743ed941a0c68617e:

  ipv6: Consider sk_bound_dev_if when binding a socket to an address (2019-01-02 20:16:37 -0800)

----------------------------------------------------------------
Aditya Pakki (2):
      ipv6/route: Add a missing check on proc_dointvec
      net: chelsio: Add a missing check on cudg_get_buffer

Alexei Starovoitov (1):
      Merge branch 'prevent-oob-under-speculation'

Christophe JAILLET (1):
      net/ipv6: Fix a test against 'ipv6_find_idev()' return value

Cong Wang (5):
      tipc: fix a double free in tipc_enable_bearer()
      ax25: fix a use-after-free in ax25_fillin_cb()
      net/wan: fix a double free in x25_asy_open_tty()
      netrom: fix locking in nr_find_socket()
      ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()

Daniel Borkmann (9):
      bpf: move {prev_,}insn_idx into verifier env
      bpf: move tmp variable into ax register in interpreter
      bpf: enable access to ax register also from verifier rewrite
      bpf: restrict map value pointer arithmetic for unprivileged
      bpf: restrict stack pointer arithmetic for unprivileged
      bpf: restrict unknown scalars of mixed signed bounds for unprivileged
      bpf: fix check_map_access smin_value test when pointer contains offset
      bpf: prevent out of bounds speculation on pointer arithmetic
      bpf: add various test cases to selftests

David Ahern (2):
      ipv6: Fix dump of specific table with strict checking
      ipv6: Consider sk_bound_dev_if when binding a socket to an address

David S. Miller (2):
      Merge git://git.kernel.org/.../pablo/nf
      Merge git://git.kernel.org/.../bpf/bpf

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Eric Dumazet (2):
      net/hamradio/6pack: use mod_timer() to rearm timers
      isdn: fix kernel-infoleak in capi_unlocked_ioctl

Florian Westphal (5):
      netfilter: nf_conncount: don't skip eviction when age is negative
      netfilter: nf_conncount: split gc in two phases
      netfilter: nf_conncount: restart search when nodes have been erased
      netfilter: nf_conncount: merge lookup and add functions
      netfilter: nf_conncount: fix argument order to find_next_bit

Heiner Kallweit (1):
      r8169: fix WoL device wakeup enable

Huazhong Tan (1):
      net: hns3: call hns3_nic_net_open() while doing HNAE3_UP_CLIENT

Jia-Ju Bai (1):
      isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug in HFCPCI_l1hw()

Kangjie Lu (8):
      niu: fix missing checks of niu_pci_eeprom_read
      net: (cpts) fix a missing check of clk_prepare
      net: stmicro: fix a missing check of clk_prepare
      net: dsa: bcm_sf2: Propagate error value from mdio_write
      atl1e: checking the status of atl1e_write_phy_reg
      tipc: fix a missing check of genlmsg_put
      net: marvell: fix a missing check of acpi_match_device
      netfilter: nf_tables: fix a missing check of nla_put_failure

Nikolay Aleksandrov (1):
      net: rtnetlink: address is mandatory for rtnl_fdb_get

Pablo Neira Ayuso (2):
      netfilter: nf_conncount: move all list iterations under spinlock
      netfilter: nf_conncount: speculative garbage collection on empty lists

Robert P. J. Day (2):
      phy.h: fix obvious errors in doc and kerneldoc content
      include/linux/phy/phy.h: fix minor kerneldoc errors

Scott Wood (1):
      fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Shawn Bohrer (1):
      netfilter: nf_conncount: replace CONNCOUNT_LOCK_SLOTS with CONNCOUNT_SLOTS

Stefano Brivio (1):
      ipv6: route: Fix return value of ip6_neigh_lookup() on neigh_create() error

Su Yanjun (1):
      ipv6: fix typo in net/ipv6/reassembly.c

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Wen Yang (1):
      net/wan/fsl_ucc_hdlc: Avoid double free in ucc_hdlc_probe()

Willem de Bruijn (2):
      tap: call skb_probe_transport_header after setting skb->dev
      ip: validate header length on virtual device xmit

Xiaozhou Liu (1):
      selftests/bpf: fix error printing in test_devmap()

Xue Chaojing (1):
      net-next/hinic:add shutdown callback

YueHaibing (1):
      ipv4: fib_rules: Fix possible infinite loop in fib_empty_table

Yunsheng Lin (1):
      ethtool: check the return value of get_regs_len

Zhu Yanjun (1):
      net: rds: remove unnecessary NULL check

yupeng (1):
      add document for TCP OFO, PAWS and skip ACK counters

 Documentation/networking/snmp_counter.rst         |  240 ++++++++++++++++-
 drivers/isdn/capi/kcapi.c                         |    4 +-
 drivers/isdn/hisax/hfc_pci.c                      |    2 +
 drivers/net/dsa/bcm_sf2.c                         |    7 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c   |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c    |    4 +
 drivers/net/ethernet/freescale/fman/fman_memac.c  |    2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c   |    7 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c    |    6 +
 drivers/net/ethernet/ibm/ibmveth.c                |    6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c   |    2 +
 drivers/net/ethernet/realtek/r8169.c              |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c |    4 +-
 drivers/net/ethernet/sun/niu.c                    |   10 +-
 drivers/net/ethernet/ti/cpts.c                    |    4 +-
 drivers/net/hamradio/6pack.c                      |   16 +-
 drivers/net/tap.c                                 |    3 +-
 drivers/net/wan/fsl_ucc_hdlc.c                    |    1 -
 drivers/net/wan/x25_asy.c                         |    2 +
 include/linux/bpf_verifier.h                      |   12 +
 include/linux/filter.h                            |   10 +-
 include/linux/phy.h                               |   13 +-
 include/linux/phy/phy.h                           |    2 +-
 include/linux/ptr_ring.h                          |    2 +
 include/net/ip_tunnels.h                          |   20 ++
 include/net/netfilter/nf_conntrack_count.h        |   19 +-
 include/net/sock.h                                |   38 ++-
 kernel/bpf/core.c                                 |   54 ++--
 kernel/bpf/verifier.c                             |  336 ++++++++++++++++++-----
 net/ax25/af_ax25.c                                |   11 +-
 net/ax25/ax25_dev.c                               |    2 +
 net/compat.c                                      |   15 +-
 net/core/ethtool.c                                |   12 +-
 net/core/rtnetlink.c                              |    5 +
 net/core/sock.c                                   |   15 +-
 net/ipv4/fib_rules.c                              |    8 +-
 net/ipv4/ip_gre.c                                 |    9 +
 net/ipv4/ip_tunnel.c                              |    9 -
 net/ipv4/ip_vti.c                                 |   12 +-
 net/ipv6/addrconf.c                               |    4 +-
 net/ipv6/af_inet6.c                               |    3 +
 net/ipv6/ip6_fib.c                                |    6 +-
 net/ipv6/ip6_gre.c                                |   10 +-
 net/ipv6/ip6_tunnel.c                             |   10 +-
 net/ipv6/ip6_vti.c                                |    8 +-
 net/ipv6/ip6mr.c                                  |   17 +-
 net/ipv6/reassembly.c                             |    2 +-
 net/ipv6/route.c                                  |   10 +-
 net/ipv6/sit.c                                    |    3 +
 net/netfilter/nf_conncount.c                      |  290 +++++++++-----------
 net/netfilter/nf_tables_api.c                     |    2 +
 net/netfilter/nft_connlimit.c                     |   14 +-
 net/netrom/af_netrom.c                            |   15 +-
 net/rds/tcp.c                                     |    2 +-
 net/sunrpc/svcsock.c                              |    2 +-
 net/tipc/bearer.c                                 |    1 -
 net/tipc/netlink_compat.c                         |    2 +
 tools/testing/selftests/bpf/test_maps.c           |    2 +-
 tools/testing/selftests/bpf/test_verifier.c       | 1146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 60 files changed, 2079 insertions(+), 404 deletions(-)
