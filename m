Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBFUJO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:09:14 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48772 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeBFUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:09:12 -0500
Date: Tue, 06 Feb 2018 15:09:09 -0500 (EST)
Message-Id: <20180206.150909.1230964506403663055.davem@davemloft.net>
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


1) Fix error path in netdevsim, from Jakub Kicinski.

2) Default values listed in tcp_wmem and tcp_rmem documentation
   were inaccurate, from Tonghao Zhang.

3) Fix route leaks in SCTP, both for ipv4 and ipv6.  From Alexey
   Kodanev and Tommi Rantala.

4) Fix "MASK < Y" meant to be "MASK << Y" in xgbe driver, from
   Wolfram Sang.

5) Use after free in u32_destroy_key(), from Paolo Abeni.

6) Fix two TX issues in be2net driver, from Suredh Reddy.

Please pull, thanks a lot!

The following changes since commit 35277995e17919ab838beae765f440674e8576eb:

  Merge branch 'x86-pti-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2018-02-04 11:45:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 176bfb406d735655f9a69d868a7af0c3da959d51:

  Merge branch 'be2net-patch-set' (2018-02-06 11:48:40 -0500)

----------------------------------------------------------------
Alexei Starovoitov (2):
      bpf: fix bpf_prog_array_copy_to_user() issues
      Merge branch 'libbpf-xdp-support'

Alexey Kodanev (1):
      sctp: fix dst refcnt leak in sctp_v6_get_dst()

Andrew Lunn (1):
      net: phy: Handle not having GPIO enabled in the kernel

Daniel Borkmann (1):
      bpf: fix null pointer deref in bpf_prog_test_run_xdp

David S. Miller (3):
      Merge git://git.kernel.org/.../bpf/bpf
      Merge branch 'net-erspan-fixes'
      Merge branch 'be2net-patch-set'

Desnes Augusto Nunes do Rosario (1):
      ibmvnic: fix empty firmware version and errors cleanup

Eric Leblond (5):
      tools: add netlink.h and if_link.h in tools uapi
      libbpf: add function to setup XDP
      libbpf: add error reporting in XDP
      libbpf: add missing SPDX-License-Identifier
      samples/bpf: use bpf_set_link_xdp_fd

Guanglei Li (1):
      RDS: IB: Fix null pointer issue

Jakub Kicinski (2):
      netdevsim: fix overflow on the error path
      nfp: fix kdoc warnings on nested structures

Jie Deng (1):
      dwc-xlgmac: remove Jie Deng as co-maintainer

Paolo Abeni (1):
      cls_u32: fix use after free in u32_destroy_key()

Suresh Reddy (2):
      be2net: Fix HW stall issue in Lancer
      be2net: Handle transmit completion errors in Lancer

Tommi Rantala (1):
      sctp: fix dst refcnt leak in sctp_v4_get_dst

Tonghao Zhang (1):
      doc: Change the min default value of tcp_wmem/tcp_rmem.

William Tu (3):
      net: erspan: fix metadata extraction
      net: erspan: fix erspan config overwrite
      sample/bpf: fix erspan metadata

Wolfram Sang (1):
      net: amd-xgbe: fix comparison to bitshift when dealing with a mask

Yonghong Song (2):
      tools/bpf: permit selftests/bpf to be built in a different directory
      bpf: add documentation to compare clang "-target bpf" and default target

 Documentation/bpf/bpf_devel_QA.txt                        |  31 +++
 Documentation/networking/ip-sysctl.txt                    |   4 +-
 MAINTAINERS                                               |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                  |   2 +-
 drivers/net/ethernet/emulex/benet/be.h                    |   7 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c            |   1 +
 drivers/net/ethernet/emulex/benet/be_hw.h                 |   1 +
 drivers/net/ethernet/emulex/benet/be_main.c               | 113 +++++-----
 drivers/net/ethernet/ibm/ibmvnic.c                        |  14 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.h             |  24 +--
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c   |  10 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h              |   6 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h      |  43 ++--
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c |  21 +-
 drivers/net/netdevsim/bpf.c                               |   5 +-
 drivers/net/phy/mdio_bus.c                                |   3 +-
 include/linux/netdevice.h                                 |   6 +
 include/net/erspan.h                                      |  26 +--
 kernel/bpf/core.c                                         |  32 ++-
 net/bpf/test_run.c                                        |   4 +
 net/ipv4/ip_gre.c                                         |  14 +-
 net/ipv6/ip6_gre.c                                        |  15 +-
 net/rds/ib.c                                              |   3 +-
 net/sched/cls_u32.c                                       |  21 +-
 net/sctp/ipv6.c                                           |  10 +-
 net/sctp/protocol.c                                       |  10 +-
 samples/bpf/Makefile                                      |   2 +-
 samples/bpf/bpf_load.c                                    | 102 ---------
 samples/bpf/bpf_load.h                                    |   2 +-
 samples/bpf/tcbpf2_kern.c                                 |  41 ++--
 samples/bpf/test_tunnel_bpf.sh                            |   4 +-
 samples/bpf/xdp1_user.c                                   |   4 +-
 samples/bpf/xdp_redirect_cpu_user.c                       |   6 +-
 samples/bpf/xdp_redirect_map_user.c                       |   8 +-
 samples/bpf/xdp_redirect_user.c                           |   8 +-
 samples/bpf/xdp_router_ipv4_user.c                        |  10 +-
 samples/bpf/xdp_rxq_info_user.c                           |   4 +-
 samples/bpf/xdp_tx_iptunnel_user.c                        |   6 +-
 tools/include/uapi/linux/if_link.h                        | 943 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/netlink.h                        | 251 ++++++++++++++++++++++
 tools/lib/bpf/Build                                       |   2 +-
 tools/lib/bpf/Makefile                                    |   6 +
 tools/lib/bpf/bpf.c                                       | 135 ++++++++++++
 tools/lib/bpf/bpf.h                                       |   2 +
 tools/lib/bpf/libbpf.c                                    |   4 +
 tools/lib/bpf/libbpf.h                                    |   6 +
 tools/lib/bpf/nlattr.c                                    | 187 +++++++++++++++++
 tools/lib/bpf/nlattr.h                                    |  72 +++++++
 tools/testing/selftests/bpf/.gitignore                    |   1 +
 tools/testing/selftests/bpf/Makefile                      |   4 +-
 tools/testing/selftests/bpf/test_verifier.c               |  14 ++
 51 files changed, 1916 insertions(+), 335 deletions(-)
 create mode 100644 tools/include/uapi/linux/if_link.h
 create mode 100644 tools/include/uapi/linux/netlink.h
 create mode 100644 tools/lib/bpf/nlattr.c
 create mode 100644 tools/lib/bpf/nlattr.h
