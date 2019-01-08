Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E56AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7A120660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977668;
	bh=HeJTL5QyjD7wyQL28gE4CZvCivyhUS7nSSY5nfjBD9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsDF7RyZ4ZVeVa8+PcqDtYtA9kbbqyFRlJhC8wjx4qhEMIOcO809+NGWC3WqAqwRp
	 qM3SBIWWmw9JAo8JouYv5K1w7ZZFvyCYS7tBS5TEgNz5IfsFXQ5L4tuSpQWfWl0qf0
	 5SY9JcP9Qr9nREDWLMVZdoMT2F42uLaoN+grFHUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfAHUBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732979AbfAHT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:26 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE1C20883;
        Tue,  8 Jan 2019 19:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977566;
        bh=HeJTL5QyjD7wyQL28gE4CZvCivyhUS7nSSY5nfjBD9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yk2FRIw+u+6JNAB3Zv7yUMphIN06/iYL/O5FTkV+D7VoyHfLsqesIT5lFxFfNTJU9
         jXlozZ4lX6hpifV6rPsQPkDf1YxcIbRoOx6PqejQtPKAZq7q2XA2FqP+NubPpFHvJA
         mVFMve4T8fNv4VW7OAHTgceQjRWBJr3Ok/E36wGs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/16] perf trace: Fix alignment for [continued] lines
Date:   Tue,  8 Jan 2019 16:58:56 -0300
Message-Id: <20190108195910.17726-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were not taking into account the "... [continued]" printed
characters, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qt20y0acmf8k0bzisce8kw95@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b8bf5d025563..ed4583128b9c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2032,9 +2032,10 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	if (ttrace->entry_pending) {
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
 	} else {
-		fprintf(trace->output, " ... [");
+		printed += fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
-		fprintf(trace->output, "]: %s()", sc->name);
+		printed += 9;
+		printed += fprintf(trace->output, "]: %s()", sc->name);
 	}
 
 	printed++; /* the closing ')' */
-- 
2.20.1

