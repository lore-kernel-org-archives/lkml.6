Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeCaHFi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:05:38 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:39944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751483AbeCaHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:36 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:960:966:968:973:988:989:1260:1345:1437:1534:1543:1711:1730:1747:1777:1792:1801:1981:2194:2196:2199:2200:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3874:4250:4385:4605:5007:6261:10004:10848:11026:11657:11658:11914:12043:12048:12296:12438:12555:12679:12895:13161:13229:14096:14394:14721:21080:21433:21451:21627:30003:30054:30055,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: bell55_87e18b8d8fd34
X-Filterd-Recvd-Size: 4157
From: Joe Perches <joe@perches.com>
To: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, bridge@lists.linux-foundation.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com
Subject: [PATCH 00/12] Ethernet: Add and use ether_<type>_addr globals
Date: Sat, 31 Mar 2018 00:05:15 -0700
Message-Id: <cover.1522479607.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many local static and non-static arrays that are used for
Ethernet broadcast address output or comparison.

Centralize the array into a single separate file and remove the local
arrays.

Joe Perches (12):
  ethernet: Add generic ether_<foo>_addr addresses
  treewide/net: Rename eth_stp_addr to ether_stp_addr
  net: mac80211: Use global ether_broadcast_addr
  bridge: netfilter: Use the new global ether_<foo>_addr arrays
  net: atm: Use ether_broadcast_addr
  wireless: Convert simple uses of a static const Ethernet broadcast address
  brcmfmac: Convert ALLFFMAC to ether_broadcast_addr
  iwlegacy: Remove EXPORT_SYMBOL(il_bcast_addr) and use ether_broadcast_addr
  iwlwifi: Remove local iwl_bcast_addr and use ether_broadcast_addr
  mvpp2: Use ether_broadcast_addr instead of a local array
  qlogic: Convert local bcast_addr to global ether_broadcast_addr
  ethernet: Use ether_zero_addr instead of local statics

 drivers/net/dsa/lan9303-core.c                        |  4 ++--
 drivers/net/ethernet/broadcom/b44.c                   |  5 ++---
 drivers/net/ethernet/freescale/gianfar.c              |  3 +--
 drivers/net/ethernet/marvell/mvpp2.c                  |  4 +---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    |  5 +----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c        |  6 ++----
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c  |  6 ++----
 drivers/net/wireless/admtek/adm8211.c                 |  3 +--
 drivers/net/wireless/ath/carl9170/mac.c               |  4 +---
 drivers/net/wireless/broadcom/b43/main.c              |  3 +--
 .../net/wireless/broadcom/brcm80211/brcmfmac/common.c |  2 --
 .../net/wireless/broadcom/brcm80211/brcmfmac/common.h |  2 --
 .../wireless/broadcom/brcm80211/brcmfmac/flowring.c   |  8 ++++----
 drivers/net/wireless/intel/iwlegacy/3945-mac.c        |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c        |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c          |  3 ---
 drivers/net/wireless/intel/iwlegacy/common.h          |  1 -
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h          |  1 -
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c          |  4 +---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c       |  3 +--
 drivers/net/wireless/realtek/rtlwifi/core.c           |  5 ++---
 drivers/net/wireless/rndis_wlan.c                     |  6 +-----
 drivers/net/wireless/ti/wl1251/main.c                 |  5 +----
 drivers/net/wireless/ti/wlcore/main.c                 |  5 +----
 include/linux/etherdevice.h                           | 13 +++++++++----
 net/atm/lec.c                                         | 12 +++++-------
 net/bridge/br_device.c                                |  4 ++--
 net/bridge/netfilter/ebt_stp.c                        |  6 ++----
 net/ethernet/Makefile                                 |  2 +-
 net/ethernet/ether_addrs.c                            | 19 +++++++++++++++++++
 net/mac80211/iface.c                                  |  5 +----
 net/mac80211/key.c                                    |  6 ++----
 net/mac80211/mesh_hwmp.c                              | 19 ++++++++++---------
 net/mac80211/mesh_pathtbl.c                           |  8 ++++----
 35 files changed, 83 insertions(+), 105 deletions(-)
 create mode 100644 net/ethernet/ether_addrs.c

-- 
2.15.0
