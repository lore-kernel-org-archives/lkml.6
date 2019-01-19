Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B218BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700CE20823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGKb6hlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfASIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:12:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfASIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:12:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so7367038plt.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DinPHAJSPmxZLoL+N/GbXLkbJIFCbPmSHWviXFvpNU0=;
        b=XGKb6hlTIWLz2+VHjnciHgQm743/XEBkGzBJfVHEjYCHzcmuDmS6JDXVHtm5rnMB+i
         n2jpXGl1CKmxSxlgHegJy9aMYHitRczuqPAx/jEdPzq8lCHxYDQrrpILFVv7MSmgr14d
         x0s8ZcvOR2ZCfB48DKGkqXHhOF9fvPXczMgaLb/aGYQvaoqJF76ACXON4ZptPmMbxQuv
         N5woZu5FZCh1piIJfV2+crKa9yfDYjX137EGYUOeSqzIG6R9TS5baGkLQPIzJnaWU6zP
         JQOsVgIjimkA76IZeIRHjUo05hKPvlhMZkbBb6kXoTxt1/D13d/u2LMJcSdAIS03luot
         ka9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DinPHAJSPmxZLoL+N/GbXLkbJIFCbPmSHWviXFvpNU0=;
        b=lNOU3V5C+UvZOYcvUFtszjvhfvvaDJoG1NU0jMROIzN9S5vNUroqB1kdVe8Z+0M6Ah
         runqUbWmziK2PYCHx36Ft7RFfeO/7bFULaZvUeIFbd5TFwDl7BrKlrpCgLj9+7j0ko+A
         YwfqPfKOXBEdAoBHiOr0dO8xgPjG+FCD2cU+MLYQw4pjIt8yic1+RlAgtolHtZWk0EYI
         gV2OW58SalsFRbQ5qlJchcaawuHOo4vQGmTtU52labnd78dKgCgjL7e5MsuqFl655kiP
         jYLxOJD8v27yWDfJYkayJ0GlUO7t2ec2QLCiRvuVjCYdwYnepySPYXmwwatKbzRiFBPA
         GKMA==
X-Gm-Message-State: AJcUukcMyA2t6Tj11AZs8DXCSkHNgUNdd0mYgbQyEkK4D2+rCosPaPV2
        chDBsVXSslrA0EvAs+ryLAykobem+YhlDA==
X-Google-Smtp-Source: ALg8bN78xJoFx2mbz3abGES53IcLRWSE1h8yog+Xhe8FdtbfDMooz/qF2HIKVKPz2cBQdg7xyjHDRA==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr22458294plp.34.1547885576028;
        Sat, 19 Jan 2019 00:12:56 -0800 (PST)
Received: from localhost (c-67-169-55-77.hsd1.ca.comcast.net. [67.169.55.77])
        by smtp.gmail.com with ESMTPSA id t3sm6585265pgv.31.2019.01.19.00.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:12:53 -0800 (PST)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@elte.hu, ak@linux.intel.com, kan.liang@intel.com
Subject: [PATCH] perf tools: handle TOPOLOGY headers with no CPU
Date:   Sat, 19 Jan 2019 00:12:39 -0800
Message-Id: <1547885559-1657-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue in cpumap.c when used with the
TOPOLOGY header. In some configurations, some NUMA nodes may
have no CPU (empty cpulist). Yet a cpumap map must be created
otherwise perf abort with an error. This patch handles this
case by creating a dummy map.

Before:
$ perf record -o - -e cycles noploop 2 | perf script -i -
0x6e8 [0x6c]: failed to process type: 80

After:
$ perf record -o - -e cycles noploop 2 | perf script -i -
noploop for 2 seconds

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/cpumap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd3342069..383674f448fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	if (!cpu_list)
 		return cpu_map__read_all_cpu_map();
 
-	if (!isdigit(*cpu_list))
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
 		goto out;
 
 	while (isdigit(*cpu_list)) {
@@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
+	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
+	else
+		cpus = cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
-- 
2.7.4

