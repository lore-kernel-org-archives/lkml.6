Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D709C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1A208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131726;
	bh=UnpaOONcYQf4SY6b9RLx353ie8X33arGWLzi/DPimac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYgyARjbfONk7wPfzbp/m4oFY4jPlX+HR2Uh+NcnJMc3Q23Y/joWw55drsiPL+WmO
	 ORXBhycoiFONxoQanlrKwqzGq9YsRcO/L+FPrkEuGGFinIKgaeK3b7t2uZLV5bEjIQ
	 0hULFD+B7keBzRblmL88j17Doco/Te1PBb4ntxH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB1A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeLFV2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLFV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:42 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8AF120989;
        Thu,  6 Dec 2018 21:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131722;
        bh=UnpaOONcYQf4SY6b9RLx353ie8X33arGWLzi/DPimac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eg+VGCz/DHWHTE3l3++RESNXMyNcMD7u7bdHnpyVAPnl0MhspqoFArYzb6nBnV9Fz
         sUa8aVPGTaThMxWE5D1YDbP54uQBT/whMNEH4ZErOxOVHKVxN0kkmbXW8f8cBJ9o7a
         UxyVU0Py+rZueCfbbBnajh3xzFCwEze0StuvJCK4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/75] perf tools: traceevent API cleanup, remove __tep_data2host*()
Date:   Thu,  6 Dec 2018 18:25:19 -0300
Message-Id: <20181206212602.20474-33-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API should be
straightforward. The __tep_data2host*() functions are going to no longer
be available as a libtraceevent API, tep_read_number() should be used
instead. This patch replaces __tep_data2host*() usage with
tep_read_number() in perf.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.743979275@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-read.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 76f12c705ef9..efe2f58cff4e 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -102,7 +102,7 @@ static unsigned int read4(struct tep_handle *pevent)
 
 	if (do_read(&data, 4) < 0)
 		return 0;
-	return __tep_data2host4(pevent, data);
+	return tep_read_number(pevent, &data, 4);
 }
 
 static unsigned long long read8(struct tep_handle *pevent)
@@ -111,7 +111,7 @@ static unsigned long long read8(struct tep_handle *pevent)
 
 	if (do_read(&data, 8) < 0)
 		return 0;
-	return __tep_data2host8(pevent, data);
+	return tep_read_number(pevent, &data, 8);
 }
 
 static char *read_string(void)
-- 
2.19.2

