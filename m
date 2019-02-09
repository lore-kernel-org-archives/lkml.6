Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F4C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF7C20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dto7JMQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBIAdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBIAdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so2279623pgk.10;
        Fri, 08 Feb 2019 16:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ALcFwzOq1HbIP5Zq0tFSEUjDJkjB3cx5B3JV7pwKHaY=;
        b=Dto7JMQxP6sbs9m14Ys8hcTKshN6hPlRN1lHm2mMyNhCt78U56HSi91p6PwJIJ6sbn
         Mlg0QWVSZeuwubERNnTN++5afWn5WXaPnm/JKwfjRmgNJed8jJSRrsY8RwLAo/PPiE8z
         ekPpvbXD77gUeIPYJGpqxV1NzZc9H+9SJHGLK1mk5peklzDsgMsEBvZS3KVhzJ9fa2iZ
         pXtoUm/ysi73Htg2m73UdPZRVnL9qQXb7xDE+6DSxnvw8hLNoIqIwRRWysPlWMcYQFlY
         RKylH20mBGe/PVwt74F8BaFeU+T5phaMOft0c7jAnWGVcLk3UTsbQZr8I0JKWgcFxCWn
         oDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ALcFwzOq1HbIP5Zq0tFSEUjDJkjB3cx5B3JV7pwKHaY=;
        b=tbA10RmmgcbYPzQywktr8ov2Y9ZJMT6RHsIzvLjZHuAlxApxSYzbKmV149yy4pdo4p
         0o0M//3HpkeHvnrgB3LyKVFd0+4qDHWvfWA46XVrNr8H6MPOThRFjDuz23MJ4EYzQOOH
         p3jZ3BqcRz2OgLeL0fLW+8Pc05SWOpET2oAPYV/W5DPuiAO8A84DaTO8C7kDeWtkmXv+
         G6ay0UvimwDGGz8F8BRAxA6HciCQP6DRh2veqwzrpYeV0usa0JgzpTcOEUWfk/0eTKOk
         3CyL8SPxsUtOFPT+LKKpVw51Wt2YXhcpq/PeH5W/opiUetwiic/clajpuGTb6nk/7zXw
         UqKQ==
X-Gm-Message-State: AHQUAuYkTIH+6wsIkj35AGc2Nw29kP/4593ARfK1aZ4zefFENL+jwY+U
        2TO977bFBW+Cv1zBTmN/HrKUSKL1
X-Google-Smtp-Source: AHgI3IY9YlCoUrz3ekM9g0i9T8Qg10yg6DESb+9LTCaBL1Ms3pbzoablCwZFMVt3ey/2Qo0rBFg1Gw==
X-Received: by 2002:a65:6658:: with SMTP id z24mr23183240pgv.189.1549672387800;
        Fri, 08 Feb 2019 16:33:07 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 00/16] net: Remove switchdev_ops
Date:   Fri,  8 Feb 2019 16:32:32 -0800
Message-Id: <20190209003248.31088-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series finishes by the removal of switchdev_ops. To get there
we need to do a few things:

- get rid of the one and only call to switchdev_port_attr_get() which is
  used to fetch the device's bridge port flags capabilities, instead we
  can just check what flags are being programmed during the prepare
  phase

- once we get rid of getting switchdev port attributes we convert the
  setting of such attributes using a blocking notifier

And then remove switchdev_ops completely.

Please review and let me know what you think!

Florian Fainelli (16):
  Documentation: networking: switchdev: Update port parent ID section
  mlxsw: spectrum: Check bridge flags during prepare phase
  staging: fsl-dpaa2: ethsw: Check bridge port flags during set
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check bridge flags during prepare phase
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        | 15 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 ---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       | 72 +++++---------
 drivers/net/ethernet/mscc/ocelot.c            | 25 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     | 99 +++++++++----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 52 +++++-----
 include/linux/netdevice.h                     |  3 -
 include/net/switchdev.h                       | 37 ++-----
 net/bridge/br_switchdev.c                     | 20 +---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 10 ++
 net/dsa/slave.c                               | 44 +++++----
 net/switchdev/switchdev.c                     | 92 +++++------------
 14 files changed, 190 insertions(+), 296 deletions(-)

-- 
2.17.1

