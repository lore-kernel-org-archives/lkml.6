Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B34ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB5820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeGWN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWN3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:51 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CECA3C03;
        Mon, 23 Jul 2018 12:28:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jing Xia <jing.xia.mail@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        chunyan.zhang@unisoc.com, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 14/44] mm: memcg: fix use after free in mem_cgroup_iter()
Date:   Mon, 23 Jul 2018 14:24:50 +0200
Message-Id: <20180723122438.123867040@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jing Xia <jing.xia.mail@gmail.com>

commit 9f15bde671355c351cf20d9f879004b234353100 upstream.

It was reported that a kernel crash happened in mem_cgroup_iter(), which
can be triggered if the legacy cgroup-v1 non-hierarchical mode is used.

Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b8f
......
Call trace:
  mem_cgroup_iter+0x2e0/0x6d4
  shrink_zone+0x8c/0x324
  balance_pgdat+0x450/0x640
  kswapd+0x130/0x4b8
  kthread+0xe8/0xfc
  ret_from_fork+0x10/0x20

  mem_cgroup_iter():
      ......
      if (css_tryget(css))    <-- crash here
	    break;
      ......

The crashing reason is that mem_cgroup_iter() uses the memcg object whose
pointer is stored in iter->position, which has been freed before and
filled with POISON_FREE(0x6b).

And the root cause of the use-after-free issue is that
invalidate_reclaim_iterators() fails to reset the value of iter->position
to NULL when the css of the memcg is released in non- hierarchical mode.

Link: http://lkml.kernel.org/r/1531994807-25639-1-git-send-email-jing.xia@unisoc.com
Fixes: 6df38689e0e9 ("mm: memcontrol: fix possible memcg leak due to interrupted reclaim")
Signed-off-by: Jing Xia <jing.xia.mail@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: <chunyan.zhang@unisoc.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -879,7 +879,7 @@ static void invalidate_reclaim_iterators
 	int nid;
 	int i;
 
-	while ((memcg = parent_mem_cgroup(memcg))) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		for_each_node(nid) {
 			mz = mem_cgroup_nodeinfo(memcg, nid);
 			for (i = 0; i <= DEF_PRIORITY; i++) {


