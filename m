Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31962C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20802173B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAEDQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:16:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:35167 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfAEDQn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:16:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 19:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="105643403"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.215.18]) ([10.254.215.18])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2019 19:16:41 -0800
Subject: Re: [PATCH] perf stat: Poll for monitored tasks being alive in fork
 mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
 <20190104125441.GF5481@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ec011f77-e08e-4471-4479-0cb0281fa79b@linux.intel.com>
Date:   Sat, 5 Jan 2019 11:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104125441.GF5481@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2019 8:54 PM, Jiri Olsa wrote:
> On Fri, Jan 04, 2019 at 10:28:17AM +0800, Jin Yao wrote:
>> Following test shows the stat keeps running even if no longer
>> task to monitor (mgen exits at ~5s).
>>
>> perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
>>              time             counts unit events
>>       1.000148916      1,308,365,864      cycles
>>       2.000379171      1,297,269,875      cycles
>>       3.000556719      1,297,187,078      cycles
>>       4.000914241        761,261,827      cycles
>>       5.001306091      <not counted>      cycles
>>       6.001676881      <not counted>      cycles
>>       7.002046336      <not counted>      cycles
>>       8.002405651      <not counted>      cycles
>>       9.002766625      <not counted>      cycles
>>      10.001395827      <not counted>      cycles
>>
>> We'd better finish stat immediately if there's no longer task to
>> monitor.
>>
>> After:
>>
>> perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
>>              time             counts unit events
>>       1.000180062      1,236,592,661      cycles
>>       2.000421539      1,223,733,572      cycles
>>       3.000609910      1,297,047,663      cycles
>>       4.000807545      1,297,215,816      cycles
>>       5.001001578      1,297,208,032      cycles
>>       6.001390345        582,343,659      cycles
>> sleep: Terminated
>>
>> Now the stat exits immediately when the monitored tasks ends.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-stat.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 63a3afc..71f3bc8 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -553,6 +553,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>   
>>   		if (interval || timeout) {
>>   			while (!waitpid(child_pid, &status, WNOHANG)) {
>> +				if (!is_target_alive(&target,
>> +					evsel_list->threads) &&
>> +					(child_pid != -1)) {
> 
> do we need that child_pid check? we just returned from waitpid
> so we should be ok.. we just make the race window smaller
> 
> could we just do:
> 
> 				if (!is_target_alive(&target, evsel_list->threads)) {
> 					kill(child_pid, SIGTERM);
> 					break;
> 				}
> 

I think this code should be OK and I have tested yet. I have a question 
about the race condition, we really don't need a lock to protect the 
child_pid?

skip_signal()
{
	/*
	 * render child_pid harmless
	 * won't send SIGTERM to a random
	 * process in case of race condition
	 * and fast PID recycling
	 */
	child_pid = -1;
}

__run_perf_stat()
{
	....
	kill(child_pid, SIGTERM);
}

If child_pid is set by -1 in a small window between checking of 
child_pid and kill(), then kill(-1, SIGTERM) may happen. All processes 
except the kill process itself and init would receive SIGTERM.

Is this case possible?

> also I'm not sure we should do this only under new option,
> as it might break people's scripts.. thoughts?
> 
> jirka
> 

In current behavior, for non fork mode, if we terminate the monitored 
task, the perf stat would return immediately. So I think this patch 
should be OK.

Thanks
Jin Yao

>> +					kill(child_pid, SIGTERM);
>> +					break;
>> +				}
>> +
>>   				nanosleep(&ts, NULL);
>>   				if (timeout)
>>   					break;
>> -- 
>> 2.7.4
>>
