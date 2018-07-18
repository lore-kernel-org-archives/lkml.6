Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDBE2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDBE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeGSAOY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:14:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbeGSAOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:14:24 -0400
Received: from localhost (unknown [128.208.196.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF54F14712DF8;
        Wed, 18 Jul 2018 16:34:09 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:34:09 +0900 (KST)
Message-Id: <20180719.083409.2106116342022697029.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 16:34:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of fixes, here goes:

1) NULL deref in qtnfmac, from Gustavo A. R. Silva.

2) Kernel oops when fw download fails in rtlwifi, from Ping-Ke Shih.

3) Lost completion messages in AF_XDP, from Magnus Karlsson.

4) Correct bogus self-assignment in rhashtable, from Rishabh Bhatnagar.

5) Fix regression in ipv6 route append handling, from David Ahern.

6) Fix masking in __set_phy_supported(), from Heiner Kallweit.

7) Missing module owner set in x_tables icmp, from Florian Westphal.

8) liquidio's timeouts are HZ dependent, fix from Nicholas Mc Guire.

9) Link setting fixes for sh_eth and ravb, from Vladimir Zapolskiy.

10) Fix NULL deref when using chains in act_csum, from Davide Caratti.

11) XDP_REDIRECT needs to check if the interface is up and whether the
    MTU is sufficient.  From Toshiaki Makita.

12) Net diag can do a double free when killing TCP_NEW_SYN_RECV
    connections, from Lorenzo Colitti.

13) nf_defrag in ipv6 can unnecessarily hold onto dst entries for a
    full minute, delaying device unregister.  From Eric Dumazet.

14) Update MAC entries in the correct order in ixgbe, from Alexander
    Duyck.

15) Don't leave partial mangles bpf program in jit_subprogs, from
    Daniel Borkmann.

16) Fix pfmemalloc SKB state propagation, from Stefano Brivio.

17) Fix ACK handling in DCTCP congestion control, from Yuchung
    Cheng.

18) Use after free in tun XDP_TX, from Toshiaki Makita.

19) Stale ipv6 header pointer in ipv6 gre code, from Prashant Bhole.

20) Don't reuse remainder of RX page when XDP is set in mlx4, from
    Saeed Mahameed.

21) Fix window probe handling of TCP rapair sockets, from Stefan
    Baranoff.

22) Missing socket locking in smc_ioctl(), from Ursula Braun.

23) IPV6_ILA needs DST_CACHE, from Arnd Bergmann.

24) Spectre v1 fix in cxgb3, from Gustavo A. R. Silva.

25) Two spots in ipv6 do a rol32() on a hash value but ignore
    the result.  Fixes from Colin Ian King.

Please pull, thanks a lot!

