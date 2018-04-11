Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeDKVx0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:53:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47250 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeDKVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:53:24 -0400
Date: Wed, 11 Apr 2018 17:53:22 -0400 (EDT)
Message-Id: <20180411.175322.2116697573480908121.davem@davemloft.net>
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


1) In ip_gre tunnel, handle the conflict between TUNNEL_{SEQ,CSUM} and
   GSO/LLTX properly.  From Sabrina Dubroca.

2) Stop properly on error in lan78xx_read_otp(), from Phil Elwell.

3) Don't uncompress in slip before rstate is initialized, from Tejaswi
   Tanikella.

4) When using 1.x firmware on aquantia, issue a deinit before we
   hardware reset the chip, otherwise we break dirty wake WOL.  From
   Igor Russkikh.

5) Correct log check in vhost_vq_access_ok(), from Stefan Hajnoczi.

6) Fix ethtool -x crashes in bnxt_en, from Michael Chan.

7) Fix races in l2tp tunnel creation and duplicate tunnel detection,
   from Guillaume Nault.

Please pull, thanks a lot!

The following changes since commit c18bb396d3d261ebbb4efbc05129c5d354c541e4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-04-09 17:04:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 0c84cee8f131a090f77f5a3dea5d6a7bd99c00db:

  Merge branch 'l2tp-tunnel-creation-fixes' (2018-04-11 17:41:28 -0400)

----------------------------------------------------------------
Andy Gospodarek (1):
      bnxt_en: do not allow wildcard matches for L2 flows

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

David S. Miller (4):
      Merge branch 'Aquantia-atlantic-critical-fixes-04-2018'
      Merge branch 'vhost-fix-vhost_vq_access_ok-log-check'
      Merge branch 'bnxt_en-Fixes-for-net'
      Merge branch 'l2tp-tunnel-creation-fixes'

Eric Auger (1):
      vhost: Fix vhost_copy_to_user()

Guillaume Nault (2):
      l2tp: fix races in tunnel creation
      l2tp: fix race in duplicate tunnel detection

Igor Russkikh (2):
      net: aquantia: Regression on reset with 1.x firmware
      net: aquantia: oops when shutdown on already stopped device

Ka-Cheong Poon (1):
      rds: MP-RDS may use an invalid c_path

Michael Chan (3):
      bnxt_en: Fix ethtool -x crash when device is down.
      bnxt_en: Need to include RDMA rings in bnxt_check_rings().
      bnxt_en: Fix NULL pointer dereference at bnxt_free_irq().

Phil Elwell (3):
      lan78xx: Correctly indicate invalid OTP
      lan78xx: Avoid spurious kevent 4 "error"
      lan78xx: Don't reset the interface on open

Sabrina Dubroca (3):
      ip_gre: clear feature flags when incompatible o_flags are set
      tun: set the flags before registering the netdevice
      tun: send netlink notification when the device is modified

Sriharsha Basavapatna (2):
      bnxt_en: Ignore src port field in decap filter nodes
      bnxt_en: Support max-mtu with VF-reps

Stefan Hajnoczi (2):
      vhost: fix vhost_vq_access_ok() log check
      vhost: return bool from *_access_ok() functions

Tejaswi Tanikella (1):
      slip: Check if rstate is initialized before uncompressing

 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |   8 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c |  16 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                    |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c            |  11 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                 |  63 +++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c                |  30 ++++++++
 drivers/net/slip/slhc.c                                      |   5 ++
 drivers/net/tun.c                                            |  33 ++++++--
 drivers/net/usb/cdc_ether.c                                  |   6 ++
 drivers/net/usb/lan78xx.c                                    |   9 +--
 drivers/vhost/vhost.c                                        |  72 +++++++++---------
 drivers/vhost/vhost.h                                        |   4 +-
 include/net/slhc_vj.h                                        |   1 +
 net/ipv4/ip_gre.c                                            |   6 ++
 net/l2tp/l2tp_core.c                                         | 225 ++++++++++++++++++++++++-------------------------------
 net/l2tp/l2tp_core.h                                         |   4 +-
 net/l2tp/l2tp_netlink.c                                      |  22 +++---
 net/l2tp/l2tp_ppp.c                                          |   9 +++
 net/rds/send.c                                               |  15 ++--
 19 files changed, 345 insertions(+), 198 deletions(-)
