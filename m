Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A02C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3D208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3D208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933953AbeGDLbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:31:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45794 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932594AbeGDLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:03 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:33:47 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BUvsj030705;
        Wed, 4 Jul 2018 14:30:57 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BUvdw024626;
        Wed, 4 Jul 2018 14:30:57 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BUtQ3024623;
        Wed, 4 Jul 2018 14:30:55 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 00/10] Add configuration parameters support
Date:   Wed,  4 Jul 2018 14:30:27 +0300
Message-Id: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration parameters setting through devlink.
Each device registers supported configuration parameters table.
Each parameter can be either generic or driver specific.
The user can retrieve data on these parameters by "devlink param show"
command and can set new value to a parameter by "devlink param set"
command.
The parameters can be set in different configuration modes:
  runtime - set while driver is running, no reset required.
  driverinit - applied while driver initializes, requires restart
               driver by devlink reload command.
  permanent - written to device's non-volatile memory, hard reset required.

The patches at the end of the patchset introduce few params that are using
the introduced infrastructure on mlx4 and bnxt.

Command examples and output:

# devlink dev param show
pci/0000:81:00.0:
  name internal_error_reset type generic
    values:
      cmode runtime value true
      cmode driverinit value true
  name max_macs type generic
    values:
      cmode driverinit value 128
  name enable_64b_cqe_eqe type driver-specific
    values:
      cmode driverinit value true
  name enable_4k_uar type driver-specific
    values:
      cmode driverinit value false

# devlink dev param set pci/0000:81:00.0 name internal_error_reset cmode runtime value false

# devlink dev param show pci/0000:81:00.0 name internal_error_reset
pci/0000:81:00.0:
  name internal_error_reset type generic
    values:
      cmode runtime value false
      cmode driverinit value true


Moshe Shemesh (8):
  devlink: Add devlink_param register and unregister
  devlink: Add param get command
  devlink: Add param set command
  devlink: Add support for get/set driverinit value
  devlink: Add devlink notifications support for params
  devlink: Add generic parameters internal_err_reset and max_macs
  mlx4: Add mlx4 initial parameters table and register it
  mlx4: Add support for devlink reload and load driverinit values

Vasundhara Volam (2):
  devlink: Add enable_sriov boolean generic parameter
  bnxt_en: Add bnxt_en initial params table and register it.

 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 121 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h |  15 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h     |  13 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c     |   9 +-
 drivers/net/ethernet/mellanox/mlx4/catas.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx4/main.c         | 161 +++++-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h         |   3 +-
 include/net/devlink.h                             | 149 +++++
 include/uapi/linux/devlink.h                      |  24 +
 net/core/devlink.c                                | 675 ++++++++++++++++++++++
 10 files changed, 1156 insertions(+), 16 deletions(-)

-- 
1.8.3.1

