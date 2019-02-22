Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952C4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E202077B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIUQohih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfBWAAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:00:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBWAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so1783007pfh.10;
        Fri, 22 Feb 2019 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p30AzGcPU94wCBS8YtPQqGyNulXQ5D1avMwXHp83bds=;
        b=dIUQohihWGlkYp7ehda73F3TvfwAG9VhTYUd85Xz4jtLlOuIaNvewcP3gJb0K7rneO
         KEa8tjRpwb6Yd+OLdRAp5Abzco36eni96Kgb3c+KxgeHx0NAp0TJDe2KdhTteWcu3Aqz
         fAmi/QVAPs+GaHM7FT6XEPwUDMfXG/TEgLPkVA4QBbcLl0YDhn2m55QBy6LapGzQupPH
         YrP8X9AaK8IaosUKRMruRY5omYqqQHiafGvoudri4vx9FSYOrUgcNh1S7m+43C7xCfy2
         eCdr+z225Ebzve44jE9d+wNwP6PEEwRmAfNqLfbZVAm0aipBZZK/5cwVmGAFmeC50fOc
         LSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p30AzGcPU94wCBS8YtPQqGyNulXQ5D1avMwXHp83bds=;
        b=bnLEc85AlLgJGhmhfAGLtJtFRUL0dC1xI3fhDDLqa0kDSUpuzS74cyPF5qhZWVLYjT
         mK48G3gSUBDNA6tZcpqqTLYBQjU/+B0W7XSfGKnGMgAJ+eVE/ASwrpEi6xCMotW9fQ7a
         WfStVxmGdHmU/XDgvK/gXgxkpstIm9XhIDfhoWpYAl8aOZyIPgmBUo45ouFM4AoyCxy3
         UoOhidOPUKL3rVDVqi6b6MHZFqERq66cGHUzmIM6NQGAqUDoPOR+DQ6vWLaBHUfMQs0Z
         AZY4W/JF6xOo77wYDOv8FDC4EJnCGFw7z+qkpOmxCa/cMj61KbsaaLfaJlFn7e0eMuob
         5gqQ==
X-Gm-Message-State: AHQUAuYzyTJ5km6PgsAnac5/9xxJaFQ8NjHOyPfzxABmZr8mkIvgofGV
        O10aHcROVsAVk2Ic6jo0f1mBwair
X-Google-Smtp-Source: AHgI3IaJ5J9VZib86SlM5U9/zuRAUxyvuu26t2ET/VcaLFKDCB0lsyV/hwvAaAV1aRaem6vuD3pApQ==
X-Received: by 2002:a65:6651:: with SMTP id z17mr6092052pgv.95.1550880023146;
        Fri, 22 Feb 2019 16:00:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 0/8] net: Remove switchdev_ops
Date:   Fri, 22 Feb 2019 15:59:18 -0800
Message-Id: <20190222235927.10295-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series completes the removal of the switchdev_ops by
converting switchdev_port_attr_set() to use either the blocking
(process) or non-blocking (atomic) notifier since we typically need to
deal with both depending on where in the bridge code we get called from.

This was tested with the forwarding selftests and DSA hardware.

Ido, Jiri, please review :)

Florian Fainelli (8):
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 +--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 ++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  26 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  42 ++---
 net/dsa/slave.c                               |  23 ++-
 net/switchdev/switchdev.c                     | 147 +++++++++---------
 12 files changed, 200 insertions(+), 137 deletions(-)

-- 
2.17.1

