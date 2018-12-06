Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F3C214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131811;
	bh=5ZIUrOlDeNqkRVkq2d2Q+ApDWwN+kvJSlI7p6Qfdm74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZNBH56qzE6nkzeot8l1xLrXdQxfDaFATM5mgr9USm7jads1G3kLCE0YC3dS8D/6M
	 Tglafh2r+7qswivKj3GMwYJkegkQzRVKK+39kaW0mV573LbnUP6lVZehx55pbhztZ7
	 9wJ34D/o8zV7tiL58950v/6uY3v9YlGXGQgfseZs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F3C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeLFVaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeLFVaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:07 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD650208E7;
        Thu,  6 Dec 2018 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131806;
        bh=5ZIUrOlDeNqkRVkq2d2Q+ApDWwN+kvJSlI7p6Qfdm74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlpy9o7zEBwk9e47g9i+VgmRm6fT/b8K2865Fw3AxxNrjwcamtXi2xQjv5XwJxZvt
         51G+EyQD2a3lPXD2OXfiepK0lHvOudXiE0PKhPOuXBDnJRSpJqwMP2629gD8xSr4L2
         Nn3SztiV+l5YvIjPGGi7tWVhbgOoyDnT0TFWdBPI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 55/75] perf top: Display slow reader warning when droping samples
Date:   Thu,  6 Dec 2018 18:25:42 -0300
Message-Id: <20181206212602.20474-56-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we display the "Too slow to read ring buffer.." helpline only
in the slow reader thread. This patch triggers it also when the
processing thread drops samples, because it has the same reason, which
is too many data on input.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-bnev2mloavyurmgchcr3o24o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9166f6087e3f..f22c531be366 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -571,7 +571,7 @@ static void perf_top__sort_new_samples(void *arg)
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
 
-	if (t->lost)
+	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
 
 	perf_top__reset_sample_counters(t);
-- 
2.19.2

