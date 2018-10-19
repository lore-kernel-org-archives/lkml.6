Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5359CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF432145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF432145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSIWr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:22:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43400 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:22:47 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4C49A140DA5D1;
        Thu, 18 Oct 2018 17:19:15 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:19:14 -0700 (PDT)
Message-Id: <20181018.171914.1210096727703399564.davem@davemloft.net>
To:     gregkh@linuxfoundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 17:19:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Fix gro_cells leak in xfrm layer, from Li RongQing.

2) BPF selftests change RLIMIT_MEMLOCK blindly, don't do that.
   From Eric Dumazet.

3) AF_XDP calls synchronize_net() under RCU lock, fix from Björn
   Töpel.

4) Out of bounds packet access in _decode_session6(), from Alexei
   Starovoitov.

5) Several ethtool bugs, where we copy a struct into the kernel
   twice and our validations of the values in the first copy can
   be invalidated by the second copy due to asynchronous updates
   to the memory by the user.  From Wenwen Wang.

6) Missing netlink attribute validation in cls_api, from Davide
   Caratti.

7) LLC SAP sockets neet to be SOCK_RCU FREE, from Cong Wang.

8) rxrpc operates on wrong kvec, from Yue Haibing.

9) A regression was introduced by the disassosciation of route
   neighbour references in rt6_probe(), causing probe for
   neighbourless routes to not be properly rate limited.  Fix
   from Sabrina Dubroca.

10) Unsafe RCU locking in tipc, from Tung Nguyen.

11) Use after free in inet6_mc_check(), from Eric Dumazet.

12) PMTU from icmp packets should update the SCTP transport
    pathmtu, from Xin Long.

13) Missing peer put on error in rxrpc, from David Howells.

14) Fix pedit in nfp driver, from Pieter Jansen van Vuuren.

15) Fix overflowing shift statement in qla3xxx driver, from Nathan
    Chancellor.

16) Fix Spectre v1 in ptp code, from Gustavo A. R. Silva.

17) udp6_unicast_rcv_skb() interprets udpv6_queue_rcv_skb() return
    value in an inverted manner, fix from Paolo Abeni.

18) Fix missed unresolved entries in ipmr dumps, from Nikolay
    Aleksandrov.

19) Fix NAPI handling under high load, we can completely miss events
    when NAPI has to loop more than one time in a cycle.  From Heiner
    Kallweit.

Please pull, thanks a lot!

The following changes since commit bab5c80b211035739997ebd361a679fa85b39465:

  Merge tag 'armsoc-fixes-4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-12 17:41:27 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to d4d576f5ab7edcb757bb33e6a5600666a0b1232d:

  ip6_tunnel: Fix encapsulation layout (2018-10-18 16:54:40 -0700)

----------------------------------------------------------------
Ake Koomsin (1):
      virtio_net: avoid using netif_tx_disable() for serializing tx routine

Alexei Starovoitov (1):
      net/xfrm: fix out-of-bounds packet access

Björn Töpel (1):
      xsk: do not call synchronize_net() under RCU read lock

Colin Ian King (1):
      qed: fix spelling mistake "Ireelevant" -> "Irrelevant"

Cong Wang (1):
      llc: set SOCK_RCU_FREE in llc_sap_add_socket()

David Howells (3):
      rxrpc: Fix an uninitialised variable
      rxrpc: Fix incorrect conditional on IPV6
      rxrpc: Fix a missing rxrpc_put_peer() in the error_report handler

David S. Miller (5):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge tag 'mlx5-fixes-2018-10-10' of git://git.kernel.org/.../saeed/linux
      Merge branch 'nfp-fix-pedit-set-action-offloads'
      Merge branch 'geneve-vxlan-mtu'
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec

Davide Caratti (1):
      net/sched: cls_api: add missing validation of netlink attributes

Eric Dumazet (2):
      bpf: do not blindly change rlimit in reuseport net selftest
      ipv6: mcast: fix a use-after-free in inet6_mc_check

Florian Fainelli (1):
      net: bcmgenet: Poll internal PHY for GENETv5

Florian Westphal (1):
      xfrm: policy: use hlist rcu variants on insert

Fugang Duan (1):
      net: fec: don't dump RX FIFO register when not available

Gregory CLEMENT (1):
      net: mscc: ocelot: Fix comment in ocelot_vlant_wait_for_completion()

Gustavo A. R. Silva (1):
      ptp: fix Spectre v1 vulnerability

Heiner Kallweit (2):
      r8169: re-enable MSI-X on RTL8168g
      r8169: fix NAPI handling under high load

Huy Nguyen (1):
      net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Ido Schimmel (1):
      mlxsw: core: Fix use-after-free when flashing firmware during init

Jian-Hong Pan (1):
      r8169: Enable MSI-X on RTL8106e

Jon Maloy (2):
      tipc: initialize broadcast link stale counter correctly
      tipc: fix info leak from kernel tipc_event

Li RongQing (1):
      xfrm: fix gro_cells leak when remove virtual xfrm interfaces

Marcelo Ricardo Leitner (1):
      sctp: fix race on sctp_id2asoc

Nathan Chancellor (1):
      net: qla3xxx: Remove overflowing shift statement

