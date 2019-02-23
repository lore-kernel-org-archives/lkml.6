Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B827CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535120652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957259;
	bh=cJ9bIiZXBnyc9CPvRT10mMqIDiOGcKiK5Uc8AtV4ElQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D9hpC8sAoRHhmyzEN5vl8JL7AqTIvOvezgFRPglnH7iAPa/o4S8/ZB6wjLEcECHFL
	 zhUFiReRXHnIssW7Su6OEJt471n/kpSrKhwMivS+G4RHa6A2dvXpKXvX8sjlx5s4hY
	 7nM4KhLL4c3Qh54OUWXwWrJgQqa/SnBwjC84J+Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfBWVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbfBWVGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B90820855;
        Sat, 23 Feb 2019 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956011;
        bh=cJ9bIiZXBnyc9CPvRT10mMqIDiOGcKiK5Uc8AtV4ElQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUZC4lrFdwGRUTjB/XGnobl6nFBBLVikzDI95Ypsnt8jmQWSidSw+hMDaCEuQDT+2
         kT102ko9yNI0PpctR9CHFGCQk4gwZyC3yTjwggYzTBrw8Y9w7GBNAHJb/iVCUBiowZ
         zHhwzWzb/EFCnFzU9xpfsRyzjCTu9g2/+n0jb7ts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 08/65] perf tools: Handle TOPOLOGY headers with no CPU
Date:   Sat, 23 Feb 2019 16:05:43 -0500
Message-Id: <20190223210640.200911-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

[ Upstream commit 1497e804d1a6e2bd9107ddf64b0310449f4673eb ]

This patch fixes an issue in cpumap.c when used with the TOPOLOGY
header. In some configurations, some NUMA nodes may have no CPU (empty
cpulist). Yet a cpumap map must be created otherwise perf abort with an
error. This patch handles this case by creating a dummy map.

  Before:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  0x6e8 [0x6c]: failed to process type: 80

  After:

  $ perf record -o - -e cycles noploop 2 | perf script -i -
  noploop for 2 seconds

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1547885559-1657-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cpumap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd33420694..383674f448fcd 100644
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
2.19.1

