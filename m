Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6623DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A9320821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOFsBr7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeKAIIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbeKAIIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA2620840;
        Wed, 31 Oct 2018 23:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027290;
        bh=/UnV7f4efCNnuHnFaiGBHQQzWtx0AD4VBrhAJZCcOl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOFsBr7/bOE89N179dWfCBZ7490OIQy7qcz4xwPORjGgb9B06fLLfaJn9nc4MyUO9
         dJTsswxwLG5u0ObSXkx+YkbHRANSk4yKCag8oJ25dSSjAsjAVzpMrf/20e2ttrFgBp
         QTnlMMty+67fTt+6GCE8YWJsikNXyWYkmZXXUbHc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sanskriti Sharma <sansharm@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 017/126] perf tools: Cleanup trace-event-info 'tdata' leak
Date:   Wed, 31 Oct 2018 19:06:05 -0400
Message-Id: <20181031230754.29029-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit faedbf3fd19f2511a39397f76359e4cc6ee93072 ]

Free tracing_data structure in tracing_data_get() error paths.

Fixes the following coverity complaint:

  Error: RESOURCE_LEAK (CWE-772):
  leaked_storage: Variable "tdata" going out of scope leaks the storage

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-3-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/trace-event-info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 7b0ca7cbb7de..8ad8e755127b 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -531,12 +531,14 @@ struct tracing_data *tracing_data_get(struct list_head *pattrs,
 			 "/tmp/perf-XXXXXX");
 		if (!mkstemp(tdata->temp_file)) {
 			pr_debug("Can't make temp file");
+			free(tdata);
 			return NULL;
 		}
 
 		temp_fd = open(tdata->temp_file, O_RDWR);
 		if (temp_fd < 0) {
 			pr_debug("Can't read '%s'", tdata->temp_file);
+			free(tdata);
 			return NULL;
 		}
 
-- 
2.17.1

