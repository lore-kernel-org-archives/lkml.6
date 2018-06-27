Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE20CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838182657A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838182657A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934152AbeF0JrT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:47:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:27374 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932135AbeF0JrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:47:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 02:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="62571561"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2018 02:47:15 -0700
Received: from [10.125.252.135] (abudanko-mobl.ccr.corp.intel.com [10.125.252.135])
        by linux.intel.com (Postfix) with ESMTP id AE44B58011E;
        Wed, 27 Jun 2018 02:47:12 -0700 (PDT)
Subject: Re: [RFC 3/4] perf: Allow per PMU access control
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <20180626153642.5587-4-tvrtko.ursulin@linux.intel.com>
 <e3beeb7e-fc9a-be86-0bea-92e8dd0916f2@linux.intel.com>
 <59478e35-4ac9-7be5-172a-c8301d9e11fd@ursulin.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <2d389cf9-e284-0557-159a-e70a758d357b@linux.intel.com>
Date:   Wed, 27 Jun 2018 12:47:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <59478e35-4ac9-7be5-172a-c8301d9e11fd@ursulin.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.06.2018 12:15, Tvrtko Ursulin wrote:
> 
> On 26/06/18 18:25, Alexey Budankov wrote:
>> Hi,
>>
>> On 26.06.2018 18:36, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>
>>> For situations where sysadmins might want to allow different level of
>>> access control for different PMUs, we start creating per-PMU
>>> perf_event_paranoid controls in sysfs.
>>>
>>> These work in equivalent fashion as the existing perf_event_paranoid
>>> sysctl, which now becomes the parent control for each PMU.
>>>
>>> On PMU registration the global/parent value will be inherited by each PMU,
>>> as it will be propagated to all registered PMUs when the sysctl is
>>> updated.
>>>
>>> At any later point individual PMU access controls, located in
>>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>>> fine grained access control.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: x86@kernel.org
>>> ---
>>>   include/linux/perf_event.h | 12 ++++++--
>>>   kernel/events/core.c       | 59 ++++++++++++++++++++++++++++++++++++++
>>>   kernel/sysctl.c            |  4 ++-
>>>   3 files changed, 71 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>> index d7938d88c028..22e91cc2d9e1 100644
>>> --- a/include/linux/perf_event.h
>>> +++ b/include/linux/perf_event.h
>>> @@ -271,6 +271,9 @@ struct pmu {
>>>       /* number of address filters this PMU can do */
>>>       unsigned int            nr_addr_filters;
>>>   +    /* per PMU access control */
>>> +    int                perf_event_paranoid;
>>
>> It looks like it needs to be declared as atomic and atomic_read/atomic_write
>> operations need to be explicitly used below in the patch as far this
>> variable may be manipulated by different threads at the same time
>> without explicit locking.
> 
> It is just a write of an integer from either sysfs access or sysctl. As such I don't think going atomic would change anything. There is no RMW or increment or anything on it.
> 
> Unless there are architectures where int stores are not atomic? But then the existing sysctl would have the same issue. So I suspect we can indeed rely on int store being atomic.

Yep, aligned word read/write is atomic on Intel and there is no runtime issue 
currently, but the implementation itself is multithread and implicitly relies 
on that atomicity so my suggestion is just explicitly code that assumption :).
Also, as you mentioned, that makes the arch independent part of code more portable.

