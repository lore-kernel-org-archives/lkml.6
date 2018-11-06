Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD802085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD802085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbeKFTIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:01 -0500
Received: from relay.sw.ru ([185.231.240.75]:59838 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:01 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxtX-00035E-W7; Tue, 06 Nov 2018 12:43:36 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0/6] fuse: Further reducing contention of fc->lock
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:43:35 +0300
Message-ID: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was introduced fc->bg_lock to reduce the contention,
and this patchset continues this efforts.

This patchset introduces per fuse_inode lock to protect
inode metadata, synchronization with background writes, etc.
All of the above is related to a single inode, and there
is no a reason, that inodes are concurrents of each other
to make some of actions exclusive.

So, here we introduce fuse_inode::lock spinlock and get rid
of fc->lock in many places.

---

Kirill Tkhai (6):
      fuse: Change argument of fuse_flush_writepages()
      fuse: Add fuse_inode argument to fuse_prepare_release()
      fuse: Introduce fuse_inode::lock to protect write related fields and statistics
      fuse: Implement fuse_attr_version_inc()
      fuse: Protect fuse_inode::nlookup with fuse_inode::lock
      fuse: Protect fuse_file::reserved_req via corresponding fuse_inode::lock


 fs/fuse/cuse.c    |    3 +
 fs/fuse/dev.c     |   10 +++-
 fs/fuse/dir.c     |   41 +++++++++---------
 fs/fuse/file.c    |  119 ++++++++++++++++++++++++++++-------------------------
 fs/fuse/fuse_i.h  |   27 ++++++++++--
 fs/fuse/inode.c   |   16 ++++---
 fs/fuse/readdir.c |    4 +-
 7 files changed, 126 insertions(+), 94 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
