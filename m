Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E40C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB8E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RhAWH6Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB8E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeGIQLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:11:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39325 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeGIQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:11:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so14365402eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3X9JFFs1YGW+QQRwFTsTnOJ4GgEVhsAf6HK9Pv7S2S8=;
        b=RhAWH6EinrTh5qYhnpcglt/c6pCXSskeZMHEWL4Wg5REOO3jfx9XV8HnU3iGZDnw9l
         NOxfHnqdYNvriVQvXks7piM4WlpQYy85YMReBtKWHVKeROQs+8BhhKTJlyrByiBipi0W
         C/E8yye12PwPaZQnQ/QTX0a3vIS8anp1eyR8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3X9JFFs1YGW+QQRwFTsTnOJ4GgEVhsAf6HK9Pv7S2S8=;
        b=bXwTeMb8Us4aUjcKlxTdWHcb3uyXRk8HCzbbkAXoCOvK5oCuO9Hb1FAMeZ3/W6DWGV
         r2VNQWgbiLU6sQxOc6o4wTpIe2XEV8d5mLTD2ep0/mo2pDtoyQ44UKdOD2ev9r/bbu+j
         d4QS1nQF/5Ba/ijCxBC4sVbi4Kb/3nl7DgT4vwBBj9o2lXKwMkZQl4f2lagCnxvWBaeB
         Z+YRKb6Cvsdma638Rl/xl3cUjRzuBlchDQdsmzkwyA0hEwP5JiLR799HXOV4jXG7nlen
         JZmacndDBvy3eOIqIGTFC+wUf8Ueu4mQ4CgL/3BdDmqn0LMIPMA6ovc8aUKhWfGQ/5lk
         Ymbg==
X-Gm-Message-State: APt69E0rPf0JXQvxYOZdCaD+Id2NjzAFVkIZJHk1GVFSTz6G5guU8ONZ
        N+YsEDYRPtl01SovF9kvtSHyTuSq
X-Google-Smtp-Source: AAOMgpeH0zEbBBcRCKg9sZb1QKJgO+OyVWrc4SRAzGoDstDanHiy8psAxktZIDbw9kUUHMowho/0GQ==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr22006389edg.25.1531152702120;
        Mon, 09 Jul 2018 09:11:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id i89-v6sm7191441edi.10.2018.07.09.09.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 09:11:41 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Eric Engestrom <eric.engestrom@intel.com>
Subject: [PATCH] cpufreq: use for_each_if
Date:   Mon,  9 Jul 2018 18:11:29 +0200
Message-Id: <20180709161129.28425-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-4-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-4-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted condition compared to the open coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Eric Engestrom <eric.engestrom@intel.com>
--
v2: Fix the logic fumble in the 2nd hunk, spotted by Eric.
---
 include/linux/cpufreq.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..3a774f523d00 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -649,9 +649,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 #define cpufreq_for_each_valid_entry(pos, table)			\
 	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)	\
-		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
-			continue;					\
-		else
+		for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
 
 /*
  * cpufreq_for_each_valid_entry_idx -     iterate with index over a cpufreq
@@ -663,9 +661,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 #define cpufreq_for_each_valid_entry_idx(pos, table, idx)		\
 	cpufreq_for_each_entry_idx(pos, table, idx)			\
-		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
-			continue;					\
-		else
+		for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
 
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-- 
2.18.0

