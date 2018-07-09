Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30244C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD89720864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="atYrFlO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD89720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeGIIhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeGIIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12-v6so13258395edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXtsumn5SIyhpMp7CSWqD0jPr1yatINHJtRo7XapFQg=;
        b=atYrFlO+YUtRBqhz46HLUWgFYEtx28erU11aJl7DfnYTW05HeVvgAbehlAklrUr/PW
         FXM1X59xpdFLp12A9gNehwLi1RyluI/vVMIgYszmSZYgOZJ1imL68s/cp8EDxb3SxAb2
         DZFLO3lSXfWLvhHAE6bMRrYetjCO2uRQKI5Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXtsumn5SIyhpMp7CSWqD0jPr1yatINHJtRo7XapFQg=;
        b=Id3J3YqKSpfP/opJI17+0yG3qpatfj+7DceM95dwp8vvp2hUwSAEW4yZf9V1Bj/3QE
         rvbi6lb5fplPSvpPYFpjSbZNi3osKwxJeXdfnBWu6TyclU7UfK3eprorxUlAXK7tK1Dk
         7SaXTrG0tG4tk5IwytW7KEY1DH/cTWKr2JDu0rsXT37ehccu3U7LBBTtUnmWtyuNdvjT
         TeEySEiut8EqpY48DDwduWewMBBwAM6mQbBEaMcLCvMLdtTT0lmY87mwJ8Aq9W62Mr18
         xYtZm/YK3z3z66TuxQj6V5t1vZBqhMNQ1u7ZavVQsotqTVtf4kaABJuNiovbY5AHcvlm
         UuEQ==
X-Gm-Message-State: APt69E27L0MM+k4VZq7jHb36nTk5veMxFr2EuiixDR0Fv3uRNHekX5do
        EQW+tPtc8qMR4YvmywynjJUd0Nli
X-Google-Smtp-Source: AAOMgpd6I1GgI8Fk3dQAUYjJcFFqyVuO0VJM84t+IT2B6tbb1EtGmvAlm5UhYA9O7a3zOuRA6kfXZw==
X-Received: by 2002:a50:8367:: with SMTP id 94-v6mr20868034edh.5.1531125421446;
        Mon, 09 Jul 2018 01:37:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:00 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 04/12] cpufreq: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:42 +0200
Message-Id: <20180709083650.23549-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted condition compared to the open coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 include/linux/cpufreq.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..f2028c229b96 100644
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
+		for_each_if (pos->frequency == CPUFREQ_ENTRY_INVALID)
 
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-- 
2.18.0

