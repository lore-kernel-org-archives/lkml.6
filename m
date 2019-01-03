Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD092070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519673;
	bh=URHuzNVaBvEqMyifd9uF7GA4XGC1xdM2CTvDR3Xjfjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUerdjuV/wzyGHPVqjy/xp/2i5Le2bMBkhIzd2MurwBXfXfCYQkmc9PF/zOSDxxdM
	 TtUw88/Q2WEzt2GCafrRqCizNbp1lAD0aVtgA7vBIf9pcZYpRiNopYCMVB1APcCKrs
	 HFhq6vxyCiGi68wIrSIuJ5rPJT31yIV4sAqSBQCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfACMrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbfACMrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:45 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 792EC2070D;
        Thu,  3 Jan 2019 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519664;
        bh=URHuzNVaBvEqMyifd9uF7GA4XGC1xdM2CTvDR3Xjfjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHc804OiosI8B+avqelDJWW1DfHCGplx8mRfmS1fWFZsb5gsobTntamsQz4Ute/mf
         DYoKbhwLji5q6yFSXWX/gW4CMnGwYJaQgYX/ebiSpC6CUq7dZw0igiow4q/yBpG5XS
         3Yu32dNroFCTwXS887NmmrT3HLuxOPKv7/iq4x+E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/29] perf session: Add comment for perf_session__register_idle_thread()
Date:   Thu,  3 Jan 2019 09:46:09 -0300
Message-Id: <20190103124609.29672-30-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a comment to perf_session__register_idle_thread() to bring attention to
a pitfall with the idle task thread structure. The pitfall is that there
should really be a 'struct thread' for the idle task of each cpu, but there
is only one that can have pid == tid == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 78a067777144..5456c84c7dd1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1527,6 +1527,13 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
 	return machine__findnew_thread(&session->machines.host, -1, pid);
 }
 
+/*
+ * Threads are identified by pid and tid, and the idle task has pid == tid == 0.
+ * So here a single thread is created for that, but actually there is a separate
+ * idle task per cpu, so there should be one 'struct thread' per cpu, but there
+ * is only 1. That causes problems for some tools, requiring workarounds. For
+ * example get_idle_thread() in builtin-sched.c, or thread_stack__per_cpu().
+ */
 int perf_session__register_idle_thread(struct perf_session *session)
 {
 	struct thread *thread;
-- 
2.19.2

