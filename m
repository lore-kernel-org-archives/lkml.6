Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BDDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA92082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131628;
	bh=4ZHIpXGs3X3aNF+ZxopMafrOv6oPkaRCuCcO5RJUKA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bq1rvLpwYhTKSiPqg+X4pzBCYTTi3NCe6Rt9Uz3mhfRYJVXZ80QXHTjqubzTi55FV
	 xYGH/N8qj6umiSqQbrx/Gsk9mNNByn4Nz+dQY8C0jCO7nBadFvMc3OG1jlD1PDevgF
	 +Viva8gfgl27KFIx0rGBUVFlZjQGtw0hjljNkOVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDA92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbeLFV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLFV1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:06 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8A72082B;
        Thu,  6 Dec 2018 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131625;
        bh=4ZHIpXGs3X3aNF+ZxopMafrOv6oPkaRCuCcO5RJUKA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSlvF//A2agxcDfWiCe5mgOCMxL3RIxXV+j7ePogGdMc/ZZc2plZFaopxQTg155WJ
         LazuMd0vFTZlliJjvj+j2HaAIbvy2W0r5PTimVc5lKqJgZ6GaxS/BxYcDXS2FIPDNZ
         2vlHb+xBmosUY3hdZsLQpzmoN8hasIAnshq92+Ro=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/75] perf tools: Use fallback for sample_addr_correlates_sym() cases
Date:   Thu,  6 Dec 2018 18:24:55 -0300
Message-Id: <20181206212602.20474-9-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

thread__resolve() is used in the sample_addr_correlates_sym() cases
where 'addr' is a destination of a branch which does not necessarily
have the same cpumode as the 'ip'. Use the fallback function in that
case.

This patch depends on patch "perf tools: Add fallback functions for
cases where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181106210712.12098-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 9431b20c1337..24493200cf80 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1706,7 +1706,7 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
-- 
2.19.2

