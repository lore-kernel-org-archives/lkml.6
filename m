Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D34C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF442088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF442088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeH1VMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:12:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbeH1VMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:12:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FAB180823E3;
        Tue, 28 Aug 2018 17:19:57 +0000 (UTC)
Received: from llong.com (ovpn-123-12.rdu2.redhat.com [10.10.123.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F69D7D4D9;
        Tue, 28 Aug 2018 17:19:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
        Michal Hocko <mhocko@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] fs/dcache: Track # of negative dentries
Date:   Tue, 28 Aug 2018 13:19:38 -0400
Message-Id: <1535476780-5773-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 17:19:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 28 Aug 2018 17:19:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a reduced scope version of the
patchset "fs/dcache: Track & limit # of negative dentries"
(https://lkml.org/lkml/2018/7/12/586). Only the first 2 patches are
included to track the number of negative dentries in the system as well
as making negative dentries more easily reclaimed than positive ones.

There are controversies on limiting number of negative dentries as it may
make negative dentries special in term of how memory resources are to
be managed in the kernel. However, I don't believe I heard any concern
about tracking the number of negative dentries in the system. So it is
better to separate that out and get it done with. We can deal with the
controversial part later on.

Patch 1 adds tracking to the number of negative dentries in the LRU list.

Patch 2 makes negative dentries to be added at the head end of the LRU
list so that they are first to go when a shrinker is running if those
negative dentries are never referenced again.

Waiman Long (2):
  fs/dcache: Track & report number of negative dentries
  fs/dcache: Make negative dentries easier to be reclaimed

 Documentation/sysctl/fs.txt | 19 ++++++++++-----
 fs/dcache.c                 | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h      |  8 ++++---
 include/linux/list_lru.h    | 17 ++++++++++++++
 mm/list_lru.c               | 16 +++++++++++--
 5 files changed, 104 insertions(+), 12 deletions(-)

-- 
1.8.3.1

