Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341FD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341FD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeKZUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:45:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeKZUpl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:45:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0584758E22;
        Mon, 26 Nov 2018 09:52:07 +0000 (UTC)
Received: from krava (ovpn-204-234.brq.redhat.com [10.40.204.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 846D25D776;
        Mon, 26 Nov 2018 09:52:04 +0000 (UTC)
Date:   Mon, 26 Nov 2018 10:52:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 2/2] perf report: Display average IPC and IPC coverage
 per symbol
Message-ID: <20181126095203.GA18780@krava>
References: <1543225254-5858-1-git-send-email-yao.jin@linux.intel.com>
 <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543225254-5858-3-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 26 Nov 2018 09:52:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:40:54PM +0800, Jin Yao wrote:
> Support displaying the average IPC and IPC coverage for symbol
> in perf report TUI browser. We create a new sort-key 'ipc' for
> that.
> 
> For example,
> 
> $ perf record -g -b ...
> $ perf report -s symbol,ipc or
>   perf report -s ipc
> 
> Overhead  Symbol                           IPC   [IPC Coverage]
>   39.60%  [.] __random                     2.30  [ 54.8%]
>   18.02%  [.] main                         0.43  [ 54.3%]
>   14.21%  [.] compute_flag                 2.29  [100.0%]
>   14.16%  [.] rand                         0.36  [100.0%]
>    7.06%  [.] __random_r                   2.57  [ 70.5%]
>    6.85%  [.] rand@plt                     0.00  [  0.0%]
> 
> Note that, stdio mode doesn't support this feature.

the patch below allowed this for stdio
please merge it in, and feel free to change it as you see fit

jirka


---
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9b75e118f609..a6756dc13285 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -85,6 +85,7 @@ struct report {
 	int			socket_filter;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 	struct branch_type_stat	brtype_stat;
+	bool			symbol_ipc;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -129,7 +130,7 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	struct mem_info *mi;
 	struct branch_info *bi;
 
-	if (!ui__has_annotation())
+	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
 	hist__account_cycles(sample->branch_stack, al, sample,
@@ -174,7 +175,7 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	if (!ui__has_annotation())
+	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
 	hist__account_cycles(sample->branch_stack, al, sample,
@@ -954,7 +955,6 @@ int cmd_report(int argc, const char **argv)
 	bool has_br_stack = false;
 	int branch_mode = -1;
 	bool branch_call_mode = false;
-	bool symbol_ipc = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
 					     CALLCHAIN_REPORT_HELP
@@ -1289,7 +1289,7 @@ int cmd_report(int argc, const char **argv)
 		strstr(sort_order, "ipc")) {
 		if (!strstr(sort_order, "symbol"))
 			sort_order = "symbol,ipc";
-		symbol_ipc = true;
+		report.symbol_ipc = true;
 	}
 
 	if (setup_sorting(session->evlist) < 0) {
@@ -1319,7 +1319,7 @@ int cmd_report(int argc, const char **argv)
 	 * so don't allocate extra space that won't be used in the stdio
 	 * implementation.
 	 */
-	if (ui__has_annotation()) {
+	if (ui__has_annotation() || report.symbol_ipc) {
 		ret = symbol__annotation_init();
 		if (ret < 0)
 			goto error;
@@ -1339,9 +1339,6 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.sort_by_name = true;
 		}
 		annotation_config__init();
-	} else if (symbol_ipc) {
-		pr_err("Only TUI mode supports sort-key ipc\n");
-		goto error;
 	}
 
 	if (symbol__init(&session->header.env) < 0)
