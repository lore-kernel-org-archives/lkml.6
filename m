Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9290DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1682101A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 05:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1682101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeGBFwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 01:52:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753060AbeGBFwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 01:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B94B307D84B;
        Mon,  2 Jul 2018 05:52:40 +0000 (UTC)
Received: from llong.com (ovpn-116-112.phx2.redhat.com [10.3.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C381001905;
        Mon,  2 Jul 2018 05:52:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/6] fs/dcache: Track & limit # of negative dentries
Date:   Mon,  2 Jul 2018 13:51:57 +0800
Message-Id: <1530510723-24814-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 02 Jul 2018 05:52:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4->v5:
  - Backed to the latest 4.18 kernel and modify the code
    accordingly. Patch 1 "Relocate dentry_kill() after lock_parent()"
    is now no longer necessary.
  - Make tracking and limiting of negative dentries an user configurable
    option (CONFIG_DCACHE_TRACK_NEG_ENTRY) so that users can decide if
    they want to include this capability in the kernel.
  - Make killing excess negative dentries an optional feature that can be
    enabled via a boot command line option or a sysctl parameter.
  - Spread negative dentry pruning across multiple CPUs.

 v4: https://lkml.org/lkml/2017/9/18/739

A rogue application can potentially create a large number of negative
dentries in the system consuming most of the memory available if it
is not under the direct control of a memory controller that enforce
kernel memory limit.

This patchset introduces changes to the dcache subsystem to track and
optionally limit the number of negative dentries allowed to be created by
background pruning of excess negative dentries or even kill it after use.
This capability will help to limit the amount of memory that can be
consumed by negative dentries.

Patch 1 tracks the number of negative dentries present in the LRU
lists and reports it in /proc/sys/fs/dentry-state.

Patch 2 makes negative dentry tracking a user configurable option
(CONFIG_DCACHE_TRACK_NEG_ENTRY) as well as adding a "neg_dentry_pc=" boot
command line option to specify a soft limit on the number of negative
allowed as a percentage of total system memory. The default is 2%.

Patch 3 enables automatic pruning of least recently used negative
dentries when the total number is close to the preset limit.

Patch 4 spreads the negative dentry pruning effort to multiple CPUs to
make it more fair.

Patch 5 extends the "neg_dentry_pc=" boot command line option to
optionally enable enforcing the limit by killing off excess negative
dentries immediately after use.

Patch 6 makes the limit enforcing option a sysctl parameter so that it
can be dynamically enabled at run time if the need arises, for example,
when a rogue application generating a lot of negative dentries is
detected.

Waiman Long (6):
  fs/dcache: Track & report number of negative dentries
  fs/dcache: Make negative dentry tracking configurable
  fs/dcache: Enable automatic pruning of negative dentries
  fs/dcache: Spread negative dentry pruning across multiple CPUs
  fs/dcache: Allow optional enforcement of negative dentry limit
  fs/dcache: Make negative dentry limit enforcement sysctl parameter

 Documentation/admin-guide/kernel-parameters.txt |  12 +
 Documentation/sysctl/fs.txt                     |  30 +-
 fs/Kconfig                                      |  10 +
 fs/dcache.c                                     | 452 +++++++++++++++++++++++-
 include/linux/dcache.h                          |  13 +-
 include/linux/list_lru.h                        |   1 +
 kernel/sysctl.c                                 |  11 +
 mm/list_lru.c                                   |   4 +-
 8 files changed, 519 insertions(+), 14 deletions(-)

-- 
1.8.3.1

