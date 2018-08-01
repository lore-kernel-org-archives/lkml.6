Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F9C46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DD320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeHAMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:43:34 -0400
Received: from mx59.baidu.com ([61.135.168.59]:11936 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387716AbeHAMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:43:34 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 1FD682040051;
        Wed,  1 Aug 2018 18:48:36 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH 1/2] mm: add a function to return a bdi_writeback dirty page statistic
Date:   Wed,  1 Aug 2018 18:48:35 +0800
Message-Id: <1533120516-18279-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this is a preparation to optimise a full writeback
when reclaim memory

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/memcontrol.h | 2 +-
 mm/memcontrol.c            | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..58e29555ac81 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1141,7 +1141,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
 void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 			 unsigned long *pheadroom, unsigned long *pdirty,
 			 unsigned long *pwriteback);
-
+unsigned long mem_cgroup_wb_dirty_stats(struct bdi_writeback *wb);
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static inline struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c0280b3143e..82d3061e91d1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3640,6 +3640,12 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	}
 }
 
+unsigned long mem_cgroup_wb_dirty_stats(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
+
+	return memcg_page_state(memcg, NR_FILE_DIRTY);
+}
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
-- 
2.16.2

