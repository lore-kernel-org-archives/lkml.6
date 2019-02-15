Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC719C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D602192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfBOEf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:35:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:19471 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfBOEf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:35:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 20:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,371,1544515200"; 
   d="scan'208";a="319218099"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2019 20:35:53 -0800
Subject: Re: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
References: <20190213023748.6614-1-aubrey.li@linux.intel.com>
 <20190213023748.6614-2-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
Date:   Fri, 15 Feb 2019 12:35:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/14 19:29, Thomas Gleixner wrote:
> On Wed, 13 Feb 2019, Aubrey Li wrote:
> 
>> AVX-512 components use could cause core turbo frequency drop. So
>> it's useful to expose AVX-512 usage elapsed time as a heuristic hint
>> for the user space job scheduler to cluster the AVX-512 using tasks
>> together.
>>
>> Example:
>> $ cat /proc/pid/status | grep AVX512_elapsed_ms
>> AVX512_elapsed_ms:      1020
>>
>> The number '1020' denotes 1020 millisecond elapsed since last time
>> context switch the off-CPU task using AVX-512 components, thus the
> 
> I know what you are trying to say, but this sentence does not parse. So
> what you want to say is:
> 
>   This means that 1020 milliseconds have elapsed since the AVX512 usage of
>   the task was detected when the task was scheduled out.

Thanks, will refine this.

> 
> Aside of that 1020ms is hardly evidence for real AVX512 usage, so you want
> to come up with a better example than that.

Oh, I wrote a simple benchmark to loop {AVX ops a while and non-AVX ops a while},
So this is expected. Yeah, I should use real AVX512 usage. Below is tensorflow
output to train a neural network model to classify images (HZ = 250 on my side).
Will change to use this example.

$ while [ 1 ]; do cat /proc/83226/status | grep AVX; sleep 1; done
AVX512_elapsed_ms:	4
AVX512_elapsed_ms:	16
AVX512_elapsed_ms:	12
AVX512_elapsed_ms:	12
AVX512_elapsed_ms:	16
AVX512_elapsed_ms:	8
AVX512_elapsed_ms:	8
AVX512_elapsed_ms:	4
AVX512_elapsed_ms:	4
AVX512_elapsed_ms:	12
AVX512_elapsed_ms:	0
AVX512_elapsed_ms:	16
AVX512_elapsed_ms:	4
AVX512_elapsed_ms:	0
AVX512_elapsed_ms:	8
AVX512_elapsed_ms:	8
AVX512_elapsed_ms:	4

> 
> But that makes me think about the usefulness of this hint in general.
> 
> A AVX512 using task which runs alone on a CPU, is going to have either no
> AVX512 usage recorded at all or the time elapsed since the last recording
> is absurdly long.

I did an experiment of this, please correct me if I was wrong.

I isolate CPU103, and run a AVX512 micro benchmark(spin AVX512 ops) on it.

$ cat /proc/cmdline 
root=UUID=e6503b72-57d7-433a-ab09-a4b9a39e9128 ro isolcpus=103

I still saw context switch
aubrey@aubrey-skl:~$ sudo trace-cmd report --cpu 103
cpus=104
        avx_demo-6985  [103]  5055.442432: sched_switch:         avx_demo:6985 [120] R ==> migration/103:527 [0]
   migration/103-527   [103]  5055.442434: sched_switch:         migration/103:527 [0] S ==> avx_demo:6985 [120]
        avx_demo-6985  [103]  5059.442430: sched_switch:         avx_demo:6985 [120] R ==> migration/103:527 [0]
   migration/103-527   [103]  5059.442432: sched_switch:         migration/103:527 [0] S ==> avx_demo:6985 [120]
        avx_demo-6985  [103]  5063.442430: sched_switch:         avx_demo:6985 [120] R ==> migration/103:527 [0]
   migration/103-527   [103]  5063.442431: sched_switch:         migration/103:527 [0] S ==> avx_demo:6985 [120]
        avx_demo-6985  [103]  5067.442430: sched_switch:         avx_demo:6985 [120] R ==> migration/103:527 [0]
   migration/103-527   [103]  5067.442431: sched_switch:         migration/103:527 [0] S ==> avx_demo:6985 [120]

It looks like some kernel threads still participant context switch on the isolated
CPU, like above one, each CPU has one migration daemon to do migration jobs.

Under this scenario, the elapsed time becomes longer than normal indeed, see below:

$ while [ 1 ]; do cat /proc/6985/status | grep AVX; sleep 1; done
AVX512_elapsed_ms:	3432
AVX512_elapsed_ms:	440
AVX512_elapsed_ms:	1444
AVX512_elapsed_ms:	2448
AVX512_elapsed_ms:	3456
AVX512_elapsed_ms:	460
AVX512_elapsed_ms:	1464
AVX512_elapsed_ms:	2468

But AFAIK, google's Heracles do a 15s polling, so this worst case is still acceptable.?

>IOW, this needs crystal ball magic to decode because
> there is no correlation between that elapsed time and the time when the
> last context switch happened simply because that time is not available in
> /proc/$PID/status. Sure you can oracle it out from /proc/$PID/stat with
> even more crystal ball magic, but there is no explanation at all.
> 
> There may be use case scenarios where this crystal ball prediction is
> actually useful, but the inaccuracy of that information and the possible
> pitfalls for any user space application which uses it need to be documented
> in detail. Without that, this is going to cause more trouble and confusion
> than benefit.
> 
Not sure if the above experiment addressed your concern, please correct me if
I totally misunderstood.

Thanks,
-Aubrey
