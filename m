Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A5C2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwRrIr1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfBFRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42292 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so3399366pfr.9;
        Wed, 06 Feb 2019 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=soD9Dgs2FvVHhYFf8XnK6PEgV8iisdLfjJhmqRKiqfU=;
        b=MwRrIr1G0Aw8SyrU/MZ3zTlCZYRXtiHnu+1luyabcIz5dLLZ2F1ZtkHNdKplfyIzSM
         krNDRru3ErDQu7gNIl+l10nfP7iN2pp2AEAfLWCqI2lJlBzRBvXrnRMmi66lB4Rrl+Y5
         yd/ZugGFrs+zxYQl1EO5G0Wm8SL1s1sfryfb9ppLXJO4Ce4ZnM9o1+/f3kh5RYvy9NBl
         yp5cepXURBgaqj6a8vFTTMprmTmtGozImxDGiDqtXY3K7hpj8NcDY1QyVhUTWOQAeJmm
         ZuCoVGng6MolfDKB9BXrNVUnr/QVx0U1I0YUxFUA1vjJPylDq0mFN+iUNV2i2LG8cUrO
         VLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=soD9Dgs2FvVHhYFf8XnK6PEgV8iisdLfjJhmqRKiqfU=;
        b=Q7TPcnie7lhD0z2vcp7TNRyvBHSXZFYy6n03MhkHp7yYkgPU3S5YEmgrdvIrEmZFRo
         4hN8xagDM/J/MDw9TNG6uNIt9xOPovqhRWAAkT6TzeCczzap3cqtUMjeF2zEz929bhsW
         FgmQvxD5P16prcGWl7GV6Zf9oY72dIaXfwM7MZCRQamvNpvX0gfFamUk/WWyRcrIVgGJ
         TIDZ5f4QjXmKSygLi0T3sQecJH4pWhMah2ed01QLVDv++T+/Ev1lorq38IR8N5VcDI+C
         7RK5tRHJO7Skf07qFj1tmr1//Xl+7szi0joLfU0ZFN8ivYX0m8nUccHVipluDDj0LNYt
         ykTg==
X-Gm-Message-State: AHQUAuaJFpp/nFtUmrTUdLcOmvndnB6gvvtumn8dJZmxI1GcdTBekbxC
        C0EOmqkrBsSsy+ltle5S7FQVZeZo
X-Google-Smtp-Source: AHgI3IZ6cqF9jkPFRAsmycZzL8PKS3Ja2w8P2IX4Mdwyy/Lu3tYs2p55gGb69ECdfpOE/SBdonJssA==
X-Received: by 2002:a63:7f46:: with SMTP id p6mr10703300pgn.54.1549475163780;
        Wed, 06 Feb 2019 09:46:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v4 00/12] net: Introduce ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:34 -0800
Message-Id: <20190206174546.23597-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Based on discussion with Ido and feedback from Jakub there are clearly
two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:

- PF/VF drivers which typically only implement return the port's parent
  ID, yet have to implement switchdev_port_attr_get() just for that

- Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
  attributes which we want to be able to eventually veto in the context
  of the caller, thus making them candidates for using a blocking notifier
  chain

Changes in v4:

- remove superfluous net/switchdev.h inclusions in a few files
- added Jiri's Acked-by where given
- removed err = -EOPNOTSUPP initializations
- changed according to Jiri's suggestion in net/ipv4/ipmr.c

Changes in v3:

- keep ethsw's switchdev_ops assignment
- remove inclusion of net/switchdev.h in netdevsim which is no longer
  necesary

Changes in v2:

- resolved build failures spotted by kbuild test robot
- added helpers functions into the core network device layer:
  dev_get_port_parent_id() and netdev_port_same_parent_id();
- added support for recursion to lower devices

Changes from RFC:

- introduce a ndo_get_port_parent_id() and convert all relevant drivers
  to use it

- get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

A subsequent set of patches will convert switchdev_port_attr_set() to
use a blocking notifier call, and still get rid of
switchdev_port_attr_get() altogether.

Florian Fainelli (12):
  net: Introduce ndo_get_port_parent_id()
  bnxt: Implement ndo_get_port_parent_id()
  liquidio: Implement ndo_get_port_parent_id()
  net/mlx5e: Implement ndo_get_port_parent_id()
  mlxsw: Implement ndo_get_port_parent_id()
  mscc: ocelot: Implement ndo_get_port_parent_id()
  nfp: Implement ndo_get_port_parent_id()
  rocker: Implement ndo_get_port_parent_id()
  netdevsim: Implement ndo_get_port_parent_id()
  staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
  net: dsa: Implement ndo_get_port_parent_id()
  net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 +++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 ++--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 ++-----
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 +++-----
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 ++++------
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 --
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 37 +++++-------
 drivers/net/ethernet/mscc/ocelot.c            | 33 +++++------
 .../ethernet/netronome/nfp/flower/action.c    |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +-
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 22 ++-----
 drivers/net/ethernet/netronome/nfp/nfp_port.h |  4 +-
 drivers/net/ethernet/rocker/rocker_main.c     | 17 ++++--
 drivers/net/netdevsim/netdev.c                | 23 ++------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 16 ++++--
 include/linux/netdevice.h                     |  9 +++
 include/net/switchdev.h                       | 11 ----
 net/bridge/br_switchdev.c                     |  9 +--
 net/core/dev.c                                | 57 +++++++++++++++++++
 net/core/net-sysfs.c                          | 12 +---
 net/core/rtnetlink.c                          | 12 +---
 net/dsa/slave.c                               | 18 ++++--
 net/ipv4/ipmr.c                               | 13 ++---
 net/switchdev/switchdev.c                     | 20 -------
 30 files changed, 214 insertions(+), 259 deletions(-)

-- 
2.17.1

