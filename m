Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DB20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeG3VvY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:51:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36780 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeG3VvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:51:24 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1628113FC9150;
        Mon, 30 Jul 2018 13:14:46 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:14:45 -0700 (PDT)
Message-Id: <20180730.131445.1852535914023760831.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 13:14:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Several small'ish fixes, I don't think any of this requires
another -rc but I'll leave that up to you:

1) Don't leak uninitialzed bytes to userspace in xfrm_user, from Eric
   Dumazet.

2) Route leak in xfrm_lookup_route(), from Tommi Rantala.

3) Premature poll() returns in AF_XDP, from Björn Töpel.

4) devlink leak in netdevsim, from Jakub Kicinski.

5) Don't BUG_ON in fib_compute_spec_dst, the condition can
   legitimately happen.  From Lorenzo Bianconi.

6) Fix some spectre v1 gadgets in generic socket code, from
   Jeremy Cline.

7) Don't allow user to bind to out of range multicast groups,
   from Dmitry Safonov with a follow-up by Dmitry Safonov.

8) Fix metrics leak in fib6_drop_pcpu_from(), from Sabrina Dubroca.

Please pull, thanks a lot!

The following changes since commit 9981b4fb8684883dcc0daf088891ff32260b9794:

  Merge tag 'mips_fixes_4.18_4' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux (2018-07-24 18:11:15 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 61f4b23769f0cc72ae62c9a81cf08f0397d40da8:

  netlink: Don't shift with UB on nlk->ngroups (2018-07-30 12:42:22 -0700)

----------------------------------------------------------------
Anton Vasilyev (2):
      net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Arjun Vynipadath (1):
      cxgb4: Added missing break in ndo_udp_tunnel_{add/del}

Avinash Repaka (1):
      RDS: RDMA: Fix the NULL-ptr deref in rds_ib_get_mr

Björn Töpel (1):
      xsk: fix poll/POLLIN premature returns

Daniel Borkmann (2):
      Merge branch 'bpf-annotate-kv-pair'
      bpf: fix bpf_skb_load_bytes_relative pkt length check

David S. Miller (4):
      Merge branch 'master' of git://git.kernel.org/.../klassert/ipsec
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'net-socket-Fix-potential-spectre-v1-gadgets'
      Merge tag 'linux-can-fixes-for-4.18-20180730' of ssh://gitolite.kernel.org/.../mkl/linux-can

Dmitry Safonov (2):
      netlink: Do not subscribe to non-existent groups
      netlink: Don't shift with UB on nlk->ngroups

Eric Dumazet (1):
      xfrm_user: prevent leaking 2 bytes of kernel memory

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Eyal Birger (1):
      vti6: fix PMTU caching and reporting on xmit

Florian Westphal (1):
      xfrm: free skb if nlsk pointer is NULL

Gal Pressman (1):
      net: ena: Fix use of uninitialized DMA address bits field

Govindarajulu Varadarajan (1):
      enic: handle mtu change for vf properly

Jakub Kicinski (1):
      netdevsim: don't leak devlink resources

Jeremy Cline (2):
      net: socket: fix potential spectre v1 gadget in socketcall
      net: socket: Fix potential spectre v1 gadget in sock_is_registered

John Hurley (1):
      nfp: flower: fix port metadata conversion bug

Justin Pettit (1):
      openvswitch: meter: Fix setting meter id for new entries

Lawrence Brakmo (1):
      tcp: ack immediately when a cwr packet arrives

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Martin KaFai Lau (5):
      bpf: btf: Ensure the member->offset is in the right order
      bpf: btf: Sync uapi btf.h to tools
      bpf: Replace [u]int32_t and [u]int64_t in libbpf
      bpf: Introduce BPF_ANNOTATE_KV_PAIR
      bpf: btf: Use exact btf value_size match in map_check_btf()

Neal Cardwell (1):
      tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

Sabrina Dubroca (1):
      net/ipv6: fix metrics leak

Stefan Wahren (1):
      net: lan78xx: fix rx handling before first packet is send

Taehee Yoo (2):
      xdp: add NULL pointer check in __xdp_return()
      bpf: use GFP_ATOMIC instead of GFP_KERNEL in bpf_parse_prog()

Tariq Toukan (1):
      net: rollback orig value on failure of dev_qdisc_change_tx_queue_len

Thomas Richter (1):
      perf build: Build error in libbpf missing initialization

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and multicast

Toshiaki Makita (1):
      virtio_net: Fix incosistent received bytes counter

Wang YanQing (1):
      bpf, x32: Fix regression caused by commit 24dea04767e6

Wei Yongjun (1):
      net: igmp: make function __ip_mc_inc_group() static

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Zhen Lei (1):
      esp6: fix memleak on error path in esp6_input

dann frazier (1):
      hinic: Link the logical network device to the pci device in sysfs

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue

 arch/x86/net/bpf_jit_comp32.c                     |   8 +++---
 drivers/net/can/usb/ems_usb.c                     |   1 +
 drivers/net/ethernet/amazon/ena/ena_com.c         |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |   4 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   2 ++
 drivers/net/ethernet/cisco/enic/enic_main.c       |  78 ++++++++++++++++++--------------------------------
 drivers/net/ethernet/huawei/hinic/hinic_main.c    |   1 +
 drivers/net/ethernet/netronome/nfp/flower/main.c  |   4 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/netdevsim/devlink.c                   |   1 +
 drivers/net/phy/mdio-mux-bcm-iproc.c              |   2 +-
 drivers/net/usb/lan78xx.c                         |   2 ++
 drivers/net/virtio_net.c                          |  41 ++++++++++++++------------
 drivers/net/xen-netfront.c                        |   6 ++++
 kernel/bpf/arraymap.c                             |   2 +-
 kernel/bpf/btf.c                                  |  14 ++++++++-
 net/core/dev.c                                    |  17 ++++++-----
 net/core/filter.c                                 |  12 ++++----
 net/core/lwt_bpf.c                                |   2 +-
 net/core/xdp.c                                    |   3 +-
 net/ipv4/fib_frontend.c                           |   4 +--
 net/ipv4/igmp.c                                   |   3 +-
 net/ipv4/tcp_bbr.c                                |   4 +++
 net/ipv4/tcp_input.c                              |   9 +++++-
 net/ipv6/esp6.c                                   |   4 ++-
 net/ipv6/ip6_fib.c                                |  18 +++++++++---
 net/ipv6/ip6_vti.c                                |  11 +++----
 net/netlink/af_netlink.c                          |   5 ++++
 net/openvswitch/meter.c                           |  10 +++----
 net/rds/ib_frmr.c                                 |   5 ++++
 net/rds/ib_mr.h                                   |   3 +-
 net/rds/ib_rdma.c                                 |  21 ++++++++------
 net/rds/rdma.c                                    |  13 +++++----
 net/rds/rds.h                                     |   5 +++-
 net/rds/send.c                                    |  12 ++++----
 net/socket.c                                      |   5 +++-
 net/xdp/xsk_queue.h                               |   2 +-
 net/xfrm/xfrm_policy.c                            |   3 ++
 net/xfrm/xfrm_user.c                              |  18 +++++++-----
 tools/include/uapi/linux/btf.h                    |   2 +-
 tools/lib/bpf/btf.c                               |  39 ++++++++++++-------------
 tools/lib/bpf/btf.h                               |  10 ++++---
 tools/lib/bpf/libbpf.c                            |  87 +++++++++++++++++++++++++++++--------------------------
 tools/lib/bpf/libbpf.h                            |   4 +--
 tools/testing/selftests/bpf/bpf_helpers.h         |   9 ++++++
 tools/testing/selftests/bpf/test_btf.c            | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 tools/testing/selftests/bpf/test_btf_haskv.c      |   7 ++---
 47 files changed, 412 insertions(+), 218 deletions(-)
