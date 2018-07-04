Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA49C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C8A208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C8A208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964809AbeGDMn2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:43:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58703 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934728AbeGDMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dI-9P; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005Y5-CM; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 00/25] UBIFS authentication support
Date:   Wed,  4 Jul 2018 14:41:12 +0200
Message-Id: <20180704124137.13396-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
images is planned and this series already contains a patch which adds support
for it, but there's no mkfs.ubifs support for signed images yet.

Testing
=======

I've gone through various tests including powercut tests over the weekend and
running xfstests. It is tested on real hardware (i.MX6 based) on a 2k page NAND
and in nandsim on a simulated 512b page NAND in big LPT mode.  Currently I am
not aware of any issues, but this is v1 of the series, so please review
carefully and if possible try to break it yourself.

This patchset is based on v4.18-rc3 and can be obtained here:

git://git.pengutronix.de/sha/linux ubifs-authentication-v1

/Sascha

Sascha Hauer (25):
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
  ubifs: support offline signed images
  Documentation: ubifs: Add authentication whitepaper

 .../filesystems/ubifs-authentication.md       | 426 +++++++++++++++
 Documentation/filesystems/ubifs.txt           |   7 +
 fs/ubifs/Kconfig                              |  12 +
 fs/ubifs/Makefile                             |   1 +
 fs/ubifs/auth.c                               | 489 ++++++++++++++++++
 fs/ubifs/debug.c                              |   6 +
 fs/ubifs/gc.c                                 |  40 +-
 fs/ubifs/io.c                                 |  96 +++-
 fs/ubifs/journal.c                            | 224 +++++---
 fs/ubifs/log.c                                |  17 +
 fs/ubifs/lpt.c                                | 174 ++++++-
 fs/ubifs/lpt_commit.c                         |  44 +-
 fs/ubifs/master.c                             |  69 ++-
 fs/ubifs/misc.h                               |   5 +-
 fs/ubifs/recovery.c                           | 118 +++--
 fs/ubifs/replay.c                             | 147 +++++-
 fs/ubifs/sb.c                                 | 208 +++++---
 fs/ubifs/super.c                              | 106 +++-
 fs/ubifs/tnc.c                                |  37 +-
 fs/ubifs/tnc_commit.c                         |  26 +
 fs/ubifs/tnc_misc.c                           |  27 +-
 fs/ubifs/ubifs-media.h                        |  65 ++-
 fs/ubifs/ubifs.h                              | 225 +++++++-
 23 files changed, 2280 insertions(+), 289 deletions(-)
 create mode 100644 Documentation/filesystems/ubifs-authentication.md
 create mode 100644 fs/ubifs/auth.c

-- 
2.18.0

