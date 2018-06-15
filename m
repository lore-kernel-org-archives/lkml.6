Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 28538C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14E20660
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA14E20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932442AbeFOHPN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:15:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:17578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754623AbeFOHPM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:15:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 00:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,226,1526367600"; 
   d="scan'208";a="237369902"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2018 00:15:04 -0700
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        me@kylehuey.com, LKML <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <CABPqkBRoecNKQEuJaEw1E+1a5KF-aTucAWK+St8A15FU9dsZsw@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5ee8dba2-3346-615c-84a2-3a65203c06a8@linux.intel.com>
Date:   Fri, 15 Jun 2018 15:15:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBRoecNKQEuJaEw1E+1a5KF-aTucAWK+St8A15FU9dsZsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2018 1:59 PM, Stephane Eranian wrote:
> On Thu, Jun 14, 2018 at 7:10 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>>
>> When doing sampling, for example:
>>
>> perf record -e cycles:u ...
>>
>> On workloads that do a lot of kernel entry/exits we see kernel
>> samples, even though :u is specified. This is due to skid existing.
>>
>> This might be a security issue because it can leak kernel addresses even
>> though kernel sampling support is disabled.
>>
>> One patch "perf/core: Drop kernel samples even though :u is specified"
>> was posted in last year but it was reverted because it introduced a
>> regression issue that broke the rr-project, which used sampling
>> events to receive a signal on overflow. These signals were critical
>> to the correct operation of rr.
>>
>> See '6a8a75f32357 ("Revert "perf/core: Drop kernel samples even
>> though :u is specified"")' for detail.
>>
>> Now the idea is to use sysctl to control the dropping of leaked
>> kernel samples.
>>
>> /sys/devices/cpu/perf_allow_sample_leakage:
>>
>> 0 - default, drop the leaked kernel samples.
>> 1 - don't drop the leaked kernel samples.
>>
>> For rr it can write 1 to /sys/devices/cpu/perf_allow_sample_leakage.
>>
>> For example,
>>
>> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
>> 0
>> root@skl:/tmp# perf record -e cycles:u ./div
>> root@skl:/tmp# perf report --stdio
>>
>> ........  .......  .............  ................
>>
>>      47.01%  div      div            [.] main
>>      20.74%  div      libc-2.23.so   [.] __random_r
>>      15.59%  div      libc-2.23.so   [.] __random
>>       8.68%  div      div            [.] compute_flag
>>       4.48%  div      libc-2.23.so   [.] rand
>>       3.50%  div      div            [.] rand@plt
>>       0.00%  div      ld-2.23.so     [.] do_lookup_x
>>       0.00%  div      ld-2.23.so     [.] memcmp
>>       0.00%  div      ld-2.23.so     [.] _dl_start
>>       0.00%  div      ld-2.23.so     [.] _start
>>
>> There is no kernel symbol reported.
>>
>> root@skl:/tmp# echo 1 > /sys/devices/cpu/perf_allow_sample_leakage
>> root@skl:/tmp# cat /sys/devices/cpu/perf_allow_sample_leakage
>> 1
>> root@skl:/tmp# perf record -e cycles:u ./div
>> root@skl:/tmp# perf report --stdio
>>
>> ........  .......  ................  .............
>>
>>      47.53%  div      div               [.] main
>>      20.62%  div      libc-2.23.so      [.] __random_r
>>      15.32%  div      libc-2.23.so      [.] __random
>>       8.66%  div      div               [.] compute_flag
>>       4.53%  div      libc-2.23.so      [.] rand
>>       3.34%  div      div               [.] rand@plt
>>       0.00%  div      [kernel.vmlinux]  [k] apic_timer_interrupt
>>       0.00%  div      libc-2.23.so      [.] intel_check_word
>>       0.00%  div      ld-2.23.so        [.] brk
>>       0.00%  div      [kernel.vmlinux]  [k] page_fault
>>       0.00%  div      ld-2.23.so        [.] _start
>>
>> We can see the kernel symbols apic_timer_interrupt and page_fault.
>>
> These kernel symbols do not match your description here. How much skid
> do you think you have here?
> You're saying you are at the user level, you get a counter overflow,
> and the interrupted IP lands in the kernel
> because you where there by the time the interrupt is delivered. How
> many instructions does it take to get
> from user land to apic_timer_interrupt() or page_fault()? These
> functions are not right at the kernel entry,
> I believe. So how did you get there, the skid must have been VERY big
> or symbolization has a problem.
> 

