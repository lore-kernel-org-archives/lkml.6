Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A32073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF9BGUIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfBEXzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:55:42 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40171 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfBEXzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:41 -0500
Received: by mail-pg1-f176.google.com with SMTP id z10so2115528pgp.7;
        Tue, 05 Feb 2019 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aI1v+H23/ZvIO3gX4umuhDThsa6Tzq1oIj/V7Nd0TRA=;
        b=KF9BGUIUvBhG4+MCAUAkUcjGX5AI1auHdzoMuhuy6vBH4Jwid48D62T6lrz7rmuTsg
         uInQxUimrCTwn5svY9xjCGUj1ECEzd/lZZ/izR/WT+XKVn2DZ2siJb4R2CTVUvyMLMg9
         RmkfOJRHNKI9XPlKEdg+/5qdP1R5Bz5B5puvL607Bs66FepWf3h1tY2/0RGRr9AkoMJS
         5Ed4sC/cmIsUeQoHg18+2S+rogIJgDKzn7q1PHcT0QsgV9VEuIYlFuvA8R72bkwL7o4L
         vNEFep+k2lrqmkqtKqrMP7tyXD3DurpKUWqJzVgxgVwfnPxgtCoN51u5Dzb2nTGuJ5/a
         s42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aI1v+H23/ZvIO3gX4umuhDThsa6Tzq1oIj/V7Nd0TRA=;
        b=S0L9hgus1Lm6kfZKPjwrF6G3GEzsGUVYhCtQ3NjtGvycF+6B6SBoUpGfoXG5YVO1iV
         /TewLD1aFyl4qVHng3THyNeHEkxu0u9glTrI/p9yt191rdrjzLd14cUpm2zy+pAVMp1e
         w1Nbzc+l/rEhSjZ2x66hri/3tVi8D/W4smw6BT2ymnVUfbcVw8kUEj7sSgowEMDeFDFq
         V/YDOnk4xvmsQeOYVUtDu69oyWBdRteJasICJnNflwUQFX4woOVCc7xonmD6XO9FLnd2
         6msAOk8xdqStLi2vIuM0Bw6iOBpIVocEHN28Rb/av2ZzInLO/YA8PVpgOYuj5YxOhZe+
         4w1g==
X-Gm-Message-State: AHQUAuaBzw9ATE5Se720e2hQIijexT6YyQQvzLzCgm0hJWZH1HtJXObR
        9+q9ZYxWrEPaj/lrxDcyUbKNrIN+
X-Google-Smtp-Source: AHgI3IaqKrsc0YWdEdNGDN4pvxxh3tC0lueXpz+LZw0dYqkuZCBlJ/njb5LBuPTirt9S08k5BVjhLg==
X-Received: by 2002:a62:4618:: with SMTP id t24mr7570719pfa.139.1549410940282;
        Tue, 05 Feb 2019 15:55:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:39 -0800 (PST)
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
Subject: [PATCH net-next v3 00/12] net: Introduce ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:14 -0800
Message-Id: <20190205235326.14600-1-f.fainelli@gmail.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 ++--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 ++-----
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 +++-----
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 ++++------
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 --
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 36 +++++-------
 drivers/net/ethernet/mscc/ocelot.c            | 33 +++++------
 .../ethernet/netronome/nfp/flower/action.c    |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +-
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 23 ++------
 drivers/net/ethernet/netronome/nfp/nfp_port.h |  4 +-
 drivers/net/ethernet/rocker/rocker_main.c     | 17 ++++--
 drivers/net/netdevsim/netdev.c                | 23 ++------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 16 ++++--
 include/linux/netdevice.h                     |  9 +++
 include/net/switchdev.h                       | 11 ----
 net/bridge/br_switchdev.c                     | 11 ++--
 net/core/dev.c                                | 57 +++++++++++++++++++
 net/core/net-sysfs.c                          | 12 +---
 net/core/rtnetlink.c                          | 14 ++---
 net/dsa/slave.c                               | 18 ++++--
 net/ipv4/ipmr.c                               | 14 ++---
 net/switchdev/switchdev.c                     | 20 -------
 30 files changed, 219 insertions(+), 260 deletions(-)

-- 
2.17.1

