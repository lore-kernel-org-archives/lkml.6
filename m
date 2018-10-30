Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE78ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1647C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eileY9ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1647C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeJ3WVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbeJ3WVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F0620838;
        Tue, 30 Oct 2018 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906082;
        bh=1JT5qScqdN7PJo5N0JgNLhXWvF5XsK9Ra2oQwhCloh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eileY9ahGbY4C7qlfyzPvHSjkG/oF9ihv/6vIDDdEPtuhDlF1oWGPBFdFkxHyRUvA
         5pQD6SAGnx5LZ1hk8fd6VKmmoin0vXlDJMcbfnj+BwpKjCGq4D5ODmiRni6AiSrMHO
         rIJiAlDDHdqKasW6kdRFpCiRxdgT9eBz7BlpmBQA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 23/33] perf cpu_map: Align cpu map synthesized events properly.
Date:   Tue, 30 Oct 2018 09:26:47 -0400
Message-Id: <20181030132657.217970-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

[ Upstream commit 0ed149cf5239cc6e7e65bf00f769e8f1e91076c0 ]

The size of the resulting cpu map can be smaller than a multiple of
sizeof(u64), resulting in SIGBUS on cpus like Sparc as the next event
will not be aligned properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
Link: http://lkml.kernel.org/r/20181011.224655.716771175766946817.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0c8ecf0c78a4..6f3db78efe39 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1074,6 +1074,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
-- 
2.17.1

