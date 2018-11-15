Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACEA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACEA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbeKPAZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbeKPAZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:25:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2F2EC0669AB;
        Thu, 15 Nov 2018 14:17:50 +0000 (UTC)
Received: from krava (unknown [10.40.205.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19419620D6;
        Thu, 15 Nov 2018 14:17:46 +0000 (UTC)
Date:   Thu, 15 Nov 2018 15:17:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com,
        tmricht@linux.vnet.ibm.com, anton@samba.org
Subject: Re: [RFC 2/2] perf stat: Fix shadow stats for clock events
Message-ID: <20181115141745.GJ9600@krava>
References: <20181115095533.16930-1-ravi.bangoria@linux.ibm.com>
 <20181115095533.16930-2-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115095533.16930-2-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 15 Nov 2018 14:17:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 03:25:33PM +0530, Ravi Bangoria wrote:
> Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> function") introduced scale and unit for clock events. Thus,
> perf_stat__update_shadow_stats() now saves scaled values of
> clock events in msecs, instead of original nsecs. But while
> calculating values of shadow stats we still consider clock
> event values in nsecs. This results in a wrong shadow stat
> values. Ex,
> 
>   # ./perf stat -e task-clock,cycles ls
>     <SNIP>
>               2.62 msec task-clock:u    #    0.624 CPUs utilized
>          2,501,536      cycles:u        # 1250768.000 GHz
> 
> Fix this by considering clock events's saved stats in msecs:
> 
>   # ./perf stat -e task-clock,cycles ls
>     <SNIP>
>               2.42 msec task-clock:u    #    0.754 CPUs utilized
>          2,338,747      cycles:u        #    1.169 GHz
> 
> Note:
> The problem with this approach is, we are losing fractional part
> while converting nsecs to msecs. This results in a sightly different
> values of shadow stats.

yea, could we just leave the NSEC instead? like below

jirka


---
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f4bad808bdd9..da8857df238e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -209,11 +209,12 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
+	u64 count_ns = count;
 
 	count *= counter->scale;
 
 	if (perf_evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
