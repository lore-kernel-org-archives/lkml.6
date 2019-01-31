Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43158218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="e5XfwYDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfAaQIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:08:05 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42969 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAaQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:08:05 -0500
Received: by mail-yb1-f196.google.com with SMTP id l20so1498293ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UP69wWmTtINd5/Z9K2WlkOH7AzazUM8Nzb3CPcSA8gQ=;
        b=e5XfwYDUxCjfYGxGVHOfo2wOQLLTu8dorggsDA1b94sfaIEhbQOcpTwGBL4wrv8DEB
         6aj6uOANmvjxCC9EDZok7Vk1Bpm49Kn7YW6vHp+em848JQLHEP8P1IkY6Akuwjl/Ke7x
         CEzZnIMsE9w8xVkUDaQEOrC4oaryD1DFRuQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UP69wWmTtINd5/Z9K2WlkOH7AzazUM8Nzb3CPcSA8gQ=;
        b=Fh1wTrEoT9WoCL0vPnZpmqYFUMOTSp92ne0gwJ9Ab+R+UVjmzmgH0lxKdVCXP6ymW8
         KfNFE020AbOLuER0cM4fR2YgjabTvV2BsZcZqLHMNMIFV7BljwOhSLoy6jyamU9u/7YG
         0RAwi3m4D4i2m//9OkUUzDdhPddsh0URQpyGmYGzHv7H5wm8hvfqI0ARDwXgZzs1BLOG
         W0gX/gCiYZvP2FvabSOVfELEWeZdDUeYYuUAUjlUPi47vv1DFYOFh7ESXwjUPzU5To+0
         2bPg6WgBlRM9/LX4Qo5ViB8oNz6a4pN/f+2mum3Gz576clBKc/00qI8Wklq4t/zxWMqH
         JKdw==
X-Gm-Message-State: AHQUAuZVgrmVOSGQOEvr/0H00WNXrPXo8tpBcuZv0BC+jIa7hf7we4dk
        ea/U9qRlVSjmFN7z6T1n9zeCGw==
X-Google-Smtp-Source: AHgI3IZ/iJQHuRIvFfVhJaEbmX7+ulluGReoNKwobgLbR9DjpGSjtPwGcIGYuyndENHvcMjuWlV6Ag==
X-Received: by 2002:a25:6041:: with SMTP id u62mr11459176ybb.149.1548950883984;
        Thu, 31 Jan 2019 08:08:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:7e97])
        by smtp.gmail.com with ESMTPSA id v9sm1968192ywh.2.2019.01.31.08.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 08:08:03 -0800 (PST)
Date:   Thu, 31 Jan 2019 11:08:02 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] fixup: mm: memcontrol: Unbreak memcontrol build when THP is
 disabled
Message-ID: <20190131160802.GA5777@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be folded into "mm: memcontrol: Expose THP events on a
per-memcg basis"
(mm-memcontrol-expose-thp-events-on-a-per-memcg-basis.patch).

kbuild points out that this patch can't be built with
CONFIG_TRANSPARENT_HUGEPAGE not set. I had originally worried about
this, but had only checked NR_ANON_THPS (which is not ifdeffed), not the
event counters.

NR_ANON_THPS is not #ifdeffed in node_stat_item, so we don't need to
also guard MEMCG_RSS_HUGE to futureproof it.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 Documentation/admin-guide/cgroup-v2.rst | 8 +++++---
 mm/memcontrol.c                         | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b6989b39ed8e..53d3288c328b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1255,12 +1255,14 @@ PAGE_SIZE multiple when read back.
 	  thp_fault_alloc
 
 		Number of transparent hugepages which were allocated to satisfy
-		a page fault, including COW faults
+		a page fault, including COW faults. This counter is not present
+		when CONFIG_TRANSPARENT_HUGEPAGE is not set.
 
 	  thp_collapse_alloc
 
-		Number of transparent hugepages which were allocated to
-		allow collapsing an existing range of pages
+		Number of transparent hugepages which were allocated to allow
+		collapsing an existing range of pages. This counter is not
+		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
 
   memory.swap.current
 	A read-only single value file which exists on non-root
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2f4fe2fb9046..bc4da016b8ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5643,9 +5643,11 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "pglazyfree %lu\n", acc.events[PGLAZYFREE]);
 	seq_printf(m, "pglazyfreed %lu\n", acc.events[PGLAZYFREED]);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	seq_printf(m, "thp_fault_alloc %lu\n", acc.events[THP_FAULT_ALLOC]);
 	seq_printf(m, "thp_collapse_alloc %lu\n",
 		   acc.events[THP_COLLAPSE_ALLOC]);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	return 0;
 }
-- 
2.20.1