I'm testing with the latest perf/core branch (4.17+). Again I test with 
Linux's vmstat (not test with my application).

perf record -e cycles:u vmstat 1
perf script -F ip

      7f84e2b0bc30
      7f84e2b0bc30
      7f84e2b0bc30
      7f84e2b0bc30
  ffffffffb7a01070
      7f84e2b243f0
      7f84e2b11891
      7f84e2b27f5e
      7f84e25a3b26
      7f84e25680f5

cat /proc/kallsyms  | grep page_fault
....
ffffffffb7a01070 T page_fault
ffffffffb7a010a0 T async_page_fault
....

So one sample (ip ffffffffb7a01070) hits on page_fault.

Maybe you can have a try too. :)

Thanks
Jin Yao

>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   kernel/events/core.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 80cca2b..7867541 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7721,6 +7721,28 @@ int perf_event_account_interrupt(struct perf_event *event)
>>          return __perf_event_account_interrupt(event, 1);
>>   }
>>
>> +static int perf_allow_sample_leakage __read_mostly;
>> +
>> +static bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
>> +{
>> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
>> +
>> +       if (allow_leakage)
>> +               return true;
>> +
>> +       /*
>> +        * Due to interrupt latency (AKA "skid"), we may enter the
>> +        * kernel before taking an overflow, even if the PMU is only
>> +        * counting user events.
>> +        * To avoid leaking information to userspace, we must always
>> +        * reject kernel samples when exclude_kernel is set.
>> +        */
>> +       if (event->attr.exclude_kernel && !user_mode(regs))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>   /*
>>    * Generic event overflow handling, sampling.
>>    */
>> @@ -7742,6 +7764,12 @@ static int __perf_event_overflow(struct perf_event *event,
>>          ret = __perf_event_account_interrupt(event, throttle);
>>
>>          /*
>> +        * For security, drop the skid kernel samples if necessary.
>> +        */
>> +       if (!sample_is_allowed(event, regs))
>> +               return ret;
>> +
>> +       /*
>>           * XXX event_limit might not quite work as expected on inherited
>>           * events
>>           */
>> @@ -9500,9 +9528,39 @@ perf_event_mux_interval_ms_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
>>
>> +static ssize_t
>> +perf_allow_sample_leakage_show(struct device *dev,
>> +                              struct device_attribute *attr, char *page)
>> +{
>> +       int allow_leakage = READ_ONCE(perf_allow_sample_leakage);
>> +
>> +       return snprintf(page, PAGE_SIZE-1, "%d\n", allow_leakage);
>> +}
>> +
>> +static ssize_t
>> +perf_allow_sample_leakage_store(struct device *dev,
>> +                               struct device_attribute *attr,
>> +                               const char *buf, size_t count)
>> +{
>> +       int allow_leakage, ret;
>> +
>> +       ret = kstrtoint(buf, 0, &allow_leakage);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (allow_leakage != 0 && allow_leakage != 1)
>> +               return -EINVAL;
>> +
>> +       WRITE_ONCE(perf_allow_sample_leakage, allow_leakage);
>> +
>> +       return count;
>> +}
>> +static DEVICE_ATTR_RW(perf_allow_sample_leakage);
>> +
>>   static struct attribute *pmu_dev_attrs[] = {
>>          &dev_attr_type.attr,
>>          &dev_attr_perf_event_mux_interval_ms.attr,
>> +       &dev_attr_perf_allow_sample_leakage.attr,
>>          NULL,
>>   };
>>   ATTRIBUTE_GROUPS(pmu_dev);
>> --
>> 2.7.4
>>
