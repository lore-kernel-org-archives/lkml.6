Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996F3206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfAITV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:21:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32795 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbfAITVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:21:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THtvvDg_1547061291;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THtvvDg_1547061291)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 03:14:58 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when offlining
Date:   Thu, 10 Jan 2019 03:14:40 +0800
Message-Id: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We have some usecases which create and remove memcgs very frequently,
and the tasks in the memcg may just access the files which are unlikely
accessed by anyone else.  So, we prefer force_empty the memcg before
rmdir'ing it to reclaim the page cache so that they don't get
accumulated to incur unnecessary memory pressure.  Since the memory
pressure may incur direct reclaim to harm some latency sensitive
applications.

Force empty would help out such usecase, however force empty reclaims
memory synchronously when writing to memory.force_empty.  It may take
some time to return and the afterwards operations are blocked by it.
Although this can be done in background, some usecases may need create
new memcg with the same name right after the old one is deleted.  So,
the creation might get blocked by the before reclaim/remove operation.

Delaying memory reclaim in cgroup offline for such usecase sounds
reasonable.  Introduced a new interface, called wipe_on_offline for both
default and legacy hierarchy, which does memory reclaim in css offline
kworker.

v2 -> v3:
* Introduced may_swap parameter to mem_cgroup_force_empty() to keep force_empty behavior per   Shakeel
* Fixed some comments from Shakeel
 
v1 -> v2:
* Introduced wipe_on_offline interface suggested by Michal
* Bring force_empty into default hierarchy

Patch #1: Fix some obsolete information about force_empty in the document
Patch #2: Introduce may_swap parameter to mem_cgroup_force_empty()
Patch #3: Introduces wipe_on_offline interface
Patch #4: Being force_empty into default hierarchy
Patch #5: Document update

Yang Shi (5):
      doc: memcontrol: fix the obsolete content about force empty
      mm: memcontrol: add may_swap parameter to mem_cgroup_force_empty()
      mm: memcontrol: introduce wipe_on_offline interface
      mm: memcontrol: bring force_empty into default hierarchy
      doc: memcontrol: add description for wipe_on_offline

 Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++++++++
 Documentation/cgroup-v1/memory.txt      | 17 ++++++++++++---
 include/linux/memcontrol.h              |  3 +++
 mm/memcontrol.c                         | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 98 insertions(+), 8 deletions(-)
