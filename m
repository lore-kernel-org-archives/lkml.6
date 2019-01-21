Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1097C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84392084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfAUIC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:02:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:39583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbfAUIC4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:02:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 17:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,501,1539673200"; 
   d="scan'208";a="120012112"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.159.76]) ([10.239.159.76])
  by orsmga003.jf.intel.com with ESMTP; 20 Jan 2019 17:40:46 -0800
Subject: Re: [PATCH v2] Poll for monitored tasks being alive in fork mode
To:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1546822850-30649-1-git-send-email-yao.jin@linux.intel.com>
 <20190107090522.GA3383@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <460f52d2-2061-8fe3-9c9a-1709d3e49343@linux.intel.com>
Date:   Mon, 21 Jan 2019 09:40:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107090522.GA3383@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Is this patch acceptable?

Thanks
Jin Yao

On 1/7/2019 5:05 PM, Jiri Olsa wrote:
> On Mon, Jan 07, 2019 at 09:00:50AM +0800, Jin Yao wrote:
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
>> v2:
>> ---
>> There is a potential race condition window, that is the
>> child_pid set with -1 and kill(-1, SIGTERM) may happen.
>> Jiri provides a simple method which stores the child_pid to
>> a local variable and check the local variable before kill().
>> At least, we can avoid the kill(-1, SIGTERM) case.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
>> ---
>>   tools/perf/builtin-stat.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 63a3afc..bd5fb8e 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -553,6 +553,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>>   
>>   		if (interval || timeout) {
>>   			while (!waitpid(child_pid, &status, WNOHANG)) {
>> +				if (!is_target_alive(&target,
>> +					evsel_list->threads)) {
>> +					int pid = child_pid;
>> +
>> +					if (pid != -1)
>> +						kill(pid, SIGTERM);
>> +					break;
>> +				}
>> +
>>   				nanosleep(&ts, NULL);
>>   				if (timeout)
>>   					break;
>> -- 
>> 2.7.4
>>
