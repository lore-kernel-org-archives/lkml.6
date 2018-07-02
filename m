Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B08AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438EE25B1C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438EE25B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964882AbeGBIdp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:33:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48957 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933540AbeGBIdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:33:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1F0DF208B3; Mon,  2 Jul 2018 10:33:38 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id D0E50206F3;
        Mon,  2 Jul 2018 10:33:27 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v4 0/2] ubi: add possibility to skip CRC check for static UBI volumes
Date:   Mon,  2 Jul 2018 10:32:56 +0200
Message-Id: <cover.99f8f464b3a02f65080962001abf6fd1f8dff0e0.1530519426.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of static UBI volumes implement their own integrity check, thus
making the volume CRC check done at open time useless. For instance, this
is the case when one use the ubiblock + dm-verity + squashfs combination,
where dm-verity already checks integrity of the block device but this time
at the block granularity instead of verifying the whole volume.

Skipping this test drastically improves the boot-time.

Patches for mtd-utils will be available as well.

Thanks,
Quentin

v4:
  - add a valid flags mask and check the given volume flag is valid when
  doing verify_mkvol_req(),

v3:
  - fix a few typos,

v2:
  - use volume flags instead of arguments on the kernel command line as
  suggested by Richard,

Quentin Schulz (2):
  ubi: provide a way to skip CRC checks
  ubi: expose the volume CRC check skip flag

 drivers/mtd/ubi/cdev.c      |  7 +++++++
 drivers/mtd/ubi/kapi.c      |  2 +-
 drivers/mtd/ubi/ubi-media.h |  6 ++++++
 drivers/mtd/ubi/ubi.h       |  4 ++++
 drivers/mtd/ubi/vmt.c       | 12 ++++++++++++
 drivers/mtd/ubi/vtbl.c      |  3 +++
 include/uapi/mtd/ubi-user.h | 18 ++++++++++++++++--
 7 files changed, 49 insertions(+), 3 deletions(-)

base-commit: 69877f06915f1c7a9f1704442993bcc12c13ace2
-- 
git-series 0.9.1
