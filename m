Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B667C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A420836
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfABUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:05:44 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57232 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbfABUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:05:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THOz2-._1546459534;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THOz2-._1546459534)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Jan 2019 04:05:41 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] mm: memcontrol: delayed force empty
Date:   Thu,  3 Jan 2019 04:05:30 +0800
Message-Id: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, force empty reclaims memory synchronously when writing to
memory.force_empty.  It may take some time to return and the afterwards
operations are blocked by it.  Although it can be interrupted by signal,
it still seems suboptimal.

Now css offline is handled by worker, and the typical usecase of force
empty is before memcg offline.  So, handling force empty in css offline
sounds reasonable.

The user may write into any value to memory.force_empty, but I'm
supposed the most used value should be 0 and 1.  To not break existing
applications, writing 0 or 1 still do force empty synchronously, any
other value will tell kernel to do force empty in css offline worker.

Patch #1: Fix some obsolete information about force_empty in the document
Patch #2: A minor improvement to skip swap for force_empty
Patch #3: Implement delayed force_empty

Yang Shi (3):
      doc: memcontrol: fix the obsolete content about force empty
      mm: memcontrol: do not try to do swap when force empty
      mm: memcontrol: delay force empty to css offline

 Documentation/cgroup-v1/memory.txt | 15 ++++++++++-----
 include/linux/memcontrol.h         |  2 ++
 mm/memcontrol.c                    | 20 +++++++++++++++++++-
 3 files changed, 31 insertions(+), 6 deletions(-)
