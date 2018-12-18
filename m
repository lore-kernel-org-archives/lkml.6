Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F55C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75BF218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171185;
	bh=wGOXjwcve918sOORTl07O95ck0A23P1wXER6vJKSlXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvLUCsgd7wmJbRGFlvxaDthB1PG550hb6NFgr1f+W5vUqFq/mosjlRfLYOgSYZCvb
	 KfVnB+WihnP2Sb0PW6lNlF9R/OCMaalAfh8SS9gGnL39S7RHF8xJRNvKwkSRpPTl1J
	 qr4WWHOfaYu93iZNs1I1Soz5jgg8vXkW1miGmE20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeLRWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeLRWND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:03 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9728E218A4;
        Tue, 18 Dec 2018 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171182;
        bh=wGOXjwcve918sOORTl07O95ck0A23P1wXER6vJKSlXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hX9s7t4jogU+6vyTwReIDyRgWNBFBD9einJRG7ycdxNf/JF1+/I01tvB3G19CeIcH
         6DX6uTeOdqCdU8qtVzCtca8HKUCoenR6mgVQDjl8Ym1hYIuF8vflul8uW2zojc7eU8
         PL7f2hQKKj+GLMm3f1yysgE+eqcCGIgLD4d2iuQQ=
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
Subject: [PATCH 36/63] perf trace: Allow configuring if zeroed syscall args should be printed
Date:   Tue, 18 Dec 2018 19:07:06 -0300
Message-Id: <20181218220733.15839-37-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The default so far, since we show argument names followed by its values,
was to make the output more compact by suppressing most zeroed args.

Make this configurable so that users can choose what best suit their
needs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q0gxws02ygodh94o0hzim5xd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 2 ++
 tools/perf/builtin-trace.c               | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 423cb41f6e3f..b55bd16c77fe 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -528,6 +528,8 @@ trace.*::
 		The initial use case is to add augmented_raw_syscalls.o to
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
+	trace.show_zeros::
+		Do not suppress syscall arguments that are equal to zero.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d754a74aef46..4d97bdac205c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_zeros;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1598,6 +1599,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 * strarray for it.
  			 */
 			if (val == 0 &&
+			    !trace->show_zeros &&
 			    !(sc->arg_fmt &&
 			      (sc->arg_fmt[arg.idx].show_zero ||
 			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
@@ -3526,14 +3528,16 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
 
 static int trace__config(const char *var, const char *value, void *arg)
 {
+	struct trace *trace = arg;
 	int err = 0;
 
 	if (!strcmp(var, "trace.add_events")) {
-		struct trace *trace = arg;
 		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_zeros")) {
+		trace->show_zeros = perf_config_bool(var, value);
 	}
 
 	return err;
-- 
2.19.2

