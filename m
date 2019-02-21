Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B884B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712412;
	bh=4WsGbzDBTtn1dKahAa0w8ISy6OUpRuGmYo/NfhuUcu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVGTxpyW0w2mA4aGCYnvBbaOSf/GygkQyF4bK/QW5/aHSa+9aORLzJaC7UkD3IZir
	 xVGw6mNWa8kDuifXlCF2d7r95bmNe0O80tbQgtqcEsOkaUyEVr4oS5mSU2rB8UmUJc
	 Z/aJfHTqQkWjstW6JlMEGjUimdBF8M2D6a41RKYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBUB0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBUB0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:49 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE06F21734;
        Thu, 21 Feb 2019 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712408;
        bh=4WsGbzDBTtn1dKahAa0w8ISy6OUpRuGmYo/NfhuUcu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9r+iVlx14IiD72acI91gNtfWBVglyllmgocM1MHbAzV00UzSyRfCX+zomPxYPE16
         pG3jSd4QMz+1Z2OsnhWLNMLVtQFGFTb1f5dd/q2iZUWrKqk4qJ6C7KopAcZrSmFtyJ
         ToUhJb1Mg3bAMz8PzwaRp4WO+IvKISyYXU+jeXmY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/17] perf evsel: Force sample_type for slave events
Date:   Wed, 20 Feb 2019 22:25:45 -0300
Message-Id: <20190221012549.4069-14-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Force sample_type setup for slave events in group leader sessions.

We don't get sample for slave events, we make them when delivering group
leader sample. Set the slave event to follow the master sample_type to
ease up report.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 684c893ca6bc..dfe2958e6287 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,6 +956,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
+
+		/*
+		 * We don't get sample for slave events, we make them
+		 * when delivering group leader sample. Set the slave
+		 * event to follow the master sample_type to ease up
+		 * report.
+		 */
+		attr->sample_type = leader->attr.sample_type;
 	}
 
 	if (opts->no_samples)
-- 
2.19.1

