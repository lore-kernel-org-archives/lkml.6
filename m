Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71BE218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyWycX+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfB0BOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:14:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40416 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0BOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:14:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so7105763plb.7;
        Tue, 26 Feb 2019 17:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cH9oJKpXYpzUBm/E3y8LZkm21TWeyoHh6mJNc57m+hA=;
        b=PyWycX+ScpJfmaeaAtaJ3Y94FGziaYuQ1mEBYYDcAbP4Lz7Hd2pubw5AFiwns4R74a
         ft6d0ZOCS+0g1Axpue7TY/5w5O/4yCiGpPH2WRhi1zm7yPcNoDuadnARPxPzSRLiMqaE
         faIaUlMCIZimDXEd+PxZbL5kXerf/ZvpR5XaiBJKdkUtM6QL9+mbgboCmiC2JxjN4+UJ
         hQxY11DbjIDXwO+FU1M8kq9uKVX47CZZsIsco60AaK1ET4tntom7qDpJaCGfTRbQHiZX
         Nb/OGKRFJF0fJNfc4RVc44voNsxk96KE6QVl28vD3iEcwEzJvh7bcb0fdfb9GZ92w5jW
         DpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cH9oJKpXYpzUBm/E3y8LZkm21TWeyoHh6mJNc57m+hA=;
        b=anRemZwP41QGjfZ69RTUldW/eNv1ISH211+mzQ0uK+MyjQQO/tLkQqK6dKGCjQf5MH
         FqjPGVcqdbeiDbrXorekd8hxAnjnsQwI8bBb1EC8PzGIt0Q2F6G2hdBUqe4rPPkeihgJ
         TtZeIDPGn7PJAMQ9tlnLxgrHIz1RR20VyXPnULADbExWXPmhgD+BDJ8wP8QR4FZtkWS3
         +pgNibB90FtusfAJuxU9U3YaNHD1qIDfNNmd1lnl16nZd4mGV3OyeC9BA4jlU4BANcjv
         ceroaXH9MTEtwWx9bVpOqEmN8QgeY8Efv5PwtSZmN100RRraBw5CRcYbfE7bAIA3zvNU
         7ijg==
X-Gm-Message-State: AHQUAuYJvwRbwUU1EwvoN4MaSRI76NgWOtSUfFpd+f55K8X4GgV0uf0H
        Gm1sK/UrOIMypQKsWXt5z45yL9r/
X-Google-Smtp-Source: AHgI3IZ2rNL5+obnXuJ3lVGuiDuQPDLHemW55b88VXd2ST7CktZISlT/Q65ztIfRO6iCPMZba5oiEw==
X-Received: by 2002:a17:902:aa47:: with SMTP id c7mr4446378plr.338.1551230076336;
        Tue, 26 Feb 2019 17:14:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q28sm21885221pgl.35.2019.02.26.17.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:14:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 0/8] net: Remove switchdev_ops
Date:   Tue, 26 Feb 2019 17:14:19 -0800
Message-Id: <20190227011427.16487-1-f.fainelli@gmail.com>
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

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 ++--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 +++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  24 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  38 ++++---
 net/bridge/br_switchdev.c                     |   7 +-
 net/dsa/slave.c                               |  23 +++-
 net/switchdev/switchdev.c                     | 104 +++++++++++++-----
 13 files changed, 203 insertions(+), 92 deletions(-)

-- 
2.17.1

