Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EC621B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taMfTJfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbfBKTK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:10:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35420 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfBKTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:10:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so10636pgs.2;
        Mon, 11 Feb 2019 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SkmoCuGIG7bBgkarhLHVf2wX33rKnc3mr2F6ISg3h5w=;
        b=taMfTJfj4E+6QegTRVG2Wr9ySYJobUOvxco2ghCl1lfCGwEqglH/PXOhQ5HSPMYKg8
         45Tf2UPVyberzHQ8+x5vsvwYmCFjY/tNbuAubqsoN2KotHzI0qvwgmL2uitpMDxI/tQ4
         YMLQDD316l10/ZfuIfrS6ermOaK0fz4qw1cTsYE+y1kVfUDgaZToPgyGZFj4NbfN4ppC
         MdfQrnptrz88EXmr2vsJwCXGup/2RQWyqW1KsxK8FnkwFvFAUYvXfr7VRTa1Nvhc1MYq
         Grb6pAouoUBFcCLGKPmMgnQFDW+hYx9SBGuYJANfZBkCgGSJjba8w3Mc82LLELn3Q+3c
         Pw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SkmoCuGIG7bBgkarhLHVf2wX33rKnc3mr2F6ISg3h5w=;
        b=EywZq1YjAFtkZXsIcx6MncZnzRGlVqmAIe9mAwFMUFq9/AqGkYQarzKjPjpNfefGTo
         BRE9Rcyjvu5uyjiUydmt5dGRAGa1nFDiLrj3oKJaR1XkzfvWW26gcU7ydxACh3iJ0X2o
         CkFVhY0yq2VlJx6N2kIrMeh/PohZGk4aQUP0BGJ1GCu585YnDPR8Usf8e8UHdqr6G2ga
         tb0ixPzc1b3hs8MWTiuUmasTOQPB9ZtQMTDyscjEyryM2eNgcAd6WQgrQ4h+snT2KX4B
         QqvG7FdxrlbO1ZGwLoTYeULUnlJQborRuW2AFj6gdyE5ah2qPtOrHAnZ9PoYoWp6uGct
         uOrg==
X-Gm-Message-State: AHQUAubfxEPOMupfuW8D9N1S6os/UCiVGR5KD40RkjKE3xlMs7BfkSf0
        YGoJ5ZzutioZpqabB/qHW39taQ3h
X-Google-Smtp-Source: AHgI3Ia67RRL7TOe3P8EdiKAMeH46zySHSkMj8kkjS0gfwkd6VqA4ziMFHiJZVfR9jsa3/DRkK74Ww==
X-Received: by 2002:a65:62da:: with SMTP id m26mr34934837pgv.278.1549912224264;
        Mon, 11 Feb 2019 11:10:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i24sm2167206pgg.14.2019.02.11.11.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:10:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Date:   Mon, 11 Feb 2019 11:09:52 -0800
Message-Id: <20190211191001.8623-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series finishes by the removal of switchdev_ops. To get there
we convert the existing switchdev_port_attr_{set,get} switchdev_ops to
use a blocking notifier, thus making it consistent with how the objects
are pushed to the switchdev enabled devices.

Please review and let me know what you think!

David, I would like to get Ido's feedback on this to make sure I did not
miss something, thank you!

Changes in v4:
- removed double space in Documentation/networking/switchdev.txt
- added Jiri's Acked-by tags
- added fall through annotations where appropriate

Changes in v3:
- dropped patches removing te need to get the attribute since we
  still need that in order to support different sleeping vs.
  non-sleeping contexts

Changes in v2:
- fixed bisectability issues in patch #15
- added Acked-by from Jiri where necessary
- fixed a few minor issues according to Jiri's feedback:
	- rename port_attr_event -> port_attr_set_event
	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
  rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: switchdev: Replace port attr get/set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
 drivers/net/ethernet/mscc/ocelot.c            |  26 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  28 ++---
 net/dsa/slave.c                               |  30 ++++-
 net/switchdev/switchdev.c                     | 107 ++++++------------
 11 files changed, 168 insertions(+), 146 deletions(-)

-- 
2.17.1

