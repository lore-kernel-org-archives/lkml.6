Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FECC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A32082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409A32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeJ0TqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbeJ0TqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42ED2D6EE1;
        Sat, 27 Oct 2018 11:05:46 +0000 (UTC)
Received: from krava (ovpn-204-48.brq.redhat.com [10.40.204.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B94D1001918;
        Sat, 27 Oct 2018 11:05:42 +0000 (UTC)
Date:   Sat, 27 Oct 2018 13:05:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso
 symbols lookup
Message-ID: <20181027110541.GA25072@krava>
References: <20181017225501.32150-1-acme@kernel.org>
 <20181017225501.32150-12-acme@kernel.org>
 <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
 <87a7n070tj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7n070tj.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 27 Oct 2018 11:05:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:19:52PM -0700, Vinicius Costa Gomes wrote:
> Hi,
> 
> Adrian Hunter <adrian.hunter@intel.com> writes:
> 
> > On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> 
> >> David reports that:
> >> 
> >> <quote>
> >> Perf has this hack where it uses the kernel symbol map as a backup when
> >> a symbol can't be found in the user's symbol table(s).
> >
> > I don't think this is a complete fix because it exposes new problems.
> 
> This commit broke function name resolution for 'perf record -g' for me.
> 
> What I mean is, with this commit applied:
> 
> $ ./tools/perf/perf record -g -- sleep 1
> 
> $ ./tools/perf/perf report
> 
> 'perf report' doesn't seem to be able to show the function names of the
> trace.
> 
> If I revert this commit, function names are resolved fine.

that commit just showed up some places where we have the
ip resolve wrong.. would attached patch fix it for you?

jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..72a5b803c797 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1824,7 +1824,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, &al, NULL);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -1909,8 +1909,8 @@ static int add_callchain_ip(struct thread *thread,
 
 	al.filtered = 0;
 	al.sym = NULL;
-	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+	if (!cpumode || *cpumode == PERF_RECORD_MISC_CPUMODE_UNKNOWN) {
+		thread__find_cpumode_addr_location(thread, ip, &al, cpumode);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2151,7 +2151,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	struct branch_stack *branch = sample->branch_stack;
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
-	u8 cpumode = PERF_RECORD_MISC_USER;
+	u8 cpumode = PERF_RECORD_MISC_CPUMODE_UNKNOWN;
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..1cd83ecde501 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -366,7 +366,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al)
+					struct addr_location *al, u8 *cpumode)
 {
 	size_t i;
 	const u8 cpumodes[] = {
@@ -378,8 +378,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
 		thread__find_symbol(thread, cpumodes[i], addr, al);
-		if (al->map)
+		if (al->map) {
+			if (cpumode)
+				*cpumode = cpumodes[i];
 			break;
+		}
 	}
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..9aad9a71c943 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -99,7 +99,7 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al);
+					struct addr_location *al, u8 *cpumode);
 
 static inline void *thread__priv(struct thread *thread)
 {
