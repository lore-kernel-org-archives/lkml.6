Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4F9208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4F9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeKLIQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41076 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeKLIQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A0BD10081DA7;
        Sun, 11 Nov 2018 14:26:49 -0800 (PST)
Date:   Sun, 11 Nov 2018 14:26:49 -0800 (PST)
Message-Id: <20181111.142649.1250091930241970662.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=euc-kr
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 14:26:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


One last pull request before heading to Vancouver for LPC, here we have:

1) Don't forget to free VSI contexts during ice driver unload, from
   Victor Raj.

2) Don't forget napi delete calls during device remove in ice driver,
   from Dave Ertman.

3) Don't request VLAN tag insertion of ibmvnic device when SKB doesn't
   have VLAN tags at all.

4) IPV4 frag handling code has to accomodate the situation where two
   threads try to insert the same fragment into the hash table at the
   same time.  From Eric Dumazet.

5) Relatedly, don't flow separate on protocol ports for fragmented
   frames, also from Eric Dumazet.

6) Memory leaks in qed driver, from Denis Bolotin.

7) Correct valid MTU range in smsc95xx driver, from Stefan Wahren.

8) Validate cls_flower nested policies properly, from Jakub Kicinski.

9) Clearing of stats counters in mc88e6xxx driver doesn't retain
   important bits in the G1_STATS_OP register causing the chip to
   hang.  Fix from Andrew Lunn.

Please pull, thanks a lot!

The following changes since commit 8053e5b93eca9b011f7b79bb019bf1eeaaf96c4b:

  Merge tag 'trace-v4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2018-11-06 08:12:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 7236ead1b14923f3ba35cd29cce13246be83f451:

  act_mirred: clear skb->tstamp on redirect (2018-11-11 10:21:31 -0800)

----------------------------------------------------------------
Akeem G Abodunrin (1):
      ice: Fix dead device link issue with flow control

Alexandre Belloni (1):
      net: mvneta: correct typo

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix clearing of stats counters

Anirudh Venkataramanan (4):
      ice: Set carrier state and start/stop queues in rebuild
      ice: Check for reset in progress during remove
      ice: Remove duplicate addition of VLANs in replay path
      ice: Fix typo in error message

Brett Creeley (2):
      ice: Fix tx_timeout in PF driver
      ice: Fix the bytecount sent to netdev_tx_sent_queue

Chinh T Cao (1):
      ice: Change req_speeds to be u16

Dave Ertman (1):
      ice: Fix napi delete calls for remove

David S. Miller (4):
      Merge branch '100GbE' of git://git.kernel.org/.../jkirsher/net-queue
      Merge branch 'FDDI-defza-Fix-a-bunch-of-small-issues'
      Merge branch 'qed-Slowpath-Queue-bug-fixes'
      Merge branch 'aquantia-fixes'

Denis Bolotin (3):
      qed: Fix memory/entry leak in qed_init_sp_request()
      qed: Fix blocking/unlimited SPQ entries leak
      qed: Fix SPQ entries not returned to pool in error flows

Dmitry Bogdanov (3):
      net: aquantia: fix potential IOMMU fault after driver unbind
      net: aquantia: invalid checksumm offload implementation
      net: aquantia: allow rx checksum offload configuration

Eric Dumazet (2):
      inet: frags: better deal with smp races
      act_mirred: clear skb->tstamp on redirect

Huazhong Tan (1):
      net: hns3: bugfix for not checking return value

Igor Russkikh (2):
      net: aquantia: synchronized flow control between mac/phy
      net: aquantia: fixed enable unicast on 32 macvlan

Jacob Keller (2):
      i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features
      i40e: enable NETIF_F_NTUPLE and NETIF_F_HW_TC at driver load

Jakub Kicinski (1):
      net: sched: cls_flower: validate nested enc_opts_policy to avoid warning

Jon Maloy (1):
      tipc: fix link re-establish failure

