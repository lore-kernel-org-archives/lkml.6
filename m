Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeFDPWw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:22:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:20714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753697AbeFDPWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:22:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="61145824"
Subject: Re: [PATCH v3]: perf record: enable arbitrary event names thru name=
 modifier
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
 <20180604075600.GA10484@krava> <20180604135849.GE3397@kernel.org>
 <3269ec8e-88b0-8254-6419-da1896c083df@linux.intel.com>
 <20180604142340.GJ3397@kernel.org>
 <ed38dfcc-be73-e1d7-4eb5-862468955766@linux.intel.com>
 <20180604145844.GL3397@kernel.org>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <80a37269-e54d-0992-712a-ee72555a04d4@linux.intel.com>
Date: Mon, 4 Jun 2018 18:22:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604145844.GL3397@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.2018 17:58, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 04, 2018 at 05:51:03PM +0300, Alexey Budankov escreveu:
>> Hi,
>> On 04.06.2018 17:23, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Jun 04, 2018 at 05:19:11PM +0300, Alexey Budankov escreveu:
>>>> Hi,
>>>>
>>>> On 04.06.2018 16:58, Arnaldo Carvalho de Melo wrote:
>>>>> Em Mon, Jun 04, 2018 at 09:56:02AM +0200, Jiri Olsa escreveu:
>>>>>> On Mon, Jun 04, 2018 at 09:50:56AM +0300, Alexey Budankov wrote:
>>>>>>> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
>>>>>>> trace using name= modifier e.g. like this:
>>>>>
>>>>>>> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
>>>>>>> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
>>>>>
>>>>>>> Below is how it looks like in the report output. Please note explicit escaped 
>>>>>>> quoting at cmdline string in the header so that thestring can be directly reused
>>>>>>> for another collection in shell:
>>>>>
>>>>> Applied, but there are other places where we show event names, such as:
>>>>>
>>>>> [root@jouet ~]# perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk
>>>>> ^C[ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 1.599 MB perf.data (704 samples) ]
>>>>>
>>>>> [root@jouet ~]# perf evlist
>>>>> OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM
>>>>> [root@jouet ~]# perf evlist -v
>>>>> OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM: type: 4, size: 112, config: 0x100003c, { sample_period, sample_freq }: 3500000, sample_type: IP|TID|TIME|CPU, disabled: 1, inherit: 1, pinned: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1
>>>>> [root@jouet ~]# 
>>>>>
>>>>> That I used to check if the period, etc were correctly set, etc. Perhaps
>>>>> we should add that \'\' there as well?
>>>>
>>>> Like this?
>>>>
>>>> name: 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM', type: 4, size: 112, config: 0x100003c, { sample_period, sample_freq }: 3500000, sample_type: IP|TID|TIME|CPU, disabled: 1, inherit: 1, pinned: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1
>>>
>>> Nope, I mean with the same intent you had when showing escaped single
>>> quotes in the 'perf report' header, that users would copy'n'paste and
>>> get something that works on the command line?
>>
>> Well ok, if there are other cases aside perf report that tool shows full 
>> command line ready for reusing then it definitely makes sense to print 
> 
> Ok, lets leave it like you did, i.e. just when command lines appear and
> people are likely to copy'n'paste them to repeat it.
> 
>> event names quoted there. If such cases were pointed out then they also 
>> could be addressed along with the unit/regression testing mentioned above.
> 
> So lests stick to just the unit/regression testing, can you take a look
> at that?

Sure. Is it enough to run perf record with some quoted event name to make 
sure it runs successfully?

Thanks,
Alexey

> 
> - Arnaldo
> 
