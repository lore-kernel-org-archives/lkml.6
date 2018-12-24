Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3045C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732CD218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545642682;
	bh=b1+7rlVG9961bCpcbJnnIbbArhO6dYSQ7SbsQ2AO0CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r40uvjr+Udo9owduW0+7Yf3v5LJwWx2r+uU+dmTwEuIRJRgLyGAL5sMZvTR2ldIfj
	 l/fyEBTggh9/oJ5hwrjYxb64JYuWq7AGayW4ouYlaoiZ1jE3C2X3zrWmb3AohN6m17
	 hIvuE6MqW8+b00tkmRgkM+fyNSzimMDJWy3MLDUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbeLXJLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:11:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54987 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLXJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:11:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so10689471wmh.4;
        Mon, 24 Dec 2018 01:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUfZ4bjB7/T4b0b3RLIppYng0yOMmN/NLKJYbfhY1CM=;
        b=ug83gFKBTrAJ8gAUu85IP8JdpGIG18NyMreoyfXWPJ0+5XSal6JlQb72ZVG/mUww1o
         DgGuPZQB2deStdRjkSzUoNqu9/Y2ZZEG5yigeGHHe1AqHbrzmBmyeW1cQQ1L6MtFGIgg
         VhJwHL1HiWdFEspTma8BmRuq8UJQp5tvOkcUD3jN1yUQzAzZw44vfRfxIQmOI5GioAVb
         ssNCNuDw7Xzsknqs3fyWF1wVYUqccr+5PtmhHs6ARUH1i4mgS/6fqops/tn+bxyCW2qf
         WeQIScwmJFeiIDPllAkcqwPKUJ0ywGJB6Kb4fo0r/GSWMQrFfi2qtG1KQkF4SgtkEeUS
         jdJA==
X-Gm-Message-State: AA+aEWaeOIzhrE8eoPYwl22+L/FNcLRoriUP97ZY1dlbOhmLeXdBFNxe
        pHyDK2AprYTgH6q8shMNNKE=
X-Google-Smtp-Source: AFSGD/UrnbShdOEX9tgTI9VOtu/OA5auG2lOOXfzMPyYnxxle+3SVZPRU+cvADHmGRyI364ntG+nKQ==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr11171339wme.81.1545642678455;
        Mon, 24 Dec 2018 01:11:18 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-137-231.eurotel.cz. [37.188.137.231])
        by smtp.gmail.com with ESMTPSA id c129sm14462948wma.48.2018.12.24.01.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 01:11:17 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Burt Holzman <burt@fnal.gov>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: [PATCH] memcg, oom: notify on oom killer invocation from the charge path
Date:   Mon, 24 Dec 2018 10:11:07 +0100
Message-Id: <20181224091107.18354-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <5ba5ba06-554c-d1ec-0967-b1d3486d0699@fnal.gov>
References: <5ba5ba06-554c-d1ec-0967-b1d3486d0699@fnal.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Burt Holzman has noticed that memcg v1 doesn't notify about OOM events
via eventfd anymore. The reason is that 29ef680ae7c2 ("memcg, oom: move
out_of_memory back to the charge path") has moved the oom handling back
to the charge path. While doing so the notification was left behind in
mem_cgroup_oom_synchronize.

Fix the issue by replicating the oom hierarchy locking and the
notification.

Reported-by: Burt Holzman <burt@fnal.gov>
Fixes: 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the charge path")
Cc: stable # 4.19+
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi Andrew,
I forgot to CC you on the patch sent as a reply to the original bug
report [1] so I am reposting with Ack from Johannes. Burt has confirmed
this is resolving the regression for him [2]. 4.20 is out but I have
marked the patch for stable so it should hit both 4.19 and 4.20.

[1] http://lkml.kernel.org/r/20181221153302.GB6410@dhcp22.suse.cz
[2] http://lkml.kernel.org/r/96D4815C-420F-41B7-B1E9-A741E7523596@services.fnal.gov

 mm/memcontrol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6e1469b80cb7..7e6bf74ddb1e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1666,6 +1666,9 @@ enum oom_status {
 
 static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 {
+	enum oom_status ret;
+	bool locked;
+
 	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		return OOM_SKIPPED;
 
@@ -1700,10 +1703,23 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		return OOM_ASYNC;
 	}
 
+	mem_cgroup_mark_under_oom(memcg);
+
+	locked = mem_cgroup_oom_trylock(memcg);
+
+	if (locked)
+		mem_cgroup_oom_notify(memcg);
+
+	mem_cgroup_unmark_under_oom(memcg);
 	if (mem_cgroup_out_of_memory(memcg, mask, order))
-		return OOM_SUCCESS;
+		ret = OOM_SUCCESS;
+	else
+		ret = OOM_FAILED;
 
-	return OOM_FAILED;
+	if (locked)
+		mem_cgroup_oom_unlock(memcg);
+
+	return ret;
 }
 
 /**
-- 
2.19.2