Nikolay Aleksandrov (1):
      net: ipmr: fix unresolved entry dumps

Paolo Abeni (1):
      udp6: fix encap return code for resubmitting

Phil Sutter (1):
      net: sched: Fix for duplicate class dump

Pieter Jansen van Vuuren (3):
      nfp: flower: fix pedit set actions for multiple partial masks
      nfp: flower: fix multiple keys per pedit action
      nfp: flower: use offsets provided by pedit instead of index for ipv6

Sabrina Dubroca (1):
      ipv6: rate-limit probes for neighbourless routes

Stefano Brivio (3):
      geneve, vxlan: Don't check skb_dst() twice
      geneve, vxlan: Don't set exceptions if skb->len < mtu
      ip6_tunnel: Fix encapsulation layout

Steffen Klassert (1):
      MAINTAINERS: Remove net/core/flow.c

Taehee Yoo (1):
      net: bpfilter: use get_pid_task instead of pid_task

Talat Batheesh (1):
      net/mlx5: Fix memory leak when setting fpga ipsec caps

Tariq Toukan (1):
      net/mlx5: WQ, fixes for fragmented WQ buffers API

Tung Nguyen (1):
      tipc: fix unsafe rcu locking when accessing publication list

Wenwen Wang (3):
      ethtool: fix a missing-check bug
      ethtool: fix a privilege escalation bug
      net: socket: fix a missing-check bug

Xin Long (4):
      sctp: use the pmtu from the icmp packet to update transport pathmtu
      sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL instead
      sctp: not free the new asoc when sctp_wait_for_connect returns err
      sctp: fix the data size calculation in sctp_data_size

YueHaibing (1):
      rxrpc: use correct kvec num when sending BUSY response packet

 MAINTAINERS                                           |  1 -
 drivers/net/ethernet/broadcom/genet/bcmmii.c          |  7 +++++--
 drivers/net/ethernet/freescale/fec.h                  |  4 ++++
 drivers/net/ethernet/freescale/fec_main.c             | 16 ++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c       | 12 +++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c       | 22 +++++++++++-----------
 drivers/net/ethernet/mellanox/mlx5/core/eq.c          |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c  |  9 ++++-----
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/wq.c          |  5 -----
 drivers/net/ethernet/mellanox/mlx5/core/wq.h          | 11 +++++------
 drivers/net/ethernet/mellanox/mlxsw/core.c            |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/core.h            |  4 ++++
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c      | 17 +++++++++++------
 drivers/net/ethernet/mscc/ocelot.c                    |  6 +++---
 drivers/net/ethernet/netronome/nfp/flower/action.c    | 51 +++++++++++++++++++++++++++++++++------------------
 drivers/net/ethernet/qlogic/qed/qed_int.c             |  2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c                 |  2 --
 drivers/net/ethernet/realtek/r8169.c                  | 20 +++++---------------
 drivers/net/geneve.c                                  | 14 +++-----------
 drivers/net/virtio_net.c                              |  5 ++++-
 drivers/net/vxlan.c                                   | 12 ++----------
 drivers/ptp/ptp_chardev.c                             |  4 ++++
 include/linux/mlx5/driver.h                           |  8 ++++++++
 include/net/dst.h                                     | 10 ++++++++++
 include/net/ip6_fib.h                                 |  4 ++++
 include/net/sctp/sm.h                                 |  2 +-
 include/net/sctp/structs.h                            |  2 ++
 include/uapi/linux/sctp.h                             |  1 +
 kernel/bpf/xskmap.c                                   | 10 ++--------
 net/bpfilter/bpfilter_kern.c                          |  6 ++++--
 net/core/ethtool.c                                    | 11 +++++++++--
 net/ipv4/ipmr_base.c                                  |  2 --
 net/ipv6/ip6_tunnel.c                                 | 10 +++++-----
 net/ipv6/mcast.c                                      | 16 ++++++++--------
 net/ipv6/route.c                                      | 12 ++++++------
 net/ipv6/udp.c                                        |  6 ++----
 net/ipv6/xfrm6_policy.c                               |  4 ++--
 net/llc/llc_conn.c                                    |  1 +
 net/rxrpc/call_accept.c                               |  2 +-
 net/rxrpc/local_object.c                              |  2 +-
 net/rxrpc/output.c                                    |  3 ++-
 net/rxrpc/peer_event.c                                |  1 +
 net/sched/cls_api.c                                   | 13 ++++++++-----
 net/sched/sch_api.c                                   | 11 ++++++-----
 net/sctp/associola.c                                  |  3 ++-
 net/sctp/input.c                                      |  1 +
 net/sctp/output.c                                     |  6 ++++++
 net/sctp/socket.c                                     | 17 +++++++++--------
 net/socket.c                                          | 11 ++++++++---
 net/tipc/group.c                                      |  1 +
 net/tipc/link.c                                       |  1 +
 net/tipc/name_distr.c                                 |  4 ++--
 net/xdp/xsk.c                                         |  2 ++
 net/xfrm/xfrm_interface.c                             |  3 +++
 net/xfrm/xfrm_policy.c                                |  8 ++++----
 tools/testing/selftests/net/reuseport_bpf.c           | 13 +++++++++----
 57 files changed, 253 insertions(+), 187 deletions(-)
