Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A88DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA022192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="T68qNAfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfBOSPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:15:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37013 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbfBOSOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:14:34 -0500
Received: by mail-yw1-f65.google.com with SMTP id k14so4045194ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Mi2kL/2WsC77PZT2+GFY8rm4/RmpjTroxvb9aqMFLo=;
        b=T68qNAfXm8z8Lj+3Sujbvrk6lrgzOm9xtKSZ/IbmFiUVElTgSyqQ2V+u8V/D9scygU
         xxfD6Glf1ZjEFDVjQQL1tMksAEl64SR6rxg+DSZh4qQylcB+qKG7yvncHsUD6laSivYP
         yrEesjRu1nLQkP3oKWLthCKmAAhpLG/cLBDhHmDEZHhlsOsBcznvipgKZKTxTcWUSIlS
         3CGsUy80UjqzcUyhdj0RAav/iNiNe2XnpUFfM0WEFDf/Nju/TBXsm4AIq5xgFLVGyhme
         /L0ACh/CL4wCcQTp/ogKd2o1NGC+q+Wz6XVJ5SxvPfpO1E1z2MSsbYxU1mnLMYATxkqx
         ds+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Mi2kL/2WsC77PZT2+GFY8rm4/RmpjTroxvb9aqMFLo=;
        b=XHHy5W+koJo4qkEUmFxEySr+N5b7MNSslOdRkZEsvpivHIe0+f3rclYviO3mtHZCa8
         O2UUo+dVt4GN0XthjC5U35D8hKaI97Auh/x8qBxn+EUHi2cq146xm1GwHjR1V9xlQg6T
         r/4wJZSCFVtGvGIi1V1VP3hrSR1pmjUJhaQnJIFx++PnnnLVeVjh3yq54F2KDZdG/4xJ
         d+1Pm9VZ3PVkyEqFqdVoLUsjZC7H41vCZKc6vQi+CpQvc05aRaQjUeuy0MyXhsmf+yuZ
         78BIdSK90g9HNmXCgC4sKLSO8dH/uDk53zXegSojzYwfU0u/59SafhrE7AAl2Lm3XDLg
         Xgeg==
X-Gm-Message-State: AHQUAuaIIVQr4dVvp7VTtl6NfXT9gm1ErtPLzOewe4WPEfe0sGMRUEPY
        hJyhu03ZPhBU7Dt8EPA2w2qBKbHsFG0=
X-Google-Smtp-Source: AHgI3IajdWAbqPOMknx8ni8lnxgBEq1c4triDMsgoY5L29gO6lYAJj0wzEH0Eefp7qQvohqB2OEqow==
X-Received: by 2002:a0d:d857:: with SMTP id a84mr9171114ywe.121.1550254473071;
        Fri, 15 Feb 2019 10:14:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:33c1])
        by smtp.gmail.com with ESMTPSA id j22sm1915679ywj.37.2019.02.15.10.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:14:32 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/6] mm: memcontrol: replace zone summing with lruvec_page_state()
Date:   Fri, 15 Feb 2019 13:14:21 -0500
Message-Id: <20190215181425.32624-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215181425.32624-1-hannes@cmpxchg.org>
References: <20190215181425.32624-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding up the zone counters, use lruvec_page_state() to get
the node state directly. This is a bit cheaper and more stream-lined.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 18 ------------------
 mm/memcontrol.c            |  2 +-
 mm/vmscan.c                |  2 +-
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 83ae11cbd12c..206090de5d7c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -499,19 +499,6 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 					   int nid, unsigned int lru_mask);
 
-static inline
-unsigned long mem_cgroup_get_lru_size(struct lruvec *lruvec, enum lru_list lru)
-{
-	struct mem_cgroup_per_node *mz;
-	unsigned long nr_pages = 0;
-	int zid;
-
-	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	for (zid = 0; zid < MAX_NR_ZONES; zid++)
-		nr_pages += mz->lru_zone_size[zid][lru];
-	return nr_pages;
-}
-
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
@@ -947,11 +934,6 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return true;
 }
 
-static inline unsigned long
-mem_cgroup_get_lru_size(struct lruvec *lruvec, enum lru_list lru)
-{
-	return 0;
-}
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b32389..a04177f25758 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -730,7 +730,7 @@ unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += mem_cgroup_get_lru_size(lruvec, lru);
+		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
 	}
 	return nr;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e979705bbf32..f88fef03fc04 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -346,7 +346,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 	int zid;
 
 	if (!mem_cgroup_disabled())
-		lru_size = mem_cgroup_get_lru_size(lruvec, lru);
+		lru_size = lruvec_page_state(lruvec, NR_LRU_BASE + lru);
 	else
 		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
 
-- 
2.20.1