Maciej W. Rozycki (4):
      FDDI: defza: Fix SPDX annotation
      FDDI: defza: Add missing comment closing
      FDDI: defza: Move SMT Tx data buffer declaration next to its skb
      FDDI: defza: Make the driver version string constant

Md Fahad Iqbal Polash (1):
      ice: Fix flags for port VLAN

Micha©© Miros©©aw (2):
      ibmvnic: fix accelerated VLAN handling
      qlcnic: remove assumption that vlan_tci != 0

Miroslav Lichvar (1):
      igb: shorten maximum PHC timecounter update interval

Sagiv Ozeri (1):
      qed: Fix potential memory corruption

Stefan Wahren (1):
      net: smsc95xx: Fix MTU range

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix incorrect assignment of real_dev

Tao Ren (1):
      net: phy: Allow BCM54616S PHY to setup internal TX/RX clock delay

Thor Thayer (1):
      net: stmmac: Fix RX packet size > 8191

Victor Raj (1):
      ice: Free VSI contexts during for unload

¹è¼®Áø (1):
      flow_dissector: do not dissect l4 ports for fragments

 drivers/net/dsa/mv88e6xxx/global1.c                                 |  2 ++
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c                 |  8 ++++----
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                      |  6 ++++++
 drivers/net/ethernet/aquantia/atlantic/aq_main.c                    | 10 ++++++++--
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                     | 18 +++++++++++++++---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h                     |  2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                    | 35 +++++++++++++++++++++++------------
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c           | 61 ++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c          |  8 ++++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h          |  3 +++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h | 18 ++++++++++++++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c   | 21 +++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                     |  3 ++-
 drivers/net/ethernet/ibm/ibmvnic.c                                  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c                         |  8 +++++---
 drivers/net/ethernet/intel/ice/ice.h                                |  4 +++-
 drivers/net/ethernet/intel/ice/ice_common.c                         |  3 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c                        |  7 ++++++-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h                     |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c                            |  3 ++-
 drivers/net/ethernet/intel/ice/ice_main.c                           | 86 ++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------
 drivers/net/ethernet/intel/ice/ice_switch.c                         | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_switch.h                         |  2 ++
 drivers/net/ethernet/intel/ice/ice_txrx.c                           | 11 ++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.h                           | 17 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_type.h                           |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c                    |  4 +---
 drivers/net/ethernet/intel/igb/igb_ptp.c                            | 12 +++++++-----
 drivers/net/ethernet/marvell/mvneta.c                               |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c                          | 11 ++++++++---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c                         |  1 +
 drivers/net/ethernet/qlogic/qed/qed_l2.c                            | 12 ++++++++----
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                          |  1 +
 drivers/net/ethernet/qlogic/qed/qed_roce.c                          |  1 +
 drivers/net/ethernet/qlogic/qed/qed_sp.h                            | 14 ++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c                   | 22 ++++++++++++++++++++--
 drivers/net/ethernet/qlogic/qed/qed_spq.c                           | 69 +++++++++++++++++++++++++++++++++++----------------------------------
 drivers/net/ethernet/qlogic/qed/qed_sriov.c                         |  1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c                      |  8 +++++---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c                     |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/common.h                        |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h                     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c                     |  2 +-
 drivers/net/fddi/defza.c                                            |  7 ++++---
 drivers/net/fddi/defza.h                                            |  3 ++-
 drivers/net/phy/broadcom.c                                          | 18 ++++++++++++++++--
 drivers/net/usb/smsc95xx.c                                          |  2 ++
 net/core/flow_dissector.c                                           |  4 ++--
 net/ipv4/inet_fragment.c                                            | 29 +++++++++++++++--------------
 net/sched/act_mirred.c                                              |  3 ++-
 net/sched/cls_flower.c                                              | 14 +++++++++++++-
 net/sched/sch_netem.c                                               |  9 ---------
 net/tipc/link.c                                                     | 11 +++++++----
 54 files changed, 430 insertions(+), 199 deletions(-)
