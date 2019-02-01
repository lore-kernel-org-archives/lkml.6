Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40282146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8ki6fjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfBAWID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:08:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35167 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBAWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:08:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so3568264pgs.2;
        Fri, 01 Feb 2019 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=shRZcfZXSpoJNw7v6WydagomunSXUd4xLMj+YXXhPFg=;
        b=u8ki6fjS7Wgs0KVuSZQbLYuC2wJ251oxcy8yPX9nHhc8Ezbl8DLpv8CeCitVXvGwAA
         rnuqTJVaqHQBQJvJP1hHUK5KcqjAEQHHVT/C8L+zFqykgu0N/RZS1QLjFHcNeJ76ZSkr
         ajsEr2udb2xp/L4ez2UNkutsuSWETPcv+l9tx/FiGI5/5h5UhojYQzo/je7QukM00p9R
         eoYNz+OwwEg/6uGpdEeS7n+vNU4uUe9cr0ux0EqAWZC2wnTMTH/IwTSb8Y08k9HVe1Oh
         xobDZrrGWwWFm6Zj22Ffw/0fzUc7xnuMUoVNiOxN3TMqwv6i3RMwf1g3QIoRwRNaC9V3
         RWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=shRZcfZXSpoJNw7v6WydagomunSXUd4xLMj+YXXhPFg=;
        b=TaS6PQC1RbOBcmt/jwK3F0Cv7V74Kqu98Ofsmy+O6qm0cuml59kcxgRLFgNjtbt8O5
         ZQDOIMxtPOwojMY89HIuNx6ctcQVgUl3D1PZx83EIuk2BlXABDWl/+3FI5vF7ZznY0uX
         Va7/fgfk5eAohz5XkkoHnERh7To/byyqKxjB8h5T8L/nEIVZdSyUYVIxESqy9aMH4e8g
         AS3DcaAsMqxbD4b0iP/EPurZfWQ4b8+3oWVGV+yLbvCwrQP0gSZk9dTGJs9bRlUOQQQ/
         r33FFg+kR6WReHysi210RltXl73/SdooNOIEZqZFHIog9EqNkELPI+d+n6ZbQd2YTHpO
         CoXQ==
X-Gm-Message-State: AHQUAubBHfAIsbIXOR6NJ1np5Oas+o+0u7W6ZgXOlwKeN4swZjsTBpPY
        23OudUvplp3jKam7rn6+F4bk+Y5J
X-Google-Smtp-Source: AHgI3IZiV0ZAgM57zVZuFPuxe6ng76m+RYxegGESNLbyEizeLeiowVe0Jk4CF4eMAJtIMvHPo5dw3A==
X-Received: by 2002:a65:43c5:: with SMTP id n5mr4078173pgp.250.1549058880032;
        Fri, 01 Feb 2019 14:08:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 78sm11142208pft.184.2019.02.01.14.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:07:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Subject: [RFC net-next 00/13] Get rid of switchdev_ops
Date:   Fri,  1 Feb 2019 14:06:44 -0800
Message-Id: <20190201220657.30170-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series converts SWITCHDEV_PORT_ATTR_{GET,SET} to use a
blocking notifier, similar to how SWITCHDEV_PORT_OBJ_{ADD,DEL} has been
changed recently by Petr.

This was suggested by Ido to help with a particular use case I have
where I want to be able to veto a switchdev bridge attribute from a
driver (multicast_snooping).

Please review since I may not have gotten the driver abstraction right,
especially for mlx5e and nfp since these are *hum* *hum* large drivers.

Florian Fainelli (13):
  switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
  rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
  bnxt: Handle SWITCHDEV_PORT_ATTR_GET event
  liquidio: Handle SWITCHDEV_PORT_ATTR_GET event
  mlxsw: switchx2: Handle SWITCHDEV_PORT_ATTR_GET event
  net/mlx5e: Handle SWITCHDEV_PORT_ATTR_GET event
  nfp: Handle SWITCHDEV_PORT_ATTR_GET event
  netdevsim: Handle SWITCHDEV_PORT_ATTR_GET event
  net: switchdev: Replace port attr get/set SDO with a notification

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  63 ++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.h |   8 ++
 .../net/ethernet/cavium/liquidio/lio_main.c   |  53 ++++++++-
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c |  48 +++++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  50 ++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.h  |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    |  46 +++++++-
 drivers/net/ethernet/mscc/ocelot.c            |  30 ++++-
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  14 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |   3 +
 .../ethernet/netronome/nfp/nfp_net_common.c   |  19 +++-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |   2 -
 drivers/net/ethernet/netronome/nfp/nfp_port.c |  17 ++-
 drivers/net/ethernet/netronome/nfp/nfp_port.h |   5 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
 drivers/net/netdevsim/netdev.c                |  46 +++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  28 ++---
 net/dsa/slave.c                               |  30 ++++-
 net/switchdev/switchdev.c                     | 107 ++++++------------
 26 files changed, 503 insertions(+), 194 deletions(-)

-- 
2.17.1

