Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59863ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D55321477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1afDyVsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D55321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJRGxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeJRGxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:53:41 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0474E21477;
        Wed, 17 Oct 2018 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539816948;
        bh=7kGPU12HmcqKw67EH33k0zhVsGscANjFI61IolNB2Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1afDyVsEsF3zKCYrtdUsJhO3y7Gwj0Dyi9m/EdfEcSUKV1SxdAgKRu5EmO8lbRBGY
         9hij4wdvVlteWQMUZgeKVUW/lz6KSWXyT9pcM31/WHJTpNRNGLiGN7TjkaqkfXaVAm
         Srd6b4Y3OCHoPtqNtX6Uf3yqbMKFVHb31Xm1Kua4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/11] perf cpu_map: Align cpu map synthesized events properly.
Date:   Wed, 17 Oct 2018 19:54:58 -0300
Message-Id: <20181017225501.32150-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

The size of the resulting cpu map can be smaller than a multiple of
sizeof(u64), resulting in SIGBUS on cpus like Sparc as the next event
will not be aligned properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
Link: http://lkml.kernel.org/r/20181011.224655.716771175766946817.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..0988eb3b844b 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1081,6 +1081,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
 	}
 
 	*size += sizeof(struct cpu_map_data);
+	*size = PERF_ALIGN(*size, sizeof(u64));
 	return zalloc(*size);
 }
 
-- 
2.14.4

