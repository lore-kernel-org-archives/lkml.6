Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E41ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EA62083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EA62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeINUGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:06:08 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:50306 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:06:08 -0400
X-Greylist: delayed 170028 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 16:06:08 EDT
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 3382E53;
        Fri, 14 Sep 2018 14:51:16 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 8F57F45;
        Fri, 14 Sep 2018 14:51:15 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     jack@suse.cz, dan.j.williams@intel.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fix sync to flush processor cache for ext2/4 DAX files
Date:   Fri, 14 Sep 2018 08:51:11 -0600
Message-Id: <20180914145114.11122-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes issues that sync syscall to existing DAX ex2/4
files does not flush processor cache.

Patch 1/3 adds .bmap to ext4_dax_aops so that mount -o dax works for
the journal inode.

Patch 2/3 fixes the ext4 issue by setting i_flags before ext4_set_aops()
in ext4_iget().

Patch 3/3 fixes the ext2 issue by setting i_flags before ext2_set_aops()
in ext2_iget(), i.e. same as ext4.

v2:
 - Add .bmap to ext4_dax_aops, instead of disabling dax for the journal
   inode. (Jan Kara)
 - Initialize i_flags early in ext4_iget(). (Jan Kara)
 - Update Fixes tag and add Cc to Stable. (Dan Williams)
 - Add fix to ext2.

---
Toshi Kani (3):
 1/3 ext4, dax: add ext4_bmap to ext4_dax_aops
 2/3 ext4, dax: set ext4_dax_aops for dax files
 3/3 ext2, dax: set ext2_dax_aops for dax files

---
 fs/ext2/inode.c | 2 +-
 fs/ext4/inode.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)