The following changes since commit d0fbad0aec1df29717fab736eb24c8a49cf2c70b:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/shli/md (2018-07-02 12:40:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to e56b8ce363a36fb7b74b80aaa5cc9084f2c908b4:

  tcp: identify cryptic messages as TCP seq # bugs (2018-07-18 15:26:33 -0700)

----------------------------------------------------------------
Alexander Couzens (1):
      net: usb: asix: replace mii_nway_restart in resume path

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexander Sverdlin (2):
      octeon_mgmt: Fix MIX registers configuration on MTU setup
      net: cavium: Add fine-granular dependencies on PCI

Alexei Starovoitov (3):
      Merge branch 'af_xdp-fixes'
      Merge branch 'sockmap-fixes'
      Merge branch 'sockhash-fixes'

Andrey Ryabinin (1):
      netfilter: nf_conntrack: Fix possible possible crash on module loading.

Arnd Bergmann (3):
      ieee802154: mcr20a: add missing includes
      net: bridge: fix br_vlan_get_{pvid,info} return values
      ipv6: ila: select CONFIG_DST_CACHE

Arun Kumar Neelakantam (2):
      net: qrtr: Broadcast messages only from control port
      net: qrtr: Reset the node and port ID of broadcast messages

Bert Kenward (2):
      sfc: avoid hang from nested use of the filter_sem
      sfc: hold filter_sem consistently during reset

Casey Leedom (1):
      cxgb4: assume flash part size to be 4MB, if it can't be determined

Colin Ian King (2):
      ipv6: sr: fix useless rol32 call on hash
      ipv6: fix useless rol32 call on hash

Constantine Shulyupin (1):
      scripts/tags.sh: Add BPF_CALL

Corentin Labbe (2):
      net: stmmac: dwmac-sun8i: fix typo descrive => describe
      net: ethernet: stmmac: fix documentation warning

Dan Carpenter (3):
      qed: off by one in qed_parse_mcp_trace_buf()
      ixgbe: Off by one in ixgbe_ipsec_tx()
      qlogic: check kstrtoul() for errors

Daniel Borkmann (4):
      bpf: fix ldx in ld_abs rewrite for large offsets
      bpf: fix panic due to oob in bpf_prog_test_run_skb
      bpf: don't leave partial mangled prog in jit_subprogs error path
      Merge branch 'bpf-af-xdp-consistent-err-reporting'

Dave Watson (1):
      tls: Stricter error checking in zerocopy sendmsg path

David Ahern (3):
      net/ipv6: Revert attempt to simplify route replace and append
      net/ipv4: Set oif in fib_compute_spec_dst
      net/ipv6: Do not allow device only routes via the multipath API

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

David S. Miller (18):
      Merge tag 'wireless-drivers-for-davem-2018-07-03' of git://git.kernel.org/.../kvalo/wireless-drivers
      Merge branch 'qrtr-Broadcasting-control-messages'
      Merge branch 'ravb-sh_eth-fix-sleep-in-atomic-by-reusing-shared-ethtool-handlers'
      Merge branch 'tipc-dad-fixes'
      Merge branch 'net-sched-fix-NULL-dereference-in-goto-chain-control-action'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge git://git.kernel.org/.../pablo/nf
      Merge branch 'bnxt_en-Bug-fixes'
      Merge branch 'ieee802154-for-davem-2018-07-11' of git://git.kernel.org/.../sschmidt/wpan
      Merge branch '10GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'sfc-filter-locking-fixes'
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'fix-DCTCP-delayed-ACK'
      Merge branch 'multicast-init-as-INCLUDE-when-join-SSM-INCLUDE-group'
      Merge branch 'tg3-fixes'
      Merge branch 'smc-fixes'
      Merge tag 'batadv-net-for-davem-20180717' of git://git.open-mesh.org/linux-merge
      Merge branch 'net-qca_spi-Minor-bugfixes'

Davide Caratti (2):
      net/sched: act_csum: fix NULL dereference when 'goto chain' is used
      net/sched: act_tunnel_key: fix NULL dereference when 'goto chain' is used

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table size

Denis Bolotin (1):
      qed: Fix reading stale configuration information

Doron Roberts-Kedes (1):
      tls: fix skb_to_sgvec returning unhandled error.

Eric Biggers (1):
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (1):
      tcp: cleanup copied_seq and urg_data in tcp_disconnect

Ewan D. Milne (1):
      qed: fix spelling mistake "successffuly" -> "successfully"

Florian Fainelli (1):
      net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite

Florian Westphal (3):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: nft_compat: explicitly reject ERROR and standard target
      netfilter: ipv6: nf_defrag: drop skb dst before queueing

Ganapathi Bhat (2):
      Revert "mwifiex: handle race during mwifiex_usb_disconnect"
      mwifiex: handle race during mwifiex_usb_disconnect

Geert Uytterhoeven (1):
      wcn36xx: Remove Unicode Byte Order Mark from testcode

Gustavo A. R. Silva (3):
      qtnfmac: fix NULL pointer dereference
      net: cxgb3_main: fix potential Spectre v1
      ptp: fix missing break in switch

Haiyang Zhang (1):
      hv_netvsc: Fix napi reschedule while receive completion is busy

Hangbin Liu (2):
      ipv4/igmp: init group mode as INCLUDE when join source group
      ipv6/mcast: init as INCLUDE when join SSM INCLUDE group

Harini Katakam (2):
      net: macb: Free RX ring for all queues
      net: macb: Allocate valid memory for TX and RX BD prefetch

Heiner Kallweit (2):
      r8169: fix mac address change
      net: phy: fix flag masking in __set_phy_supported

Igor Russkikh (1):
      net: aquantia: vlan unicast address list correct handling

Jacob Keller (1):
      sch_fq_codel: zero q->flows_cnt when fq_codel_init fails

John Allen (1):
      ibmvnic: Fix error recovery on login failure

John Fastabend (6):
      bpf: sockmap, error path can not release psock in multi-map case
      bpf: sockmap, hash table is RCU so readers do not need locks
      bpf: fix sk_skb programs without skb->dev assigned
      bpf: sockhash, disallow bpf_tcp_close and update in parallel
      bpf: sockmap, consume_skb in close path
      bpf: sockmap, convert bpf_compute_data_pointers to bpf_*_sk_skb

Jon Maloy (4):
      tipc: fix wrong return value from function tipc_node_try_addr()
      tipc: correct discovery message handling during address trial period
      tipc: fix correct setting of message type in second discoverer
      tipc: make function tipc_net_finalize() thread safe

Kalle Valo (1):
      Merge ath-current from git://git.kernel.org/.../kvalo/ath.git

Karsten Graul (1):
      net/smc: reset recv timeout after clc handshake

Krzysztof Kozlowski (1):
      MAINTAINERS: Drop inactive Vitaly Bordug's email

Linus Lüssing (2):
      batman-adv: Avoid storing non-TT-sync flags on singular entries too
      batman-adv: Fix multicast TT issues with bogus ROAM flags

Lorenzo Colitti (1):
      net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Lubomir Rintel (1):
      ieee802154: 6lowpan: set IFLA_LINK

Magnus Karlsson (8):
      xsk: fix potential lost completion message in SKB path
      xsk: frame could be completed more than once in SKB path
      samples/bpf: deal with EBUSY return code from sendmsg in xdpsock sample
      xsk: fix potential race in SKB TX completion code
      xsk: do not return ENXIO from TX copy mode
      xsk: do not return EAGAIN from sendmsg when completion queue is full
      xsk: always return ENOBUFS from sendmsg if there is no TX queue
      xsk: do not return EMSGSIZE in copy mode for packets larger than MTU

Masanari Iida (1):
      bonding: Fix a typo in bonding.txt

Matevz Vucnik (1):
      qmi_wwan: add support for Quectel EG91

Mathieu Xhonneux (1):
      bpf: fix availability probing for seg6 helpers

Mauricio Vasquez B (1):
      bpf: hash map: decrement counter on error

Mauro Carvalho Chehab (2):
      networking: e100.rst: Get rid of Sphinx warnings
      networking: e1000.rst: Get rid of Sphinx warnings

Michael Chan (4):
      bnxt_en: Fix inconsistent BNXT_FLAG_AGG_RINGS logic.
      bnxt_en: Always set output parameters in bnxt_get_max_rings().
      bnxt_en: Support clearing of the IFF_BROADCAST flag.
      bnxt_en: Do not modify max IRQ count after RDMA driver requests/frees IRQs.

Michael Heimpold (1):
      net: ethtool: fix spelling mistake: "tubale" -> "tunable"

Michael Hennerich (2):
      net: ieee802154: adf7242: Fix erroneous RX enable
      net: ieee802154: adf7242: Fix OCL calibration runs

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Máté Eckl (1):
      netfilter: nf_tproxy: fix possible non-linear access to transport header

Nicholas Mc Guire (1):
      liquidio: make timeout HZ independent and readable

Okash Khawaja (1):
      bpf: btf: Fix bitfield extraction for big endian

Pablo Neira Ayuso (1):
      netfilter: nf_tables: place all set backends in one single module

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paul Moore (1):
      ipv6: make ipv6_renew_options() interrupt/kernel safe

Ping-Ke Shih (2):
      rtlwifi: Fix kernel Oops "Fw download fail!!"
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Prashant Bhole (1):
      net: ip6_gre: get ipv6hdr after skb_cow_head()

Randy Dunlap (2):
      net/ethernet/freescale/fman: fix cross-build error
      tcp: identify cryptic messages as TCP seq # bugs

Rishabh Bhatnagar (1):
      lib: rhashtable: Correct self-assignment in rhashtable.c

Roman Gushchin (1):
      bpf: include errno.h from bpf-cgroup.h

Russell King (2):
      sfp: ensure we clean up properly on bus registration failure
      sfp: fix module initialisation with netdev already up

Ryan Hsu (1):
      ath10k: update the phymode along with bandwidth change request

Sabrina Dubroca (1):
      ipv6: make DAD fail with enhanced DAD when nonce length differs

Saeed Mahameed (1):
      net/mlx4_en: Don't reuse RX page when XDP is set

Sanjeev Bansal (1):
      tg3: Add higher cpu clock for 5762.

Siva Reddy Kallam (1):
      tg3: Update copyright

Stanislaw Gruszka (1):
      mt7601u: remove warning when avg_rssi is zero

Stefan Baranoff (3):
      tcp: fix sequence numbers for repaired sockets re-using TIME-WAIT sockets
      tcp: allow user to create repair socket without window probes
      tcp: Fix broken repair socket window probe patch

Stefan Schmidt (4):
      MAINTAINERS: update my email address
      ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: at86rf230: use __func__ macro for debug messages
      ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Stefan Wahren (4):
      net: lan78xx: Fix race in tx pending skb size calculation
      net: qca_spi: Avoid packet drop during initial sync
      net: qca_spi: Make sure the QCA7000 reset is triggered
      net: qca_spi: Fix log level if probe fails

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Stephen Hemminger (1):
      hv/netvsc: fix handling of fallback to single queue mode

Sven Eckelmann (4):
      batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
      batman-adv: Fix bat_v best gw refcnt after netlink dump
      batman-adv: Fix debugfs path for renamed hardif
      batman-adv: Fix debugfs path for renamed softif

Taehee Yoo (1):
      rhashtable: add restart routine in rhashtable_free_and_destroy()

Taeung Song (5):
      samples/bpf: add missing <linux/if_vlan.h>
      samples/bpf: Check the result of system()
      samples/bpf: Check the error of write() and read()
      samples/bpf: add .gitignore file
      samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Thomas Falcon (1):
      ibmvnic: Revise RX/TX queue error messages

Toke Høiland-Jørgensen (1):
      gen_stats: Fix netlink stats dumping in the presence of padding

Toshiaki Makita (2):
      xdp: XDP_REDIRECT should check IFF_UP and MTU
      tun: Fix use-after-free on XDP_TX

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user ns

Ursula Braun (4):
      net/smc: reduce sock_put() for fallback sockets
      net/smc: take sock lock in smc_ioctl()
      net/smc: optimize consumer cursor updates
      net/smc: add error handling for get_user()

Venkat Duvvuru (1):
      bnxt_en: Fix the vlan_tci exact match check.

Vikas Gupta (1):
      bnxt_en: Fix for system hang if request_irq fails

Vladimir Zapolskiy (14):
      sh_eth: fix invalid context bug while calling auto-negotiation by ethtool
      sh_eth: fix invalid context bug while changing link options by ethtool
      sh_eth: simplify link auto-negotiation by ethtool
      sh_eth: remove custom .nway_reset from ethtool ops
      sh_eth: remove useless serialization in sh_eth_get_link_ksettings()
      sh_eth: remove custom .get_link_ksettings from ethtool ops
      sh_eth: remove custom .set_link_ksettings from ethtool ops
      ravb: fix invalid context bug while calling auto-negotiation by ethtool
      ravb: fix invalid context bug while changing link options by ethtool
      ravb: simplify link auto-negotiation by ethtool
      ravb: remove custom .nway_reset from ethtool ops
      ravb: remove useless serialization in ravb_get_link_ksettings()
      ravb: remove custom .get_link_ksettings from ethtool ops
      ravb: remove custom .set_link_ksettings from ethtool ops

Wang Dongsheng (1):
      net: phy: marvell: change default m88e1510 LED configuration

Willem de Bruijn (3):
      nsh: set mac len based on inner packet
      packet: reset network header if packet shorter than ll reserved space
      selftests: in udpgso_bench do not test udp zerocopy

Xin Long (1):
      sctp: fix the issue that pathmtu may be set lower than MINSEGMENT

Xinming Hu (1):
      MAINTAINERS: update Xinming's email address

Yuchung Cheng (2):
      tcp: fix dctcp delayed ACK schedule
      tcp: remove DELAYED ACK events in DCTCP

YueHaibing (1):
      net: sched: Using NULL instead of plain integer

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

 Documentation/networking/bonding.txt                      |   2 +-
 Documentation/networking/e100.rst                         |  27 +++++++----
 Documentation/networking/e1000.rst                        | 187 ++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 MAINTAINERS                                               |   7 ++-
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h           |   2 -
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h            |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c          |  11 +----
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |  47 +++++++++++--------
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h           |   2 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c |   2 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c                |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.h                |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |  24 +++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                 |   1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c              |  30 ++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c             |   2 -
 drivers/net/ethernet/broadcom/tg3.c                       |  13 ++++++
 drivers/net/ethernet/broadcom/tg3.h                       |   2 +
 drivers/net/ethernet/cadence/macb.h                       |  11 +++++
 drivers/net/ethernet/cadence/macb_main.c                  |  36 +++++++++-----
 drivers/net/ethernet/cavium/Kconfig                       |  12 ++---
 drivers/net/ethernet/cavium/liquidio/lio_main.c           |   5 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c          |  14 ++++--
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c           |   2 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                |  35 ++++++--------
 drivers/net/ethernet/ibm/ibmvnic.c                        |  43 +++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c           |  12 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c            |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                |   8 +++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c     |  48 +++++++++----------
 drivers/net/ethernet/qlogic/qed/qed.h                     |   1 +
 drivers/net/ethernet/qlogic/qed/qed_debug.c               |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c                |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                 |  39 +++++++++++-----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c         |   2 +
 drivers/net/ethernet/qualcomm/qca_spi.c                   |  21 +++++----
 drivers/net/ethernet/realtek/r8169.c                      |   1 +
 drivers/net/ethernet/renesas/ravb_main.c                  |  93 +++++++-----------------------------
 drivers/net/ethernet/renesas/sh_eth.c                     |  94 +++++++------------------------------
 drivers/net/ethernet/sfc/ef10.c                           |  30 ++++++++----
 drivers/net/ethernet/sfc/efx.c                            |  17 ++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c     |   1 -
 drivers/net/hyperv/netvsc.c                               |  17 ++++---
 drivers/net/hyperv/rndis_filter.c                         |   1 +
 drivers/net/ieee802154/adf7242.c                          |  34 +++++++++++++-
 drivers/net/ieee802154/at86rf230.c                        |  15 ++----
 drivers/net/ieee802154/fakelb.c                           |   2 +-
 drivers/net/ieee802154/mcr20a.c                           |   3 +-
 drivers/net/phy/marvell.c                                 |  54 ++++++++++++++-------
 drivers/net/phy/phy_device.c                              |   7 +--
 drivers/net/phy/sfp-bus.c                                 |  35 ++++++++++----
 drivers/net/tun.c                                         |   2 +-
 drivers/net/usb/asix_devices.c                            |   4 +-
 drivers/net/usb/lan78xx.c                                 |   5 +-
 drivers/net/usb/qmi_wwan.c                                |   1 +
 drivers/net/usb/rtl8150.c                                 |   2 +-
 drivers/net/usb/smsc75xx.c                                |  62 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/mac.c                     |  16 ++++++-
 drivers/net/wireless/ath/ath10k/wmi.h                     |   1 +
 drivers/net/wireless/ath/wcn36xx/testmode.c               |   2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   |   7 +++
 drivers/net/wireless/marvell/mwifiex/usb.c                |   7 +--
 drivers/net/wireless/mediatek/mt7601u/phy.c               |   6 ++-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c         |   3 +-
 drivers/net/wireless/realtek/rtlwifi/base.c               |  17 ++++---
 drivers/net/wireless/realtek/rtlwifi/base.h               |   2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c               |   3 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c                |   2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c                 |   4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c                |   2 +-
 drivers/ptp/ptp_chardev.c                                 |   1 +
 include/linux/bpf-cgroup.h                                |   1 +
 include/linux/filter.h                                    |   6 +--
 include/linux/fsl/guts.h                                  |   1 +
 include/linux/if_bridge.h                                 |   4 +-
 include/linux/igmp.h                                      |   2 +
 include/linux/marvell_phy.h                               |   2 +
 include/linux/skbuff.h                                    |  10 ++--
 include/net/ip6_route.h                                   |   6 +++
 include/net/ipv6.h                                        |  13 ++----
 include/net/netfilter/nf_tables_core.h                    |   6 +++
 include/net/netfilter/nf_tproxy.h                         |   4 +-
 include/net/tc_act/tc_csum.h                              |   1 -
 include/net/tc_act/tc_tunnel_key.h                        |   1 -
 include/net/tcp.h                                         |   6 ++-
 include/net/xdp_sock.h                                    |   4 ++
 include/uapi/linux/ethtool.h                              |   2 +-
 include/uapi/linux/tcp.h                                  |   4 ++
 kernel/bpf/btf.c                                          |  30 ++++++------
 kernel/bpf/devmap.c                                       |   7 ++-
 kernel/bpf/hashtab.c                                      |  16 +++++--
 kernel/bpf/sockmap.c                                      |  43 ++++++++++-------
 kernel/bpf/syscall.c                                      |   4 +-
 kernel/bpf/verifier.c                                     |  11 ++++-
 lib/rhashtable.c                                          |  27 +++++++----
 net/batman-adv/bat_iv_ogm.c                               |   4 +-
 net/batman-adv/bat_v.c                                    |   4 +-
 net/batman-adv/debugfs.c                                  |  40 ++++++++++++++++
 net/batman-adv/debugfs.h                                  |  11 +++++
 net/batman-adv/hard-interface.c                           |  37 ++++++++++++---
 net/batman-adv/translation-table.c                        |   7 ++-
 net/bpf/test_run.c                                        |  17 +++++--
 net/core/filter.c                                         | 149 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 net/core/gen_stats.c                                      |  16 ++++++-
 net/core/skbuff.c                                         |   1 +
 net/dns_resolver/dns_key.c                                |  28 ++++++-----
 net/ieee802154/6lowpan/core.c                             |   6 +++
 net/ipv4/fib_frontend.c                                   |   1 +
 net/ipv4/igmp.c                                           |  58 ++++++++++++++++-------
 net/ipv4/inet_fragment.c                                  |   2 +-
 net/ipv4/ip_sockglue.c                                    |   4 +-
 net/ipv4/netfilter/ip_tables.c                            |   1 +
 net/ipv4/netfilter/nf_tproxy_ipv4.c                       |  18 ++++---
 net/ipv4/sysctl_net_ipv4.c                                |   5 +-
 net/ipv4/tcp.c                                            |  16 ++++---
 net/ipv4/tcp_dctcp.c                                      |  31 ++----------
 net/ipv4/tcp_ipv4.c                                       |  23 +++++++--
 net/ipv4/tcp_output.c                                     |   4 --
 net/ipv6/Kconfig                                          |   1 +
 net/ipv6/calipso.c                                        |   9 ++--
 net/ipv6/exthdrs.c                                        | 111 ++++++++++++-------------------------------
 net/ipv6/ip6_fib.c                                        | 156 ++++++++++++++++++++++++++++++++++---------------------------
 net/ipv6/ip6_gre.c                                        |   3 +-
 net/ipv6/ipv6_sockglue.c                                  |  32 +++++++++----
 net/ipv6/mcast.c                                          |  64 +++++++++++++++++--------
 net/ipv6/ndisc.c                                          |   2 +-
 net/ipv6/netfilter/ip6_tables.c                           |   1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c                   |   2 +
 net/ipv6/netfilter/nf_tproxy_ipv6.c                       |  18 ++++---
 net/ipv6/route.c                                          |  10 +++-
 net/ipv6/seg6_iptunnel.c                                  |   2 +-
 net/netfilter/Kconfig                                     |  25 +++-------
 net/netfilter/Makefile                                    |   7 +--
 net/netfilter/nf_conntrack_core.c                         |   2 +-
 net/netfilter/nf_tables_set_core.c                        |  28 +++++++++++
 net/netfilter/nft_compat.c                                |  13 ++++++
 net/netfilter/nft_set_bitmap.c                            |  19 +-------
 net/netfilter/nft_set_hash.c                              |  29 ++----------
 net/netfilter/nft_set_rbtree.c                            |  19 +-------
 net/netfilter/xt_TPROXY.c                                 |   8 ++--
 net/nfc/llcp_commands.c                                   |   9 ++--
 net/nsh/nsh.c                                             |   2 +-
 net/packet/af_packet.c                                    |   2 +
 net/qrtr/qrtr.c                                           |  13 +++++-
 net/sched/act_csum.c                                      |   6 +--
 net/sched/act_tunnel_key.c                                |   6 +--
 net/sched/cls_api.c                                       |   4 +-
 net/sched/sch_fq_codel.c                                  |  25 +++++++---
 net/sctp/transport.c                                      |   2 +-
 net/smc/af_smc.c                                          |  37 +++++++++++----
 net/smc/smc_clc.c                                         |   3 +-
 net/smc/smc_close.c                                       |   2 +
 net/smc/smc_tx.c                                          |  12 ++++-
 net/tipc/discover.c                                       |  18 ++++---
 net/tipc/net.c                                            |  17 ++++---
 net/tipc/node.c                                           |   7 ++-
 net/tls/tls_sw.c                                          |   7 ++-
 net/xdp/xsk.c                                             |  30 +++++-------
 net/xdp/xsk_queue.h                                       |   9 +---
 samples/bpf/.gitignore                                    |  49 +++++++++++++++++++
 samples/bpf/parse_varlen.c                                |   6 +--
 samples/bpf/test_overhead_user.c                          |  19 ++++++--
 samples/bpf/trace_event_user.c                            |  27 +++++++++--
 samples/bpf/xdp2skb_meta.sh                               |   6 +--
 samples/bpf/xdpsock_user.c                                |   2 +-
 scripts/tags.sh                                           |   1 +
 tools/testing/selftests/bpf/test_verifier.c               |  23 ++++++++-
 tools/testing/selftests/net/fib_tests.sh                  |  41 ----------------
 tools/testing/selftests/net/udpgso_bench.sh               |   3 --
 171 files changed, 1739 insertions(+), 1128 deletions(-)
 create mode 100644 net/netfilter/nf_tables_set_core.c
 create mode 100644 samples/bpf/.gitignore