> 
> Regards,
> 
> Tvrtko
> 
>>
>>> +
>>>       /*
>>>        * Fully disable/enable this PMU, can be used to protect from the PMI
>>>        * as well as for lazy/batch writing of the MSRs.
>>> @@ -1168,6 +1171,9 @@ extern int sysctl_perf_cpu_time_max_percent;
>>>     extern void perf_sample_event_took(u64 sample_len_ns);
>>>   +extern int perf_proc_paranoid_handler(struct ctl_table *table, int write,
>>> +        void __user *buffer, size_t *lenp,
>>> +        loff_t *ppos);
>>>   extern int perf_proc_update_handler(struct ctl_table *table, int write,
>>>           void __user *buffer, size_t *lenp,
>>>           loff_t *ppos);
>>> @@ -1180,17 +1186,17 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
>>>     static inline bool perf_paranoid_tracepoint_raw(const struct pmu *pmu)
>>>   {
>>> -    return sysctl_perf_event_paranoid > -1;
>>> +    return pmu->perf_event_paranoid > -1;
>>>   }
>>>     static inline bool perf_paranoid_cpu(const struct pmu *pmu)
>>>   {
>>> -    return sysctl_perf_event_paranoid > 0;
>>> +    return pmu->perf_event_paranoid > 0;
>>>   }
>>>     static inline bool perf_paranoid_kernel(const struct pmu *pmu)
>>>   {
>>> -    return sysctl_perf_event_paranoid > 1;
>>> +    return pmu->perf_event_paranoid > 1;
>>>   }
>>>     extern void perf_event_init(void);
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 370c89e81722..da36317dc8dc 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -432,6 +432,24 @@ static void update_perf_cpu_limits(void)
>>>     static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
>>>   +int perf_proc_paranoid_handler(struct ctl_table *table, int write,
>>> +        void __user *buffer, size_t *lenp,
>>> +        loff_t *ppos)
>>> +{
>>> +    int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>> +    struct pmu *pmu;
>>> +
>>> +    if (ret || !write)
>>> +        return ret;
>>> +
>>> +    mutex_lock(&pmus_lock);
>>> +    list_for_each_entry(pmu, &pmus, entry)
>>> +        pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
>>> +    mutex_unlock(&pmus_lock);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int perf_proc_update_handler(struct ctl_table *table, int write,
>>>           void __user *buffer, size_t *lenp,
>>>           loff_t *ppos)
>>> @@ -9425,6 +9443,41 @@ static void free_pmu_context(struct pmu *pmu)
>>>       mutex_unlock(&pmus_lock);
>>>   }
>>>   +/*
>>> + * Fine-grained access control:
>>> + */
>>> +static ssize_t
>>> +perf_event_paranoid_show(struct device *dev,
>>> +             struct device_attribute *attr,
>>> +             char *page)
>>> +{
>>> +    struct pmu *pmu = dev_get_drvdata(dev);
>>> +
>>> +    return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->perf_event_paranoid);
>>> +}
>>> +
>>> +static ssize_t
>>> +perf_event_paranoid_store(struct device *dev,
>>> +              struct device_attribute *attr,
>>> +              const char *buf, size_t count)
>>> +{
>>> +    struct pmu *pmu = dev_get_drvdata(dev);
>>> +    int ret, val;
>>> +
>>> +    ret = kstrtoint(buf, 0, &val);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (val < -1 || val > 2)
>>> +        return -EINVAL;
>>> +
>>> +    pmu->perf_event_paranoid = val;
>>> +
>>> +    return count;
>>> +}
>>> +
>>> +static DEVICE_ATTR_RW(perf_event_paranoid);
>>> +
>>>   /*
>>>    * Let userspace know that this PMU supports address range filtering:
>>>    */
>>> @@ -9539,6 +9592,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
>>>       if (ret)
>>>           goto free_dev;
>>>   +    /* Add fine-grained access control attribute. */
>>> +    ret = device_create_file(pmu->dev, &dev_attr_perf_event_paranoid);
>>> +    if (ret)
>>> +        goto del_dev;
>>> +
>>>       /* For PMUs with address filters, throw in an extra attribute: */
>>>       if (pmu->nr_addr_filters)
>>>           ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
>>> @@ -9570,6 +9628,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>>       if (!pmu->pmu_disable_count)
>>>           goto unlock;
>>>   +    pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
>>>       pmu->type = -1;
>>>       if (!name)
>>>           goto skip_type;
>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>> index 2d9837c0aff4..7f6fccb64a30 100644
>>> --- a/kernel/sysctl.c
>>> +++ b/kernel/sysctl.c
>>> @@ -1142,7 +1142,9 @@ static struct ctl_table kern_table[] = {
>>>           .data        = &sysctl_perf_event_paranoid,
>>>           .maxlen        = sizeof(sysctl_perf_event_paranoid),
>>>           .mode        = 0644,
>>> -        .proc_handler    = proc_dointvec,
>>> +        .proc_handler   = perf_proc_paranoid_handler,
>>> +        .extra1         = &neg_one,
>>> +        .extra2         = &two,
>>>       },
>>>       {
>>>           .procname    = "perf_event_mlock_kb",
>>>
>>
> 
