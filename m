Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB03C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FB62082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FB62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJ3AAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:00:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:31442 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeJ3AAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:00:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 08:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="85069852"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2018 08:11:28 -0700
Received: from [10.251.20.185] (kliang2-mobl1.ccr.corp.intel.com [10.251.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E0D11580332;
        Mon, 29 Oct 2018 08:11:26 -0700 (PDT)
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20181026183805.GD3353@kernel.org>
 <20181026184255.GE3353@kernel.org> <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
 <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
 <20181029130331.GC21857@kernel.org>
 <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
 <20181029143506.GF21857@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9ad642b0-1a15-b3d9-781f-893f782f8867@linux.intel.com>
Date:   Mon, 29 Oct 2018 11:11:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029143506.GF21857@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/2018 10:35 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 29, 2018 at 10:33:06AM -0400, Liang, Kan escreveu:
>> On 10/29/2018 9:03 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Oct 26, 2018 at 04:11:51PM -0400, Liang, Kan escreveu:
>>>> On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
>>>>> Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
>>>> It is mainly for performance reason to switch to overwrite mode. The impact
>>>> was very small when I did my test. But now the effect is easily noticeable
>>>> in other tests. Yes, I agree. We may change it back to non-overwrite mode
>>>> until the issue is addressed.
> 
>>> So, I have these two patches in my perf/core branch, with Fixes tags
>>> that will make them get to the stable kernels, ok?
>   
>> I just realized that the problem in KNL will be back if we switch back to
>> non-overwrite mode.
>> The problem is that users have to wait tens of minutes to see perf top
>> results on the screen in KNL. Before that, there is nothing but a black
>> screen.
>   
>> Sorry I didn't notice it last Friday. Because I thought the ui_warning in
>> perf_top__mmap_read() can give user a hint. So the user can switch to
>> overwrite mode manually.
>> But unfortunately, the ui_warning doesn't work. Because it is called after
>> perf_top__mmap_read(). The processing time of perf_top__mmap_read() could be
>> tens of minutes.
> 
> So we need a way to notice that we're in a machine like that and warn
> the user before the wait takes place, ideas on how to do that?
> 
The processing time for each perf_top__mmap_read_idx() should not that 
long. We may check it after each perf_top__mmap_read_idx(). Also change 
the ui_warning to one-time warning. The patch as below can do that (not 
test).


diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d875..5e532e0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -877,31 +877,40 @@ static void perf_top__mmap_read_idx(struct 
perf_top *top, int idx)
  	perf_mmap__read_done(md);
  }

+static bool check_processing_time = true;
+
  static void perf_top__mmap_read(struct perf_top *top)
  {
  	bool overwrite = top->record_opts.overwrite;
  	struct perf_evlist *evlist = top->evlist;
-	unsigned long long start, end;
+	unsigned long long start, end, tolerance;
  	int i;

-	start = rdclock();
  	if (overwrite)
  		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);

-	for (i = 0; i < top->evlist->nr_mmaps; i++)
+	tolerance = (unsigned long long)top->delay_secs * NSEC_PER_SEC / 
top->evlist->nr_mmaps;
+	start = rdclock();
+	for (i = 0; i < top->evlist->nr_mmaps; i++) {
  		perf_top__mmap_read_idx(top, i);
+		if (check_processing_time) {
+			end = rdclock();
+
+			if ((end - start) > tolerance) {
+				ui__warning("Too slow to read ring buffer.\n"
+					    "Please try increasing the period (-c) or\n"
+					    "decreasing the freq (-F) or\n"
+					    "limiting the number of CPUs (-C)\n");
+				check_processing_time = false;
+			}
+			start = end;
+		}
+	}

  	if (overwrite) {
  		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
  		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
  	}
-	end = rdclock();
-
-	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
-		ui__warning("Too slow to read ring buffer.\n"
-			    "Please try increasing the period (-c) or\n"
-			    "decreasing the freq (-F) or\n"
-			    "limiting the number of CPUs (-C)\n");
  }

  /*
