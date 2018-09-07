Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50124C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DA42077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DA42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeIGRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:21:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeIGRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007bl-79; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00061W-9r; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 00/25] UBIFS authentication support
Date:   Fri,  7 Sep 2018 14:36:21 +0200
Message-Id: <20180907123646.12688-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset introduces UBIFS authentication support. With authentication
enabled UBIFS is fully protected against offline changes. This is done by
hashing the different parts of UBIFS and protecting the toplevel hashes with
HMACs. The parts that are protected are:

* the index tree
* the journal
* the LPT
* the master nodes
* the superblock node

A detailed overview how the different parts are authenticated can be found
here:

https://github.com/sigma-star/ubifs-authentication/blob/master/ubifs-authentication-whitepaper.md

However, some details still had to be changed, so an updated version of that
document is part of this patchset.

Usage:
======

First add an authentication key to the kernel keyring. It must be of type
'logon'. The description can be freely chosen, it must be passed as mount
option later:

# keyctl add logon ubifs:foo 12345678901234567890123456789012 @s

Attach the UBI device and mount with auth_key=$description and
auth_hash_name=$algo:

# mount -t ubifs /dev/ubi0_0 -o auth_key=ubifs:foo,auth_hash_name=sha256 /mnt/

This mounts the UBIFS in authenticated mode. The hash algorithm can be freely
chosen from include/uapi/linux/hash_info.h as long as the digest is at maximum
64 bytes which is the space we reserved in the UBIFS structures. We always use
the same algorithms for creating HMACs, so using sha256 for hashing means that
we also use hmac(sha256) for creating authentication data.

When the authentication_key mount option is given, a UBIFS image which can be
authenticated with that key is mandatory, no unauthenticated image will be
accepted. Likewise, when the option is not given, no authenticated image can be
accepted since that couldn't be authenticated. We could skip authentication in
this case, but we couldn't create any valid HMACs when writing new data. We
could make it an option to mount in readonly mode for debugging purposes when
we do not have a key (or we already know that parts of the UBIFS image are
corrupted), but that is not implemented yet.

Offline signed images
=====================

Currently UBIFS authentication is only supported on the default filesystem the
kernel creates when an empty UBI volume is found. Support for offline signed
images is in the makings. Preliminary patches for the Kernel and mtd-utils are
ready and can be shared on request, otherwise I'll continue on them once
this basic patchset is ready and merged.

Testing
=======

I've gone through various tests including powercut tests over the weekend and
running xfstests. It is tested on real hardware (i.MX6 based) on a 2k page NAND
and in nandsim on a simulated 512b page NAND in big LPT mode. Basic testing has
been done with all chk_* ubifs flags set to 1, lockdep enabled.

This patchset is based on v4.19-rc2 and can be obtained here:

git://git.pengutronix.de/sha/linux ubifs-authentication-v2

Changes since v1:

- rebase onto v4.19-rc2
- Add missing ubifs_copy_hash() in make_idx_node to make in-the-gaps method work
  with authentication
- Return error codes from all crypto related functions and forward error
- Remove VLAs
- rename c->superblock to c->sup_node
- use UBIFS_HASH_ARR_SZ for array sizes. UBIFS_HASH_ARR_SZ is set to 0
  for non authenticated fs and to UBIFS_MAX_HASH_LEN for authenticated fs
- Add common bad-hash report handler
- fix various comments
- Add missing ubifs_add_dirt() in the garbage collectors move_nodes() function
- add ubifs_add_auth_dirt() to add dirt for an authentication node

/Sascha

Sascha Hauer (25):
  ARM: imx_v6_v7_defconfig: update
  ubifs: refactor create_default_filesystem()
  ubifs: pass ubifs_zbranch to try_read_node()
  ubifs: pass ubifs_zbranch to read_znode()
  ubifs: export pnode_lookup as ubifs_pnode_lookup
  ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
  ubifs: drop write_node
  ubifs: Store read superblock node
  ubifs: Format changes for authentication support
  ubifs: add separate functions to init/crc a node
  ubifs: add helper functions for authentication support
  ubifs: Create functions to embed a HMAC in a node
  ubifs: Add hashes to the tree node cache
  ubifs: authentication: Add hashes to index nodes
  ubifs: Add authentication nodes to journal
  ubifs: Add auth nodes to garbage collector journal head
  ubifs: authenticate replayed journal
  ubifs: authentication: authenticate LPT
  ubfis: authentication: authenticate master node
  ubifs: Create hash for default LPT
  ubifs: authentication: Authenticate super block node
  ubifs: Add hashes and HMACs to default filesystem
  ubifs: do not update inode size in-place in authenticated mode
  ubifs: Enable authentication support
  Documentation: ubifs: Add authentication whitepaper

 .../filesystems/ubifs-authentication.md       | 426 +++++++++++++++
 Documentation/filesystems/ubifs.txt           |   7 +
 arch/arm/configs/imx_v6_v7_defconfig          |  15 +-
 fs/ubifs/Kconfig                              |  11 +
 fs/ubifs/Makefile                             |   1 +
 fs/ubifs/auth.c                               | 502 ++++++++++++++++++
 fs/ubifs/debug.c                              |   6 +
 fs/ubifs/gc.c                                 |  49 +-
 fs/ubifs/io.c                                 | 110 +++-
 fs/ubifs/journal.c                            | 289 +++++++---
 fs/ubifs/log.c                                |  24 +
 fs/ubifs/lpt.c                                | 184 ++++++-
 fs/ubifs/lpt_commit.c                         |  44 +-
 fs/ubifs/master.c                             |  64 ++-
 fs/ubifs/misc.h                               |   5 +-
 fs/ubifs/recovery.c                           | 120 +++--
 fs/ubifs/replay.c                             | 177 +++++-
 fs/ubifs/sb.c                                 | 207 +++++---
 fs/ubifs/super.c                              |  91 +++-
 fs/ubifs/tnc.c                                |  36 +-
 fs/ubifs/tnc_commit.c                         |  27 +
 fs/ubifs/tnc_misc.c                           |  26 +-
 fs/ubifs/ubifs-media.h                        |  46 +-
 fs/ubifs/ubifs.h                              | 253 ++++++++-
 24 files changed, 2422 insertions(+), 298 deletions(-)
 create mode 100644 Documentation/filesystems/ubifs-authentication.md
 create mode 100644 fs/ubifs/auth.c

-- 
2.18.0

