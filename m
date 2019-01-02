Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A8C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5495D218FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwipEX4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfABSCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:02:19 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38364 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfABSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:02:19 -0500
Received: by mail-pg1-f202.google.com with SMTP id x26so27487060pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5dUXWnMYVxK4GhlE9mU3i7S+YQhp/yuwfcvNZh6pQ54=;
        b=qwipEX4wIkJkoVONyw3px8ydt+BiUWSb5U5RBPSsg7mhqCD+4qDp9Uj7JYhb/A9Wor
         HGqBh8MUbe7wxfjpQpqc+O8AenWmE4OjT/7XjR4dKHO72AkllbS6mYl+xwh2rAwMGRVy
         BeEtch55uq4z+z+HihCDU/thB4jlyVfn7Ax0WKYyWHtP4mvf1pkAT/gw9M1obguZFDwz
         VXYecv1XxqTFYnefuQotftd9giuHUU/3eX7wCghZm0IGTbQDkI4F3ArxMZGS8pKURKGH
         GWEb7bvAiTowOkeKfzxgaSbx7UHm1gD5UZrvAN4lhg6X5eSgig7+6g51ewHZVobYp4u5
         SpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5dUXWnMYVxK4GhlE9mU3i7S+YQhp/yuwfcvNZh6pQ54=;
        b=ldOK5IgKid/evOJX3j9V5h02Ug/gNik0lYAVEb5CAhHptiJ45UpXh0krJisIYsOHNT
         RCsLDA1Zw+SdaA5xb75Jq+woiiWbpHFrAii/IPncfO07pysxuEnv4SVUuy+3F1t/TiNX
         FYGEifPJOJRTT4RjwBxarF6c/1EBVx3U7bOskAQRy+5LcAwoUzJRfjwndO1luwdlNyIX
         qNN67gpxUwC7W/pfXxVsZUFRmO+sCcWlw7I2/3cK9GlP5m7TFkYrgBc5lBuv/OiRyexd
         /g8xUzeK5+uDw8HKvWNLIrwUwDp18Hfdno2zrvCGRsNT97N1KvL/wgBFNJ0kSC4SMHcc
         n+Vw==
X-Gm-Message-State: AA+aEWYpAI6c5NVSIFgVcfuQeAJqQpHXOoNyWwvU9NrFuweOhuF0JFg9
        zfVi6BQWGeP+LuVp+hA0qOedrufSRpJCMA==
X-Google-Smtp-Source: AFSGD/WvKYzExjx3kanWeTXSxjcrXDOcA3b9GU3ybkrL1kzUW/cmA5LtiGb7NwqgZ+pIcpg3kHSdFAwvMzIcAw==
X-Received: by 2002:aa7:8714:: with SMTP id b20mr20428221pfo.85.1546452138509;
 Wed, 02 Jan 2019 10:02:18 -0800 (PST)
Date:   Wed,  2 Jan 2019 10:01:45 -0800
Message-Id: <20190102180145.57406-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] fork, memcg: fix cached_stacks case
From:   Shakeel Butt <shakeelb@google.com>
To:     Rik van Riel <riel@surriel.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on
memcg charge fail") fixes a crash caused due to failed memcg charge of
the kernel stack. However the fix misses the cached_stacks case which
this patch fixes. So, the same crash can happen if the memcg charge of
a cached stack is failed.

Fixes: 5eed6f1dff87 ("fork,memcg: fix crash in free_thread_stack on memcg charge fail")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index e4a51124661a..593cd1577dff 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -216,6 +216,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		memset(s->addr, 0, THREAD_SIZE);
 
 		tsk->stack_vm_area = s;
+		tsk->stack = s->addr;
 		return s->addr;
 	}
 
-- 
2.20.1.415.g653613c723-goog

