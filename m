Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC87217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhhSv0FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfB0TpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:45:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45066 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbfB0TpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:45:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so8425877pgc.12;
        Wed, 27 Feb 2019 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1pXVJqmKhJcvrRxONTsS1Oysqm17cirViqUhJzDEsoU=;
        b=lhhSv0FGaLKee7FV8Yi4Qdi4yQGF7+JN2mf1xvumG0TwmNTfiYxl0iyyZMoXbP7YbA
         mzmAdhr7njLaP6UrJuUDF6b2NeBjEo96RNhp//Zpmj87XQzFNaOFj/t53777E62jmh9f
         8kbsOTRY4sppZqUdzUPm9Qmyq5gBJQCFu9We7NqhBjGuJYSOXKz5V+Qtdc2A2Qke+pxE
         +ivfmk8jtHsJg+rMawdcn8t+vfizseL1MeZ5WUXKSATqMgvc4JnWn6d8lSsfpTyWsj5B
         g3dvFuXtNRSvcBj2lBkGDCBWKtOqXmu4kv19mQnTi1AOIe6Ke8hVkYzlY2vdGX40UHUy
         5rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1pXVJqmKhJcvrRxONTsS1Oysqm17cirViqUhJzDEsoU=;
        b=NYT+hd7yPu2rhugXnfIirZJtj2ZwK5S/xZRh9pS1RwhBALGQ3oGOsh+rJIp0YkoLeI
         sl7ii0bJKSf8PEl+sQlXepSufA44TDpPwm5UzuV44MECsqMhRx+nDdFi3BNwdoRRqmKJ
         uKyNkk/m2LFhxrWq2VwEs7mQuAvq6oztEAGaKH4Luf4fIBwaaFSZJx+pQTqYAsKkxPwM
         U8vVbGQjRzjOnq/jVi3rRH5XHMt8yA8SswTMVxwEm380mt5ODPwxL7mD3jwQC8dbQQDK
         Kkdv6prHc96yFlSkxWKNRKsD9IilLk6HPIpu1y1/g5/QaGb0ZPs4N0Ku3pXWp9Af1hXV
         yx7Q==
X-Gm-Message-State: AHQUAuav5PUtTsmFfuWTHXPbtFl2rN3Rnr0qNR/O9GnfuqiVorLAM/Nz
        mqkF2pLmR91yBiWmtGVmLvEMWAgm
X-Google-Smtp-Source: AHgI3Ib3XLDuIolwX+6cHHb7wqng0YZZ/1YqVugvLapQvg/WgKTrFUpuFViW04F7sr/I55e/cIzvZA==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr3400216pfi.138.1551296723799;
        Wed, 27 Feb 2019 11:45:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j6sm17044642pgq.33.2019.02.27.11.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:45:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 0/8] net: Remove switchdev_ops
Date:   Wed, 27 Feb 2019 11:44:24 -0800
Message-Id: <20190227194432.725-1-f.fainelli@gmail.com>
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

Ido, hopefully this captures your comments done on v1, if not, can you
illustrate with some pseudo-code what you had in mind if that's okay?

Changes in v3:

- added Reviewed-by tags from Ido where relevant
- added missing notifier_to_errno() in net/bridge/br_switchdev.c when
  calling the atomic notifier for PRE_BRIDGE_FLAGS
- kept mlxsw_sp_switchdev_init() in mlxsw/

Changes in v2:

- do not check for SWITCHDEV_F_DEFER when calling the blocking notifier
  and instead directly call the atomic notifier from the single location
  where this is required

Florian Fainelli (8):
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   3 -
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 ++--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 +++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  24 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  38 ++++---
 net/bridge/br_switchdev.c                     |   8 +-
 net/dsa/slave.c                               |  23 +++-
 net/switchdev/switchdev.c                     | 104 +++++++++++++-----
 13 files changed, 204 insertions(+), 83 deletions(-)

-- 
2.17.1

