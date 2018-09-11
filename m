Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AD4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093A12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093A12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIKVDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:03:22 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:10476 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKVDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:03:22 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id CD42161149;
        Tue, 11 Sep 2018 16:03:24 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id D74F097;
        Tue, 11 Sep 2018 16:03:23 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 48DF03A;
        Tue, 11 Sep 2018 16:03:23 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     jack@suse.cz, dan.j.williams@intel.com
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix sync to flush processor cache for ext4 DAX files
Date:   Tue, 11 Sep 2018 09:42:44 -0600
Message-Id: <20180911154246.6844-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes an issue that sync syscall to an existing DAX file
does not flush processor cache.

Patch 1/2 adds a check to skip the journal inode. It's a bit awkward,
but I could not find a beter way to get the journal inode.

Patch 2/2 fixes the issue by moving up ext4_set_inode_flags() before
ext4_set_aops() in ext4_iget(). This assumes updated i_flags is harmless
in the error cases after the moved-up ext4_set_inode_flags(). Please
review.

---
Toshi Kani (2):
 1/2 ext4, dax: update dax check to skip journal inode
 2/2 ext4, dax: set ext4_dax_aops for dax files

---
 fs/ext4/ext4_jbd2.h | 8 ++++++++
 fs/ext4/inode.c     | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)
