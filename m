Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE2C41518
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49097218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="HSlGn43T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAWWbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:31:46 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39185 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfAWWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:31:46 -0500
Received: by mail-yw1-f68.google.com with SMTP id k188so1603058ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rN8KV8MqbWC2EzLp/Y3zp+83cz1GfcZCLRbo4f/oY74=;
        b=HSlGn43T/DPjcpxY2PHRVu5emRtk6G3y3/2N+3fPvO4BIBYuyxKbQVal+a3OPdq0d2
         FHrF4yEJD/k1F/jtCNZ9VK6eBNouqJ3EVBdmc2Ht3rBYTihQb4mXfIOaUOhIdU+TAWm2
         RJGVihJfhTS9IVLmmR21QUwV6Dtasmzv3PUCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rN8KV8MqbWC2EzLp/Y3zp+83cz1GfcZCLRbo4f/oY74=;
        b=uCePun32bPNWtHxNu8iCSPdRn7fI20EkWH56HDqoVImlKUsBJGPBcC7Hia3EuM4pZI
         Rb/ChhIbCd/tBGosqyOThxW2iFlKiNtMVoJ+5oO8aHJM/HmnKdocdPL3PxSJKk3ktk3Z
         D7/QcpCtFvkReY80lA1hs4H6wkxdcIBV8mQNqw4tgcYAXKWGRDBTNnpPSRDKLaUkKGxb
         aOUSRySrKMiR1or1CsU5HOLI3ZfSgo6Z8GDnp4vQAua39wp4ca9Ymc1rLefP0vKBBHCm
         eQKuPUcFZg/6m0qyKBn2nAeQ+mk4F0esJCRaKonExplMzAnbLFJ9pxOfE++Tz7nyNHuZ
         dsgA==
X-Gm-Message-State: AJcUukckVuIVN7apvnHrTO2uvejPVK7tNqD9Dbf71eIBg5qDfqJ9iTFe
        3xbMfSxFiywtDNfDqWol8xKJQQ==
X-Google-Smtp-Source: ALg8bN40eS4e/F5lkk+WMZkqLL0VlzoE7n63AlUxPDaTsYNruD/BT6hchGE5b3Ze/PIg84m36SDSow==
X-Received: by 2002:a81:ac1e:: with SMTP id k30mr4100091ywh.513.1548282705278;
        Wed, 23 Jan 2019 14:31:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:a24b])
        by smtp.gmail.com with ESMTPSA id x132sm16043434ywx.27.2019.01.23.14.31.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 23 Jan 2019 14:31:44 -0800 (PST)
Date:   Wed, 23 Jan 2019 17:31:44 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190123223144.GA10798@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory.stat and other files already consider subtrees in their output,
and we should too in order to not present an inconsistent interface.

The current situation is fairly confusing, because people interacting
with cgroups expect hierarchical behaviour in the vein of memory.stat,
cgroup.events, and other files. For example, this causes confusion when
debugging reclaim events under low, as currently these always read "0"
at non-leaf memcg nodes, which frequently causes people to misdiagnose
breach behaviour. The same confusion applies to other counters in this
file when debugging issues.

Aggregation is done at write time instead of at read-time since these
counters aren't hot (unlike memory.stat which is per-page, so it does it
at read time), and it makes sense to bundle this with the file
notifications.

After this patch, events are propagated up the hierarchy:

    [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
    low 0
    high 0
    max 0
    oom 0
    oom_kill 0
    [root@ktst ~]# systemd-run -p MemoryMax=1 true
    Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
    [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
    low 0
    high 0
    max 7
    oom 1
    oom_kill 1

Signed-off-by: Chris Down <chris@chrisdown.name>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 include/linux/memcontrol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 380a212a8c52..5428b372def4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -769,8 +769,10 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
-	atomic_long_inc(&memcg->memory_events[event]);
-	cgroup_file_notify(&memcg->events_file);
+	do {
+		atomic_long_inc(&memcg->memory_events[event]);
+		cgroup_file_notify(&memcg->events_file);
+	} while ((memcg = parent_mem_cgroup(memcg)));
 }
 
 static inline void memcg_memory_event_mm(struct mm_struct *mm,
-- 
2.20.1

