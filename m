Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F83C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC7218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171008;
	bh=Q/120mT5Lg2KbTYhMN3zTkusZn8IcTwavWjel9Y/uBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D5IAeVMxdzwzme/JAbae5VssQoDLrWR/nwHCLDDrrKPADjr//YvQyxng2T1BErnfJ
	 PIZxWYoxt2meNVdwmBq00/u8SnaslVFyAGPpaZrXX95e5kxjSg0+tLLtvicQzW81PK
	 8FwRjz/q4iZ3XkeOiuQDTN4ubzGYb4ev4c40uM9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeLRWKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeLRWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:05 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4AF7218A6;
        Tue, 18 Dec 2018 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171004;
        bh=Q/120mT5Lg2KbTYhMN3zTkusZn8IcTwavWjel9Y/uBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmgbpFrXgySFfLJs/3i8F0ewYG2Q/3tbw46hL5AAwk6K9/C+q5fzrxbTDJB4hFtDb
         sYy3E5fe7NN2Utgxuan0Mzy8Adkq0RksPnJqJQ8TrJfAagN30uFaHwc6VxoT9U/IIm
         pQa+83CI08Pn3LOj241OGYlywd/+QckKkSSPa9B8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 25/63] perf trace: Switch to using a struct for the aumented_raw_syscalls syscalls map values
Date:   Tue, 18 Dec 2018 19:06:55 -0300
Message-Id: <20181218220733.15839-26-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll start adding more perf-syscall stuff, so lets do this prep step so
that the next ones are just about adding more fields.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vac4sn1ns1vj4y07lzj7y4b8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de81918c7ad4..096380e8c213 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -908,6 +908,10 @@ struct syscall {
 	struct syscall_arg_fmt *arg_fmt;
 };
 
+struct bpf_map_syscall_entry {
+	bool	enabled;
+};
+
 /*
  * We need to have this 'calculated' boolean because in some cases we really
  * don't know what is the duration of a syscall, for instance, when we start
@@ -2583,7 +2587,9 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
-	bool value = !trace->not_ev_qualifier;
+	struct bpf_map_syscall_entry value = {
+		.enabled = !trace->not_ev_qualifier,
+	};
 	int err = 0;
 	size_t i;
 
@@ -2601,10 +2607,13 @@ static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
+	struct bpf_map_syscall_entry value = {
+		.enabled = enabled,
+	};
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		err = bpf_map_update_elem(fd, &key, &enabled, BPF_ANY);
+		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
 			break;
 	}
-- 
2.19.2

