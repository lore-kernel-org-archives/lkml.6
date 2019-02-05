Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A5FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0962054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivmBfcNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfBEWN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:13:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35468 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbfBEWN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id b17so123794eds.2;
        Tue, 05 Feb 2019 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y+ay6SV/BFYUMRbOxWKkp7WjzKgRjee0FGJy6UkTvYI=;
        b=ivmBfcNwjjQxi17W5sZ3yKZRKRnCfR/z7Ve40DljruO78jg7NPH2BDH6TDyg1J655U
         vh5pxM0WGrua21AznJn8ttrFL0ZWQo3J2RXWY7VUXNex/aNPjwkth5XhgpwhfiwY/+Bk
         9r7xfTKHksh2UV9qlTNtCguqNDISbvL/EuKEqqg7jNS20M2CYtoERDDpFGVNCvHHUkqx
         0vbgG+ylg5rWhAIN2OUZCtnl0Feo0CdbRje1A9tAyBlfPC9whmhkPt/cP5SYarpSza73
         BdvhMpQAyysL670o2mg8Ciwwd5pIjJWCuiCd3ivaK7VI5vQvNFkMZq3DFgV3u/Dgsv56
         6bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y+ay6SV/BFYUMRbOxWKkp7WjzKgRjee0FGJy6UkTvYI=;
        b=TDfOujUBn6ov3Eq/4aoi79AcDwwfJrTvCsJeNN6MRn5dTbdFjOJAW9beHl/QxszoPu
         mJp2KqE7DvB0ncdkb27zcqAGV7h4a3u3dIWZRty5GCaPxFdKhymxlPWmMNA6jUTljxIy
         cdQBu5PqjA+iold5CEo+m8EjRZGCpcOUJDF9i1MkovXGyvFO/50kdnE7Nky5lTRn+ppR
         +MKGi2xPp8if8NcolHpzIe/oJnuyOCMLx8lQB6RV5fNNpNAL1X3KY4eB3L0k8R4hDOm9
         ModQBp8XkPhbVVykSWC8B61ibnLfn6cDknUEHGQe/k2iYpD9H9RiGqPPuB18cRUAjTwy
         /31w==
X-Gm-Message-State: AHQUAubbb86YJm2hizgJom55YHrH/fsrLPxAeg+iwtjgByKfvMsNW6ap
        xJp7feXYMbuINtgQSdIWbrIdzKI2
X-Google-Smtp-Source: AHgI3IZ6rBXMKArkzMzNelMUndppkrvZcsXlIc5vjhiJMoF5WF/OGdoWqdkkfBBP1TYnOY7qZxMqwg==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr5620606eds.91.1549404806380;
        Tue, 05 Feb 2019 14:13:26 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:25 -0800 (PST)
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
Subject: [PATCH net-next v2 00/12] net: Introduce ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:12:59 -0800
Message-Id: <20190205221311.18476-1-f.fainelli@gmail.com>
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
 drivers/net/netdevsim/netdev.c                | 22 ++-----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 17 ++++--
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

